Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406043-2-15180945948582344681
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406042; b=u6fNYgtE3qKC7+a/P7sr7EDlxK3TeqpfEVW+3GhJwMY6/aWfbH
    /hpcYbVLlf2u2s05SvfQiRZshJrGCCm5wF909ug0DMOCFxCn4FgK9AoLS41MIZAh
    edcp1wBPc3s/inwaSr4fPLXTCSm/4an08WjWJ+LyTuVQWcf6K0/t75cme7ycf2Kv
    idifJ57OWPlcwemne4cqvk+g3ByWvyL7sN5c+yFICRrGbPSx3ACyz8qmC2emH8+f
    mZqOod+ilj2dvI8h/QUzw2gF9rpYplfyPQPFbKuEnjc3V+0lCv3vBE8flMY5AuMJ
    ky7LmnVHdJOaILRwaunU9a/S8Mm3h2+UvfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406042; bh=mRgYGyH74zL3dl0cao82d19iAQhCJs
    2349nMDoM+uuw=; b=jdLVHs9UcDO3/Rl+/P+KIQ4WBnEJ3prxUHF8HVMt9VwqNJ
    iKsYDEuvvQtEUJIkAcQvS1NfMYZnSoygfQo/63WyRzSrziPewOQU1sEDVqfwkbXN
    VGVmiK7Enz/3WN0FY2ynDN0SIhwq4gOxFiuSCwjyBOhhRhpFxN6DClbnQViRVK0H
    kTqDyGBqRY/aO7MZAG50e3W6R/5KcGef0bGGaZ29vgacMbJAHHJ0fqfXpQtXa+dC
    vWCeLQeflWyG1D1zA38Mi4kumk6JAHTgB1Va0Wbncj2sL3ZLtKrjMb2NkekNv6AL
    TGc4jiEFBi2ybugAa6w/fBJNt+9d6swdJn/5EJ+w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBW6KMNBk0M/kF8MrtlKl4zfa62UvDySTmiOmITvtMeMFXQPdk1hdnbIjmNqfEfqrb1LDyT5PNcZ7Fp9Gq+QUpq3/bLo8TGFfPEYAm0d5Zo//VhCdTTz
    rEfpCyZdcCbVKr8cRjhmTxBrTtlKDoC6AXMJmz3oVTBbkB1S/FuP3deLy1Af0moQpRYRwDA0v0TZfkUI/b2apVCxl0OCdz637vYZY839hVlzZu/bnnwOv6KO
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JF9118EUAAAA:8 a=GUVi8RmzAAAA:8 a=CbDCq_QkAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=SLg6BmJyXiY6LNhR8lUA:9 a=Y6mXgi45pPES3-gn:21
    a=-E9XzUklZNS7ujlh:21 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
    a=jSdgSmmMQx7r16_JUfbt:22 a=1qrBK16LubpBFNPVNq2M:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755748AbeDVOHS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:07:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51794 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755669AbeDVOHO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:07:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Moni Shoua <monis@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 088/164] RDMA/rxe: Fix an out-of-bounds read
Date: Sun, 22 Apr 2018 15:52:35 +0200
Message-Id: <20180422135139.027888732@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit a6544a624c3ff92a64e4aca3931fa064607bd3da upstream.

This patch avoids that KASAN reports the following when the SRP initiator
calls srp_post_send():

==================================================================
BUG: KASAN: stack-out-of-bounds in rxe_post_send+0x5c4/0x980 [rdma_rxe]
Read of size 8 at addr ffff880066606e30 by task 02-mq/1074

CPU: 2 PID: 1074 Comm: 02-mq Not tainted 4.16.0-rc3-dbg+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
Call Trace:
dump_stack+0x85/0xc7
print_address_description+0x65/0x270
kasan_report+0x231/0x350
rxe_post_send+0x5c4/0x980 [rdma_rxe]
srp_post_send.isra.16+0x149/0x190 [ib_srp]
srp_queuecommand+0x94d/0x1670 [ib_srp]
scsi_dispatch_cmd+0x1c2/0x550 [scsi_mod]
scsi_queue_rq+0x843/0xa70 [scsi_mod]
blk_mq_dispatch_rq_list+0x143/0xac0
blk_mq_do_dispatch_ctx+0x1c5/0x260
blk_mq_sched_dispatch_requests+0x2bf/0x2f0
__blk_mq_run_hw_queue+0xdb/0x160
__blk_mq_delay_run_hw_queue+0xba/0x100
blk_mq_run_hw_queue+0xf2/0x190
blk_mq_sched_insert_request+0x163/0x2f0
blk_execute_rq+0xb0/0x130
scsi_execute+0x14e/0x260 [scsi_mod]
scsi_probe_and_add_lun+0x366/0x13d0 [scsi_mod]
__scsi_scan_target+0x18a/0x810 [scsi_mod]
scsi_scan_target+0x11e/0x130 [scsi_mod]
srp_create_target+0x1522/0x19e0 [ib_srp]
kernfs_fop_write+0x180/0x210
__vfs_write+0xb1/0x2e0
vfs_write+0xf6/0x250
SyS_write+0x99/0x110
do_syscall_64+0xee/0x2b0
entry_SYSCALL_64_after_hwframe+0x42/0xb7

The buggy address belongs to the page:
page:ffffea0001998180 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x4000000000000000()
raw: 4000000000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: dead000000000100 dead000000000200 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff880066606d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
ffff880066606d80: f1 00 f2 f2 f2 f2 f2 f2 f2 00 00 f2 f2 f2 f2 f2
>ffff880066606e00: f2 00 00 00 00 00 f2 f2 f2 f3 f3 f3 f3 00 00 00
                                    ^
ffff880066606e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff880066606f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Moni Shoua <monis@mellanox.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rxe/rxe_verbs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -712,9 +712,8 @@ static int init_send_wqe(struct rxe_qp *
 		memcpy(wqe->dma.sge, ibwr->sg_list,
 		       num_sge * sizeof(struct ib_sge));
 
-	wqe->iova		= (mask & WR_ATOMIC_MASK) ?
-					atomic_wr(ibwr)->remote_addr :
-					rdma_wr(ibwr)->remote_addr;
+	wqe->iova = mask & WR_ATOMIC_MASK ? atomic_wr(ibwr)->remote_addr :
+		mask & WR_READ_OR_WRITE_MASK ? rdma_wr(ibwr)->remote_addr : 0;
 	wqe->mask		= mask;
 	wqe->dma.length		= length;
 	wqe->dma.resid		= length;
