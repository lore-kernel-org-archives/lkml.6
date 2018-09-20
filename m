Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C2CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBD62146E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFuO991U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBD62146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbeIUCa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:30:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44886 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:30:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id d131-v6so6630312qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AD+NjC4OILLMNYqw8gBfzMFWrkc1Q+NA4r7e2oixdgo=;
        b=lFuO991UMYfRvJNry30DVUGMYoMXwU6mcizEQtgFJPNsvnXVWEoNgHmDHcjwOMyMB/
         LdXQ7oR3ZsE7vGcl9hLbs1UabwUKWEibbn3e9vYyc+9J2kQfQJPkHPkB3hE4z1RTcAaV
         e9ejXohDVqe/BRVrg4KNgwTQZhVyZhXBei0kK/bPLSzNjaJXu3/gQQzXdhYxoeq5MeI0
         bX736GW5FVZX/fJZ1ZSkd4feZ8/aqxZv4JxdxiHep+Rr/IFWyqSAEVakXzgAsHFYTS2h
         c4oajar/y6WGKAu4CobU+7Cjhw58tO5n4W/kNMJ5uZFbmTmS6Ok0vF/CGeS2Ea8J6yNB
         DBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AD+NjC4OILLMNYqw8gBfzMFWrkc1Q+NA4r7e2oixdgo=;
        b=W5dYCgP7T+U8ZlzuDAmjYNvHHxb+R+CKHaU6pyCnLCIL8LpTKjhjCN8pREbeLIS9My
         ahKe6Xf5n8p2eTa0nAVMWByHDpYW+aUD+rlbK0VtTcTwn9D/NqMc2WZYltVYos+mMMoQ
         dSCiTgXeacIAvtUZmtuU7o59Nh6llw+tGoosjRRmkBs+UDhGZrsGqOdXyrmD/O+c8+bp
         aKsba6znuBlbyxsfcoax+z4PX6UbrJi+R3tttKF9AR1CQ5klg099N+yXo9eUpe1rDTz6
         gS1vZS9FzrNJ5+lQKKeythYf4nnCwz+4cuWhy1PIUkNIFULFe9Rh1JbByrlhUzZdAzz6
         SeZw==
X-Gm-Message-State: APzg51AVmeGex8MU8UmDREQf4WeeTCNmTK8dL87mG1OMc9hPJQsptuvr
        0TKDh2eMx2H1kgWlk4Tg9lWE1cE=
X-Google-Smtp-Source: ANB0VdZuiR8TnHebQdAauSxSY67MB/j83qhqM86N+24mzztoPrUIMnzxOjXb2JacKwIxJWSSZE+qog==
X-Received: by 2002:a37:79c5:: with SMTP id u188-v6mr28910848qkc.82.1537476306326;
        Thu, 20 Sep 2018 13:45:06 -0700 (PDT)
Received: from mwhitehe.remote.csb (ip-107-53-162-92.nymnny.spcsdns.net. [107.53.162.92])
        by smtp.gmail.com with ESMTPSA id k3-v6sm13768251qtm.12.2018.09.20.13.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:45:05 -0700 (PDT)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        luto@amacapital.net, bp@alien8.de, hpa@zytor.com,
        Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH] x86/cpu: Enable cpuid instruction on Cyrix 6x86/6x86L processors
Date:   Thu, 20 Sep 2018 16:44:52 -0400
Message-Id: <1537476292-28056-1-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On power up, the cpuid instruction is disabled on Cyrix 6x86 and 6x86L
processors and it needs to be enabled. There is code to do this, but it
does not work because it uses the broken {set,get}Cx86_old() macros.

There are comments in processor-cyrix.h advising you to _not_ make calls
using the deprecated macros in this style:

  setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);

This is because it expands the macro into a non-functioning calling
sequence. The new macros fix this problem, so we use them instead.

We also need to forcibly enable X86_FEATURE_CPUID. This is because
early_identify_cpu() does not know that the call to
identify_cpu_without_cpuid() actually enables the cpuid instruction in the
odd Cyrix case, and it turns X86_FEATURE_CPUID off after it has just been
enabled on the processor.

This was tested on actual Cyrix hardware.

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
---
 arch/x86/kernel/cpu/cyrix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 8949b7a..e603cc5 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -437,10 +437,11 @@ static void cyrix_identify(struct cpuinfo_x86 *c)
 			/* enable MAPEN  */
 			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);
 			/* enable cpuid  */
-			setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);
+			setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x80);
 			/* disable MAPEN */
 			setCx86(CX86_CCR3, ccr3);
 			local_irq_restore(flags);
+			setup_force_cpu_cap(X86_FEATURE_CPUID);
 		}
 	}
 }
-- 
1.8.3.1

