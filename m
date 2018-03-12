Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086679-1520882933-2-3943401889895859160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520882932; b=s7nhzyIWr+mxVVSfFYzbMkeTtGibSM282uuFmtm4QTaKHYu
    sb8fK7xsLrw7jJFjaU1iD4Q+5aU8YOpnS59Nh414Ql0SdGuXGknbcwIMIZ6AvpP5
    91NOSGTNPUHyWaOn+273Zc8fPOBnsq5GorsbJyj5Rl4R1aLCA/0K5Kj1FBTUxqVB
    mxPGCsLIRoicja1Q0S/svN0C9Lx3lTuWR9g0LmcprmUfHYxRHcDnd/9FCv0Kr9nz
    6LoB7MfiF8ddMIv/vdZk05lfLJSY9pHZ3YWXfqVdBXowI9ENOp46B9tJuvsAHtb9
    jV6u0Uvr/8O1/EwM+CDXdyCJSNOOmJOxu/mRttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520882932; bh=uVDlPqY3RFy699HrPDtBPat9qF
    FZ/0XHM5E5AN5MhVY=; b=hL3rxUnlEfpZ3gIQTN1EpDrHBq/i4ZdwUQlp19yZhS
    OGSyETY/GjMXcdp6QguHh5gXYqRUVCQ4njb3/zD4zewF4a3w0N3DgwcBwlKxbq6u
    r4Tm8fTS2TjOb+0eTLmrBLzrMAzLh4V5ifvOgVveV6RHmD5kg4ACRjNYMhJLQMom
    NdaO5NBACUI2EljJW58WVemGK+j+0vJ3Qb6+rkSLCiZyI5/dd9EN5TZGJgKGhnzS
    +TuxGMwiWR9XRGO6UHko4ReGN1zMLSl+D+o9qOnjh6WEFCJU0oRsE8ieyAbe6rTj
    bOSFH/wcHu0N3EnDwzqMkeCQ3T2dDoEZuZ6dxgrWzMEA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vmware.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vmware.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vmware.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vmware.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeCLT2v (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 15:28:51 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:42598 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750811AbeCLT2u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 15:28:50 -0400
From: Nadav Amit <namit@vmware.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Xavier Deguillard <xdeguillard@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        <linux-kernel@vger.kernel.org>, Gil Kupfer <gilkup@gmail.com>,
        Oleksandr Natalenko <onatalen@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, <stable@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v2] vmw_balloon: fixing double free when batching mode is off
Date: Mon, 12 Mar 2018 12:28:48 -0700
Message-ID: <20180312192848.22104-1-namit@vmware.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180312191917.21381-1-namit@vmware.com>
References: <20180312191917.21381-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Gil Kupfer <gilkup@gmail.com>

The balloon.page field is used for two different purposes if batching is
on or off. If batching is on, the field point to the page which is used
to communicate with with the hypervisor. If it is off, balloon.page
points to the page that is about to be (un)locked.

Unfortunately, this dual-purpose of the field introduced a bug: when the
balloon is popped (e.g., when the machine is reset or the balloon driver
is explicitly removed), the balloon driver frees, unconditionally, the
page that is held in balloon.page.  As a result, if batching is
disabled, this leads to double freeing the last page that is sent to the
hypervisor.

The following error occurs during rmmod when kernel checkers are on, and
the balloon is not empty:

[   42.307653] ------------[ cut here ]------------
[   42.307657] Kernel BUG at ffffffffba1e4b28 [verbose debug info unavailable]
[   42.307720] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
[   42.312512] Modules linked in: vmw_vsock_vmci_transport vsock ppdev joydev vmw_balloon(-) input_leds serio_raw vmw_vmci parport_pc shpchp parport i2c_piix4 nfit mac_hid autofs4 vmwgfx drm_kms_helper hid_generic syscopyarea sysfillrect usbhid sysimgblt fb_sys_fops hid ttm mptspi scsi_transport_spi ahci mptscsih drm psmouse vmxnet3 libahci mptbase pata_acpi
[   42.312766] CPU: 10 PID: 1527 Comm: rmmod Not tainted 4.12.0+ #5
[   42.312803] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 09/30/2016
[   42.313042] task: ffff9bf9680f8000 task.stack: ffffbfefc1638000
[   42.313290] RIP: 0010:__free_pages+0x38/0x40
[   42.313510] RSP: 0018:ffffbfefc163be98 EFLAGS: 00010246
[   42.313731] RAX: 000000000000003e RBX: ffffffffc02b9720 RCX: 0000000000000006
[   42.313972] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9bf97e08e0a0
[   42.314201] RBP: ffffbfefc163be98 R08: 0000000000000000 R09: 0000000000000000
[   42.314435] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffc02b97e4
[   42.314505] R13: ffffffffc02b9748 R14: ffffffffc02b9728 R15: 0000000000000200
[   42.314550] FS:  00007f3af5fec700(0000) GS:ffff9bf97e080000(0000) knlGS:0000000000000000
[   42.314599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.314635] CR2: 00007f44f6f4ab24 CR3: 00000003a7d12000 CR4: 00000000000006e0
[   42.314864] Call Trace:
[   42.315774]  vmballoon_pop+0x102/0x130 [vmw_balloon]
[   42.315816]  vmballoon_exit+0x42/0xd64 [vmw_balloon]
[   42.315853]  SyS_delete_module+0x1e2/0x250
[   42.315891]  entry_SYSCALL_64_fastpath+0x23/0xc2
[   42.315924] RIP: 0033:0x7f3af5b0e8e7
[   42.315949] RSP: 002b:00007fffe6ce0148 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[   42.315996] RAX: ffffffffffffffda RBX: 000055be676401e0 RCX: 00007f3af5b0e8e7
[   42.316951] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055be67640248
[   42.317887] RBP: 0000000000000003 R08: 0000000000000000 R09: 1999999999999999
[   42.318845] R10: 0000000000000883 R11: 0000000000000206 R12: 00007fffe6cdf130
[   42.319755] R13: 0000000000000000 R14: 0000000000000000 R15: 000055be676401e0
[   42.320606] Code: c0 74 1c f0 ff 4f 1c 74 02 5d c3 85 f6 74 07 e8 0f d8 ff ff 5d c3 31 f6 e8 c6 fb ff ff 5d c3 48 c7 c6 c8 0f c5 ba e8 58 be 02 00 <0f> 0b 66 0f 1f 44 00 00 66 66 66 66 90 48 85 ff 75 01 c3 55 48
[   42.323462] RIP: __free_pages+0x38/0x40 RSP: ffffbfefc163be98
[   42.325735] ---[ end trace 872e008e33f81508 ]---

To solve the bug, we eliminate the dual purpose of balloon.page.

Fixes: 220a80f0c2e7 ("VMware balloon: add batching to the vmw_balloon.")
Cc: stable@vger.kernel.org
Reported-by: Oleksandr Natalenko <onatalen@redhat.com>
Signed-off-by: Gil Kupfer <gilkup@gmail.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
---
v2: Fixing commit message

 drivers/misc/vmw_balloon.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 9047c0a529b2..efd733472a35 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -576,15 +576,9 @@ static void vmballoon_pop(struct vmballoon *b)
 		}
 	}
 
-	if (b->batch_page) {
-		vunmap(b->batch_page);
-		b->batch_page = NULL;
-	}
-
-	if (b->page) {
-		__free_page(b->page);
-		b->page = NULL;
-	}
+	/* Clearing the batch_page unconditionally has no adverse effect */
+	free_page((unsigned long)b->batch_page);
+	b->batch_page = NULL;
 }
 
 /*
@@ -991,16 +985,13 @@ static const struct vmballoon_ops vmballoon_batched_ops = {
 
 static bool vmballoon_init_batching(struct vmballoon *b)
 {
-	b->page = alloc_page(VMW_PAGE_ALLOC_NOSLEEP);
-	if (!b->page)
-		return false;
+	struct page *page;
 
-	b->batch_page = vmap(&b->page, 1, VM_MAP, PAGE_KERNEL);
-	if (!b->batch_page) {
-		__free_page(b->page);
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
 		return false;
-	}
 
+	b->batch_page = page_address(page);
 	return true;
 }
 
-- 
2.14.1
