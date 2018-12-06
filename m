Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_RHS_DOB autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB27C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D845820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FmVdNl4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D845820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeLFQSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:18:51 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36530 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFQSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:18:48 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so2322218itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwFF5RodQzcPhlF5Fs1Z1R7kCHD7s0M2IolrVWTUV8I=;
        b=FmVdNl4oqZcQo3G02EC703bO1c5yl219Ex2MeU9DfRkMpnCThTn0KlXCubxyNCcKlD
         IJZ6g0yCpXFp1hT54VUxi9LRM2X4/BytQp2NtNAq7JMgyUVGsKOiyMzre1Q7M4d9WYBI
         1d6UN3TP6XUxRioNV5ikcMIIcihRaBWanx7cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwFF5RodQzcPhlF5Fs1Z1R7kCHD7s0M2IolrVWTUV8I=;
        b=rj/333kcItZkm8KgzgBlp1vJEilTz2+j2m1+y3P9b8hn7f9iRvMWFx1mE9nWf8ColR
         N/D2uwrDMGUmN3IlTbFXZ+c9XkmeqBUsR4czESaLClr0ySw4MPQxrmviWZnkKvdMzz8W
         iqnp2sG011R6+xQEjXy/C06eGppSJ7/hzBX4ExOjboscUTqtPi/bhRUtEe3agG+sk/Y7
         39VvIetYPUcy2i9N93xzakc8sy5C/yx4uYMzutsHtRuWa0C4iGuKRbWtJ18tLKgNrvGQ
         O5ASr6DHOPNZRlERp8uv5Po5rJHTdOrYHSxlD9FAEDR6lXYhj7qWNLu9IvFrfxIPbn9q
         UoJQ==
X-Gm-Message-State: AA+aEWZru1xLvyNzO5C6U0JvAEnalFl0UhZrjH1VAy6qq8Ok1Ro1uIQR
        Ls5AcxcGanJ+1heRAR+ERpDIp5/a4IG/tAQ3VygPbw==
X-Google-Smtp-Source: AFSGD/Vktru4QIRmr0qQj22J+Oc+HyD5QK50oyvY4sFLYB8EKWkVpIU70ShDOaifv/dnLCkA5Ggmjhr3DjuMw0sAk2Q=
X-Received: by 2002:a24:5411:: with SMTP id t17mr18520001ita.32.1544113127612;
 Thu, 06 Dec 2018 08:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
 <20181206132306.11843-3-jagan@amarulasolutions.com> <20181206153532.6c756gccmpuj4wdw@flea>
In-Reply-To: <20181206153532.6c756gccmpuj4wdw@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 6 Dec 2018 21:48:34 +0530
Message-ID: <CAMty3ZB0rvZ8kwcOmXT2oLUqDLc5w8VBshMQirXfUAVG=042kw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: allwinner: a64: Add pinmux setting for
 CSI MCLK on PE1
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 9:05 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Dec 06, 2018 at 06:53:06PM +0530, Jagan Teki wrote:
> > Some camera modules have the SoC feeding a master clock to the sensor
> > instead of having a standalone crystal. This clock signal is generated
> > from the clock control unit and output from the CSI MCLK function of
> > pin PE1.
> >
> > Add a pinmux setting for it for camera sensors to reference.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - new patch
> >
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > index d7ab0006ebce..902b5238f1dd 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -538,6 +538,11 @@
> >                               function = "csi0";
> >                       };
> >
> > +                     csi_mclk_pin: csi-mclk {
> > +                             pins = "PE1";
> > +                             function = "csi0";
> > +                     };
> > +
>
> We're not merging nodes that have no users.

Yes, v1 [1] has a consumer for this. Since it's under discussion about
PE group supply, opendrain I hold it. will send once the discussion
done, I even tested on top-of your ov5640 changes.

[1] https://patchwork.kernel.org/patch/10709077/
