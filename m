Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519217389-2-17571311404503212655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519217388; b=sNa7EV/pzZrkMnOVTrlPqQswQViL0kqdcmyc9/Qq779Sv3T
    XnfElwHIYPV+6yibBP+/3kVShuUH1cwvOmfQRhYtH3ru5Lx243rcRPsXBLEPqZwE
    kpCgyRQ7CcB4WSU/XlErDenugMe2r8ceuaK2X6PhIpmDuvBf87sDohv0FOzsAtwu
    FL/P22XGG9ikpJklJfJS2KG3a3BFD32Scvi87QpLW3CF5IBcLBbTbRaGL2LWhuvM
    MtkMvqe9ye0VDan/Xsii24AoPoRfqYgFqNlPcvvjRSMP7Nck7dYtLwQ2txr0jKYK
    vcuUQlChbqZtVG6gorLECkxPGIvGEtwyMVe7bfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217388; bh=ApHNRAh4rTAWLpKrsXNkpof8Ko
    C8AcK/bKK1OssxByQ=; b=h47FNNcvRZSl1VPgyGF++FwOFmQG68o0yJgw9LGZae
    bfm3wXshkniRvZntMtl/kGC5VaAeVtW3f853DGV6Pn3EE2MSYqL51r522gJLYG2+
    E2/htwMQcCC/5lhESBMEbFvV2XaVeWNgnJd0KFR2jib3OuB750Z/xEYss27JxS2Q
    zCYloEtk4xYho4qZn+9/cvY+mhfAY04vLyHA1XZKvxfkk/hYWkpPORhDMvX2RRqD
    QOp1bOrgI9hbAV5lzTggjzNV2mfCwwMofT+8XeONWY6wWGdhzpn7sFfgH52qu8hJ
    sBzcuvV+m8/qSzOnzL9spNL2v/PoGr16Q2cIoPgj4QgA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754369AbeBUMqW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:46:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754362AbeBUMqU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:46:20 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 10/33] x86/cpu: Change type of x86_cache_size variable to unsigned int
Date: Wed, 21 Feb 2018 13:44:53 +0100
Message-Id: <20180221124410.226816399@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <garsilva@embeddedor.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/processor.h      |    2 +-
 arch/x86/kernel/cpu/common.c          |    2 +-
 arch/x86/kernel/cpu/microcode/intel.c |    2 +-
 arch/x86/kernel/cpu/proc.c            |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -113,7 +113,7 @@ struct cpuinfo_x86 {
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
 	/* in KB - valid for CPUS which support this call: */
-	int			x86_cache_size;
+	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
 	/* Cache QoS architectural values: */
 	int			x86_cache_max_rmid;	/* max index */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -955,7 +955,7 @@ static void identify_cpu(struct cpuinfo_
 	int i;
 
 	c->loops_per_jiffy = loops_per_jiffy;
-	c->x86_cache_size = -1;
+	c->x86_cache_size = 0;
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
 	c->x86_model = c->x86_mask = 0;	/* So far unknown... */
 	c->x86_vendor_id[0] = '\0'; /* Unset */
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -1075,7 +1075,7 @@ static struct microcode_ops microcode_in
 
 static int __init calc_llc_size_per_core(struct cpuinfo_x86 *c)
 {
-	u64 llc_size = c->x86_cache_size * 1024;
+	u64 llc_size = c->x86_cache_size * 1024ULL;
 
 	do_div(llc_size, c->x86_max_cores);
 
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -87,8 +87,8 @@ static int show_cpuinfo(struct seq_file
 	}
 
 	/* Cache size */
-	if (c->x86_cache_size >= 0)
-		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
+	if (c->x86_cache_size)
+		seq_printf(m, "cache size\t: %u KB\n", c->x86_cache_size);
 
 	show_cpuinfo_core(m, c, cpu);
 	show_cpuinfo_misc(m, c);
