Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7C0C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7D820673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7D820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeGSFtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:49:46 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.95]:25987 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbeGSFtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:49:46 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 738E9400D184B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 00:08:31 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id g1B1fmAcXaSeyg1B1fNxCF; Thu, 19 Jul 2018 00:08:31 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=46322 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fg1B1-003nUS-03; Thu, 19 Jul 2018 00:08:31 -0500
Date:   Thu, 19 Jul 2018 00:08:30 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] s390/hypfs: Replace PTR_RET with PTR_ERR_OR_ZERO
Message-ID: <20180719050830.GA26688@embeddedor.com>
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
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fg1B1-003nUS-03
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:46322
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_RET is deprecated, use PTR_ERR_OR_ZERO instead.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/s390/hypfs/hypfs_diag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index a2945b2..3452e18 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -497,7 +497,7 @@ static int hypfs_create_cpu_files(struct dentry *cpus_dir, void *cpu_info)
 	}
 	diag224_idx2name(cpu_info__ctidx(diag204_info_type, cpu_info), buffer);
 	rc = hypfs_create_str(cpu_dir, "type", buffer);
-	return PTR_RET(rc);
+	return PTR_ERR_OR_ZERO(rc);
 }
 
 static void *hypfs_create_lpar_files(struct dentry *systems_dir, void *part_hdr)
@@ -544,7 +544,7 @@ static int hypfs_create_phys_cpu_files(struct dentry *cpus_dir, void *cpu_info)
 		return PTR_ERR(rc);
 	diag224_idx2name(phys_cpu__ctidx(diag204_info_type, cpu_info), buffer);
 	rc = hypfs_create_str(cpu_dir, "type", buffer);
-	return PTR_RET(rc);
+	return PTR_ERR_OR_ZERO(rc);
 }
 
 static void *hypfs_create_phys_files(struct dentry *parent_dir, void *phys_hdr)
-- 
2.7.4

