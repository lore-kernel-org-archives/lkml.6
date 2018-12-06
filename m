Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF9EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69349214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMsRq722"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69349214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeLFDMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:12:14 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45911 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeLFDMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:12:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so20707183ota.12;
        Wed, 05 Dec 2018 19:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XmTNi32rN9pRyRU2vCHXFXjQ81AuBxzem2x3A9alD6Q=;
        b=hMsRq722pT6la2BjKDBF879r8WpamVWOMLculSpJOwj102dHWt/k0qHapbR8bcNZCg
         3vMv2bsSENTiQjFUrQhaBxFzmFv7uvBRo7lQXV+t4gQYkXR2JLgbE1/Hxv28N0rw72E3
         o0mKVgZpC3K7vLHQq9wmjpbY7CUECI+IM6PbWu1q3oIZ283+2QyWv4vXDTjsKgLevxuD
         0vUOfHhjZUTsxZhjyDPPLbCUbMMRGj3Ni97vOnIt0GOyw+bjAmUxXsY5Bw+CwZ7Ycy02
         ho1IhRqYYl867d/ji9SvO24wZXF+/KWkaWITToO0/L+sk3KZvpUXWP1wTU2r/twEHoOn
         Ee3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XmTNi32rN9pRyRU2vCHXFXjQ81AuBxzem2x3A9alD6Q=;
        b=ZcaqV55tKPzcr7IxOtVe+8ej7aFsLkU3n2GW0WCKqjW+Pt02y7BoXlVtsiePREJi9Q
         KJ+ydCMXG+gLFKtv0/KrLRtghJAJQY52mmVBE/IrreGgSKhExiSetX8hlRMOrIGcY/pN
         WKaNZBMFk6hVGV1hQIflLh84mE9xBNSOBFm+zj1QsjFQK9fOSrcmr99FdeivytDv4wYa
         JPAKY5rMD21bAwZ4YNSD20iqCSeg/oswUauXVJodpQ7/e5VVTpO+EVI7nszg5wuiAfV3
         JYuWzjZo8d8dqVvDwH/ZzYkBFgyRs9P7qIePHmDy78NU5a9t0JzpDH7yd4If3rllSJ2b
         K2xQ==
X-Gm-Message-State: AA+aEWZ/NHeRwPp+VayjUvaa7U5qUK+q9DTiYCm8qbv86iTzIlNi93qY
        1qvtLtxQtltHK1qINuS9KGTxdgcXC1K5AO+QdtM=
X-Google-Smtp-Source: AFSGD/VTKMNB149I5gCjAOtC5SNApDeyyxvqTkDGG910KrEPGjssz/lpez9REIv98OHPNlMYz6OfkrGUBOIP1+ZLg2o=
X-Received: by 2002:a9d:7a8c:: with SMTP id l12mr17522835otn.335.1544065932561;
 Wed, 05 Dec 2018 19:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20181204194025.2719-1-linux.amoon@gmail.com> <CAJKOXPcT-x0JWVw2CaxHzSthxbp3sDRcsa4Nc5gHYqUy98b_yw@mail.gmail.com>
 <CANAwSgSSOmTbqS4WUYZHXdB8XL5fjoiGbrh3unxufQ0gZXBPkQ@mail.gmail.com> <CAJKOXPdvk0Kip-RrFF3cwTpuXnFFL2PEi1U57=vMzNY7HVjTGw@mail.gmail.com>
In-Reply-To: <CAJKOXPdvk0Kip-RrFF3cwTpuXnFFL2PEi1U57=vMzNY7HVjTGw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 6 Dec 2018 08:42:00 +0530
Message-ID: <CANAwSgQPcfAjyZEXfkWc6E4+N_k4nC3EPs96BpFkaTuQQ3FC6Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, 5 Dec 2018 at 21:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 5 Dec 2018 at 17:11, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Krzysztof,
> >
> > Thanks for your review.
> > .
> > On Wed, 5 Dec 2018 at 19:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Tue, 4 Dec 2018 at 20:40, Anand Moon <linux.amoon@gmail.com> wrote:
> > > >
> > > > Add suspend-to-mem node to regulator core to be enabled or disabled
> > > > during system suspend and also support changing the regulator operating
> > > > mode during runtime and when the system enter sleep mode.
> > > >
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > Tested on Odroid U3+
> > > > ---
> > > >  .../boot/dts/exynos4412-odroid-common.dtsi    | 72 +++++++++++++++++++
> > > >  1 file changed, 72 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > index 2caa3132f34e..837713a2ec3b 100644
> > > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > @@ -285,6 +285,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > >
> > > Driver does not support suspend_enable so this will be noop. We could
> > > add this for DT-correctness (and full description of HW) but then I
> > > need explanation why this regulator has to stay on during suspend.
> > >
> >
> > Well I tried to study the suspend/resume feature from
> > *arch/arm/boot/dts/exynos4412-midas.dtsi*
> > and them I tried to apply the same with this on Odroid-U3 boards and
> > test these changes.
>
> Midas DTSI clearly has bugs then.
>
> >
> > > >                         };
> > > >
> > > >                         ldo3_reg: LDO3 {
> > > > @@ -292,6 +295,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > >
> > > The same but with suspend_disable.
> > >
> > > I am not saying that these are wrong but I would be happy to see
> > > explanations why you chosen these particular properties.
> > >
> >
> > Well I was not aware on the regulator-always-on cannot be set to off
> > in suspend mode.
> > Will drop this in the future patch where regulator-always-on; is set.
> >
> > > >                         };
> > > >
> > > >                         ldo4_reg: LDO4 {
> > > > @@ -299,6 +305,9 @@
> > > >                                 regulator-min-microvolt = <2800000>;
> > > >                                 regulator-max-microvolt = <2800000>;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo5_reg: LDO5 {
> > > > @@ -307,6 +316,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo6_reg: LDO6 {
> > > > @@ -314,6 +326,9 @@
> > > >                                 regulator-min-microvolt = <1000000>;
> > > >                                 regulator-max-microvolt = <1000000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo7_reg: LDO7 {
> > > > @@ -321,18 +336,27 @@
> > > >                                 regulator-min-microvolt = <1000000>;
> > > >                                 regulator-max-microvolt = <1000000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo8_reg: LDO8 {
> > > >                                 regulator-name = "VDD10_HDMI_1.0V";
> > > >                                 regulator-min-microvolt = <1000000>;
> > > >                                 regulator-max-microvolt = <1000000>;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo10_reg: LDO10 {
> > > >                                 regulator-name = "VDDQ_MIPIHSI_1.8V";
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo11_reg: LDO11 {
> > > > @@ -340,6 +364,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo12_reg: LDO12 {
> > > > @@ -348,6 +375,9 @@
> > > >                                 regulator-max-microvolt = <3300000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo13_reg: LDO13 {
> > > > @@ -356,6 +386,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo14_reg: LDO14 {
> > > > @@ -364,6 +397,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo15_reg: LDO15 {
> > > > @@ -372,6 +408,9 @@
> > > >                                 regulator-max-microvolt = <1000000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo16_reg: LDO16 {
> > > > @@ -380,6 +419,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo20_reg: LDO20 {
> > > > @@ -387,6 +429,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo21_reg: LDO21 {
> > > > @@ -394,6 +439,9 @@
> > > >                                 regulator-min-microvolt = <2800000>;
> > > >                                 regulator-max-microvolt = <2800000>;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > >
> > > That's unusual setting... enabled in suspend but not necessarily
> > > during work (no always-on).
> > >
> >
> > I kept the regulator required for emmc/sd card in
> > regulator-on-in-suspend in suspend mode.
> >
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo22_reg: LDO22 {
> > > > @@ -411,6 +459,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         buck1_reg: BUCK1 {
> > > > @@ -419,6 +470,9 @@
> > > >                                 regulator-max-microvolt = <1100000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > >
> > > This is seriously wrong so I have doubts whether you tested the
> > > changes or you know what is happening with them. If you turn off
> > > memory bus regulator off, how the memory will work in
> > > Suspend-to-Memory mode?
> > >
> >
> > Well I did not find any issue in my testing but I might be wrong.
> > Ok I will drop this changes in the next version of the patch where
> > regulator-always-on is set.
>
> It worked fine because regulator-off-in-suspend is noop for buck1 but
> it is clearly wrong from logical point of view. Do you think that
> memory should be off in Suspend to RAM?
>
My bad setting this for buck setting I will drop this in the future patch.
> > > >                         };
> > > >
> > > >                         buck2_reg: BUCK2 {
> > > > @@ -427,6 +481,9 @@
> > > >                                 regulator-max-microvolt = <1350000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         buck3_reg: BUCK3 {
> > > > @@ -435,6 +492,9 @@
> > > >                                 regulator-max-microvolt = <1050000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > >
> > > Looks suspicious as well.
> >
> > Ok I will drop this changes in the next version of the patch where
> > regulator-always-on is set.
> >
> > >
> > > Best regards,
> > > Krzysztof
> > >
> >
> > Well I have tested this patch as following
> > with only one issue, before enable suspend number of On-line cpu is 4
> > after resume number of On-line cpu is 1.
>
> If before your change number of resumed CPUs was 4, then you
> apparently break some things.
>
> Best regards,
> Krzysztof

Ok I will double check that I do not break any feature.

Best Regards
-Anand
