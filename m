Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325260-2-13554576768899484454
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES da,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325260; b=PaAfpytC9S58DucejAf176EVvEHluEwaOAvmE420f05Gimf
    Qt2iZt3ecJaLKAB1Ep80BbHz0EDpjxGfNHDM6SAyaBzA2PqArJLZTJLlEm0GQSdW
    cp9SyTtooH8O5FkKM1bq+7EkaRuP3ONy7m+xAflOzMz2B3VDJCLuXgC719nscA1F
    m1K1jCVF6pPyjBAFWeto+31iclOmjtDPeiGjm/FA3JRYlXAgOfdW0DUbPsZTi8Zt
    6ZJHGf5EfoRSe4N82bOzE/jo/FcygkmWQwrRdTlZEiOTJqQ3QYkfwcLSLZh5xIpi
    x92vPeAlLl/pfvJeCNgcV1P0gxs9keTzNi5zeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325260; bh=N2hWsmaWt5i2XUKjeak
    +V4kJciNxI37NRxQGgBCu9WQ=; b=ejbHd7Ys1r43zxbG8OBpnIZ0VLTV78s9Ps0
    AmXWV8p98RcvKovm3nS32AO85Yppag5U+bDkOe/cSkU8/IgjeLGxpwculY1uY+sg
    NSv3tt7Kbep8T10TmDIyxiGmujAcuHJFEplnQ6TNACVGs+K3nYVZXbZlCWFuHn+j
    MmzBofzH034I10afT6yeIG4dTRdR+G7348w3oLF0VHw6xYBXeGS2nObvpY5+uoyL
    IB3ad6aDuNJckmimmdTGufZVEQNjJA7fxZpO/2UqXYdx4WJLoqyAAq9RYIm7qdoD
    /77TNndIwwBqT6BWf7GG2hMh0yil/L1rUz71AY61l9z1G+qp4zw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeBKE6s (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:58:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41687 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752790AbeBKEd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Juerg Haefliger" <juerg.haefliger@canonical.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.292484135@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 132/136] Revert "x86: kvmclock: Disable use from
 vDSO if KPTI is enabled"
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Juerg Haefliger <juerg.haefliger@canonical.com>

This reverts commit abe3029e4febfa18e4a9562a792465182b3992a0.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/kvmclock.c | 5 -----
 arch/x86/mm/kaiser.c       | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -24,7 +24,6 @@
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
 #include <linux/memblock.h>
-#include <linux/kaiser.h>
 
 #include <asm/x86_init.h>
 #include <asm/reboot.h>
@@ -287,10 +286,6 @@ int __init kvm_setup_vsyscall_timeinfo(v
 	if (!hv_clock)
 		return 0;
 
-	/* FIXME: Need to add pvclock pages to user-space page tables */
-	if (kaiser_enabled)
-		return 0;
-
 	size = PAGE_ALIGN(sizeof(struct pvclock_vsyscall_time_info)*NR_CPUS);
 
 	preempt_disable();
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -322,7 +322,7 @@ silent_disable:
  */
 void __init kaiser_init(void)
 {
-	int cpu, idx;
+	int cpu;
 
 	if (!kaiser_enabled)
 		return;
