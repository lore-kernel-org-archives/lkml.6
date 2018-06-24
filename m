Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DB1C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 23:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B44625375
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 23:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffXNIPmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B44625375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeFXXvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 19:51:23 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38574 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeFXXvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 19:51:21 -0400
Received: by mail-ot0-f194.google.com with SMTP id w16-v6so4493073otk.5;
        Sun, 24 Jun 2018 16:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/HBaArMgj9C6KEqAjvjAWzn59kkoG/COp3jOMwoCxns=;
        b=ffXNIPmKkuB8iQYWnUsznwvRJ3+81NyhNEp4m8AZg0SgoJ3hN7zWjftmsC2/T8tLc2
         c/dxhTFQXVFa1FEpFiHhE7/Y+KkNyaCYnNsHM8eoTZLJkICLoF9EUHsw208sLjk/3pf9
         tOpP/TKN168RppFgYKx1hxpogUzGcsHrXfjXHy3VFNYCeolvM+YLFf0bW3wJVIVkhFfX
         c9fY6RhFm4ceyW1YCtNjDhmt+aHqfy8V/iMqkqFpe+w/LvA9ahymQwkhJKcIVICWMnKJ
         LpvE8n3rdicoRkTPCDZHrkrQM+1OvwyMdroUAtpd612Ocd0JX4mXYHDjGR270giEMuA2
         31Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/HBaArMgj9C6KEqAjvjAWzn59kkoG/COp3jOMwoCxns=;
        b=dl+HJn2Wp0Ur2YRi/szLwzMcNxVSeY88njkZzHMIV6nehJ/0ptWwg7NifZPSCwipPI
         X39+Lp4itHT7hR5rBY9v6fduq8ZqRjdZbptYIyiucv1BK5W9jlaRHuBtuzJRkPv+Z4x3
         iP7ett/7PqwmmW/ZscutgVgb5mBB/Q8texxRYfAngB1k2QtEERgJfnqO/TGxRaKWi/0n
         k545Kz8AsxikERG+L+2WEOXugZgMxLJhaaau0HAklJdIDnvEyVlyvabBQYPPeIcHb+nn
         zO2nxn2eieS/MaxcDsabKOwaZY5OBw6wLKF22rSKPHdx2r9GjTs024Ny7dtwYOczdm3I
         RoSA==
X-Gm-Message-State: APt69E2fEGsQo7kwNCZCpXRk1nnrI41ElqfGKomDx5F1GMAVZkKcAVbQ
        +z8D/mgQ1LHIuwwYXYw1uygTaeBx/PDTgK/wEho=
X-Google-Smtp-Source: ADUXVKKmDtdBMqfKEOkLeRvMbS98smSLv701Bb6IjIEpo3VpKPEP/cWnNB0tvcYOsH6tlTouqoz9tnMGWIdLlUCOleo=
X-Received: by 2002:a9d:cc8:: with SMTP id o8-v6mr6675449otd.38.1529884280768;
 Sun, 24 Jun 2018 16:51:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 16:51:20
 -0700 (PDT)
In-Reply-To: <CAHQ1cqHpNvZGAfFKrp-OiZevsha5CBwJsw8GT+uhgNSfEUejkw@mail.gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
 <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com>
 <CAOMZO5CumdNSP6iTfgXPdmpcZwh7YmBstUpAmb3A1QAf1UWJdw@mail.gmail.com> <CAHQ1cqHpNvZGAfFKrp-OiZevsha5CBwJsw8GT+uhgNSfEUejkw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 24 Jun 2018 20:51:20 -0300
Message-ID: <CAOMZO5DAbooRgA+sHJa5EmEGy-CHW3FPydcOFtK5AqpdJzD7MQ@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Peter Chen <peter.chen@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Sun, Jun 24, 2018 at 7:40 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> It's definitely the bootloader, or more specifically whether or not it
> initialized/used USB before booting the kernel. Some interesting
> highlights:
>
>  - On your "good" 4.17.2 based image, if you interrupt U-Boot, do "usb
> start" (optionally "usb stop") and then "boot", you'll get the hang
> that I was trying to fix with my patch.
>
>  - Things are exact opposite with 4.18-rc1 and doing the above would
> _prevent_ the hang and the image would boot fine.
>
>  - Disabling USB in Barebox based boot "stack" gets it to behave the
> same way as U-boot from your image (hanging when booting 4.18-rc1)
>
> Digging more into code it seems that the reason for 4.18-rc1's
> behavior is the fact that it's missing a call hw_phymode_configure()
> after usb_phy_init() and, AFAICT, the only reason it is not happening
> is because default image is being built without
> CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS. Enabling those two
> options on 4.18-rc1, seem to fix the problem on both your U-Boot based
> image and my "special" Barebox setup.
>
> So AFAICT, this patch still fixes a valid issue (my use-case was net
> booting via USB-Ethernet dongle), but an additional patch enabling
> those two configuration options might be needed. Thoughts?

Yes, I can confirm that your suggested change avoids the kernel hang:

diff --git a/arch/arm/configs/imx_v6_v7_defconfig
b/arch/arm/configs/imx_v6_v7_defconfig
index d14de86..2da678c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -300,6 +300,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_FTDI_SIO=m
@@ -336,6 +337,7 @@ CONFIG_USB_GADGETFS=m
 CONFIG_USB_FUNCTIONFS=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
+CONFIG_USB_ULPI_BUS=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y

> Also, I don't have any i.MX53 HW, so I wasn't able to test the effects
> of enabling those two options there.

The imx53 board I have access to does not use ULPI.

Maybe Sebastian on Cc may help testing this on his imx53 board as he
is the author of:
be9cae2479f48 ("usb: chipidea: imx: Fix ULPI on imx53")

I am wondering if we need to force some kind of USB reset to put the
USB controller into a known state independently of what the bootloader
has done previously.

Thanks
