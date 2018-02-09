Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185153-2-11705615957511013106
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
    t=1518185153; b=UjowfPm8lEIR/lMPCY+GahZ6oDj95YFAQfxr2mvs/7XHSWa
    FbLth2KVXR2OHzKqVlHCLgsyUW6JUIgvuMZMcCx1bW+mlqJUmiapDK5pCxrS7NVT
    pMgbbmmKz7PZpZqgsYPdqeKyO7pxiz1ePSn9btJXG3hflbhLtqRj60fAPQ76NV2s
    p9b8Ugv1UoVnVPUV0Vck5jb5pOfIPZSXCcbhpaWX8wCo3V+Pcn9VJJY1FWWEArfj
    ZAuyqveNF3Fzi4ip/sz8lqbJL7aiCUkw5hLFwIIbZc19g9bvZogbSfQZF/Hp61f6
    5TJmNWLMl1wavNR2KqwtGCc1aTV70muU+Q1RYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185153; bh=kjtrU5i1/ZicKHxq/smXclSBWz
    kz1a7rI0CXrqf6+0c=; b=Qbmkt1R89TV/8ovodHvZBEFrjlXbHFpStwP+fjr7xe
    xzygxpoel0OTWh6E+e1g8u8JGVxAbDf34dbOmK555hNyNMjOVtDqYTcQQV3LtKpU
    9OeqqYWRLnuYLegTpUvj1PUx7qo15QE7oPP54XAUG+bpFdzs7gtuq/CJ5h142Xvf
    Uvxj1mptJCXOaLi0KOLLww/pyv/yCfrB2FmXdtMDOHhDCk1o7+SSGcIfngslKVH2
    yrMVn6+jdoSOV/1A/q9qb3KmjqoW8CliXs2Bku16ubHEUjoPq00qjqCa/qghYSEC
    hRPGFNqh18tRDTZsVSols+yYgJVL6Q1sZ6b/1qutyiXw==
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
        id S1752721AbeBINm6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753128AbeBINm5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:57 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Al Viro <viro@zeniv.linux.org.uk>, alan@linux.intel.com,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 59/92] x86: Introduce barrier_nospec
Date: Fri,  9 Feb 2018 14:39:28 +0100
Message-Id: <20180209133935.497488184@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>


(cherry picked from commit b3d7ad85b80bbc404635dca80f5b129f6242bc7a)

Rename the open coded form of this instruction sequence from
rdtsc_ordered() into a generic barrier primitive, barrier_nospec().

One of the mitigations for Spectre variant1 vulnerabilities is to fence
speculative execution after successfully validating a bounds check. I.e.
force the result of a bounds check to resolve in the instruction pipeline
to ensure speculative execution honors that result before potentially
operating on out-of-bounds data.

No functional changes.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727415361.33451.9049453007262764675.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/barrier.h |    4 ++++
 arch/x86/include/asm/msr.h     |    3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -47,6 +47,10 @@ static inline unsigned long array_index_
 /* Override the default implementation from linux/nospec.h. */
 #define array_index_mask_nospec array_index_mask_nospec
 
+/* Prevent speculative execution past this barrier. */
+#define barrier_nospec() alternative_2("", "mfence", X86_FEATURE_MFENCE_RDTSC, \
+					   "lfence", X86_FEATURE_LFENCE_RDTSC)
+
 #ifdef CONFIG_X86_PPRO_FENCE
 #define dma_rmb()	rmb()
 #else
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -188,8 +188,7 @@ static __always_inline unsigned long lon
 	 * that some other imaginary CPU is updating continuously with a
 	 * time stamp.
 	 */
-	alternative_2("", "mfence", X86_FEATURE_MFENCE_RDTSC,
-			  "lfence", X86_FEATURE_LFENCE_RDTSC);
+	barrier_nospec();
 	return rdtsc();
 }
 
