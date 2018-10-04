Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB94C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D84521470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D84521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeJDOCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:02:36 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.62]:19343 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbeJDOCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:02:36 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id D6ED1198F5A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 02:10:46 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 7xlzgvqSQ8YaU7xmKgOZ3N; Thu, 04 Oct 2018 02:10:46 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:48088 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g7xly-0030bB-TM; Thu, 04 Oct 2018 02:10:11 -0500
Date:   Thu, 4 Oct 2018 09:10:09 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] scsi: aic94xx: mark expected switch fall-throughs
Message-ID: <20181004071009.GA13875@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 92.93.206.174
X-Source-L: No
X-Exim-ID: 1g7xly-0030bB-TM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net (embeddedor) [92.93.206.174]:48088
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114988 ("Missing break in switch")
Addresses-Coverity-ID: 114989 ("Missing break in switch")
Addresses-Coverity-ID: 114990 ("Missing break in switch")
Addresses-Coverity-ID: 114991 ("Missing break in switch")
Addresses-Coverity-ID: 114992 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/aic94xx/aic94xx_scb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_scb.c b/drivers/scsi/aic94xx/aic94xx_scb.c
index 22873ce..91ea87d 100644
--- a/drivers/scsi/aic94xx/aic94xx_scb.c
+++ b/drivers/scsi/aic94xx/aic94xx_scb.c
@@ -724,9 +724,11 @@ static void set_speed_mask(u8 *speed_mask, struct asd_phy_desc *pd)
 	switch (pd->max_sas_lrate) {
 	case SAS_LINK_RATE_6_0_GBPS:
 		*speed_mask &= ~SAS_SPEED_60_DIS;
+		/* fall through*/
 	default:
 	case SAS_LINK_RATE_3_0_GBPS:
 		*speed_mask &= ~SAS_SPEED_30_DIS;
+		/* fall through*/
 	case SAS_LINK_RATE_1_5_GBPS:
 		*speed_mask &= ~SAS_SPEED_15_DIS;
 	}
@@ -734,6 +736,7 @@ static void set_speed_mask(u8 *speed_mask, struct asd_phy_desc *pd)
 	switch (pd->min_sas_lrate) {
 	case SAS_LINK_RATE_6_0_GBPS:
 		*speed_mask |= SAS_SPEED_30_DIS;
+		/* fall through*/
 	case SAS_LINK_RATE_3_0_GBPS:
 		*speed_mask |= SAS_SPEED_15_DIS;
 	default:
@@ -745,6 +748,7 @@ static void set_speed_mask(u8 *speed_mask, struct asd_phy_desc *pd)
 	switch (pd->max_sata_lrate) {
 	case SAS_LINK_RATE_3_0_GBPS:
 		*speed_mask &= ~SATA_SPEED_30_DIS;
+		/* fall through*/
 	default:
 	case SAS_LINK_RATE_1_5_GBPS:
 		*speed_mask &= ~SATA_SPEED_15_DIS;
@@ -803,6 +807,7 @@ void asd_build_control_phy(struct asd_ascb *ascb, int phy_id, u8 subfunc)
 
 		/* link reset retries, this should be nominal */
 		control_phy->link_reset_retries = 10;
+		/* fall through */
 
 	case RELEASE_SPINUP_HOLD: /* 0x02 */
 		/* decide the func_mask */
-- 
2.7.4

