Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F23FC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F263D21473
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa39owUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F263D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeJAC1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:27:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34983 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbeJAC1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id o18-v6so6642441wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TpBKzlnAcl8FLRX8Dxg1z+6n0TXc6UZ9KETi8o1N0qk=;
        b=Oa39owUGed+QEBpIO26Qih19+ltorEBFiiloSGH0iKE21oHekyoWLHRkTJQDOOUITK
         SSbTFRo5tGLeIZvFzragBusFfNhm4Xq+FIoZBSf3yov+41HaSwy/Tky0Wz4PICoEfIdD
         Nnz04/NXnT+xFn4bFSIuMFWySowGkwWDoNlkTAQ9nmhtAy8r0E3kHqm5ykPfOZOZmO38
         gGmqMP57uSkfR6ndRd2lonepv75aUuMLwWk3wBjJKR7gua8NhKnyXscfg7JFodJV4FGt
         pO8toJ4wYAT9L00C+4/hL2fZ5muagD4t+/fx9wTmD1uO6ZD+dpb3m0bOdN8Z+EGWD9pC
         glAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TpBKzlnAcl8FLRX8Dxg1z+6n0TXc6UZ9KETi8o1N0qk=;
        b=FtdRYvK9Wl6iEMkgekxQ1p55oXd1MTQIubY7IhvTQzW/6OSdSiU6arMt3bnyr+yPuK
         z9kTcWiPS5HaPGUzIhk+6wX5MLELKdyVI4QK1DzAbGFy/pkewy6WXe6T7li9Xc7hDiKY
         Hhnw6EOZL7454Aj9k2d/HBV7OuHfdlHZpKD8aKGYRi+VPPdc26DZmuyAYfeqD3D483yE
         0hclDuUqdK7drDHDuvwyuPtwmUWAZYcejDKK/hM+VzWp25yEFfKcKEkTiWA0qAb8pGid
         Z1SHJoQu4Gl5wqBRFfg3MWlTWFmu39CRD3Sitq/tZR6MnW/5dam07+NuVQusWgMch/HA
         3zSw==
X-Gm-Message-State: ABuFfogP0GUIejE5obGodYAGQQwY1S24squGltaPSVDG6kQSC3OmpPUM
        qXGZ7t13zgp8sTPM9SAdzE8=
X-Google-Smtp-Source: ACcGV61gGM1ppMwgB4eEDl7Cd0+Mpk3Vy/xme5rPPouieXmiCpumyaK+q0n+oMYVUesMI3KfBo16Jg==
X-Received: by 2002:a1c:7f93:: with SMTP id a141-v6mr6828873wmd.45.1538337213445;
        Sun, 30 Sep 2018 12:53:33 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 14/19] staging: rtl8188eu: correct block comment in bb_cfg.c
Date:   Sun, 30 Sep 2018 21:53:05 +0200
Message-Id: <20180930195310.1531-14-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct block comment to clear a checkpatch warning.
WARNING: Block comments should align the * on each line

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/bb_cfg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/bb_cfg.c b/drivers/staging/rtl8188eu/hal/bb_cfg.c
index 1862c1396c85..11e0bb9c67d7 100644
--- a/drivers/staging/rtl8188eu/hal/bb_cfg.c
+++ b/drivers/staging/rtl8188eu/hal/bb_cfg.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
-*
-* Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
-*
-******************************************************************************/
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ ******************************************************************************/
 
 #include "odm_precomp.h"
 
-- 
2.19.0

