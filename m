Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4009650-1520450673-2-2958768063313079203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520450672; b=eIjz0Rd7TQWTqa8iVctnxE/49C8dqFd2AEsaZlMkREsoe+k
    ey0s3xAVrKn7HYiDcfXZ+zs1elxeiGJGqJVQIHssZDctB1A+UEZgTCK861LMDj47
    ZbYX/QPd7wal5jnBnDfWIlFYxnKFI1sM3DmKl3XbLlXWzeDilHf3Yu3VUc3QAj6P
    xPbVl0WJoYAJ8BXDtmAvAvPZeaoCu/wY5D/yCE/KphNPDOqHQYlOJJ4mEMOxVtbR
    Osls9hDPb9SjaYNWom5zMu7RqlmwYFVbPl0bb4G5bHwkYIle8gW/bsmg76G8lMLG
    K/IiE6BOjNLXjPQB3vdsjFRPnJM2RAW6BSCjFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520450672; bh=SIkQJEg4fzKybDAjTz38b5JfGa
    SZqtgpDYlm1bPPWIw=; b=YIkTWFY1XBr6rGGF9SzD6i2LweXn7t80+bw0nOKWAa
    FRdayBaxGVBqN+WXMyyMtuKw/AvVo6Yw1+S+N6Ub9g5HZnenWcHONqT0ukjYFiJ+
    S2efMvH6UFUM6hZXof6zFt3VL5YP9HWt3XBUAvKNtd3PJ8Y+6gxpPSFd+VstXAbc
    /rrkw0nmVeyA0xsV1y1ZAASTNAx6/eAUWTD0tb5tJcu95qes2MBSsPBW38Xd/w3U
    GLonvFArqyUMCvD8LbMb0zS/hpLGnQ8rxEdBtJw5qyaXKnWd8/aTaIYET9dtzOlG
    +r6FHYgifdgU5QEnczdxC9xQlzgnf32Np7L3P5LU4doA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=lH8bx8F6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=STUPAUY+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=lH8bx8F6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=STUPAUY+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933418AbeCGTY3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:24:29 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43502 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCGTY2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:24:28 -0500
X-Google-Smtp-Source: AG47ELu3e+tpzZBh4lyiM1ZHcwtkkGLnSHHVaWTX72nS7BtBCpTCxYeCZQ3mO9012mIYrcYiM1YG3g==
From: Greg Hackmann <ghackmann@google.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
Subject: [PATCH] net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()
Date: Wed,  7 Mar 2018 11:24:16 -0800
Message-Id: <20180307192416.233202-1-ghackmann@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

f7c83bcbfaf5 ("net: xfrm: use __this_cpu_read per-cpu helper") added a
__this_cpu_read() call inside ipcomp_alloc_tfms().  Since this call was
introduced, the rules around per-cpu accessors have been tightened and
__this_cpu_read() cannot be used in a preemptible context.

syzkaller reported this leading to the following kernel BUG while
fuzzing sendmsg:

BUG: using __this_cpu_read() in preemptible [00000000] code: repro/3101
caller is ipcomp_init_state+0x185/0x990
CPU: 3 PID: 3101 Comm: repro Not tainted 4.16.0-rc4-00123-g86f84779d8e9 #154
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Call Trace:
 dump_stack+0xb9/0x115
 check_preemption_disabled+0x1cb/0x1f0
 ipcomp_init_state+0x185/0x990
 ? __xfrm_init_state+0x876/0xc20
 ? lock_downgrade+0x5e0/0x5e0
 ipcomp4_init_state+0xaa/0x7c0
 __xfrm_init_state+0x3eb/0xc20
 xfrm_init_state+0x19/0x60
 pfkey_add+0x20df/0x36f0
 ? pfkey_broadcast+0x3dd/0x600
 ? pfkey_sock_destruct+0x340/0x340
 ? pfkey_seq_stop+0x80/0x80
 ? __skb_clone+0x236/0x750
 ? kmem_cache_alloc+0x1f6/0x260
 ? pfkey_sock_destruct+0x340/0x340
 ? pfkey_process+0x62a/0x6f0
 pfkey_process+0x62a/0x6f0
 ? pfkey_send_new_mapping+0x11c0/0x11c0
 ? mutex_lock_io_nested+0x1390/0x1390
 pfkey_sendmsg+0x383/0x750
 ? dump_sp+0x430/0x430
 sock_sendmsg+0xc0/0x100
 ___sys_sendmsg+0x6c8/0x8b0
 ? copy_msghdr_from_user+0x3b0/0x3b0
 ? pagevec_lru_move_fn+0x144/0x1f0
 ? find_held_lock+0x32/0x1c0
 ? do_huge_pmd_anonymous_page+0xc43/0x11e0
 ? lock_downgrade+0x5e0/0x5e0
 ? get_kernel_page+0xb0/0xb0
 ? _raw_spin_unlock+0x29/0x40
 ? do_huge_pmd_anonymous_page+0x400/0x11e0
 ? __handle_mm_fault+0x553/0x2460
 ? __fget_light+0x163/0x1f0
 ? __sys_sendmsg+0xc7/0x170
 __sys_sendmsg+0xc7/0x170
 ? SyS_shutdown+0x1a0/0x1a0
 ? __do_page_fault+0x5a0/0xca0
 ? lock_downgrade+0x5e0/0x5e0
 SyS_sendmsg+0x27/0x40
 ? __sys_sendmsg+0x170/0x170
 do_syscall_64+0x19f/0x640
 entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x7f0ee73dfb79
RSP: 002b:00007ffe14fc15a8 EFLAGS: 00000207 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0ee73dfb79
RDX: 0000000000000000 RSI: 00000000208befc8 RDI: 0000000000000004
RBP: 00007ffe14fc15b0 R08: 00007ffe14fc15c0 R09: 00007ffe14fc15c0
R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000400440
R13: 00007ffe14fc16b0 R14: 0000000000000000 R15: 0000000000000000

Cc: stable@vger.kernel.org
Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 net/xfrm/xfrm_ipcomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index ccfdc7115a83..a00ec715aa46 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -283,7 +283,7 @@ static struct crypto_comp * __percpu *ipcomp_alloc_tfms(const char *alg_name)
 		struct crypto_comp *tfm;
 
 		/* This can be any valid CPU ID so we don't need locking. */
-		tfm = __this_cpu_read(*pos->tfms);
+		tfm = this_cpu_read(*pos->tfms);
 
 		if (!strcmp(crypto_comp_name(tfm), alg_name)) {
 			pos->users++;
-- 
2.16.2.395.g2e18187dfd-goog
