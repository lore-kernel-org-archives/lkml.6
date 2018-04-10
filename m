Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-843308-1523402308-2-6386493965766162892
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
    1523402308; b=jFlBAiMx+w4S8LCCSzy463w42NANj3bYwHUCMl124en2ZWlVzl
    S4E+HRfkZ1mgbqMJtmniQW4d9slqpAuJRbfNJqr5qhKGosSnYP+3lnGsvs2JQCP6
    K3ipinN5QYIJCulYvCmhCRw7trMOncMdo4AralO+MPzBwfprDW4tuoK31d7hMr2j
    TITTtjqHOdZY656vM4pozz0UuCqSshHx420sMXjPoahtnVG6oCg9HgsjAewepIO8
    uVGyTGSv79/GBMpVDek2GDXl35bG1haS3xIBJ9/RW9uNnSbqBWNhfyN5VS4zv0aV
    CKCq00uCLgzGUaQ9r5828lFtHQ1yDJRU9pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523402308; bh=JoMtZzRMKZM40j9uJpOKg8wko34jWT
    PQOgqe0vTdcZs=; b=ElGH10ZcaeLvUZM8K7ViMV7lV5et6ReyyTJ7pZ4DVBI/1U
    q+BIs3GFmZ2g3BcnGKb7yohvKFyX7970n91dgCHPJHeJZunBUr4bL9zjr2d7WqSY
    EyBwYWtnBC74hc2aDL/EmEDg39FsvhQkbCe86yvH3w0RUFkupIqlvCcgCIP0jHe7
    NWvmpAxBxOCFm0Q8zRezhxAsQx3s6hoR7U9z7TlWkBUrLMZr7me5IOZeXuILJZ6F
    /YnLXDKUZttT7iPx/zWU5VbUxkZTkCub9+Ee4dH+lLzkbYiE273En1iiPV4ppR6h
    cPcbBVgQm9TX/i0gTP2W4BmEC7KZJW1OaLmOYWzw==
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
X-CM-Envelope: MS4wfKpy0tKksKwkBf9wcZZ4MbLoEFYdAm2Ck+/vwwCW7Kr3YKX2np/U13XuvUwRHi0aE9eNSEP1v24LjizYZYg/iYrxPJbQ3kaQFwR8PsCsVYjdf4mCnTNW
    gZG8cR4GgS36QGqvpuMfvZVJLcfXGUjEDQSa9/cN1njUUXA+vGwBtLCcl+x4QEg7w3yuvKD9cua1GPk1RA85Urly0XlVFeIOhehkzZrFy+Asy9EigfxA1Xca
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=P8mRVJMrAAAA:8 a=4RBUngkUAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=X1aZe-7iDjBEnuuV1dwA:9 a=KtUIG-lCcybAZkOZ:21
    a=QEXdDO2ut3YA:10 a=Vc1QvrjMcIoGonisw6Ob:22 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeDJWb2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:31:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbeDJWb0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:31:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        "Reported-by: syzbot" <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 125/168] net: fix possible out-of-bound read in skb_network_protocol()
Date: Wed, 11 Apr 2018 00:24:27 +0200
Message-Id: <20180410212805.897549657@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 1dfe82ebd7d8fd43dba9948fdfb31f145014baa0 ]

skb mac header is not necessarily set at the time skb_network_protocol()
is called. Use skb->data instead.

BUG: KASAN: slab-out-of-bounds in skb_network_protocol+0x46b/0x4b0 net/core/dev.c:2739
Read of size 2 at addr ffff8801b3097a0b by task syz-executor5/14242

CPU: 1 PID: 14242 Comm: syz-executor5 Not tainted 4.16.0-rc6+ #280
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x194/0x24d lib/dump_stack.c:53
 print_address_description+0x73/0x250 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x23c/0x360 mm/kasan/report.c:412
 __asan_report_load_n_noabort+0xf/0x20 mm/kasan/report.c:443
 skb_network_protocol+0x46b/0x4b0 net/core/dev.c:2739
 harmonize_features net/core/dev.c:2924 [inline]
 netif_skb_features+0x509/0x9b0 net/core/dev.c:3011
 validate_xmit_skb+0x81/0xb00 net/core/dev.c:3084
 validate_xmit_skb_list+0xbf/0x120 net/core/dev.c:3142
 packet_direct_xmit+0x117/0x790 net/packet/af_packet.c:256
 packet_snd net/packet/af_packet.c:2944 [inline]
 packet_sendmsg+0x3aed/0x60b0 net/packet/af_packet.c:2969
 sock_sendmsg_nosec net/socket.c:629 [inline]
 sock_sendmsg+0xca/0x110 net/socket.c:639
 ___sys_sendmsg+0x767/0x8b0 net/socket.c:2047
 __sys_sendmsg+0xe5/0x210 net/socket.c:2081

Fixes: 19acc327258a ("gso: Handle Trans-Ether-Bridging protocol in skb_network_protocol()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Pravin B Shelar <pshelar@ovn.org>
Reported-by: Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2719,7 +2719,7 @@ __be16 skb_network_protocol(struct sk_bu
 		if (unlikely(!pskb_may_pull(skb, sizeof(struct ethhdr))))
 			return 0;
 
-		eth = (struct ethhdr *)skb_mac_header(skb);
+		eth = (struct ethhdr *)skb->data;
 		type = eth->h_proto;
 	}
 
