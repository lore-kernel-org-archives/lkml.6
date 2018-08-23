Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F86CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6419521473
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6419521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbeHWLj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:39:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbeHWLj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:39:57 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D96E3C7B;
        Thu, 23 Aug 2018 08:11:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 089/130] ieee802154: at86rf230: use __func__ macro for debug messages
Date:   Thu, 23 Aug 2018 09:53:25 +0200
Message-Id: <20180823074932.960899583@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Schmidt <stefan@datenfreihafen.org>

[ Upstream commit 8a81388ec27c4c0adbdecd20e67bb5f411ab46b2 ]

Instead of having the function name hard-coded (it might change and we
forgot to update them in the debug output) we can use __func__ instead
and also shorter the line so we do not need to break it. Also fix an
extra blank line while being here.
Found by checkpatch.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ieee802154/at86rf230.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1117,8 +1117,7 @@ at86rf230_set_hw_addr_filt(struct ieee80
 	if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
 		u16 addr = le16_to_cpu(filt->short_addr);
 
-		dev_vdbg(&lp->spi->dev,
-			 "at86rf230_set_hw_addr_filt called for saddr\n");
+		dev_vdbg(&lp->spi->dev, "%s called for saddr\n", __func__);
 		__at86rf230_write(lp, RG_SHORT_ADDR_0, addr);
 		__at86rf230_write(lp, RG_SHORT_ADDR_1, addr >> 8);
 	}
@@ -1126,8 +1125,7 @@ at86rf230_set_hw_addr_filt(struct ieee80
 	if (changed & IEEE802154_AFILT_PANID_CHANGED) {
 		u16 pan = le16_to_cpu(filt->pan_id);
 
-		dev_vdbg(&lp->spi->dev,
-			 "at86rf230_set_hw_addr_filt called for pan id\n");
+		dev_vdbg(&lp->spi->dev, "%s called for pan id\n", __func__);
 		__at86rf230_write(lp, RG_PAN_ID_0, pan);
 		__at86rf230_write(lp, RG_PAN_ID_1, pan >> 8);
 	}
@@ -1136,15 +1134,13 @@ at86rf230_set_hw_addr_filt(struct ieee80
 		u8 i, addr[8];
 
 		memcpy(addr, &filt->ieee_addr, 8);
-		dev_vdbg(&lp->spi->dev,
-			 "at86rf230_set_hw_addr_filt called for IEEE addr\n");
+		dev_vdbg(&lp->spi->dev, "%s called for IEEE addr\n", __func__);
 		for (i = 0; i < 8; i++)
 			__at86rf230_write(lp, RG_IEEE_ADDR_0 + i, addr[i]);
 	}
 
 	if (changed & IEEE802154_AFILT_PANC_CHANGED) {
-		dev_vdbg(&lp->spi->dev,
-			 "at86rf230_set_hw_addr_filt called for panc change\n");
+		dev_vdbg(&lp->spi->dev, "%s called for panc change\n", __func__);
 		if (filt->pan_coord)
 			at86rf230_write_subreg(lp, SR_AACK_I_AM_COORD, 1);
 		else
@@ -1248,7 +1244,6 @@ at86rf230_set_cca_mode(struct ieee802154
 	return at86rf230_write_subreg(lp, SR_CCA_MODE, val);
 }
 
-
 static int
 at86rf230_set_cca_ed_level(struct ieee802154_hw *hw, s32 mbm)
 {


