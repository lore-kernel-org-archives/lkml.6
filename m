Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184271-2-11505904559900058666
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184270; b=gFmI6ngWRji910Jc0goay/qwaOnR0YHC4lGXl/3WH2ZL6sY
    xwgmYPtIJQq1aNmjqHm9iY5/ewiA3lzy4jHFWkxzoJ5kQpgLbnFHf4x/JRcjhf7T
    PobsMgxH4j9rUv2RuNC7VJ1npBv35pOMYt2mGeTH9jDF7S/sNGx5zNMlsV7zQlx5
    EfnrjAAU1IIKUXuMdZDa5UHf+fd1Js/mjBYu1F1hSdH/ArplAelavmpSAuHhWja3
    5wm7W/tCqM0+QYOhYYSsTZJD8IE2GWXFjHU7bQNTrbWrQ1RrOn3o7L6kbnpMVbin
    BV2AyiSMMz9x6q8r1ayXOGpC/37dMFEnaUuJawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184270; bh=QzUDawOl5d54bhZ4rh5GsIKEpi
    tz9BHtv4HaRgu8+mg=; b=JEWhr9/WONG556BvoAwTbAAqLJHomakJltpu1T91TG
    TjAq504mV7qVN1+rAAVyGPWXHEsRoMJOXuH+YBBzWJM2Zph09MWZSUwESWoe700H
    jxtd+ngnRqx5oPm4KMYT9A99Rx6D6xQi2+Du1qyWCxJMhmwc16vpR6dyXEfMmZyT
    CaP28JSH6MhO/U5SA3SGbKDxY2Y5RDytqes3IbS/t803SH/CEnzI8zNKceaW4S/N
    7ICSifPi+Hd1o353frS3T3V+TQNgdGuyBwCNkhg3GHPiyOKy0v/HmK9Ql5vAeI0O
    IoLKilgEiukR9TzGMPCuSZaysuQwcJSpIRJ2RGmhVBew==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753810AbeBINqZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:46:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753783AbeBINqY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:46:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 14/23] cls_u32: add missing RCU annotation.
Date: Fri,  9 Feb 2018 14:40:12 +0100
Message-Id: <20180209133939.067316754@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>


[ Upstream commit 058a6c033488494a6b1477b05fe8e1a16e344462 ]

In a couple of points of the control path, n->ht_down is currently
accessed without the required RCU annotation. The accesses are
safe, but sparse complaints. Since we already held the
rtnl lock, let use rtnl_dereference().

Fixes: a1b7c5fd7fe9 ("net: sched: add cls_u32 offload hooks for netdevs")
Fixes: de5df63228fc ("net: sched: cls_u32 changes to knode must appear atomic to readers")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_u32.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -544,6 +544,7 @@ static void u32_remove_hw_knode(struct t
 static int u32_replace_hw_knode(struct tcf_proto *tp, struct tc_u_knode *n,
 				u32 flags)
 {
+	struct tc_u_hnode *ht = rtnl_dereference(n->ht_down);
 	struct tcf_block *block = tp->chain->block;
 	struct tc_cls_u32_offload cls_u32 = {};
 	bool skip_sw = tc_skip_sw(flags);
@@ -563,7 +564,7 @@ static int u32_replace_hw_knode(struct t
 	cls_u32.knode.sel = &n->sel;
 	cls_u32.knode.exts = &n->exts;
 	if (n->ht_down)
-		cls_u32.knode.link_handle = n->ht_down->handle;
+		cls_u32.knode.link_handle = ht->handle;
 
 	err = tc_setup_cb_call(block, NULL, TC_SETUP_CLSU32, &cls_u32, skip_sw);
 	if (err < 0) {
@@ -840,8 +841,9 @@ static void u32_replace_knode(struct tcf
 static struct tc_u_knode *u32_init_knode(struct tcf_proto *tp,
 					 struct tc_u_knode *n)
 {
-	struct tc_u_knode *new;
+	struct tc_u_hnode *ht = rtnl_dereference(n->ht_down);
 	struct tc_u32_sel *s = &n->sel;
+	struct tc_u_knode *new;
 
 	new = kzalloc(sizeof(*n) + s->nkeys*sizeof(struct tc_u32_key),
 		      GFP_KERNEL);
@@ -859,11 +861,11 @@ static struct tc_u_knode *u32_init_knode
 	new->fshift = n->fshift;
 	new->res = n->res;
 	new->flags = n->flags;
-	RCU_INIT_POINTER(new->ht_down, n->ht_down);
+	RCU_INIT_POINTER(new->ht_down, ht);
 
 	/* bump reference count as long as we hold pointer to structure */
-	if (new->ht_down)
-		new->ht_down->refcnt++;
+	if (ht)
+		ht->refcnt++;
 
 #ifdef CONFIG_CLS_U32_PERF
 	/* Statistics may be incremented by readers during update
