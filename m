Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7414FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2727620862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEa93Ifb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2727620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbeHAVAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:00:00 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37089 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeHAU76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:59:58 -0400
Received: by mail-pl0-f68.google.com with SMTP id d5-v6so3693498pll.4;
        Wed, 01 Aug 2018 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4XgQr0v93BmMi0+ykyaOvN9BFSFtuq3EFayKXlWi74s=;
        b=bEa93Ifb9Faj5Wl5K9X/HWUc334Za9fdns9J+zj68XBgCqCcWzrNyIbLvoW7/b6XPY
         JOUiQYnhDmM3V6Do0Qnjn9eJLZQljDWVC7QwhkbAGg+q0vuWLrcMDp7Ucgr1X9+3Q7SZ
         9jtVYflW4bBP2z3AW17squlhZ/eF4NIr4+xX9rDT8ot6/0X4m4PtI2W68t0tUQxlqcqM
         C4R+Oz/zoPcG9BvodU8mUEgLwPdXuzeJB2+8ALzmzCCNxCGc9oxr2vo7e53v1Nmom1uF
         Ixu4ykgPKDbPm2JrXJ0wPPuz8uRQKuxw5XxqN5w+8jGhx84J3e4TCCc16kvuk4vm7hkR
         kBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4XgQr0v93BmMi0+ykyaOvN9BFSFtuq3EFayKXlWi74s=;
        b=uROCv0y8WWH/m2OqNjNTNGP+tB8Ne8x+Kckos/4bk1Kedjf90sm7PXDMTYvN4sgqDr
         HzvYCV6vi0yygUm1YQn+wV8nNeqvFnPFxHijNT/0eJWj53/qv+m0t2ug5yUgIXqwVM8h
         suF6koRrZ9FOLHjaABBTPJmeEn23apVnG1SCDCzQC5g3QR45ncTLr/jxJBaMM+cCUmft
         Hf2yHGY+5oPi0c7GvDLVWayFmCgVOrTkvN9hPn5VSJLOpolplBGOh+xC000oHIqUVLzi
         XzfQsfgnEpwORBNaQjhoivwD25y8HAYhDB750gjWIeXTWG/tJ/3helQen6FcvU3FTm5S
         CzXg==
X-Gm-Message-State: AOUpUlF4Bt3UwkoONskcxCCpvlFrT9ZrEZsdify7lvy/UhEkK86o7P6T
        tqsvw/R//LgacGE4Isy7LTKdX6fP
X-Google-Smtp-Source: AAOMgpcwUV9Ax8YPbRajmczg2HWz0QG47JI0B/UG0xc3IEQ1bFL3q4HiFjgn91uBBClkH3xwC/k6pg==
X-Received: by 2002:a17:902:bd82:: with SMTP id q2-v6mr9484396pls.178.1533150764185;
        Wed, 01 Aug 2018 12:12:44 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.googlemail.com with ESMTPSA id u42-v6sm31171336pgn.1.2018.08.01.12.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 12:12:43 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE
        IMX), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 05/14] gpu: ipu-v3: Allow negative offsets for interlaced scanning
Date:   Wed,  1 Aug 2018 12:12:18 -0700
Message-Id: <1533150747-30677-6-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

The IPU also supports interlaced buffers that start with the bottom field.
To achieve this, the the base address EBA has to be increased by a stride
length and the interlace offset ILO has to be set to the negative stride.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-cpmem.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-cpmem.c b/drivers/gpu/ipu-v3/ipu-cpmem.c
index e68e473..8cd9e37 100644
--- a/drivers/gpu/ipu-v3/ipu-cpmem.c
+++ b/drivers/gpu/ipu-v3/ipu-cpmem.c
@@ -269,9 +269,20 @@ EXPORT_SYMBOL_GPL(ipu_cpmem_set_uv_offset);
 
 void ipu_cpmem_interlaced_scan(struct ipuv3_channel *ch, int stride)
 {
+	u32 ilo, sly;
+
+	if (stride < 0) {
+		stride = -stride;
+		ilo = 0x100000 - (stride / 8);
+	} else {
+		ilo = stride / 8;
+	}
+
+	sly = (stride * 2) - 1;
+
 	ipu_ch_param_write_field(ch, IPU_FIELD_SO, 1);
-	ipu_ch_param_write_field(ch, IPU_FIELD_ILO, stride / 8);
-	ipu_ch_param_write_field(ch, IPU_FIELD_SLY, (stride * 2) - 1);
+	ipu_ch_param_write_field(ch, IPU_FIELD_ILO, ilo);
+	ipu_ch_param_write_field(ch, IPU_FIELD_SLY, sly);
 };
 EXPORT_SYMBOL_GPL(ipu_cpmem_interlaced_scan);
 
-- 
2.7.4

