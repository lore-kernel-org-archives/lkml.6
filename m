Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518325735-2-1454644671039572450
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325734; b=CYesewUIHmF2OWoUqTXMp2oX++EhJ7dKSUEi7Ghtdvs2+7U
    qMOAjsWICBQuT41b1R+K7oueZesGE4+vNFndJbUS64mlNTCNnuu4WzQOtT7M1rK7
    QIEKrnodh+8u8ze5ydIlKgRE5YZ5BM7gCUOc+3WCYyUyI8Fy+eR2GOKJsxOts6hT
    drVdnb30feAPJMCi6d0u6dhy8oIC/oPbpK2foEhFE/xOjDCUHT37ijs0dVJ9JotF
    SvCF+y8ulWMozqZoHTtRYm63jTsYXIGU0WzOndmKefqbMI37EKpXcUgj7RG6kHXO
    BpIRCJXAyJ3082fPguTNtCXO9u9k4cKsI8+c6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325734; bh=PJZbxEB4fmnccTkyBCd
    BRb0Nj+cc92VlfuFoYJwqgKU=; b=mnHtLMxplXMqVVn7ZLszoeY7rrMllICEVNw
    F3rR+ya4fiPGJQmQA471MGoZuk+UZMuAOFpmZ5zSysiHYSkQDyZre4GNR8m0sXlG
    yP4KbNTaSD1KGOwcxB4XYFpNrK9mSZdbKGpNGAbMKycoNIwK0QjU09uQVDKmTOdp
    u8lYSK7YVXuqoY8h9aYE2i7liN4+Gqiuw8rYO5K1nbDAdVwcOIxsensJDIVVJxpW
    8cs6lIX1xxnzY7W/l4jqP/YUd4qOai/b7sNIasc2zkWZWS6upacuEBXFnVf9IWms
    n1+QLzXwu5a2o51CDUkumOVpEUiB+go/lSxbI6tFctKqT9H0pmg==
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
        id S1753727AbeBKFHd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:07:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41419 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752635AbeBKEdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Xin Long" <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
        "Alexander Potapenko" <glider@google.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.241527982@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 42/79] sctp: fully initialize the IPv6 address in
 sctp_v6_to_addr()
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Potapenko <glider@google.com>

commit 15339e441ec46fbc3bf3486bb1ae4845b0f1bb8d upstream.

KMSAN reported use of uninitialized sctp_addr->v4.sin_addr.s_addr and
sctp_addr->v6.sin6_scope_id in sctp_v6_cmp_addr() (see below).
Make sure all fields of an IPv6 address are initialized, which
guarantees that the IPv4 fields are also initialized.

==================================================================
 BUG: KMSAN: use of uninitialized memory in sctp_v6_cmp_addr+0x8d4/0x9f0
 net/sctp/ipv6.c:517
 CPU: 2 PID: 31056 Comm: syz-executor1 Not tainted 4.11.0-rc5+ #2944
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs
 01/01/2011
 Call Trace:
  dump_stack+0x172/0x1c0 lib/dump_stack.c:42
  is_logbuf_locked mm/kmsan/kmsan.c:59 [inline]
  kmsan_report+0x12a/0x180 mm/kmsan/kmsan.c:938
  native_save_fl arch/x86/include/asm/irqflags.h:18 [inline]
  arch_local_save_flags arch/x86/include/asm/irqflags.h:72 [inline]
  arch_local_irq_save arch/x86/include/asm/irqflags.h:113 [inline]
  __msan_warning_32+0x61/0xb0 mm/kmsan/kmsan_instr.c:467
  sctp_v6_cmp_addr+0x8d4/0x9f0 net/sctp/ipv6.c:517
  sctp_v6_get_dst+0x8c7/0x1630 net/sctp/ipv6.c:290
  sctp_transport_route+0x101/0x570 net/sctp/transport.c:292
  sctp_assoc_add_peer+0x66d/0x16f0 net/sctp/associola.c:651
  sctp_sendmsg+0x35a5/0x4f90 net/sctp/socket.c:1871
  inet_sendmsg+0x498/0x670 net/ipv4/af_inet.c:762
  sock_sendmsg_nosec net/socket.c:633 [inline]
  sock_sendmsg net/socket.c:643 [inline]
  SYSC_sendto+0x608/0x710 net/socket.c:1696
  SyS_sendto+0x8a/0xb0 net/socket.c:1664
  entry_SYSCALL_64_fastpath+0x13/0x94
 RIP: 0033:0x44b479
 RSP: 002b:00007f6213f21c08 EFLAGS: 00000286 ORIG_RAX: 000000000000002c
 RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 000000000044b479
 RDX: 0000000000000041 RSI: 0000000020edd000 RDI: 0000000000000006
 RBP: 00000000007080a8 R08: 0000000020b85fe4 R09: 000000000000001c
 R10: 0000000000040005 R11: 0000000000000286 R12: 00000000ffffffff
 R13: 0000000000003760 R14: 00000000006e5820 R15: 0000000000ff8000
 origin description: ----dst_saddr@sctp_v6_get_dst
 local variable created at:
  sk_fullsock include/net/sock.h:2321 [inline]
  inet6_sk include/linux/ipv6.h:309 [inline]
  sctp_v6_get_dst+0x91/0x1630 net/sctp/ipv6.c:241
  sctp_transport_route+0x101/0x570 net/sctp/transport.c:292
==================================================================
 BUG: KMSAN: use of uninitialized memory in sctp_v6_cmp_addr+0x8d4/0x9f0
 net/sctp/ipv6.c:517
 CPU: 2 PID: 31056 Comm: syz-executor1 Not tainted 4.11.0-rc5+ #2944
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs
 01/01/2011
 Call Trace:
  dump_stack+0x172/0x1c0 lib/dump_stack.c:42
  is_logbuf_locked mm/kmsan/kmsan.c:59 [inline]
  kmsan_report+0x12a/0x180 mm/kmsan/kmsan.c:938
  native_save_fl arch/x86/include/asm/irqflags.h:18 [inline]
  arch_local_save_flags arch/x86/include/asm/irqflags.h:72 [inline]
  arch_local_irq_save arch/x86/include/asm/irqflags.h:113 [inline]
  __msan_warning_32+0x61/0xb0 mm/kmsan/kmsan_instr.c:467
  sctp_v6_cmp_addr+0x8d4/0x9f0 net/sctp/ipv6.c:517
  sctp_v6_get_dst+0x8c7/0x1630 net/sctp/ipv6.c:290
  sctp_transport_route+0x101/0x570 net/sctp/transport.c:292
  sctp_assoc_add_peer+0x66d/0x16f0 net/sctp/associola.c:651
  sctp_sendmsg+0x35a5/0x4f90 net/sctp/socket.c:1871
  inet_sendmsg+0x498/0x670 net/ipv4/af_inet.c:762
  sock_sendmsg_nosec net/socket.c:633 [inline]
  sock_sendmsg net/socket.c:643 [inline]
  SYSC_sendto+0x608/0x710 net/socket.c:1696
  SyS_sendto+0x8a/0xb0 net/socket.c:1664
  entry_SYSCALL_64_fastpath+0x13/0x94
 RIP: 0033:0x44b479
 RSP: 002b:00007f6213f21c08 EFLAGS: 00000286 ORIG_RAX: 000000000000002c
 RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 000000000044b479
 RDX: 0000000000000041 RSI: 0000000020edd000 RDI: 0000000000000006
 RBP: 00000000007080a8 R08: 0000000020b85fe4 R09: 000000000000001c
 R10: 0000000000040005 R11: 0000000000000286 R12: 00000000ffffffff
 R13: 0000000000003760 R14: 00000000006e5820 R15: 0000000000ff8000
 origin description: ----dst_saddr@sctp_v6_get_dst
 local variable created at:
  sk_fullsock include/net/sock.h:2321 [inline]
  inet6_sk include/linux/ipv6.h:309 [inline]
  sctp_v6_get_dst+0x91/0x1630 net/sctp/ipv6.c:241
  sctp_transport_route+0x101/0x570 net/sctp/transport.c:292
==================================================================

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sctp/ipv6.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -487,7 +487,9 @@ static void sctp_v6_to_addr(union sctp_a
 {
 	addr->sa.sa_family = AF_INET6;
 	addr->v6.sin6_port = port;
+	addr->v6.sin6_flowinfo = 0;
 	ipv6_addr_copy(&addr->v6.sin6_addr, saddr);
+	addr->v6.sin6_scope_id = 0;
 }
 
 /* Compare addresses exactly.
