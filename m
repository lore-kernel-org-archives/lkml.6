Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06081C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4952184A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rRDyxmwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfAJELh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:11:37 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4775 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfAJELe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:11:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c36c5e80000>; Wed, 09 Jan 2019 20:11:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Jan 2019 20:11:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Jan 2019 20:11:33 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 04:11:32 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 04:11:33 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Jan 2019 04:11:32 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c36c5f20004>; Wed, 09 Jan 2019 20:11:32 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>,
        "Venkat Reddy Talla" <vreddytalla@nvidia.com>
Subject: [PATCH 2/2] regulator: max77620: disable notifier events for FPS rails
Date:   Thu, 10 Jan 2019 12:11:17 +0800
Message-ID: <20190110041117.8216-2-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190110041117.8216-1-markz@nvidia.com>
References: <20190110041117.8216-1-markz@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547093480; bh=ANuGvTGYMoCE/3OxiFWpD45mC+dsL4A5k+RFn7JGYe0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=rRDyxmwldO62y0no+pKyN2itzGm6fXDNTYNa79eWVgQ7X0yeRPKSXMkaPqGSUw8ei
         SsX/l3Pp7+/EVvBbCpTrEIxDvFVc2fKgNqqJK+QESlzEWAvSz7OWgfh96RJqELm+Iq
         Pm4j9S9w+lIxyw8BzPAp5FF7174gNC9FE2bUQ0PYacEe54EOFFpU67YLS4CO46IQkX
         zblkWAOgv0Ki8sb6ehRThpVDIUGGizLVDpNsK5ILAC2CJ+JVltTUZvTfv8C2ok4I75
         IUEr+pTiRXNNcD32SHfmCohZU/1NjTNDRfpzfPOn58s6X66iLW8mfHs0P1Rfn7TPzM
         hVRwb4cGrpj0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling regulator notifier events if regulator is
configured part of flexible power sequencer(FPS),
there is no SW control to enable/disable if regulator
is configured part of FPS, so disabling notifier events
if client driver try to enable/disable FPS rails.

Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 drivers/regulator/max77620-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max=
77620-regulator.c
index cd93cf53e23c..20e985071bfc 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -823,6 +823,13 @@ static int max77620_regulator_probe(struct platform_de=
vice *pdev)
 				rdesc->name, ret);
 			return ret;
 		}
+
+		/* there is no SW control for rails which are part of FPS
+		 * set always no contraint to true to avoid regulator
+		 * enable/disable notification
+		 */
+		if (pmic->reg_pdata[id].active_fps_src !=3D MAX77620_FPS_SRC_NONE)
+			rdev->constraints->always_on =3D true;
 	}
=20
 	return 0;
--=20
2.19.2

