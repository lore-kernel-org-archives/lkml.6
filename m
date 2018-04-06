Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1972233-1523039479-2-10330995028077720995
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
    1523039478; b=BEFJWd8ryDfLARUqNzMaTpJdcU1vxW3JJvYSq4LQt/V5l7J39i
    pLeJJIOz5eCAZXfO4zHu+S68vBnErBdc+0NxVMJBMlpD74mSMyIWIF44aRvzzgFt
    dA7yNvY6NCknOwE7yK1BPYyfNiOSQOs85QmLHMFwAG2SnPN//3wpy2D1o9Hpjh3u
    of8c1IjDgkq326ccvCtRFGT8QllJAUsdSaQIwJnIlZRh4OMfR8mUimpkRx7Q/Wum
    ZyHiw+P07pJ6hhK4yqWuEo0iZZLQUZ71vUpdqnCyJmnjY5eFC4zzvBDSzwzV7JNu
    k5g64xCyTS3UmC/tSo2FXHBHnC7CYRXkPyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523039478; bh=
    SUjhhFwwy96J1mJYUh5ZGsay0Z0kwn7oewnTLjj30ac=; b=lIlnNhV7Fc0XlIx7
    oKVLolagUfO2L9qQ4ll6ThWxGI3RhpD2NOcZalirIqgZejNijZuE67ny0FnrZzCi
    3xWP9bgSv8ZTKJ1VKspK9F+D8gY08PKmM8PgEop6pqMRCzJLOCvvyafhug/GoOC8
    TjsxiaNh18oh6gqFjrGxQ7AbHqz90QPh3wnwPsgFTC8xOWvCjJcaCSaaN08pFBUm
    QVYyOufZh09N1kUa0Pu1X1609TzrYbufdkpO1j2W46Tzt9IEPbKmE1Tve3F3vFI6
    sITVymGfygYqjyZ0s7RfNGzHvarChVisM5AZoEwwrJIX9mcRNb+4zfjr2EKM7Wgj
    AilfXQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIFFN6ID5hAz2RgkN00VuS2+sGN0nSjjJP0eIu7eEAaNuN5z8A6GJmfQ7kWeb4hmsT31hjos+fgIbxC81V0i6J1mahnQ72GPDQRWkDLYNZ9BDAgRIKE9
    7vQguXMySe5fiIqFfWYOeFcludZZQxkEB+hIkMXMKhGUK3BRXW2/7TgyHKzzQ7u5ic4BenQrmqlrMKQl37i9pbYWbXz+5c4W7dMy/sx1jVVVkNbi+RFoKKvh
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=gAeq1xfyj2LgD56u6OEA:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeDFSaf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 14:30:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:38635 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752011AbeDFSae (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 14:30:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="31611451"
From: Ashok Raj <ashok.raj@intel.com>
To: gregkh@linuxfoundation.org, tglx@linutronix.de
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, bp@suse.de, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com
Subject: [4.15 & 4.14 stable 06/12] x86/microcode/intel: Writeback and invalidate caches before updating microcode
Date: Fri,  6 Apr 2018 11:30:20 -0700
Message-Id: <1523039426-3938-7-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 91df9fdf51492aec9fed6b4cbd33160886740f47 upstream

Updating microcode is less error prone when caches have been flushed and
depending on what exactly the microcode is updating. For example, some
of the issues around certain Broadwell parts can be addressed by doing a
full cache flush.

[ Borislav: Massage it and use native_wbinvd() in both cases. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Asit K Mallick <asit.k.mallick@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1519352533-15992-3-git-send-email-ashok.raj@intel.com
Link: https://lkml.kernel.org/r/20180228102846.13447-4-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 87bd6dc..e2864bc 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -600,6 +600,12 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 		return UCODE_OK;
 	}
 
+	/*
+	 * Writeback and invalidate caches before updating microcode to avoid
+	 * internal issues depending on what the microcode is updating.
+	 */
+	native_wbinvd();
+
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -816,6 +822,12 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		return UCODE_OK;
 	}
 
+	/*
+	 * Writeback and invalidate caches before updating microcode to avoid
+	 * internal issues depending on what the microcode is updating.
+	 */
+	native_wbinvd();
+
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
-- 
2.7.4
