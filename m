Return-Path: <cmc@babblebit.net>
X-Google-Smtp-Source: AIpwx48frdwM+axbW0IQAAaqHSuhXlafML3KNMZ55pJRfhEueNbIWgVUj4RxgmxkbFs2txlFeve7
ARC-Seal: i=1; a=rsa-sha256; t=1522271983; cv=none;
        d=google.com; s=arc-20160816;
        b=BxSDW67Z0B6hQ26IyFg1/qbYt/WaiHfTSOzSP2aU2eIiIHy/t6+j2tB/6giIllFRGJ
         CqoqlV1dUso+OFzpwV3wRZD+dKBz5kMl+wel2wFu9rMb1Rn7TTJUgVWvIYb5CXVFDJXr
         +21+ZfhTEaRLNjwQgiuREgXaUznhKJ4SgN4Ixz/LUbspCq7PKehYJSww8smjmtAmEvY4
         yjBZ/STQ/XhL+ViIEU8atLyznLun+uwFX1nI1PtBNMSTDro7Cl1C9nXwsVWuMzSL0QJt
         lVvQeqmQeyXT0PDOl5PeTDsEKMhdYACycP6bbN1cxSyIibZcER4m10kAHfgfiEyBAujy
         D3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=R/uz8bjKXsjIELboBtP317xpJrps0eKm77F0FyDCjKY=;
        b=VPRHlXjhD0IGzWbhQPK2hxbgY1P8IkvXPptLc5ub0ixIOCmNUwhACJAy+iSFVxBdss
         5NaWHyoiFNgU+4vksxPFcqfsGY3G+qTVnB6+qRBVruOfxLBf2RGcfctJieGA3/B97/Wy
         VXmlmJzqDLo262A1I5QSTHnKKCry09uToZfv3eeHJD5b+VLsI5I0DaiyPqrvpQI3Wa7u
         LUmld4GfqFftpatH1mnVyGzBT4wC1FtrF9nc3gBUjy0WxM8gYzvBloBXhympofEtGBsU
         E0sMVO3F0qUDn5/BdK/TwDxEaRMZCGkn6DESbbSCKDxfSs9ptxvs7vbL3kHcF/tTIYrM
         JWZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@babblebit.net header.s=mail header.b=NBwHopey;
       spf=pass (google.com: domain of cmc@babblebit.net designates 37.139.8.208 as permitted sender) smtp.mailfrom=cmc@babblebit.net;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=babblebit.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@babblebit.net header.s=mail header.b=NBwHopey;
       spf=pass (google.com: domain of cmc@babblebit.net designates 37.139.8.208 as permitted sender) smtp.mailfrom=cmc@babblebit.net;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=babblebit.net
From: Chris Coffey <cmc@babblebit.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	NeilBrown <neil@brown.name>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chris Coffey <cmc@babblebit.net>
Subject: [PATCH] staging: mt7621-eth: Fix sparse warning in ethtool.c
Date: Wed, 28 Mar 2018 22:18:48 +0100
Message-Id: <20180328211848.11085-1-cmc@babblebit.net>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596217866471510564?=
X-GMAIL-MSGID: =?utf-8?q?1596217866471510564?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Include the local ethtool.h header file in mtk_eth_soc.h so
implementation files have centralized access to it.

This fixes the following sparse warning:

drivers/staging/mt7621-eth/ethtool.c:213:6: warning: symbol
'mtk_set_ethtool_ops' was not declared. Should it be static?

Signed-off-by: Chris Coffey <cmc@babblebit.net>
---
 drivers/staging/mt7621-eth/mtk_eth_soc.c | 1 -
 drivers/staging/mt7621-eth/mtk_eth_soc.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
index cbc7339843..0574e71573 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
@@ -35,7 +35,6 @@
 
 #include "mtk_eth_soc.h"
 #include "mdio.h"
-#include "ethtool.h"
 
 #define	MAX_RX_LENGTH		1536
 #define MTK_RX_ETH_HLEN		(VLAN_ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN)
diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.h b/drivers/staging/mt7621-eth/mtk_eth_soc.h
index 443f88d8af..01deeddfdd 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.h
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.h
@@ -23,6 +23,7 @@
 #include <linux/ethtool.h>
 #include <linux/version.h>
 #include <linux/atomic.h>
+#include "ethtool.h"
 
 /* these registers have different offsets depending on the SoC. we use a lookup
  * table for these
-- 
2.11.0
