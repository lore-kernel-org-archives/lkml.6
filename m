Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3184158-1518109987-2-9174553935426326316
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
    t=1518109987; b=eWWSKfK9EYAssr5g1cFqkeyR6eoxkQU64MbamnxYLQrVHUC
    pQs7Z3Vqi7KIQ+YaH1gONulBA4FJzq3JqzZYuvALCnjON5APX9LfiBzblYju9bA8
    IML5pD1My82Txwwns9qeSbPnyBpGsRIqTe81dpgVgpM3lEoJ+YZYdvBh/fmr3XNP
    A2+ABEtS2PJSyoKP7z/suAdIb3kD8cqA83h+OgNMxBKta7EDX6olWca1RxyyH0Kf
    739uVXJeskt6V2m+R3ncBYQZNKwTDfKp7mJsDX8MPEHzHNsV7pjCN4tLQ73mPaF+
    E9fVKJ7THkFguZ73FHp4bNo/uT8XHgxhaTi6/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518109987;
    bh=nPaQLkt+wCzTkteHee6D/MjjB6IR4KHCgNxIQJdK7Lk=; b=O3QwZ/b6Z9/R
    Y3R10kzpqee+IY/9KFmwt5xC9yuzYw9akPeZb5oS6EDnJaz1Z4/lgXVS7RfZHHhF
    1oi7OOpNY9+QVFQrxOnR6NXjL6wkhna/1FCspzeCvUhfwvOJnutjYeBY7E3sDoFi
    JVe7SaTKjnnCKLMmWtVax3rANdneg0r3Gwhv5+uh3mLjmGIdQONMSxBoS0xnbkGq
    HjNjDaNqaFi5/sER8DYwf+0gXmYpBNYJzjg6TFkRGnrLHZRbr633JT/wLSUMeXfN
    r6X1z/rEW4eVKG+SohUdJ7O1/1yPlCMFAOPqVzvYhMnpQW5z5syAXei15/dHzGEF
    +4cJZ2isAw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=docker.com header.i=@docker.com header.b=C5w94/46 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=docker.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BfAcHykC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=docker.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=docker.com header.i=@docker.com header.b=C5w94/46 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=docker.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BfAcHykC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=docker.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBHRM0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 12:12:26 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53952 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBHRMZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Feb 2018 12:12:25 -0500
X-Google-Smtp-Source: AH8x224WcUuFxAOOS9N3o99vIId5JD5l+xNVFbKQIV8rKrAcPipzuU6OoT3pwH2bFpV7p4/6B1A5Bw==
From: Rolf Neugebauer <rolf.neugebauer@docker.com>
To: gregkh@linuxfoundation.org
Cc: bp@alien8.de, zhang.jia@linux.alibaba.com, tglx@linutronix.de,
        tony.luck@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, stable@vger.kernel.org,
        Rolf Neugebauer <rolf.neugebauer@docker.com>
Subject: [PATCH 1/2] x86/microcode/AMD: Do not load when running on a hypervisor
Date: Thu,  8 Feb 2018 17:12:03 +0000
Message-Id: <20180208171204.62005-1-rolf.neugebauer@docker.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180208163940.GD9421@kroah.com>
References: <20180208163940.GD9421@kroah.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

commit a15a753539eca8ba243d576f02e7ca9c4b7d7042 upstream with minor
adjustments.

Doing so is completely void of sense for multiple reasons so prevent
it. Set dis_ucode_ldr to true and thus disable the microcode loader by
default to address xen pv guests which execute the AP path but not the
BSP path.

By having it turned off by default, the APs won't run into the loader
either.

Also, check CPUID(1).ECX[31] which hypervisors set. Well almost, not the
xen pv one. That one gets the aforementioned "fix".

Also, improve the detection method by caching the final decision whether
to continue loading in dis_ucode_ldr and do it once on the BSP. The APs
then simply test that value.

Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Juergen Gross <jgross@suse.com>
Link: http://lkml.kernel.org/r/20161218164414.9649-4-bp@alien8.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org> # 4.4.x
Signed-off-by: Rolf Neugebauer <rolf.neugebauer@docker.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b3e94ef461fd..1b3e0aa4c511 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -44,7 +44,7 @@
 
 static struct microcode_ops	*microcode_ops;
 
-static bool dis_ucode_ldr;
+static bool dis_ucode_ldr = true;
 
 static int __init disable_loader(char *str)
 {
@@ -81,6 +81,7 @@ struct cpu_info_ctx {
 
 static bool __init check_loader_disabled_bsp(void)
 {
+	u32 a, b, c, d;
 #ifdef CONFIG_X86_32
 	const char *cmdline = (const char *)__pa_nodebug(boot_command_line);
 	const char *opt	    = "dis_ucode_ldr";
@@ -93,8 +94,23 @@ static bool __init check_loader_disabled_bsp(void)
 	bool *res = &dis_ucode_ldr;
 #endif
 
-	if (cmdline_find_option_bool(cmdline, option))
-		*res = true;
+	if (!have_cpuid_p())
+		return *res;
+
+	a = 1;
+	c = 0;
+	native_cpuid(&a, &b, &c, &d);
+
+	/*
+	 * CPUID(1).ECX[31]: reserved for hypervisor use. This is still not
+	 * completely accurate as xen pv guests don't see that CPUID bit set but
+	 * that's good enough as they don't land on the BSP path anyway.
+	 */
+	if (c & BIT(31))
+		return *res;
+
+	if (cmdline_find_option_bool(cmdline, option) <= 0)
+		*res = false;
 
 	return *res;
 }
@@ -126,9 +142,6 @@ void __init load_ucode_bsp(void)
 	if (check_loader_disabled_bsp())
 		return;
 
-	if (!have_cpuid_p())
-		return;
-
 	vendor = x86_vendor();
 	family = x86_family();
 
@@ -162,9 +175,6 @@ void load_ucode_ap(void)
 	if (check_loader_disabled_ap())
 		return;
 
-	if (!have_cpuid_p())
-		return;
-
 	vendor = x86_vendor();
 	family = x86_family();
 
-- 
2.16.0
