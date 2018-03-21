Return-Path: <hariprasath.elango@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521631004; cv=none;
        d=google.com; s=arc-20160816;
        b=vppCBqx7L3Vct2YIYq7mTiEemYNatAspC3plz0LiT2xvwh3GbDvba08HewxdC3hcGt
         0RdSCiEwQCygioSAPphHaf3Z+8N0hZvZ7xKs0sm5H9MG2J7vBoa1ERIFs7Q/3rSizxxW
         FN7orG+Zh5NTutYrTRVBh6vPmibM4CaIN1uL3yfpkEDrHvxtaovJLzPgcMouDMciTeZp
         Wi1ar96vw9nJ7W9g9bRZ9fQR9SollUdhtCYGCO4rBEV6lZu6jo6Y5/5pAHRvPfx9NGW4
         6rvgBm0FdERvKnDeWaue5fw+lpse9MCg7QsKRS3YPjCNqkUnZD+C3xpJhRoUisK5jn3w
         BiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=eulO39E4Ky49awq/FnHraOvH9YntX/ea+TqNY6VKfbY=;
        b=j9exPt7lyUm1nM3Xv5vuY8o90meqazf1TrdZh2r23LR52RwFWMYaRS8C6OoRI9mj4g
         unSfLuxgmQFri9A3kU4C4i+s+6p6ikjfSXMZj2yqpINXopq6UWoRgKCVqpXq2mLSRqa5
         mvad7/zHcXGT+I0vzLukoX585Mb6uCPLnaJL+lftmJHFrP+QmC4mSUWcblutCB3eSqeY
         Akj6/lpbOVkBO4K3ForyJwXFz2punF8LB1FVHtbhtexgIwIXlRV1eOmSPTDuXr2LvYuf
         AiyNpQJ3dTeY7FJUsm4hqmfhasx4VsUJJ36F3Kb/ePu9AkEyQibz2jV1av3OF2VRmycF
         b1Ew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jujT6jGT;
       spf=pass (google.com: domain of hariprasath.elango@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hariprasath.elango@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jujT6jGT;
       spf=pass (google.com: domain of hariprasath.elango@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hariprasath.elango@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELseQld/4qLy+Eg0IjQz1AtmKbxMUN7X8dIMg3YGjFSm5IaRGi1egudY4YTJySEfRb8iBFymqA==
From: hariprasath.elango@gmail.com
To: ruxandra.radulescu@nxp.com,
	gregkh@linuxfoundation.org
Cc: gehariprasath@gmail.com,
	HariPrasath Elango <hariprasath.elango@gmail.com>,
	linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCH] staging: fsl-dpaa2: replace simple switch case by if statement
Date: Wed, 21 Mar 2018 16:46:04 +0530
Message-Id: <20180321111604.9902-1-hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595545752605466743?=
X-GMAIL-MSGID: =?utf-8?q?1595545752605466743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

Replace a couple of simple switch cases by if condition

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
index 070a3f2..fb517cb 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
@@ -171,8 +171,7 @@ static void dpaa2_eth_get_strings(struct net_device *netdev, u32 stringset,
 	u8 *p = data;
 	int i;
 
-	switch (stringset) {
-	case ETH_SS_STATS:
+	if (stringset == ETH_SS_STATS) {
 		for (i = 0; i < DPAA2_ETH_NUM_STATS; i++) {
 			strlcpy(p, dpaa2_ethtool_stats[i], ETH_GSTRING_LEN);
 			p += ETH_GSTRING_LEN;
@@ -181,18 +180,16 @@ static void dpaa2_eth_get_strings(struct net_device *netdev, u32 stringset,
 			strlcpy(p, dpaa2_ethtool_extras[i], ETH_GSTRING_LEN);
 			p += ETH_GSTRING_LEN;
 		}
-		break;
 	}
 }
 
 static int dpaa2_eth_get_sset_count(struct net_device *net_dev, int sset)
 {
-	switch (sset) {
-	case ETH_SS_STATS: /* ethtool_get_stats(), ethtool_get_drvinfo() */
+	if (sset == ETH_SS_STATS)
+		/* ethtool_get_stats(), ethtool_get_drvinfo() */
 		return DPAA2_ETH_NUM_STATS + DPAA2_ETH_NUM_EXTRA_STATS;
-	default:
+	else
 		return -EOPNOTSUPP;
-	}
 }
 
 /** Fill in hardware counters, as returned by MC.
-- 
2.10.0.GIT
