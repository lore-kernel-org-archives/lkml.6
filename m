Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F3ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D3020866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="hEtjevJC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tgocxn7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D3020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJRL6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:58:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43805 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727316AbeJRL6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:58:48 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 91C762222E;
        Wed, 17 Oct 2018 23:59:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 Oct 2018 23:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=tphzm0J0NJUxcrq/neXvMAODX7YDfQM2nrQVe5xSB9g=; b=hEtje
        vJCylNP+/tx+4zac/tPVVwdSjPZcIOSd006rdcopX7d3qOAkoPfdN9KK7UOwXlce
        1mO3Nf+tRe4jYmZCyVMeG52WX9aJVhTlueR1ZYtdFMJXZkS17nxnBKsxdQMfnuJ0
        BLAtw06sCmeWs5BIX9wVX7ZNBy0gehGZJLKCTpHAWa6TnYpgQB1aoZj34BpF1uHk
        9Q//dJ3BXvUDA2J7WfdVJr6byj7RVVmFOTcQuawApzwE8oVIy6gc7C5KUEUxVFH+
        0yKzZWI3iCcHM0s/LjqVYsd/8tb4otSa22JWehh758mkSIt+5436Op+j3d/tDTie
        mIYeQnD8Hba/+HOiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=tphzm0J0NJUxcrq/neXvMAODX7YDfQM2nrQVe5xSB9g=; b=tgocxn7K
        k+koGdZENqcLUdWGvE0y6qMiCBigtPtKqc01mx9ReahcwuiXGzEHItWSnCVy3/pr
        Yq8MHf8s9Z1Wu5UlBndzpnZpj5yKffiEO4D+oDwCCkpdBl1XdzhCAi0EXCscNiXv
        5PG2DUYnAuO1uUoFY04eoEzjwWKe9L+XW2/F5nuhbQjY3k0mOxtmpFastvFa18oD
        3kvRHtADBbX0vPSqWDF2wzgzFjl0tDscVa3fziAPF9FNRjm9PdRdSEbW60+bka6v
        u+WBCVuTVvje0I+sAO4ek1SRlVPmVGycsi/g3CqN793eEUIVyLxEMziTg+oIXHqo
        wnLQfr6/j/wDug==
X-ME-Sender: <xms:OQXIW_ebz8ZUU5_ddvhyJ3_2wptJ04SHLflG00laPlEAJ1SFvCKcCw>
X-ME-Proxy: <xmx:OQXIW0y6mqgtMvhZyCukj5FZ8QnOFtCYw8Ch_Gc4Z0iAxHEvnZMFJA>
    <xmx:OQXIW4eQmqdxX-F7ED1ebfG0q2SFrNPCYCRVsXRRA6p-T4xZNo8eoQ>
    <xmx:OQXIW4Ic97DLLnyAo-6Wu4ksj0ALa5KvVP-np2zKW6VqPQmPb0J84A>
    <xmx:OQXIWxFtckoh8RLjm04vEB98d38dkDajSVHE6GHNoEnEFxVmliUMxg>
    <xmx:OQXIW6qh-WfBj1yXvvMSM_h71KhowyBolcx_CI68fLrvHcnhOeKk2Q>
    <xmx:OQXIW0aAFj4u1mrcOCVPiFvbwM7LT3pmg49NZnKhQkTOUvwo0peHGQ>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0D001102D7;
        Wed, 17 Oct 2018 23:59:50 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next 1/6] net/ncsi: Don't enable all channels when HWA available
Date:   Thu, 18 Oct 2018 14:59:12 +1100
Message-Id: <20181018035917.19413-2-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018035917.19413-1-sam@mendozajonas.com>
References: <20181018035917.19413-1-sam@mendozajonas.com>
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
index 6aa0614d2d28..65ee46c4d8f4 100644
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
 
@@ -968,35 +966,6 @@ static bool ncsi_check_hwa(struct ncsi_dev_priv *ndp)
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
@@ -1510,7 +1479,6 @@ EXPORT_SYMBOL_GPL(ncsi_register_dev);
 int ncsi_start_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
-	int ret;
 
 	if (nd->state != ncsi_dev_state_registered &&
 	    nd->state != ncsi_dev_state_functional)
@@ -1522,14 +1490,7 @@ int ncsi_start_dev(struct ncsi_dev *nd)
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

