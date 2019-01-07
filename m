Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B859DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8784A2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfPtO/Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfAGRA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:00:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37032 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfAGRA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:00:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so397522pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vgTJDnzhkquR4KWnT+mh2/tvLovcFzlbrSgkpkmp5Vw=;
        b=sfPtO/GgVSYhrQvDFOKtn1ZkZQ7mrYCuD5TuHn9qu8HiJY57Rbp5J1lRFmG+Q26bnU
         r3TSr2qnJgfxMMRBM/G/XDP8GX4xoVuOiXT14wODHSjsHPhkg1v3w7a6ic78+rJe+s2z
         ihUlVkbjaXqWCJAeodtZJ8NpIktX5iZNNLY0p414Ugh9ffihkemzBXQWs2wLYtyn0kuS
         rNxttpBaNyPPR5UIG8+875t2ZAeDFF3jYhO2LYZhSMFuLPiyOEEYmSpQ4vPraF7FPKYs
         hxIzjknDc2jpg81cX6spj/V1AyqIVSpKAjNZMCLLxalthZJAAYmsQ0Bb2cT4HAbCeu25
         ll2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vgTJDnzhkquR4KWnT+mh2/tvLovcFzlbrSgkpkmp5Vw=;
        b=p0gP5nY6OJifoCBySJV+d3ofNKFH5chpQYffmM/TRn08enjXNDZ6ud0qlWJW8KlriK
         Kv7La028HQA5Arf9QWqcwIgwAmdYoPJbfT8GMDkbdZrNh33xc0Q4V7e7G8O3ysmkgOuA
         NvAQXfDW4HIssONBXvXDjgmQfWOh0gcXSWGqq83gi98cbbYnP34wC3kU5gblJl4evPQc
         9N9klcpSb+1DbxPrPviQ/S0YEjKBQ4EMXyWr28H512jK3qie62nnQfsYJ7VXokzB5/5/
         8aAAhFutSSZ1KN4nhRYeDhLTOls2A1vEF6aLiAfLjTLh3yO2S58yTx0bWQRri0/3AcOe
         8O3w==
X-Gm-Message-State: AJcUukfo2IdbcvGihvtcRMdaCccxa8g0mKpxkMvQabZp8qiqtYrvd2bw
        lz4sr2y8LeqnE0vU8j3q3nEwRH/nYk4=
X-Google-Smtp-Source: ALg8bN5q2EZb5eFMXuW3oK133vW3OS746EIVqjGlr0WwrMT4PCRH+MF5O3RXBgXvj7SRtiRzxoJ2bw==
X-Received: by 2002:a63:f658:: with SMTP id u24mr11677128pgj.267.1546880427969;
        Mon, 07 Jan 2019 09:00:27 -0800 (PST)
Received: from Ideapad-330S ([49.206.13.149])
        by smtp.gmail.com with ESMTPSA id v14sm158372608pgf.3.2019.01.07.09.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 09:00:27 -0800 (PST)
Date:   Mon, 7 Jan 2019 22:30:22 +0530
From:   b-ak <anur.bhargav@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM
 standby mode
Message-ID: <20190107170022.GA10006@Ideapad-330S>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

