Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1972233-1523039592-2-4314050518702489444
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523039591; b=UCJjK6uZwm6AlEV3AbHA8JsakdhLEfY/kCLL0/Y6fdA+SG/RjU
    8wDn+4xYGwhQ6IAPWNzrI0K6nhO/an4kY+k4Hbf3/wtWqsnH8jTFMfRoIK6dURZc
    26VIaQn4y2TaDPx5DCRoasovEXJst60nvgIu3Ls8ZUcVZsG4S2gHpFBcHkPb2/Fo
    wAJxTwFswS33TtJ5RyDQtsBgGbzStK1a3N76qdMwZcX8rWBq5O2IQfPXf6ZLaSuY
    eP3t49ZxSG0Hko8nzCeadaiyECqoWe3lQXcURK9PHXgzr93+LHl+AC2i5LPeL22O
    eW2xKgQpDjaxCjdZAc3okwwqsf7aKmUJnyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523039591; bh=
    T966OKZFFesiMUrmIGL1hW757ZNXzmjMPfBBfRRUMZo=; b=ME2gCjYAwUzUVaVo
    2O0NOsRdRMPGErQsiLOdBBVnZOMcZV1xUJdvAzdeFS+BodsD3/Cl01+6ISTWoljD
    C7LRrcwrCruyQnyqeauZ8GS92exnchl9MHZh4yxgq+o9QsR6eEbmFXvuZavUZCLM
    2yD3O/kJ9iH91CyTgajlD94HwSdBxjSEGlf16sPVPHevI8o9OuZz8tS5J41CuK3i
    mGmJIq+eYehunEhdIP84urAUp8ISMhFvFWVa2J7bQlQIpLVTA25TPTIgE7d+vGLN
    4G44nAhCO0lJ6lmvMMzJEI5bICczHHYv2sx/AiYrOxrSmcic2UH59Au1+Yav2OWs
    77+30A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfDhppu5hKEwr0sVBabh3gf7I917ENqujU1Nw4v3oKBhdtQxm+uN57cfLQX/lxrosPUEUof2OoPLppQ7MCuT28JFPSVjfZQJxucZa08Skb3DKm0KEAwq3
    vYK1DZP8J9xN/NDbD1AXUqfyguF7vdK6cOTCDx3dkrVVcBFkGfzwftzRzkLYYT1o2JDvHScqZV3bT+vVsW8bT7g+BK/H4F2M7RrXd8tATK42zwbTrMoGVoon
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8
    a=Z4Rwk6OoAAAA:8 a=zd2uoN0lAAAA:8 a=NwJIS6zlZZp3WNkDnN0A:9
    a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDFScz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:32:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:38635 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbeDFSac (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611441"
From: Ashok Raj <ashok.raj@intel.com>
To: gregkh@linuxfoundation.org, tglx@linutronix.de
Cc: Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [4.15 & 4.14 stable 03/12] x86/CPU: Check CPU feature bits after microcode upgrade
Date: Fri,  6 Apr 2018 11:30:17 -0700
Message-Id: <1523039426-3938-4-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

commit 42ca8082e260dcfd8afa2afa6ec1940b9d41724c upstream

With some microcode upgrades, new CPUID features can become visible on
the CPU. Check what the kernel has mirrored now and issue a warning
hinting at possible things the user/admin can do to make use of the
newly visible features.

Originally-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Asit K Mallick <asit.k.mallick@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180216112640.11554-4-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/common.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 84f1cd8..348cf48 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1757,5 +1757,25 @@ core_initcall(init_cpu_syscore);
  */
 void microcode_check(void)
 {
+	struct cpuinfo_x86 info;
+
 	perf_check_microcode();
+
+	/* Reload CPUID max function as it might've changed. */
+	info.cpuid_level = cpuid_eax(0);
+
+	/*
+	 * Copy all capability leafs to pick up the synthetic ones so that
+	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
+	 * get overwritten in get_cpu_cap().
+	 */
+	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
+
+	get_cpu_cap(&info);
+
+	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability)))
+		return;
+
+	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
+	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
 }
-- 
2.7.4
