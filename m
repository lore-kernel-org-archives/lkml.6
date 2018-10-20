Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF814C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0DC21523
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKL0qWyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0DC21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJTT76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 15:59:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37705 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeJTT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 15:59:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id d14-v6so41287568qto.4;
        Sat, 20 Oct 2018 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfU7trzytXEQgm48XveJPLclbMip892MyyjjV71tUP8=;
        b=SKL0qWyR9JAvYMazbtshAYLsYIRDjdLHL+yYbptWVlBPii8D1YGJk5TYx+tN5idxpH
         Rwyc+XzqT7dlgpoS9i3p2TMyqYBwWJ1ibO8TULv6OPih0ocYA0ZvUhh4KSZFkOuTCPIH
         hhd3ljUnmPrlpNx1BMYI2/Z1PRjmkHeYYhbfGyhAWaY+u/MTWkoyowud6DoBk982+kb2
         UPtcuR49531Wzfa14wPS5UCkFnNPnn5KUpOz93IsdnLyaYeLY9/1xVXedWGpltdFvftS
         IeOIkvo1JwyuKsvPzjATht3qsaYvUnrD7gCMuj2u6kIPGB3s0xerZWMPmtklJD9RfkNz
         pTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfU7trzytXEQgm48XveJPLclbMip892MyyjjV71tUP8=;
        b=V2/YXtgeZntOUcOOe3W5xk2IWWFAxSq6/S5VwgCpgv5EvPYAsgqPqmjK0udcfzuola
         JqRuzhSR6Sp9KCvbO+kj4NiYYa7XUpZ5WVwDQH7GURRIcoUNk20svjD+ohc40SQUqWok
         9jczrolgonNE0NWp/c7URmgHVsyjnGgAtDCNcIAMl/0RIa3zLiIgwJST+JWIQ5LCMaeG
         Md1K5Gs1BzhjmyCW8jLApcTWIvGHkdcpqkeC1mgmpMVxGkNa5fbcxAIuDjLEj/VUW2qK
         k0n6CSxXaFq4qP0nPqc16GPGJXH5nh3fYQY8wQmOhkX/QTpuTXsKalAOkUrXxbKHVk8h
         82yw==
X-Gm-Message-State: AGRZ1gLD5vW5bzAeE4iA23hTtBNo4b1zygT39m7SJKMrarSd8zlZvQ2T
        NGptI076AAqXqBGrjb1Re9m2ccGDXe4t4GvDruY=
X-Google-Smtp-Source: ACcGV61yqz2eA3u7RdRfX5MIl8qS2aFtZaNR1SSGsZ28eL37+/YipKpp19JSvhAbd9gbiz0wCT6o9nhEh6fm9qERFn0=
X-Received: by 2002:ac8:191a:: with SMTP id t26-v6mr4790985qtj.327.1540036185534;
 Sat, 20 Oct 2018 04:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180421085009.28773-1-javier@emutex.com> <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-2-git-send-email-dan@emutex.com>
In-Reply-To: <1539969334-24577-2-git-send-email-dan@emutex.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Oct 2018 14:49:33 +0300
Message-ID: <CAHp75VdkwfcPdSmB0dYBF_xwwXMqkrLOa1tL0xkOJ4DVcx8h8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mfd: upboard: Add UP2 platform controller driver
To:     "Dan O'Donovan" <dan@emutex.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        carlos.iglesias@emutex.com, Javier Arteaga <javier@emutex.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 8:26 PM Dan O'Donovan <dan@emutex.com> wrote:
>
> From: Javier Arteaga <javier@emutex.com>
>
> UP Squared (UP2) is a x86 SBC from AAEON based on Intel Apollo Lake. It
> features a MAX 10 FPGA that routes lines from both SoC and on-board
> devices to two I/O headers:
>
>                                 +------------------------+
>                                 | 40-pin RPi-like header |
>                          +------|         (HAT)          |
>                          |      +------------------------+
>     +-------+    +--------+
>     |       |    |        |     +------------------------+
>     |  SoC  |----|  FPGA  |-----|  Custom UP2 pin header |
>     |       |    |        |     |        (EXHAT)         |
>     +-------+    +--------+     +------------------------+
>                          |
>                          +------* On-board devices: LED, VLS...
>
> This is intended to enable vendor-specific applications to customize I/O
> header pinout, as well as include low-latency functionality. It also
> performs voltage level translation between the SoC (1.8V) and HAT header
> (3.3V).
>
> Out of the box, this block implements a platform controller with a
> GPIO-bitbanged control interface. It's enumerated by ACPI and provides
> registers to control:
>
> - Configuration of all FPGA-routed header lines. These can be driven
>   SoC-to-header, header-to-SoC or set in high impedance.
>
> - On-board LEDs and enable lines for other platform devices.
>
> Add core support for this platform controller as a MFD device, exposing
> these registers as a regmap.

Can we see a link to or an excerpt of ACPI table for this device?

> +#define set_clear(u, x) gpiod_set_value((u)->clear_gpio, (x))
> +#define set_strobe(u, x) gpiod_set_value((u)->strobe_gpio, (x))
> +#define set_datain(u, x) gpiod_set_value((u)->datain_gpio, (x))
> +#define get_dataout(u) gpiod_get_value((u)->dataout_gpio)

I think these macros don't bring much value. (Up to you and Lee to decide)


> +static void __reg_io_write(const struct upboard_ddata * const ddata,
> +                          unsigned int size, unsigned int val)
> +{
> +       int i;
> +
> +       /*
> +        * DATAIN is latched on each rising edge of the STROBE signal.
> +        * Data (register address or value) is sent MSb first.
> +        */

> +       for (i = size - 1; i >= 0; i--) {

while (size--)

> +               set_strobe(ddata, 0);
> +               set_datain(ddata, (val >> i) & 0x1);
> +               set_strobe(ddata, 1);
> +       }
> +}
> +
> +static void __reg_io_read(const struct upboard_ddata * const ddata,
> +                         unsigned int size, unsigned int *val)
> +{
> +       int i;
> +
> +       /*
> +        * DATAOUT is latched on on each rising edge of the STROBE signal.
> +        * Data (register value) is received MSb first.
> +        */
> +       *val = 0;

> +       for (i = size - 1; i >= 0; i--) {

Ditto.

> +               set_strobe(ddata, 0);
> +               set_strobe(ddata, 1);
> +               *val |= get_dataout(ddata) << i;
> +       }
> +}

> +static int upboard_check_supported(struct device *dev, struct regmap *regmap)
> +{
> +       uint8_t manufacturer_id, build, major, minor, patch;
> +       unsigned int platform_id, firmware_id;
> +       int ret;

> +       manufacturer_id = platform_id & 0xff;

Redundant & 0xff part.

> +       if (manufacturer_id != AAEON_MANUFACTURER_ID) {
> +               dev_err(dev,
> +                       "unsupported FPGA firmware from manufacturer 0x%02x",
> +                       manufacturer_id);
> +               return -ENODEV;
> +       }

> +static int upboard_match_device(struct device *dev)
> +{
> +       struct upboard_ddata *ddata = dev_get_drvdata(dev);
> +       const struct acpi_device_id *id;
> +

> +       id = acpi_match_device(upboard_acpi_match, dev);
> +       if (!id)
> +               return -ENODEV;
> +
> +       switch (id->driver_data) {

device_get_match_data() IIRC the name of the call.

> +       case UPBOARD_ID_UP2:
> +               ddata->regmapconf = &upboard_up2_regmap_config;
> +               ddata->cells = upboard_up2_mfd_cells;
> +               ddata->ncells = ARRAY_SIZE(upboard_up2_mfd_cells);
> +               break;
> +       default:
> +               dev_err(dev, "unsupported ID %lu\n", id->driver_data);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}

> +       ret = upboard_init_gpio(dev);
> +       if (ret) {
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "failed to init GPIOs: %d", ret);
> +               return ret;
> +       }

I don't know if probe_err() helper is going to be a part of v4.21
(which this series targets), it would be good to use it.

> +}

-- 
With Best Regards,
Andy Shevchenko
