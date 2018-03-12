Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826388-2-12025636729088943035
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
    t=1520826387; b=OXzvDHI0Mrf0BsjMnY0FoC+v/oU2NVgY7P0tfLBUK+A1pei
    ozAIxoSxgkysUkccmrsmt0MSNvZBSnkv5amMXuJL8CSgHta3tONXaBsM4TVOS+th
    lkjZQ2lEidiyR0AGcapr9z8x2u5W5Y2YaSU8kEKSPw97Jzx5tgLdzHqJABzbd1+i
    GKHgvk5MlFqjR6JXaDZIpg+DjUsuTjR+Ei+3QQWPWHs58UUPWD5L3KX3xquqpxiN
    Jw1Hx0yuI8miMZuOFWPt65aR98NVBaNQZU2R4GBJduEO4h4Bp2tlsrs/KzHkJAYh
    PppBaaQDW5WW0aU10gB4KGpqdPQcO46tWhR0izQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826387; bh=dCbSMdIN6DpGxoFphGL
    2kKW9wYQO34Ku/zzZBybeoZo=; b=c6LDju1u7jTrVk8REBRVerAk4uABS04d0uY
    WX5nc0gzd9wHY3XRwKE73VdTn5a+jAU4nklD6mYarBPojFUhak2lUyAdIFpx9sT3
    mAHmN9ommbYduLDmLyZaeVzhKuZlJZ5ub7bYfsEeUr4VlxiGRk55BBwu68t9VnbI
    fBWe5eLKfuiIEEKbtzq5U+9YNY1eEgdy/a+Q0aOYbvu3134yC8QM8QlTdjSRZP55
    1ZXC/6L2eL+sPmchYweWfxqHsqSjwiTd/kfRABx2s0HD03IS5u6pZhvwupTkB58f
    fV+cgYXDZ/uz0FW3GN1BEXxXG/jn1qnJ2T2vPzya4UGPKkAi+pg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S932802AbeCLDoi (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:44:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41142 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932646AbeCLDHm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:42 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Borislav Petkov" <bp@suse.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.697207786@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 042/104] x86/cpu, x86/pti: Do not enable PTI on AMD
 processors
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

From: Tom Lendacky <thomas.lendacky@amd.com>

commit 694d99d40972f12e59a3696effee8a376b79d7c8 upstream.

AMD processors are not subject to the types of attacks that the kernel
page table isolation feature protects against.  The AMD microarchitecture
does not allow memory references, including speculative references, that
access higher privileged data when running in a lesser privileged mode
when that access would result in a page fault.

Disable page table isolation by default on AMD processors by not setting
the X86_BUG_CPU_INSECURE feature, which controls whether X86_FEATURE_PTI
is set.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20171227054354.20369.94587.stgit@tlendack-t1.amdoffice.net
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -768,8 +768,8 @@ static void __init early_identify_cpu(st
 	if (this_cpu->c_bsp_init)
 		this_cpu->c_bsp_init(c);
 
-	/* Assume for now that ALL x86 CPUs are insecure */
-	setup_force_cpu_bug(X86_BUG_CPU_INSECURE);
+	if (c->x86_vendor != X86_VENDOR_AMD)
+		setup_force_cpu_bug(X86_BUG_CPU_INSECURE);
 }
 
 void __init early_cpu_init(void)
