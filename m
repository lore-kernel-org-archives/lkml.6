Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1D3C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A84C20894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A84C20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbeHBCce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:32:34 -0400
Received: from gateway30.websitewelcome.com ([192.185.180.41]:40631 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730431AbeHBCce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:32:34 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 923E834C6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 19:44:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id l1iofIG8bRPojl1iofnT7R; Wed, 01 Aug 2018 19:44:06 -0500
X-Authority-Reason: nr=8
Received: from [189.250.61.218] (port=43344 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fl1io-001vSv-2B; Wed, 01 Aug 2018 19:44:06 -0500
Date:   Wed, 1 Aug 2018 19:44:05 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] nfsd: use true and false for boolean values
Message-ID: <20180802004405.GA23995@embeddedor.com>
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
X-Source-IP: 189.250.61.218
X-Source-L: No
X-Exim-ID: 1fl1io-001vSv-2B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.61.218]:43344
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/nfsd/nfsfh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index a008e76..b319080 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -451,7 +451,7 @@ static bool fsid_type_ok_for_exp(u8 fsid_type, struct svc_export *exp)
 	switch (fsid_type) {
 	case FSID_DEV:
 		if (!old_valid_dev(exp_sb(exp)->s_dev))
-			return 0;
+			return false;
 		/* FALL THROUGH */
 	case FSID_MAJOR_MINOR:
 	case FSID_ENCODE_DEV:
@@ -461,13 +461,13 @@ static bool fsid_type_ok_for_exp(u8 fsid_type, struct svc_export *exp)
 	case FSID_UUID8:
 	case FSID_UUID16:
 		if (!is_root_export(exp))
-			return 0;
+			return false;
 		/* fall through */
 	case FSID_UUID4_INUM:
 	case FSID_UUID16_INUM:
 		return exp->ex_uuid != NULL;
 	}
-	return 1;
+	return true;
 }
 
 
-- 
2.7.4

