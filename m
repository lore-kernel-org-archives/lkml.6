Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804350-2-15492264934580222855
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804350; b=fGE79gZ1qDUWAU7BSU8BebR70N4B/kKgGvIyZifijkRDYG8
    VkUNr/1zaXq/9dadz7hMR9CeEsj58OXvIIkf5jMvM0zmI0nXOgjeS13c+Qd5rX9Y
    RWhngh1sbMfqPJ/i0cZlTOl/iqGlr6yY0C1UNgIplVfox04E7/K55O7v7A878oLD
    neAMXkQxRwaIFSa8uw0H2Tf1ZBKBAtSGg7jXBqx1wV70gJ0bDGKX2xwczeTuOxsW
    2RY62dUeu8P2sDZolH14IMh6SByWMahc8/H34YXUDCcZy/YhDXVxzUWvWk3nULV0
    VqwFgCggS+Ya/+vP2dm/BBGTXqB1Np5e6LRzn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804350; bh=hBnyq/ubrerktkoaJ5no4mFuXb
    2LzptGz68vf1FFggY=; b=FlCNrUl51M6BYszkrQWhyQLDtDOd6VBmda9F5APD7T
    Xv5Nq3Mrq/tCuU43jqP05j9DexeZ/vHBBUjY3DHdulQpNUL5ejhqbNXuImIVTLPX
    WDxsH7AHyPO/BBhXK+hlW3l8E5gRbJSaJpJ09haLXSBs+wz5S9EZ+f464S+f/1S9
    nK72QOkkFx+b5h9Zga7HJOK2XI7l3aWWHi62+RZz4OSGebq/fcT0oFdTbXxFaTeZ
    pc0/tx+V0MXVj8LtMw6RPUmb5SZKED6EB8P9LQaa8UPbmI02TSTczj+j1IPQCenM
    6qHPgBtOv3A2DnVVKoifG0T38efqU75XdkJZll1dpzKA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755298AbeCWKH0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:07:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41210 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755013AbeCWKHY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 060/177] netfilter: nf_ct_helper: permit cthelpers with different names via nfnetlink
Date: Fri, 23 Mar 2018 10:53:08 +0100
Message-Id: <20180323094207.990467581@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Liping Zhang <zlpnobody@gmail.com>


[ Upstream commit 66e5a6b18bd09d0431e97cd3c162e76c5c2aebba ]

cthelpers added via nfnetlink may have the same tuple, i.e. except for
the l3proto and l4proto, other fields are all zero. So even with the
different names, we will also fail to add them:
  # nfct helper add ssdp inet udp
  # nfct helper add tftp inet udp
  nfct v1.4.3: netlink error: File exists

So in order to avoid unpredictable behaviour, we should:
1. cthelpers can be selected by nft ct helper obj or xt_CT target, so
report error if duplicated { name, l3proto, l4proto } tuple exist.
2. cthelpers can be selected by nf_ct_tuple_src_mask_cmp when
nf_ct_auto_assign_helper is enabled, so also report error if duplicated
{ l3proto, l4proto, src-port } tuple exist.

Also note, if the cthelper is added from userspace, then the src-port will
always be zero, it's invalid for nf_ct_auto_assign_helper, so there's no
need to check the second point listed above.

Fixes: 893e093c786c ("netfilter: nf_ct_helper: bail out on duplicated helpers")
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_conntrack_helper.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -379,17 +379,33 @@ int nf_conntrack_helper_register(struct
 	struct nf_conntrack_tuple_mask mask = { .src.u.all = htons(0xFFFF) };
 	unsigned int h = helper_hash(&me->tuple);
 	struct nf_conntrack_helper *cur;
-	int ret = 0;
+	int ret = 0, i;
 
 	BUG_ON(me->expect_policy == NULL);
 	BUG_ON(me->expect_class_max >= NF_CT_MAX_EXPECT_CLASSES);
 	BUG_ON(strlen(me->name) > NF_CT_HELPER_NAME_LEN - 1);
 
 	mutex_lock(&nf_ct_helper_mutex);
-	hlist_for_each_entry(cur, &nf_ct_helper_hash[h], hnode) {
-		if (nf_ct_tuple_src_mask_cmp(&cur->tuple, &me->tuple, &mask)) {
-			ret = -EEXIST;
-			goto out;
+	for (i = 0; i < nf_ct_helper_hsize; i++) {
+		hlist_for_each_entry(cur, &nf_ct_helper_hash[i], hnode) {
+			if (!strcmp(cur->name, me->name) &&
+			    (cur->tuple.src.l3num == NFPROTO_UNSPEC ||
+			     cur->tuple.src.l3num == me->tuple.src.l3num) &&
+			    cur->tuple.dst.protonum == me->tuple.dst.protonum) {
+				ret = -EEXIST;
+				goto out;
+			}
+		}
+	}
+
+	/* avoid unpredictable behaviour for auto_assign_helper */
+	if (!(me->flags & NF_CT_HELPER_F_USERSPACE)) {
+		hlist_for_each_entry(cur, &nf_ct_helper_hash[h], hnode) {
+			if (nf_ct_tuple_src_mask_cmp(&cur->tuple, &me->tuple,
+						     &mask)) {
+				ret = -EEXIST;
+				goto out;
+			}
 		}
 	}
 	hlist_add_head_rcu(&me->hnode, &nf_ct_helper_hash[h]);
