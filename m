Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520824297-2-1909785526969375884
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520824295; b=VD4hkME6sx2u12KkSf9efluSsLGYoWhcy2uW/u6ic4VTqKP
    LehdLdTkBU1R5pdAkRksst+EYfFzulDbNzn3M41vjdPDorxxhXGKbSUVJcr4MERW
    Cn4OImY0J3hJgxBp6ZW8xjkIaKE0DNOky/beG9/bveX4sIMDQ9TDILaERzEGxccH
    DXAlJ+l6VGH60zhFkQ/Vzbf5FlNJN5zu+KgYRnoW69wjiTJ6niZfCD1PLfUJP/fn
    HApuUIPlC85qlu+b4OLdRskD/bX3iN/jg+YQUvYSmSzD2bBn1c78L/0lHc91FIIt
    aCZma7yz6dixj8pAZwilOS62jToV5ImvfQaA8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824295; bh=ireE8KIUEC48mSa63PX
    VAZPeeYK+6/FJMULeWAQ6IE4=; b=akXCPRvClckJPi3LxEnpV6oVPNtUPmepZTT
    FeAgWnP6byt4lMQDatFzm3baSLlun634Ln5JmzWXFedKgh90LQti2G7p3hlzyUbV
    akiIZ8EW2TqOp7n8wMQraI+9AOiInCRwv9fPpF/18ZRK2ETg6tGpdLJEPIDGn27X
    d6HrwPBEjgowd9qRogYAplKCpWIJ9XWWrpcJfPeXhNeG1ifEaZGfrrjOhXXUL54U
    NLDHcKZSKUW8pGzQPqcm8mAe3xKpNMW69efC6gBwcM++c0UY+Zj6STJdTUadCrnJ
    aZSx1m7jVVsCXDC9M7cxdqNtSlyfQQxEoL5dgy7gqOr0YfcqhDg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S932907AbeCLDJA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:09:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41679 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932819AbeCLDHx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:53 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.375460400@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 42/76] x86/cpu: Change type of x86_cache_size
 variable to unsigned int
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

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>

commit 24dbc6000f4b9b0ef5a9daecb161f1907733765a upstream.

Currently, x86_cache_size is of type int, which makes no sense as we
will never have a valid cache size equal or less than 0. So instead of
initializing this variable to -1, it can perfectly be initialized to 0
and use it as an unsigned variable instead.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Addresses-Coverity-ID: 1464429
Link: http://lkml.kernel.org/r/20180213192208.GA26414@embeddedor.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/processor.h      | 2 +-
 arch/x86/kernel/cpu/common.c          | 2 +-
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 arch/x86/kernel/cpu/proc.c            | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -107,7 +107,7 @@ struct cpuinfo_x86 {
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
 	/* in KB - valid for CPUS which support this call: */
-	int			x86_cache_size;
+	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
 	int			x86_power;
 	unsigned long		loops_per_jiffy;
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -905,7 +905,7 @@ static void identify_cpu(struct cpuinfo_
 	int i;
 
 	c->loops_per_jiffy = loops_per_jiffy;
-	c->x86_cache_size = -1;
+	c->x86_cache_size = 0;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->x86_model = c->x86_mask = 0;	/* So far unknown... */
 	c->x86_vendor_id[0] = '\0'; /* Unset */
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -352,7 +352,7 @@ static struct microcode_ops microcode_in
 
 static int __init calc_llc_size_per_core(struct cpuinfo_x86 *c)
 {
-	u64 llc_size = c->x86_cache_size * 1024;
+	u64 llc_size = c->x86_cache_size * 1024ULL;
 
 	do_div(llc_size, c->x86_max_cores);
 
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -86,8 +86,8 @@ static int show_cpuinfo(struct seq_file
 	}
 
 	/* Cache size */
-	if (c->x86_cache_size >= 0)
-		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
+	if (c->x86_cache_size)
+		seq_printf(m, "cache size\t: %u KB\n", c->x86_cache_size);
 
 	show_cpuinfo_core(m, c, cpu);
 	show_cpuinfo_misc(m, c);
