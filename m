Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3184158-1518109952-2-12352631436865127741
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518109952; b=sN8tiMqIq7Lp19yj7BpAWbw+GxrvBTB65ID0J7GUVNt9ifS
    0QRn24uh8qMnPoRS2D92oSBOFgiKvP8e+JOM9Ht/hf0/r+IcdBpH41CxnEbLlkWd
    2k9+KX+H//h7oxqvYcHNNQlzGJNJz+h3loOJefEOx75Trs8x0VYZOmvt09Ef+kxE
    Bwxqq0vM8b6k3Ouizwp7sSwJjPquT+Ks5PRdDYXa7HWsA27fZ/ZyEGsmRcG5P7Vp
    a69Mew14zzqgP3Y0Zwi/rD5cUmcwyX5sDD1icnykh6wqMDsyWo3VASGi92pRdcTH
    nO+Bcji9h0lI8ZVu6SS3zRGcVgu/N91kWJ5cXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518109952;
    bh=VvbZWZdnnJg3BJHEm5YpUv953Npw5yOZqf7lCP0FyCE=; b=KWFSYiywl216
    s5yYPTkXXfxcUTAs8inDvC35wUdZrMOqMQ/k6yvUQwmRJ9yFk8xzG57OLtUi1qi+
    GAvTdQ9uSybI0A3Oxhgg83Mn7ojc3SVebujZKuvXBmZ5gJPCGXWeS2M88fiCvUoX
    AXRQnJ9boWuOJ8FD3nI/wLTfq81KwKXj6LB0D9BBV4a5p3/2WtmB5DxiCLiZ+8xL
    ENTfIzMRwV7oYMOSJNhkWDfkru6gllrjMcLG+PShw4KejCqXghJR8QK1maeyIltn
    OLV7mJg/+StfIc/w2C4rE+klprhCLPMGZPU0fWRqjBSVqm1Iv4toWsnTG4PkRK2p
    qToBDUCyMQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=docker.com header.i=@docker.com header.b=FWI6vKmk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=docker.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=k5IcMdYM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=docker.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=docker.com header.i=@docker.com header.b=FWI6vKmk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=docker.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=k5IcMdYM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=docker.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBHRM3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 12:12:29 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46024 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752058AbeBHRM1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Feb 2018 12:12:27 -0500
X-Google-Smtp-Source: AH8x227ZLnvVK/kPLputZo+U6Vyj3Ufl/tEniQrNSryl7wQ4Zjp+GSqvyzHKIdKQy6sIaRxCBufRWg==
From: Rolf Neugebauer <rolf.neugebauer@docker.com>
To: gregkh@linuxfoundation.org
Cc: bp@alien8.de, zhang.jia@linux.alibaba.com, tglx@linutronix.de,
        tony.luck@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Rolf Neugebauer <rolf.neugebauer@docker.com>
Subject: [PATCH 2/2] x86/microcode: Do the family check first
Date: Thu,  8 Feb 2018 17:12:04 +0000
Message-Id: <20180208171204.62005-2-rolf.neugebauer@docker.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180208171204.62005-1-rolf.neugebauer@docker.com>
References: <20180208163940.GD9421@kroah.com>
 <20180208171204.62005-1-rolf.neugebauer@docker.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

commit 1f161f67a272cc4f29f27934dd3f74cb657eb5c4 upstream with adjustments.

On CPUs like AMD's Geode, for example, we shouldn't even try to load
microcode because they do not support the modern microcode loading
interface.

However, we do the family check *after* the other checks whether the
loader has been disabled on the command line or whether we're running in
a guest.

So move the family checks first in order to exit early if we're being
loaded on an unsupported family.

Reported-and-tested-by: Sven Glodowski <glodi1@arcor.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # 4.11..
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://bugzilla.suse.com/show_bug.cgi?id=1061396
Link: http://lkml.kernel.org/r/20171012112316.977-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org> # 4.4.x
Signed-off-by: Rolf Neugebauer <rolf.neugebauer@docker.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 1b3e0aa4c511..ce5f8a2e7ae6 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -94,9 +94,6 @@ static bool __init check_loader_disabled_bsp(void)
 	bool *res = &dis_ucode_ldr;
 #endif
 
-	if (!have_cpuid_p())
-		return *res;
-
 	a = 1;
 	c = 0;
 	native_cpuid(&a, &b, &c, &d);
@@ -138,8 +135,9 @@ void __init load_ucode_bsp(void)
 {
 	int vendor;
 	unsigned int family;
+	bool intel = true;
 
-	if (check_loader_disabled_bsp())
+	if (!have_cpuid_p())
 		return;
 
 	vendor = x86_vendor();
@@ -147,16 +145,27 @@ void __init load_ucode_bsp(void)
 
 	switch (vendor) {
 	case X86_VENDOR_INTEL:
-		if (family >= 6)
-			load_ucode_intel_bsp();
+		if (family < 6)
+			return;
 		break;
+
 	case X86_VENDOR_AMD:
-		if (family >= 0x10)
-			load_ucode_amd_bsp(family);
+		if (family < 0x10)
+			return;
+		intel = false;
 		break;
+
 	default:
-		break;
+		return;
 	}
+
+	if (check_loader_disabled_bsp())
+		return;
+
+	if (intel)
+		load_ucode_intel_bsp();
+	else
+		load_ucode_amd_bsp(family);
 }
 
 static bool check_loader_disabled_ap(void)
-- 
2.16.0
