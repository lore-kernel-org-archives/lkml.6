Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F80ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E91520873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="th5XtAk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E91520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbeGMLiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:38:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45243 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbeGMLiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:38:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id i20-v6so11305652eds.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=15HiGTNpAIoO2MtCNaf3eU8yfW7U4yy9d8ty0bb+Vnc=;
        b=th5XtAk7ugQwWfiSehDgNPgAOxJNcPxsTtcETFB4g7EzMie2iUTIdzwv7kQliWPmSt
         TaQ5oQJ+qMeptcbcQBR3CvJetLQtx7HVwqMxrujuEjsFui/AKW9S0m3AyNpx+Sm0hm2U
         6XXkexCuHlXSAfb77ZeU3iaMr18Ddc2Ta6a6GyuoKex6EK9g5/kySxAGfKLYl3VYjJvB
         qBTCiY9L5pNLvEnEo7fLLmMVMRpTAlMJsL5H5X90pwR4qXbjP0relBF62t7zYHjR+Xy0
         D1GsCjQ9X0CrePeXWJTJz3LzQiyFpBoxPSMRcxvxLnO3Cb4DLikbEqGUkfxXlckeaLz7
         GrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=15HiGTNpAIoO2MtCNaf3eU8yfW7U4yy9d8ty0bb+Vnc=;
        b=tSnDy+Xge5AfsME+CmRFB7gOjV5XitBaXvgl0gh7wtP5TuEozE6j3m3f/C8AYsmTt4
         DJf8SlL7lcydAu7m/emMt+YlIF3FGnYY1Wnze5M40PCIW99djnIVleKrXYECqqObdsrU
         wS7/xqJSHMHP1jy9KnqCiJMGwiB/IInFc7JoyZhkTmWSDK9VySC1NseXecwmezZ3hY11
         SBZ8mCDkm60SArlhoVaLFevr6IiPi9QFJxBAi/Xq7dXI9KzIa91yeYGZO9DS0eLHH72D
         XWCJA0GIjdhoPN2mOUb3eNViViaFSLAD9Bjbc9TAgoq/HjlUkujLZJao59E1uQafh1kd
         1vIw==
X-Gm-Message-State: AOUpUlFkM9SJBmbSnWPV9ztWiJJYaafDGmzZCzfE+qH7FQpjTuQtN1rc
        Z11IknFwFflsFp51EOuKTuulnzZj
X-Google-Smtp-Source: AAOMgpe5g3Z2fjAYIBKEActVOpWi014lgKixflYP2A2+FJKFdgrjEooFboGVPj8QYk9tPHNUXsNMIg==
X-Received: by 2002:a50:aec9:: with SMTP id f9-v6mr6700492edd.72.1531481042846;
        Fri, 13 Jul 2018 04:24:02 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:24:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/13] staging:rtl8192u: Rename file macro to avoid camel case - Coding Style
Date:   Fri, 13 Jul 2018 12:23:11 +0100
Message-Id: <20180713112311.544-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple rename of the preprosessor switch, protecting against multiple
inclusion of the header file. Change to clear the checkpatch coding style
issue.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 37aa36126d19..5f7b7b182ef6 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -15,8 +15,8 @@
  * project Authors.
  */
 
-#ifndef R819xU_H
-#define R819xU_H
+#ifndef R8192U_H
+#define R8192U_H
 
 #include <linux/compiler.h>
 #include <linux/module.h>
-- 
2.18.0

