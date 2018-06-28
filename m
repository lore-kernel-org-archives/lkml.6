Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472BFC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F6027314
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8ATI8d7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F6027314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934223AbeF1MCa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:02:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45368 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbeF1MC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:02:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id g15-v6so625927edr.12;
        Thu, 28 Jun 2018 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ljY3ugvmSl2VVG4kqLnEmYqiY41ElSAYYMx/X3Gw72c=;
        b=r8ATI8d73RzYyn6BbAomWQnNOMTpktQeRm89jLg132CcGgUmfxohUKr21Vi77DpxyK
         0YNGAP93QAAlnH6uBOUPlkQs1SRAPq98UnA+NClr2LPyz21I/R7wa37V8ozEqrk0mv0w
         50FownUYaAYk/jiFvCZc5y2NyZ8p+DrYlSPiB/OjeuEVZ3/IAXmJAEHosMaSRU+LtYfx
         BoydGqvvpCvcUTudyNEdHGkWSafssXmmYkIPT6Rn0f2N2k2DZe44hoStq87pdoquHVZM
         cVjk149jquw6qPqLXjOnQVnQU/hRiw4ApGsggD78U6cqXo4AY2ZSWYqIxk4bWz+nJC5s
         ME5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ljY3ugvmSl2VVG4kqLnEmYqiY41ElSAYYMx/X3Gw72c=;
        b=Dt2/lbe2AvnctbyLevWw1xuY6etK6oXTJTNJXOZI+4H3/YQiGmw3xYQYHai2S5xdB+
         BFuvY39ZuA3porlJX1xS7LYqZv3/7eZ7zrGDe0ZCSwwxshHQA6vczSohiPDrRih5su6F
         3Z/1x0Ivm6PJYwFJktopO9uWap6DDWtWVUGKUt3+OKYC8DatSFwGKmqd7BgMVHyPQKuJ
         fkmrGvpAg/OE2gVR29CzDkt7BB3cKFK5ivNe4yIkutXDMyj3bJxLtkc97yEDEzBMoTqu
         9F7gE+HYWc9rkSeSg6NGhqIMVv4vvvtLoPLGRP2puN7XGPCwjnBPhlC8VYNetIlf+/Fy
         paTg==
X-Gm-Message-State: APt69E0tCqYuJ7oW7JzcjsOq8nyVtkLG+n6KukVGYB3gicOxWG9GS9sr
        e0L10p9eIYcqjyiEoZgIwQ==
X-Google-Smtp-Source: AAOMgpf8ztZHCZMPG/1qnfdivrSSdAB6DTviSU+PlKGFMIm3AE2sXIsUa4xXm5Oj+C2utKGnE4txFg==
X-Received: by 2002:a50:d0d1:: with SMTP id g17-v6mr9047391edf.182.1530187346115;
        Thu, 28 Jun 2018 05:02:26 -0700 (PDT)
Received: from [172.17.1.67] ([130.228.251.5])
        by smtp.gmail.com with ESMTPSA id l13-v6sm2946432edn.74.2018.06.28.05.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 05:02:24 -0700 (PDT)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
X-Google-Original-From: Piotr Bugalski <elvis@carbonite>
Date:   Thu, 28 Jun 2018 14:02:19 +0200 (CEST)
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
cc:     Piotr Bugalski <bugalski.piotr@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: Re: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <1d736934-b3e7-7b23-0f34-1d22d36b2b18@microchip.com>
Message-ID: <alpine.DEB.2.20.1806281352590.22837@carbonite>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com> <20180618162124.21749-2-bugalski.piotr@gmail.com> <20180621233321.0f25f572@bbrezillon> <alpine.DEB.2.20.1806220719190.21824@carbonite> <20180622093905.62a3b936@bbrezillon>
 <455adb76-530a-1fd5-303c-cfa158ad7870@microchip.com> <alpine.DEB.2.20.1806270940500.32198@carbonite> <1d736934-b3e7-7b23-0f34-1d22d36b2b18@microchip.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tudor,

On Thu, 28 Jun 2018, Tudor Ambarus wrote:

> Hi, Piotr,
>
> On 06/27/2018 10:52 AM, Piotr Bugalski wrote:
>>
>>> General things to consider for the limitation in performance:
>>> - is the serial flash memory operating in Quad SPI?
>>
>> Yes, I've checked signal using logic analyzer, data is transferred using
>> all four lines.
>>
>>> - QSCLK should be as high as possible
>>
>> Sure, but when we are using lower frequency CPU impact should be
>> negligible while efficiency is crap on every speed.
>>
>>> - transfer delays - I checked them, they have default values, we should be good.
>>> - use DMA, as you suggested
>>>
>>
>> I don't understand one thing. While CPU is not busy and during my tests
>> 100% of CPU can be used for communication, efficiency is still very low.
>> Why DMA has such impact?
>>
>> It is very interesting to observe signals using logic analyzer.
>> When CPU is used for communication, there are long delays after
>> every byte transferred. These delays are  much longer than it should be only because of writing next value by CPU.
>
> Are those consecutive transfers (same peripheral without removing chip select)?
> The delays between consecutive transfers can be set just in SPI mode. It would
> be strange to see this kind of delays in serial memory mode.
>

Yes, it's just single block transfer so no CS changes occurs.
I find this delays strange also, but I have no idea how to avoid them.
The same behaviour exists even when DMA is used in APB mode (write
to registers). Only using SMM with DMA helps.

>> I tried to change SPI frequency. If delay were CPU related,
>> delay time should stay the same. Unfortunately results were different -
>> lowering SPI freqency extends delay time.
>
> If QSCK is less than f-perif-clock/2, then setting DLYBS to 1 will shorten the
> DLYBS delay, but this is peanuts.
>

I have DLYBS, DLYCS and DLYBCT set to zeros. I can try DLYBS=1 if
you wish.

> Thanks,
> ta
>
>> Using DMA makes these delays to disappear, but how to acheive CPU
>> communication without delays?
>

Thank you for comments,
Piotr
