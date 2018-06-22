Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776DAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2416323F23
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV9DwA+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2416323F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeFVIm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:42:29 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38615 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbeFVIm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:42:26 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so7970192lfh.5;
        Fri, 22 Jun 2018 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4nv5ty2ilxan10XbO2sCYoNuwELuDNB6zhPYxnBjO8=;
        b=KV9DwA+xikJ4+9I5azPOVA9ncEtfA8ho/GSSULrdX/8BZoaoj0vrehDrBfnDgmg6a4
         p7Pd/cQl/sdkAUgFArkoBTGEYYk7upDIkpSpGCLxM+GJrgoR6pXA2RcNPvnlhf5CTQWQ
         VI92jQyHbtV+b0BGKgamfwHhxqp5FX+9JujYNYrMlxqdwo3xpFaIRK/XUVzy7OEKK2oX
         BgNFX+OItSXrcXl+9g3F14HsRZzx7mEWVy4bRFuTpp27BFU43pkEbs8EMX2dEYTKEE9K
         IAiu3TgFj81JDN56HAF6HAJdaP8tbe8Lv0CwNflwVVCp+kF8xULVHJnbwSUsoYNjHZux
         ARUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Q4nv5ty2ilxan10XbO2sCYoNuwELuDNB6zhPYxnBjO8=;
        b=AGxYzDsisFyOrSypXXaXh3RfUhAvqRvWV0oEqHJ8i8qZQx9f9FwBCrdjWsdwGGCLFs
         9U/qcCd3bQ3hqXlxCo74JVfs2bI9QXjyZa4uG4vPaKqgtpW/z9g+QXDgoblOdefXxmen
         +49gWBiSGw5XqwMMh9GssGtm5+Qzj0IMcmbi+btlP0jmYpaSRcucTtbX8PhBdiGIvrIm
         +AIprO2t5x4AcWl8LhT1fWhF3YyUa3AF5F3B81c44+/8N4f54oh4sIB2HdXDfhmZjWkh
         YfjENTbOk8bPE93KJmq9YYsZZBH5aNbeXH0lGbUNPpYULwFAMqLYW11Z4P+ZCSWrE1y2
         omoA==
X-Gm-Message-State: APt69E3FL/fP71qrbMmDXtkwqbVOI7I7KADKqh12GWRnSFeINQgxCj1M
        Wyy4dm0w40uiNA658lYQJqo=
X-Google-Smtp-Source: ADUXVKLnGUbrPyh9TI3z3iCsa4KkxP95Kv3tx3IywWFmz8beYBcFS1zqxGfv4DX+aupYUesuF8SmUw==
X-Received: by 2002:a19:23cb:: with SMTP id j194-v6mr671744lfj.90.1529656944299;
        Fri, 22 Jun 2018 01:42:24 -0700 (PDT)
Received: from acerlaptop.localnet (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.gmail.com with ESMTPSA id z1-v6sm1215185ljz.69.2018.06.22.01.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 01:42:23 -0700 (PDT)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH 3/7] ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy S phone.
Date:   Fri, 22 Jun 2018 10:42:22 +0200
Message-ID: <1851346.itd6mG8ZId@acerlaptop>
User-Agent: KMail/5.1.3 (Linux/4.13.0-45-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <CAJKOXPf8cpJ-pivG9j1sCM3aB_-i2n73MoeQKOd4oXxz976EVw@mail.gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1529608199-5583-4-git-send-email-pawel.mikolaj.chmiel@gmail.com> <CAJKOXPf8cpJ-pivG9j1sCM3aB_-i2n73MoeQKOd4oXxz976EVw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 22, 2018 9:49:42 AM CEST Krzysztof Kozlowski wrote:
> On 21 June 2018 at 21:09, Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.c=
om> wrote:
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
>=20
> Please add commit message. This can be something as simple as "Add
> Samsung Galaxy S DTS which is a commercial phone based on Aries
> family." or something more (e.g. describe what is working).
>=20
> > ---
> >  arch/arm/boot/dts/Makefile            |  1 +
> >  arch/arm/boot/dts/s5pv210-galaxys.dts | 72 +++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 73 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 7e2424957809..522ebdca1d3d 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -846,6 +846,7 @@ dtb-$(CONFIG_ARCH_S3C64XX) +=3D \
> >         s3c6410-smdk6410.dtb
> >  dtb-$(CONFIG_ARCH_S5PV210) +=3D \
> >         s5pv210-aquila.dtb \
> > +       s5pv210-galaxys.dtb \
> >         s5pv210-goni.dtb \
> >         s5pv210-smdkc110.dtb \
> >         s5pv210-smdkv210.dtb \
> > diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/=
s5pv210-galaxys.dts
> > new file mode 100644
> > index 000000000000..d435032541a9
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
>=20
> Duplicated inclusion.
>=20
> > +#include "s5pv210-aries.dtsi"
> > +
> > +/ {
> > +       model =3D "Samsung Galaxy S1 (GT-I9000) based on S5PV210";
> > +       compatible =3D "samsung,galaxys", "samsung,aries", "samsung,s5p=
v210";
> > +
> > +       chosen {
> > +               bootargs =3D "console=3DttySAC2,115200n8 root=3D/dev/mm=
cblk2p1 rw rootwait ignore_loglevel earlyprintk";
>=20
> stdout-path =3D "serial2:115200n8";
>=20
> Rest of bootargs should not be here (they are not HW dependent) unless
> you cannot configure them through bootloader?
>=20
Stock (proprietary) bootloader is little problematic for me:
=2D to access it, You need to build special cable.
=2D i wasn't able to boot any kernel newer than 2.6.35/3.0 on it, without f=
ollowing hack/patch
https://github.com/tom3q/linux/commit/af96ebcba03b607ab93bd5778301890feb038=
479.patch

I would like to leave those bootargs for now, so anyone can easly test this=
 kernel (just with that one patch),
without breaking booting existing software, so they could easly go back to =
stock software by just flashing old kernel.
Later it'll be removed because there is initial port of mainline u-boot sta=
rted for both devices
=2D currently it can be flashed to device, instead of kernel and boot kerne=
ls from onenand/sdcard.
In this way migration from old kernel to new one will be much easier to use=
rs (and won't require special tools/cables/etc).


> > +       };
> > +
> > +       nand_pwrseq: nand-pwrseq {
> > +               compatible =3D "mmc-pwrseq-simple";
> > +               reset-gpios =3D <&gpj2 7 GPIO_ACTIVE_LOW>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&massmemory_en>;
>=20
> massmemory_en is used only here, so please move it from aries.dtsi.
> The same applies to all other possible properties if they are not used
> in other DTSes including aries.
>=20
> > +       };
> > +
> > +       gpio-keys {
> > +               compatible =3D "gpio-keys";
> > +
> > +               power {
> > +                       label =3D "power";
> > +                       gpios =3D <&gph2 6 GPIO_ACTIVE_LOW>;
> > +                       linux,code =3D <KEY_POWER>;
> > +                       wakeup-source;
> > +               };
> > +
> > +               vol-down {
> > +                       label =3D "volume_down";
> > +                       gpios =3D <&gph3 1 GPIO_ACTIVE_LOW>;
> > +                       linux,code =3D <KEY_VOLUMEDOWN>;
> > +               };
> > +
> > +               vol-up {
> > +                       label =3D "volume_up";
> > +                       gpios =3D <&gph3 2 GPIO_ACTIVE_LOW>;
> > +                       linux,code =3D <KEY_VOLUMEUP>;
> > +               };
> > +
> > +               home {
> > +                       label =3D "home";
> > +                       gpios =3D <&gph3 5 GPIO_ACTIVE_LOW>;
> > +                       linux,code =3D <KEY_HOME>;
> > +                       wakeup-source;
> > +               };
> > +       };
> > +};
> > +
> > +&pinctrl0 {
> > +       massmemory_en: massmemory-en {
>=20
> Oh wait, I see massmemory_en here... so there is no need of such in aries=
=2Edtsi.
>=20
> Best regards,
> Krzysztof
>=20
> > +               samsung,pins =3D "gpj2-7";
> > +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> > +               samsung,pin-pud =3D <S3C64XX_PIN_PULL_NONE>;
> > +               samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
> > +       };
> > +};
> > +
> > +&sdhci0 {
> > +       bus-width =3D <4>;
> > +       non-removable;
> > +       mmc-pwrseq =3D <&nand_pwrseq>;
> > +       pinctrl-0 =3D <&sd0_clk &sd0_cmd &sd0_bus4>;
> > +       pinctrl-names =3D "default";
> > +       status =3D "okay";
> > +};
> > --
> > 2.7.4
> >
>=20


