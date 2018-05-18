Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3608381-1526631740-2-1894833550431586300
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526631739; b=jtfnN3YskjhA5x/hQcGGZ0LJ2/JFzxbzv08Sz5GjwTaS9dFz1C
    q1rnTeh2mHeTUjM5wQGLyEoPh4LYzs/x5F3caEJ1BID1pzZOPlLBoZ/R9nW7egvJ
    6a2eFv96OSVw4waK//qj8VPSGv/JC2hFsDOyG5FXK6m10e1JJ8tK6MDFz4hIem/t
    Kr4Ir/pCIYJ6ejWEQS8rOBSueh7YTM76UFvk0/xRYx/xqOUUb1myFgT3IA76ycX6
    Our46yDcYUzdsjwl1TAUPYWNbsL8GhfMpo0tmikNfKQ69xgdet8PblyWWIEgWwUq
    Gm1Gfr0jUyKJw2Gzf6qVAYB1junJsMBCY+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526631739; bh=z/AuGvDZ76880xP6yyQVcfGWA/Q/U6
    zK+uLmIKKV1sM=; b=B5rarMhLkBDnjOF7/04xqsjpkru1iI+mdjL/9ENOitZAGu
    RKti7UKjyUX1p6zP/KdzSj6ZFs2QWDew1ELebq+bkE85VmlSJriGRPviQpyHUG5f
    pvsqfGODXayMSaIKmM+heNXPP0oop9tkNUqB1vZZhwB77KFOpawiTmvZsDccTNJb
    JGIRQINYfaR82dAdn/uMxVXpPsIhVoDxZBi3WzaeJ5XnTuz6+zreJOuVvu4Mj7yI
    I1W80Pfb2Rzs+CEahd3rtxMyfjKyJyvje+pa1tK7XTECh2VIh0sqeGqy0Vu2DjgL
    5hzWkaZRqZ6g6P/KWjYx5msiNPLuBBaAqbSH/iUQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=TZlUfZBv x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=TZlUfZBv x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLTIWZ4RzoYPszoX+eNkuh9EjTONxJUeEjZZYgwm14A2V2sZnkiWdEVW1h9DYILzCXF9D3Cc58zUYvQmF+7pNt1fcLXIuHDmD9L1NvNi3+i4ZBJg9hzG
    AOUHTPGFQ1DQ+20CLVcFAGwX/ZUq9rAzDsQb83X/ugnMCsCG5O0OzQwTCtOo+nOed0F44DzUVDM2a1CJ8Ra3PdnMWVRwWkah9BedOOdqZtoS3widHwiGCRur
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=CbDCq_QkAAAA:8 a=ag1SF4gXAAAA:8 a=bu8f3Q09rVqL7knDnFgA:9 a=QEXdDO2ut3YA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753729AbeERIWQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 04:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753723AbeERIWN (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 04:22:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adi Nissim <adin@mellanox.com>,
        Ariel Almog <ariela@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.9 09/33] net/mlx5: E-Switch, Include VF RDMA stats in vport statistics
Date: Fri, 18 May 2018 10:15:48 +0200
Message-Id: <20180518081535.458779708@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
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

From: Adi Nissim <adin@mellanox.com>

[ Upstream commit 88d725bbb43cd63a40c8ef70dd373f1d38ead2e3 ]

The host side reporting of VF vport statistics didn't include the VF
RDMA traffic.

Fixes: 3b751a2a418a ("net/mlx5: E-Switch, Introduce get vf statistics")
Signed-off-by: Adi Nissim <adin@mellanox.com>
Reported-by: Ariel Almog <ariela@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1924,26 +1924,35 @@ int mlx5_eswitch_get_vport_stats(struct
 	memset(vf_stats, 0, sizeof(*vf_stats));
 	vf_stats->rx_packets =
 		MLX5_GET_CTR(out, received_eth_unicast.packets) +
+		MLX5_GET_CTR(out, received_ib_unicast.packets) +
 		MLX5_GET_CTR(out, received_eth_multicast.packets) +
+		MLX5_GET_CTR(out, received_ib_multicast.packets) +
 		MLX5_GET_CTR(out, received_eth_broadcast.packets);
 
 	vf_stats->rx_bytes =
 		MLX5_GET_CTR(out, received_eth_unicast.octets) +
+		MLX5_GET_CTR(out, received_ib_unicast.octets) +
 		MLX5_GET_CTR(out, received_eth_multicast.octets) +
+		MLX5_GET_CTR(out, received_ib_multicast.octets) +
 		MLX5_GET_CTR(out, received_eth_broadcast.octets);
 
 	vf_stats->tx_packets =
 		MLX5_GET_CTR(out, transmitted_eth_unicast.packets) +
+		MLX5_GET_CTR(out, transmitted_ib_unicast.packets) +
 		MLX5_GET_CTR(out, transmitted_eth_multicast.packets) +
+		MLX5_GET_CTR(out, transmitted_ib_multicast.packets) +
 		MLX5_GET_CTR(out, transmitted_eth_broadcast.packets);
 
 	vf_stats->tx_bytes =
 		MLX5_GET_CTR(out, transmitted_eth_unicast.octets) +
+		MLX5_GET_CTR(out, transmitted_ib_unicast.octets) +
 		MLX5_GET_CTR(out, transmitted_eth_multicast.octets) +
+		MLX5_GET_CTR(out, transmitted_ib_multicast.octets) +
 		MLX5_GET_CTR(out, transmitted_eth_broadcast.octets);
 
 	vf_stats->multicast =
-		MLX5_GET_CTR(out, received_eth_multicast.packets);
+		MLX5_GET_CTR(out, received_eth_multicast.packets) +
+		MLX5_GET_CTR(out, received_ib_multicast.packets);
 
 	vf_stats->broadcast =
 		MLX5_GET_CTR(out, received_eth_broadcast.packets);
