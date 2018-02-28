Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834181-2-15712432233514792886
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES caenro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834181; b=Gde5JkNDrLjcjbd3JJY+Mlc6RRRvUUnni4amM90v+sf/5pP
    Jt/6ExJ329HMD4Wm//vWuFACpJ6IyGjQUN8Dp9BOVwJCdtY4jn3XSxQHSRTRqorV
    T9/IVs5wyB+85TrTkGw6czdZaZaaLgje+tEBLl+JeMa1VyHhi/g74HEgghY2bFdW
    2qk9nO3Qv2ggxDaPZ+sFelOBicZJoSjLfGuTx3BHwwKIePrJeGdK5BKGTW8BX+xW
    F0wCwLOLnXRHjw3H8T7lumV3z8zXdLrO5LKLs6L9kVgJNSVF4L+KRvBopJr28epi
    K2GwcHdaV7eSOkn4L3cSv3S7GubR/ksr4J+Oo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834181; bh=eoIX2rP7oMTDD+Mghhi
    /dr02dWB8QV5hz6t6R+RDLZo=; b=GqdZV6F143qHGGAEHW3ccbLdQGtcjbHXXeN
    5vLjQVw6PFPjzL7+o/O9lht2jK6IGqU6Y43Nu3tsNlfyTUgM1AMLlREq2epfEiy6
    pV7vHn64LQLOoF8O0/epUytcm4N/qXenQcusnME9ay+gW/C6vAmpsnQ3Ned/yGbE
    +th0n9Xaqpal494pSmISE7eVQ8zHVmcKx4MhCuxbtOQkGglw1FCd3dQkJGPDa3dR
    NVi3qmFS4YRUYpE7WxJGPeSwW5VB22Kb9gp4kAjI2aPdqigjGFMsK5q2IF6btQH7
    InUN1YQdRpsEJ7p9r2dpEkxpRkRiHPSuLqGFJBX55MaJyX0ADwA==
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
        id S932760AbeB1QJ0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:09:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34994 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934407AbeB1QJL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:09:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Paul Burton" <Paul.Burton@mips.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        "James Hogan" <james.hogan@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        "Alex Smith" <alex@alex-smith.me.uk>, linux-mips@linux-mips.org
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.14230707@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 110/254] MIPS: Disallow outsized PTRACE_SETREGSET
 NT_PRFPREG regset accesses
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@mips.com>

commit c8c5a3a24d395b14447a9a89d61586a913840a3b upstream.

Complement commit c23b3d1a5311 ("MIPS: ptrace: Change GP regset to use
correct core dump register layout") and also reject outsized
PTRACE_SETREGSET requests to the NT_PRFPREG regset, like with the
NT_PRSTATUS regset.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Fixes: c23b3d1a5311 ("MIPS: ptrace: Change GP regset to use correct core dump register layout")
Cc: James Hogan <james.hogan@mips.com>
Cc: Paul Burton <Paul.Burton@mips.com>
Cc: Alex Smith <alex@alex-smith.me.uk>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17930/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -568,6 +568,9 @@ static int fpr_set(struct task_struct *t
 
 	BUG_ON(count % sizeof(elf_fpreg_t));
 
+	if (pos + count > sizeof(elf_fpregset_t))
+		return -EIO;
+
 	init_fp_ctx(target);
 
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
