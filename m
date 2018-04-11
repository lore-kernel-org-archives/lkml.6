Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039319-1523472260-2-2907038394481719708
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523472259; b=CmiBBYzTP4nJ+tp3ubWlfEcIl2Bdqmv6aVBarpgiFREaCG5oB3
    o+BLN5HC8yYd0g70EYdrySLTyZNCrZTWysJGOo/fXBipP4eoITjpHQW7pr4JaDk3
    F2oRlvQGD5UYhZT7jULu39I/jpxPr5aiPpobEdFu/UGQeuI+kq0BGiaFlSw9FeVX
    B3GOBqFZXnczZXrvV+hH5Q3UKmWVFlwkhdmP6kLGKho0FTIjj5U1HUFeWKwnzKb8
    XZ/4n+o3HpiRTDI5j8lUh9bM2cpZ7VA5/6oi8GcCHkbNQCbMZanauGlwd8CdGO9T
    en77ogzKBgUPzdNLCGlA+fCvSmiCJKOvrnCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472259; bh=kQSNurYoBScAldvpu8R5oSqE0quEmb
    Z1RP27iqYpvEg=; b=WH8oEgDzqe0PLZleb09Ze/V2AvnJIoGL/3xxJ3v+GWuHU1
    wnGnRA59iqe7w3NyHMJnaidG7NzhFrgl1kRf+3NJZI+rvestmAyZTTEUiy3cZhuJ
    35J6DohYzgS6goXzU/DaXNhxJoh32zuXSznje00RUOxwo7ea1+umMtH3fx1YC2Qc
    aMOAV0Evj+l1x/9P7xgD0J3hspnQqyL1DXV7ci4ZvWCcskeMl+DoiAxYWyPDaCnH
    cGmxyu4KnKlMr7PXeGPG9ineYCJ6u9iFf0YurYY39+AjpW7cKktP2mh27WehHSg5
    kl23sMwl1Cwx0fy9c76leT5yde5sGCBSSajVV0qg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfJzOBMrzPfwTq1mVutBX9MQjHReT46hvSqjUuexGZWJFmhLTuU/pYaNTQwPtE+1STXS8rk8EItkd4Ys2jm4isbNo7jEZFq6wDEp+tDIWapvaw2nJnwjl
    CDnkoHNga8Y2D50zCjSR4j5IOgwriW70K8ieO60IaMjarcmwVIavJYMhZubAtE+qxo0RNMEpuYvwMhWucg4Qr2m4Vj5S7h92lEXi9NhArwct0v23V+gDBdou
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=T0oSdNId3tmA6LNMnrQA:9 a=A6vPX1yFCLAQ0Nu4:21 a=sv4KXNMTVxxuvHMY:21
    a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932172AbeDKSoK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:44:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932141AbeDKSoG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Talat Batheesh <talatb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 018/190] net/mlx4_en: Avoid adding steering rules with invalid ring
Date: Wed, 11 Apr 2018 20:34:24 +0200
Message-Id: <20180411183551.157632178@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1513,6 +1513,11 @@ static int mlx4_en_flow_replace(struct n
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
