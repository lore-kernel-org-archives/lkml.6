Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1972233-1523039505-2-7190108966416993645
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
    1523039505; b=ShIEAM7+MYRj6CMATrN0eBO8mLdNB9DftJdzEqTm5hoQP7e5GK
    4iJmyCiCHYuK8BzCUZKfht41Ea0zPpuSep+J0czfpnSc/InjE1lDiDnjqwOSRxGh
    lHZbjQagWesEFc5LKcFBnf7rEKEKU3AJ1Jxmq+MtXnLroYvFCX05aat5jgxTKmJB
    xmmrDWzSdl8/n3blHy2/pH55gljrIxh6KRIzgDbq3d0VUdXIY6h0jBWARAX5gNZ4
    fyuFJtzoklnvQZ/H+e9TXefxqymWUztahVb8wGSvHMSAvAA/zb6B1ZPWX0MjCSnX
    iDIrc8JftJYWxP5j29sb3PquRVroAhkzDH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523039505; bh=
    FB32k/o5mzMzn7br6XTAiUTmCEmXJe2ARDvb+GhUuhU=; b=LACwk8omCs2GmryA
    8l9QlH4qOgwWph7YibSnyQ/BWqa1srC+udYTZq1NRzqaQvnIHXTVElvc4FOp6lY4
    mWujpw1J426UBUcWAIyKwOAINvfIZMECBACak0E9yzougmcyTw47N2W7tgJqG8VE
    HtiT3k4sxj4ldpv884K4wFrL0Zp/YLAU4sXymO8xpFSY8M3A4WWoCZvmexyip1bv
    Gf6cJJ5/C7Iyo4NbhnamfmmZURjNwaQluvsblOTgvQnjfWF64LhVE4uNxMpgP8bP
    DUm5RocolZIz6LNWbyWueXZnZ0MOlPZC9C+APAB39YYPmuWu7A+Sa2qnwEI+9eGi
    cVEXlg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfKRtArxzdFpXxIdTlG4376trOvj//RjZOR5hERjuHNWoOgCMPfDuf3llqOktsNcH8HVmmSxJs4DSgDI4oJhi8bpdQOTZS//7kxAiVd80AlrgD/2DMh7w
    bBDkt7UKDrQAxAHEjrz8hLZvsfnYZJCIlHQYCj8YTDH1sQhgJVyfF2wb1JvSRvLw1f6eqDwTcOsSUReELuX359durnYvxfs8BvFL7RhfcwMBzCPq0gXe/0Ea
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=zd2uoN0lAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=uC6kQh8WcCk4H5cXT7QA:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeDFSbZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:31:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:38636 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751982AbeDFSad (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611444"
From: Ashok Raj <ashok.raj@intel.com>
To: gregkh@linuxfoundation.org, tglx@linutronix.de
Cc: Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com
Subject: [4.15 & 4.14 stable 04/12] x86/microcode: Get rid of struct apply_microcode_ctx
Date: Fri,  6 Apr 2018 11:30:18 -0700
Message-Id: <1523039426-3938-5-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

commit 854857f5944c59a881ff607b37ed9ed41d031a3b upstream

It is a useless remnant from earlier times. Use the ucode_state enum
directly.

No functional change.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Asit K Mallick <asit.k.mallick@intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180228102846.13447-2-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/core.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b40b56e..cbeace2 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -373,26 +373,23 @@ static int collect_cpu_info(int cpu)
 	return ret;
 }
 
-struct apply_microcode_ctx {
-	enum ucode_state err;
-};
-
 static void apply_microcode_local(void *arg)
 {
-	struct apply_microcode_ctx *ctx = arg;
+	enum ucode_state *err = arg;
 
-	ctx->err = microcode_ops->apply_microcode(smp_processor_id());
+	*err = microcode_ops->apply_microcode(smp_processor_id());
 }
 
 static int apply_microcode_on_target(int cpu)
 {
-	struct apply_microcode_ctx ctx = { .err = 0 };
+	enum ucode_state err;
 	int ret;
 
-	ret = smp_call_function_single(cpu, apply_microcode_local, &ctx, 1);
-	if (!ret)
-		ret = ctx.err;
-
+	ret = smp_call_function_single(cpu, apply_microcode_local, &err, 1);
+	if (!ret) {
+		if (err == UCODE_ERROR)
+			ret = 1;
+	}
 	return ret;
 }
 
-- 
2.7.4
