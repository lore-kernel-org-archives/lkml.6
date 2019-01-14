Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A9CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256742086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GvkVJoH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfANJdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:33:05 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2347 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbfANJdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:33:04 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3c57330001>; Mon, 14 Jan 2019 01:32:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 14 Jan 2019 01:33:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 14 Jan 2019 01:33:03 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 14 Jan
 2019 09:33:03 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 14 Jan 2019 09:33:03 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c3c574d0000>; Mon, 14 Jan 2019 01:33:03 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <broonie@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jinyoung Park <jinyoungp@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: [PATCH] regmap-irq: do not write mask register if mask_base is zero
Date:   Mon, 14 Jan 2019 17:32:58 +0800
Message-ID: <20190114093258.28431-1-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547458355; bh=0OnHzBt5es8g2HSdohKXESDhLxi6lJehrw+NLO6N/ng=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=GvkVJoH+s6MVk8QKAyn06zgmaYQGkUHaDwWDGcNlhvyjFtzdbIHb3SF+caQiHUTbe
         EXM4xnHNptLF2cyKn66neounV6MYz+GPuFxmOpHSjUxtdAZ9H4u5OZ4wZmLM3pW8YB
         GlI6J7NYdZg4OntPfKmPtHeMXTLBWxBNGiAP2hJI80oaed+JFHTgVkbffaR6vtFiUv
         KKBC0+XoBoEQLDHWrhl933IPIH5XM51HhEPrZIegIV2jKsfA48uXceTEYoVn6JBwMa
         SjhKo0zJARB3FVY0iHhNSeIRSu0aqpmfQAGT8vidgMtw0O42vGPG1GBLUFy6QdTZBF
         hu9EMPlEjbvXQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If client have not provided the mask base register then do not
write into the mask register.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Jinyoung Park <jinyoungp@nvidia.com>
Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 drivers/base/regmap/regmap-irq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-=
irq.c
index d2d0014b0d23..330c1f7e9665 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -108,6 +108,9 @@ static void regmap_irq_sync_unlock(struct irq_data *dat=
a)
 	 * suppress pointless writes.
 	 */
 	for (i =3D 0; i < d->chip->num_regs; i++) {
+		if (!d->chip->mask_base)
+			continue;
+
 		reg =3D d->chip->mask_base +
 			(i * map->reg_stride * d->irq_reg_stride);
 		if (d->chip->mask_invert) {
@@ -588,6 +591,9 @@ int regmap_add_irq_chip(struct regmap *map, int irq, in=
t irq_flags,
 	/* Mask all the interrupts by default */
 	for (i =3D 0; i < chip->num_regs; i++) {
 		d->mask_buf[i] =3D d->mask_buf_def[i];
+		if (!chip->mask_base)
+			continue;
+
 		reg =3D chip->mask_base +
 			(i * map->reg_stride * d->irq_reg_stride);
 		if (chip->mask_invert)
--=20
2.19.2

