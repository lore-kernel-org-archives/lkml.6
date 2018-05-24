Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158399-2-11729012519144500733
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527158399; b=eBb1dh5L3dK+OdY7HeofXKMgl1Vh4oqZKOVHqAWVHZ9o+CTwpY
    lbEwkvCL7ME9b/XBJgC/S0lWJGLp2RFl9Y+/wwC6rfPq+N5VtGbR+Gcf3AJ4vW0y
    e4zIrt285D1g1apFnbTjL0ReoLsJMJ/5q/LDGyiDYuKh2ihA4SpPeDibFjxKh3DT
    88xZFbMnT19A2RlFkPQzCccyWc8iBYqQU8Vtit+GAy34AkHm7PVEq2Xr60D+uPdu
    xlLTDuBSPecmFKZjO2SLBqnhUVM6FPHpg71udrr8YPsFT7JDOJfg/A56VWBuMo3L
    KAuHu7JlOGtb0ll4t+Mdj9kDW8n8T190sKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158399; bh=0SUc0skS64inpjZWHpJcUYfOXB8Zz3
    +LAl+RNIPsEE8=; b=Lv8w/mx3/QTkvBxknoFeTEyv8g8EN3zBmHLzQlFPnp95lA
    B2Jyj+dnxzn4rTIZT/SA5wRgQrC/UWfMoOS307NqbwDHeRgmf4Z13NZuaIV3WHCH
    6O3LH0wYL/wGD+ljajAXt3ohHUeMdYxD0J13jbx2N6tskKKog3QBCv4i2opNTuPW
    AeNBKooAvjsOmouIpoSX1BGHAApx3S2fQFvnBG62RuJazlIPIkyYMhlHzLtBTIw4
    0e/eCx697qpNP4+7NwZ0Gh/w0xXTgicPeN/cDNs3xrneZXkGc62kIo9eFp0pIsCn
    ZVN4RW/BxzujFBLbmn5GhbRcbti3upLfrWiNF8zQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=uIk4nZxy x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=uIk4nZxy x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAEuCk6kgG/2BHvZU8AOBgwV632jD9+d1BN3UjCXX0TFwoUT94AwsSxTB+m7mr8T8AR/rouXCIMyakjJwHxfS3bDrwcsCZw3+n1VbYgA149T2Gvq7Fag
    QLUm77LYXeC7umzEV5q37wrvVTAZW/TrLOqUZc2GJj3qRujoY00CGerBqS/rCt9C5ypyQPdBLfyWVLH1uoahhiBJfBzZMA/eKWo6p/P/zQixm2JLogtAFQXs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=ZVih2NwWPhLWbMse_D0A:9 a=TiveFTzRZJ9mzpMo:21
    a=fJZUOfTwKeHIMS-v:21 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030834AbeEXKjn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:39:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030728AbeEXJ7N (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:59:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e8b902c3c3fadf0a9dba@syzkaller.appspotmail.com,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 011/161] tun: fix use after free for ptr_ring
Date: Thu, 24 May 2018 11:37:16 +0200
Message-Id: <20180524093019.778543667@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit b196d88aba8ac72b775137854121097f4c4c6862 ]

We used to initialize ptr_ring during TUNSETIFF, this is because its
size depends on the tx_queue_len of netdevice. And we try to clean it
up when socket were detached from netdevice. A race were spotted when
trying to do uninit during a read which will lead a use after free for
pointer ring. Solving this by always initialize a zero size ptr_ring
in open() and do resizing during TUNSETIFF, and then we can safely do
cleanup during close(). With this, there's no need for the workaround
that was introduced by commit 4df0bfc79904 ("tun: fix a memory leak
for tfile->tx_array").

Reported-by: syzbot+e8b902c3c3fadf0a9dba@syzkaller.appspotmail.com
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Fixes: 1576d9860599 ("tun: switch to use skb array for tx")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -680,15 +680,6 @@ static void tun_queue_purge(struct tun_f
 	skb_queue_purge(&tfile->sk.sk_error_queue);
 }
 
-static void tun_cleanup_tx_ring(struct tun_file *tfile)
-{
-	if (tfile->tx_ring.queue) {
-		ptr_ring_cleanup(&tfile->tx_ring, tun_ptr_free);
-		xdp_rxq_info_unreg(&tfile->xdp_rxq);
-		memset(&tfile->tx_ring, 0, sizeof(tfile->tx_ring));
-	}
-}
-
 static void __tun_detach(struct tun_file *tfile, bool clean)
 {
 	struct tun_file *ntfile;
@@ -735,7 +726,8 @@ static void __tun_detach(struct tun_file
 			    tun->dev->reg_state == NETREG_REGISTERED)
 				unregister_netdevice(tun->dev);
 		}
-		tun_cleanup_tx_ring(tfile);
+		if (tun)
+			xdp_rxq_info_unreg(&tfile->xdp_rxq);
 		sock_put(&tfile->sk);
 	}
 }
@@ -775,14 +767,14 @@ static void tun_detach_all(struct net_de
 		tun_napi_del(tun, tfile);
 		/* Drop read queue */
 		tun_queue_purge(tfile);
+		xdp_rxq_info_unreg(&tfile->xdp_rxq);
 		sock_put(&tfile->sk);
-		tun_cleanup_tx_ring(tfile);
 	}
 	list_for_each_entry_safe(tfile, tmp, &tun->disabled, next) {
 		tun_enable_queue(tfile);
 		tun_queue_purge(tfile);
+		xdp_rxq_info_unreg(&tfile->xdp_rxq);
 		sock_put(&tfile->sk);
-		tun_cleanup_tx_ring(tfile);
 	}
 	BUG_ON(tun->numdisabled != 0);
 
@@ -826,7 +818,8 @@ static int tun_attach(struct tun_struct
 	}
 
 	if (!tfile->detached &&
-	    ptr_ring_init(&tfile->tx_ring, dev->tx_queue_len, GFP_KERNEL)) {
+	    ptr_ring_resize(&tfile->tx_ring, dev->tx_queue_len,
+			    GFP_KERNEL, tun_ptr_free)) {
 		err = -ENOMEM;
 		goto out;
 	}
@@ -3131,6 +3124,11 @@ static int tun_chr_open(struct inode *in
 					    &tun_proto, 0);
 	if (!tfile)
 		return -ENOMEM;
+	if (ptr_ring_init(&tfile->tx_ring, 0, GFP_KERNEL)) {
+		sk_free(&tfile->sk);
+		return -ENOMEM;
+	}
+
 	RCU_INIT_POINTER(tfile->tun, NULL);
 	tfile->flags = 0;
 	tfile->ifindex = 0;
@@ -3151,8 +3149,6 @@ static int tun_chr_open(struct inode *in
 
 	sock_set_flag(&tfile->sk, SOCK_ZEROCOPY);
 
-	memset(&tfile->tx_ring, 0, sizeof(tfile->tx_ring));
-
 	return 0;
 }
 
@@ -3161,6 +3157,7 @@ static int tun_chr_close(struct inode *i
 	struct tun_file *tfile = file->private_data;
 
 	tun_detach(tfile, true);
+	ptr_ring_cleanup(&tfile->tx_ring, tun_ptr_free);
 
 	return 0;
 }
