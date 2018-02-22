Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932474AbeBVM7X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:59:23 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:47524 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932199AbeBVM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:59:17 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/5] regmap: Remove unnecessary printk for failed allocation
Date: Thu, 22 Feb 2018 12:59:11 +0000
Message-ID: <20180222125914.17016-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180222125914.17016-1-ckeepax@opensource.cirrus.com>
References: <20180222125914.17016-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=793 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802220164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 8a6de76f89bb..c84c4d5d2df7 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2052,10 +2052,9 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 			return -EINVAL;
 
 		wval = kmemdup(val, val_count * val_bytes, map->alloc_flags);
-		if (!wval) {
-			dev_err(map->dev, "Error in memory allocation\n");
+		if (!wval)
 			return -ENOMEM;
-		}
+
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
 			map->format.parse_inplace(wval + i);
 
-- 
2.11.0
