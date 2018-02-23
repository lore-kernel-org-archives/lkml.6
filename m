Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415415-2-12098231205020075514
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
    t=1519415415; b=b/07IEHpjMIIBE7K4E03+nbEVUFLHXbe+DZiidb6qpbsSy+
    QpiGWFt2bNKy5DrjsvQdprRHirdfhQzcthvJRO7qCuBc0YcQ1iB+yWOH8geIKUV8
    OXjQjXCsDSsHEwPQJGlP+e/O/h5MqkrNRpNd15zKfV7pffoIeqfA0ClHGGGHk6X3
    3jT9xN/aLIV1zrVzMCiA0hWBQ/NBbBGLP9rSUZO/ov80qeTACT6QXWLvo/lXtwdJ
    PALUw+ggWjC+LrHxyuJ0tpANi4J66WSTgBpqV8eBj05B9E5r21vX5FDT9sQvVLzC
    NAtQTXd/tVBHVF5opHm3icJDfKuN+Grha4Hx+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415415; bh=rwtTyhvVVeJ/BgfBbZJ956gYrU
    5NUu+NBz0HV7VrlxU=; b=E22BDUbIzlwZVQufhrOMkPkXSZ7r+Tyt0Tb5XO0teF
    CMS/CsSwrVf/nZcV8xOG+VosBAjekdpw5lC4H///LZC7mnkPFoMG+qDUVtq815qE
    +uA27HueBVQutI6qaDuoc7ZRTc9kX/MM1a+XKf/Kopc4NsDuwu3FTAar8VBTST2o
    7gq1U3HjqqBVHuKKNwDdSLLc4nTFTgPPHn5StRCYqblHtKykWdpWyqcDXiADeWWT
    eKaSBQtSaDrczAwfvIyXO9divpu4NoUGIiBrjIM7zWmRFsicWj5J25eW4u7q/6b+
    XM3lot6txErK95JoEPVAw6qxxtoSmF3C4WHEvJVDjlfQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933641AbeBWSqS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:46:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933975AbeBWSqP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:46:15 -0500
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
Subject: [PATCH 4.9 083/145] x86/mm/kmmio: Fix mmiotrace for page unaligned addresses
Date: Fri, 23 Feb 2018 19:26:29 +0100
Message-Id: <20180223170735.466154379@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -347,11 +347,11 @@ void iounmap(volatile void __iomem *addr
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
