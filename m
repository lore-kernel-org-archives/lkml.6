Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D248AC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9109521874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWWzUxdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbfAEEqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 23:46:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37218 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfAEEqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 23:46:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so18317133pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 20:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AN04LEO7C3pTM+9WOgkpT0uFmrzyPpBA8MxUgLTgUfg=;
        b=gWWzUxdL0X9ZiV7JBgHBnWq8/oRJh1aPWTJkRchkBpw74g9bSzdUGeMf3cHlIEd5PM
         W0QpDrMsP11VdZzXuySK4u5UnjdVfPsICQQWtuXauunlXUdu85dkNo/iuetfKLz4pVBr
         K0iuN9taaf93x4uL8bG2u1Yk2IgmAWAP5IbwM77Ka303wAxLf8BHtvDhoUmQfdAvf6vh
         L0FojE8BAYJjAfo7BcZln6puIcQwDpy7mpW8YhO9IsokqmyXpk5agO9g3Ja0QG8HdMsC
         UHl4w1Ytxv30fRSGZ3bOzI7ux8TVScfg9vo94D6B2YcHsHQGvj0wHWJ8vcQlcJHmuYyT
         XeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AN04LEO7C3pTM+9WOgkpT0uFmrzyPpBA8MxUgLTgUfg=;
        b=Vq8xayaQHtQx/XaJM4PhphQTIcGnITcj+tAZqcP5865kr/j+z4Tc3Xq9fryzjhPhf0
         vRIRWaWGmBuF/QGpYllL9to1SJzIMuwvygVJEPdO/l0zaXF5NcTbqaFaCI4Ue5pUODwW
         HwYAQYVyvfgDUou9TWC7bInhONvjI8ONNcLXuii6vKz7MKXErn9TzPlbCjYJ4FJZ0GJO
         5bDRhJRY9nJOMoOsy3ix9TVAP/k4jlLX+/97/tPQajPlo2KphTN7/zuNIJ76xfoW1MKA
         ONpY6dMKuXQRWhw2+G+yVNopO2AHRwJxMMq/MOGuRTrmpykOO5OztBzTEuv/hyS/7G6w
         c6GQ==
X-Gm-Message-State: AJcUukfEGnBUr8bvXU7g4JEhXGf2PGmKX7gbolTqosyxlBFrPPupatFb
        vr2T2DOrF1NPo9JMI7MVi4g=
X-Google-Smtp-Source: ALg8bN5bJlT9akWmSILYHZqvr1cUGlB9TfL0iJyemUy4Jn7mWSNnwzPZ3xpZohn55L1l/yHZ/V75bw==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr22808163pgb.56.1546663589750;
        Fri, 04 Jan 2019 20:46:29 -0800 (PST)
Received: from Ideapad-330S ([49.206.14.132])
        by smtp.gmail.com with ESMTPSA id s84sm124184497pfi.15.2019.01.04.20.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 20:46:28 -0800 (PST)
Date:   Sat, 5 Jan 2019 10:16:22 +0530
From:   b-ak <anur.bhargav@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM
 standby mode
Message-ID: <20190105044622.GA14481@Ideapad-330S>
References: <20190102170633.GA9724@Ideapad-330S>
 <20190103124554.GS1846@sirena.org.uk>
 <20190103193421.GB18413@Ideapad-330S>
 <20190104164040.GA10873@Ideapad-330S>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20190104164040.GA10873@Ideapad-330S>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 04, 2019 at 10:10:40PM +0530, b-ak wrote:
> On Fri, Jan 04, 2019 at 01:04:21AM +0530, b-ak wrote:
> > On Thu, Jan 03, 2019 at 12:45:54PM +0000, Mark Brown wrote:
> > > On Wed, Jan 02, 2019 at 10:36:33PM +0530, b-ak wrote:
> > > > During the bootup of the kernel, as soon as the DAPM framework kicks in
> > > > it pushes the codec into standy mode.
> > > > 
> > > > The existing TVL320AIC32x4 codec driver doesn't prepare the clock in
> > > > the probe function.
> > > > This leads to an OOPS when the DAPM tries to put it into standy by calling
> > > > clk_disable_unprepare()
> > > > 
> > > > This patch fixes that problem.
> > > 
> > > This isn't the best way of fixing this because it makes it look like
> > > there's a missing disable in the removal process.  What would be better
> > > would be to do what other drivers do and check to see what state we're
> > > transitioning from before we disable the clock in set_bias_level().  See
> > > drivers like wm8903.c for examples.
> > 
> > Hello Mark,
> > 
> > I will test the change and update the patch.
> > 
> > Thanks,
> > Bhargav
> > 
> 
> Hi Mark,
> 
> I have updated the patch with the changes.
> 
> Regards,
> Bhargav
> 

Hi Mark,

Fixed the build error.

Thanks,
Bhargav


--SLDf9lqlvOQaIe6s
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-ASoC-tlv320aic32x4-Kernel-OOPS-while-entering-DAPM-s.patch"

From 5854c8b48e6c2367d391cc760939538ac8f624f7 Mon Sep 17 00:00:00 2001
From: b-ak <anur.bhargav@gmail.com>
Date: Tue, 1 Jan 2019 22:52:40 +0530
Subject: [PATCH] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM standby
 mode

During the bootup of the kernel, the DAPM bias level is in the OFF
state. As soon as the DAPM framework kicks in it pushes the codec
into STANDBY state.

The probe function doesn't prepare the clock, and STANDBY state
does a clk_disable_unprepare() without checking the previous state.
This leads to an OOPS.

Not transitioning from an OFF state to the STANDBY state fixes the
problem.

Signed-off-by: b-ak <anur.bhargav@gmail.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e2b5a11b16d1..f03195d2ab2e 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -822,6 +822,10 @@ static int aic32x4_set_bias_level(struct snd_soc_component *component,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
+		/* Initial cold start */
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF)
+			break;
+
 		/* Switch off BCLK_N Divider */
 		snd_soc_component_update_bits(component, AIC32X4_BCLKN,
 				    AIC32X4_BCLKEN, 0);
-- 
2.19.1


--SLDf9lqlvOQaIe6s--
