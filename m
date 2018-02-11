Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518323705-2-15396244825850246018
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
    t=1518323705; b=OF2t7nauWs6Z9TfNsUviu23pdO1CUmFOHoZhNIbEXYAt890
    vlGTXG1hKTdX/sjTZwlVXuz8SSKSulfT7KWzlVhX6BHT9Ilqu02LriCOqLngIrFt
    qbnywpBYPUQgSxm//xOxY4JFRQgEzXWFDrNBzHa5xhAsak8kA2hJuFNeK0TK8djg
    C25Jec6N7aOJL6LwBmvyCCnCAnKa2FZEnvAq8ETAMJ85tEYCrQO41gL/NAhX1YuS
    XC5o46qj7TlbWsP+JpQTqqtCp+bdzXeQhhOLjaoDXYvtlHzEouAosozkUIPJ+j1t
    +4xZTl6BJjs0q2iBoxgWvOZKH9Fayv1eMtRKvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323705; bh=MA/nS8Tp9B0IwgyFXcY
    vsRvKi2kXlJ23cahD4ZIrm8I=; b=not50u0o3HtvtzZx8tlBA7PkXGMn2ic5bLD
    o1Fv5uJ64LVEDPbTw8mgyXzrEZfy49taQu5b8yuvyoYrUzdRw5zMmsf6k5DGzMTd
    RctJufJ8zz8bXoMw+v6Rv4PnNG73lzJh3UoKSVB3Y1HxR1/CkCUyLX3qFJUbAjI7
    Q4Z76dAmZGXUDOyRRfqfSfAbbW+ZSZDbS4078WZnirGbscTI0nY/6g+SpfLdMlFU
    /1esdl5h5uChIDRs8mXEasK32qlOXl9rDOa/R90/3Uz4NlJridZbI88mUDTI8xsE
    k9vdyJS00y/viC3YCQLq51sNEbQjvfSR5m2O0nB/+Y/Nx+L1ZXA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeBKEfA (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:35:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41775 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753007AbeBKEeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
        "Xin Long" <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Alexander Potapenko" <glider@google.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.376040765@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 084/136] sctp: fully initialize the IPv6 address in
 sctp_v6_to_addr()
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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sctp/ipv6.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -491,7 +491,9 @@ static void sctp_v6_to_addr(union sctp_a
 {
 	addr->sa.sa_family = AF_INET6;
 	addr->v6.sin6_port = port;
+	addr->v6.sin6_flowinfo = 0;
 	addr->v6.sin6_addr = *saddr;
+	addr->v6.sin6_scope_id = 0;
 }
 
 /* Compare addresses exactly.
