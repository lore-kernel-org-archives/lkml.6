Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524839918-2-13439396708480222862
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839917; b=Nuw5hmhX8gGJOOpe15d5OP+BSx7g8Aw/W4jlaWUdux99OpldVM
    DweItO3qAj4FfE8/6H4Cob8vWBY8bEVMUYM0lGob8NtZCJxHvjLdf82HIDJt6GIy
    P7IRtwdr3/VERpT1PfNmx/KP32g4FvzJtMPAE4gAdy+Z8RVVudfUqErwbNuDoRyv
    onhI+ITGuFDv2a39jP+gTNve99CRofmL9+YUuj2ADRgPJ6krJ62j9/C13ATeD8pl
    F+XZvM+SA5z5R7zePngQdcoy7UGtYkeNY/qHeZ+ifg8Fbs2CvihHron9PVbxmXzJ
    SoUX8TkRf40mb+W8a0nlBO6/gvZL7oi8p1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839917; bh=ZGZ95wkszPzPal+0GDV/BduMlDg5l0
    Zq43uLehYeG6A=; b=CXwCgJ1IkkRtQouvyOINxR5akICxNYGT4G9k0xQqz0RFoE
    bfVzGPGOzn7tXX4W8/F7q9aSN9AsE8O0RchBU2Odj6vSB+Y6zYWzrNcA0BoPSZE9
    YjixXHFv0SKz8dRX4SJfEl5HS7LiHgfhcw7ntW0+AUils1aplYddrYaA5uj134qN
    smVTUDY1fspLMQIw/vic/x8j6c6+XZr/eUDTKK1cMlAnpvB0qaD0OIH4LG8iXy5a
    6msqx8gNEfDMDc7+MjiYV2YxAEb7H8OGJ5b+JaorJSCQqfDKXEuG3Cx9thsy1XEe
    eYaVYBOIoj1D9BZV/DPhoEcpBqjcsznbj0sFa/Cg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfA8vSHuai9W4LIhZUDlG3p5dA7NRuHnCs75M1WhLRKzpn/sUzAEfGDAXtY5LJeFlPvwL4j39ou29FmuRFiYpGctW4SqBCOjq3ZPi4je/Ck7dvsFUK4TC
    olGglq7WmKrYszRd8CVNyc1L/0xSoDbtep1OYUavyc1nEVIOSYEuyk8F7xf48D4J+wHJzUulN7bstE2bWpI7uSGRpdZSVMzZ5frFGtuyF0siCgGCQmKAn/Y+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8981fWPbAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8
    a=tBb2bbeoAAAA:8 a=ag1SF4gXAAAA:8 a=zYvEwg2aL9dim6SEHGUA:9 a=QEXdDO2ut3YA:10
    a=o72u2rHnfW5qNJ_4I8LD:22 a=AjGcO6oz07-iQ99wixmX:22 a=Oj-tNtZlA1e06AYgeCfH:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934679AbeD0OiV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934633AbeD0OJN (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:09:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5584621864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4.14 74/80] block/swim: Fix array bounds check
Date: Fri, 27 Apr 2018 15:59:07 +0200
Message-Id: <20180427135736.753978656@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Finn Thain <fthain@telegraphics.com.au>

commit 7ae6a2b6cc058005ee3d0d2b9ce27688e51afa4b upstream.

In the floppy_find() function in swim.c is a call to
get_disk(swd->unit[drive].disk). The actual parameter to this call
can be a NULL pointer when drive == swd->floppy_count. This causes
an oops in get_disk().

Data read fault at 0x00000198 in Super Data (pc=0x1be5b6)
BAD KERNEL BUSERR
Oops: 00000000
Modules linked in: swim_mod ipv6 mac8390
PC: [<001be5b6>] get_disk+0xc/0x76
SR: 2004  SP: 9a078bc1  a2: 0213ed90
d0: 00000000    d1: 00000000    d2: 00000000    d3: 000000ff
d4: 00000002    d5: 02983590    a0: 02332e00    a1: 022dfd64
Process dd (pid: 285, task=020ab25b)
Frame format=B ssw=074d isc=4a88 isb=6732 daddr=00000198 dobuf=00000000
baddr=001be5bc dibuf=bfffffff ver=f
Stack from 022dfca4:
        00000000 0203fc00 0213ed90 022dfcc0 02982936 00000000 00200000 022dfd08
        0020f85a 00200000 022dfd64 02332e00 004040fc 00000014 001be77e 022dfd64
        00334e4a 001be3f8 0800001d 022dfd64 01c04b60 01c04b70 022aba80 029828f8
        02332e00 022dfd2c 001be7ac 0203fc00 00200000 022dfd64 02103a00 01c04b60
        01c04b60 0200e400 022dfd68 000e191a 00200000 022dfd64 02103a00 0800001d
        00000000 00000003 000b89de 00500000 02103a00 01c04b60 02103a08 01c04c2e
Call Trace: [<02982936>] floppy_find+0x3e/0x4a [swim_mod]
 [<00200000>] uart_remove_one_port+0x1a2/0x260
 [<0020f85a>] kobj_lookup+0xde/0x132
 [<00200000>] uart_remove_one_port+0x1a2/0x260
 [<001be77e>] get_gendisk+0x0/0x130
 [<00334e4a>] mutex_lock+0x0/0x2e
 [<001be3f8>] disk_block_events+0x0/0x6c
 [<029828f8>] floppy_find+0x0/0x4a [swim_mod]
 [<001be7ac>] get_gendisk+0x2e/0x130
 [<00200000>] uart_remove_one_port+0x1a2/0x260
 [<000e191a>] __blkdev_get+0x32/0x45a
 [<00200000>] uart_remove_one_port+0x1a2/0x260
 [<000b89de>] complete_walk+0x0/0x8a
 [<000e1e22>] blkdev_get+0xe0/0x29a
 [<000e1fdc>] blkdev_open+0x0/0xb0
 [<000b89de>] complete_walk+0x0/0x8a
 [<000e1fdc>] blkdev_open+0x0/0xb0
 [<000e01cc>] bd_acquire+0x74/0x8a
 [<000e205c>] blkdev_open+0x80/0xb0
 [<000e1fdc>] blkdev_open+0x0/0xb0
 [<000abf24>] do_dentry_open+0x1a4/0x322
 [<00020000>] __do_proc_douintvec+0x22/0x27e
 [<000b89de>] complete_walk+0x0/0x8a
 [<000baa62>] link_path_walk+0x0/0x48e
 [<000ba3f8>] inode_permission+0x20/0x54
 [<000ac0e4>] vfs_open+0x42/0x78
 [<000bc372>] path_openat+0x2b2/0xeaa
 [<000bc0c0>] path_openat+0x0/0xeaa
 [<0004463e>] __irq_wake_thread+0x0/0x4e
 [<0003a45a>] task_tick_fair+0x18/0xc8
 [<000bd00a>] do_filp_open+0xa0/0xea
 [<000abae0>] do_sys_open+0x11a/0x1ee
 [<00020000>] __do_proc_douintvec+0x22/0x27e
 [<000abbf4>] SyS_open+0x1e/0x22
 [<00020000>] __do_proc_douintvec+0x22/0x27e
 [<00002b40>] syscall+0x8/0xc
 [<00020000>] __do_proc_douintvec+0x22/0x27e
 [<0000c00b>] dyadic+0x1/0x28
Code: 4e5e 4e75 4e56 fffc 2f0b 2f02 266e 0008 <206b> 0198 4a88 6732 2428 002c 661e 486b 0058 4eb9 0032 0b96 588f 4a88 672c 2008
Disabling lock debugging due to kernel taint

Fix the array index bounds check to avoid this.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Fixes: 8852ecd97488 ("[PATCH] m68k: mac - Add SWIM floppy support")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/swim.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -790,7 +790,7 @@ static struct kobject *floppy_find(dev_t
 	struct swim_priv *swd = data;
 	int drive = (*part & 3);
 
-	if (drive > swd->floppy_count)
+	if (drive >= swd->floppy_count)
 		return NULL;
 
 	*part = 0;
