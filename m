Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC2EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A821C21A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ/vbPUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A821C21A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbeHFVsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:48:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37259 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeHFVsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:48:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id j8-v6so9910782lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wcgcqp5msO3ui2DnnZpmlYGy7KEeFYNAHjoKNZ9a8D8=;
        b=ZQ/vbPUtK22lLy+c6VSNFXgA/RRKgBljHkuJQUdWIigLJjsNWPitAkgUIx0roMildS
         KzdwNL291XSQKkLWIoI5HZYAg5TaHgUI7qmu2ICY+0kwg7+SunFaLR1BQcKw65KnknkV
         CVIyZFOnxTK/1nvmra/eVx+aZSAtDwAMC93Vu+th78Kwm6LEOQ3hJYKNrVZzv7I+BGXJ
         u02TtENKVLbAU6jzN4uRdu8u1qj8BnzRIQ72dXsotwhLVqCFc/N4hjEnBrvXsvRT/Inc
         hIPS50X3Iy4ORPWtpzgVTSThIwNkTaHrq/+Mu5yKIZ4s7BkfG1+NLdB01MTe9rLL6yAb
         wnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wcgcqp5msO3ui2DnnZpmlYGy7KEeFYNAHjoKNZ9a8D8=;
        b=SMVef+E/uLQvj9+Aezr86XmvPF/yv7nOzSJV8zafY5BCr5KE5meCZaug6cLtzpCtCW
         BTq+08SEW15jlm1b2iB1ndfgysRzp4Pn8GIv1jFWusGkQ8rNG3ZPuVBzgGZ72/uXw4WR
         A4/iDvbuT4tMjnRd4OnvfGSgMLFDUTIf8OndjrbIaLCqCjtznoSUu3OM4rqCFnwT52Qe
         3sP1yz9fe8uUMCOD26a+S3cIva8tIEsQIpZbRShMn/b1TA+GBdp08yDGcX9641qLm/En
         BuUwqz+5tLIunJyMGpLLRPMXkiSzVHeE0K7KFZ0A+rzZWvY+VcfDaJYTs7CohMLybMrc
         7peA==
X-Gm-Message-State: AOUpUlHnmXKZMWxp/lwTDN478TNAU9Db3+thfQZkbqsum0xPpqeZmrFt
        0zWIXNnL+JVzJWrJ1ohrfO4=
X-Google-Smtp-Source: AAOMgpfdgCvZomSNSXUcg4YOzw4z3FT5TitCGLRMe5zEDlQtdfIaE12DsyLX/q0rCZn3ePngn0b7yg==
X-Received: by 2002:a19:e40d:: with SMTP id b13-v6mr12892247lfh.141.1533584262145;
        Mon, 06 Aug 2018 12:37:42 -0700 (PDT)
Received: from localhost.localdomain (185.59.110.199.maxnet.net.pl. [185.59.110.199])
        by smtp.gmail.com with ESMTPSA id w27-v6sm2379157lfk.5.2018.08.06.12.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 12:37:41 -0700 (PDT)
From:   Arkadiusz Lis <areklis909@gmail.com>
To:     jfrederich@gmail.com, dsd@laptop.org, jon.nettleton@gmail.com,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Arkadiusz Lis <areklis909@gmail.com>
Subject: [PATCH v2] Staging: One Laptop Per Child: fix SPDX-License-Identifier issue
Date:   Mon,  6 Aug 2018 21:35:52 +0200
Message-Id: <1533584152-5792-1-git-send-email-areklis909@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533575300-5001-1-git-send-email-areklis909@gmail.com>
References: <1533575300-5001-1-git-send-email-areklis909@gmail.com>
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

