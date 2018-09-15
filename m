Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130EDECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC97F208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 08:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC97F208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeIONkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 09:40:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47995 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeIONkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 09:40:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8F8LpKT3752058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 Sep 2018 01:21:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8F8LpFU3752055;
        Sat, 15 Sep 2018 01:21:51 -0700
Date:   Sat, 15 Sep 2018 01:21:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Randy Dunlap <tipbot@zytor.com>
Message-ID: <tip-002b87d2aace62b4f3841c3aa43309d2380092be@git.kernel.org>
Cc:     jikos@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        rdunlap@infradead.org, tglx@linutronix.de, hch@lst.de,
        hpa@zytor.com
Reply-To: hch@lst.de, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, rdunlap@infradead.org,
          mingo@kernel.org, jikos@kernel.org
In-Reply-To: <be39ac12-44c2-4715-247f-4dcc3c525b8b@infradead.org>
References: <be39ac12-44c2-4715-247f-4dcc3c525b8b@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/APM: Fix build warning when PROC_FS is not
 enabled
Git-Commit-ID: 002b87d2aace62b4f3841c3aa43309d2380092be
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  002b87d2aace62b4f3841c3aa43309d2380092be
Gitweb:     https://git.kernel.org/tip/002b87d2aace62b4f3841c3aa43309d2380092be
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Fri, 14 Sep 2018 15:10:29 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 15 Sep 2018 10:16:25 +0200

x86/APM: Fix build warning when PROC_FS is not enabled

Fix build warning in apm_32.c when CONFIG_PROC_FS is not enabled:

../arch/x86/kernel/apm_32.c:1643:12: warning: 'proc_apm_show' defined but not used [-Wunused-function]
 static int proc_apm_show(struct seq_file *m, void *v)

Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Jiri Kosina <jikos@kernel.org>
Link: https://lkml.kernel.org/r/be39ac12-44c2-4715-247f-4dcc3c525b8b@infradead.org


---
 arch/x86/kernel/apm_32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index ec00d1ff5098..f7151cd03cb0 100644
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
