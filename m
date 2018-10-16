Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DB9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C66F2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc6AWTxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C66F2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeJPWf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeJPWf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:35:26 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C03A4208B3;
        Tue, 16 Oct 2018 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539701078;
        bh=4gaieX353ARNS4j7F496jnpg38O9WhEBCQBcU1ftDMU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tc6AWTxnl2Jgm8LjVTXIxixM8+qJwHdtu2xTakvEWd/WH0hubWNVSxfm2V8fo0Ho8
         gC3k1kR/b7BEWkgQ1YCe84Zu4NFJpD4XV9vgNbatpU9yFkFR+Nv+Io10UsW8jRkt/L
         DH0ds6+IZfW216xZ8ysUrBW1KD/+2Z56v3HsL54Q=
Received: by mail-qk1-f172.google.com with SMTP id p6-v6so14297735qkg.1;
        Tue, 16 Oct 2018 07:44:38 -0700 (PDT)
X-Gm-Message-State: ABuFfohHy+h4qL47XAX4FfHmqv4hNCeKa9Dcs2qLUh2Y5OV37yveZnUG
        o2t0sSvb7g2EMZSynX08NDrU3lu9v2pKarLhDg==
X-Google-Smtp-Source: ACcGV60UeVZaHOAjpZVx869r+1noWVYhA9BHqX7AxSgtfyuxMlnydqnfsuaMkdcecjjR8MsjJpFo+dleRFhFapx1Moc=
X-Received: by 2002:a37:12d1:: with SMTP id 78-v6mr20860146qks.147.1539701077916;
 Tue, 16 Oct 2018 07:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
 <1537866192-12320-9-git-send-email-daniel.lezcano@linaro.org>
 <20181015162835.GA20955@bogus> <d2cb2fa0-b579-205c-1777-308da075b3fd@linaro.org>
In-Reply-To: <d2cb2fa0-b579-205c-1777-308da075b3fd@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 16 Oct 2018 09:44:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJCJbOxP_ODJ_JTRCvrFpSCSxa-X1LCr+1-pY_ApTz_1Q@mail.gmail.com>
Message-ID: <CAL_JsqJCJbOxP_ODJ_JTRCvrFpSCSxa-X1LCr+1-pY_ApTz_1Q@mail.gmail.com>
Subject: Re: [PATCH 08/14] ARM64: dts: hisilicon: Add tsensor interrupt name
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 1:01 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rob,
>
> thanks for the review.
>
> On 15/10/2018 18:28, Rob Herring wrote:
> > On Tue, Sep 25, 2018 at 11:03:06AM +0200, Daniel Lezcano wrote:
> >> Add the interrupt names for the sensors, so the code can rely on them
> >> instead of dealing with index which are prone to error.

[...]

> >> +            interrupt-names =3D "tsensor_intr";
> >
> > That name seems pretty pointless.
> >
> >>              clocks =3D <&sys_ctrl HI6220_TSENSOR_CLK>;
> >>              clock-names =3D "thermal_clk";
> >>              #thermal-sensor-cells =3D <1>;
> >> @@ -28,5 +30,6 @@ for Hi3660:
> >>              compatible =3D "hisilicon,hi3660-tsensor";
> >>              reg =3D <0x0 0xfff30000 0x0 0x1000>;
> >>              interrupts =3D <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> >> +            interrupt-names =3D "tsensor_a73";
> >
> > Just 'a73' is sufficient.
>
> This is the name defined in the board documentation to give a name to
> the interrupt when requesting it. This one appears in /proc/interrupts.
>
> I can replace the 'tsensor_intr' by 'tsensor', but if 'tsensor_a73' is
> replaced by 'a73' that may looks odd in /proc/interrupts to see an
> interrupts line with the 'a73' name.

Sounds like a Linux problem, not DT...

The thing is that any *-names property is supposed to be a local to
block name. For example, a UART may have a TX irq. It's local name is
just "TX IRQ", but then upstream at the interrupt controller it may be
"UART1 TX IRQ". If you have multiple instances, the local names are
the same.

If we lose the node name from /proc/interrupts when interrupt-names is
used, then we should fix that.

>
> However this is the preparation for the multiple sensors support so we
> will have more interrupt names.
>
> Is it possible to keep these names ?
>
>  - tsensor
>  - tsensor_a73
>  - tsensor_a57
>  - tsensor_gpu
>
>
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
