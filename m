Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324436-2-16303530461281656805
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
    t=1518324435; b=bpp1D/nTE0FSvFpflkMnBE9Ynwn/VKzkbYmCRlohVuVK5YD
    MUJPKIH+0XDRf0ZJj0FqEhyj+WTWIWjCD8As65OunhQGEKafK+ivCPmRkT6z1Hlm
    z7vE6nF9fC/Pa39/A+Dy5jM+TZI0YYTX1GP0I/y54hTkh9iSgryIo6mVDuSLUtHG
    tm7bL9yHkzamrqluyz5HC0q2dlrc2VyNleDLNoxAd2dunyZahhTEsUBa6mtvAXYh
    XcQUSB16h4CxxUU3M1ySJupoxF3kFh6KufX7ohCkm14zpJxFY1BuGAsP415jj0P5
    +9YhdbSNPwRX0PEgnw5ncySAUSegj/c8kyOi1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324435; bh=XskA4XTBBsXM+cFh+8D
    z/n08torXCfJjiRYkeOxXrcQ=; b=YVgh91Vh/c3/blvEftSKqFoX2kN3VUJph+s
    fvHlwhtoDbIA0vt+aiomx3bvKqiet/bBGS+xyW8h2YlOqj0YrqZJVG76d2xYK+aP
    9pnFRkKyJaxfUVwXZXFTJ62MQqpqcaLz9SSFhlOENWRqM0owegohvbL79NuyUc0l
    L/e4DM8Wpc/STM1ssJRnC1UvbSUpK60uTuB4sqQv8vce4rYuJN8159wa6qC/mr4u
    TaYDOLvNz8uZ9UK0/cFkQ+hvy+poU5rHYylzeJpYQF5IKA0PBn7GEXarYjX95p+M
    mOp3OxJvYv2w8N/zpwg6V+VQTHw7dVbKa+NIHBPPEvzcPOWxypQ==
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
        id S1753041AbeBKEpO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:45:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41864 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752856AbeBKEd7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "John David Anglin" <dave.anglin@bell.net>,
        "Helge Deller" <deller@gmx.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.229576546@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 090/136] parisc: Fix validity check of pointer size
 argument in new CAS implementation
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

From: John David Anglin <dave.anglin@bell.net>

commit 05f016d2ca7a4fab99d5d5472168506ddf95e74f upstream.

As noted by Christoph Biedl, passing a pointer size of 4 in the new CAS
implementation causes a kernel crash.  The attached patch corrects the
off by one error in the argument validity check.

In reviewing the code, I noticed that we only perform word operations
with the pointer size argument.  The subi instruction intentionally uses
a word condition on 64-bit kernels.  Nullification was used instead of a
cmpib instruction as the branch should never be taken.  The shlw
pseudo-operation generates a depw,z instruction and it clears the target
before doing a shift left word deposit.  Thus, we don't need to clip the
upper 32 bits of this argument on 64-bit kernels.

Tested with a gcc testsuite run with a 64-bit kernel.  The gcc atomic
code in libgcc is the only direct user of the new CAS implementation
that I am aware of.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/parisc/kernel/syscall.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -690,15 +690,15 @@ cas_action:
 	/* ELF32 Process entry path */
 lws_compare_and_swap_2:
 #ifdef CONFIG_64BIT
-	/* Clip the input registers */
+	/* Clip the input registers. We don't need to clip %r23 as we
+	   only use it for word operations */
 	depdi	0, 31, 32, %r26
 	depdi	0, 31, 32, %r25
 	depdi	0, 31, 32, %r24
-	depdi	0, 31, 32, %r23
 #endif
 
 	/* Check the validity of the size pointer */
-	subi,>>= 4, %r23, %r0
+	subi,>>= 3, %r23, %r0
 	b,n	lws_exit_nosys
 
 	/* Jump to the functions which will load the old and new values into
