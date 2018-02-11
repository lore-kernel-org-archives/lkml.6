Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324029-2-1438859901919312958
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324029; b=UxW9/fzku4YdTo+FrtQWsfwi5CJa8ENEKYrfCGo1JTrWJ01
    D+pMqb2FwwuI7SvfHf6vijdVLs/rywU2fYgBzE5P1/7L0gdLIVbROZVr1CEz5qX0
    u8xoiaR3nx30Bo5fqPfUpLokc6kbRkLJjbltgwv4loFTrnn7TAMQn+MTTUlEXkx4
    Fciyj0xzmlgvhudaY6tewCV9LefYs13Cm8wH4RVuwAQ9ZkyhZlvhnP4OGqVRQi5+
    StmFzfEV0p+dW3XfoQ7CG3gSL8qsFaLwhNEAzrMKq2h8l9n7gtjgIiGr/fQMoch1
    CELLHIQ8LJQazMtIoavdLr3Ms4xrrSs27awkGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324029; bh=hlUkjsa84gDpw7YowaF
    ETRkghX3xVs9OCIvEyglTwFQ=; b=lSzKMb/0xPGbVYZqHyqjEajTBunI7uJEayF
    VbLPWVAyVfKYniV+Bkoz0f4/a5erMvmGrAfBSfcNnW2hGc0P6KSbySlUwJH6S8x7
    u/O7Z3+g/SsRY3PVbW4qbDr7jLy6ypK3E/arQCxkYntrsKeRRKT5pNGx08AsdNWZ
    n5HgGDXhWMkAXF6MDofHHeIXSzTRw5lHn6AU6rTjNRR/6K1kXhJdYiRcVEicWjQA
    tuMIr1m0OrEwp3IcCqrNCRQpq60OfA2KO4mjzsV7pYBGvcVYjkj01paQAK6EiZGt
    Q83Q5+5l+7dINUtwCxxg9uxb/nmbFGSdBnSm6M2A4bphOXbGa7g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeBKEi6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:38:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41673 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752949AbeBKEeI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:08 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Mark Salyzyn" <salyzyn@android.com>,
        "Will Deacon" <will.deacon@arm.com>,
        "Andrew Pinski" <apinski@cavium.com>,
        "Mark Rutland" <mark.rutland@arm.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.111126904@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 041/136] arm64: vdso: fix clock_getres for
 4GiB-aligned res
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

From: Mark Rutland <mark.rutland@arm.com>

commit c80ed088a519da53f27b798a69748eaabc66aadf upstream.

The vdso tries to check for a NULL res pointer in __kernel_clock_getres,
but only checks the lower 32 bits as is uses CBZ on the W register the
res pointer is held in.

Thus, if the res pointer happened to be aligned to a 4GiB boundary, we'd
spuriously skip storing the timespec to it, while returning a zero error code
to the caller.

Prevent this by checking the whole pointer, using CBZ on the X register
the res pointer is held in.

Fixes: 9031fefde6f2ac1d ("arm64: VDSO support")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Andrew Pinski <apinski@cavium.com>
Reported-by: Mark Salyzyn <salyzyn@android.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/kernel/vdso/gettimeofday.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -186,7 +186,7 @@ ENTRY(__kernel_clock_getres)
 	b.ne	4f
 	ldr	x2, 6f
 2:
-	cbz	w1, 3f
+	cbz	x1, 3f
 	stp	xzr, x2, [x1]
 
 3:	/* res == NULL. */
