Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45628C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEC720856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfA2LI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:08:59 -0500
Received: from mx133-tc.baidu.com ([61.135.168.133]:27663 "EHLO
        tc-sys-mailedm01.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726744AbfA2LI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:08:59 -0500
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm01.tc.baidu.com (Postfix) with ESMTP id 597F82040041;
        Tue, 29 Jan 2019 19:08:42 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH] XArray tests: allocation has to be GFP_ATOMIC under rcu_read_lock
Date:   Tue, 29 Jan 2019 19:08:42 +0800
Message-Id: <1548760122-13000-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 lib/test_xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index c596a957f764..5b671c83b73d 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -108,7 +108,7 @@ static noinline void check_xas_retry(struct xarray *xa)
 	XA_BUG_ON(xa, xas_next_entry(&xas, ULONG_MAX) != xa_mk_value(0));
 	XA_BUG_ON(xa, xas.xa_node != NULL);
 
-	XA_BUG_ON(xa, xa_store_index(xa, 1, GFP_KERNEL) != NULL);
+	XA_BUG_ON(xa, xa_store_index(xa, 1, GFP_ATOMIC) != NULL);
 	XA_BUG_ON(xa, !xa_is_internal(xas_reload(&xas)));
 	xas.xa_node = XAS_RESTART;
 	XA_BUG_ON(xa, xas_next_entry(&xas, ULONG_MAX) != xa_mk_value(0));
-- 
2.16.2

