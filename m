Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872EFECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BFF206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BFF206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeGTITd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:19:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbeGTITc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:19:32 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 06932C7A24D7A;
        Fri, 20 Jul 2018 15:32:34 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Fri, 20 Jul 2018
 15:32:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
        <pombredanne@nexb.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] x86: use PTR_ERR_OR_ZERO to fix ptr_ret.cocci warning
Date:   Fri, 20 Jul 2018 15:32:13 +0800
Message-ID: <20180720073213.14996-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptr_ret.cocci warnings:
  arch/x86/kernel/pcspeaker.c:12:8-14: WARNING: PTR_ERR_OR_ZERO can be used

use PTR_ERR_OR_ZERO rather than an open-code version to fix this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/x86/kernel/pcspeaker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pcspeaker.c b/arch/x86/kernel/pcspeaker.c
index da5190a..4a710ff 100644
--- a/arch/x86/kernel/pcspeaker.c
+++ b/arch/x86/kernel/pcspeaker.c
@@ -9,6 +9,6 @@ static __init int add_pcspkr(void)
 
 	pd = platform_device_register_simple("pcspkr", -1, NULL, 0);
 
-	return IS_ERR(pd) ? PTR_ERR(pd) : 0;
+	return PTR_ERR_OR_ZERO(pd);
 }
 device_initcall(add_pcspkr);
-- 
2.7.0


