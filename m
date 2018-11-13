Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E40C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF55F223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF55F223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbeKMOek convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:34:40 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:22946 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeKMOek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:34:40 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 73A8FC4862DAD13EEC12;
        Tue, 13 Nov 2018 12:38:20 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAD4cHHQ097140;
        Tue, 13 Nov 2018 12:38:17 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018111312382992-10341810 ;
          Tue, 13 Nov 2018 12:38:29 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        pasha.tatashin@oracle.com, wang.yi59@zte.com.cn,
        rajvi.jingar@intel.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, bp@suse.de
Subject: [PATCH] x86/tsc: Fix -Wmissing-prototypes warning for calibrate_delay_is_known()
Date:   Tue, 13 Nov 2018 12:40:05 +0800
Message-Id: <1542084005-16416-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-13 12:38:30,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-13 12:38:13
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn wAD4cHHQ097140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning when building kernel with W=1:
arch/x86/kernel/tsc.c:1497:15: warning: no previous prototype for ‘calibrate_delay_is_known’ [-Wmissing-prototypes]
 unsigned long calibrate_delay_is_known(void)
               ^

Add the missing declaration in head file to fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 arch/x86/include/asm/tsc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index eb5bbfe..8a0c25c 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -35,6 +35,7 @@ static inline cycles_t get_cycles(void)
 
 extern void tsc_early_init(void);
 extern void tsc_init(void);
+extern unsigned long calibrate_delay_is_known(void);
 extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
 extern int check_tsc_unstable(void);
-- 
1.8.3.1

