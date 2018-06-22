Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31401C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFC723F30
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2LbP46og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFC723F30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeFVIvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbeFVIvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:51:31 -0400
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com [209.85.128.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3123023F30;
        Fri, 22 Jun 2018 08:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529657490;
        bh=9Mpn+LKUO0/8odiAv8dPlm5czmr3P5/qhoPsPKJQP14=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=2LbP46og3de598f5gqDLPIFntNxIRHXVuvl3oX1+89gIW4eWasCgTHWE/4p1x7PFH
         xAk9tyG0ZKViCpxXXtaOBLQj05Z7QWrTfZare1RZPFx+Qoj5zM9uSGt/TC8cP+dx8A
         Jjfx5dg5tVUhZh7EvF4bM3AxXYNrLZq1SWlVVLp4=
Received: by mail-wr0-f176.google.com with SMTP id l14-v6so807202wrq.13;
        Fri, 22 Jun 2018 01:51:30 -0700 (PDT)
X-Gm-Message-State: APt69E34UM7Bou6msyup/ZT2xbadfTTzhDMW8qdDZRolbXwY3hOVkMoS
        0fmokGnyiePyKnI+sVhelslZj/3Oz3pYGRth6hE=
X-Google-Smtp-Source: AAOMgpdavHQyk/48V93uHR1UkSCxMecm02cVgzveie2hwpF4EXH0dI7s3EsO8IWmZM2FmSM82pUkwbbqudP3nzvGuWE=
X-Received: by 2002:adf:9dc9:: with SMTP id q9-v6mr822902wre.12.1529657488694;
 Fri, 22 Jun 2018 01:51:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 01:51:28
 -0700 (PDT)
In-Reply-To: <1851346.itd6mG8ZId@acerlaptop>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1529608199-5583-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPf8cpJ-pivG9j1sCM3aB_-i2n73MoeQKOd4oXxz976EVw@mail.gmail.com> <1851346.itd6mG8ZId@acerlaptop>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 22 Jun 2018 10:51:28 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc+u5eazcn3sO94gjaAtWXzJWW5YUFbGsE5sjXzkfd2Dw@mail.gmail.com>
Message-ID: <CAJKOXPc+u5eazcn3sO94gjaAtWXzJWW5YUFbGsE5sjXzkfd2Dw@mail.gmail.com>
Subject: Re: [PATCH 3/7] ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy
 S phone.
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 June 2018 at 10:42, Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com=
> wrote:
> On Friday, June 22, 2018 9:49:42 AM CEST Krzysztof Kozlowski wrote:
>> On 21 June 2018 at 21:09, Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.=
com> wrote:
>> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
>>
>> Please add commit message. This can be something as simple as "Add
>> Samsung Galaxy S DTS which is a commercial phone based on Aries
>> family." or something more (e.g. describe what is working).
>>
>> > ---
>> >  arch/arm/boot/dts/Makefile            |  1 +
>> >  arch/arm/boot/dts/s5pv210-galaxys.dts | 72 ++++++++++++++++++++++++++=
+++++++++
>> >  2 files changed, 73 insertions(+)
>> >  create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts
>> >
>> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> > index 7e2424957809..522ebdca1d3d 100644
>> > --- a/arch/arm/boot/dts/Makefile
>> > +++ b/arch/arm/boot/dts/Makefile
>> > @@ -846,6 +846,7 @@ dtb-$(CONFIG_ARCH_S3C64XX) +=3D \
>> >         s3c6410-smdk6410.dtb
>> >  dtb-$(CONFIG_ARCH_S5PV210) +=3D \
>> >         s5pv210-aquila.dtb \
>> > +       s5pv210-galaxys.dtb \
>> >         s5pv210-goni.dtb \
>> >         s5pv210-smdkc110.dtb \
>> >         s5pv210-smdkv210.dtb \
>> > diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts=
/s5pv210-galaxys.dts
>> > new file mode 100644
>> > index 000000000000..d435032541a9
>> > --- /dev/null
>> > +++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
>> > @@ -0,0 +1,72 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +
>> > +/dts-v1/;
>> > +#include <dt-bindings/gpio/gpio.h>
>> > +#include <dt-bindings/interrupt-controller/irq.h>
>> > +#include <dt-bindings/input/input.h>
>> > +#include <dt-bindings/interrupt-controller/irq.h>
>>
>> Duplicated inclusion.
>>
>> > +#include "s5pv210-aries.dtsi"
>> > +
>> > +/ {
>> > +       model =3D "Samsung Galaxy S1 (GT-I9000) based on S5PV210";
>> > +       compatible =3D "samsung,galaxys", "samsung,aries", "samsung,s5=
pv210";
>> > +
>> > +       chosen {
>> > +               bootargs =3D "console=3DttySAC2,115200n8 root=3D/dev/m=
mcblk2p1 rw rootwait ignore_loglevel earlyprintk";
>>
>> stdout-path =3D "serial2:115200n8";
>>
>> Rest of bootargs should not be here (they are not HW dependent) unless
>> you cannot configure them through bootloader?
>>
> Stock (proprietary) bootloader is little problematic for me:
> - to access it, You need to build special cable.
> - i wasn't able to boot any kernel newer than 2.6.35/3.0 on it, without f=
ollowing hack/patch
> https://github.com/tom3q/linux/commit/af96ebcba03b607ab93bd5778301890feb0=
38479.patch
>
> I would like to leave those bootargs for now, so anyone can easly test th=
is kernel (just with that one patch),
> without breaking booting existing software, so they could easly go back t=
o stock software by just flashing old kernel.
> Later it'll be removed because there is initial port of mainline u-boot s=
tarted for both devices
> - currently it can be flashed to device, instead of kernel and boot kerne=
ls from onenand/sdcard.
> In this way migration from old kernel to new one will be much easier to u=
sers (and won't require special tools/cables/etc).

OK, then move the console to stdout-path and leave the rest with a
comment explaining why they are useful.

Best regards,
Krzysztof
