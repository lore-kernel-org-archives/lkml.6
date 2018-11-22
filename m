Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D23C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDE92080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Yea8vnYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDE92080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403824AbeKVKtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:49:21 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36648 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390778AbeKVKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:48:50 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4E69689154;
        Thu, 22 Nov 2018 13:12:06 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1542845526;
        bh=7pBgkn6yqsFB/7HrIpaxbvTidNEiKjOKcblyTutVUkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Yea8vnYOyEF8mTL1ayviFy0wKY6F0bm0ib1jOEieypiO2WUt+bMj/+0b5aSndWVHf
         4zt5XNp6MsUuYHNJWlZOtYjBY5RtCxD+huzZeXI7cpeFqOLkSPqDZZHPZmNm7X1T5I
         /uI24ZcU0hmufRBAVflYY5ZV23b7i4MAfj/DbWaGPPZ2RnCMKqiN5paFqgRXJyo02U
         1tF8VcCt2N/JqYx2YRcwNvYUhPsIJ4HmzVZW17BT+QOExngjRH/bONK3hn4xuaH7zH
         AFh8nWBGjJT+mAk4T9zutTrY5DCarY119iMXUwWMHbK2zxQfzDbKx6C8vtsaf8uP5G
         KBx+nv+5k2g4g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bf5f4550006>; Thu, 22 Nov 2018 13:12:05 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id AB57113EFF0;
        Thu, 22 Nov 2018 13:12:08 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 422EA1E08D9; Thu, 22 Nov 2018 13:12:03 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v7 9/9] EDAC: armada_xp: Add support for more SoCs
Date:   Thu, 22 Nov 2018 13:11:42 +1300
Message-Id: <20181122001142.19187-10-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
References: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Armada 38x and other integrated SoCs use a reduced pin count so the
width of the SDRAM interface is smaller than the Armada XP SoCs. This
means that the definition of "full" and "half" width is reduced from
64/32 to 32/16.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
=20drivers/edac/armada_xp_edac.c | 5 +++++
=201 file changed, 5 insertions(+)

diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.=
c
index 3759a4fbbdee..7f227bdcbc84 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -332,6 +332,11 @@ static int axp_mc_probe(struct platform_device *pdev=
)
=20
=20	axp_mc_read_config(mci);
=20
+	/* These SoCs have a reduced width bus */
+	if (of_machine_is_compatible("marvell,armada380") ||
+	    of_machine_is_compatible("marvell,armadaxp-98dx3236"))
+		drvdata->width /=3D 2;
+
=20	/* configure SBE threshold */
=20	/* it seems that SBEs are not captured otherwise */
=20	writel(1 << SDRAM_ERR_CTRL_THR_OFFSET, drvdata->base + SDRAM_ERR_CTRL=
_REG);
--=20
2.19.1
