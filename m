Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F83C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DA326872
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT633WDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DA326872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933044AbeF0HwN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:52:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36350 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933003AbeF0HwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:52:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id t3-v6so2507380eds.3;
        Wed, 27 Jun 2018 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lcGFu3Cf+HOvNT5s4dYpX9gZqwV2eJ1XJh38kWmONEs=;
        b=LT633WDkPGau4/7ZYzoYO6HLqrqsVGrNPG8ut7Do0YJ6J0R0wQqAfF50CEJ8Gqcn/9
         4gr8voUG8b5GChha5/cxC2siC6gXU3KFF0OzPRHgtQAB8DTSOrupYvXqHP4+v6oEz6QI
         Mc+N+bSNcm4UQwjFyqCpuNpp2FOYW7Mxy9FN31nbAjYqS0Lzhzj/v1ZRfPX1XOig1gVx
         C3yOwbFL05x6Pwk2bz5wdOOZubgIQFhO/K75sYS4EjTWmcacFl+Zp6FFYXh3RRHAYUeL
         E/0N6BVF2Ua+jLgkTLgloha0/s/LmMuMy9nPCv+LsO1InN1cDdv2hI4wMZJdN91W9QRM
         jb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lcGFu3Cf+HOvNT5s4dYpX9gZqwV2eJ1XJh38kWmONEs=;
        b=RLrpGMIX1uXrMt6bTT6QnNvvSAgLyDmdw1X9toHbzI6RmTol0HWDI0fL8t9M/mesFW
         pimDDNocfyu6OzWjwwCgKp3Z1ZzpC9GNBBMpwi05qf6yxVgQENh7NyKc7Lx2n58/57rU
         x/vqZQmyBANRhY9yGI+AcMFbodsgqqxpxccG/2xAvVEO+m58e0cg0nIIkf7M0Nao3hlx
         7StdrH7rQB55AVvJf3kMUmY/cTT3WX3d5O9TAMl6HfvDVeh0S5ZMiZQJ6UYbyqlIXT6u
         y/oTBm9j3niuMk6rnw3LD1ldxz0vlbqFPi5YL+WUrnL/TQr9s/gj5iUtqKutTjUhYVi7
         /e2g==
X-Gm-Message-State: APt69E3n8dJ35ZXqDcH2iVE85c40/rsxFsgqBGZUTgk6f55gEH8BPR3J
        OWBdyo0j6CSUVLIjSoxN+g==
X-Google-Smtp-Source: AAOMgpeIjbR7ld1DT6PX2oyprMf0wwyxSFVHEr6cvtAxQOlsKffX4ge3AjvfoBVWJPzhhTCCfC4Jww==
X-Received: by 2002:a50:d9c7:: with SMTP id x7-v6mr4621141edj.95.1530085929245;
        Wed, 27 Jun 2018 00:52:09 -0700 (PDT)
Received: from [172.17.1.84] ([130.228.251.5])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1591264eda.14.2018.06.27.00.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 00:52:08 -0700 (PDT)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
X-Google-Original-From: Piotr Bugalski <elvis@carbonite>
Date:   Wed, 27 Jun 2018 09:52:00 +0200 (CEST)
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
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
In-Reply-To: <455adb76-530a-1fd5-303c-cfa158ad7870@microchip.com>
Message-ID: <alpine.DEB.2.20.1806270940500.32198@carbonite>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com> <20180618162124.21749-2-bugalski.piotr@gmail.com> <20180621233321.0f25f572@bbrezillon> <alpine.DEB.2.20.1806220719190.21824@carbonite> <20180622093905.62a3b936@bbrezillon>
 <455adb76-530a-1fd5-303c-cfa158ad7870@microchip.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tudor,

Thank you very much for comments.

On Tue, 26 Jun 2018, Tudor Ambarus wrote:

> Hi, Piotr,
>
> General things to consider for the limitation in performance:
> - is the serial flash memory operating in Quad SPI?

Yes, I've checked signal using logic analyzer, data is transferred using
all four lines.

> - QSCLK should be as high as possible

Sure, but when we are using lower frequency CPU impact should be
negligible while efficiency is crap on every speed.

> - transfer delays - I checked them, they have default values, we should be good.
> - use DMA, as you suggested
>

I don't understand one thing. While CPU is not busy and during my tests
100% of CPU can be used for communication, efficiency is still very low.
Why DMA has such impact?

It is very interesting to observe signals using logic analyzer.
When CPU is used for communication, there are long delays after
every byte transferred. These delays are  much longer than it 
should be only because of writing next value by CPU.
I tried to change SPI frequency. If delay were CPU related,
delay time should stay the same. Unfortunately results were different -
lowering SPI freqency extends delay time.
Using DMA makes these delays to disappear, but how to acheive CPU
communication without delays?

> On 06/22/2018 10:39 AM, Boris Brezillon wrote:
>> [...]
>>
>>>>> +/*
>>>>> + * Atmel SAMA5D2 QuadSPI driver.
>>>>> + *
>>>>> + * Copyright (C) 2018 Cryptera A/S
>>>>
>>>> A non-negligible portion of this code has been copied from the existing
>>>> driver. Please keep the existing copyright (you can still add Cryptera's
>>>> one).
>>>>
>>>
>>> Technically this driver were written from scratch, with spi-fsl-qspi
>>> as example of new interface. Hence the name and code structure.
>>> But it's the same peripheral as Atmel's driver uses so code looks
>>> similar. I can unify the code to make comparsion even simpler and
>>> then update copyright.
>>
>> Hm, ok. Some constructs really looked like they were copied
>> from the old driver, hence my comment. I'll let Nicolas give his
>> opinion on this aspect.
>
> This driver will be a conversion of the legacy one to the spi-mem interface. I
> would keep the legacy copyright and add Cryptera's below, as Boris suggested.
>
> [...]
>
>>>>> +#define QSPI_SR_CMD_COMPLETED           (QSPI_SR_INSTRE | QSPI_SR_CSR)
>>>>
>>>> Do you really to wait for both INSTRE and CSR to consider the command
>>>> as complete?
>>>>
>>>
>>> This part were really copied from Atmel driver. I wasn't sure so I
>>> used tested solution.
>>
>> Okay. I guess that's a question for Cyrille and/or Tudor then.
>
> We have to wait for both INSTRE and CSR.
>

I've also found that information in datasheet, good we have this
solution then.

> Best,
> ta
>

Best Regards,
Piotr

