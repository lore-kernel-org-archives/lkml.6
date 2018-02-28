Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519838166-2-1476612083645008894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838166; b=wkgJQDwVKtAxA/RzAli/VMMJJZh5AHit9bghz6RZGIjapjX
    SQ8nhJWmBYTPAF56ADGojuP3zuNdjDqKA6wiKqvUzufH9XgjMAnBoT2zp2ubtyKT
    oGAtI/Lks4fzSB1oz6Lvy5YAKcv9ooSDy6MZawcuH7sJx0+tnviVlsLeH2wC/G3J
    LYlemsY8sxf+QFvU5W8MwHifMY1ucejxjibeLhsfK3Zzqk5ndcPw5VBtLDW+eYPB
    wJ6spL88Kr/PpFkS45D8dVI5clTa6frK10uJhA+tW4mfAbhrneTQU3lzkRukvf0B
    AhQJXRfiLvgff0yQhK2pjogk4Rs9NcPH2J0pw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838166; bh=8f7LEs203Tp5rvV2ZI0
    24E2siEaAglSgUZDnQG3Z9Ig=; b=C47gvEi/POmW32YGcgpFzuRNqc4w75iqFzM
    v/cUnKyTWHw0nkvx8LH/rONqF4EuuRAAVsZP/LNM3R2kSPaUVDZ/niOdR0i00IpP
    JFd0y+XikYOtcZ+DzLitPrRLoejFXhjBfsTvDS50Rnkh9JMDrYgtFtWjiHSc9dfr
    RDDtZ/Z4po3C/+ovuTY6RV2/NNX0KR+RwCVeNnq4kQ2Vl+Zn9x0anGehnQK5r/0Z
    exK0gsZX878g7AbSpXXjjZln+AgRjoRrQ4Fy42acaDHE/Va1WR5OWn5aYI8wHPBW
    60MArkALqveJ5cn57hjhPZ/682jwK8HW6TwO1rlvH/0iKGZEQKQ==
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
        id S933531AbeB1RPz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:15:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34236 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932284AbeB1PsG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:48:06 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "syzbot" <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Francesco Ruggeri" <fruggeri@aristanetworks.com>,
        "Eric Dumazet" <edumazet@google.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.708777711@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 031/254] net/packet: fix a race in packet_bind() and
 packet_notifier()
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

From: Eric Dumazet <edumazet@google.com>

commit 15fe076edea787807a7cdc168df832544b58eba6 upstream.

syzbot reported crashes [1] and provided a C repro easing bug hunting.

When/if packet_do_bind() calls __unregister_prot_hook() and releases
po->bind_lock, another thread can run packet_notifier() and process an
NETDEV_UP event.

This calls register_prot_hook() and hooks again the socket right before
first thread is able to grab again po->bind_lock.

Fixes this issue by temporarily setting po->num to 0, as suggested by
David Miller.

[1]
dev_remove_pack: ffff8801bf16fa80 not found
------------[ cut here ]------------
kernel BUG at net/core/dev.c:7945!  ( BUG_ON(!list_empty(&dev->ptype_all)); )
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
device syz0 entered promiscuous mode
CPU: 0 PID: 3161 Comm: syzkaller404108 Not tainted 4.14.0+ #190
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
task: ffff8801cc57a500 task.stack: ffff8801cc588000
RIP: 0010:netdev_run_todo+0x772/0xae0 net/core/dev.c:7945
RSP: 0018:ffff8801cc58f598 EFLAGS: 00010293
RAX: ffff8801cc57a500 RBX: dffffc0000000000 RCX: ffffffff841f75b2
RDX: 0000000000000000 RSI: 1ffff100398b1ede RDI: ffff8801bf1f8810
device syz0 entered promiscuous mode
RBP: ffff8801cc58f898 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801bf1f8cd8
R13: ffff8801cc58f870 R14: ffff8801bf1f8780 R15: ffff8801cc58f7f0
FS:  0000000001716880(0000) GS:ffff8801db400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020b13000 CR3: 0000000005e25000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:106
 tun_detach drivers/net/tun.c:670 [inline]
 tun_chr_close+0x49/0x60 drivers/net/tun.c:2845
 __fput+0x333/0x7f0 fs/file_table.c:210
 ____fput+0x15/0x20 fs/file_table.c:244
 task_work_run+0x199/0x270 kernel/task_work.c:113
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0x9bb/0x1ae0 kernel/exit.c:865
 do_group_exit+0x149/0x400 kernel/exit.c:968
 SYSC_exit_group kernel/exit.c:979 [inline]
 SyS_exit_group+0x1d/0x20 kernel/exit.c:977
 entry_SYSCALL_64_fastpath+0x1f/0x96
RIP: 0033:0x44ad19

Fixes: 30f7ea1c2b5f ("packet: race condition in packet_bind")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Francesco Ruggeri <fruggeri@aristanetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/packet/af_packet.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2732,6 +2732,10 @@ static int packet_do_bind(struct sock *s
 	if (need_rehook) {
 		if (po->running) {
 			rcu_read_unlock();
+			/* prevents packet_notifier() from calling
+			 * register_prot_hook()
+			 */
+			po->num = 0;
 			__unregister_prot_hook(sk, true);
 			rcu_read_lock();
 			dev_curr = po->prot_hook.dev;
@@ -2740,6 +2744,7 @@ static int packet_do_bind(struct sock *s
 								 dev->ifindex);
 		}
 
+		BUG_ON(po->running);
 		po->num = proto;
 		po->prot_hook.type = proto;
 
