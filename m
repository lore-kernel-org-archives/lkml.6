Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517590797-2-3743359905965150178
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517590793; b=J0bmpt1xsb7Los/gdINSa+dK3JTq+h2PsSGBUCwB27Ys1TA
    71qeIr/3CE14daw54wpinNf/rvTIq5LrOiGNp69bA85jk5PcwSWCczDpH2bxJ6RD
    GNoOhi3+iRrGhjRQP/+7iau/uZKb9HUnp88+fX2W1M6xXOCjT+tykXC6Hdw5Qtg5
    mGonr1Z1pGlwwMVTvQXy66ChLTaXzVgTIhu6lCApA7PySGUMdR6yL0FgCEZKYgyD
    WynsJIuFkrpKBM6q0TA61RRkbzz60svjgrWoZLfiV7cGRA2gxk9EGIZ9RaQY13o5
    GxVCmShBxJ4Q3DB0BRZew7daK6UmYWDEAujYTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590793; bh=x2sIyCL+jGOJuatqIkD4sgCZkC
    BAdkVCWz3+R7rZ+fI=; b=LgqxBlaBxjTR3YUnglGph5jblxR0w0j36jSUGGL7kr
    HJ+dx+KVW99mlr/apyATW6O3FZbUuZ0AA4o8IlqwTqplyy9i8npfrqv+SLLnSNbn
    +wyZxpN4bydv+xYjFXYYLSQfWTv2SezoK8ZhazL9wnLlGWGpQvjvSn2m/dQJJeZH
    M5wSg/vP3/mfqDEn48mHTsxSttqguS0fCuIddeHEMMJtuoLPc58mg5VtYsvl+C3M
    fJP1xBV9kQkjMDpOTyOXThcO0SpGBGaCFxmvmjk3gDdIwUwg5ay+aHCrtinqvvye
    x2n1HT1W8LQkEwqSOqEzI1M2NNGrfLNKlJPTiNOVAKsw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeBBQ7w (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 11:59:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34456 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeBBQ7k (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 11:59:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        gnomes@lxorguk.ukuu.org.uk, peterz@infradead.org,
        ning.sun@intel.com, tboot-devel@lists.sourceforge.net,
        andi@firstfloor.org, luto@kernel.org, law@redhat.com,
        pbonzini@redhat.com, torvalds@linux-foundation.org,
        dwmw@amazon.co.uk, nickc@redhat.com,
        Hugh Dickins <hughd@google.com>, gregkh@linux-foundation.org
Subject: [PATCH 4.4 11/67] x86/pti: Make unpoison of pgd for trusted boot work for real
Date: Fri,  2 Feb 2018 17:57:40 +0100
Message-Id: <20180202140816.487701831@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 445b69e3b75e42362a5bdc13c8b8f61599e2228a upstream.

The inital fix for trusted boot and PTI potentially misses the pgd clearing
if pud_alloc() sets a PGD.  It probably works in *practice* because for two
adjacent calls to map_tboot_page() that share a PGD entry, the first will
clear NX, *then* allocate and set the PGD (without NX clear).  The second
call will *not* allocate but will clear the NX bit.

Defer the NX clearing to a point after it is known that all top-level
allocations have occurred.  Add a comment to clarify why.

[ tglx: Massaged changelog ]

[hughd notes: I have not tested tboot, but this looks to me as necessary
and as safe in old-Kaiser backports as it is upstream; I'm not submitting
the commit-to-be-fixed 262b6b30087, since it was undone by 445b69e3b75e,
and makes conflict trouble because of 5-level's p4d versus 4-level's pgd.]

Fixes: 262b6b30087 ("x86/tboot: Unbreak tboot with PTI enabled")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: "Tim Chen" <tim.c.chen@linux.intel.com>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: peterz@infradead.org
Cc: ning.sun@intel.com
Cc: tboot-devel@lists.sourceforge.net
Cc: andi@firstfloor.org
Cc: luto@kernel.org
Cc: law@redhat.com
Cc: pbonzini@redhat.com
Cc: torvalds@linux-foundation.org
Cc: gregkh@linux-foundation.org
Cc: dwmw@amazon.co.uk
Cc: nickc@redhat.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180110224939.2695CD47@viggo.jf.intel.com
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/tboot.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -140,6 +140,16 @@ static int map_tboot_page(unsigned long
 		return -1;
 	set_pte_at(&tboot_mm, vaddr, pte, pfn_pte(pfn, prot));
 	pte_unmap(pte);
+
+	/*
+	 * PTI poisons low addresses in the kernel page tables in the
+	 * name of making them unusable for userspace.  To execute
+	 * code at such a low address, the poison must be cleared.
+	 *
+	 * Note: 'pgd' actually gets set in pud_alloc().
+	 */
+	pgd->pgd &= ~_PAGE_NX;
+
 	return 0;
 }
 
