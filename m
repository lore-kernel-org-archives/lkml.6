Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BA7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7128920862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7128920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbeKGS15 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:27:57 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:48786 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbeKGS14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:27:56 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 7A8B1EE387A539D56066;
        Wed,  7 Nov 2018 16:52:56 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wA78qkMS003847;
        Wed, 7 Nov 2018 16:52:46 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018110716530885-9176881 ;
          Wed, 7 Nov 2018 16:53:08 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        suravee.suthikulpanit@amd.com, puwen@hygon.cn,
        davidwang@zhaoxin.com, wang.yi59@zte.com.cn,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk,
        gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
        fenghua.yu@intel.com, pbonzini@redhat.com, konrad.wilk@oracle.com,
        zhong.weidong@zte.com.cn
Subject: [PATCH 1/3] x86/cpu: fix prototype warning in cacheinfo.c
Date:   Wed, 7 Nov 2018 16:54:35 +0800
Message-Id: <1541580877-45723-2-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541580877-45723-1-git-send-email-wang.yi59@zte.com.cn>
References: <1541580877-45723-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-07 16:53:09,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-07 16:52:38
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn wA78qkMS003847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing include file causes warning:
arch/x86/kernel/cpu/cacheinfo.c:647:6: warning: no previous prototype for ‘cacheinfo_amd_init_llc_id’ [-Wmissing-prototypes]
arch/x86/kernel/cpu/cacheinfo.c:686:6: warning: no previous prototype for ‘cacheinfo_hygon_init_llc_id’ [-Wmissing-prototypes]

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 arch/x86/kernel/cpu/cacheinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index dc1b934..5bafd93 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -19,6 +19,7 @@
 #include <asm/cpufeature.h>
 #include <asm/amd_nb.h>
 #include <asm/smp.h>
+#include <asm/cacheinfo.h>
 
 #include "cpu.h"
 
-- 
1.8.3.1

