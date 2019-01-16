Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA64C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3C62082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbfAPFk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:40:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730832AbfAPFk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:40:56 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B81A4DAA9291EE2DB4D1;
        Wed, 16 Jan 2019 13:40:49 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 16 Jan 2019
 13:40:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] LSM: Make some functions static
Date:   Wed, 16 Jan 2019 13:33:53 +0800
Message-ID: <20190116053353.29320-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the follow sparse warning:

security/security.c:533:5: warning: symbol 'lsm_task_alloc' was not declared. Should it be static?
security/security.c:554:5: warning: symbol 'lsm_ipc_alloc' was not declared. Should it be static?
security/security.c:575:5: warning: symbol 'lsm_msg_msg_alloc' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/security.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/security.c b/security/security.c
index 9a98c52..750d3f3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -530,7 +530,7 @@ int lsm_inode_alloc(struct inode *inode)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-int lsm_task_alloc(struct task_struct *task)
+static int lsm_task_alloc(struct task_struct *task)
 {
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
@@ -551,7 +551,7 @@ int lsm_task_alloc(struct task_struct *task)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-int lsm_ipc_alloc(struct kern_ipc_perm *kip)
+static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
 {
 	if (blob_sizes.lbs_ipc == 0) {
 		kip->security = NULL;
@@ -572,7 +572,7 @@ int lsm_ipc_alloc(struct kern_ipc_perm *kip)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-int lsm_msg_msg_alloc(struct msg_msg *mp)
+static int lsm_msg_msg_alloc(struct msg_msg *mp)
 {
 	if (blob_sizes.lbs_msg_msg == 0) {
 		mp->security = NULL;
-- 
2.7.0


