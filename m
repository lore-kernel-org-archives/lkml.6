Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB987C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49EB218D9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shagPUc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390046AbeLVSS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:18:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39674 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbeLVSS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:18:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so8582654wmd.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 10:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XLqC4skjHOL8pvuilpizAE6KhzrZ+Jd75hEFy5MHPTY=;
        b=shagPUc9RF4DW05Luva+bHx4TTWFJewM8qNqFWzYB/wnBsuqcxsF7yTWBmGnNDBLts
         8cELjw/rAr4IXV6RaGUVyqsi7My6om7ARVMFwhMwS+Z/ecek0C/f5LiMG5LfLB1yjQsF
         nR2MPYpbScVLt4AeE0brXdUsafYvrl/9zhipjumDGQJ+/SW91mxf1nONtLy/LUMQR1j0
         XugzfiI/E85QgqMPx3QIWsA3X4dUC8bhdVxqhx3Yd0s8TqryR8M+FNo8h5gHbXE8K43+
         nBF/idT4Pjv3iC+sXcUlT6GMrjAygypPAoxZuId8i+qNReJrVaF/AtfmAsOr06+w48iw
         qiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XLqC4skjHOL8pvuilpizAE6KhzrZ+Jd75hEFy5MHPTY=;
        b=ARni41iTChaX5TKZMTBpnfc20mjeSYIdsVpN5mMPeKuISrq4idGdwPejrR3NhUa6Me
         Gl3/ItqYHbMNX98N/UA66r7txNHiizKN4zDYQxANaiEQI8ssAHNkB8wYDOBmy9GOgmHm
         rbMNh1Xo0o8CQb9otyQMV2qUYwDJD/KvhXYgZay/w/nIuopw9jPgcPegU3GTYYqqBIqB
         RApXAAmA08oXjDxs3Wf1oEvTe0Xee8A7G0K2vbZwHjdEkPfsZ4j1ddtFDKtOtugMP+6U
         dPZ6HMBot0xYSev/PCT7jUVGusMW/UQ8rE3WuJaIgM4rS+bvGfCNcg3oI4hWLquM++X9
         P4fw==
X-Gm-Message-State: AA+aEWaZmot6t5ncA/oL5B4wZ5NtyDN0XhxgCgU+Z2Fu9+ZyMB5vbNC6
        EuPITGyrsFwJ5x56NdP4yurro4PW
X-Google-Smtp-Source: ALg8bN7l9nfN/CGs8lSXsH2lEJBPdI8uVg//Z4G46xWwnecsFHKdzblREXUwZlrixxYqGpxikfs0pw==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr6071831wmu.52.1545470705136;
        Sat, 22 Dec 2018 01:25:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id m4sm9829637wml.2.2018.12.22.01.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 01:25:04 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: goldfish: remove GPL boiler plate text
Date:   Sat, 22 Dec 2018 10:24:53 +0100
Message-Id: <20181222092453.22047-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPDX identifier is a legally binding shorthand,
which can be used instead of the full boiler plate text.

There is a SPDX identifier line in goldfish_audio.c.
Remove the GPL boiler plate text to reduce file size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/goldfish/goldfish_audio.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/goldfish/goldfish_audio.c b/drivers/staging/goldfish/goldfish_audio.c
index d4520490cf6d..24a738238f9f 100644
--- a/drivers/staging/goldfish/goldfish_audio.c
+++ b/drivers/staging/goldfish/goldfish_audio.c
@@ -4,16 +4,6 @@
  *
  * Copyright (C) 2007 Google, Inc.
  * Copyright (C) 2012 Intel, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 #include <linux/module.h>
-- 
2.20.1

