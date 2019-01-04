Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21483C43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E594B2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfADAxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:53:47 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:42058 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbfADAxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:53:46 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id EB3507023EC736F8EB75;
        Fri,  4 Jan 2019 08:53:43 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x040rcHd004679;
        Fri, 4 Jan 2019 08:53:38 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019010408541302-20344947 ;
          Fri, 4 Jan 2019 08:54:13 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  security/apparmor/domain: use PTR_ERR_OR_ZERO
Date:   Fri, 4 Jan 2019 17:17:10 +0800
Message-Id: <1546593430-24355-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-04 08:54:13,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-04 08:53:23,
        Serialize complete at 2019-01-04 08:53:23
X-MAIL: mse01.zte.com.cn x040rcHd004679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'new' may be NULL, so use PTR_ERR_OR_ZERO instead
of PTR_ERR.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 security/apparmor/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 08c88de..7663589 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -1444,7 +1444,7 @@ int aa_change_profile(const char *fqname, int flags)
 			new = aa_label_merge(label, target, GFP_KERNEL);
 		if (IS_ERR_OR_NULL(new)) {
 			info = "failed to build target label";
-			error = PTR_ERR(new);
+			error = PTR_ERR_OR_ZERO(new);
 			new = NULL;
 			perms.allow = 0;
 			goto audit;
-- 
1.8.3.1

