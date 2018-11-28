Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FD9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C429B20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C429B20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeK1P4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:56:18 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.111]:32969 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbeK1P4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:56:18 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 43B7B2F33E7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:32:30 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrWYggWVykBj6RrWYgctJ5; Tue, 27 Nov 2018 22:32:30 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58358 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrWX-001p79-J6; Tue, 27 Nov 2018 22:32:29 -0600
Date:   Tue, 27 Nov 2018 22:32:27 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        megaraidlinux.pdl@broadcom.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 29/41] scsi: megaraid: megaraid_sas_base: Mark expected
 switch fall-through
Message-ID: <073efb316d0acba28e6105fcd4f4d5deda2ff3f7.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrWX-001p79-J6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58358
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 209
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index b7d3fc6fb118..9db7aebc3564 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3281,6 +3281,7 @@ megasas_complete_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd,
 			megasas_complete_int_cmd(instance, cmd);
 			break;
 		}
+		/* fall through */
 
 	case MFI_CMD_LD_READ:
 	case MFI_CMD_LD_WRITE:
-- 
2.17.1

