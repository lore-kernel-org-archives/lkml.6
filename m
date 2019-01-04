Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AEFC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA4D218FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdWBrnnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfADQkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:40:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46713 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfADQkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:40:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so17645774ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z36PibCGIMhXSvZ2wXmkDKSfkCKPppo96OJXliwX/2M=;
        b=FdWBrnnkmFdRHVV7YLdV5OBhjA9PsG02+d0hvQtqj7mkGMsXp5shCvbWE2qyf/ki1A
         2EgDYuDJBp7uatgGJYYfPED5zU733HifSOF/qbvXbtMDd8cZbWBsTLP3XOguR3kl9UNm
         cguCYDlXhw6RqrlD/Il6fbPG6dapV94jHX9B9/SnKGeuI9p2LuwPRkKK9D3oOUEVatfZ
         tGTEYSfUWwzq/CRi4chdt8jjZ5k9rwvdS6TeSp6b8Fukm6wlOwNv5nTibrRA0YICMe8P
         rOya4Md0DVIyV6XSdh/xn/P/ZjPDXxMDiTlo8p8+UuNZA7QRsnj5AyCzMjM2i5Bcm9ve
         eg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z36PibCGIMhXSvZ2wXmkDKSfkCKPppo96OJXliwX/2M=;
        b=oyqgoLvIaYoGqQa1nSeIR7f2iUH3EEqiOZ1fC0UyTcleHcA3pgTVgv+EbxY+TH0CjP
         A3p2+x0XE0Yr5Ua0dM/2IXLyvMi/lR2G/KtTh72EXnhILp98YtlHfedB8+ONsZvR4x4r
         H9yP292NHU6DWTLdG+dDtqiUA74b9Gi3QM4Em4+EIv+Re3WfLh8xUnL91JYQS+XXpJNC
         vMVmfikde8HZWVC6QRQaoBBfQv8vgnmQRky4NZG0fR8RguaZD20y82CaHYe8eJJ2gWPG
         ha4IF5J+9Afgl2T+I29d13AKNXiX1ewzYpyNeef6UCIXZPjNsEALxNK3rNwizRWg1OuC
         GLiw==
X-Gm-Message-State: AJcUukdGDykxC+lz/WRw1uqDPWPEu+WgOOrrzr0e8ByVqLPmMEKET13T
        seF3lY/ofMTDNHE4LRtfxTmT9aEwAFI=
X-Google-Smtp-Source: ALg8bN4Sknhj9C78NfZneWPY6+lhtT+2rCcQExYD/u/VcnLGw/mkqVCiIKYEFoUiJVc/zU0hyPwq2Q==
X-Received: by 2002:a17:902:b40d:: with SMTP id x13mr52449078plr.237.1546620046358;
        Fri, 04 Jan 2019 08:40:46 -0800 (PST)
Received: from Ideapad-330S ([49.206.14.132])
        by smtp.gmail.com with ESMTPSA id o8sm115136162pfa.42.2019.01.04.08.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 08:40:45 -0800 (PST)
Date:   Fri, 4 Jan 2019 22:10:40 +0530
From:   b-ak <anur.bhargav@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM
 standby mode
Message-ID: <20190104164040.GA10873@Ideapad-330S>
References: <20190102170633.GA9724@Ideapad-330S>
 <20190103124554.GS1846@sirena.org.uk>
 <20190103193421.GB18413@Ideapad-330S>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20190103193421.GB18413@Ideapad-330S>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 04, 2019 at 01:04:21AM +0530, b-ak wrote:
> On Thu, Jan 03, 2019 at 12:45:54PM +0000, Mark Brown wrote:
> > On Wed, Jan 02, 2019 at 10:36:33PM +0530, b-ak wrote:
> > > During the bootup of the kernel, as soon as the DAPM framework kicks in
> > > it pushes the codec into standy mode.
> > > 
> > > The existing TVL320AIC32x4 codec driver doesn't prepare the clock in
> > > the probe function.
> > > This leads to an OOPS when the DAPM tries to put it into standy by calling
> > > clk_disable_unprepare()
> > > 
> > > This patch fixes that problem.
> > 
> > This isn't the best way of fixing this because it makes it look like
> > there's a missing disable in the removal process.  What would be better
> > would be to do what other drivers do and check to see what state we're
> > transitioning from before we disable the clock in set_bias_level().  See
> > drivers like wm8903.c for examples.
> 
> Hello Mark,
> 
> I will test the change and update the patch.
> 
> Thanks,
> Bhargav
> 

Hi Mark,

I have updated the patch with the changes.

Regards,
Bhargav


--0F1p//8PRICkK4MW
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-ASoC-tlv320aic32x4-Kernel-OOPS-while-entering-DAPM-s.patch"

From 5c0530506bd6d167db4f40d5af5bb82b14debad5 Mon Sep 17 00:00:00 2001
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
index e2b5a11b16d1..395f892776cd 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -822,6 +822,10 @@ static int aic32x4_set_bias_level(struct snd_soc_component *component,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
+		/* Initial cold start */
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
+			break;
+
 		/* Switch off BCLK_N Divider */
 		snd_soc_component_update_bits(component, AIC32X4_BCLKN,
 				    AIC32X4_BCLKEN, 0);
-- 
2.19.1


--0F1p//8PRICkK4MW--
