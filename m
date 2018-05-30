Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753090AbeE3LdE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:33:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60880 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751777AbeE3LHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:04 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Kees Cook" <keescook@google.com>,
        "Johannes Berg" <johannes.berg@intel.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.855916611@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 104/153] regulatory: add NUL to request alpha2
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 657308f73e674e86b60509a430a46e569bf02846 upstream.

Similar to the ancient commit a5fe8e7695dc ("regulatory: add NUL
to alpha2"), add another byte to alpha2 in the request struct so
that when we use nla_put_string(), we don't overrun anything.

Fixes: 73d54c9e74c4 ("cfg80211: add regulatory netlink multicast group")
Reported-by: Kees Cook <keescook@google.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/net/regulatory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -66,7 +66,7 @@ enum environment_cap {
 struct regulatory_request {
 	int wiphy_idx;
 	enum nl80211_reg_initiator initiator;
-	char alpha2[2];
+	char alpha2[3];
 	bool intersect;
 	bool processed;
 	enum environment_cap country_ie_env;
