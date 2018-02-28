Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790356-2-4776293377013523525
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790356; b=YQTSxKf1eBok8wdF55UBlGwZaSEaMiIKM8Jxn5qA0fAm656
    W9xAt2R03pTiiMAXQYIrUrzb5aC5cz9yyy0A3Vek7sV5XWtarRoQ6IbaM+R9U1JB
    pEFNZBRLIONixI6WqtFGSMvqH7zLHdCyFFabf5t2+wbHK3S3ankzElCkJ6axjOUZ
    TvPDD/Gb3iHhn6+b9HM2/Ulo09b9IReWqY8zV0wtE6YCV0HvrHpIPTr/ZzFQqcFx
    Bkyov5R406Y4umJlxLI5nqr3EqgQVZJAVHi6yJt64XELTX2pvyV6Y8D7ehSAUw+B
    UH3e7IUdEAbuwzIx1npiARbTDkSpoESgAbC7Xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790356;
    bh=pUvcFHZB0gmxXIk6KYrb0J8r+/ie6VTOJuvKP5z63GU=; b=shbbBI7Kkt6w
    xkLZG1rwm7ueN2FFIINkmHmM5fY5CPh2UJQL3EqDV+Gva579ApimRsO0A94p7mCg
    6iZB80wIuLRaPwAcARKnQUfslFIbICPq9HN5oNIZVVNWCC3HNnBxGuCWMCJ9fsil
    U3Oo+4wyvLgy+UnbHiftU6k/c21gpWx23AHyHIafUu+zVuocAWnumYlqcQn4WEs5
    I06PzQF0WJkGnRR7PMvaKTUXhpkq3eEE1jiwSl8WCd7zsIsMXoJURfwpJrlrw80c
    jB/83PoMfj+O6+J6fwNvd35Er4nqgIlIvUEbmO4FINMyQ5IkWv8IPEvQuIVFQrXZ
    o0pOSbVkaw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=TSxrL4HE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BcVP9n7O;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=TSxrL4HE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BcVP9n7O;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeB1D7L (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:59:11 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36249 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeB1D7J (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:59:09 -0500
X-Google-Smtp-Source: AH8x227FTjYlIlGZG+/GmZtgoxqLjJhRMcRqc4G1Pq8cN6Wkx9vS+CDp5b5WvdEF6EueOVgXMGAyEw==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 13/29] arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks
Date: Wed, 28 Feb 2018 11:56:35 +0800
Message-Id: <1519790211-16582-14-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 18011eac28c7 upstream.

When unmapping the kernel at EL0, we use tpidrro_el0 as a scratch register
during exception entry from native tasks and subsequently zero it in
the kernel_ventry macro. We can therefore avoid zeroing tpidrro_el0
in the context-switch path for native tasks using the entry trampoline.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	fold tls_preserve_current_state() in arch/arm64/kernel/process.c
---
 arch/arm64/kernel/process.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 0e73949..0972ce5 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -306,17 +306,17 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 static void tls_thread_switch(struct task_struct *next)
 {
-	unsigned long tpidr, tpidrro;
+	unsigned long tpidr;
 
 	tpidr = read_sysreg(tpidr_el0);
 	*task_user_tls(current) = tpidr;
 
-	tpidr = *task_user_tls(next);
-	tpidrro = is_compat_thread(task_thread_info(next)) ?
-		  next->thread.tp_value : 0;
+	if (is_compat_thread(task_thread_info(next)))
+		write_sysreg(next->thread.tp_value, tpidrro_el0);
+	else if (!arm64_kernel_unmapped_at_el0())
+		write_sysreg(0, tpidrro_el0);
 
-	write_sysreg(tpidr, tpidr_el0);
-	write_sysreg(tpidrro, tpidrro_el0);
+	write_sysreg(*task_user_tls(next), tpidr_el0);
 }
 
 /* Restore the UAO state depending on next's addr_limit */
-- 
2.7.4
