Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7B2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D0F20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D0F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbeKGS22 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:28:28 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:49228 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbeKGS21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:28:27 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 0EA5F53F0717C37BBBB0;
        Wed,  7 Nov 2018 16:53:00 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wA78qnc4003905;
        Wed, 7 Nov 2018 16:52:49 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018110716531155-9176894 ;
          Wed, 7 Nov 2018 16:53:11 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        suravee.suthikulpanit@amd.com, puwen@hygon.cn,
        davidwang@zhaoxin.com, wang.yi59@zte.com.cn,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk,
        gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
        fenghua.yu@intel.com, pbonzini@redhat.com, konrad.wilk@oracle.com,
        zhong.weidong@zte.com.cn
Subject: [PATCH 2/3] x86/cpu: fix prototype warning in scattered.c
Date:   Wed, 7 Nov 2018 16:54:36 +0800
Message-Id: <1541580877-45723-3-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541580877-45723-1-git-send-email-wang.yi59@zte.com.cn>
References: <1541580877-45723-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-07 16:53:11,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-07 16:52:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn wA78qnc4003905
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing include file causes warning:
arch/x86/kernel/cpu/scattered.c:37:6: warning: no previous prototype for ‘init_scattered_cpuid_features’ [-Wmissing-prototypes]
arch/x86/kernel/cpu/scattered.c:60:5: warning: no previous prototype for ‘get_scattered_cpuid_leaf’ [-Wmissing-prototypes]

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 arch/x86/kernel/cpu/scattered.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 772c219..5b6866f 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -9,6 +9,8 @@
 
 #include <asm/apic.h>
 
+#include "cpu.h"
+
 struct cpuid_bit {
 	u16 feature;
 	u8 reg;
-- 
1.8.3.1

