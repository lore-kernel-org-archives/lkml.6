Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B94C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E11218FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I26PW4qz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbeLWJ6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:58:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34414 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLWJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:58:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so17317010wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 01:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBF33CCG8HC0TkiGAXOdSK4xih8UNjM1Sjwsu9ZtEXY=;
        b=I26PW4qzceQMkUlyqiJ9lu4XcIaF6CNFLezFlHT03Eoa+TDYcVcskDYJ1pIziOcp2+
         WrcbjDHRJvwkFJsbO2diz5YIL299LK019S46mLXxXJqFrHi9bSJpgp5KgIPwQok3oAsZ
         Iip4zTvYIHia6dBoRVf4PCOUCJ7ak+BZCZ/E/RvvfcRRUOmAb2F4yUJNSb7BahPM6Vye
         03cnyYVjA+YT7dcGupMkwKB8n294IqtltToD892PBwwuugr76QnbGUoCEkeJ7f+wAQeA
         n2D9laJIHEiKFxngqoUK5SxES6oFuVehFy0YIVIO/VnXpCK6ArWR7z/S5nMtE/jasa1c
         hEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBF33CCG8HC0TkiGAXOdSK4xih8UNjM1Sjwsu9ZtEXY=;
        b=V3ikvLzbyFvW4vJVmSuFb/IhmnvXFNWrdTeOOhIORCJdeqPJHoBy/w1heZZloqxw3Q
         p7/0ANiZ/u61uZYJm6nk78PPNR/nyLXKxuxyI4hDJygCBxbThs9BbpJqoaKuGEe1f9Ee
         UCn81BdTyF+5E806mYjWhXScvzmCvb2C1//tZBHrtxyzpyVAFjulOgP2QuzGkl0bMPIy
         WEeH/w0GXLhsAuoR5izhzGufVMura6VmyHu0LuC4X8EgVl4EWgaHBwyflt4WAYW7B6jE
         JwEX8jcklRnH9rNmo4LQi1tOLuO+fDL67ZPlqODTAOAgdpBK27azl9HrqJ/j9rvicYx5
         BCxQ==
X-Gm-Message-State: AA+aEWZOIxcHG0PIjuotVPVHadXkd6Y/tXNkMb1nV1GPd8vWPtNNJf0k
        NXr0iSaALlnRydaD7LmE8Bk=
X-Google-Smtp-Source: ALg8bN5vFx4uJtBUEFL5GxgppYdM1K+q4FsloJHPehdBKEkSyC52uLEFlupF1pST6TPGD2dtJKT91w==
X-Received: by 2002:a1c:f112:: with SMTP id p18mr8409093wmh.83.1545559077106;
        Sun, 23 Dec 2018 01:57:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id v16sm13900298wrs.75.2018.12.23.01.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 01:57:56 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: mt29f_spinand: add SPDX identifiers
Date:   Sun, 23 Dec 2018 10:57:02 +0100
Message-Id: <20181223095702.25701-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This satisfies a checkpatch warning and is the preferred
method for notating the license.

The SPDX identifier is a legally binding shorthand, which
can be used instead of the full boiler plate text.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/mt29f_spinand/mt29f_spinand.c | 11 +----------
 drivers/staging/mt29f_spinand/mt29f_spinand.h | 12 ++----------
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index def8a1f57d1c..8630f7012957 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2003-2013 Broadcom Corporation
  *
  * Copyright (c) 2009-2010 Micron Technology, Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.h b/drivers/staging/mt29f_spinand/mt29f_spinand.h
index 457dc7ffdaf1..38837cc6421c 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.h
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.h
@@ -1,17 +1,9 @@
-/*-
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright 2013 Broadcom Corporation
  *
  * Copyright (c) 2009-2010 Micron Technology, Inc.
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * Henry Pan <hspan@micron.com>
  *
  * based on nand.h
-- 
2.20.1

