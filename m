Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02137C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B6B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B6B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeK1PvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:51:08 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.250]:28866 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727590AbeK1PvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:51:08 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id CE49040112A8D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:30:13 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrULgJK1Z957pRrULg2e0b; Tue, 27 Nov 2018 22:30:13 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58310 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrUL-001mpS-1W; Tue, 27 Nov 2018 22:30:13 -0600
Date:   Tue, 27 Nov 2018 22:30:11 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 19/41] scsi: isci: remote_node_context: mark expected switch
 fall-throughs
Message-ID: <b54e3cf608d656ce6d8445becd105d1613325198.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrUL-001mpS-1W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58310
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 148
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that, in this particular case, a dash is added as a token in
order to separate the "Fall through" annotations from the rest of
the comment on the same line, which is what GCC is expecting to find.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/isci/remote_node_context.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/isci/remote_node_context.c b/drivers/scsi/isci/remote_node_context.c
index e3f2a5359d71..474a43460963 100644
--- a/drivers/scsi/isci/remote_node_context.c
+++ b/drivers/scsi/isci/remote_node_context.c
@@ -601,9 +601,9 @@ enum sci_status sci_remote_node_context_suspend(
 				 __func__, sci_rnc);
 			return SCI_FAILURE_INVALID_STATE;
 		}
-		/* Fall through and handle like SCI_RNC_POSTING */
+		/* Fall through - and handle like SCI_RNC_POSTING */
 	case SCI_RNC_RESUMING:
-		/* Fall through and handle like SCI_RNC_POSTING */
+		/* Fall through - and handle like SCI_RNC_POSTING */
 	case SCI_RNC_POSTING:
 		/* Set the destination state to AWAIT - this signals the
 		 * entry into the SCI_RNC_READY state that a suspension
-- 
2.17.1

