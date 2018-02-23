Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519418848-2-9120371232078530656
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519418847; b=kxWH4A5OejQmUNjr4zYqnnTcAC7JkYmsxtle1bgF1F1iCaE
    OrvTve6QES9MiaIMhP/tLqgO+nL00y1vHOq38CLcw5k7oL5Tza+xKSIGsTvVLcRH
    uGFZK9Tu3wLlhNC1mbtSF9ovVTPVqhq8Z4Wz8smHDnLcdYMUozU9N9PQT71oRZy9
    MlHKRqv45R+L2d84fq3Cj630HWlkB/EzTgoZI8ukd5FQE63guRbSxgM4N9cgrhWg
    DZfVlEI6fAeamtXEAvgaaLLC9clEcwRwq+Dbsy4tTsjnXdXft422hFL3k3wMxrZ/
    B9uI9pviCKA/HwASy6Z9yp0jtBFpsgFxofyQ55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418847; bh=sZFq/4y8UfETwgFFxOEz5nkHE9
    i+bP4uTJgRiHQiygk=; b=e4sKQxFrAy38BVEwRT7xi113VPvDjbLsqdo0W7iUED
    5uCwzWAzdCDlcMhpufHOymi5ttv0a4pQgUtZ/0T6Wf5nZ1AHt6wtHeulc6/AXurK
    Bu8blfyC7ggB62Ps/cvRWuVb1WpIWNItJQLP9RWkyxuBb4vvEJ/8R8bxDtDNG+Xe
    VNSb00Vmm/CFCyKQbQo6AP8jUgj9QnZidVBINggoB03W7qPPeDRj1xERZItKcarP
    8JW2ueM5G7Pn19JfVP2pFnBtIcYVHgz+iy4CBiGqav39pickdVFr1A98epJnB29L
    OgczBRw+DzASz8pkCdrNGiADHCUiMfRre6UyPiI1ISYA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeBWUrK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:47:10 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbeBWScK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:32:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        nouveau@lists.freedesktop.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 54/58] x86/mm/kmmio: Fix mmiotrace for page unaligned addresses
Date: Fri, 23 Feb 2018 19:26:53 +0100
Message-Id: <20180223170215.213776406@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karol Herbst <kherbst@redhat.com>


[ Upstream commit 6d60ce384d1d5ca32b595244db4077a419acc687 ]

If something calls ioremap() with an address not aligned to PAGE_SIZE, the
returned address might be not aligned as well. This led to a probe
registered on exactly the returned address, but the entire page was armed
for mmiotracing.

On calling iounmap() the address passed to unregister_kmmio_probe() was
PAGE_SIZE aligned by the caller leading to a complete freeze of the
machine.

We should always page align addresses while (un)registerung mappings,
because the mmiotracer works on top of pages, not mappings. We still keep
track of the probes based on their real addresses and lengths though,
because the mmiotrace still needs to know what are mapped memory regions.

Also move the call to mmiotrace_iounmap() prior page aligning the address,
so that all probes are unregistered properly, otherwise the kernel ends up
failing memory allocations randomly after disabling the mmiotracer.

Tested-by: Lyude <lyude@redhat.com>
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Acked-by: Pekka Paalanen <ppaalanen@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: nouveau@lists.freedesktop.org
Link: http://lkml.kernel.org/r/20171127075139.4928-1-kherbst@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/ioremap.c |    4 ++--
 arch/x86/mm/kmmio.c   |   12 +++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -296,11 +296,11 @@ void iounmap(volatile void __iomem *addr
 	    (void __force *)addr < phys_to_virt(ISA_END_ADDRESS))
 		return;
 
+	mmiotrace_iounmap(addr);
+
 	addr = (volatile void __iomem *)
 		(PAGE_MASK & (unsigned long __force)addr);
 
-	mmiotrace_iounmap(addr);
-
 	/* Use the vm area unlocked, assuming the caller
 	   ensures there isn't another iounmap for the same address
 	   in parallel. Reuse of the virtual address is prevented by
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -434,17 +434,18 @@ int register_kmmio_probe(struct kmmio_pr
 	unsigned long flags;
 	int ret = 0;
 	unsigned long size = 0;
+	unsigned long addr = p->addr & PAGE_MASK;
 	const unsigned long size_lim = p->len + (p->addr & ~PAGE_MASK);
 	unsigned int l;
 	pte_t *pte;
 
 	spin_lock_irqsave(&kmmio_lock, flags);
-	if (get_kmmio_probe(p->addr)) {
+	if (get_kmmio_probe(addr)) {
 		ret = -EEXIST;
 		goto out;
 	}
 
-	pte = lookup_address(p->addr, &l);
+	pte = lookup_address(addr, &l);
 	if (!pte) {
 		ret = -EINVAL;
 		goto out;
@@ -453,7 +454,7 @@ int register_kmmio_probe(struct kmmio_pr
 	kmmio_count++;
 	list_add_rcu(&p->list, &kmmio_probes);
 	while (size < size_lim) {
-		if (add_kmmio_fault_page(p->addr + size))
+		if (add_kmmio_fault_page(addr + size))
 			pr_err("Unable to set page fault.\n");
 		size += page_level_size(l);
 	}
@@ -527,19 +528,20 @@ void unregister_kmmio_probe(struct kmmio
 {
 	unsigned long flags;
 	unsigned long size = 0;
+	unsigned long addr = p->addr & PAGE_MASK;
 	const unsigned long size_lim = p->len + (p->addr & ~PAGE_MASK);
 	struct kmmio_fault_page *release_list = NULL;
 	struct kmmio_delayed_release *drelease;
 	unsigned int l;
 	pte_t *pte;
 
-	pte = lookup_address(p->addr, &l);
+	pte = lookup_address(addr, &l);
 	if (!pte)
 		return;
 
 	spin_lock_irqsave(&kmmio_lock, flags);
 	while (size < size_lim) {
-		release_kmmio_fault_page(p->addr + size, &release_list);
+		release_kmmio_fault_page(addr + size, &release_list);
 		size += page_level_size(l);
 	}
 	list_del_rcu(&p->list);
