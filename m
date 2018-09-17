Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F28ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7B62086B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7B62086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeIQLjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:39:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726075AbeIQLjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:39:23 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8C7306B13E0BB;
        Mon, 17 Sep 2018 14:13:26 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Mon, 17 Sep 2018 14:13:24 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <jikos@kernel.org>
CC:     <hpa@zytor.com>, <x86@kernel.org>, <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/apm: Fix a unused function warning
Date:   Mon, 17 Sep 2018 14:01:06 +0800
Message-ID: <1537164066-39990-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

arch/x86/kernel/apm_32.c:1643:12: warning: proc_apm_show defined but not used [-Wunused-function]
 static int proc_apm_show(struct seq_file *m, void *v)

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/x86/kernel/apm_32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index ec00d1f..f7151cd 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1640,6 +1640,7 @@ static int do_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+#ifdef CONFIG_PROC_FS
 static int proc_apm_show(struct seq_file *m, void *v)
 {
 	unsigned short	bx;
@@ -1719,6 +1720,7 @@ static int proc_apm_show(struct seq_file *m, void *v)
 		   units);
 	return 0;
 }
+#endif
 
 static int apm(void *unused)
 {
-- 
1.7.12.4

