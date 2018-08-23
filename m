Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258A4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C02208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C02208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbeHWRNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:13:40 -0400
Received: from gateway23.websitewelcome.com ([192.185.48.71]:36491 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731195AbeHWRNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:13:40 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 0BACD13C25
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 08:43:54 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id spt4fPdKWPvAdsptbfO5Rg; Thu, 23 Aug 2018 08:43:53 -0500
X-Authority-Reason: nr=8
Received: from [189.250.40.214] (port=58782 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fspt2-000Z5p-Rm; Thu, 23 Aug 2018 08:42:56 -0500
Date:   Thu, 23 Aug 2018 08:42:55 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] apparmor: remove dead code
Message-ID: <20180823134255.GA12128@embeddedor.com>
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
X-Source-IP: 189.250.40.214
X-Source-L: No
X-Exim-ID: 1fspt2-000Z5p-Rm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.40.214]:58782
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to commit fb5841091f28 ("apparmor: remove no-op permission check
in policy_unpack"), there is some leftover code.

Coverity reports this issue as Structurally dead code. Fix this by
removing such code.

Addresses-Coverity-ID: 1472998 ("Structurally dead code")
Fixes: fb5841091f28 ("apparmor: remove no-op permission check in policy_unpack")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 security/apparmor/policy_unpack.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 3647b58..21cb384 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -422,10 +422,6 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
 	}
 
 	return dfa;
-
-fail:
-	aa_put_dfa(dfa);
-	return ERR_PTR(-EPROTO);
 }
 
 /**
-- 
2.7.4

