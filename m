Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184658-2-12035653292486935260
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184657; b=DmSHadbzPHJ+ZObRlneUIYXy5LBTx4nVxPNeX3/Zl7W2lC1
    vGXdkgrQhbNXqoP/QnqRu+uVYsnblUqdTzlZsqyi8SBF54xtbCDIF07r23cToN+g
    zKFH/BGmazNlYX3A/BbxLqB+8gP6NVpE7aArfjWPhSFTfhecm3gQVLJRykyMfEeb
    QA9gVPpLeWXcvmqrs/+RLj/+f+5Xxd1ZmnQtlc6ZAMd07lZCVkdTQMJPpjOxK0HW
    UUBtkN7H7i3Knw/Xq+/IpnnaTRgqJV2Get85IsSfPAEFAqFA/vyCc02nYYW1ZXV1
    HfS+hOASLcAWM789ZJz3TIkdAQp+w5QT69tdQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184657; bh=zN6QCVId6DZR01HS+Rrj12U4p7
    o/7/qKHkpPmJHCO3I=; b=XKf9aZUoBHy9j5iC2Ws+EnIF+AIbKruCnkUED9XbM/
    fBm/qpwdDQmJKENye9edOvkgcfqEz40eLBgC8ftIv6XeVypwDcmtsQOWp0YRQQ0U
    2aB1A07CRtkJbd/42ulNFI7T9pzAyH4cfLX3YujmaMY7xmQLwpQ9YqpJO1ezx6Cv
    WzWDi0eJrDNydmGL3hY6nBvnrupqdH8KC2LMlC2GGOLYsWpRQ0I7hiJAg44Wr4DY
    FQGrCSA6c4RUkqhuK2LAKwGNr9HmWcdv8QedKcHO+RYacHRxR+r4H2fwm5pxJv2O
    ITd9h205X4nauYqrsPPw1MISKdcwAMJyHg9zCLQAM0mQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbeBINoz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:44:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeBINox (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Rolf Neugebauer <rolf.neugebauer@docker.com>
Subject: [PATCH 4.9 92/92] x86/microcode: Do the family check first
Date: Fri,  9 Feb 2018 14:40:01 +0100
Message-Id: <20180209133937.642673187@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Rolf Neugebauer <rolf.neugebauer@docker.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/core.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -86,9 +86,6 @@ static bool __init check_loader_disabled
 	bool *res = &dis_ucode_ldr;
 #endif
 
-	if (!have_cpuid_p())
-		return *res;
-
 	a = 1;
 	c = 0;
 	native_cpuid(&a, &b, &c, &d);
@@ -130,8 +127,9 @@ void __init load_ucode_bsp(void)
 {
 	int vendor;
 	unsigned int family;
+	bool intel = true;
 
-	if (check_loader_disabled_bsp())
+	if (!have_cpuid_p())
 		return;
 
 	vendor = x86_cpuid_vendor();
@@ -139,16 +137,27 @@ void __init load_ucode_bsp(void)
 
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
