Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523399613-2-10693940506547152459
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523399613; b=wvrwlR9fcgUsNfbBTmqd1Kyfzl4mN/rAIzNjNfsqlB+OhjIGXf
    qGdNnFeVtXgAx3V1xwqMRl7l8kSa3X8VghzeGZP8jfbfmU1z/Ss3CwkZzPB54gU3
    lW14/JLCeX4AcEasUqvUDvghIuf/IsMzCdjYSCAzi1/HVDZlwQEdhX16ry4qfQRQ
    BgsnIZ3O3rrdw2sRQ0Py3aIZcBft3v+BxP3TWOw4zrBl7ENu6/Hgu+/EH852osXy
    3zlvYwkLMB0En00Vi5z0kJsDoV3L3YR+QxVpMvLlC0Hkh2fOWZNnAjiM7IaasKka
    6p1sShhrzor58h1R3Flb2dRSiS2twrKGO+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399613; bh=OLUv5fplAMgNApMG86vPsryD2qQgak
    gK8+nzK3vaBbY=; b=F8iCiWGARrM4xgvBgwdR+QMo3CWquyaXRr+uN5OiEgJKHA
    qjgaUEIVthDXzpl1YQ2kKCRSEaO12xN/lls45UEkHC+2GHWrI4Ok05ReUTa94r04
    MjsuZFtEsM2rW0HcO45HxKYRAUNs+9FRKAUL89z7SHO16rUJtNsr14G0g4B3DSwX
    ZAJcwC+W43BRR+Cl1vgx8gU7hw1X9G0xo75tuR55mYTrdE3ZXGdlGY66HmY5oZdS
    BdTcexCkHdHqUQ2Kuune8oHRm+2HFO2NJoV0G3WUFmMnzFK7OdXvIwKgR6tkoUKZ
    NLnfG8n/Qp5+UJG47qVbr+FtwUCg6TyCM2OVStKg==
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
X-CM-Envelope: MS4wfHwSANXGEJKfurIZ9mr3fC2asdb/qfh9+xmkTMd9hpmw9NaeSeJl3Y9vrQZBoC7gXtOr+jGhRO9u6XdSPOEzPBhptJXZ3QShRr4Di/UTXnkhRilOecMd
    pbK04IL6euGHKnAQ6YFhkyBnBO60rbDf67Ki11CIG7bmKETyvoEDYfhZK1G/flXbKx7I1kpluhbathFT+dlLovOG3Swf4fXOpyOuEVAhEwJO1wOOKEYSYSQG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=ag1SF4gXAAAA:8 a=d9u0pwqUsCscJSrev_gA:9 a=QEXdDO2ut3YA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755240AbeDJWdb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:33:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41364 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755237AbeDJWda (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:33:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shahar Klein <shahark@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.15 158/168] net/mlx5e: Sync netdev vxlan ports at open
Date: Wed, 11 Apr 2018 00:25:00 +0200
Message-Id: <20180410212807.827239817@linuxfoundation.org>
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

From: Shahar Klein <shahark@mellanox.com>


[ Upstream commit a117f73dc2430443f23e18367fa545981129c1a6 ]

When mlx5_core is loaded it is expected to sync ports
with all vxlan devices so it can support vxlan encap/decap.
This is done via udp_tunnel_get_rx_info(). Currently this
call is set in mlx5e_nic_enable() and if the netdev is not in
NETREG_REGISTERED state it will not be called.

Normally on load the netdev state is not NETREG_REGISTERED
so udp_tunnel_get_rx_info() will not be called.

Moving udp_tunnel_get_rx_info() to mlx5e_open() so
it will be called on netdev UP event and allow encap/decap.

Fixes: 610e89e05c3f ("net/mlx5e: Don't sync netdev state when not registered")
Signed-off-by: Shahar Klein <shahark@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2715,6 +2715,9 @@ int mlx5e_open(struct net_device *netdev
 		mlx5_set_port_admin_status(priv->mdev, MLX5_PORT_UP);
 	mutex_unlock(&priv->state_lock);
 
+	if (mlx5e_vxlan_allowed(priv->mdev))
+		udp_tunnel_get_rx_info(netdev);
+
 	return err;
 }
 
@@ -4428,12 +4431,6 @@ static void mlx5e_nic_enable(struct mlx5
 #ifdef CONFIG_MLX5_CORE_EN_DCB
 	mlx5e_dcbnl_init_app(priv);
 #endif
-	/* Device already registered: sync netdev system state */
-	if (mlx5e_vxlan_allowed(mdev)) {
-		rtnl_lock();
-		udp_tunnel_get_rx_info(netdev);
-		rtnl_unlock();
-	}
 
 	queue_work(priv->wq, &priv->set_rx_mode_work);
 
