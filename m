Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1965609-1523039476-2-12488781523410842163
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523039475; b=JSsE6dXAvMVQUwHTrOFoCIuVJyGZrDSEcx/KOsB/a7GS1SjGED
    61djQTyDNYaIaS7OUwd3zS6RxmU14rRWCqDpW1DamRfwakkZnc5IdO5QvhMuHQFL
    KEasqwP3lg6KE3RVZ0wtVIhDxtWNYc1Y2V1ABsGOkkQSSA2V0aZDAfRYFaJift4x
    HtstJA1gb759n4aB1W4CFv6dT14mMVPZaHuFInHtYECv3Ovy1a3bv1pG0moqmN4n
    Q25zFaP7jwwYGQBF+ftckh3ZR+XQ+Z4PYsucWqPpY7aEGX4BDnRe3x6pyu7OQCio
    yWORCzIUP3qkmjn+3Cec35zZMOlJztZgN8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523039475; bh=
    eh5bmkQCg5dczU7xTYus3CjiAFPBJbK02/NJGcK3vek=; b=dMmKiJTjcRSCaT+1
    rEfjZb4lP/tNuVUeJigBlT4X1pbOzcTjNrFsoclDtiKSj9VA/PzjDNIUxZ6Eutm+
    AtXKLwgYqWGNZV13c5YTRyVf/3nCfhpoA3Wmo3H1oARXMTG0TuXn4xUrAvHeZ/TV
    wA2MzTfIB5X+y3EgWt1H3EKMwaoPeFFhqNjs5ZdNNw7XgtWpiMIM0Pbzck0hSc9E
    dF5+aIfaVs0UnweLftVFhoHMoRzU1wGPMrdkD2upoAVJlr6KS2x+viJ1/AnZMFSM
    k7bvLEMTtKFHhUcbdVKnd1eEq98w1nV2KmrhaoO0ffJo+RTA2jmF+X6vxwXKSJFF
    mpVUXA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIE6Y7LEbVqth0xyoDw57/YzDUJE38NwV4c4HYKqZHuDByLT/BRV8PQ/2cgkRP0HxD015D5OOjXhIOx/EzqAITdw0cpqVWvN/FRmk3Y9u5Jy+8DXcYCj
    FJevpdJvF8wsMYPyfqyNj/xlVU9gJ5FAi244cwYfTyh6A75yOHadAsb+cxvWpduA08KwfP1uvVGDjkx0gp+bonI7pcaDSb22p+QJKWiODbJmaIuINlFTLPh6
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=zd2uoN0lAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=OE5egSsZdzanHIGowZ8A:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeDFSag (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:30:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:38643 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752006AbeDFSae (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611458"
From: Ashok Raj <ashok.raj@intel.com>
To: gregkh@linuxfoundation.org, tglx@linutronix.de
Cc: Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com
Subject: [4.15 & 4.14 stable 08/12] x86/microcode/intel: Look into the patch cache first
Date: Fri,  6 Apr 2018 11:30:22 -0700
Message-Id: <1523039426-3938-9-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

commit d8c3b52c00a05036e0a6b315b4b17921a7b67997 upstream

The cache might contain a newer patch - look in there first.

A follow-on change will make sure newest patches are loaded into the
cache of microcode patches.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Asit K Mallick <asit.k.mallick@intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180228102846.13447-6-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index e2864bc..2aded9d 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -791,9 +791,9 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 
 static enum ucode_state apply_microcode_intel(int cpu)
 {
-	struct microcode_intel *mc;
-	struct ucode_cpu_info *uci;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	struct microcode_intel *mc;
 	static int prev_rev;
 	u32 rev;
 
@@ -801,11 +801,10 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	uci = ucode_cpu_info + cpu;
-	mc = uci->mc;
+	/* Look for a newer patch in our cache: */
+	mc = find_patch(uci);
 	if (!mc) {
-		/* Look for a newer patch in our cache: */
-		mc = find_patch(uci);
+		mc = uci->mc;
 		if (!mc)
 			return UCODE_NFOUND;
 	}
-- 
2.7.4
