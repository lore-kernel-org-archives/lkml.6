Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC87AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB0A215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB0A215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeHHBmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:42:44 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.233]:25397 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727025AbeHHBmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:42:44 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 238DA1CDA3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 18:26:00 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nBMUfjbhIBcCXnBMVfJdaj; Tue, 07 Aug 2018 18:26:00 -0500
X-Authority-Reason: nr=8
Received: from [189.250.73.102] (port=48124 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnBMU-001ww8-52; Tue, 07 Aug 2018 18:25:58 -0500
Date:   Tue, 7 Aug 2018 18:25:57 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com
Subject: [PATCH 25/33] qed: qed_dev: Mark expected switch fall-throughs
Message-ID: <3c008dabbd2b659d67259ccd2e736fa85e28506d.1533675546.git.gustavo@embeddedor.com>
References: <cover.1533675546.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1533675546.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.73.102
X-Source-L: No
X-Exim-ID: 1fnBMU-001ww8-52
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.73.102]:48124
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 162
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I replaced the code comments with
a proper "fall through" annotation, which is what GCC is expecting
to find.

Addresses-Coverity-ID: 114809 ("Missing break in switch")
Addresses-Coverity-ID: 114810 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 6a0b46f..2f42df3 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -1709,14 +1709,14 @@ int qed_hw_init(struct qed_dev *cdev, struct qed_hw_init_params *p_params)
 						p_hwfn->hw_info.hw_mode);
 			if (rc)
 				break;
-		/* Fall into */
+		/* Fall through */
 		case FW_MSG_CODE_DRV_LOAD_PORT:
 			rc = qed_hw_init_port(p_hwfn, p_hwfn->p_main_ptt,
 					      p_hwfn->hw_info.hw_mode);
 			if (rc)
 				break;
 
-		/* Fall into */
+		/* Fall through */
 		case FW_MSG_CODE_DRV_LOAD_FUNCTION:
 			rc = qed_hw_init_pf(p_hwfn, p_hwfn->p_main_ptt,
 					    p_params->p_tunn,
-- 
2.7.4

