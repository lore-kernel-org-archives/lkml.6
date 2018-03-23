Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806931-2-7940899179414406784
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806930; b=XrK3IIHUzkptcyGf3TTuSiay/WoEsc/fClfpC9Y0TIZDniK
    E2V+OpFFKMLgvGny+zEf+mWrSaJWgx1dVp2tc6m2tnp6QQOTYlyzCCCksuu0vTEu
    ZJFT7IaRQy8GDZX5K0tthDnrC6qeTHfE2xrfDqfqcsSZpdZ7lw3bZHpVd964UThp
    YzV1p7j9XEyKL1fDGD17kHvw/MVMrJHCsFDWoxJCMdthhUSrQSgZtPgUvqOl75bh
    dbkuwpM3ngyJXHlLf6qjqPHQoXRi9Foxn14lOpjVS/4VSWi7aQAI1MiFi5T4oTYp
    Mg99DqXyiaIwZuG8cKr666WqW/xz7h1h/GjgrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806930; bh=FnFBDZY1PpaskaW9Qxc49hqYtZ
    jhT6MTNiZuaFVxWI8=; b=kYBf1uqGbN9GaylOI1ZcIsanjn6ngNTlQhMJlEw+dz
    Oqn9ddoBVOo3o5VlHUIB9u62iIK8ZkBA3lrI4uJ5FC5t2QNMbNoFI8v2smbEpgEH
    dhOgoQMLW+lKTYpJwd0AYgf5HTZEzOsB7fozOTuphAEovjzyn73S2tUahO6pvqH8
    zu0t4T6L6VcH6MNvhbqPZLmk6QQ0lrRs2Prxg1iifP6u6IHh6RKy4BSamHwesQs3
    EtszR9VknrNKfoObQMoeK+Eb1xQvHnK+IUYbwCvhiFcyIcv/ztUk2NngX5SZougX
    +PE/K8XSE3RxbMBIWnw97El3v4OSM4fedtzNLaL9cXeg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeCWMIc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:08:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35760 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753132AbeCWJ6d (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:58:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 60/84] iommu/vt-d: clean up pr_irq if request_threaded_irq fails
Date: Fri, 23 Mar 2018 10:54:14 +0100
Message-Id: <20180323095421.066004813@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerry Snitselaar <jsnitsel@redhat.com>


[ Upstream commit 72d548113881dd32bf7f0b221d031e6586468437 ]

It is unlikely request_threaded_irq will fail, but if it does for some
reason we should clear iommu->pr_irq in the error path. Also
intel_svm_finish_prq shouldn't try to clean up the page request
interrupt if pr_irq is 0. Without these, if request_threaded_irq were
to fail the following occurs:

fail with no fixes:

[    0.683147] ------------[ cut here ]------------
[    0.683148] NULL pointer, cannot free irq
[    0.683158] WARNING: CPU: 1 PID: 1 at kernel/irq/irqdomain.c:1632 irq_domain_free_irqs+0x126/0x140
[    0.683160] Modules linked in:
[    0.683163] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2 #3
[    0.683165] Hardware name:                  /NUC7i3BNB, BIOS BNKBL357.86A.0036.2017.0105.1112 01/05/2017
[    0.683168] RIP: 0010:irq_domain_free_irqs+0x126/0x140
[    0.683169] RSP: 0000:ffffc90000037ce8 EFLAGS: 00010292
[    0.683171] RAX: 000000000000001d RBX: ffff880276283c00 RCX: ffffffff81c5e5e8
[    0.683172] RDX: 0000000000000001 RSI: 0000000000000096 RDI: 0000000000000246
[    0.683174] RBP: ffff880276283c00 R08: 0000000000000000 R09: 000000000000023c
[    0.683175] R10: 0000000000000007 R11: 0000000000000000 R12: 000000000000007a
[    0.683176] R13: 0000000000000001 R14: 0000000000000000 R15: 0000010010000000
[    0.683178] FS:  0000000000000000(0000) GS:ffff88027ec80000(0000) knlGS:0000000000000000
[    0.683180] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.683181] CR2: 0000000000000000 CR3: 0000000001c09001 CR4: 00000000003606e0
[    0.683182] Call Trace:
[    0.683189]  intel_svm_finish_prq+0x3c/0x60
[    0.683191]  free_dmar_iommu+0x1ac/0x1b0
[    0.683195]  init_dmars+0xaaa/0xaea
[    0.683200]  ? klist_next+0x19/0xc0
[    0.683203]  ? pci_do_find_bus+0x50/0x50
[    0.683205]  ? pci_get_dev_by_id+0x52/0x70
[    0.683208]  intel_iommu_init+0x498/0x5c7
[    0.683211]  pci_iommu_init+0x13/0x3c
[    0.683214]  ? e820__memblock_setup+0x61/0x61
[    0.683217]  do_one_initcall+0x4d/0x1a0
[    0.683220]  kernel_init_freeable+0x186/0x20e
[    0.683222]  ? set_debug_rodata+0x11/0x11
[    0.683225]  ? rest_init+0xb0/0xb0
[    0.683226]  kernel_init+0xa/0xff
[    0.683229]  ret_from_fork+0x1f/0x30
[    0.683259] Code: 89 ee 44 89 e7 e8 3b e8 ff ff 5b 5d 44 89 e7 44 89 ee 41 5c 41 5d 41 5e e9 a8 84 ff ff 48 c7 c7 a8 71 a7 81 31 c0 e8 6a d3 f9 ff <0f> ff 5b 5d 41 5c 41 5d 41 5
e c3 0f 1f 44 00 00 66 2e 0f 1f 84
[    0.683285] ---[ end trace f7650e42792627ca ]---

with iommu->pr_irq = 0, but no check in intel_svm_finish_prq:

[    0.669561] ------------[ cut here ]------------
[    0.669563] Trying to free already-free IRQ 0
[    0.669573] WARNING: CPU: 3 PID: 1 at kernel/irq/manage.c:1546 __free_irq+0xa4/0x2c0
[    0.669574] Modules linked in:
[    0.669577] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2 #4
[    0.669579] Hardware name:                  /NUC7i3BNB, BIOS BNKBL357.86A.0036.2017.0105.1112 01/05/2017
[    0.669581] RIP: 0010:__free_irq+0xa4/0x2c0
[    0.669582] RSP: 0000:ffffc90000037cc0 EFLAGS: 00010082
[    0.669584] RAX: 0000000000000021 RBX: 0000000000000000 RCX: ffffffff81c5e5e8
[    0.669585] RDX: 0000000000000001 RSI: 0000000000000086 RDI: 0000000000000046
[    0.669587] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000023c
[    0.669588] R10: 0000000000000007 R11: 0000000000000000 R12: ffff880276253960
[    0.669589] R13: ffff8802762538a4 R14: ffff880276253800 R15: ffff880276283600
[    0.669593] FS:  0000000000000000(0000) GS:ffff88027ed80000(0000) knlGS:0000000000000000
[    0.669594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.669596] CR2: 0000000000000000 CR3: 0000000001c09001 CR4: 00000000003606e0
[    0.669602] Call Trace:
[    0.669616]  free_irq+0x30/0x60
[    0.669620]  intel_svm_finish_prq+0x34/0x60
[    0.669623]  free_dmar_iommu+0x1ac/0x1b0
[    0.669627]  init_dmars+0xaaa/0xaea
[    0.669631]  ? klist_next+0x19/0xc0
[    0.669634]  ? pci_do_find_bus+0x50/0x50
[    0.669637]  ? pci_get_dev_by_id+0x52/0x70
[    0.669639]  intel_iommu_init+0x498/0x5c7
[    0.669642]  pci_iommu_init+0x13/0x3c
[    0.669645]  ? e820__memblock_setup+0x61/0x61
[    0.669648]  do_one_initcall+0x4d/0x1a0
[    0.669651]  kernel_init_freeable+0x186/0x20e
[    0.669653]  ? set_debug_rodata+0x11/0x11
[    0.669656]  ? rest_init+0xb0/0xb0
[    0.669658]  kernel_init+0xa/0xff
[    0.669661]  ret_from_fork+0x1f/0x30
[    0.669662] Code: 7a 08 75 0e e9 c3 01 00 00 4c 39 7b 08 74 57 48 89 da 48 8b 5a 18 48 85 db 75 ee 89 ee 48 c7 c7 78 67 a7 81 31 c0 e8 4c 37 fa ff <0f> ff 48 8b 34 24 4c 89 ef e
8 0e 4c 68 00 49 8b 46 40 48 8b 80
[    0.669688] ---[ end trace 58a470248700f2fc ]---

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/intel-svm.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -129,6 +129,7 @@ int intel_svm_enable_prq(struct intel_io
 		pr_err("IOMMU: %s: Failed to request IRQ for page request queue\n",
 		       iommu->name);
 		dmar_free_hwirq(irq);
+		iommu->pr_irq = 0;
 		goto err;
 	}
 	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
@@ -144,9 +145,11 @@ int intel_svm_finish_prq(struct intel_io
 	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
 	dmar_writeq(iommu->reg + DMAR_PQA_REG, 0ULL);
 
-	free_irq(iommu->pr_irq, iommu);
-	dmar_free_hwirq(iommu->pr_irq);
-	iommu->pr_irq = 0;
+	if (iommu->pr_irq) {
+		free_irq(iommu->pr_irq, iommu);
+		dmar_free_hwirq(iommu->pr_irq);
+		iommu->pr_irq = 0;
+	}
 
 	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
 	iommu->prq = NULL;
