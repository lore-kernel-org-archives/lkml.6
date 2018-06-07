Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id X5+uONRNGVtTcwAAmS7hNA
	; Thu, 07 Jun 2018 15:23:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3EE82607E7; Thu,  7 Jun 2018 15:23:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C0B48606DD;
	Thu,  7 Jun 2018 15:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0B48606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935846AbeFGPXi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:23:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41209 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935550AbeFGO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:58:41 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbY-0005hL-Qb; Thu, 07 Jun 2018 15:09:32 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00036x-Ez; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Kees Cook" <keescook@google.com>,
        "Johannes Berg" <johannes.berg@intel.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.863632618@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 277/410] regulatory: add NUL to request alpha2
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 657308f73e674e86b60509a430a46e569bf02846 upstream.

Similar to the ancient commit a5fe8e7695dc ("regulatory: add NUL
to alpha2"), add another byte to alpha2 in the request struct so
that when we use nla_put_string(), we don't overrun anything.

Fixes: 73d54c9e74c4 ("cfg80211: add regulatory netlink multicast group")
Reported-by: Kees Cook <keescook@google.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/net/regulatory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -78,7 +78,7 @@ struct regulatory_request {
 	int wiphy_idx;
 	enum nl80211_reg_initiator initiator;
 	enum nl80211_user_reg_hint_type user_reg_hint_type;
-	char alpha2[2];
+	char alpha2[3];
 	enum nl80211_dfs_regions dfs_region;
 	bool intersect;
 	bool processed;
