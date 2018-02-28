Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834324-2-6909947827478683951
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834323; b=TdBaDfbOs3057vw5rypetasiA7rCBAXeg14pnqszGRydm6a
    +v1bDyhFSse01O8kIJ9wi4iUpWi33OmaSliE0nAfCGaejmmvQ0GrJ5E+h+E+Kb1n
    /HoNu+RLNNwZgtC8WKPRQ1zYkvwxGkJkWSKY7L1v2OGANGS163gfRow/QIpExsZr
    7D3CQu7P47EegD3NgWs6C1l32OUUNrYibLROKggqJ9h6MPiXEZq1nk/1Ooggz33N
    /blThdJ5ZqEVuOq3JIlyMjvm6lWFWnMTMQZiGbdDK+VLW9k5/WF19Q4tpBwCpAe8
    VvZ5VGnSjdfbs5KxI5zC4DuGGcD0oAbkDvgXRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834323; bh=gwWmIRWhU3Ui/4s+Ap2
    xK2niVgvaKF4QGJEkWdtgdT0=; b=govwIpU8+9puaENwFgdNIC/1Lo8AJ44sVpx
    rQ8BKAifOYmC1CiXSEdZp0v2W35VxB+Jp15wPKH70BmW+BBse/8wTQ+oAsWymNU3
    3x7CgA5/Ca12AdE8scP+08nMTFK7S+X22ovje4emrIMSy7VrmB2Ku0SlV1btMptb
    Quwy1c9iOc3iE4zCULRNQnrts1YG9wEQUMl97ehIHv06UhaZ61KGo6qM6cyLEJX9
    YSzv5kv6sZmUIRZXFSUxxqzINtxlh1Cy9rBUrhhuQRMfOAq8AhyNP+63dw6peQyo
    sEe180jBWt3NKeWk4KVgk0ShXC/Gxm6LhXlhxwV8417S45jM4nA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeB1QMA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:12:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35022 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933269AbeB1QL6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:11:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Christoffer Dall" <christoffer.dall@linaro.org>,
        "Andre Przywara" <andre.przywara@arm.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.180482909@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 119/254] KVM: arm/arm64: Fix HYP unmapping going off
 limits
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

From: Marc Zyngier <marc.zyngier@arm.com>

commit 7839c672e58bf62da8f2f0197fefb442c02ba1dd upstream.

When we unmap the HYP memory, we try to be clever and unmap one
PGD at a time. If we start with a non-PGD aligned address and try
to unmap a whole PGD, things go horribly wrong in unmap_hyp_range
(addr and end can never match, and it all goes really badly as we
keep incrementing pgd and parse random memory as page tables...).

The obvious fix is to let unmap_hyp_range do what it does best,
which is to iterate over a range.

The size of the linear mapping, which begins at PAGE_OFFSET, can be
easily calculated by subtracting PAGE_OFFSET form high_memory, because
high_memory is defined as the linear map address of the last byte of
DRAM, plus one.

The size of the vmalloc region is given trivially by VMALLOC_END -
VMALLOC_START.

Reported-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/kvm/mmu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -345,17 +345,15 @@ void free_boot_hyp_pgd(void)
  */
 void free_hyp_pgds(void)
 {
-	unsigned long addr;
-
 	free_boot_hyp_pgd();
 
 	mutex_lock(&kvm_hyp_pgd_mutex);
 
 	if (hyp_pgd) {
-		for (addr = PAGE_OFFSET; virt_addr_valid(addr); addr += PGDIR_SIZE)
-			unmap_range(NULL, hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
-		for (addr = VMALLOC_START; is_vmalloc_addr((void*)addr); addr += PGDIR_SIZE)
-			unmap_range(NULL, hyp_pgd, KERN_TO_HYP(addr), PGDIR_SIZE);
+		unmap_range(NULL, hyp_pgd, KERN_TO_HYP(PAGE_OFFSET),
+			    (uintptr_t)high_memory - PAGE_OFFSET);
+		unmap_range(NULL, hyp_pgd, KERN_TO_HYP(VMALLOC_START),
+			    VMALLOC_END - VMALLOC_START);
 
 		free_pages((unsigned long)hyp_pgd, pgd_order);
 		hyp_pgd = NULL;
