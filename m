Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477698-2-11556717630416793340
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477697; b=FKDBtk32cMJIoGhCnfroKQ4xnDHNb4ACrfJsr/8pvX3nCMrUaw
    W0J5ozfZjLh62dnzrWoxy2wnRUp5V4jPFIEp5ZdYURPQ8fUTCg5pTw/tztiHz/32
    O4nsTAH9QSLUJy4u9RDFbfwSKSjd/TfWX6YCYp0THyS8pVl92Vg/k2FN9zWJbxpL
    dr+b9u4jP68TpUXCRTcRlbDnXB8K5B1m0ijSsa04r+E+KO+DWvEr15Ojdk27ZqPL
    8t2iCJM3rX7MAX+UiWoXSMOQohZRPAB9yBhIk08xJWQxiK79NNcOFTAim/58Iu8U
    f5QXwsUpRk3kdWsknzOx/3qQ4aD3/0TiCrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477697; bh=gcfZVNDdUnI476SiP9wsp1sxrvzZz6
    epmw1My1nJAjM=; b=Tn64YgcXyiNBPcOkQK190p0zmJXNjrJn6n7gvI5OkNc97q
    ZPoqeb8WJqJZcf/nrNCzdoEeb/DgXvCOowNa0JBaoQQ8zsC0gYiM8ajDDNdnLWuU
    c8MVfbUY1mlqtwXDjbXnV5h8VJRWWqI2PeeuEHr0SZMPDaI5lenM4eH9qRIpc+6M
    jVu5bUuoognMANhhItkQEjSEgsvsQgtUkptfhl6c7cf0yO8W2Ynyz2IGdAEqh4xk
    7FBCJoC66THm/iO6wdtFzGI0CbRJw0oGJ2CNFgqzz3Et2ZLLzmUmRsjLJzZQ5LO9
    FB5q9Hm8tj8v0aVXPTY1O4HJxtrpt9bSHKsfwf3Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfHWYeeV3c5U4HBLs/jxwWnoahnqBoyOi+xiHkXiLEut2BaaSExqEPnNnJwiu1Ow+2phJ5kevRaQC0+xQae9ii9LGCBJzrs8KQEiANi6K4QcC1Ple7+EC
    0t+vQg5dymNJ5zCmk8mLmhrjx7kWxyoAABHza//zmBKoY6h6ptCdd7tLTEiItmSLd7SWkfiwue4PT7isAgV+3S3hWwzHEg0k3wleh2eLDWwt90kNg7OpWsuP
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=T0oSdNId3tmA6LNMnrQA:9 a=SCRI0SzRsUidcPNW:21 a=sv4KXNMTVxxuvHMY:21
    a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756230AbeDKUOg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:14:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933279AbeDKSxa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Talat Batheesh <talatb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 024/310] net/mlx4_en: Avoid adding steering rules with invalid ring
Date: Wed, 11 Apr 2018 20:32:43 +0200
Message-Id: <20180411183623.336232448@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Talat Batheesh <talatb@mellanox.com>


[ Upstream commit 89c557687a32c294e9d25670a96e9287c09f2d5f ]

Inserting steering rules with illegal ring is an invalid operation,
block it.

Fixes: 820672812f82 ('net/mlx4_en: Manage flow steering rules with ethtool')
Signed-off-by: Talat Batheesh <talatb@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1520,6 +1520,11 @@ static int mlx4_en_flow_replace(struct n
 		qpn = priv->drop_qp.qpn;
 	else if (cmd->fs.ring_cookie & EN_ETHTOOL_QP_ATTACH) {
 		qpn = cmd->fs.ring_cookie & (EN_ETHTOOL_QP_ATTACH - 1);
+		if (qpn < priv->rss_map.base_qpn ||
+		    qpn >= priv->rss_map.base_qpn + priv->rx_ring_num) {
+			en_warn(priv, "rxnfc: QP (0x%x) doesn't exist\n", qpn);
+			return -EINVAL;
+		}
 	} else {
 		if (cmd->fs.ring_cookie >= priv->rx_ring_num) {
 			en_warn(priv, "rxnfc: RX ring (%llu) doesn't exist\n",
