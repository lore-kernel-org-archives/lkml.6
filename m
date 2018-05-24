Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161146-2-10424985053134608271
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
    1527161146; b=h2yxFGfGzQFNBouTg2+acroQEx64UwU/0VCAIR3GC3XwqvZEoL
    7nciPSYA/Ijp9Er2G0Nr4zsurbQLr/OJx5jl55NdzJseh2+Dq8hRJkfZZrwjtoB+
    oVB9pLrWTGzdF4bcHsmqHrkqsXE3b3T5dg2NChd/VNyfqtABVmllWTleXsKmNm0j
    JEGdQPt5ABe/yT/gMvLgXZTZ8wEjKbDEVJNNsO8pJpekoYHhPp/o5fPBKum1gsPJ
    GADqEhhrbtUcP/WMptKv/TT2vUuRHqEgFQ9w1f42EjEuDIfG7iYgtrLc49RajCHp
    rGr7nGzb/Kl5x4Lx97FC48FuMKIPNBBktqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161146; bh=mHXxJ+sIKodz+nO70UmxvpBPy6BvlO
    F0efw9B8avJ2c=; b=MQU9rZV51zNjoXL1ET2soEh7ro89bcZcE1dtXhO0iF3eJk
    dxQRUBW0FnkjQkuZCV/MSPnP6NrMuVxA7nwqqal9ymJfTQvV87NniBGPwiUS+EPM
    Oi6chzNGwuo1Q2MIo/yYzAkMnlw/eWUe/OPZ+/EOFXs/Qt5gyVYjSFe/mpqnhD8C
    H4qpOm+yKvs8EWWmKa9DQbjol8irTTpLuQn3yWFYGrgxFhcjxKITNKUB3c3XUdqa
    s+GNYPHWwd440OWHWg4Tg2W9ibUwO7zvUAx1Gon9KLFheRLrYQCG46CFk3khnTdY
    Daf4aw1UI7eZqzo9hARzUWiwtpRD/C89I5HEUmwQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=RGvLYnMi x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=RGvLYnMi x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfDdvQthMYxj93cawn/3QW3+SUnVLfXarT/XeK7s75Hu7u5P/rjmDDwgBiOvOqEnc9tK30frxbEQac11Ox69KQIkNKmrHxr2WrsoxUkvNqVcGGHq6aBp1
    1MrNRzgF68EsM37sEAUExFziZRPPh9bPu5jD+yoD6splUw7A2ookcFhH6UFun6AkmPC1Y/nD0K/N08HDWdC8kW6JY/tIRuAGwHk1BQcTQXPrTgV8IMiSUtnx
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=yKzyzu08epFtSTDwoBIA:9
    a=hB-1L-uiLOUXesct:21 a=W6LEFqR1meXKOoSF:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967707AbeEXJvs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967760AbeEXJvo (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 013/165] hv_netvsc: Rename ind_table to rx_table
Date: Thu, 24 May 2018 11:36:59 +0200
Message-Id: <20180524093622.513439108@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Commit 47371300dfc269dd8d150e5b872bdbbda98ba809 upstream. ]

Rename this variable because it is the Receive indirection
table.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/hyperv_net.h   |    2 +-
 drivers/net/hyperv/netvsc_drv.c   |    4 ++--
 drivers/net/hyperv/rndis_filter.c |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -179,7 +179,7 @@ struct rndis_device {
 
 	u8 hw_mac_adr[ETH_ALEN];
 	u8 rss_key[NETVSC_HASH_KEYLEN];
-	u16 ind_table[ITAB_NUM];
+	u16 rx_table[ITAB_NUM];
 };
 
 
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1378,7 +1378,7 @@ static int netvsc_get_rxfh(struct net_de
 	rndis_dev = ndev->extension;
 	if (indir) {
 		for (i = 0; i < ITAB_NUM; i++)
-			indir[i] = rndis_dev->ind_table[i];
+			indir[i] = rndis_dev->rx_table[i];
 	}
 
 	if (key)
@@ -1408,7 +1408,7 @@ static int netvsc_set_rxfh(struct net_de
 				return -EINVAL;
 
 		for (i = 0; i < ITAB_NUM; i++)
-			rndis_dev->ind_table[i] = indir[i];
+			rndis_dev->rx_table[i] = indir[i];
 	}
 
 	if (!key) {
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -759,7 +759,7 @@ int rndis_filter_set_rss_param(struct rn
 	/* Set indirection table entries */
 	itab = (u32 *)(rssp + 1);
 	for (i = 0; i < ITAB_NUM; i++)
-		itab[i] = rdev->ind_table[i];
+		itab[i] = rdev->rx_table[i];
 
 	/* Set hask key values */
 	keyp = (u8 *)((unsigned long)rssp + rssp->kashkey_offset);
@@ -1284,8 +1284,8 @@ struct netvsc_device *rndis_filter_devic
 	net_device->num_chn = min(net_device->max_chn, device_info->num_chn);
 
 	for (i = 0; i < ITAB_NUM; i++)
-		rndis_device->ind_table[i] = ethtool_rxfh_indir_default(i,
-							net_device->num_chn);
+		rndis_device->rx_table[i] = ethtool_rxfh_indir_default(
+						i, net_device->num_chn);
 
 	atomic_set(&net_device->open_chn, 1);
 	vmbus_set_sc_create_callback(dev->channel, netvsc_sc_open);
