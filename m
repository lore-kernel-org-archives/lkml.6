Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5D5C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C83F21904
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392403AbfBMS4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:56:53 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:10059 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730942AbfBMS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:56:51 -0500
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 13 Feb 2019 10:56:49 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 91600B221C;
        Wed, 13 Feb 2019 13:56:50 -0500 (EST)
From:   Nadav Amit <namit@vmware.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Linux-MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>
Subject: [PATCH] pid: remove next_pidmap() declaration
Date:   Wed, 13 Feb 2019 03:37:36 -0800
Message-ID: <20190213113736.21922-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 95846ecf9dac ("pid: replace pid bitmap implementation with IDR API")
removed next_pidmap() but left its declaration.

Remove it. No functional change.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Gargi Sharma <gs051095@gmail.com>
Fixes: 95846ecf9dac ("pid: replace pid bitmap implementation with IDR API")
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/pid.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 14a9a39da9c7..b6f4ba16065a 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -109,7 +109,6 @@ extern struct pid *find_vpid(int nr);
  */
 extern struct pid *find_get_pid(int nr);
 extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
-int next_pidmap(struct pid_namespace *pid_ns, unsigned int last);
 
 extern struct pid *alloc_pid(struct pid_namespace *ns);
 extern void free_pid(struct pid *pid);
-- 
2.17.1

