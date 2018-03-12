Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826222-2-14912308703126111136
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
    t=1520826221; b=Lz4tmDlT+v3mS/C8wMCIvaW3mReJF0Na95kRbGzarQKse+7
    +QKfsXRiuUizd0lXqaqy5IVswL2jz59rYaOkeAxkZOg5QScTc4/Ug3Xcr0SuabCC
    yYQN+lNS4wQKJapYLAAeb4X2ksxl830ohT9hj/VlWWFRczDoSuSen16pfINz0H5d
    ASOZJ5IdFYw11/ffRpostOsE+0qIt+yTb8juRC4MQjw6NkDQYTO8QXTrxu9wlwv2
    ir+a1Z9EHM7bRfgJn2sSXDUXFbw4BqcqZDBMUsCIgLLzk55y4hOzgyKoGpmb5Qna
    WIKEUHazUBLM+3mMwq/g1Dm0vSm3fKgjR0WzSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826221; bh=QpFduA92K6NlfBz7hyc
    sbsJVcnT1AY9oipYxTAk4sSI=; b=EXEaMs8Hc74E+Fq7KIdS7aA67VKyQpHuG4I
    qv71od56Gsg+5G2Jue9ZzstkHcvBjw9kH9fM55jUd3/t4cnUfN8T+HvVCpE5I26V
    0a+BFqF1b0BrnwstoJaYDunqh9gdpIUK0WwjU5q1GSkTAFBd05Kq8GaV/rZUF096
    93srPOoBhRLsrFOZhkoAmt/v6ltBTQqcAossenzJx6qXkJRbDPhI1C7gctYMckqX
    p1y2dwbYI4MqiOktnBHiTjCLBTJ9Dal3lJXZEubIckYgtFTzFdAFAjMQlgm5nKsS
    Qj3lqpaUv9Qp07zWtQYvJO1zWPVS76kCTwYF2FPgYCyCHnxwgEg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S933083AbeCLDmD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:42:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41160 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932660AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Rik van Riel" <riel@redhat.com>,
        "Matthew Whitehead" <tedheadster@gmail.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "One Thousand Gnomes" <gnomes@lxorguk.ukuu.org.uk>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "Borislav Petkov" <bp@suse.de>, "Oleg Nesterov" <oleg@redhat.com>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.524396514@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 039/104] x86/cpu: Factor out application of forced CPU
 caps
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/common.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -632,6 +632,16 @@ void __cpuinit cpu_detect(struct cpuinfo
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
 void __cpuinit get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 tfms, xlvl;
@@ -880,10 +890,7 @@ static void __cpuinit identify_cpu(struc
 		this_cpu->c_identify(c);
 
 	/* Clear/Set all flags overriden by options, after probe */
-	for (i = 0; i < NCAPINTS; i++) {
-		c->x86_capability[i] &= ~cpu_caps_cleared[i];
-		c->x86_capability[i] |= cpu_caps_set[i];
-	}
+	apply_forced_caps(c);
 
 #ifdef CONFIG_X86_64
 	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
@@ -939,10 +946,7 @@ static void __cpuinit identify_cpu(struc
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
