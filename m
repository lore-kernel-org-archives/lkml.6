Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835832-2-10078141081102945385
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
    t=1519835832; b=ZLU0d8Zk4Y/v+mW/2O0OYUL599kKoNasR79++hJn9DLjULE
    9mkeL77PHqyAdJNjwj3EZmlFITioJcJFqeqj2tBH7dCF4HAC1LgVcVMukGJ+nF+/
    f9PTJtgAQGWz+z5IP5Z5aoDjMdR8Q4tXOTuXi8wQFDiKvnhLOdJr/M/jTT+IEPhf
    XtGxlTDVLsFL/8DAp4XTP85PlmPaztq7yd+wGiveUow35RYZVW0I1LmL34LeL5fP
    IdKpt6XsFHMvPnh9ApsBbS0tDxfKbqJ+GKEAR8eoNg/EMabOAopd/ADQrMy3ELBQ
    rwpVh/Nyaq8zOBOoxltLbyvsash8U+Pmy6epuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835832; bh=mNAuFt2kZNd0feB3WWG
    38AcKYatdAtomUHIOCW2EJl0=; b=ma0Y5717B9VHEEUPEOslwT5sxM6LQ34hBj5
    RKOwgYSRHuC320gnqFjId6v1/lIpCd3wmVn2UWMDhvthp8d7QXLf9tjOZhjM9EH4
    G8G8A5x9izRydkhBbT8S96ek9D1/N+khc+DuO8stuo2S+51wAhv/CFKDS6z7BwAs
    dD0uH0PiBvV6/Rq8piw5yvU/Rl0bhaLC7lGGmVF74yqHeLBFY7sz8IO4zu3ZJR8c
    7dYti9/x1bL7UPmlWm7Ih7/V1belLzAdkEJ04MHyMidOl+OYMNV/AWXRQrcbHBCr
    I0RHfjoUMPKbzNWJO9P4qLk+k6mYS6nDbBp1r7JLMix5u36fUIQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932414AbeB1Qg6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:36:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34841 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932839AbeB1QEo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:44 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Guillaume Nault" <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+ed0838d0fa4c4f2b528e20286e6dc63effc7c14d@syzkaller.appspotmail.com,
        "Xin Long" <lucien.xin@gmail.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.139451129@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 227/254] pppoe: take ->needed_headroom of lower
 device into account on xmit
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

From: Guillaume Nault <g.nault@alphalink.fr>

commit 02612bb05e51df8489db5e94d0cf8d1c81f87b0c upstream.

In pppoe_sendmsg(), reserving dev->hard_header_len bytes of headroom
was probably fine before the introduction of ->needed_headroom in
commit f5184d267c1a ("net: Allow netdevices to specify needed head/tailroom").

But now, virtual devices typically advertise the size of their overhead
in dev->needed_headroom, so we must also take it into account in
skb_reserve().
Allocation size of skb is also updated to take dev->needed_tailroom
into account and replace the arbitrary 32 bytes with the real size of
a PPPoE header.

This issue was discovered by syzbot, who connected a pppoe socket to a
gre device which had dev->header_ops->create == ipgre_header and
dev->hard_header_len == 0. Therefore, PPPoE didn't reserve any
headroom, and dev_hard_header() crashed when ipgre_header() tried to
prepend its header to skb->data.

skbuff: skb_under_panic: text:000000001d390b3a len:31 put:24
head:00000000d8ed776f data:000000008150e823 tail:0x7 end:0xc0 dev:gre0
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:104!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 3670 Comm: syzkaller801466 Not tainted
4.15.0-rc7-next-20180115+ #97
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:skb_panic+0x162/0x1f0 net/core/skbuff.c:100
RSP: 0018:ffff8801d9bd7840 EFLAGS: 00010282
RAX: 0000000000000083 RBX: ffff8801d4f083c0 RCX: 0000000000000000
RDX: 0000000000000083 RSI: 1ffff1003b37ae92 RDI: ffffed003b37aefc
RBP: ffff8801d9bd78a8 R08: 1ffff1003b37ae8a R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff86200de0
R13: ffffffff84a981ad R14: 0000000000000018 R15: ffff8801d2d34180
FS:  00000000019c4880(0000) GS:ffff8801db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000208bc000 CR3: 00000001d9111001 CR4: 00000000001606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  skb_under_panic net/core/skbuff.c:114 [inline]
  skb_push+0xce/0xf0 net/core/skbuff.c:1714
  ipgre_header+0x6d/0x4e0 net/ipv4/ip_gre.c:879
  dev_hard_header include/linux/netdevice.h:2723 [inline]
  pppoe_sendmsg+0x58e/0x8b0 drivers/net/ppp/pppoe.c:890
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg+0xca/0x110 net/socket.c:640
  sock_write_iter+0x31a/0x5d0 net/socket.c:909
  call_write_iter include/linux/fs.h:1775 [inline]
  do_iter_readv_writev+0x525/0x7f0 fs/read_write.c:653
  do_iter_write+0x154/0x540 fs/read_write.c:932
  vfs_writev+0x18a/0x340 fs/read_write.c:977
  do_writev+0xfc/0x2a0 fs/read_write.c:1012
  SYSC_writev fs/read_write.c:1085 [inline]
  SyS_writev+0x27/0x30 fs/read_write.c:1082
  entry_SYSCALL_64_fastpath+0x29/0xa0

Admittedly PPPoE shouldn't be allowed to run on non Ethernet-like
interfaces, but reserving space for ->needed_headroom is a more
fundamental issue that needs to be addressed first.

Same problem exists for __pppoe_xmit(), which also needs to take
dev->needed_headroom into account in skb_cow_head().

Fixes: f5184d267c1a ("net: Allow netdevices to specify needed head/tailroom")
Reported-by: syzbot+ed0838d0fa4c4f2b528e20286e6dc63effc7c14d@syzkaller.appspotmail.com
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ppp/pppoe.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -832,6 +832,7 @@ static int pppoe_sendmsg(struct kiocb *i
 	struct pppoe_hdr *ph;
 	struct net_device *dev;
 	char *start;
+	int hlen;
 
 	lock_sock(sk);
 	if (sock_flag(sk, SOCK_DEAD) || !(sk->sk_state & PPPOX_CONNECTED)) {
@@ -850,16 +851,16 @@ static int pppoe_sendmsg(struct kiocb *i
 	if (total_len > (dev->mtu + dev->hard_header_len))
 		goto end;
 
-
-	skb = sock_wmalloc(sk, total_len + dev->hard_header_len + 32,
-			   0, GFP_KERNEL);
+	hlen = LL_RESERVED_SPACE(dev);
+	skb = sock_wmalloc(sk, hlen + sizeof(*ph) + total_len +
+			   dev->needed_tailroom, 0, GFP_KERNEL);
 	if (!skb) {
 		error = -ENOMEM;
 		goto end;
 	}
 
 	/* Reserve space for headers. */
-	skb_reserve(skb, dev->hard_header_len);
+	skb_reserve(skb, hlen);
 	skb_reset_network_header(skb);
 
 	skb->dev = dev;
@@ -920,7 +921,7 @@ static int __pppoe_xmit(struct sock *sk,
 	/* Copy the data if there is no space for the header or if it's
 	 * read-only.
 	 */
-	if (skb_cow_head(skb, sizeof(*ph) + dev->hard_header_len))
+	if (skb_cow_head(skb, LL_RESERVED_SPACE(dev) + sizeof(*ph)))
 		goto abort;
 
 	__skb_push(skb, sizeof(*ph));
