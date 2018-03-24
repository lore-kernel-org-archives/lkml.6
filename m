Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750865AbeCXELp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 00:11:45 -0400
Received: from mout.perfora.net ([74.208.4.196]:45587 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbeCXELn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 00:11:43 -0400
From: Quytelda Kahja <quytelda@tamalin.org>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 3/3] ieee80211: Replace bit shifts with the BIT() macro for 802.11g ERP IEs.
Date: Fri, 23 Mar 2018 21:10:27 -0700
Message-Id: <20180324041027.6498-3-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180324041027.6498-1-quytelda@tamalin.org>
References: <20180324041027.6498-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:k7gMxXvoRa6oB0FLXF2SUOqVpQWJ5a3+qJubj9Dcjn6nJtbQ5FB
 vSW0u3vLi8RqbV7qonO1p7oqZrqmah9JhEspT8HgBL29SDPq4oWNphwdD56j2wq6XyZF8a0
 jpolS1NmscIw2TkwQJfBrTQodF6ucMzkB/cjzJd3ljxvc3Cp06BVNR5L6HRAv8uYGiaLvj9
 YK2ozdRoXr0Tal/mOGsDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lQ3wlwp90hY=:C/do8+tjDakBu86Gi/xp3F
 mQrxsbzs85eUDw/asr2Y5n/QzIYpYYdtUeCfmPxmZl1HcHJXBiPZyOrf+JRovcXWxOa56sGNU
 puU/KFU7ZEFuIlqn7nLvpAkE8atYVi9y7uyQxNYebMCX/y5e8lE712tQMAWDe+CqqkMzzEGEt
 J36PpxL/aPdIdbNs2N9qwrdfzPVsJ8GLqU72jY0XtGROc1J+Lvr8t64DDNH3JPr1B7AFXYv0y
 34ionBvZNFkwH0dq+hi3Z7IFrz7pAANlhVAkmpxynrfyJl4pXe6ShKB05SUTqzhA2C1o2rX4z
 0tAuNeHY/lH1UVSib8TcyGFD5/66nANXks8Xi0Yap31fH1ARUQYslHHkgcO97zVQLP69AG4gh
 A902OkuAuhBPi8CW4JxcpxdIUhODJLxpUmCkNCj7VscXsUYysctUeawA72NQrWmopgURnYZb0
 B5tTR0z5XVkfQ8zojz14rccJIOWBLqYVWVM38oL0oaRY40zHUyZ+nxb+dPCb7x5+T4dy/VvPQ
 8f8/q2YTMSnnlgnIcrCKpUCSbgCisb/9pMjlWZtQSph1jhTaQaeES0w91+uLtkZyJXwrPYkBU
 VzY9ITlORg0AqyF5KXAOpAxnmogEB3panR/yW6gFgiOAScm44rzQAsz8JX6EfqiGfLMgO8AYG
 RUQp5TxtmWvurD1NZn8MhZvmJAhVZqZW7vRc8EcQ8a2OGyfyBOK1nq2VeeehNpfxvCST3Hmyn
 U9I7biCRYGfL5Tx5vGTHbdqSnRPpSz5FOib5IA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is neater and more consistent with the rest of the document to use the
BIT() macro from 'linux/bitops.h' to define the WLAN_ERP_* bitmasks.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 include/linux/ieee80211.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index dc361ed2fb7e..bc68d542f082 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1641,9 +1641,9 @@ struct ieee80211_vht_operation {
 #define IEEE80211_SPCT_MSR_RPRT_TYPE_RPI	2
 
 /* 802.11g ERP information element */
-#define WLAN_ERP_NON_ERP_PRESENT (1<<0)
-#define WLAN_ERP_USE_PROTECTION (1<<1)
-#define WLAN_ERP_BARKER_PREAMBLE (1<<2)
+#define WLAN_ERP_NON_ERP_PRESENT BIT(0)
+#define WLAN_ERP_USE_PROTECTION  BIT(1)
+#define WLAN_ERP_BARKER_PREAMBLE BIT(2)
 
 /* WLAN_ERP_BARKER_PREAMBLE values */
 enum {
-- 
2.16.2
