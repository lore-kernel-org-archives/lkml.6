Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeBLSP4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:15:56 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:46518 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752741AbeBLSPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:15:51 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <david.rhodes@cirrus.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 4/4] regmap: Use helper function for register offset
Date: Mon, 12 Feb 2018 18:15:47 +0000
Message-ID: <20180212181547.2415-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180212181547.2415-1-ckeepax@opensource.cirrus.com>
References: <20180212181547.2415-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=763 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802120234
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a helper function exists for calculating register offsets lets use
that rather than open coding with the reg_stride.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 8594b02aa3e67..6342eaefc2189 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1993,7 +1993,7 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 				return -EINVAL;
 			}
 
-			ret = regmap_write(map, reg + (i * map->reg_stride),
+			ret = regmap_write(map, reg + regmap_get_offset(map, i),
 					   ival);
 			if (ret)
 				return ret;
-- 
2.11.0
