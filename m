Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523399949-2-4371643602480030239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523399948; b=unaVzNKN7qCRYs55gM36jdgPpnd/bjIHNuZSezfq+KC+qhHMBW
    pZnPRy/hbujvUNTuH/nuDQxaC2E245GjmF5Htn2bD5TuupkAzJCkZ5v2x4TgzZUQ
    n3hkmNdn2a6CO2VuUs09BM0Bt6ahUKzWOX89aJ35Xi5X9+dioPeN/dIrLmjzVutw
    K0TEChYo08slEpQYlsdLYH+psf958Vf4J71bE2aksyg4p/IjrC5hDDz1ejVBBRMY
    qb7MdrKvo4aK7qHMW3tPzdilHDPlrTKWoHfy8PL5cd7tUQEgdExda1VA2EltZGEV
    qaVNhF1aTE2meVhBQnvPczZvATJVnGhjTXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399948; bh=eG8PW1UcHv4oBO8i0NFd9P4nGs0k0o
    ifP8N0MbzRlv0=; b=UA6MHr3SUMXlHw7phkVLEobbhb+mtrI01Kvm9re6ilWYnF
    bV213ocqaDkqVAkK9uOrAKnXyGWlqV7sPkblmB+DSoEgRn4VOcuXWxp3VBC9J7AT
    YfuaW15dNtiOfjUaTNmPiVDr8DNpxl+3w0ZpgkQ/P0T96dFlJhAkD56W2o/XsDOe
    Urvj55xVNBzfDoY5x4EmqTuB8aYfbD31n6tPP9FvG7+YQK8EKVOAkvxVtue6dFwi
    c/O/n2RTJjbS7EgOzZfry1ri7K4euNuXAK8tGyWSunVfOXb0Bd5mv8H3XGpBLJbV
    vD7d43gG1UKYvlnzZE2eCdHVBy83cZ2lFdkqtoTw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLaR7QPRDrSA1iTYt+2Gz0MBcwy+mVjrSIYi4agfqVvsf7k/I0VAEDaSdRfKA4q1ej7gBLLybhPWusBL+PTou1bkItlbBSJEZvEG2rR55swfCZnYjX6d
    ea8UjcQQx3okNIpPbefd4LzbDTnKggCREUb+UUZIDCcEgTize848hR++LN9s//t4esodPRIUzkYAyQdU/8hTv2GdZ6pbPcKVFnis6qXVsIisT3jU90PfK/AN
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=l5zREIWbMigowtcXp7QA:9 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932504AbeDJWjB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:39:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45046 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbeDJWi7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:38:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 118/138] ip_tunnel: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 00:25:08 +0200
Message-Id: <20180410212915.904565170@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 9cb726a212a82c88c98aa9f0037fd04777cd8fe5 ]

Use dev_valid_name() to make sure user does not provide illegal
device name.

syzbot caught the following bug :

BUG: KASAN: stack-out-of-bounds in strlcpy include/linux/string.h:300 [inline]
BUG: KASAN: stack-out-of-bounds in __ip_tunnel_create+0xca/0x6b0 net/ipv4/ip_tunnel.c:257
Write of size 20 at addr ffff8801ac79f810 by task syzkaller268107/4482

CPU: 0 PID: 4482 Comm: syzkaller268107 Not tainted 4.16.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x1b9/0x29f lib/dump_stack.c:53
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0xac/0x2f5 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
 memcpy+0x37/0x50 mm/kasan/kasan.c:303
 strlcpy include/linux/string.h:300 [inline]
 __ip_tunnel_create+0xca/0x6b0 net/ipv4/ip_tunnel.c:257
 ip_tunnel_create net/ipv4/ip_tunnel.c:352 [inline]
 ip_tunnel_ioctl+0x818/0xd40 net/ipv4/ip_tunnel.c:861
 ipip_tunnel_ioctl+0x1c5/0x420 net/ipv4/ipip.c:350
 dev_ifsioc+0x43e/0xb90 net/core/dev_ioctl.c:334
 dev_ioctl+0x69a/0xcc0 net/core/dev_ioctl.c:525
 sock_ioctl+0x47e/0x680 net/socket.c:1015
 vfs_ioctl fs/ioctl.c:46 [inline]
 file_ioctl fs/ioctl.c:500 [inline]
 do_vfs_ioctl+0x1cf/0x1650 fs/ioctl.c:684
 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
 SYSC_ioctl fs/ioctl.c:708 [inline]
 SyS_ioctl+0x24/0x30 fs/ioctl.c:706
 do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_tunnel.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -253,13 +253,14 @@ static struct net_device *__ip_tunnel_cr
 	struct net_device *dev;
 	char name[IFNAMSIZ];
 
-	if (parms->name[0])
+	err = -E2BIG;
+	if (parms->name[0]) {
+		if (!dev_valid_name(parms->name))
+			goto failed;
 		strlcpy(name, parms->name, IFNAMSIZ);
-	else {
-		if (strlen(ops->kind) > (IFNAMSIZ - 3)) {
-			err = -E2BIG;
+	} else {
+		if (strlen(ops->kind) > (IFNAMSIZ - 3))
 			goto failed;
-		}
 		strlcpy(name, ops->kind, IFNAMSIZ);
 		strncat(name, "%d", 2);
 	}
