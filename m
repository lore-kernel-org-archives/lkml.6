Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414834-2-9246982703007791714
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414833; b=HoL2H+gFdD+o+6yQ3bJSJnrMWHkZSIj/dEVuXRtQqJPPpw0
    +4/EXPrEQ51EofEYW18zp+/RFjRZYoasyBSALNtCvM8osRQOgwFOR1VPJC0mkHX+
    W/lyLVn0jGkfBAVhdMB5+r7UecvJ406Fne4JdNaIWWvOGJla75zM/rXnec6eMpja
    2MkI7hYlEZ7qPn2HWnHFeelmpOd/CViiw9WC8To5zpR2QdOsBjmlQQOo2Yrb2xR6
    A5taYgHNZdQYc1hDXXiw1pjFP9L4KEBaNVpUqKqCIQKdRURiKPSWZ1zHIJeGo0zV
    hWaYAQX1k5hlMVLyCZmF93G/8yicAwK5xgrbmxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414833; bh=lVfKCvwud4g9zUwRMKYXglCYag
    eY0G9tOAMCLtwMFsE=; b=ocmcNKFi1FshhtplP/Q6E+Ot4hGm+IuBgOpzh85k04
    nOM1s7z8u71WAR8w9m9VId+FS1+TSy9gfm7yK/X8Gxha3hDPCEIxIa7RoDpvmX3P
    7zQzMhbjtJMcmn8j+RsiOo1qeNGnyJiv0YaswBSLcpA/GR4msynhoopAfrZlmHpD
    5nouEbWhEsUoISQVCB94gdOfxX23L8AiLw3/wd1foFsOjAJ5Ni2H7fGjQZDJjOSw
    gt/TP58Atv1dMRqpYrw+czm+jzxUDHwH1nUmr5jOeQY32mDHzezgsaRoYbZRb546
    AC2547OQpchhZ2lYXhfFeOU855QxL4FSQkMAwoV6NioA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934540AbeBWSt3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:49:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45288 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934016AbeBWSt0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        Timo Teras <timo.teras@iki.fi>,
        Christophe Gouault <christophe.gouault@6wind.com>,
        syzbot
        <bot+c028095236fcb6f4348811565b75084c754dc729@syzkaller.appspotmail.com>,
        Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.14 011/159] xfrm: skip policies marked as dead while rehashing
Date: Fri, 23 Feb 2018 19:25:19 +0100
Message-Id: <20180223170744.559775565@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

commit 862591bf4f519d1b8d859af720fafeaebdd0162a upstream.

syzkaller triggered following KASAN splat:

BUG: KASAN: slab-out-of-bounds in xfrm_hash_rebuild+0xdbe/0xf00 net/xfrm/xfrm_policy.c:618
read of size 2 at addr ffff8801c8e92fe4 by task kworker/1:1/23 [..]
Workqueue: events xfrm_hash_rebuild [..]
 __asan_report_load2_noabort+0x14/0x20 mm/kasan/report.c:428
 xfrm_hash_rebuild+0xdbe/0xf00 net/xfrm/xfrm_policy.c:618
 process_one_work+0xbbf/0x1b10 kernel/workqueue.c:2112
 worker_thread+0x223/0x1990 kernel/workqueue.c:2246 [..]

The reproducer triggers:
1016                 if (error) {
1017                         list_move_tail(&walk->walk.all, &x->all);
1018                         goto out;
1019                 }

in xfrm_policy_walk() via pfkey (it sets tiny rcv space, dump
callback returns -ENOBUFS).

In this case, *walk is located the pfkey socket struct, so this socket
becomes visible in the global policy list.

It looks like this is intentional -- phony walker has walk.dead set to 1
and all other places skip such "policies".

Ccing original authors of the two commits that seem to expose this
issue (first patch missed ->dead check, second patch adds pfkey
sockets to policies dumper list).

Fixes: 880a6fab8f6ba5b ("xfrm: configure policy hash table thresholds by netlink")
Fixes: 12a169e7d8f4b1c ("ipsec: Put dumpers on the dump list")
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Timo Teras <timo.teras@iki.fi>
Cc: Christophe Gouault <christophe.gouault@6wind.com>
Reported-by: syzbot <bot+c028095236fcb6f4348811565b75084c754dc729@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_policy.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -610,7 +610,8 @@ static void xfrm_hash_rebuild(struct wor
 
 	/* re-insert all policies by order of creation */
 	list_for_each_entry_reverse(policy, &net->xfrm.policy_all, walk.all) {
-		if (xfrm_policy_id2dir(policy->index) >= XFRM_POLICY_MAX) {
+		if (policy->walk.dead ||
+		    xfrm_policy_id2dir(policy->index) >= XFRM_POLICY_MAX) {
 			/* skip socket policies */
 			continue;
 		}
