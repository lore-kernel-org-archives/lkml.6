Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932340AbeE1KJG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935042AbeE1KJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:09:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@google.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 069/185] regulatory: add NUL to request alpha2
Date: Mon, 28 May 2018 12:01:50 +0200
Message-Id: <20180528100056.674766400@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 657308f73e674e86b60509a430a46e569bf02846 ]

Similar to the ancient commit a5fe8e7695dc ("regulatory: add NUL
to alpha2"), add another byte to alpha2 in the request struct so
that when we use nla_put_string(), we don't overrun anything.

Fixes: 73d54c9e74c4 ("cfg80211: add regulatory netlink multicast group")
Reported-by: Kees Cook <keescook@google.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/regulatory.h |    2 +-
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
