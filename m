Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCXEMI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 00:12:08 -0400
Received: from mout.perfora.net ([74.208.4.194]:43071 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750743AbeCXELn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 00:11:43 -0400
From: Quytelda Kahja <quytelda@tamalin.org>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 2/3] ieee80211: Replace bit shifts with the BIT() macro for measurement masks.
Date: Fri, 23 Mar 2018 21:10:26 -0700
Message-Id: <20180324041027.6498-2-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180324041027.6498-1-quytelda@tamalin.org>
References: <20180324041027.6498-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:L+2GxnK4E8M4EXHjCqEaa/U3ZO3LeF5g54r7VJCGHA2PtVAtFGs
 25MhDj2rP8fcetQdLi7StUpVW6ZucmfALB1hTG6qIAYUUEVLgvo3qT/ptIewqoWNTzYMD8j
 Q68HWC0s+0KUDtWRroLu3Ykz9Q5Df4q66/l/rl3BQfV2mUMbjVaPVepGEWPPXlJ11mQpHwZ
 1er5utpT7NwAcdW0d9GVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LSLelXvDT4Q=:FY58Jk3Sb11fYz486nG7QF
 udl/aXJUrJofqkpeO0r2OSDYQVHQ1+Skf/gwDjeA+FaEd17LPJqhhZslHrW+qlRUr2ZBQNGNt
 x7nBMrUtCO0fNeUphD0LWbG4yEB+e7fkuC2XrsLdmXZTeB05Tnrai3fzXm0EiXFeYoaZc4E1k
 IUy+qgGK1Tix4WGtYQl5NiBVNySSEaLdxN6YErmoXe+j/VTa/kNkxVlz3H7CY32+tDvGdmM/i
 eS9F6As9Qy5EuxOZ2p4vS271aruOLlhv1Gf/RRSvD+REAsKI+Mgpbi3djbpPfM1H/K88WKDXd
 taj1ztiQQdBDyItfT90isdHLf+cuEpyY8lSdAqy8q0c+nHMZD4qHat4xcCNMgMcmXIQfvrrNv
 GrLTCAO1/a742Bgy3e13ibMn3gZ8TedQDWrs1yf8Ck5yTTFDliL8JV7k5vgyBf9pU83GBhyJX
 3sOB+MC2XUb/IMBw/eW20NRKSUA1EHu1rcehVWlfPCyVPnBUj3t/MjVVLUWQ/XjiuLZIhr/dR
 i50K5ltKQ8krne9Jtkds+I0JuTc/oN1I/cToRhbZxJGD4m8dilh5xAPX0zUhl2kHNc/6micyL
 t3q+Z/Stv2Rrzv8iO4QbmVzsCUmXbA1RAh1J6X+CQaOUYA5HnRD6VKMwF7h2JVUgknb7W/khZ
 VZzUC0+dAumsp6R+vZOmadEYUNmyw+0HcuGgoqr2Nf+rEAP0HCxWxXsEAKxAPlXhWgkDYmXDv
 zsZrACqXxIDI+7kxDSqfozYvRNTiYfn7XuHvpQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is neater and more consistent with the rest of the document to use the
BIT() macro from 'linux/bitops.h' to define the
IEEE80211_SPCT_MSR_RPRT_MODE_* bitmasks.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 include/linux/ieee80211.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 58069176b432..dc361ed2fb7e 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1632,9 +1632,9 @@ struct ieee80211_vht_operation {
 #define WLAN_CAPABILITY_DMG_RADIO_MEASURE	BIT(12)
 
 /* measurement */
-#define IEEE80211_SPCT_MSR_RPRT_MODE_LATE	(1<<0)
-#define IEEE80211_SPCT_MSR_RPRT_MODE_INCAPABLE	(1<<1)
-#define IEEE80211_SPCT_MSR_RPRT_MODE_REFUSED	(1<<2)
+#define IEEE80211_SPCT_MSR_RPRT_MODE_LATE	BIT(0)
+#define IEEE80211_SPCT_MSR_RPRT_MODE_INCAPABLE	BIT(1)
+#define IEEE80211_SPCT_MSR_RPRT_MODE_REFUSED	BIT(2)
 
 #define IEEE80211_SPCT_MSR_RPRT_TYPE_BASIC	0
 #define IEEE80211_SPCT_MSR_RPRT_TYPE_CCA	1
-- 
2.16.2
