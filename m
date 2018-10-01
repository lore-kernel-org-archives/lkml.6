Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45627C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4C1208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1/4qrix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4C1208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeJARft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:35:49 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33830 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeJARft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:35:49 -0400
Received: by mail-wr1-f43.google.com with SMTP id z4-v6so12018553wrb.1;
        Mon, 01 Oct 2018 03:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DhroON450Y9M6snKQmG8LksL4MmKsKuRBb2uogCUSOw=;
        b=N1/4qrix9wP1gtrYbdgG0uvu13dnxIUgSb3RHntBWN54Id6hgiM8MHwueTyTi+XLqU
         aAJi9I/xRoTgimzIvfYrSQURPQYv0gEv+3DEnE3LNkir9R7nlyhzQFj0ohtRueLwM0M8
         ebmNo509Zo7EBfsL3YPHIBXk4A6XaEtmVu8Pm3dffXyl/14R0v+mAG09IpPCr3QCY9tQ
         K4773bwrvLXGxRU5KmjeQX6MiOgiEaBRrmMgfGIIFYpXuN2qOy7rh7ZKp3Z0PHzylxFT
         da6hjMZJ9cFOTVatxJnvWJtugmWdP7ip7aqDNOY9VL8vgb9PRkjNNgGUY1t96DjycyrS
         cORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DhroON450Y9M6snKQmG8LksL4MmKsKuRBb2uogCUSOw=;
        b=f5OF/veEEKEyB6BUeVvhwqK/rMIxSLTlsU6wHjRxBbgTUGH7i1lCpUmtEMA0ZEwjKw
         OjZlsqK2vKHDXytjw90y4xOzxAd9FjnwnxIR4IVrxciklRSTLjwMTN8FiXDpZ3OGu0KE
         TQ3+2aJlcqtHvk54SffOvNpyYgE2Bj3n0uWbpGYjjvWq2k1EZS3slqYFRlNvQBx7n5KL
         +3F2i88cdYqqKPQqD01KsWrFajkFUE907QLLmTZoIz9FjRfDpNYqNq4/xaeek2WSIF0d
         +37KKcM41Zycv1nmluVLLi0gCykBlwDBqRQZOdLlYVM1HDFhij9V/gBkFiHxrKmCuNlN
         N5dw==
X-Gm-Message-State: ABuFfojfiCg1Cya8O6Hb/hf2We8XHnwotZsIKKdWWCvq/yJgZeMcxBqA
        4NWk3AIEvgFb05q5TP0zBECrn9Q4
X-Google-Smtp-Source: ACcGV603HAZZRZ8sC1S01+TdiNfCupVUx8u045Y0sj8rH0ad/j9mAW1jBPaOsYG3RE0LX66n08xkqw==
X-Received: by 2002:adf:eec4:: with SMTP id a4-v6mr7093740wrp.242.1538391513680;
        Mon, 01 Oct 2018 03:58:33 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-30-92.net.upcbroadband.cz. [86.49.30.92])
        by smtp.gmail.com with ESMTPSA id c19-v6sm12467447wre.86.2018.10.01.03.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:58:32 -0700 (PDT)
Subject: Re: Bad MAINTAINERS pattern in section 'RENESAS R-CAR GYROADC DRIVER'
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     linux-iio@vger.kernel.org
References: <20180928220152.31151-1-joe@perches.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <6b5b6ff4-1575-706e-defe-03fe4223c155@gmail.com>
Date:   Mon, 1 Oct 2018 12:58:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180928220152.31151-1-joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/29/2018 12:01 AM, Joe Perches wrote:
> Please fix this defect appropriately.
> 
> linux-next MAINTAINERS section:
> 
> 	12496	RENESAS R-CAR GYROADC DRIVER
> 	12497	M:	Marek Vasut <marek.vasut@gmail.com>
> 	12498	L:	linux-iio@vger.kernel.org
> 	12499	S:	Supported
> -->	12500	F:	drivers/iio/adc/rcar_gyro_adc.c
> 
> Commit that introduced this:
> 
> commit 059c53b3232960cfd38cc46de0a7bedd642021f5
>  Author: Marek Vasut <marek.vasut+renesas@gmail.com>
>  Date:   Sat Jan 28 00:08:37 2017 +0100
>  
>      iio: adc: Add Renesas GyroADC driver
>      
>      Add IIO driver for the Renesas RCar GyroADC block. This block is a
>      simple 4/8-channel ADC which samples 12/15/24 bits of data every
>      cycle from all channels.
>      
>      Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>      Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>      Cc: Simon Horman <horms+renesas@verge.net.au>
>      Cc: Jonathan Cameron <jic23@kernel.org>
>      Cc: linux-renesas-soc@vger.kernel.org
>      Cc: Wolfram Sang <wsa@the-dreams.de>
>      Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>  
>   MAINTAINERS                    |   6 +
>   drivers/iio/adc/Kconfig        |  13 +
>   drivers/iio/adc/Makefile       |   1 +
>   drivers/iio/adc/rcar-gyroadc.c | 631 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 651 insertions(+)
> 
> No commit with drivers/iio/adc/rcar_gyro_adc.c found
> 
Fixed, thanks for the heads up.

-- 
Best regards,
Marek Vasut
