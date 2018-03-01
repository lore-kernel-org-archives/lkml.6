Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2898263-1519909453-2-2844986617895136519
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909453; b=rimP3dBhrL5NkOTm23/maTBydSfc8ITSZlKi41tqayJkxao
    JtjBvW1b+I2LkcUu/rODGw5bITyroPq+L1ZZ8A1LU9KjlA8t3si34RUAZs28bz7X
    wHvJXYSezh/KGhUehAVDCl/U9YUNTj5uOrHZujIcg9PZEIs8WGwZnL74CUem60z0
    6m2OjhBAcTfu9tnWJeFPkL5i3xORfv8xKo3mwSvXEGUUrKv8ks58ftsqMRNem2Lf
    r1vt8OAn29QM+xDcJs3U/78u1qb3R34MeBwPFLM7nRRdGoMal7Gj0gjxE+jiXUCs
    ovraJkchhM/nlpPJHaJvCsaXOthGTi9kdrsBlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909453;
    bh=D9AfP0d9wigJX9FEBgA9gUNC1gw2wouMr9JGYC6sYGw=; b=Sa/DRRMOu3ap
    qoLSQgt3MMnvz8nKkKuvMTpM1oaifZ3BAn9LGxU1CbA4hxg7DxAx6jgl1nRouwel
    1pkJ+XlYkX3KvJYi1fAw9ej0Wc+Naohev8DP/oFv/Tljnb4a0F6JnVapn83FAwRm
    JYc3LVAQQ/nW8+xa+0bCh0PPbiinFhraPwemTQgXXYXuqLuJridgr7MX8pZEKS7w
    lcAvkFPuRlN1b/gTMc8V+a8r5ReY4RzMbXAAferHqhIrVsp5oSHh4C6Sp1Tf8HIH
    9VsxcN9V6NsWtPf4SisZELrx0mkItKLXYD/ljSu44c3pgMip2Jtv9PCqKAbpw2oa
    NzhZckaplA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jS2vTu6b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pp2V1MBp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jS2vTu6b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pp2V1MBp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031062AbeCANEI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:04:08 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38703 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030779AbeCAM7O (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:59:14 -0500
X-Google-Smtp-Source: AG47ELs85H+tl32PZBkIMa3V4Kigi0Zf6HyTmHw8UkQhJj9BfOvJ3NTTSk4fKsmbqVQ270daWcJHpQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 28/45] arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75
Date: Thu,  1 Mar 2018 20:54:05 +0800
Message-Id: <1519908862-11425-29-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit a65d219fe5dc upstream.

Hook up MIDR values for the Cortex-A72 and Cortex-A75 CPUs, since they
will soon need MIDR matches for hardening the branch predictor.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/cputype.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 26a68dd..0843b3f 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -75,7 +75,10 @@
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
 #define ARM_CPU_PART_CORTEX_A57		0xD07
+#define ARM_CPU_PART_CORTEX_A72		0xD08
 #define ARM_CPU_PART_CORTEX_A53		0xD03
+#define ARM_CPU_PART_CORTEX_A73		0xD09
+#define ARM_CPU_PART_CORTEX_A75		0xD0A
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -86,6 +89,9 @@
 
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
+#define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
+#define MIDR_CORTEX_A73 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A73)
+#define MIDR_CORTEX_A75 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A75)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 
-- 
2.7.4
