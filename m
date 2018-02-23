Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeBWNoG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:44:06 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:59076 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751437AbeBWNoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:44:00 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <linus.walleij@linaro.org>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] pinctrl: core: Add missing EXPORT on pinctrl_register_mappings
Date: Fri, 23 Feb 2018 13:43:52 +0000
Message-ID: <20180223134352.32612-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=996 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802230172
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems that don't have devicetree need pinctrl_register_mappings.
It should be EXPORT_SYMBOL_GPL so that it can be called from
pinctrl drivers built as modules.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/pinctrl/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 343981cb2461..e5a303002021 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1416,6 +1416,7 @@ int pinctrl_register_mappings(const struct pinctrl_map *maps,
 {
 	return pinctrl_register_map(maps, num_maps, true);
 }
+EXPORT_SYMBOL_GPL(pinctrl_register_mappings);
 
 void pinctrl_unregister_map(const struct pinctrl_map *map)
 {
-- 
2.11.0
