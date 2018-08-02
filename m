Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E1DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ADB21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnYvMMSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85ADB21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeHBVoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:44:38 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40216 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHBVoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:44:38 -0400
Received: by mail-vk0-f68.google.com with SMTP id q184-v6so1632769vke.7;
        Thu, 02 Aug 2018 12:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FFkZOuciTSWH3PXQg7FzWg2BCu6qD6mXF998zw61qDY=;
        b=BnYvMMSGmR5xHE7WbIqqevTdqFp5mGvzuNbsoPXDgTpbuU4hUasZ1xsFVsBfxc6isK
         8unO2/4F3tW+920hdI0qo0a63dn2IOV6tUs56XsGdsO6op4R+to74+zmwDGzQLlQ0D+p
         rvV6kcH+Mr2nSLohav2dqPjK4fevFsAjnKklXIKhKFwuWuuQyFXkU+sbZ5ZT5ZlzXVP6
         ThQ/uN8Ov8Vyhx6P1uWzeHZvNzeIr6+YBO/6CT7bW1aIS4fcHX+J6GuyHtktHx4s/bQT
         vFYWXx2sx7xUAwnn3BxffUL2E+IIdNCjnJpTJfsDAQ03h5W09iQMb9BP8bcS1U+MKc9E
         ZPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FFkZOuciTSWH3PXQg7FzWg2BCu6qD6mXF998zw61qDY=;
        b=uiJSTiAQj63lJbUir5O3g0kvK1oqr3gFdvQvAWVCBITJOJR6csS1JKcFvdLMrJY0R3
         Wd3pHxyKqdK51YqHSpE6NKtLCg3xO8SMtRcZqdD+m7zFGEUVXrhwZ7jy5/x0daR0iAbQ
         Z6B79SZCGtf0ngJP5SIqQRZUyQQDyM5vmNfumEZjJHkoWTc4COgxcJBJ7Mow4NxDHmmR
         YN/eAVu/Ai5H7q2bYJY8CpOv4D48kzz1XB7RBNdfhVfBWEsHQOFqIuDmifEO1f+JKBBr
         V2K424PMkxfNjblLFaJDbGQq+v5Rs4Z5pr+aux+itUMXpWJPeqk+4YVTJqWX7iR0nai8
         eefQ==
X-Gm-Message-State: AOUpUlE1lMIg/XRCoL4rTMsNfvJpLOsq8n2Io3zu00l+52gp3/dPDuhG
        QGyf1U7u2WiX+KnfhlR4bIYWSqJAu2zk8TShYaM=
X-Google-Smtp-Source: AAOMgpeZZrtygHxWyQNUJFAOUlhO8utaVgmYGdo0W2YKEpRTmzukSAKWe+zHbTYxyPJsTW8Ub6HuJKZB3oENfvBqMUg=
X-Received: by 2002:a1f:920b:: with SMTP id u11-v6mr589875vkd.58.1533239521306;
 Thu, 02 Aug 2018 12:52:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 12:52:00 -0700 (PDT)
In-Reply-To: <20180802191554.20176-1-marcus.folkesson@gmail.com>
References: <20180802191554.20176-1-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Aug 2018 22:52:00 +0300
Message-ID: <CAHp75Vf8kMLsoFN_EK150yW_FvH8XfgjiETYAtvW63et5NNurw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: adc: add support for mcp3911
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 10:15 PM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> MCP3911 is a dual channel Analog Front End (AFE) containing two
> synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

> Signed-off-by: Kent Gustavsson <kent@minoris.se>

What is this? Why it's here (presense and location in the message)?

> + * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>

> + *

Redundant.

> +static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
> +{
> +       int ret;
> +
> +       reg = MCP3911_REG_READ(reg, adc->dev_addr);
> +       ret = spi_write_then_read(adc->spi, &reg, 1, val, len);
> +       if (ret < 0)
> +               return ret;
> +
> +       be32_to_cpus(val);
> +       *val >>= ((4 - len) * 8);
> +       dev_dbg(&adc->spi->dev, "reading 0x%x from register 0x%x\n", *val,
> +                       reg>>1);
> +       return ret;
> +}
> +
> +static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 len)
> +{
> +       dev_dbg(&adc->spi->dev, "writing 0x%x to register 0x%x\n", val, reg);
> +
> +       val <<= (3 - len) * 8;
> +       cpu_to_be32s(&val);
> +       val |= MCP3911_REG_WRITE(reg, adc->dev_addr);
> +
> +       return spi_write(adc->spi, &val, len + 1);
> +}

Can't you use REGMAP_SPI ?

> +       of_property_read_u32(of_node, "device-addr", &adc->dev_addr);
> +       if (adc->dev_addr > 3) {
> +               dev_err(&adc->spi->dev,
> +                               "invalid device address (%i). Must be in range 0-3.\n",
> +                               adc->dev_addr);
> +               return -EINVAL;
> +       }
> +       dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);

Isn't what we called CS (chip select)?

> +       if (IS_ERR(adc->vref)) {

> +

Redundant.

> +       if (adc->clki)

Seems to be redundant if clock is optional (it should be NULL and API
is NULL-aware).

> +               clk_disable_unprepare(adc->clki);

> +       if (adc->clki)
> +               clk_disable_unprepare(adc->clki);

Ditto.

> +#if defined(CONFIG_OF)

This prevents playing with the device on ACPI enabled platforms.

> +               .of_match_table = of_match_ptr(mcp3911_dt_ids),

Ditto for macro.

-- 
With Best Regards,
Andy Shevchenko
