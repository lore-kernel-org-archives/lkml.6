Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A402FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610BE21468
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610BE21468
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934218AbeGFFvR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:51:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934160AbeGFFvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:09 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9D2D86A;
        Fri,  6 Jul 2018 05:51:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 32/61] netfilter: nf_tables: add missing netlink attrs to policies
Date:   Fri,  6 Jul 2018 07:46:56 +0200
Message-Id: <20180706054713.562781496@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 467697d289e7e6e1b15910d99096c0da08c56d5b upstream.

Fixes: 8aeff920dcc9 ("netfilter: nf_tables: add stateful object reference to set elements")
Fixes: f25ad2e907f1 ("netfilter: nf_tables: prepare for expressions associated to set elements")
Fixes: 1a94e38d254b ("netfilter: nf_tables: add NFTA_RULE_ID attribute")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_tables_api.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1978,6 +1978,7 @@ static const struct nla_policy nft_rule_
 	[NFTA_RULE_POSITION]	= { .type = NLA_U64 },
 	[NFTA_RULE_USERDATA]	= { .type = NLA_BINARY,
 				    .len = NFT_USERDATA_MAXLEN },
+	[NFTA_RULE_ID]		= { .type = NLA_U32 },
 };
 
 static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
@@ -3412,6 +3413,8 @@ static const struct nla_policy nft_set_e
 	[NFTA_SET_ELEM_TIMEOUT]		= { .type = NLA_U64 },
 	[NFTA_SET_ELEM_USERDATA]	= { .type = NLA_BINARY,
 					    .len = NFT_USERDATA_MAXLEN },
+	[NFTA_SET_ELEM_EXPR]		= { .type = NLA_NESTED },
+	[NFTA_SET_ELEM_OBJREF]		= { .type = NLA_STRING },
 };
 
 static const struct nla_policy nft_set_elem_list_policy[NFTA_SET_ELEM_LIST_MAX + 1] = {


