Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCDDC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AEB21772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEY4BJEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56AEB21772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeHHSDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:03:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42675 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeHHSDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:03:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so2068479ljc.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUq89/0b4uGPBIsa4F9J0E7MTHgB7WbhQA+9Mce9u4A=;
        b=dEY4BJEcS9F3RXCDAHFSUjKpX/da1oKO8dvRqlnoX2xgPc6IL8CUmjFsfoebdV+fYU
         waRf0/qGroRAd+UNb+9Q8N73SQDWbsZYw8cvkzQ9M+bvxl3U4RNO5LpBSvVIBuXY4lRp
         HNtnAN3dTvw3FlUzXfUBNV/hj6HfnvHzkGa0b01xdoFfdCZS1IE/505iQeAOljx1LWNk
         EeM4oziNHzj5xW3K14D4Y0J34Or/MYKVO62cvzE1p7mITp1PexSbUzEPaoZ6J5beUZvd
         1AorPMCaAa9CmVS7ITT2Bow7L1uxlr3TmSN7xNHK7jcztllhRxg71fkNm+xbdkpmaQ43
         sdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUq89/0b4uGPBIsa4F9J0E7MTHgB7WbhQA+9Mce9u4A=;
        b=LJ6K4UI7ZOT82Ynv+TWFeG9m91T/JMYNhdutcwiKu6yk/WSrX2qrCkBvSm3K1YCPm6
         cKONZkwi8H4bCOH0ZYrlOnnnxTooXrd02DwN1tG92niP1RVpvcxew8Vwla+RahyA22cD
         BIaVDoOv/fZK5clbHI6MZQKgau2NiFbZxloPRu7FHz2DvaJeka/o9ImMWCOXheebTBYx
         wVY47hvgYL8V7V1BukFCzGQHiA3cX+mARCt7pleb4M+gQYPaJNB6WCuLl+YPOq1xisU4
         su0P3JLitCItDgjfo1iWlba58yGi8UdZVcrjLiK6NxQCuAHEjnJNIxyUZX4li9zi475d
         MmDQ==
X-Gm-Message-State: AOUpUlGa8JUHfu7zFuiIHM3CsN3wMXREwJfb918yOHl3PFsL/ERul8yK
        pxC0GmWHFvFU50GS4WlEAxE=
X-Google-Smtp-Source: AA+uWPyCf8Iv6AKFPQWxpLLke2sdtGe27uSLG0DNRuw9mNA3Gen1u8GSFo4RZYB2kGQsGwIxWHJW6g==
X-Received: by 2002:a2e:4d51:: with SMTP id a78-v6mr2361807ljb.106.1533742986340;
        Wed, 08 Aug 2018 08:43:06 -0700 (PDT)
Received: from localhost.localdomain (185.59.110.199.maxnet.net.pl. [185.59.110.199])
        by smtp.gmail.com with ESMTPSA id x2-v6sm725985ljx.64.2018.08.08.08.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 08:43:05 -0700 (PDT)
From:   Arkadiusz Lis <areklis909@gmail.com>
To:     jfrederich@gmail.com, dsd@laptop.org, jon.nettleton@gmail.com,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Arkadiusz Lis <areklis909@gmail.com>
Subject: [PATCH v3] Staging: One Laptop Per Child: fix SPDX-License-Identifier issue
Date:   Wed,  8 Aug 2018 17:42:29 +0200
Message-Id: <1533742949-6432-1-git-send-email-areklis909@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20180807080734.GB20615@kroah.com>
References: <20180807080734.GB20615@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX-License-Identifier to the source files.
Remove redundant, old license.

Signed-off-by: Arkadiusz Lis <areklis909@gmail.com>
---
Changes in v3:
 - change old license to SPDX 
 - adding change summary, missing in v2

 drivers/staging/olpc_dcon/olpc_dcon.c        | 5 +----
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c   | 5 +----
 drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index 2744c9f..6b714f7 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Mainly by David Woodhouse, somewhat modified by Jordan Crouse
  *
@@ -5,10 +6,6 @@
  * Copyright © 2006-2007  Advanced Micro Devices, Inc.
  * Copyright © 2009       VIA Technology, Inc.
  * Copyright (c) 2010-2011  Andres Salomon <dilinger@queued.net>
- *
- * This program is free software.  You can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
index 633c58c..ff145d4 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Mainly by David Woodhouse, somewhat modified by Jordan Crouse
  *
@@ -5,10 +6,6 @@
  * Copyright © 2006-2007  Advanced Micro Devices, Inc.
  * Copyright © 2009       VIA Technology, Inc.
  * Copyright (c) 2010  Andres Salomon <dilinger@queued.net>
- *
- * This program is free software.  You can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
index 6458442..838daa2 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2009,2010       One Laptop per Child
- *
- * This program is free software.  You can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
1.9.1

