Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757953AbeBPOga (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:36:30 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50974 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750942AbeBPOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:36:29 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Fix some signedness errors in register access
Date: Fri, 16 Feb 2018 14:36:10 +0000
Message-ID: <20180216143610.12048-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=625 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802160175
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

base and sysclk_reg should be unsigned int, as that is what
regmap takes as a register address.

sysclk_mask is used to mask unsigned register values so
should be unsigned.

sysclk_shift is a shift value so is not allowed to be negative.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 41cc11c19b83..d4042c95315e 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -64,10 +64,10 @@ struct wm_adsp {
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
 
-	int base;
-	int sysclk_reg;
-	int sysclk_mask;
-	int sysclk_shift;
+	unsigned int base;
+	unsigned int sysclk_reg;
+	unsigned int sysclk_mask;
+	unsigned int sysclk_shift;
 
 	struct list_head alg_regions;
 
-- 
2.11.0
