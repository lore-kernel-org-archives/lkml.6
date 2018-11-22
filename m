Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92892C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554FC206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554FC206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437816AbeKWCWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:22:04 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39742 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391763AbeKWCWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:22:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so8052343edt.6;
        Thu, 22 Nov 2018 07:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qw/ymTo2L9i7ZLFLYgRmvysutDL1dsbO+O0f/0AEZnc=;
        b=pC55ndwdEz6lV6/EE+IBzDt3R63N8sN6BLrUdsgMimZeWgIOasLskA6SmJk5Z4gyst
         CEs0PR/gqW9e1axRD3o64Y/BSdl0Kw/1q8D0bk0qLbhfipm/pBEfMR8xzvhk35tLuYnI
         VWjC5IetwE7wQ1A7mjeimowEpYmKrWndRVKlzcBb9tMUigM2Rdr8a4I3dA+6skCuUfmI
         1n/0iMgxwNl4BnxjlnBG5v3RCr6iXcJpPmrsBRXTRoGN12mC40Gw0+8i5/ofwEZpNs9z
         42bInNz6UHFxM2860Sz1jRUHYBPmii41XDySNiluyRehkZaa3z77id39xSDaPZoiTTc+
         Yy7w==
X-Gm-Message-State: AGRZ1gKljdTfm11snNedCbZZDz6XNI2LMc2ATwsRNe90dOe/Um9CPmWh
        cSM9+689wwuhSQcXUYpeqNLFyrqocOw=
X-Google-Smtp-Source: AJdET5dGeUdkRORvxm1oPZ4VHrUXeOcRjUVkBftc2TouXPtBiiMcn1r53jK5uzHv5ZXm2kUv/+2xHg==
X-Received: by 2002:a17:906:838e:: with SMTP id p14-v6mr8395930ejx.94.1542901329352;
        Thu, 22 Nov 2018 07:42:09 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id e35sm8516569eda.13.2018.11.22.07.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:42:09 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id v6so9677758wrr.12;
        Thu, 22 Nov 2018 07:42:08 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr9841277wrv.87.1542901328306;
 Thu, 22 Nov 2018 07:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20181122102325.29495-1-wens@csie.org> <20181122102325.29495-2-wens@csie.org>
 <20181122153241.lzrwhkewg5q4hy2c@flea>
In-Reply-To: <20181122153241.lzrwhkewg5q4hy2c@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 22 Nov 2018 23:41:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v64-Wszg9m8+jCPWzYYRQduwpod2P0UdrFdhTLvAe3paPA@mail.gmail.com>
Message-ID: <CAGb2v64-Wszg9m8+jCPWzYYRQduwpod2P0UdrFdhTLvAe3paPA@mail.gmail.com>
Subject: Re: [PATCH v9 1/8] ASoC: dt-bindings: sun50i-codec-analog: Add
 headphone amp regulator supply
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 11:33 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Thu, Nov 22, 2018 at 06:23:18PM +0800, Chen-Yu Tsai wrote:
> > On the Allwinner A64 SoC, the audio codec has a built-in headphone
> > amplifier. This amplifier has a power supply separate from the rest of
> > the analog audio circuitry.
> >
> > Add a regulator supply property to handle this.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
> > index 4f8ad0e04d20..056a098495cc 100644
> > --- a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
> > +++ b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
> > @@ -4,9 +4,11 @@ Required properties:
> >  - compatible: must be one of the following compatibles:
> >               - "allwinner,sun50i-a64-codec-analog"
> >  - reg: must contain the registers location and length
> > +- cpvdd-supply: Regulator supply for the headphone amplifier
>
> I guess we should make this optional, since even if it's missing, it's
> going to create a dummy regulator. and that allows to have backward
> compatibility.
>
> For the rest of the series,
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

This one (not sun8i-codec-analog) is new for the next release, so there's
no backward compatibility to consider. Plus none of the device tree changes
for A64 have been merged.

ChenYu
