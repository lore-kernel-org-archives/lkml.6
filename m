Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713595-1523399858-2-10757591609412655884
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523399858; b=jda29uHlwJfMpz1RDkg7RQ40n6PDKlbmp/A71/uH/lS1UUDmTA
    BU5Zhc3BobCOc7XWf74nj0/r3RKzR1QgKHeIJWqDKmHMDKpGCFB4OfBdZPb8dgfT
    mP55k7Uql92LvX7Cd4k0SK+m6ALSe0Z0QLYLDO95rwAA/JWdVcyvmc/SsaSPhv16
    Mx0XI+HedLARQ88p8JLb/5AI1/l7sfcDF0lXD14pDDN1yyUvK3RXoRSwTMKojGjJ
    2i+88TDsHA2TgjTixCza3jyqygipagrXOiTMET4c4I7NjTNZTQNGpeXsuVT+VQBJ
    krXKAOsMJAO2Gpzi7A17XpbjElwMz8EKbUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399858; bh=+h6+OM1ds1pu1Wgqt6ZVEgEmLvvBIP
    PwS/cDDuubpIM=; b=SEHceeq2XUag+hksmKCsBnveuX7L0TlwD6OJr94n0Ml3D7
    TLsMCxMz2GZopjf2QnAKIZpm1bH0OUwFXrxO45we2nqjZ4iFKQ7A2YT3YLdywkuO
    kAXhEZSTh/G5qE3JJcQlQuj1LkmLdnKv5v790s0PVSGvrxqMK73qsWbGVmAlNdX/
    sGtIDQNRtXwpKnII4aT8LiNM7yInv7G4yBWsqPAKLdUNQDCJACCNPy19ygPs5ree
    LaQc9x3TKXrWbJP0BWYF/LSzK6Oj4IuLzLJZgswo3tTJ1YUJT7h+8Eb1MOCOPlzI
    GNV/XqF7oaaf52cnMS4noIp16tDTAd0J+yQLdEGw==
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
X-CM-Envelope: MS4wfDDPv5+luFK7N6eUdYsJJ0EZn8ARolqxYog85LRXqat5a1VbWxFQCPpN1wjGiFRK58rU5MH1iZpIX9Duf3zfi2zAQZkXdawK+kEt2OdroZGMACY+mdSl
    WxClaYUScIX/3UhDR2jVwzXSzr3nrXaqMWmqXD+SatDcLHN+Ska3itZa5PLG4AUHx89+ZdUiPPaj7diBnzAhnS2X91MA+WmpcmPbIZIYHcMGr5BVFhzoEV8K
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AGRr4plBAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=2LBmB76TW1u_f6CjTDoA:9 a=QEXdDO2ut3YA:10 a=bOnWt3ThIoLzEnqt84vq:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeDJWhb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:37:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43808 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeDJWha (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:37:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arjun Vynipadath <arjun@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 069/138] cxgb4vf: Fix SGE FL buffer initialization logic for 64K pages
Date: Wed, 11 Apr 2018 00:24:19 +0200
Message-Id: <20180410212910.115520311@linuxfoundation.org>
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

From: Arjun Vynipadath <arjun@chelsio.com>


[ Upstream commit ea0a42109aee7b92e631c4eb3f2219fadf58acdd ]

We'd come in with SGE_FL_BUFFER_SIZE[0] and [1] both equal to 64KB and
the extant logic would flag that as an error. This was already fixed in
cxgb4 driver with "92ddcc7 cxgb4: Fix some small bugs in
t4_sge_init_soft() when our Page Size is 64KB".

Original Work by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -2619,8 +2619,8 @@ void t4vf_sge_stop(struct adapter *adapt
 int t4vf_sge_init(struct adapter *adapter)
 {
 	struct sge_params *sge_params = &adapter->params.sge;
-	u32 fl0 = sge_params->sge_fl_buffer_size[0];
-	u32 fl1 = sge_params->sge_fl_buffer_size[1];
+	u32 fl_small_pg = sge_params->sge_fl_buffer_size[0];
+	u32 fl_large_pg = sge_params->sge_fl_buffer_size[1];
 	struct sge *s = &adapter->sge;
 
 	/*
@@ -2628,9 +2628,20 @@ int t4vf_sge_init(struct adapter *adapte
 	 * the Physical Function Driver.  Ideally we should be able to deal
 	 * with _any_ configuration.  Practice is different ...
 	 */
-	if (fl0 != PAGE_SIZE || (fl1 != 0 && fl1 <= fl0)) {
+
+	/* We only bother using the Large Page logic if the Large Page Buffer
+	 * is larger than our Page Size Buffer.
+	 */
+	if (fl_large_pg <= fl_small_pg)
+		fl_large_pg = 0;
+
+	/* The Page Size Buffer must be exactly equal to our Page Size and the
+	 * Large Page Size Buffer should be 0 (per above) or a power of 2.
+	 */
+	if (fl_small_pg != PAGE_SIZE ||
+	    (fl_large_pg & (fl_large_pg - 1)) != 0) {
 		dev_err(adapter->pdev_dev, "bad SGE FL buffer sizes [%d, %d]\n",
-			fl0, fl1);
+			fl_small_pg, fl_large_pg);
 		return -EINVAL;
 	}
 	if ((sge_params->sge_control & RXPKTCPLMODE_F) !=
@@ -2642,8 +2653,8 @@ int t4vf_sge_init(struct adapter *adapte
 	/*
 	 * Now translate the adapter parameters into our internal forms.
 	 */
-	if (fl1)
-		s->fl_pg_order = ilog2(fl1) - PAGE_SHIFT;
+	if (fl_large_pg)
+		s->fl_pg_order = ilog2(fl_large_pg) - PAGE_SHIFT;
 	s->stat_len = ((sge_params->sge_control & EGRSTATUSPAGESIZE_F)
 			? 128 : 64);
 	s->pktshift = PKTSHIFT_G(sge_params->sge_control);
