Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7EEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ED120881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSyaXALL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96ED120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbeLCIOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:14:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33380 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLCIOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:14:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so12763362qtp.0;
        Mon, 03 Dec 2018 00:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZzRMC4CM45BgSQpZdQxsEMspQ5uuOMVoXYF0i64M28=;
        b=YSyaXALL71meXGHh5/Nuab6nqEYdg+7It3hJZeNGWeM/ayyZOzMUu7X0S3gra2Az/V
         jKyME26IlXLN/Z9PTAhYDizJklW8lp8r75AOs4Ea13RgmvC5sMCBoO29BFsTQC++I8sd
         DA7OWl7VvSjz5S6fwah0bzz80RfMm+5HCdCPJXpGsKiX2di0hrqDXhYHncmlCQEFcebf
         Zh2FCFhYj2eZatwBJ5XlmZ2087PN90+2ODe8QMjY5dXUMSt/vrT5chs2trx0GY5Vl80d
         bsXxtNLsgQX8f3x22s42Y0B9zKsmr7M5qgITvmHvLnPVYtNf5MV/TCUbVUmrZpbLgyK4
         Id7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZzRMC4CM45BgSQpZdQxsEMspQ5uuOMVoXYF0i64M28=;
        b=k4CG12YxUGkRYhx8Jd4oo6lLXl7kpUsq1Z+/Fo18UuVJnGgdmCsLJm+Q1xmLpOSK/R
         PqwhOhRfQlJwI9P/tooDvL6kh00beyQTHFx+JHbZIrR8eiAvZSLGlohL4IZ1Ph5Nx7uY
         oVSiaFJmvTRoIEdjMCcCfJ2mb2MPfxsYWoORd+xWQrqXdFm52Dt6Waiz/NIdX5ghBsmA
         ZssxPjpC68NaxX36vgNZP5YMb2DK21FZPlhmNMzXf3EVD60Q4cdVcKXe+XB4QEJmx/Ku
         76nnT556aKDEuEiSe1BOWXtAyndGKWLTUec+fwPk73WJJEdhChFiQrlEH3llTNeLtSNj
         Mo6A==
X-Gm-Message-State: AA+aEWZ3Dmgv1XMo281To3ikqY7GRwrzDc9jaaAwxxXl5zuKkf4OuvgP
        eJhiAc9iZ5PayDsI+oOihErMhrnfq1ULAYrR1mAWMmbxjww=
X-Google-Smtp-Source: AFSGD/XWY5/Jpe/69OROY6sXqDodaf0+Kj9WrT2dKTO7TN7nTEF6dO/E6qdLkjkLHTFbPvpddk/oQgIWqXl5j8iG07o=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr14404054qvl.180.1543824881868;
 Mon, 03 Dec 2018 00:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20181203034515.91412-1-chenyu56@huawei.com> <20181203034515.91412-7-chenyu56@huawei.com>
In-Reply-To: <20181203034515.91412-7-chenyu56@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 10:14:30 +0200
Message-ID: <CAHp75Vepvab=fD-3vps_RXewrb-Nfe8947soAmbNHatS4YQR4w@mail.gmail.com>
Subject: Re: [PATCH v1 06/12] phy: Add usb phy support for hi3660 Soc of Hisilicon
To:     chenyu56@huawei.com
Cc:     USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        lpc.li@hisilicon.com, sunjianguo1@huawei.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xuejiancheng@hisilicon.com, John Stultz <john.stultz@linaro.org>,
        Wangbinghui <wangbinghui@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:47 AM Yu Chen <chenyu56@huawei.com> wrote:
>
> This driver handles usb phy power on and shutdown for hi3660 Soc of
> Hisilicon.

> +// SPDX-License-Identifier: GPL-2.0+

Ambigous license through the code reading.


> +#define PERI_CRG_CLK_EN4                       (0x40)
> +#define PERI_CRG_CLK_DIS4                      (0x44)
> +#define GT_CLK_USB3OTG_REF                     BIT(0)
> +#define GT_ACLK_USB3OTG                                BIT(1)
> +
> +#define PERI_CRG_RSTEN4                                (0x90)
> +#define PERI_CRG_RSTDIS4                       (0x94)
> +#define IP_RST_USB3OTGPHY_POR                  BIT(3)
> +#define IP_RST_USB3OTG                         BIT(5)
> +
> +#define PERI_CRG_ISODIS                                (0x148)
> +#define USB_REFCLK_ISO_EN                      BIT(25)
> +
> +#define PCTRL_PERI_CTRL3                       (0x10)
> +#define PCTRL_PERI_CTRL3_MSK_START             (16)
> +#define USB_TCXO_EN                            BIT(1)
> +
> +#define PCTRL_PERI_CTRL24                      (0x64)
> +#define SC_CLK_USB3PHY_3MUX1_SEL               BIT(25)
> +
> +#define USBOTG3_CTRL0                          (0x00)
> +#define SC_USB3PHY_ABB_GT_EN                   BIT(15)
> +
> +#define USBOTG3_CTRL2                          (0x08)
> +#define USBOTG3CTRL2_POWERDOWN_HSP             BIT(0)
> +#define USBOTG3CTRL2_POWERDOWN_SSP             BIT(1)
> +
> +#define USBOTG3_CTRL3                          (0x0C)
> +#define USBOTG3_CTRL3_VBUSVLDEXT               BIT(6)
> +#define USBOTG3_CTRL3_VBUSVLDEXTSEL            BIT(5)
> +
> +#define USBOTG3_CTRL4                          (0x10)
> +
> +#define USBOTG3_CTRL7                          (0x1c)
> +#define REF_SSP_EN                             BIT(16)
> +
> +#define HI3660_USB_DEFAULT_PHY_PARAM           (0x1c466e3)

A lot of redundant parens.

> +static const struct of_device_id hi3660_phy_of_match[] = {
> +       {.compatible = "hisilicon,hi3660-usb-phy",},
> +       { },

No comma needed.

> +};

-- 
With Best Regards,
Andy Shevchenko
