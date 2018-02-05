Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3105817-1517855029-2-16797763694740213358
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855028; b=ON3HY+DxKDXaqK5s8/DGZb880vAlSOmIx8Ag3HslGvVAl2B
    qR20GIag9CG0lrlSUjYGJwvI/DwFbyg0AbiiB0PTPwttNehdNhVOg9Ee25HjMNjS
    YCZ89r0MoCn+89YuDWIOBsp95D++6V7G9/sd4H5FCAdR0mflYG2rpZ5WrxrnF0VG
    CSMCUx3uMjLEvR6S7ugmbuZtALT347zuumCaQBAjuZn1/rFMNH6lkuQF7QKGAuBw
    tu3tAqxSKTwALCn52S+UMwYqon1pTfTW5OU9hAAjd+u8HsaMnkneFj6Q2omiWgET
    i+P6laGTUo9xnbGX25rP0Myvm/57nYrmO2efeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855028; bh=VnUUDnwx1Pz507+3ag1Rsvd7x9
    XGRA4GqgGxmvw2XTI=; b=WqPZSOsy2KOg97bgSNJrorRgiYryHEKCDtxc5fXKon
    0TWeh6heB8RDX7qBfnPVu7eOpbfDodUi5PvmUf6ckZH33mRlcUzflauiud2ZWVu9
    oFV7V9BFVmLl5nnN92hOcxIOGYjHDf8b9LND079e4VmDXmuVE0KLyFk799A33BLQ
    5SyZhET5qYg/QUMn62wIUMdZNTr40WmR715ikxWnR1I9nYv1wyeCWDOmQedoQ+3V
    FA9CFfIKsL84WUAKMkrmyQoeSssulz5kuidllw04tldcqQovsnNn0ZZkiqBGdqs5
    GY4VFRv1p6Ev/QVDbpUDDvxz4IHBe+8C/9IwIGcqH25A==
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
        id S1753453AbeBESXm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:23:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBESX3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:23:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com,
        ashok.raj@intel.com, dave.hansen@intel.com, karahmed@amazon.de,
        arjan@linux.intel.com, torvalds@linux-foundation.org,
        peterz@infradead.org, bp@alien8.de, pbonzini@redhat.com,
        tim.c.chen@linux.intel.com, gregkh@linux-foundation.org
Subject: [PATCH 4.14 13/64] x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early Spectre v2 microcodes
Date: Mon,  5 Feb 2018 10:22:32 -0800
Message-Id: <20180205182139.112895118@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse dwmw@amazon.co.uk

commit a5b2966364538a0e68c9fa29bc0a3a1651799035

This doesn't refuse to load the affected microcodes; it just refuses to
use the Spectre v2 mitigation features if they're detected, by clearing
the appropriate feature bits.

The AMD CPUID bits are handled here too, because hypervisors *may* have
been exposing those bits even on Intel chips, for fine-grained control
of what's available.

It is non-trivial to use x86_match_cpu() for this table because that
doesn't handle steppings. And the approach taken in commit bd9240a18
almost made me lose my lunch.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-7-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/intel.c |   66 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -102,6 +102,59 @@ static void probe_xeon_phi_r3mwait(struc
 		ELF_HWCAP2 |= HWCAP2_RING3MWAIT;
 }
 
+/*
+ * Early microcode releases for the Spectre v2 mitigation were broken.
+ * Information taken from;
+ * - https://newsroom.intel.com/wp-content/uploads/sites/11/2018/01/microcode-update-guidance.pdf
+ * - https://kb.vmware.com/s/article/52345
+ * - Microcode revisions observed in the wild
+ * - Release note from 20180108 microcode release
+ */
+struct sku_microcode {
+	u8 model;
+	u8 stepping;
+	u32 microcode;
+};
+static const struct sku_microcode spectre_bad_microcodes[] = {
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
+	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
+	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
+	{ INTEL_FAM6_SKYLAKE_MOBILE,	0x03,	0xc2 },
+	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
+	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
+	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
+	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
+	{ INTEL_FAM6_BROADWELL_XEON_D,	0x03,	0x07000011 },
+	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
+	{ INTEL_FAM6_HASWELL_ULT,	0x01,	0x21 },
+	{ INTEL_FAM6_HASWELL_GT3E,	0x01,	0x18 },
+	{ INTEL_FAM6_HASWELL_CORE,	0x03,	0x23 },
+	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
+	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
+	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
+	/* Updated in the 20180108 release; blacklist until we know otherwise */
+	{ INTEL_FAM6_ATOM_GEMINI_LAKE,	0x01,	0x22 },
+	/* Observed in the wild */
+	{ INTEL_FAM6_SANDYBRIDGE_X,	0x06,	0x61b },
+	{ INTEL_FAM6_SANDYBRIDGE_X,	0x07,	0x712 },
+};
+
+static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
+		if (c->x86_model == spectre_bad_microcodes[i].model &&
+		    c->x86_mask == spectre_bad_microcodes[i].stepping)
+			return (c->microcode <= spectre_bad_microcodes[i].microcode);
+	}
+	return false;
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
@@ -122,6 +175,19 @@ static void early_init_intel(struct cpui
 	if (c->x86 >= 6 && !cpu_has(c, X86_FEATURE_IA64))
 		c->microcode = intel_get_microcode_revision();
 
+	if ((cpu_has(c, X86_FEATURE_SPEC_CTRL) ||
+	     cpu_has(c, X86_FEATURE_STIBP) ||
+	     cpu_has(c, X86_FEATURE_AMD_SPEC_CTRL) ||
+	     cpu_has(c, X86_FEATURE_AMD_PRED_CMD) ||
+	     cpu_has(c, X86_FEATURE_AMD_STIBP)) && bad_spectre_microcode(c)) {
+		pr_warn("Intel Spectre v2 broken microcode detected; disabling SPEC_CTRL\n");
+		clear_cpu_cap(c, X86_FEATURE_SPEC_CTRL);
+		clear_cpu_cap(c, X86_FEATURE_STIBP);
+		clear_cpu_cap(c, X86_FEATURE_AMD_SPEC_CTRL);
+		clear_cpu_cap(c, X86_FEATURE_AMD_PRED_CMD);
+		clear_cpu_cap(c, X86_FEATURE_AMD_STIBP);
+	}
+
 	/*
 	 * Atom erratum AAE44/AAF40/AAG38/AAH41:
 	 *
