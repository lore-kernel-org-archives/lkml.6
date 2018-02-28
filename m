Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519835085-2-151266471686666570
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835084; b=Tq9BfAIUvGhJluwSxGJt4Hc8QYy7sdOeBrgkAEOcFH7k+u+
    UdEYM1Dr1DXafI3+tPOW/n0jxEJoRO61+IOUhqu5n7KT6jZegcTneYEVPAVrHBw+
    n1JaZEDKNIhg4BJp1xBAoVAbKuYWc7qjeMCcLJr44Y4CeJRzySYz8RAMKl9GSqPW
    je9huO5eP94sPgcW5sPiAHkzRnMLrA7DF30JhECTaclJURt6XdrldqNICwK4bV2C
    /q0lf3X0kE3C30hluppUVgYGgxRQ9xZIblhu7I5WdTQ71DgOvDpTMbsW+xEZXsAB
    knAn5VUYsnfTXFc8S2wtDD6Lpy4c++3Eg8Np45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835084; bh=7tQzegcagdvY5jy0fgx
    1Gy+iiaVtos/iuBfRPqGs/zY=; b=gTwKhf5v9wdgaa/PR8JgQBo45Gb7NuvuMNk
    Wch5gT9FeFDgnKwpiRvWSy7lC/5kw90wz2N4ActQprjsxJqu/c/1821FGfgcUNgO
    njafRWVGCVe0Gea1eNIV2D4nbbSeO3q5rEblx0M+W4hFcoD1qgq+uhAhKmYSygWS
    3m82iiRoTaNwYN96yBKU4YFsLup4/dtHvgQd00yGsbKiC5XTbEANFIz6EfdzYr80
    NNhMtsuPWvygXx9aCXEP1AlQEzeH4u6sf9LYVnvnNxqo0S+oDTqKu0Tgd5wKVmxQ
    S5igR4n8y6qc9dITIpz2bveYPjouJzI0+LBeZ6OlmAXD9S/QH3Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeB1QY0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:24:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35369 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935171AbeB1QUh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:37 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.612805808@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 178/254] sh_eth: fix SH7757 GEther initialization
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit 5133550296d43236439494aa955bfb765a89f615 upstream.

Renesas  SH7757 has 2 Fast and 2 Gigabit Ether controllers, while the
'sh_eth' driver can only reset and initialize TSU of the first controller
pair. Shimoda-san tried to solve that adding the 'needs_init' member to the
'struct sh_eth_plat_data', however the platform code still never sets this
flag. I think  that we can infer this information from the 'devno' variable
(set  to 'platform_device::id') and reset/init the Ether controller pair
only for an even 'devno'; therefore 'sh_eth_plat_data::needs_init' can be
removed...

Fixes: 150647fb2c31 ("net: sh_eth: change the condition of initialization")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/renesas/sh_eth.c | 4 ++--
 include/linux/sh_eth.h                | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2902,8 +2902,8 @@ static int sh_eth_drv_probe(struct platf
 		ndev->features = NETIF_F_HW_VLAN_CTAG_FILTER;
 	}
 
-	/* initialize first or needed device */
-	if (!devno || pd->needs_init) {
+	/* Need to init only the first port of the two sharing a TSU */
+	if (devno % 2 == 0) {
 		if (mdp->cd->chip_reset)
 			mdp->cd->chip_reset(ndev);
 
--- a/include/linux/sh_eth.h
+++ b/include/linux/sh_eth.h
@@ -16,7 +16,6 @@ struct sh_eth_plat_data {
 	unsigned char mac_addr[ETH_ALEN];
 	unsigned no_ether_link:1;
 	unsigned ether_link_active_low:1;
-	unsigned needs_init:1;
 };
 
 #endif
