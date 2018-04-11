Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523473925-2-4828009091046939834
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
    1523473924; b=OuR4s/wnZT0/3W5hOoheplx07UicVUR38pldeUXV4emryiERyk
    NibypF6fnQn+b04DG2jz5BEePuozWrdqhHnvMfdg0UCInebwKd148QiTdUOvG5AG
    V7qNA0yCDrf3Ab9gtgcXBkQ+3h7g4afOGSl5si0taO3vpApdqM+h+I9RkTWgG/EV
    qtAxCwQdPXy4ieNbfBGhLa3VWBaDMYOPPz7n2zOE7Bz9shQfM85VLSTtmpVS4e4M
    CAi7RMXKHbZzPqcASfiHOZYoal0E4DZYEUKiT/FpqXPjLP45FOdbW3IRxDSwKP36
    rG54DccHpLlKCgjfbv3aKxa1/RECrDLVJrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473924; bh=IiQsIX59LdpwsET2PYu0g8rFS79wNc
    T9Lg6b32xXSJA=; b=SvbkbZLz7ywi5P1HLTjVbRRmYHxGxcuAW4Jkoxe9k/bkZ+
    ciEZTYt5gNfj23ka68Aa55GWIPlGaL8rpSHbSiWFtrSkAY5Hvxlp+D6jgoupArqn
    kuZM6lAbfjBvcxAxMdIr/R2K7PeQNN0pUshy2Vny6Z3bLIpCUEtYeQ3wDZ1++0OH
    QL3Sdy7Cj0oZBZQhOpXvZR0a6hM1RgyDgJbeBd011VXzly3MNbzoL1BtDaXxmjVh
    yPD5Qixer6+oMawJktG5sLqYQfiQN8HvWX02Mj3yxxnMhdIs+O7x8HlEPk+kle42
    BX2cSmrENZyWsPP+4zyy2TLFtBxSyJsG6Ms+xp3w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCNy0xqN6HFFTKyOSlwkwQd6oQ4hfWBJo1xDG44z29/H6S59VoGGWeZkkXGfxvUV37anvcDOEXr0AEtyDE9qGdg9blpwadQOWnqjERRdnArJhR2ctHgd
    FTtaKn/YhybJdmXeVumhZ4PUbqwjfZGtIf5deaKCaM0+30fiN8oBEMeh3Q/sY1PPEpCRTOkb+Mqn1FixraSsbPbEFel8dH14m0DH/C9mjE3RgVnguh4pDpQK
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=ag1SF4gXAAAA:8 a=d9u0pwqUsCscJSrev_gA:9 a=QEXdDO2ut3YA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935181AbeDKTGS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:06:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40746 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934041AbeDKTGR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shahar Klein <shahark@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.9 299/310] net/mlx5e: Sync netdev vxlan ports at open
Date: Wed, 11 Apr 2018 20:37:18 +0200
Message-Id: <20180411183635.430069733@linuxfoundation.org>
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
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2741,6 +2741,9 @@ static int set_feature_lro(struct net_de
 
 	mutex_unlock(&priv->state_lock);
 
+	if (mlx5e_vxlan_allowed(priv->mdev))
+		udp_tunnel_get_rx_info(netdev);
+
 	return err;
 }
 
@@ -3785,13 +3788,6 @@ static void mlx5e_nic_enable(struct mlx5
 	if (netdev->reg_state != NETREG_REGISTERED)
 		return;
 
-	/* Device already registered: sync netdev system state */
-	if (mlx5e_vxlan_allowed(mdev)) {
-		rtnl_lock();
-		udp_tunnel_get_rx_info(netdev);
-		rtnl_unlock();
-	}
-
 	queue_work(priv->wq, &priv->set_rx_mode_work);
 }
 
