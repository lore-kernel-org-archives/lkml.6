Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D88C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F12E20833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KMvNWM2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F12E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeIZBZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:25:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43254 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeIZBZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:25:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id z14-v6so7003110wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=3GHDbgTe9TRc7fBRyhh4rsmV5dkMzK8mTT+8wkI8zjs=;
        b=KMvNWM2Uhqpk1m6WDXSv6ZT7XHeQWfT0zTMgzM9wwk0VYyg+81NfJdRmPPzVepUBML
         SD5hXglpnha1LPG7NgXz2KwN7nMTD2j7zL8Az3Z5Pwx1UXo4LdrNGU4Md7h2YRlBjgr3
         Axan66GAkvfWUSC09Tb/DqJ5su5QW54LrIf/K90xSwvFjGgFYLis9ZSWjz/4Cpv7ClJl
         Rlt844zn1HgvSS4dU4BMdQNedUk7hU8hVwKQJWOW9YU6JIGIZ73Ls5+q3qzovsCiSyQO
         vsmR7dn17Ug19T+kSL/WLWLOZXCQ9K5eZjI2aV05xEPw97EKetxSTInT5KgsPmDCTuqW
         6zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3GHDbgTe9TRc7fBRyhh4rsmV5dkMzK8mTT+8wkI8zjs=;
        b=ZLWd+dIARq8s6+kafQ8z1NdxPK4xFLf5fMJu+AaL6LzhuhiEreO9l6NmsXFBxuJGiU
         JAv7wB0VRhE+/swqT3X84hR6TuSBdngmt/1ON2wR/oVZe3Fp8VuhRjET8xztwuylduZM
         w/RFD8SXHE+ElWaZs19ceiAXpS3yCPdeGOSV0HWQoTvvySrY5GN/m7zwBrMvopU9B1TK
         vcEb8NfXvvaj6o2NPzviPdTjDBM5Hs3n/DW/YuvOMMMhq561T18HJijo5+zPEc9sQgRU
         +pBdkPIKACj6TLEbRiHtqqoPk0w2yTTpB2/eNH+N1huWura6qIEnw7k6k6QcobgLai80
         E0dg==
X-Gm-Message-State: ABuFfohNkMgoVwrOTTToXxi9FIpym/iHoElLN0S7uy8IlOENtrhP6xND
        t56ENXScEzL/30Awv5sI0E1JtQ==
X-Google-Smtp-Source: ACcGV60l/Bq1qf0Fv2PcJUBRglPGvuvjlX2z5RkOFTjNqQLn2iew21Avap2IBBJMkpFRLHSmp5dLXg==
X-Received: by 2002:adf:b2d7:: with SMTP id g81-v6mr2278868wrd.48.1537903006271;
        Tue, 25 Sep 2018 12:16:46 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id c19-v6sm3469361wre.86.2018.09.25.12.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 12:16:45 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     airlied@linux.ie, tomi.valkeinen@ti.com, andy.gross@ti.com,
        clabbe@baylibre.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: omap: remove unused header tcm-sita.h
Date:   Tue, 25 Sep 2018 19:16:37 +0000
Message-Id: <1537902997-19949-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcm-sita.h is unused since commit 0d6fa53fd805 ("drm/omap: Use bitmaps for TILER placement")
Let's remove it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/gpu/drm/omapdrm/tcm-sita.h | 93 --------------------------------------
 1 file changed, 93 deletions(-)
 delete mode 100644 drivers/gpu/drm/omapdrm/tcm-sita.h

diff --git a/drivers/gpu/drm/omapdrm/tcm-sita.h b/drivers/gpu/drm/omapdrm/tcm-sita.h
deleted file mode 100644
index 460e63dbf825..000000000000
--- a/drivers/gpu/drm/omapdrm/tcm-sita.h
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * SImple Tiler Allocator (SiTA) private structures.
- *
- * Copyright (C) 2009-2011 Texas Instruments Incorporated - http://www.ti.com/
- * Author: Ravi Ramachandra <r.ramachandra@ti.com>
- *
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * * Redistributions of source code must retain the above copyright
- *   notice, this list of conditions and the following disclaimer.
- *
- * * Redistributions in binary form must reproduce the above copyright
- *   notice, this list of conditions and the following disclaimer in the
- *   documentation and/or other materials provided with the distribution.
- *
- * * Neither the name of Texas Instruments Incorporated nor the names of
- *   its contributors may be used to endorse or promote products derived
- *   from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
- * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
- * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef _TCM_SITA_H
-#define _TCM_SITA_H
-
-#include "tcm.h"
-
-/* length between two coordinates */
-#define LEN(a, b) ((a) > (b) ? (a) - (b) + 1 : (b) - (a) + 1)
-
-enum criteria {
-	CR_MAX_NEIGHS		= 0x01,
-	CR_FIRST_FOUND		= 0x10,
-	CR_BIAS_HORIZONTAL	= 0x20,
-	CR_BIAS_VERTICAL	= 0x40,
-	CR_DIAGONAL_BALANCE	= 0x80
-};
-
-/* nearness to the beginning of the search field from 0 to 1000 */
-struct nearness_factor {
-	s32 x;
-	s32 y;
-};
-
-/*
- * Statistics on immediately neighboring slots.  Edge is the number of
- * border segments that are also border segments of the scan field.  Busy
- * refers to the number of neighbors that are occupied.
- */
-struct neighbor_stats {
-	u16 edge;
-	u16 busy;
-};
-
-/* structure to keep the score of a potential allocation */
-struct score {
-	struct nearness_factor	f;
-	struct neighbor_stats	n;
-	struct tcm_area		a;
-	u16    neighs;		/* number of busy neighbors */
-};
-
-struct sita_pvt {
-	spinlock_t lock;	/* spinlock to protect access */
-	struct tcm_pt div_pt;	/* divider point splitting container */
-	struct tcm_area ***map;	/* pointers to the parent area for each slot */
-};
-
-/* assign coordinates to area */
-static inline
-void assign(struct tcm_area *a, u16 x0, u16 y0, u16 x1, u16 y1)
-{
-	a->p0.x = x0;
-	a->p0.y = y0;
-	a->p1.x = x1;
-	a->p1.y = y1;
-}
-
-#endif
-- 
2.16.4

