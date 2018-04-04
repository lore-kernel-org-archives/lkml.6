Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeDDLxo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:53:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37758 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDDLxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:53:42 -0400
X-Google-Smtp-Source: AIpwx4/4l2qEl0I4zQsnUrazDJAJIm033Korfz3pdDN95bCBnTedY3A1FLpba3+Qq6EfGm4RNDYESA==
From: Masanari Iida <standby24x7@gmail.com>
To: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] mac80211: Fix bad line warning
Date: Wed,  4 Apr 2018 20:53:33 +0900
Message-Id: <20180404115333.1563-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.17.0.rc2.3.gc2a499e6c31e
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 03fe2debbb2771fb90881e merged during 4.17 marge window,
I start to see following warning during "make xmldocs"

./include/net/mac80211.h:2083: warning: bad line:  >

Replace ">" with "*" fix the issue.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 include/net/mac80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d2279b2d61aa..b2f3a0c018e7 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2080,7 +2080,7 @@ struct ieee80211_txq {
  *	virtual interface might not be given air time for the transmission of
  *	the frame, as it is not synced with the AP/P2P GO yet, and thus the
  *	deauthentication frame might not be transmitted.
- >
+ *
  * @IEEE80211_HW_DOESNT_SUPPORT_QOS_NDP: The driver (or firmware) doesn't
  *	support QoS NDP for AP probing - that's most likely a driver bug.
  *
-- 
2.17.0.rc2.3.gc2a499e6c31e
