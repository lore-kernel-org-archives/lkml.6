Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518323854-2-12664887321940114918
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323853; b=bOBTTSzWR0FtSoW1rX9dziPn5jVbBk91LNr5odiTX/oJOIP
    tDqqx0+j2V9ALawPKEXfpZZ1OE+GgyXE2LmgzDAop9y73/9MpD6klCnSiG0FXzQJ
    bW+gNuzm7FYNasCM7WJkCisE0DbXDS3KmaPcTl8FxM/EaZvb2wh5Ee7oXR0AhlBP
    cl6acCWRspvP0O92m039eBmQn/6qHFL2889kUro+b7XQUN1NFszkVpWMJt9fE5z5
    0jAmHWVd44E2vc0S8D2bzsK3uFrIxUH2YodMH27qQV57rLyE1Yr0di4SNyy0T6tr
    fbCozMKk6t+x4z2KOMyDcGuTK6TLL++TPrgUMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323853; bh=s0VMelOCdanNosWQqL4
    l/onouXESsKF2xi1+vVmJH1A=; b=lP/y3vn1S5gH1c2CNmGDLGgvJg+30jLWuTk
    9X2eJxRUdEIeeVNLpdMHY37mTXlxJcw5FK2rjB+SxVozdvJ54vDXLbOTCGHv4nLB
    lhzx0MdE/QX4oqHl37VBFL95ANSU0VlY0XNf5i6b9oOofNAxKcoa10FMGTnYNtyf
    wVRqRuyvEx4/g1ZcdtsEdQ5ExlYV75n8EgP+4nhPibdhHiU02mB2M+UIiGka80LI
    sB+uuHr6hFuRHiEgs4ZfiFmBWnk9v9zwQFX+TrdlMNL5cCOzacSTrmz4qxq/QC1Q
    vJA2SxhLku2KpmaGyH9mQb1YYHZV6VZv0S9gaKtU584GM/3eSJg==
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
        id S1753009AbeBKEfB (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:35:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41765 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753005AbeBKEeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Tyler Baicar" <tbaicar@codeaurora.org>,
        "James Morse" <james.morse@arm.com>, "Borislav Petkov" <bp@suse.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.518047208@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 061/136] ACPI / APEI: Remove ghes_ioremap_area
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

From: James Morse <james.morse@arm.com>

commit 520e18a5080d2c444a03280d99c8a35cb667d321 upstream.

Now that nothing is using the ghes_ioremap_area pages, rip them out.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[bwh: Backported to 3.16:
 - Delete additional call to ghes_ioremap_exit() from ghes_exit()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/acpi/apei/ghes.c | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -112,19 +112,7 @@ static DEFINE_RAW_SPINLOCK(ghes_nmi_lock
  * from BIOS to Linux can be determined only in NMI, IRQ or timer
  * handler, but general ioremap can not be used in atomic context, so
  * the fixmap is used instead.
- */
-
-/*
- * Two virtual pages are used, one for NMI context, the other for
- * IRQ/PROCESS context
- */
-#define GHES_IOREMAP_PAGES		2
-#define GHES_IOREMAP_NMI_PAGE(base)	(base)
-#define GHES_IOREMAP_IRQ_PAGE(base)	((base) + PAGE_SIZE)
-
-/* virtual memory area for atomic ioremap */
-static struct vm_struct *ghes_ioremap_area;
-/*
+ *
  * These 2 spinlocks are used to prevent the fixmap entries from being used
  * simultaneously.
  */
@@ -147,23 +135,6 @@ static struct irq_work ghes_proc_irq_wor
 struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
-static int ghes_ioremap_init(void)
-{
-	ghes_ioremap_area = __get_vm_area(PAGE_SIZE * GHES_IOREMAP_PAGES,
-		VM_IOREMAP, VMALLOC_START, VMALLOC_END);
-	if (!ghes_ioremap_area) {
-		pr_err(GHES_PFX "Failed to allocate virtual memory area for atomic ioremap.\n");
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void ghes_ioremap_exit(void)
-{
-	free_vm_area(ghes_ioremap_area);
-}
-
 static void __iomem *ghes_ioremap_pfn_nmi(u64 pfn)
 {
 	__set_fixmap(FIX_APEI_GHES_NMI, pfn << PAGE_SHIFT, PAGE_KERNEL);
@@ -1063,13 +1034,9 @@ static int __init ghes_init(void)
 
 	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
 
-	rc = ghes_ioremap_init();
-	if (rc)
-		goto err;
-
 	rc = ghes_estatus_pool_init();
 	if (rc)
-		goto err_ioremap_exit;
+		goto err;
 
 	rc = ghes_estatus_pool_expand(GHES_ESTATUS_CACHE_AVG_SIZE *
 				      GHES_ESTATUS_CACHE_ALLOCED_MAX);
@@ -1093,8 +1060,6 @@ static int __init ghes_init(void)
 	return 0;
 err_pool_exit:
 	ghes_estatus_pool_exit();
-err_ioremap_exit:
-	ghes_ioremap_exit();
 err:
 	return rc;
 }
@@ -1103,7 +1068,6 @@ static void __exit ghes_exit(void)
 {
 	platform_driver_unregister(&ghes_platform_driver);
 	ghes_estatus_pool_exit();
-	ghes_ioremap_exit();
 }
 
 module_init(ghes_init);
