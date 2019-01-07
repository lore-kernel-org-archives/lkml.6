Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8514FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5978C206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxXWO1pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfAGRpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:45:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43735 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfAGRpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:45:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so436424pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vgTJDnzhkquR4KWnT+mh2/tvLovcFzlbrSgkpkmp5Vw=;
        b=lxXWO1pFR4AjdnPR8/C6RLeUGUrOHueZ3gpds2JnMSD7+2geLXED/Ak43RMBqrMMPM
         /Whowas1bSCcWeu3Q09WBD6W6Yen/unlfSgvkk5lZQ1AqILW/2HqUM03dz9PHD/XeIPW
         xQnM40ukMRUL8hYO4i8CrjDyewo+Ww2TiLp1/Vsk7NEJpSuNhycaHyMU6lt4glcnM8hy
         pCFYUxc7TZ5TJl8lIt0PXWH5FmcJCVjaUQqMtxaUDmZPxggr0uVOc4wZiuZifclyF61W
         xPWY6G9NWHYj4b8fIWlRH94UjNXp4y3RaJV9MS7+SZ1JbWz+hrqa2v+UQmF4Cmzg9Isz
         d+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vgTJDnzhkquR4KWnT+mh2/tvLovcFzlbrSgkpkmp5Vw=;
        b=TJrloCWuylt/clI5b+nKivM8ClM+tam/GlWXkPECUHlYxh+BBEJcRksPg/PTpo2ZFi
         DFNwwp29GPVGs1I80T2YQZuf8RZCxphXt+M7y68zh+XjrhvD0YgUXIQyNvkUX67F0lKa
         tu8VMyNk2A1mxFd+raztWX5ZSGSlArhi6xQhsizSaJv/Q3DqZ5r4GB43vvvxfoQqgCnw
         KqIw3l4TaZcG408MDilRWb2wohRDL+b6Gld/T8+xfvQl90Z+BsyfnpxB/xsOBAksS9LU
         W8axb0hIXH96ouGN81Bi2CvC67GE40lBcfQaKgRFUnqdHw5aB5gE1oAvBuDs++oMBfDB
         32bQ==
X-Gm-Message-State: AJcUukeR4UB4ygpq1KTUIIBUZEf9E8NkVLs1olhFCCEEPAqDRXnmDM1Y
        jXIkmbwEvbSsBfUt4CKjqD0=
X-Google-Smtp-Source: ALg8bN6gl4BJDtQqIRcpbGYm5WMI+2fHxCcgrsjzhLbCPuxDBEtnLcdi2KsVpA/LN0b0egp5JdeWhg==
X-Received: by 2002:a63:6ecf:: with SMTP id j198mr11913264pgc.3.1546883142332;
        Mon, 07 Jan 2019 09:45:42 -0800 (PST)
Received: from localhost.localdomain ([49.206.13.149])
        by smtp.gmail.com with ESMTPSA id w23sm10726109pgc.72.2019.01.07.09.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 09:45:41 -0800 (PST)
From:   b-ak <anur.bhargav@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     b-ak <anur.bhargav@gmail.com>
Subject: [PATCH v2] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM standby mode
Date:   Mon,  7 Jan 2019 23:15:25 +0530
Message-Id: <20190107174525.13289-1-anur.bhargav@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190107125907.GC9570@sirena.org.uk>
References: <20190107125907.GC9570@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

