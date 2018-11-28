Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A81C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A133620873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A133620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeK1Peg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:34:36 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.122]:19935 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726894AbeK1Peg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:34:36 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id BFED948B6E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:34:21 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrYLgzR2MaSeyRrYLgC3yn; Tue, 27 Nov 2018 22:34:21 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58398 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrYK-001qhX-F3; Tue, 27 Nov 2018 22:34:21 -0600
Date:   Tue, 27 Nov 2018 22:34:17 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 39/41] scsi: sym53c8xx_2: sym_nvram: Mark expected switch
 fall-through
Message-ID: <5e410e73a46bb5722617d4060bd5d92ca5be34bd.1543374820.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gRrYK-001qhX-F3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58398
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 265
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
 drivers/scsi/sym53c8xx_2/sym_nvram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sym53c8xx_2/sym_nvram.c b/drivers/scsi/sym53c8xx_2/sym_nvram.c
index 5662fbb3ff60..0d37b4f07b5e 100644
--- a/drivers/scsi/sym53c8xx_2/sym_nvram.c
+++ b/drivers/scsi/sym53c8xx_2/sym_nvram.c
@@ -708,6 +708,7 @@ static int sym_read_Tekram_nvram (struct sym_device *np, Tekram_nvram *nvram)
 					  data, len);
 		if (!x)
 			break;
+		/* fall through */
 	default:
 		x = sym_read_T93C46_nvram(np, nvram);
 		break;
-- 
2.17.1

