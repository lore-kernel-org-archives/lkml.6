Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1757396-1527157616-2-12551960402800686003
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527157615; b=UzoelpXhO7IfucHuY61Xl2X4zMd/ipJrjbpc/NzVtoDe/g/Xis
    EUZ64TQlpzQN1oaDVj4iTGiKrlO1/Bhmwdw3qy2UHy2eh0YiyEZP9uRUtmhOosmh
    45efHbxfFR82/UuWHG/UnRdmKj9BVa319e+59vEQfh+WqKWFb7d/76clzfLzSIOw
    1YxAbfSZC0waZxKR5XRUnSCLtEv2bH+ll5jM3Q9Mm9/LGIzS5wgeaHjdaLcBAI/O
    ka1AkbSNc1X4LszsNy6Yb3oNsSJl9bF3cAzzmfhpDcI+DTD+e9uCcK47lWq2JB7I
    JhmFXhNK/xxHCF3lhc34813cNBsUo8mZnp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157615; bh=ZWqKNejgJb6VE/q6kJmBXihJjzbyuX
    y8yc8NhxHqJGE=; b=iVoUaAzuLW/vrjSlAEyHzDb+BdvyZT+IESs/ZIOWurIM0j
    SSBZ/1TEm9h/LfxK25ErKGZm3+U9dq64jpPmQC51FN00Sav7X0nsGEEskl/vgV8c
    S5CvKU2vcB5+gaYcWJHde/t0M2mTqX23Esb++vQ1TmcTllBEpnP8s+wUVG+P6R6H
    Z+Ch4bq5iIdfvruGwbapVqVY/14czAPPBkU9C992pq8jwtYgTEtLIvAPVl21JjhS
    kgU9tWBFzaIqQ1f8Gj2sOx/fcnuPS2HjaLtUBOH4Mmll6wxDqPdvlx9cj4FCdUXk
    WSJfsxHFQPcjLrDQk0l2GaAJpH+z1c8uEN3sIHgw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=v4nxg0kF x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=v4nxg0kF x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHpeDml5XH533EkV8z1E39wfs0agbuWpS1rIwPl1rk0EIB1RVibxLajYCs9vtVo0yNWxvHEybQtP+kPqcK5FbktIewjzUW8ZVruz08P6AzdcDcTrUNlE
    7hHB623HQslAFMESBcxIP/Kus9KWSwok8ueALwtNRG1C9+aYo6Dn2f9F8GnMlcp9hGR+Gqtx7xh9x/Nnip1QMnBVRYSIn8/jtZc0Jr3KbyncLbYxJuzW5JAv
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=zAyngx5bAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=muyRz08OCrGZHOrQXZEA:9
    a=QEXdDO2ut3YA:10 a=4LA4qAFo6bo561LpWNDU:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031013AbeEXK0x (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030993AbeEXKBp (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Elior <Ariel.Elior@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 030/161] qed: LL2 flush isles when connection is closed
Date: Thu, 24 May 2018 11:37:35 +0200
Message-Id: <20180524093021.949524719@linuxfoundation.org>
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

From: Michal Kalderon <Michal.Kalderon@cavium.com>

[ Upstream commit f9bcd60274a565751abef622f9018badd01a17c8 ]

Driver should free all pending isles once it gets a FLUSH cqe from FW.
Part of iSCSI out of order flow.

Fixes: 1d6cff4fca4366 ("qed: Add iSCSI out of order packet handling")
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -601,6 +601,27 @@ static u8 qed_ll2_convert_rx_parse_to_tx
 	return bd_flags;
 }
 
+static bool
+qed_ll2_lb_rxq_handler_slowpath(struct qed_hwfn *p_hwfn,
+				struct core_rx_slow_path_cqe *p_cqe)
+{
+	struct ooo_opaque *iscsi_ooo;
+	u32 cid;
+
+	if (p_cqe->ramrod_cmd_id != CORE_RAMROD_RX_QUEUE_FLUSH)
+		return false;
+
+	iscsi_ooo = (struct ooo_opaque *)&p_cqe->opaque_data;
+	if (iscsi_ooo->ooo_opcode != TCP_EVENT_DELETE_ISLES)
+		return false;
+
+	/* Need to make a flush */
+	cid = le32_to_cpu(iscsi_ooo->cid);
+	qed_ooo_release_connection_isles(p_hwfn, p_hwfn->p_ooo_info, cid);
+
+	return true;
+}
+
 static int qed_ll2_lb_rxq_handler(struct qed_hwfn *p_hwfn,
 				  struct qed_ll2_info *p_ll2_conn)
 {
@@ -627,6 +648,11 @@ static int qed_ll2_lb_rxq_handler(struct
 		cq_old_idx = qed_chain_get_cons_idx(&p_rx->rcq_chain);
 		cqe_type = cqe->rx_cqe_sp.type;
 
+		if (cqe_type == CORE_RX_CQE_TYPE_SLOW_PATH)
+			if (qed_ll2_lb_rxq_handler_slowpath(p_hwfn,
+							    &cqe->rx_cqe_sp))
+				continue;
+
 		if (cqe_type != CORE_RX_CQE_TYPE_REGULAR) {
 			DP_NOTICE(p_hwfn,
 				  "Got a non-regular LB LL2 completion [type 0x%02x]\n",
