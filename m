Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E83C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B33214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B33214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeLFBT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:19:29 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:65404 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbeLFBT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:19:29 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 7C3496A9E8452192936F;
        Thu,  6 Dec 2018 09:19:27 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB61JM6A044245;
        Thu, 6 Dec 2018 09:19:22 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120609194970-15007981 ;
          Thu, 6 Dec 2018 09:19:49 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Alessandro Rubini <rubini@gnudd.com>
Cc:     linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] drivers/fmc: Remove unnecessary NULL check before debugfs_remove_recursive
Date:   Thu, 6 Dec 2018 09:19:17 +0800
Message-Id: <20181206011917.32154-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-06 09:19:50,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-06 09:19:11
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB61JM6A044245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs=5Fremove=5Frecursive() accepts a NULL parameter and returns
immediately, there's no need for a NULL check in the caller.

This issue was detected with the help of Coccinelle.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Alessandro Rubini <rubini@gnudd.com>
CC: linux-kernel@vger.kernel.org
---
 drivers/fmc/fmc-debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/fmc/fmc-debug.c b/drivers/fmc/fmc-debug.c
index 32930722770c..ab868a35e221 100644
--- a/drivers/fmc/fmc-debug.c
+++ b/drivers/fmc/fmc-debug.c
@@ -168,6 +168,5 @@ int fmc=5Fdebug=5Finit(struct fmc=5Fdevice *fmc)
=20
 void fmc=5Fdebug=5Fexit(struct fmc=5Fdevice *fmc)
 {
-	if (fmc->dbg=5Fdir)
-		debugfs=5Fremove=5Frecursive(fmc->dbg=5Fdir);
+	debugfs=5Fremove=5Frecursive(fmc->dbg=5Fdir);
 }
--=20
2.19.1

