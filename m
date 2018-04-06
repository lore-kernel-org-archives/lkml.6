Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523021660-2-17677458096343523728
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021659; b=eLBN3k8fSUjMM78BaImDi+emk8Bjl5AOJfLnc9yu0wBtvoUZCN
    EQBnx/pGHbq+AYQCLXKzFUSUJyuVWEk5RI+LAp6NxM7x2LU4wECvgXIqGaunnEoH
    RlqEWtYH8mRbWAAvJpsWJtQfwh00abc5x3UwQlzzW4BCKlAHWOfDOscBO6d7fNA/
    ArmfHZPocw9byyQd2hWAPOQHFx2xly3rkeazhXlO3+WVeTsQnfuv5POEL+O3TL0Q
    mURloP6jMwJJYL8L//6IGkwUrrjU/Fh4zIqGpmlt+KK6HkemRWaBmNU1GlL8Z/Ae
    l2ZhMiBuOGGMsCCKoOaFPjAV3hYvTrDLYgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021659; bh=O495A2h4rAUxMSkX4R0Bo+IM0kqCj9
    4vZi3Wm5xx3+A=; b=FjDWwmf6QunOYVtHywbJqlkhhJ5wQgwdVfxUkM/XcUK8nE
    ukKi2TCN7+YPf5zk98z8i2GlhlkqxFwb6rQfmCxsY9U2e53X6QY0fmuWhcdDl7EI
    XinengW6vbo6usE4WAiN1y4n5VtHNH9VfMYfsUw0+GHNEz1rsTjLtdGcCRlkgn2q
    x2paRBszHSMuUe1Xt+EPZ+0aJ/uYmIqjT0cvku1diVYysrNdJMH34wxt2xuDkIXW
    0HeuDalxm34z/1pbMyD6agFAARK8xP37ho0WGv54zRUzu1F2peoaTFcFC3RUlUVn
    /WQzuTC8MpBwNa5LDcGDvE5TYKQziJHR1F5wmiwQ==
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
X-CM-Envelope: MS4wfKivSW6JSSJWsN3GFxmv0p0SGOfBnZq0Vws2HwgTsS/J9UpW09+qvGpHxIcjrbFuPw9Qc3cAtd2xS9vVyHXA1oTqkhycvnPoFDjCK9AOXyMvcY8bSA1H
    MWu4cqXzlu5TgkELZviBpnHqUlP0kNdKIyVfiDymzz+iHAwNToRSyCph4FTytj0h9ug3Md83uO5XXtlCq6TkdsuyXZXUoivKp14FlFXWDgC2VVwWFY6oi6GU
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=7ZN4cI0QAAAA:8 a=ag1SF4gXAAAA:8 a=IQiBa5yE71Sq9Y6vsHgA:9
    a=QEXdDO2ut3YA:10 a=Dl0WHwQvj8hGZljrFLtM:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755794AbeDFNeP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:34:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58214 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755788AbeDFNeM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:34:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Hackmann <ghackmann@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.9 042/102] net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()
Date: Fri,  6 Apr 2018 15:23:23 +0200
Message-Id: <20180406084337.589659794@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Hackmann <ghackmann@google.com>

commit 0dcd7876029b58770f769cbb7b484e88e4a305e5 upstream.

f7c83bcbfaf5 ("net: xfrm: use __this_cpu_read per-cpu helper") added a
__this_cpu_read() call inside ipcomp_alloc_tfms().

At the time, __this_cpu_read() required the caller to either not care
about races or to handle preemption/interrupt issues.  3.15 tightened
the rules around some per-cpu operations, and now __this_cpu_read()
should never be used in a preemptible context.  On 3.15 and later, we
need to use this_cpu_read() instead.

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

Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_ipcomp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -283,7 +283,7 @@ static struct crypto_comp * __percpu *ip
 		struct crypto_comp *tfm;
 
 		/* This can be any valid CPU ID so we don't need locking. */
-		tfm = __this_cpu_read(*pos->tfms);
+		tfm = this_cpu_read(*pos->tfms);
 
 		if (!strcmp(crypto_comp_name(tfm), alg_name)) {
 			pos->users++;
