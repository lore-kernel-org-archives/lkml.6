Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68185C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271072245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+Gv0rJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271072245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbeKLXCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:02:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34627 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbeKLXCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:02:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id f1-v6so8823921wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 05:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L+taUgU27DvtZOpOKqbcokXNGT222ER3ubJyB4wwyVk=;
        b=F+Gv0rJO0T2X+B+xnHCthFiVK17KIe8r76Wyw317hBy53vWSpwOAw7mU09kxPlXySR
         V0c5NnyI6eWRbaqJsqRsgYFcs45Xw2EZ59PNQTzmuUF7Z3rhYN5u7b2YdVgLrPFThlLa
         oQ0B2+HdBLswIio2i2MlitVU4rbVHU7crw5tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L+taUgU27DvtZOpOKqbcokXNGT222ER3ubJyB4wwyVk=;
        b=Chg/fZ2Zjarxn5WxqJYq7jqFRt744lKZMHnJDRk0Cpv/U7KDvBPHO+P5ex5hj7RxHi
         /X34mbAvMCDSuh3X0sbbt4y6+GoLcjkFtkZihhjbJ4ldubPjqV6U3OTSLk4H2ADZ1Nev
         qnr51N7Hy/HU67HTyTDD0sTbkmlb27nfABLm1yg9bCbfeQB5BTGGX2uV8r8OET+WtS7Y
         hyM/I7+qyHxBmip5L4xoX7UXcpIIOjeUQYSCMhgiBcycdWSqfpXNP2h5a596KXX8VQqq
         cwArSIMDChYZepJ7R95pCUQd7KgGgjwFmtEbfG9LDANxoVmmak/nOI+T4QpT01nKfNOc
         kNHQ==
X-Gm-Message-State: AGRZ1gISUnrZfbQFGP9W1K4ElaQN03TnVX+HjusKB+1jkDvAub9z5NGO
        naPFDsCW3oMLXleNpyeJnD9mmyLJzw8=
X-Google-Smtp-Source: AJdET5fEcM2AXkXs4DS3uGe1dMxBETNVr7xkze19Ovp50ez8u7QW38CMnWrvHZ2uHYyBE1bW0nfD8w==
X-Received: by 2002:a1c:1792:: with SMTP id 140-v6mr7541569wmx.117.1542028144958;
        Mon, 12 Nov 2018 05:09:04 -0800 (PST)
Received: from [192.168.0.12] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id x142-v6sm29081627wmd.20.2018.11.12.05.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:09:04 -0800 (PST)
Subject: Re: [PATCH] nvmem: add type attribute
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-kernel@vger.kernel.org
References: <20181107105133.3789-1-alexandre.belloni@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4a1d832d-6718-e8a5-4fe2-f2f3e4c48704@linaro.org>
Date:   Mon, 12 Nov 2018 13:09:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181107105133.3789-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/18 10:51, Alexandre Belloni wrote:
> Add a type attribute so userspace is able to know how the data is stored as
> this can help taking the correct decision when selecting which device to
> use. This will also help program display the proper warnings when burning
> fuses for example.
> 
> Signed-off-by: Alexandre Belloni<alexandre.belloni@bootlin.com>
> ---
>   drivers/nvmem/core.c           | 20 ++++++++++++++++++++
>   include/linux/nvmem-provider.h | 16 ++++++++++++++++

Applied to nvmem for-next branch!

thanks,
srini
