Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0D0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBA72081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBA72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeK1PvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:51:21 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.97]:40781 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727672AbeK1PvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:51:20 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id A3F1342225
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:27:03 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrRHggT7ckBj6RrRHgcpxE; Tue, 27 Nov 2018 22:27:03 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58256 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrRG-001kCf-18; Tue, 27 Nov 2018 22:27:02 -0600
Date:   Tue, 27 Nov 2018 22:27:00 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 08/41] scsi: be2iscsi: be_main: Mark expected switch
 fall-through
Message-ID: <ca994231ba2101ba489ee7b18862a10a8c9dad7e.1543374820.git.gustavo@embeddedor.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543374820.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.127
X-Source-L: No
X-Exim-ID: 1gRrRG-001kCf-18
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58256
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 87
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1357387 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/be2iscsi/be_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index effb6fc95af4..b6449da1320c 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -1539,6 +1539,7 @@ beiscsi_hdl_get_handle(struct beiscsi_conn *beiscsi_conn,
 		break;
 	case UNSOL_DATA_DIGEST_ERROR_NOTIFY:
 		error = 1;
+		/* fall through */
 	case UNSOL_DATA_NOTIFY:
 		pasync_handle = pasync_ctx->async_entry[ci].data;
 		break;
-- 
2.17.1

