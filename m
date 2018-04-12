Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3778089-1523494379-2-6198154083127238930
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523494378; b=vrKF3qKckcy5BTZi/7za5gwGWES8vmS9vVFFmmktRn6XgrdCYE
    KhTJ5SndGiAuKxTsmVSPEnp+V9lU+f0aX0D1UhBWS8KusYiWs18gle+UZeTbPHu3
    mIGlUza+mfN18pqsM2lIUlmSKp86+47k1EVD3TlmpHbnNcwwT40X2py/ZBQaMQ1o
    +4pEnGWgNwe4Ifv4bWCnucSJeaWROI3y4w7jr6XigfVyetqylF08aimFb2tLTOvK
    N+bDXC79vhtaPVhKA0rjXd+6A3uHa08QS0+6930uLivM3wO7Lz5qX3RkkxcKxllP
    xHL0ny0kU77A//In0llnP350/MP45XvHJkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:message-id:in-reply-to:references
    :from:subject:date:sender:list-id; s=fm2; t=1523494378; bh=evUbS
    0xssYoBu2g7/p08O9tVthhH4p3pxKhV7WFVyVQ=; b=GHExvJx32XCcMPoxO3j0l
    N5AvAnPGo8AK/2Ou101jmWevtxI8xWKcMCWkgPZnASvW1dP5pLJEA24OPut7dr1N
    MQ9FqTF5nd5dk3t6k7pLx0Zfv2TkgjpNmo2JAZvKqDLsC0Rs028aFt5dwJ4OYWey
    BK5NFFoIszwV1VsExwEW2Heu5ft9n0TU0EN736EXgZ5u7v+nTCn5SvnUs2HhHwqD
    ccJnzgWYnjhJuDYoMxkGL3swrA1VuF8P4o3TtvvuU+ch5yZo59/0xN6n88ZmXqNr
    9jmbQpNn96Eyo84X+zMidN3rrl1tDafbTXoLWA8/2DchQz8G4MDfitqMWsRmWfnj
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJPiHk4wIlTwYaQTAnzuEqnk6DPtUcBO2/8INM3VFNkoRIK2dpa9Q4wvFWAruJ9YX8RoFZ1ntcZID0R+ExksRxDIPcfpwzqMOBigb+2CMcfEue2m+Hzd
    mfdi7MEt1iMv34XTFUW9grW03Rht+S+hRpkZycSfhH8sKd2WsFGVwsRUw0MekGlInxQ1848Gh0tvH+9GbaDIsp0Gz38rnE4H3+HXsKuJqIJQRexcET1znfoj
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=8981fWPbAAAA:8 a=WE3sKKnEPmJ39uoXETcA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=o72u2rHnfW5qNJ_4I8LD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeDLAwE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:52:04 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39756 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeDLAuP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 20:50:15 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Message-Id: <d51df9ec57959b04f93ae1e40ed8c61fc3155cb0.1523493475.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 03/10] m68k/mac: Don't remap SWIM MMIO region
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For reasons I don't understand, calling ioremap() then iounmap() on
the SWIM MMIO region causes a hang on 68030 (but not on 68040).

~# modprobe swim_mod
SWIM floppy driver Version 0.2 (2008-10-30)
SWIM device not found !
watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [modprobe:285]
Modules linked in: swim_mod(+)
Format 00  Vector: 0064  PC: 000075aa  Status: 2000    Not tainted
ORIG_D0: ffffffff  D0: d00c0000  A2: 007c2370  A1: 003f810c
A0: 00040000  D5: d0096800  D4: d0097e00
D3: 00000001  D2: 00000003  D1: 00000000
Non-Maskable Interrupt
Modules linked in: swim_mod(+)
PC: [<000075ba>] __iounmap+0x24/0x10e
SR: 2000  SP: 007abc48  a2: 007c2370
d0: d00c0000    d1: 000001a0    d2: 00000019    d3: 00000001
d4: d0097e00    d5: d0096800    a0: 00040000    a1: 003f810c
Process modprobe (pid: 285, task=007c2370)
Frame format=0
Stack from 007abc7c:
        ffffffed 00000000 006a4060 004712e0 007abca0 000076ea d0080000 00080000
        010bb4b8 007abcd8 010ba542 d0096000 00000000 00000000 00000001 010bb59c
        00000000 007abf30 010bb4b8 0047760a 0047763c 00477612 00616540 007abcec
        0020a91a 00477600 0047760a 010bb4cc 007abd18 002092f2 0047760a 00333b06
        007abd5c 00000000 0047760a 010bb4cc 00404f90 004776b8 00000001 007abd38
        00209446 010bb4cc 0047760a 010bb4cc 0020938e 0031f8be 00616540 007abd64
Call Trace: [<000076ea>] iounmap+0x46/0x5a
 [<00080000>] shrink_page_list+0x7f6/0xe06
 [<010ba542>] swim_probe+0xe4/0x496 [swim_mod]
 [<0020a91a>] platform_drv_probe+0x20/0x5e
 [<002092f2>] driver_probe_device+0x21c/0x2b8
 [<00333b06>] mutex_lock+0x0/0x2e
 [<00209446>] __driver_attach+0xb8/0xce
 [<0020938e>] __driver_attach+0x0/0xce
 [<0031f8be>] klist_next+0x0/0xa0
 [<00207562>] bus_for_each_dev+0x74/0xba
 [<000344c0>] blocking_notifier_call_chain+0x0/0x20
 [<00333b06>] mutex_lock+0x0/0x2e
 [<00208e44>] driver_attach+0x1a/0x1e
 [<0020938e>] __driver_attach+0x0/0xce
 [<00207e26>] bus_add_driver+0x188/0x234
 [<000344c0>] blocking_notifier_call_chain+0x0/0x20
 [<00209894>] driver_register+0x58/0x104
 [<000344c0>] blocking_notifier_call_chain+0x0/0x20
 [<010bd000>] swim_init+0x0/0x2c [swim_mod]
 [<0020a7be>] __platform_driver_register+0x38/0x3c
 [<010bd028>] swim_init+0x28/0x2c [swim_mod]
 [<000020dc>] do_one_initcall+0x38/0x196
 [<000344c0>] blocking_notifier_call_chain+0x0/0x20
 [<003331cc>] mutex_unlock+0x0/0x3e
 [<00333b06>] mutex_lock+0x0/0x2e
 [<003331cc>] mutex_unlock+0x0/0x3e
 [<00333b06>] mutex_lock+0x0/0x2e
 [<003331cc>] mutex_unlock+0x0/0x3e
 [<00333b06>] mutex_lock+0x0/0x2e
 [<003331cc>] mutex_unlock+0x0/0x3e
 [<00333b06>] mutex_lock+0x0/0x2e
 [<00075008>] __free_pages+0x0/0x38
 [<000045c0>] mangle_kernel_stack+0x30/0xda
 [<000344c0>] blocking_notifier_call_chain+0x0/0x20
 [<003331cc>] mutex_unlock+0x0/0x3e
 [<00333b06>] mutex_lock+0x0/0x2e
 [<0005ced4>] do_init_module+0x42/0x266
 [<010bd000>] swim_init+0x0/0x2c [swim_mod]
 [<000344c0>] blocking_notifier_call_chain+0x0/0x20
 [<0005eda0>] load_module+0x1a30/0x1e70
 [<0000465d>] mangle_kernel_stack+0xcd/0xda
 [<00331c64>] __generic_copy_from_user+0x0/0x46
 [<0033256e>] _cond_resched+0x0/0x32
 [<00331b9c>] memset+0x0/0x98
 [<0033256e>] _cond_resched+0x0/0x32
 [<0005f25c>] SyS_init_module+0x7c/0x112
 [<00002000>] _start+0x0/0x8
 [<00002000>] _start+0x0/0x8
 [<00331c82>] __generic_copy_from_user+0x1e/0x46
 [<0005f2b2>] SyS_init_module+0xd2/0x112
 [<0000465d>] mangle_kernel_stack+0xcd/0xda
 [<00002b40>] syscall+0x8/0xc
 [<0000465d>] mangle_kernel_stack+0xcd/0xda
 [<0008c00c>] pcpu_balance_workfn+0xb2/0x40e
Code: 2200 7419 e4a9 e589 2841 d9fc 0000 1000 <2414> 7203 c282 7602 b681 6600 0096 0242 fe00 0482 0000 0000 e9c0 11c3 ed89 2642

There's no need to call ioremap() for the SWIM address range, as it lies
within the usual IO device region at 0x5000 0000, which has already been
mapped by head.S.

Remove the redundant ioremap() and iounmap() calls to fix the hang.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/block/swim.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 64e066eba72e..92f0cddc597e 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -911,7 +911,7 @@ static int swim_probe(struct platform_device *dev)
 		goto out;
 	}
 
-	swim_base = ioremap(res->start, resource_size(res));
+	swim_base = (struct swim __iomem *)res->start;
 	if (!swim_base) {
 		ret = -ENOMEM;
 		goto out_release_io;
@@ -923,7 +923,7 @@ static int swim_probe(struct platform_device *dev)
 	if (!get_swim_mode(swim_base)) {
 		printk(KERN_INFO "SWIM device not found !\n");
 		ret = -ENODEV;
-		goto out_iounmap;
+		goto out_release_io;
 	}
 
 	/* set platform driver data */
@@ -931,7 +931,7 @@ static int swim_probe(struct platform_device *dev)
 	swd = kzalloc(sizeof(struct swim_priv), GFP_KERNEL);
 	if (!swd) {
 		ret = -ENOMEM;
-		goto out_iounmap;
+		goto out_release_io;
 	}
 	platform_set_drvdata(dev, swd);
 
@@ -945,8 +945,6 @@ static int swim_probe(struct platform_device *dev)
 
 out_kfree:
 	kfree(swd);
-out_iounmap:
-	iounmap(swim_base);
 out_release_io:
 	release_mem_region(res->start, resource_size(res));
 out:
@@ -974,8 +972,6 @@ static int swim_remove(struct platform_device *dev)
 	for (drive = 0; drive < swd->floppy_count; drive++)
 		floppy_eject(&swd->unit[drive]);
 
-	iounmap(swd->base);
-
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (res)
 		release_mem_region(res->start, resource_size(res));
-- 
2.16.1
