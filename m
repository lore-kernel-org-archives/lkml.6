Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE06ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300A920854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae1mD+KQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300A920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbeGVXJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52660 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbeGVXJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so14027964wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G3S3Zo/CYRT2dT3820gVf29FJz/zj7+6+Nh66pdWjXU=;
        b=Ae1mD+KQon7hoDyCDP60bMqTETGROjqKiNHtIvHUwZPj2n2+nUDk4vjjIXMq89jZ87
         qJjXgUki20i7EQ6ADuKACTkCKdXqZyznRI8jRVX1CUyKy9YHmdC81Hv1BRrpSdB4fK/v
         iTjJDIS6sdjCnbRLTKQCvtmC73TbzenKjs9170L4dAVUJiTlpKpkG1pvgLz+ZiImmtIo
         AgPDkLu1brT71snQQ0/2e0/RKzl5eajsB59iEYa6Uw5jsuJCo/LxMRT6uHhKsZJ4N6iw
         btc25IP6X9/dOqm21zv9Qr+OX+iOw4BfyGiM8nOb6Ap+3t1mxQ4m7aS7UVSQXrJUGHd0
         RC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G3S3Zo/CYRT2dT3820gVf29FJz/zj7+6+Nh66pdWjXU=;
        b=JjFW1S8IoABSDCqzvqmBaaw0Bhhmdf8z5uS6/OxWXcC7xHxMMVNBXQrAx435Zgbnaz
         Tm9xvhFn8QvTm/H5SV6Nhlcs5gYJSAnVEZjr2RrURkJPmiJYs8IxPkHflWwxmNczR1Yu
         njwMf+GL090aNmU35f+PAgfbDMu7M5NvVYW30jpOiZjHDU/hdhllzdMvkrtJlqLTsTfa
         HeKgiXYNFVijKgslvvq4OrctJ8NYokRUZZnXRlZn1uIHXja2mCdbBEO0mrhSPHfgPUEN
         z0s8tDYaDLsmQSGrCbQIEHhfxKLxxmSKr6nelXyWJrY4mkr5O0vMBnjLzDcKH5ixblJJ
         77eg==
X-Gm-Message-State: AOUpUlGA5J+vEiU59F2RMEK8F78iIDFq5X8F7ZErf87V16PVLfvdaUaL
        pmY8IQmeD77pmKchlVc3YLJSqQaeElE=
X-Google-Smtp-Source: AAOMgpeOOQ7hsyd1gvNqOOVsDQ6NsNO9QUKwOM+GVGBoQk+gJffyo/juxlXI4EEo8AQ9g5MEVxJbkQ==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr6176359wmc.68.1532297477066;
        Sun, 22 Jul 2018 15:11:17 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:11:16 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 18/20] staging:rtl8192u: Remove unused RF Zebra1 Bit Mask definitions - Style
Date:   Sun, 22 Jul 2018 23:10:33 +0100
Message-Id: <20180722221035.14453-19-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused 'RF Zebra1' bit mask definitions. These definitions
fail the checkpatch CamelCase naming tests. Since the definitions are
unused in code they have simply been removed, rather then renaming.

This is a coding style change which will have no impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index b3f9f7e65073..09eade1f4dbe 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -129,15 +129,7 @@
 /* RF
  * Zebra1
  */
-#define bZebra1_HSSIEnable        0x8
-#define bZebra1_TRxControl        0xc00
-#define bZebra1_TRxGainSetting    0x07f
-#define bZebra1_RxCorner          0xc00
-#define bZebra1_TxChargePump      0x38
-#define bZebra1_RxChargePump      0x7
 #define bZebra1_ChannelNum        0xf80
-#define bZebra1_TxLPFBW           0x400
-#define bZebra1_RxLPFBW           0x600
 
 /* Zebra4 */
 #define bRTL8256RegModeCtrl1      0x100
-- 
2.18.0

