Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FF0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6875A2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6875A2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbeIUIr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:47:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53445 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727141AbeIUIr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:47:27 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9437A3E5BA254;
        Fri, 21 Sep 2018 11:00:42 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 11:00:42 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <bhe@redhat.com>
CC:     <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCHv2] kernel: kexec_file: remove some duplicated include file
Date:   Fri, 21 Sep 2018 10:48:18 +0800
Message-ID: <1537498098-19171-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We include kexec.h and slab.h twice in kexec_file.c. It's unnecessary.
hence just remove them.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 kernel/kexec_file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index c6a3b68..35cf0ad 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -25,8 +25,6 @@
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
-#include <linux/kexec.h>
-#include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
-- 
1.7.12.4

