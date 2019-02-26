Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCD12173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfBZJYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:24:54 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:51659 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:24:53 -0500
Received: from 5HSWXM1.fritz.box ([87.191.24.82]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPA (Nemesis) id
 1M8yU2-1gtd1f2tcM-0068oM; Tue, 26 Feb 2019 10:24:45 +0100
From:   Rolf Evers-Fischer <embedded24@evers-fischer.de>
To:     kishon@ti.com, linux-kernel@vger.kernel.org
Cc:     Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: [PATCH] phy: ti-pipe3: Do not overwrite the whole PROGRAMMABILITY register
Date:   Tue, 26 Feb 2019 10:24:21 +0100
Message-Id: <20190226092421.13440-1-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7P3qrNhErKWV8XxaD2lBu4iAPhVLMaRQggFovP/j8tcVIC9hXlP
 C+N/tU5sX9w/HElVz2tH1iM1NJA43sLiS9Ul1+h5rZ7grOGcJN7daaOWOrt0V5mBrxoH+Xv
 9vx/2AxcAzSASdSJmBjPqhn1HwFxih62aUUHE07899Tp85pbweBrT1ukR8Uh37n2tGMjLBr
 ZbpT3+v7MS9BYL5Io09tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:As27xGcIp7Q=:huLFTiO0ROyBvmXspG43ti
 ljGkvQdnnBUoEMdD+DpeVuy2yiwO3r9+iIEj7qr45bG3jcRZCy6zFH8oWv3QOhGImeSar41pF
 zFykfYk1xwLuzjNEUjK/qAoWQCHxWq8t9B4VOwIXMU5oqnY3eHbJKjbQ5J0s9uhkRnhbxn+6i
 CeG7ZTEtoLQL9fEWBAmx/qVeECoduPNVzbl0t7a61qGnb4Xy34qoAic1AclIbyzy4HfzK9aBS
 18J1+jTBXYthxBBpdVWRrZD831glrLFJc4FrC8euJbcBUp+EuX2SW04I+pZxIjYEL5653C85k
 H53cVMHKnM0AyB7DabX6yy5CcyDV9OlCDQdxu6KCERbeJQwyheYVyY6mryQeJRyPk0EwXLpyV
 nVULCZapJacGvAoIM330uqePQAlA5UKexGedb3vd+CKvntKf6TRLtZWOirLwo9eGSlKHX4hsQ
 zb5H+hcULSNxe7To/Eb6Vjq/t+w3OmuXomISAhwNcaovje8GAN0FTAr7UlodTfctpoTp9n9Kz
 Z76rmi20MofOm92geKq36LfdnNM6GEDSyZfFebRKPi1BgfE75Wn+THCp/Es0WxbpIKVifK+/G
 94FwydsiOvD2gBQMeASdN8WEI4GrQj+7p2U08+ECKhlH61bjBrw298oUPiOKoyS32pSdTHt/F
 1MiQA5u63LXtD2zrZugVSbX5JAVluJSxQ22U5aZxVJK9QGF9tkmWrGzZckPwqSBKHY5cLB72b
 qleK8mPESXpkFAgV9ziafd9xLZ7AqXf8PtVGszawpRWypuUDbgN/YQsre0M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>

Previously, ti_pipe3_calibrate() wrote all bits in the
PCIEPHYRX_ANA_PROGRAMMABILITY register, thus overwriting bits,
which should not be modified.
Fix ti_pipe3_calibrate() so that it only modifies LOSD and
INTERFACE bits.

Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
---
 drivers/phy/ti/phy-ti-pipe3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 68ce4a082b9b..693acc167351 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -303,7 +303,7 @@ static void ti_pipe3_calibrate(struct ti_pipe3 *phy)
 
 	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_ANA_PROGRAMMABILITY);
 	val &= ~(INTERFACE_MASK | LOSD_MASK | MEM_PLLDIV);
-	val = (0x1 << INTERFACE_SHIFT | 0xA << LOSD_SHIFT);
+	val |= (0x1 << INTERFACE_SHIFT | 0xA << LOSD_SHIFT);
 	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_ANA_PROGRAMMABILITY, val);
 
 	val = ti_pipe3_readl(phy->phy_rx, PCIEPHYRX_DIGITAL_MODES);
-- 
2.21.0

