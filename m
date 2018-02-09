Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518183761-2-3833981081248859506
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
    t=1518183760; b=LVS3eDdbq5zBse+v48W5pIdaxi7NIORhRcbCs7l2abn4UuU
    eO4m+gNv9LyonWIXtXEAvL9eK588Fiasjry2dhuQNtI0KFOCDH2YcSKQkvM2hI5c
    Vyp+Jag1GYsxyfJboGCoc2xo/GHAN79LHH7RK4SActhiqPG/qoJZcQPdrwh6KppY
    M0fJ088SRKA2zw8d2mTmwItNf75UgjNquonDgzF/ELNkFqPOkX0N7PAuAnI1nuUV
    iJIndB62HN+V3ZHhdpqNR8rcm6KhqhE0p0j6bkZPbXsBBuWSoAuGa4V251O+qatE
    9O5mh5vBirDMAnJYCBB26R35yUb57CJ9c6dAR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518183760; bh=E7spTSmEefd6Yb3h0d7iTUjSuW
    /q7YzBv7O9YpVeVuc=; b=rKnRilQdSIdKTVs9YLk7YFRx9CfgUYb899HKTMaTHj
    pkbjBvvY/JMLXPAjMd4Jjl0lRdhXdEeptMBxMzYpacJzFKebMD48qjDrpZOObGeU
    aD4CZf5nm4Tim5N0sjRdDLFb0Roa3sWvka781xmL6RgPZ4Y0d+/V0dgPsPjomJFN
    hT9UpPI1PG2m1Vz9JExvJ2186iuqn/rfRtyfqV4SoeQLQ2EyYkH+2cIXm0F1n2jq
    Dv0wkjLHNccXuk03y+TDf82waBaBazwE1HVJ5IGp/hTrk4xQ7Y+Qe5m3b+qSfVIu
    r0NXnfoiwcz1vPar7cX+3MjCVg6o5s1P3vKB5YnUR0aQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbeBINmf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49900 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752943AbeBINmd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:33 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        gnomes@lxorguk.ukuu.org.uk, peterz@infradead.org,
        ning.sun@intel.com, tboot-devel@lists.sourceforge.net,
        andi@firstfloor.org, luto@kernel.org, law@redhat.com,
        pbonzini@redhat.com, torvalds@linux-foundation.org,
        dwmw@amazon.co.uk, nickc@redhat.com, Jiri Kosina <jkosina@suse.cz>,
        Hugh Dickins <hughd@google.com>, gregkh@linux-foundation.org
Subject: [PATCH 4.9 16/92] x86/pti: Make unpoison of pgd for trusted boot work for real
Date: Fri,  9 Feb 2018 14:38:45 +0100
Message-Id: <20180209133932.427736240@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 445b69e3b75e42362a5bdc13c8b8f61599e2228a upstream

The inital fix for trusted boot and PTI potentially misses the pgd clearing
if pud_alloc() sets a PGD.  It probably works in *practice* because for two
adjacent calls to map_tboot_page() that share a PGD entry, the first will
clear NX, *then* allocate and set the PGD (without NX clear).  The second
call will *not* allocate but will clear the NX bit.

Defer the NX clearing to a point after it is known that all top-level
allocations have occurred.  Add a comment to clarify why.

[ tglx: Massaged changelog ]

[ hughd notes: I have not tested tboot, but this looks to me as necessary
and as safe in old-Kaiser backports as it is upstream; I'm not submitting
the commit-to-be-fixed 262b6b30087, since it was undone by 445b69e3b75e,
and makes conflict trouble because of 5-level's p4d versus 4-level's pgd.]

Fixes: 262b6b30087 ("x86/tboot: Unbreak tboot with PTI enabled")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
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
Link: https://lkml.kernel.org/r/20180110224939.2695CD47@viggo.jf.intel.com
Cc: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/tboot.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -134,6 +134,16 @@ static int map_tboot_page(unsigned long
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
 
