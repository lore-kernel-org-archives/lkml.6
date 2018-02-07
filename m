Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbeBGNJq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:09:46 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29076 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753696AbeBGNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:09:44 -0500
From: Fabien Dessenne <fabien.dessenne@st.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Corentin LABBE <clabbe.montjoie@gmail.com>,
        <linux-crypto@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@st.com>,
        Lionel Debieve <lionel.debieve@st.com>
Subject: [PATCH 2/2] crypto: stm32/cryp - add stm32mp1 support
Date: Wed, 7 Feb 2018 14:08:55 +0100
Message-ID: <1518008935-30428-3-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518008935-30428-1-git-send-email-fabien.dessenne@st.com>
References: <1518008935-30428-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stm32mp1 differs from stm32f7 in the way it handles byte ordering and
padding for aes gcm & ccm algo.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 6a1fe98..c5d3efc 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -1906,8 +1906,14 @@ static const struct stm32_cryp_caps f7_data = {
 	.padding_wa = true,
 };
 
+static const struct stm32_cryp_caps mp1_data = {
+	.swap_final = false,
+	.padding_wa = false,
+};
+
 static const struct of_device_id stm32_dt_ids[] = {
 	{ .compatible = "st,stm32f756-cryp", .data = &f7_data},
+	{ .compatible = "st,stm32mp1-cryp", .data = &mp1_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_dt_ids);
-- 
2.7.4
