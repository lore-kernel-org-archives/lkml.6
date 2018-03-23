Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806405-2-16826594197467958249
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES rocaen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806404; b=PAZS5N6uq0MF93iBAJaFo6nP7YsrEHVRGBfE29uZ+tc5SZ3
    Hr/uMMuBR3ryctkmmFKajRB6+sIS0NfDwCMLWKcJhkxvEngjcCb5RlqdOnipnjK1
    8upUEO66Y0Zk2DBk4n7smIFI0vzxhSz3buDFbmU+uWDQkXEX54YdA/f6Ue3nZuvG
    H/2fBYRWAsVyihUiNKgHgi5YZyKqEsaC8NmUQYqKXqhoKXKyBD1ffvB8QIbj0iwb
    IX1Wf8aAbgiC+H6eqJ0u5103hNfCIbkaqHz+5ID4B5k58kIYXTPNjy2oJV2AlCTL
    euTGxPCIcC9Jb98rJBk9qeGhnS+WmVhR7Wq1ZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806404; bh=pcUSL0XXN7uoA1E2jRUFAcbm2K
    LYejUI8qLmtExgiTA=; b=mnrbzJKZjLwzKMLen8sVHPBOIBzI4FzKChROx7uNYX
    9F56BnUznIiUXw5xD0T2Tp/YzO6WXwmOVBm3bMfLW3KvoYVjC+RlQ2td+6hcyAeu
    zzXMmfzjH7EFQEJr21+7v/fs6n6WUJNFNNCPRHWb9PN/qlVKxwMMf9D1j2fnvxts
    kLppPVYDLaRomUbrRch5NLwBPZBIbjX3MO9xpz+t0WXupbuKOqnanT60KTUDQuev
    D31uGRQ2ZTB0hf+CQ1pv6sWxLM+pxDvYTM4oi3R7v4zBKC41rUQfKEPlIuGIz2tr
    iyrNDwfChWK7+1AQblZSWSSBACen31XNgNR6fp9ioYrQ==
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
        id S1753521AbeCWKAM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:00:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeCWKAL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:00:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+2287ac532caa81900a4e@syzkaller.appspotmail.com,
        Leon Romanovsky <leonro@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.15 84/84] RDMA/ucma: Dont allow join attempts for unsupported AF family
Date: Fri, 23 Mar 2018 10:54:38 +0100
Message-Id: <20180323095424.636689075@linuxfoundation.org>
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

From: Leon Romanovsky <leonro@mellanox.com>

commit 0c81ffc60d5280991773d17e84bda605387148b1 upstream.

Users can provide garbage while calling to ucma_join_ip_multicast(),
it will indirectly cause to rdma_addr_size() return 0, making the
call to ucma_process_join(), which had the right checks, but it is
better to check the input as early as possible.

The following crash from syzkaller revealed it.

kernel BUG at lib/string.c:1052!
invalid opcode: 0000 [#1] SMP KASAN Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4113 Comm: syz-executor0 Not tainted 4.16.0-rc5+ #261
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fortify_panic+0x13/0x20 lib/string.c:1051
RSP: 0018:ffff8801ca81f8f0 EFLAGS: 00010286
RAX: 0000000000000022 RBX: 1ffff10039503f23 RCX: 0000000000000000
RDX: 0000000000000022 RSI: 1ffff10039503ed3 RDI: ffffed0039503f12
RBP: ffff8801ca81f8f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000000 R12: ffff8801ca81f998
R13: ffff8801ca81f938 R14: ffff8801ca81fa58 R15: 000000000000fa00
FS:  0000000000000000(0000) GS:ffff8801db200000(0063) knlGS:000000000a12a900
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000008138024 CR3: 00000001cbb58004 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 memcpy include/linux/string.h:344 [inline]
 ucma_join_ip_multicast+0x36b/0x3b0 drivers/infiniband/core/ucma.c:1421
 ucma_write+0x2d6/0x3d0 drivers/infiniband/core/ucma.c:1633
 __vfs_write+0xef/0x970 fs/read_write.c:480
 vfs_write+0x189/0x510 fs/read_write.c:544
 SYSC_write fs/read_write.c:589 [inline]
 SyS_write+0xef/0x220 fs/read_write.c:581
 do_syscall_32_irqs_on arch/x86/entry/common.c:330 [inline]
 do_fast_syscall_32+0x3ec/0xf9f arch/x86/entry/common.c:392
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f9ec99
RSP: 002b:00000000ff8172cc EFLAGS: 00000282 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020000100
RDX: 0000000000000063 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Code: 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 48 89 df e8 42 2c e3 fb eb de
55 48 89 fe 48 c7 c7 80 75 98 86 48 89 e5 e8 85 95 94 fb <0f> 0b 90 90 90 90
90 90 90 90 90 90 90 55 48 89 e5 41 57 41 56
RIP: fortify_panic+0x13/0x20 lib/string.c:1051 RSP: ffff8801ca81f8f0

Fixes: 5bc2b7b397b0 ("RDMA/ucma: Allow user space to specify AF_IB when joining multicast")
Reported-by: <syzbot+2287ac532caa81900a4e@syzkaller.appspotmail.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1348,7 +1348,7 @@ static ssize_t ucma_process_join(struct
 		return -ENOSPC;
 
 	addr = (struct sockaddr *) &cmd->addr;
-	if (!cmd->addr_size || (cmd->addr_size != rdma_addr_size(addr)))
+	if (cmd->addr_size != rdma_addr_size(addr))
 		return -EINVAL;
 
 	if (cmd->join_flags == RDMA_MC_JOIN_FLAG_FULLMEMBER)
@@ -1416,6 +1416,9 @@ static ssize_t ucma_join_ip_multicast(st
 	join_cmd.uid = cmd.uid;
 	join_cmd.id = cmd.id;
 	join_cmd.addr_size = rdma_addr_size((struct sockaddr *) &cmd.addr);
+	if (!join_cmd.addr_size)
+		return -EINVAL;
+
 	join_cmd.join_flags = RDMA_MC_JOIN_FLAG_FULLMEMBER;
 	memcpy(&join_cmd.addr, &cmd.addr, join_cmd.addr_size);
 
@@ -1431,6 +1434,9 @@ static ssize_t ucma_join_multicast(struc
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
+	if (!rdma_addr_size((struct sockaddr *)&cmd.addr))
+		return -EINVAL;
+
 	return ucma_process_join(file, &cmd, out_len);
 }
 
