Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96CEC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FABD20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FABD20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tamalin.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753853AbeFQFbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:31:16 -0400
Received: from mout.perfora.net ([74.208.4.194]:46603 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932176AbeFQFbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:31:12 -0400
Received: from kahja.local ([73.231.184.107]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MgdbV-1fpVvj0IKt-00O2GH;
 Sun, 17 Jun 2018 07:31:04 +0200
From:   Quytelda Kahja <quytelda@tamalin.org>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 09/11] staging: rtl8723bs: Merge conditionals with similar bodies.
Date:   Sat, 16 Jun 2018 22:30:38 -0700
Message-Id: <20180617053040.5903-9-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617053040.5903-1-quytelda@tamalin.org>
References: <20180617053040.5903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:oZsn9/0drw2QPz+H3MbsZGJD0eVI3TyuOUSwgXHRelusaDkUv/F
 4qNCm3qfqeqAKJAmEPSJRAmjvUCBPPHOEwMVr3F3/LWL8fNA+iKZofBJM6ukzGXGAyo9OsK
 oVQghcPeLxRHzQwaAMmWkUuji6fXIs1ca7T4KhUWzhnt0mvIN9foepF8VReCA1uHONAYGrV
 Ye0bWkL2NAb/XI7x54YEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o4v3UrDbjW4=:ABUcDWN01OgiMDmxQKSWnC
 CWd91m6I+UV6iKSl0lxccvSpQOsx35i/Ak3aXaOCo5L3QeLTPhKY96ZvcBUGetun/YXQru9aT
 7bvzjFxYyxWFFVn31j+HXrQOVsoq7Z8hUUvOJYkfqUm1f2YEvnaz6rDkXGwKKHxzPMrn1pcOy
 l+qYLj6vQA87HESvVk4QSDla2+etjCfi6jb9qMkGWWupvCZ9FkFSW2kwsaDTFuG0+XBS2SdDV
 5krgTLBceKx8TTCcWLxk59qRnqxmnl5tE0XSKTywy5xmM60abfR5RXQTMKLvUsS56RgaWcL2N
 GgslQNVHKB5qd6fdYrCO6uEkH3ZqLZVLrMNUWhoeGlW1bIRjbXYcBFvx3M5RV5WcDzDSpQSMd
 vdXmKO3Dp4oYhmvoxMy973DdXxbO4XBgz/a8qJLHRQVMkNga+N257VkQhsW7ICKOt8YeykItY
 /IgQ3unYWtBr8wSee3yVT3Fz4aLCAwn0iY0wtPH3SvFgsx/d/rjYHG/fyfO/lE9y+juf/CiRw
 u1h1RkO4T2etSqkU/p/dgKd0Hhx7xf8nEJ6hnJ4a33vVHJagkAe9Gut98iMsaLRk9hyYCM7gE
 n+IzR/ZSEdumASXnfLfKJ+LRaHnTXu47baa0uLMNFsPE8jtMsKnczXkmAObgcceMyi+P6cfWY
 Ly7Kg4MaZ3MqmfsypZF7VohPAtVWOLxuud8pDap4f/0az5rVVEaRMuBJfb2dMpZ+Urqc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two conditionals that set 'channel' based on 'band_type' in
'phy_get_tx_pwr_lmt()' can be simplified into one single-line conditional.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index dd097df86fa3..9e6dc238c028 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1738,12 +1738,8 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 		idx_bandwidth = 1;
 	}
 
-	if (band_type == BAND_ON_2_4G)
-		channel = phy_GetChannelIndexOfTxPowerLimit(BAND_ON_2_4G,
-							    channel);
-	else if (band_type == BAND_ON_5G)
-		channel = phy_GetChannelIndexOfTxPowerLimit(BAND_ON_5G,
-							    channel);
+	if (band_type == BAND_ON_2_4G || band_type == BAND_ON_5G)
+		channel = phy_GetChannelIndexOfTxPowerLimit(band_type, channel);
 
 	if (idx_band == -1 || idx_regulation == -1 || idx_bandwidth == -1 ||
 	    idx_rate_sctn == -1 || idx_channel == -1) {
-- 
2.17.1

