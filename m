Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeBLSPy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:15:54 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:46516 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752694AbeBLSPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:15:51 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <david.rhodes@cirrus.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/4] regmap: Correct comparison in regmap_cached
Date: Mon, 12 Feb 2018 18:15:44 +0000
Message-ID: <20180212181547.2415-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=638 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802120234
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cache pointer points to the actual memory used by the cache, as the
comparison here is looking for the type of the cache it should check
against cache_type.

Fixes: 1ea975cf1ef5 ("regmap: Add a function to check if a regmap register is cached")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 453116fd4362e..c7b7c5fa73ab4 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -99,7 +99,7 @@ bool regmap_cached(struct regmap *map, unsigned int reg)
 	int ret;
 	unsigned int val;
 
-	if (map->cache == REGCACHE_NONE)
+	if (map->cache_type == REGCACHE_NONE)
 		return false;
 
 	if (!map->cache_ops)
-- 
2.11.0
