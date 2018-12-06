Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE498C07E85
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638AF214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638AF214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeLFBJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:09:33 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:7790 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbeLFBJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:09:32 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 4118F4AFD19892376DF3;
        Thu,  6 Dec 2018 09:09:27 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB619KFv034498;
        Thu, 6 Dec 2018 09:09:20 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120609094780-15005750 ;
          Thu, 6 Dec 2018 09:09:47 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] platform/x86: intel_ips: Remove unnecessary NULL check before debugfs_remove_recursive
Date:   Thu, 6 Dec 2018 09:09:14 +0800
Message-Id: <20181206010914.21964-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-06 09:09:48,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-06 09:09:09
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB619KFv034498
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs=5Fremove=5Frecursive() accepts a NULL parameter and returns
immediately, there's no need for a NULL check in the caller.

This issue was detected with the help of Coccinelle.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Darren Hart <dvhart@infradead.org>
CC: Andy Shevchenko <andy@infradead.org>
CC: platform-driver-x86@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/platform/x86/intel=5Fips.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel=5Fips.c b/drivers/platform/x86/inte=
l=5Fips.c
index 225638a1b09e..f8175b972537 100644
--- a/drivers/platform/x86/intel=5Fips.c
+++ b/drivers/platform/x86/intel=5Fips.c
@@ -1300,9 +1300,7 @@ static const struct file=5Foperations ips=5Fdebugfs=
=5Fops =3D {
=20
 static void ips=5Fdebugfs=5Fcleanup(struct ips=5Fdriver *ips)
 {
-	if (ips->debug=5Froot)
-		debugfs=5Fremove=5Frecursive(ips->debug=5Froot);
-	return;
+	debugfs=5Fremove=5Frecursive(ips->debug=5Froot);
 }
=20
 static void ips=5Fdebugfs=5Finit(struct ips=5Fdriver *ips)
--=20
2.19.1

