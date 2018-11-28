Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88395C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECA720645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr/SkzSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECA720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeK2Ebt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:31:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39038 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbeK2Ebo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:31:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id n133so3414633wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dlbWACoXmz36LsOHX6d4B3toMHwxtF97wsLAjZl8KKc=;
        b=Mr/SkzSLdkxNtL39zKzYeTcwr7MmX5J5x7+G6g07J90V3SYsCjFMXZMVI3HzLk+8w7
         /g0/bXzeYCZuwVrCFafHSH/lET5D49dTiaX3xM8k3rlHM3tLx9Dv294OW0KL+XQzs9eA
         70CC8LXJpCzPJy7u24rXY4DvTZ93bJSZRzYN1hdoGeaQoMvR50MrpQpgZz4LAtXUELDV
         1mC2rxeahBpapY2g1KOFQ+MKaTWJ+mS3AQPkmPvggYNMHHODjaT4pzP7LFyckx16Rg9Q
         1FeqotM6ShNLIUhdfnLfFC2qHv5/axt/dp+L8zbT+sELyc/74dSehmGoD/84RtZBGqJC
         ygKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dlbWACoXmz36LsOHX6d4B3toMHwxtF97wsLAjZl8KKc=;
        b=Ay0G1Puq5c6CKMOj4OBBc9j+3LqUFhEqkR3fS91G8OenVtFsM1Sy28ikZ0KaTI17th
         kUBh1JMRCWdT1ohHSpGds2zxSsWnTfZwM5yHgEwuC7ront98QLWx6Xa+6VAMiy5I3IK1
         EnQOKlhpfaDQ4Fl0HPLfz5Kt5vH6SzLalKhtioGHu8n+MSSzpeB3rylCmxlhwh//kv0u
         JyMrJbMxxvLhhBeLq19VXsrEaua82DHB9JMMLG7GVncP042GOd1tDaX5Wv01OWLOAiMa
         W9iUkB+/QYBgwT25b5ZleqnqSE4Yc79UW0zWs9MFIHkUvP5M6xboxEX1K+i0hz6FjCdw
         pOJQ==
X-Gm-Message-State: AA+aEWZNY6wpyVJERAraRowHAvtlPJGY9GtP6EYLeB2x2tGjQYYG9Nak
        ThSyL5ERGTbSdw0IE+oXQoJFfkF7
X-Google-Smtp-Source: AFSGD/VzNM2feR+6evqMQCRQkR99k0sClCc8yacdpnbyreyyRz+Mi2X0aYB5/KPLKNrs/RfXKjzTjQ==
X-Received: by 2002:a1c:410b:: with SMTP id o11mr3623104wma.109.1543426161211;
        Wed, 28 Nov 2018 09:29:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id m126sm4199467wmb.30.2018.11.28.09.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 09:29:20 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: rtl8188eu: cleanup comment in hal8188e_rate_adaptive.c
Date:   Wed, 28 Nov 2018 18:29:06 +0100
Message-Id: <20181128172906.1694-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128172906.1694-1-straube.linux@gmail.com>
References: <20181128172906.1694-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup comment in hal8188e_rate_adaptive.c.
Clears checkpatch warnings.

WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../rtl8188eu/hal/hal8188e_rate_adaptive.c      | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
index f1ff86fec654..9ddd51685063 100644
--- a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
+++ b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
@@ -1,19 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*++
-Copyright (c) Realtek Semiconductor Corp. All rights reserved.
+/*
+ * Copyright (c) Realtek Semiconductor Corp. All rights reserved.
+ */
 
-Module Name:
-	RateAdaptive.c
-
-Abstract:
-	Implement Rate Adaptive functions for common operations.
-
-Major Change History:
-	When       Who               What
-	---------- ---------------   -------------------------------
-	2011-08-12 Page            Create.
-
---*/
 #include "odm_precomp.h"
 
 /*  Rate adaptive parameters */
-- 
2.19.2

