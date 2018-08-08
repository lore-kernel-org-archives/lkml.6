Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C50C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D468D21708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+PHJBrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D468D21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeHHFgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 01:36:38 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39636 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbeHHFgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 01:36:38 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so1333896oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 20:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ms4FwXsJndENZbvgLcfV9ojGH69NJRZSfNVJ6d+fbAs=;
        b=H+PHJBrjANkVpZojgmycndm0V9rSdXe/RCGIbsreD/ukwgW5II8UfGucJVM21VQJf3
         Ut+WUiCzRnWYXxI26CGYLlIpulSlZAyRAZjgVmW1zAfJW3nD5KtHXLGlgaWQT3o03l64
         1nGTcdi2EfIONZ0zwxtEop9ZcL2WPAotyPUgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ms4FwXsJndENZbvgLcfV9ojGH69NJRZSfNVJ6d+fbAs=;
        b=g6IrY1dLTqTlJoStAdxttrfP8DiNN+m2gLfVdPpqBVQ7iIQTo2rC1sJg9oLWWOz+Zj
         BoX/j2eKQlJXaVLqAcq3NCbpEAA7gftVnBGcmH7sX548z4Vz3etODzX5HHAs/idmTjmA
         PVbvXTdsL8ly2hzinetmrD6argaHKMThK30sB68gLAu5YHzEWk5c077HX7ANJopYVSJV
         I9jM1OPx4LLro4F4ks0SNq7b3hQIGuEQo7MGA0EYQns86BXs9ottX+8/NBWj+qfYnlzO
         u7HTEDSH1Hb0j6s1TmgQ2OjO/iCaz+/dIb4B0I/ysyPF9EX6ITr/boj4hGAVs64eEOcq
         oaVg==
X-Gm-Message-State: AOUpUlGMNQHqoAPCrkkt9pSxEwI9a4lsIwKlmZ2yUsmS9sA8b+wMfzN/
        ctVXH9NSuLNuZX+gLafR5Rd0ICJlU7Qel3d5M9fVDL+3IX7O7A==
X-Google-Smtp-Source: AA+uWPw4DrDmv5eWrJjRuPe9WvHKBdY/5PvULRXSRpSDZ+Rkn8aTJzkiDO3yv4R6qhpBm42tsvdOB+JjAT/ilX53Waw=
X-Received: by 2002:aca:d846:: with SMTP id p67-v6mr1245446oig.42.1533698348195;
 Tue, 07 Aug 2018 20:19:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 20:19:07 -0700 (PDT)
In-Reply-To: <1533661818.2283.264.camel@impinj.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <99befd2badc4dffb59662fca1e11d79f18b64755.1533638405.git.baolin.wang@linaro.org>
 <1533661818.2283.264.camel@impinj.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 8 Aug 2018 11:19:07 +0800
Message-ID: <CAMz4kuJrzaZn9560tF73a-WPNhhRj5S2ezTKr0HHpcGRXMw-Ew@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: sprd: Add SPI driver for Spreadtrum SC9860
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lanqing.liu@spreadtrum.com" <lanqing.liu@spreadtrum.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trent,

On 8 August 2018 at 01:10, Trent Piepho <tpiepho@impinj.com> wrote:
> On Tue, 2018-08-07 at 18:43 +0800, Baolin Wang wrote:
>>
>> +static u32 sprd_spi_transfer_max_timeout(struct sprd_spi *ss,
>> +                                      struct spi_transfer *t)
>> +{
>> +     /*
>> +      * The time spent on transmission of the full FIFO data is the maximum
>> +      * SPI transmission time.
>> +      */
>> +     u32 size = t->bits_per_word * SPRD_SPI_FIFO_SIZE;
>> +     u32 bit_time_us = SPRD_SPI_HZ / t->speed_hz + 1;
>> +     u32 total_time_us = size * bit_time_us;
>> +     /*
>> +      * There is an interval between data and the data in our SPI hardware,
>> +      * so the total transmission time need add the interval time.
>> +      *
>> +      * The inteval calculation formula:
>> +      * interval time (source clock cycles) = interval * 4 + 10.
>> +      */
>> +     u32 interval_cycle = SPRD_SPI_FIFO_SIZE * ((ss->interval << 2) + 10);
>> +     u32 interval_time_us = interval_cycle * SPRD_SPI_HZ / ss->src_clk + 1;
>
> If interval is greater than 31, this will overflow.

Usually we will not set such a big value for interval,  but this is a
risk like you said. So we will check and limit the interval value to
make sure the formula will not overflow.

>
> Also SPRD_SPI_HZ is not the speed anything runs at, as one might think
> from the name.  It's the number of microseconds in a second.  The is
> already a Linux macro for that, USEC_PER_SEC, that you should use
> instead.

Right, will use USEC_PER_SEC instead.

>
>> +
>> +     return total_time_us + interval_time_us;
>> +}
>> +
>
>
>> +static void sprd_spi_set_speed(struct sprd_spi *ss, u32 speed_hz)
>> +{
>> +     /*
>> +      * From SPI datasheet, the prescale calculation formula:
>> +      * prescale = SPI source clock / (2 * SPI_freq) - 1;
>> +      */
>> +     u32 clk_div = ss->src_clk / (speed_hz << 1) - 1;
>
> You should probably round up here.  The convention is to use the
> closest speed less than equal to the requested speed, but since this is
> a divider, rounding it down will select the next highest speed.

Per the datasheet, we do not need round up/down the speed. Since our
hardware can handle the clock calculated by the above formula if the
requested speed is in the normal region (less than ->max_speed_hz).

>> +
>> +     writel_relaxed(clk_div, ss->base + SPRD_SPI_CLKD);
>> +}
>> +
>
>> +
>> +static int sprd_spi_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     struct spi_controller *sctlr;
>> +     struct resource *res;
>> +     struct sprd_spi *ss;
>> +     int ret;
>> +
>> +     pdev->id = of_alias_get_id(pdev->dev.of_node, "spi");
>> +     sctlr = spi_alloc_master(&pdev->dev, sizeof(*ss));
>> +     if (!sctlr)
>> +             return -ENOMEM;
>> +
>> +     ss = spi_controller_get_devdata(sctlr);
>> +     if (of_property_read_u32(np, "sprd,spi-interval", &ss->interval))
>> +             ss->interval = SPRD_SPI_ITVL_NUM;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     ss->base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(ss->base)) {
>> +             ret = PTR_ERR(ss->base);
>> +             goto free_controller;
>> +     }
>> +
>> +     ss->dev = &pdev->dev;
>> +     sctlr->dev.of_node = pdev->dev.of_node;
>> +     sctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE | SPI_TX_DUAL;
>> +     sctlr->bus_num = pdev->id;
>> +     sctlr->setup = sprd_spi_setup;
>> +     sctlr->set_cs = sprd_spi_chipselect;
>> +     sctlr->transfer_one = sprd_spi_transfer_one;
>> +     sctlr->max_speed_hz = (ss->src_clk / 2) < SPRD_SPI_MAX_SPEED_HZ ?
>> +             ss->src_clk / 2 : SPRD_SPI_MAX_SPEED_HZ;
>
> You can write this as:
>         sctlr->max_speed_hz = min(ss->src_clk / 2, SPRD_SPI_MAX_SPEED_HZ);

Right. Thanks for your comments.

-- 
Baolin Wang
Best Regards
