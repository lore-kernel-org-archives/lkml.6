Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749BAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFA920850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqcb0ivL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFA920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeLEM5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:57:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33945 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeLEM5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:57:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so19606576wrw.1;
        Wed, 05 Dec 2018 04:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8UdnAtR9/yN+nJuk+GNTk+gAMGkrxfRiYdrHzN1jSK0=;
        b=Gqcb0ivLu5iAdcHJeK0b2eJn21/zO+GpQGUIGrHv652QMqsQcc+NO+5P6TvReLF8QN
         R73YTopLYrCpvjJn6fQiWWV/Qm3MnYb0iqUGESk1ZlS/pkothd+/6nW58k5eNXeycxpz
         Tu+Y7A9lY82zTOKEfqAs+N04eSmGao1HxaDjxqKgsnxZ8t1vd4C/oW3tSnSAQXkzbhVd
         yxZbz4l5EG9T9lyrAtG5293juc1nRNGRhUX24ZkCVBOFQd53IQTDvqnuNK1P3xq8BJaK
         4IoStV3htSqXryaQQSzUf6hIJB7db0oR/8avfCBwlwyls9xAlqFJDPnHzMQwKYS8c92o
         omOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8UdnAtR9/yN+nJuk+GNTk+gAMGkrxfRiYdrHzN1jSK0=;
        b=Cn1Xkcr7MJNP3O5toVBSeOlm0sDK0cq5krTgwgNqhhLfeJTrl4vJi6rd4/F6th35/S
         lZOve9PMoCGEVms9kjTGgPUo6Z+IVlpzhq0tnonRCdMC0fqAidMlI3iMSdMOXF+k8b+G
         oa6e0srdNjPAElxxtoKzXsFxfFEyS30y7IFgzhQwejmBNDtAUzuURzemE4syzXNmQqsf
         lPoiKDkYfcLrSTuUq/IC+GdvaLyS8YdgI+TqXFzWA/em0bhd3rWNE/rGxOnTEUQRlQuE
         1fMBOn38LGD8OWZh+MPyAULmZoUS12J4DT2LSqhOPew+Ce5Br1/xK+jFu9xi9rjjvkNV
         JuAQ==
X-Gm-Message-State: AA+aEWZsaRlARpL8Vyxn732EQFxgc8YrvP+HSfZA8EcNBmbwAIFa7us6
        6yzJpKoLpi90inDEiceyXlJrTdL9
X-Google-Smtp-Source: AFSGD/W0MwH5Xo0gjbROWdKBQGBCvFCd0g/xRWIdt4Y31VWMXnmDc35RfFHfQL2fFGeQmF04WPdTtA==
X-Received: by 2002:adf:f848:: with SMTP id d8mr4837771wrq.178.1544014668402;
        Wed, 05 Dec 2018 04:57:48 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id s3sm12460200wmj.23.2018.12.05.04.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 04:57:47 -0800 (PST)
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>, masonccyang@mxic.com.tw
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com>
 <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
 <CAMuHMdXS_039E6F3=+UgfE_KgJcwmVvA-zPraOiQPUXMEwck2A@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <4b06ed22-8711-6700-056b-c66799d0e616@gmail.com>
Date:   Wed, 5 Dec 2018 13:35:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXS_039E6F3=+UgfE_KgJcwmVvA-zPraOiQPUXMEwck2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2018 10:11 AM, Geert Uytterhoeven wrote:
> Hi Mason,
> 
> On Wed, Dec 5, 2018 at 8:44 AM <masonccyang@mxic.com.tw> wrote:
>>> "Marek Vasut" <marek.vasut@gmail.com>
>>> 2018/12/05 上午 10:04
>>> On 12/03/2018 10:18 AM, Mason Yang wrote:
>>>> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
>>>>
>>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> 
>>>> +static u8 rpc_bits_xfer(u32 nbytes)
>>>> +{
>>>> +   if (nbytes > 4)
>>>> +      nbytes = 4;
>>>
>>> Use clamp() ?
>>>
>>
>> nbytes = clamp(nbytes, 1, 4);
>>
>> got many warnings, something like,
>> ./include/linux/kernel.h:845:29: warning: comparison of distinct pointer types lacks a cast
> 
> You can either make the constants unsigned (1U and 4U), or
> use clamp_t(u32, ...).
> 
>>>> +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>>>> +               (op->data.nbytes)) | RPC_SMENR_SPIDB
>>>> +               (fls(op->data.buswidth >> 1));
>>>
>>> Drop parenthesis around fls()
>>
>> ?
>> no way.
> 
> Please split the line before RPC_SMENR_SPIDB, and join the next line
> with the parameters, so it becomes obvious the parentheses are needed
> because RPC_SMENR_SPIDB() is a macro taking parameters.

Oh, I didn't notice that, right.

-- 
Best regards,
Marek Vasut
