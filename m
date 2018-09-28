Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A796C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6C5216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/uSFHt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6C5216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeI1IaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:30:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34119 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeI1IaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:30:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id x23-v6so5084871qtr.1;
        Thu, 27 Sep 2018 19:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FnsE+PwbSYT7Ik4sfBLqTvLMfucbH50GCrBzd4xVqgg=;
        b=n/uSFHt6d+HCUETD/614yqwcizWwVLls342kxJhg7jvzKajBcriywXtRgekX3nkOLb
         ACtKZCqOmYCX47uywr+QcDecfTemGUKAeroLZlgV7T1iIZBGhbPCHwOenZyI6o7CHHBP
         2C5KTzrn6qnJLESQ5YDu5X9CSCDoPHytvHu/yIZBlsdgWaJSWSL8nxQS36jSjIPpuCbX
         QyMEK5kxb9LMPJB2vaRhr5xO2U9m3U9nBAQy9l8uCFHqpkDqu0C6a7qXk7rwIM7fP0o4
         iJupUc4+1P23OxonbcvIrioDXN+CAogQcOlNL9FpbzVR4b8DT7dIRzwWcKI+pqSj+68j
         JM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnsE+PwbSYT7Ik4sfBLqTvLMfucbH50GCrBzd4xVqgg=;
        b=FywH483DofL75a8gTF55g7AlOwoXZGkHmhLulbbTs/bt+Z6w8ktqR8tO1UHjm/kpfD
         z7O7n8pvMuddJjl1h/d4t3ViI95SPKmHmpPneS+H2Oxn95AjiXIctrxGYq81/ZB+vh2y
         gGJlaK2W9aw7TQ6KNIYn9XzVCvAU7zkxBBkeCCfE0wSXHh/KE9gO7REEUimBFOltLCo8
         gDQpLA8x2APW7pQLIwJAFy+RiaHg1m0gyQiQnFqDTA6VvxvMr7u5FyJsIOQsJWsTH4xP
         RheJR1RPHINkLbbH2wZX6PAvrxcRkIJ6mLmoNnLjUW+auo7m4GXzgXwyiC01s6ep5P43
         tqiw==
X-Gm-Message-State: ABuFfoirkTkOkxv6laJ/zrJ0eHLUzQ/4NdBlQawlyWQRjGY85sdld/K0
        jT+oalOiq2i/FBxsnOc4NEc=
X-Google-Smtp-Source: ACcGV60ofa9o4GpIHIDU2Wr4VJFAxKzxYG+RRnI2evk5IX94glLjzmF1zMR8rul47F5Qndp/EGtMPg==
X-Received: by 2002:aed:20a3:: with SMTP id 32-v6mr10391742qtb.195.1538100539239;
        Thu, 27 Sep 2018 19:08:59 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id y138-v6sm731191qka.36.2018.09.27.19.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 19:08:58 -0700 (PDT)
From:   =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     =?UTF-8?q?Leonardo=20Br=C3=A1s?= <leobras.c@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 4/7] drivers: zorro: Avoids building proc.o if CONFIG_ZORRO is disabled
Date:   Thu, 27 Sep 2018 23:08:13 -0300
Message-Id: <20180928020816.11251-5-leobras.c@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928020816.11251-1-leobras.c@gmail.com>
References: <20180928020816.11251-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids building proc.o if 'make drivers/zorro/' is called and
CONFIG_ZORRO is disabled, even if CONFIG_PROC_FS is enabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/zorro/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/zorro/Makefile b/drivers/zorro/Makefile
index b360ac4ea846..d580f9f08e0a 100644
--- a/drivers/zorro/Makefile
+++ b/drivers/zorro/Makefile
@@ -3,9 +3,10 @@
 # Makefile for the Zorro bus specific drivers.
 #
 
-obj-$(CONFIG_ZORRO)	+= zorro.o zorro-driver.o zorro-sysfs.o
-obj-$(CONFIG_PROC_FS)	+= proc.o
-obj-$(CONFIG_ZORRO_NAMES) +=  names.o
+obj-$(CONFIG_ZORRO) 		:= zorro_all.o
+zorro_all-y			+= zorro.o zorro-driver.o zorro-sysfs.o
+zorro_all-$(CONFIG_ZORRO_NAMES) += names.o
+zorro_all-$(CONFIG_PROC_FS)	+= proc.o
 
 hostprogs-y 		:= gen-devlist
 
-- 
2.19.0

