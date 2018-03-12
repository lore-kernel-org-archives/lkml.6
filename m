Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824565-2-3249967447264598304
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
    t=1520824564; b=HqWXPoz6fgxTdOgqy1k/OKBiRHmdi3c1Mmd3QBJdvAgeJAy
    9O/r3yDX92v5kU+U5vyq26mLt7qWly2oH44Xd5NsqLP3PqrM+6YL+wFITiYhIMl9
    p8i0cb3eHiO4MJztklnlgneojxEILl0GOlnDrlGP10t9BemOEu5opVVs+6QTEnwj
    7omHK4eOMZtwL2xKpNbrvhrqa+SMOsjw06ldJZmGJktlMJfBqwLLivpN3/PwdXN1
    EnGBMh68UdAeyVYu76jtH7/+iLPLJ4o3go0hPiyWN3owES0pWgFWVXaU9nKA2yk0
    Nj9jDqx0MK7179dvJ/7dvADrrTcY3xU4OZNEUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824564; bh=pO2xGcBVcu5r0sO3kya
    3lHxRbOHtv/Krwj74YL5EyXo=; b=Q9ipJdof8FWsgxTJddjqpTjC32e5WKK8Oty
    cIUszGqNnjaTt6w5MNilRoaUz+TFFkth9m152qYSuwGLVTjFE69POlIZ+p0P8QGJ
    G3JGz86LP+OAZ4ACM0LZE8oo+QTIZ5a0vomVZLXlzPg/AegPBWr/sdoXY1GteU/R
    qS5bc6jV8bcuLaeCvXuiXHe9BYGr6bZXzDTUOjMK004B7C6fSZM2f5BzVImGfgHc
    JclhY2Nzyr5MFFP45cs2a5bZ2GUkE6ftpVRLFWLFjxpLYpbrZDt+vduqQ+T3tRll
    GrPhAT85Zd0DJZ8b7p39JSFlAK8tkCxpfSiuxfZqR8adGeCs/uA==
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
        id S932791AbeCLDOv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:14:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41519 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932787AbeCLDHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:51 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andy Lutomirski" <luto@kernel.org>,
        "Borislav Petkov" <bp@suse.de>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.74256894@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 06/76] x86/cpu, x86/pti: Do not enable PTI on AMD
 processors
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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -805,8 +805,8 @@ static void __init early_identify_cpu(st
 
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
 
-	/* Assume for now that ALL x86 CPUs are insecure */
-	setup_force_cpu_bug(X86_BUG_CPU_INSECURE);
+	if (c->x86_vendor != X86_VENDOR_AMD)
+		setup_force_cpu_bug(X86_BUG_CPU_INSECURE);
 }
 
 void __init early_cpu_init(void)
