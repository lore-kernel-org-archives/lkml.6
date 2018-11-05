Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319E0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA77320827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMWC2NB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA77320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbeKEXPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:15:52 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46321 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387396AbeKEXPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:15:52 -0500
Received: by mail-yw1-f66.google.com with SMTP id j202-v6so3638105ywa.13;
        Mon, 05 Nov 2018 05:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/IbAU/nV1gxZm6JITmKDX5GvBjOPYPRF6W1nWB7tma8=;
        b=hMWC2NB9ULCLoalg8XAXCvhT3A7kAlKs7qgYdL7dkegrZiycRJ5tYImXmUetOkdfs1
         YR1L73+hMEy0ocaPrWanQY75Z61HetEZy6uQ0u+cwMCzrZud8dGd4RET5VULiZ2b4JNI
         G0O+4N8ORFeO9qEiEVCrdpDSEi7/f6nIN5XNBf1IsM+vvAisnSuU+P3wNyRq+uPmPKyo
         kGynOTGL4n6RX0eu8wKJGgv69mcy2nTFpLewcCYhySLgzIl6SgJduJL4XW28qmVIXMUN
         Ttr1LlfTqipthdaylvprjyB8RdyyDKoz6ICHOGU3vcpi14t3+wEk+ByZeG6ZGAhvqv38
         3RQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/IbAU/nV1gxZm6JITmKDX5GvBjOPYPRF6W1nWB7tma8=;
        b=tJZMUeJqio83WalsQofQQzQI9EegEWnnBTrd2H/h93swKlDIZVNFWuVo+KaT0/4ok0
         3+IYmm2/Tbs3insTESRMTsbvYFDXbqpnHR/qBzBQQmRM9ajegAhRtYs1atzeDVWBSr2F
         PgkUUR6mQfZFUz7Z00xRSOJ13PT/jcxBH2gF/nc06IFpomehfoPMLr7UD3ZvhLnqwld/
         wNYDezXYk53wFFKDS4JPbYLMrT/mMtYtVN8i1ErLkcM1V0qktGZ+IbwYB7bIr18mDFCj
         ZaljHvFCpijvEfP3Rw03ghMw171liX3ZL6zgkk8VmkQh0wkEC3v411LgILX2cbjhNkAB
         F2uQ==
X-Gm-Message-State: AGRZ1gKN/XAi34uEnrMEiIpvRGFAyga9BTnxLJV0eAPvrheydAFZWHWt
        8pcn8s3Nqxh8qZ+t0xrJfV4M1/8jAVyFMq3sK4cbI/QUFGw=
X-Google-Smtp-Source: AJdET5cJvbqgtM2bwzXU2FZuCVaWIRFqJth/LJruCzaOeNjjYfI6y5fR/Gxp4NIAzd2rZOlsNlYJ5kuAb2UnnXzNzMU=
X-Received: by 2002:a81:7bc1:: with SMTP id w184-v6mr20659949ywc.345.1541426159710;
 Mon, 05 Nov 2018 05:55:59 -0800 (PST)
MIME-Version: 1.0
References: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
 <20181104144614.GJ26016@tiger> <0298f7ec-fbff-8edb-92bb-70a736ddaf25@mentor.com>
In-Reply-To: <0298f7ec-fbff-8edb-92bb-70a736ddaf25@mentor.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 5 Nov 2018 14:55:48 +0100
Message-ID: <CAJiuCcde0n5VGnqsXgnevKEk9KkPHf=_JMo7yyBBvX-PF_v2-A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: i.MX25: add the clocks for the EPIT blocks
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, martin@kaiser.cx,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 5 Nov 2018 at 09:58, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
>
> Adding Cl=C3=A9ment.
>
> On 11/04/2018 04:46 PM, Shawn Guo wrote:
> > On Thu, Nov 01, 2018 at 06:32:47PM +0100, Martin Kaiser wrote:
> >> The i.MX25 contains two EPIT (Enhanced Periodic Interrupt Timer)
> >> function blocks. Add their ipg and per clocks to the device tree.
> >>
> >> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> >
> > Are these EPIT devices actually used in upstream kernel, or just
> > somewhere else?
>
> Cl=C3=A9ment wrote a good driver, which has already passed a series of re=
views,
> but this clocks add-on is actually missing.
>
> Cl=C3=A9ment, can you please add clock-names property and the correspondi=
ng
> functional change to your driver? Thank you in advance.

I'm converting it with the new timer-of framework, will check for
adding both clocks.

New patch should come this week I hope.

Regards,
Clement>
> --
> Best wishes,
> Vladimir
>
> >> ---
> >>
> >> I tried to make this similar to gpt1 and gpt2.
> >>
> >>  arch/arm/boot/dts/imx25.dtsi | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dt=
si
> >> index b25309d26ea5..e80101847aff 100644
> >> --- a/arch/arm/boot/dts/imx25.dtsi
> >> +++ b/arch/arm/boot/dts/imx25.dtsi
> >> @@ -388,12 +388,16 @@
> >>                      epit1: timer@53f94000 {
> >>                              compatible =3D "fsl,imx25-epit";
> >>                              reg =3D <0x53f94000 0x4000>;
> >> +                            clocks =3D <&clks 83>, <&clks 43>;
> >> +                            clock-names =3D "ipg", "per";
> >>                              interrupts =3D <28>;
> >>                      };
> >>
> >>                      epit2: timer@53f98000 {
> >>                              compatible =3D "fsl,imx25-epit";
> >>                              reg =3D <0x53f98000 0x4000>;
> >> +                            clocks =3D <&clks 84>, <&clks 43>;
> >> +                            clock-names =3D "ipg", "per";
> >>                              interrupts =3D <27>;
> >>                      };
> >>
> >> --
> >> 2.1.4
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
