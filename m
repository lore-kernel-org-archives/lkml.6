Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2183564-1519633475-2-7175657929928222393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519633475; b=FvhGPQqkqTeCVPN7hFoLdt5PN22ApHbLUEeDyL0g13kDzu7
    h4qJeiMNsLuEabuRn3OxYjhG1IVniSX52rG813fr/ujNAuccHnMAhdSiP5DFLGY7
    baDhU59AE+dgaMGGmqaRmKK9QP+u6XNecWb02McWje8Tak9FZf6aKFdiOmYfX1BV
    47OM42PTPRIb55k5K9LDzXMHgEQ2Qz4N3kFLPQrm1du0zwpreWlACC8RTeRK2NMk
    6o9mV67FzZsAB2kqOclCLx1zpz3zUeYXA4L1Y4UBKV1QAhR5wIsWXztv18RvuQyR
    tIswa+Cghpz47bnofaUqV99n90EynjwxQTZcyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519633475;
    bh=AHr70MZkEOaKFey+eCDJheezhRWSsRAnZ4+h4S16qZs=; b=nBnrh7mowT2V
    1/lKYM5guap3Q/ivqGI5vORoLFTOJMbmqqSGfI0tt9woYo47cJh1R2XTX6YD5wcc
    rnfodcNJYhXhrOynEmOz7qGbncOtNx6wbsUZfie6VU+kq9/9GaLs/G+CJeWZU8IZ
    fVG39W7XA9x3fGvd7VyeVL0G2WmoSnwbcppZparipYIsDXOnqrJQN5BLRL/O6ex/
    GMqYAbWDe3ce4y7Z4ZbsZpDCM6ykruNhB8ELscGrYrGOmkERGa+NnwFrDbKyw5Lk
    Pq++G8JsAtd4Neqw5kJ1KrMLHlwPrqCioT7ARE8+XORhPvFvA+3FbCbDUZ/1F8Mn
    WBixZoyddQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ZM7Kt5Bd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ietcv2gc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ZM7Kt5Bd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ietcv2gc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeBZIYa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:24:30 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33334 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeBZIY2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:24:28 -0500
X-Google-Smtp-Source: AH8x227WNqLHoZbeiA5SzQLySaFBd6bpHmYI4z8djmXNzox9kLOOHal+XtK+fy7bzq+UMQzKA9T6EQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 28/52] arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75
Date: Mon, 26 Feb 2018 16:20:02 +0800
Message-Id: <1519633227-29832-29-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
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

Conflicts:
	pick A73 too in arch/arm64/include/asm/cputype.h
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
