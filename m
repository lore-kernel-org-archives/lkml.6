Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A96AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE7D207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="ncnB2kpJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6oxmmyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE7D207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbeJXGRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:17:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60303 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbeJXGRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:17:42 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C27621C89;
        Tue, 23 Oct 2018 17:52:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 23 Oct 2018 17:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=b2ahh3Iw8m8+J5Uwp/fHl35av8AEDr7dkvKTygYNgrE=; b=ncnB2
        kpJTCgFGgSdcl6Tu2E8KkKGx7wSJrQfT+Hm+/GfdokMMxYj7Q+9nXy7LuT3fsBpl
        mM6QCo9xdUDXRudC75ThlJ+PvSjez72HyJsHcpy4wlfKnyaKYoYzQXVeleDNuTEa
        Nv0wNeiCNa4eihyl+YWMVJBkeycFn5c/rtNHjX1xcbWy834zI2VW+VU2YMuSSgLJ
        /Qu3gNeS0/55iHddjTKDGJ42yd4ZbYfBDN2uH8N/NrLQhYVaKRNQ2Jap5ApZeShI
        8Tew8Eb+nahiYTJV2Wyv2X2+P9N2zfLaR487mKW78heqos69a2R7a9aonsLT55xj
        zriX/MxUihs1D2P3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=b2ahh3Iw8m8+J5Uwp/fHl35av8AEDr7dkvKTygYNgrE=; b=n6oxmmyi
        wJUMYTgm/GLySwLT3w7gQI4pumi2gJ39IhDP53ZyR0hIySz5bEu/OFvu2HRQRA8q
        /C9MatOT3jSKUBnELCQKlZM2fwD0IsIP44/ZfPM35ARGnfSPjtoNAeWN8HBqtW0i
        0xF2mwS8k96AWDly/2Z6a/OxreKJyMwiR+uiX5yHaXZ00a5SGo7Xp2ObP1enXVRN
        VOuAdHHb8gm3xIELRnY/jde3Ihb9fypYvOYX4XjNBatJewbvNngdJDe7KecJ8Nfc
        Rq5jOokNMd2PheqPISnb4KED69AM+Vja3/uw3sNL111IldZ7gpDziV/+we3eexuk
        Cp+W9PJlIS3LwA==
X-ME-Sender: <xms:GpjPW_yHWsH3ob5Eta2_EsrZqOfSxLQXVfFDXcD6Num1AF-LUBADSw>
X-ME-Proxy: <xmx:GpjPW6FBRr1QpXOVCdakJLwsuT8loaYyM_QPvkxbvoFv-DSEsURfnw>
    <xmx:GpjPW7iNlQjFQ83K3dsqujtqHoPuYYN2CfvZLPgCEPXdh1RsDwy36Q>
    <xmx:GpjPW1_wemI3wr-gn7fQMqXN25q3m-0quAuQlfOIQ23Hik3x3ZxR_g>
    <xmx:GpjPWyowqEV5NMPJtKWz98UjYJZirHt-CXXlzCFRQkANRmfFmUZ4tw>
    <xmx:GpjPW08pMjTIWRqowdewKtsGTya8NBogKDiIRQJO5WaR3j8_2pLnAA>
    <xmx:G5jPW6fGkNaHgPbW2js7dynXwwNLsFZPI9Dkmu4ukJOtWsnOwBxWYQ>
Received: from v4.ibm.com (unknown [158.140.225.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 63BF4102F9;
        Tue, 23 Oct 2018 17:52:24 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next v2 1/6] net/ncsi: Don't enable all channels when HWA available
Date:   Wed, 24 Oct 2018 10:51:56 +1300
Message-Id: <20181023215201.27315-2-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023215201.27315-1-sam@mendozajonas.com>
References: <20181023215201.27315-1-sam@mendozajonas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NCSI hardware arbitration allows multiple packages to be enabled at once
and share the same wiring. If the NCSI driver recognises that HWA is
available it unconditionally enables all packages and channels; but that
is a configuration decision rather than something required by HWA.
Additionally the current implementation will not failover on link events
which can cause connectivity to be lost unless the interface is manually
bounced.

Retain basic HWA support but remove the separate configuration path to
enable all channels, leaving this to be handled by a later
implementation.

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
---
 net/ncsi/ncsi-aen.c    |  3 +--
 net/ncsi/ncsi-manage.c | 45 +++---------------------------------------
 2 files changed, 4 insertions(+), 44 deletions(-)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 25e483e8278b..65f47a648be3 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -86,8 +86,7 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	    !(state == NCSI_CHANNEL_ACTIVE && !(data & 0x1)))
 		return 0;
 
-	if (!(ndp->flags & NCSI_DEV_HWA) &&
-	    state == NCSI_CHANNEL_ACTIVE)
+	if (state == NCSI_CHANNEL_ACTIVE)
 		ndp->flags |= NCSI_DEV_RESHUFFLE;
 
 	ncsi_stop_channel_monitor(nc);
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index bfc43b28c7a6..4da051f90974 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -113,10 +113,8 @@ static void ncsi_channel_monitor(struct timer_list *t)
 	default:
 		netdev_err(ndp->ndev.dev, "NCSI Channel %d timed out!\n",
 			   nc->id);
-		if (!(ndp->flags & NCSI_DEV_HWA)) {
-			ncsi_report_link(ndp, true);
-			ndp->flags |= NCSI_DEV_RESHUFFLE;
-		}
+		ncsi_report_link(ndp, true);
+		ndp->flags |= NCSI_DEV_RESHUFFLE;
 
 		ncsi_stop_channel_monitor(nc);
 
@@ -1050,35 +1048,6 @@ static bool ncsi_check_hwa(struct ncsi_dev_priv *ndp)
 	return false;
 }
 
-static int ncsi_enable_hwa(struct ncsi_dev_priv *ndp)
-{
-	struct ncsi_package *np;
-	struct ncsi_channel *nc;
-	unsigned long flags;
-
-	/* Move all available channels to processing queue */
-	spin_lock_irqsave(&ndp->lock, flags);
-	NCSI_FOR_EACH_PACKAGE(ndp, np) {
-		NCSI_FOR_EACH_CHANNEL(np, nc) {
-			WARN_ON_ONCE(nc->state != NCSI_CHANNEL_INACTIVE ||
-				     !list_empty(&nc->link));
-			ncsi_stop_channel_monitor(nc);
-			list_add_tail_rcu(&nc->link, &ndp->channel_queue);
-		}
-	}
-	spin_unlock_irqrestore(&ndp->lock, flags);
-
-	/* We can have no channels in extremely case */
-	if (list_empty(&ndp->channel_queue)) {
-		netdev_err(ndp->ndev.dev,
-			   "NCSI: No available channels for HWA\n");
-		ncsi_report_link(ndp, false);
-		return -ENOENT;
-	}
-
-	return ncsi_process_next_channel(ndp);
-}
-
 static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
 {
 	struct ncsi_dev *nd = &ndp->ndev;
@@ -1592,7 +1561,6 @@ EXPORT_SYMBOL_GPL(ncsi_register_dev);
 int ncsi_start_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
-	int ret;
 
 	if (nd->state != ncsi_dev_state_registered &&
 	    nd->state != ncsi_dev_state_functional)
@@ -1604,14 +1572,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
 		return 0;
 	}
 
-	if (ndp->flags & NCSI_DEV_HWA) {
-		netdev_info(ndp->ndev.dev, "NCSI: Enabling HWA mode\n");
-		ret = ncsi_enable_hwa(ndp);
-	} else {
-		ret = ncsi_choose_active_channel(ndp);
-	}
-
-	return ret;
+	return ncsi_choose_active_channel(nd);
 }
 EXPORT_SYMBOL_GPL(ncsi_start_dev);
 
-- 
2.19.1

