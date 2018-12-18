Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2296C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF0E21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlUfCdyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeLRNi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:38:29 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44587 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeLRNi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:38:27 -0500
Received: by mail-qk1-f193.google.com with SMTP id n12so9441501qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/l2BFz5E70jNVo74ymdqczm+NbZ9ebLqQEzgpe0bSVM=;
        b=qlUfCdyiLBdQu0DU6mjIUOqWf02Dt5Ck2ELgE/yfaah1/qeh6x+WF5dZNRMdwmf2M8
         5kF0G+XnMeiNMEN/9KdoFXWlQsf6FVPIt0TA7B6iZW9akILLRa/TbdA/YwZxZwoyb6B5
         L4sEnODZxNohOFNXx6ZyNxlioKXZxaj4hGcTrNOHp41ny3Lw0jfN1t41Sop93EVKwUTn
         OIWwOkSmXJVtwVdqB+vSyBIXLZ7xZ/7xn2+fqyKVLtJNnpn1+tz1Vv/bOotoO8uiHxli
         w8PgVpKKm/BrJJVpbnux7NHTHuGsTlEhD1q7uTCN4O4b9QzcxTJJa57Po3Cz0tKWY32l
         Koyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/l2BFz5E70jNVo74ymdqczm+NbZ9ebLqQEzgpe0bSVM=;
        b=gRGOZucnCZUO1W3J+rC2BozxeJKyWb9uy74Akd9ckUTq47PLSMI5MzYO1WuggTk8Wr
         6WTlGr4IdzP5tE23zySF9yry9+ZzdxmremWNMqPVZFe8C69/nuxDuQKogypMKuyBrZB2
         qriAWsGtHckWEpXx3M/diONVGPHx4oKdabdG+Ta6PvUe31ipeiXsMh/ARIK4NHSTCG1w
         5ASQopfoT1ZBu2Isv8fAQgQgDHCHkDp0EpCeMZmYHexA+TE6dULgSvuMwkluJf2RwlVo
         ZUwjXwBEHP/yhgC/Cfpq8A/FTXzcO9lSZbT8Ws1SggH4S+JNAV/0wdrPRibBL1O3QQXk
         XG/w==
X-Gm-Message-State: AA+aEWZ9NX5cc02YkJ6Axs4ixV2+KWd2Rg2eE66BTL22fPdk6DIXzR3q
        tWliBk4C3o9P16LSB/RaZjc=
X-Google-Smtp-Source: AFSGD/XqObxQTYDG2HVfcjJsd9udD8Mmi+0AtuNGVitZ+v0iBng7sclI85XgG+u9m2nHg4w+9lZcZg==
X-Received: by 2002:a37:5d06:: with SMTP id r6mr15922874qkb.229.1545140305836;
        Tue, 18 Dec 2018 05:38:25 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id b20sm12611815qkb.17.2018.12.18.05.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 05:38:25 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:38:21 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] drm: i915: Delete base.id prints
Message-ID: <20181218133821.sykwt6wdeo7uf6o7@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes base.id prints from drm_display_mode                         
objects in i915 files. It removes dependency from drm_mode_object.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/i915/i915_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index 7f455bca528e..61dd7bb3fa85 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -2948,8 +2948,8 @@ static void intel_seq_print_mode(struct seq_file *m, int tabs,
 	for (i = 0; i < tabs; i++)
 		seq_putc(m, '\t');
 
-	seq_printf(m, "id %d:\"%s\" freq %d clock %d hdisp %d hss %d hse %d htot %d vdisp %d vss %d vse %d vtot %d type 0x%x flags 0x%x\n",
-		   mode->base.id, mode->name,
+	seq_printf(m, "name:\"%s\" freq %d clock %d hdisp %d hss %d hse %d htot %d vdisp %d vss %d vse %d vtot %d type 0x%x flags 0x%x\n",
+		   mode->name,
 		   mode->vrefresh, mode->clock,
 		   mode->hdisplay, mode->hsync_start,
 		   mode->hsync_end, mode->htotal,
-- 
2.17.1

