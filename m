Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1758260-1527158369-2-16598793018779977863
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527158368; b=ifDUQ70Q4vCdO81QWUjiQ00Ei8+vURadvp1fIU/uGdBbl33UNd
    3KFnGEVeV3rvn40dLI1jxtczMerJaT0hfQL/LaIR28WFWU3LMt/B46i+lrxWX75u
    fb//zKZCKTJ8izpbPvpnTWdtH687HF+R/jdyd9mELro5yml+EzfUsI+cc6ka7cXq
    ABnEOg4jJnq5J2GpOX7KV/SlY22eGdr0+LK7I9w/GusSsygZdPY30VbDkz4VYTe1
    8Ssj1RL9unx5qxZpjMONZKvak0CIdTZOkGXkklj6ySaOMXNFHho+clNzT201lc1K
    ZR28w2cUCjpkujjLD/INUzu/imv0koK8NeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158368; bh=tACKGZiLBFbr/ZkDRKUQ0snsTvxVTj
    sjYuBBJqAolwE=; b=ZpM/OjLwdRsMhq5EFEXkyH0DdX2+l/GgFf5PPn9OXrhA4/
    2loyJM1se9bLf6aHH4scCWdhUaRQRwVoXeF6dhLYpOT7Qk1CZ8ntGpEEv7smuS3V
    8crbOAwg36JruWoARps98KT1VhObOSETNUgiDrFO5aX/JRrgHrVUT1rvukfv60mB
    DoT/d8iRO0mq+sG5WNq1+SnxIkQGKVuuZFknY4WYxAgcjCC4gkIs++F4bmOXt3Pw
    UFXMkG5qb00iDooAVZ7iSxdKE9UXQmur86857wunZI6DCYVa7blFAoeGnGLfQxla
    VO5ptrOEar8uVwvkqLeUXXa3VV755N4tdrIwJIfw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=IpwkT3Lb x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=IpwkT3Lb x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHhVMF6UCLl+I+85crWHNhQNTAofa/s7ysfSTjgW95ajWwE8CNdIQZ6oXqNvVEwTqqgrvZGjdHYS8SvA9d+iXBi1PzCdd2A0GwcVzleHBB+gufmWWPhV
    O5yfqHyLYqGoXwOiXl8cS/Yrd8TIa+QYJSXATnO7ysRS7lcGePtOliWNquL4uMhb9b9BAvt5AZQ2fX5xX0zCKlLa2I37ud/dYvCqBtiYo+RnolWEfPAXw+kd
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=AGRr4plBAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=DtmbCb3duNTZNefSDu4A:9
    a=QEXdDO2ut3YA:10 a=bOnWt3ThIoLzEnqt84vq:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032238AbeEXKjW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030419AbeEXJ7S (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:59:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kumar Sanghvi <kumaras@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 013/161] cxgb4: Correct ntuple mask validation for hash filters
Date: Thu, 24 May 2018 11:37:18 +0200
Message-Id: <20180524093019.992334089@linuxfoundation.org>
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

From: Kumar Sanghvi <kumaras@chelsio.com>

[ Upstream commit 849a742c59a3d597473c0232f9c2506c69eeef14 ]

Earlier code of doing bitwise AND with field width bits was wrong.
Instead, simplify code to calculate ntuple_mask based on supplied
fields and then compare with mask configured in hw - which is the
correct and simpler way to validate ntuple mask.

Fixes: 3eb8b62d5a26 ("cxgb4: add support to create hash-filters via tc-flower offload")
Signed-off-by: Kumar Sanghvi <kumaras@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c |   88 +++++++---------------
 1 file changed, 30 insertions(+), 58 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -836,7 +836,7 @@ bool is_filter_exact_match(struct adapte
 {
 	struct tp_params *tp = &adap->params.tp;
 	u64 hash_filter_mask = tp->hash_filter_mask;
-	u32 mask;
+	u64 ntuple_mask = 0;
 
 	if (!is_hashfilter(adap))
 		return false;
@@ -865,73 +865,45 @@ bool is_filter_exact_match(struct adapte
 	if (!fs->val.fport || fs->mask.fport != 0xffff)
 		return false;
 
-	if (tp->fcoe_shift >= 0) {
-		mask = (hash_filter_mask >> tp->fcoe_shift) & FT_FCOE_W;
-		if (mask && !fs->mask.fcoe)
-			return false;
-	}
+	/* calculate tuple mask and compare with mask configured in hw */
+	if (tp->fcoe_shift >= 0)
+		ntuple_mask |= (u64)fs->mask.fcoe << tp->fcoe_shift;
 
-	if (tp->port_shift >= 0) {
-		mask = (hash_filter_mask >> tp->port_shift) & FT_PORT_W;
-		if (mask && !fs->mask.iport)
-			return false;
-	}
+	if (tp->port_shift >= 0)
+		ntuple_mask |= (u64)fs->mask.iport << tp->port_shift;
 
 	if (tp->vnic_shift >= 0) {
-		mask = (hash_filter_mask >> tp->vnic_shift) & FT_VNIC_ID_W;
-
-		if ((adap->params.tp.ingress_config & VNIC_F)) {
-			if (mask && !fs->mask.pfvf_vld)
-				return false;
-		} else {
-			if (mask && !fs->mask.ovlan_vld)
-				return false;
-		}
+		if ((adap->params.tp.ingress_config & VNIC_F))
+			ntuple_mask |= (u64)fs->mask.pfvf_vld << tp->vnic_shift;
+		else
+			ntuple_mask |= (u64)fs->mask.ovlan_vld <<
+				tp->vnic_shift;
 	}
 
-	if (tp->vlan_shift >= 0) {
-		mask = (hash_filter_mask >> tp->vlan_shift) & FT_VLAN_W;
-		if (mask && !fs->mask.ivlan)
-			return false;
-	}
+	if (tp->vlan_shift >= 0)
+		ntuple_mask |= (u64)fs->mask.ivlan << tp->vlan_shift;
 
-	if (tp->tos_shift >= 0) {
-		mask = (hash_filter_mask >> tp->tos_shift) & FT_TOS_W;
-		if (mask && !fs->mask.tos)
-			return false;
-	}
+	if (tp->tos_shift >= 0)
+		ntuple_mask |= (u64)fs->mask.tos << tp->tos_shift;
 
-	if (tp->protocol_shift >= 0) {
-		mask = (hash_filter_mask >> tp->protocol_shift) & FT_PROTOCOL_W;
-		if (mask && !fs->mask.proto)
-			return false;
-	}
+	if (tp->protocol_shift >= 0)
+		ntuple_mask |= (u64)fs->mask.proto << tp->protocol_shift;
 
-	if (tp->ethertype_shift >= 0) {
-		mask = (hash_filter_mask >> tp->ethertype_shift) &
-			FT_ETHERTYPE_W;
-		if (mask && !fs->mask.ethtype)
-			return false;
-	}
+	if (tp->ethertype_shift >= 0)
+		ntuple_mask |= (u64)fs->mask.ethtype << tp->ethertype_shift;
 
-	if (tp->macmatch_shift >= 0) {
-		mask = (hash_filter_mask >> tp->macmatch_shift) & FT_MACMATCH_W;
-		if (mask && !fs->mask.macidx)
-			return false;
-	}
+	if (tp->macmatch_shift >= 0)
+		ntuple_mask |= (u64)fs->mask.macidx << tp->macmatch_shift;
+
+	if (tp->matchtype_shift >= 0)
+		ntuple_mask |= (u64)fs->mask.matchtype << tp->matchtype_shift;
+
+	if (tp->frag_shift >= 0)
+		ntuple_mask |= (u64)fs->mask.frag << tp->frag_shift;
+
+	if (ntuple_mask != hash_filter_mask)
+		return false;
 
-	if (tp->matchtype_shift >= 0) {
-		mask = (hash_filter_mask >> tp->matchtype_shift) &
-			FT_MPSHITTYPE_W;
-		if (mask && !fs->mask.matchtype)
-			return false;
-	}
-	if (tp->frag_shift >= 0) {
-		mask = (hash_filter_mask >> tp->frag_shift) &
-			FT_FRAGMENTATION_W;
-		if (mask && !fs->mask.frag)
-			return false;
-	}
 	return true;
 }
 
