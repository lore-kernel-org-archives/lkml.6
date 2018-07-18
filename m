Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FD5ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120D42075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120D42075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbeGRDjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:39:21 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:37762 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731178AbeGRDjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:39:21 -0400
Received: from 89-71-158-145.dynamic.chello.pl ([89.71.158.145] helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1ffckW-0007zF-KV; Wed, 18 Jul 2018 05:03:34 +0200
Received: from kilobyte by umbar.angband.pl with local (Exim 4.91)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1ffckW-0000AH-4P; Wed, 18 Jul 2018 05:03:32 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Wed, 18 Jul 2018 05:03:22 +0200
Message-Id: <20180718030327.579-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
X-SA-Exim-Connect-IP: 89.71.158.145
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 1/6] vt: drop unused struct vt_struct
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hasn't been ever used within historic (ie, git) times.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 include/linux/console_struct.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 2c8d3239899b..fea64f2692a0 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -17,7 +17,6 @@
 #include <linux/vt.h>
 #include <linux/workqueue.h>
 
-struct vt_struct;
 struct uni_pagedir;
 struct uni_screen;
 
@@ -150,7 +149,7 @@ struct vc {
 	struct vc_data *d;
 	struct work_struct SAK_work;
 
-	/* might add  scrmem, vt_struct, kbd  at some time,
+	/* might add  scrmem, kbd  at some time,
 	   to have everything in one place - the disadvantage
 	   would be that vc_cons etc can no longer be static */
 };
-- 
2.18.0

