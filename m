Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824581-2-8249168539416314025
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520824580; b=cr+ppa/G9JzjqnHBnK+XCBDt3vQEt/gMTLPyy0xPoMZfLFs
    Zo+6gP2NtD+tAhKBfJtiSAiunN+RdcN45p1OsdEsDM0s0tk2s/Zn8Jog9JeHqMpD
    0C0IxZBVriGMwO7yAw8lol+3jBLDoTEygd+UCcTPvzWO9KlVYFgvbvYDPLfgrbHV
    tYiTA7GIcDF0OfTTZU/OvzmS/D2P9cBolSSYRAWwQRaMTNWLEkj8x/f6FqPP6JKp
    02Wpw0zmfEo/YrXZPKkgX6n8j7zTsU5Gr5P2MUFIBftc33+PZKYoSOxWoUffbbtK
    54wBd+RYT+aQYGbB/PZglmn9EiyGcrWZOVWs1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824580; bh=KpiASXSAOpwNJna9rSG
    DzGx3zfHlPv7dLPaIfZ507Rc=; b=eDcEQYprMT41l9hHQd1AbT2rE21oGimiBTh
    HFqdY9yUKonvQgm5qCgNSmTwsjOwko04FMNEHQ26pdXR60eTE8uUAYJ1YNX6ret8
    USrz0MLb89p1aBlUgK0QZ93wHUOCU+OrpQgdj8TEKTlDBsK6+RbY60DP6Ev2wRH0
    brjlEreYa/2EF0Mo/JDqZzuxGOzxT5xJnIaauX+Wv96HYGey8JKgwiJGWHO8pkRa
    msHJ/bnQV9JPV2SviE5mtBq2bYJ48NUTh4FDAeltDDong+RZW00yxfm/lmaGC97D
    +m6HN8EN2XS/ZsGsget/9l6yuPa7cwdEfsBit5YeAww3+3iePtQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932446AbeCLDQQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:16:16 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41516 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932783AbeCLDHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:51 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Borislav Petkov" <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "Matthew Whitehead" <tedheadster@gmail.com>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "One Thousand Gnomes" <gnomes@lxorguk.ukuu.org.uk>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@kernel.org>,
        "Rik van Riel" <riel@redhat.com>, "Brian Gerst" <brgerst@gmail.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.130287871@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 03/76] x86/cpu: Factor out application of forced CPU caps
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 8bf1ebca215c262e48c15a4a15f175991776f57f upstream.

There are multiple call sites that apply forced CPU caps.  Factor
them into a helper.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Whitehead <tedheadster@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/623ff7555488122143e4417de09b18be2085ad06.1484705016.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/common.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -670,6 +670,16 @@ void cpu_detect(struct cpuinfo_x86 *c)
 	}
 }
 
+static void apply_forced_caps(struct cpuinfo_x86 *c)
+{
+	int i;
+
+	for (i = 0; i < NCAPINTS; i++) {
+		c->x86_capability[i] &= ~cpu_caps_cleared[i];
+		c->x86_capability[i] |= cpu_caps_set[i];
+	}
+}
+
 void get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 tfms, xlvl;
@@ -915,10 +925,7 @@ static void identify_cpu(struct cpuinfo_
 		this_cpu->c_identify(c);
 
 	/* Clear/Set all flags overriden by options, after probe */
-	for (i = 0; i < NCAPINTS; i++) {
-		c->x86_capability[i] &= ~cpu_caps_cleared[i];
-		c->x86_capability[i] |= cpu_caps_set[i];
-	}
+	apply_forced_caps(c);
 
 #ifdef CONFIG_X86_64
 	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
@@ -978,10 +985,7 @@ static void identify_cpu(struct cpuinfo_
 	 * Clear/Set all flags overriden by options, need do it
 	 * before following smp all cpus cap AND.
 	 */
-	for (i = 0; i < NCAPINTS; i++) {
-		c->x86_capability[i] &= ~cpu_caps_cleared[i];
-		c->x86_capability[i] |= cpu_caps_set[i];
-	}
+	apply_forced_caps(c);
 
 	/*
 	 * On SMP, boot_cpu_data holds the common feature set between
