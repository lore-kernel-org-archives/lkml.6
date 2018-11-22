Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2282C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2F020870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="HK5nKTL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2F020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390767AbeKVKst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:48:49 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36599 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388436AbeKVKss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:48:48 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 701328365D;
        Thu, 22 Nov 2018 13:12:05 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1542845525;
        bh=mTaA5V5SDbaoUTifccvwBOpV2UZw2RIkrTYYv2E8CzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HK5nKTL8+Ve+Yhkba6u786dkA9gWYtBcdloH8Z5Sr9CiXoqDfjOGb7jTJ3L285kVx
         /UujElM9bRCqYQxtank5Uyz3UEy+k5VeGjofnHOR0beaetrEAS/boRxtVr6gwSA1I/
         FMFn3+XTbLYTexgBuQx0VfE0OGCK9DTwQrJ+d3WPLjr1r5QtWZWx0KJbFPlm12xxau
         OLWTqKHN4+39NJQstg28Ig7jdqQuUrr1GT1hghdo5RLnWXeyANO3hKxm4s1G+FpZfY
         e9eiI2aq/4Pp73yITCDN/thtslOnMFQcEsDSELEuIE/xqTLiIiYMMbr71YS6dI508+
         fbhsaT7f1dweQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bf5f4550001>; Thu, 22 Nov 2018 13:12:05 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id AE5C413EEF7;
        Thu, 22 Nov 2018 13:12:07 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4665B1E08D9; Thu, 22 Nov 2018 13:12:02 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v7 2/9] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
Date:   Thu, 22 Nov 2018 13:11:35 +1300
Message-Id: <20181122001142.19187-3-chris.packham@alliedtelesis.co.nz>
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

From: Jan Luebbe <jlu@pengutronix.de>

The macro name is too generic, so add a AURORA_ prefix.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
=20arch/arm/include/asm/hardware/cache-aurora-l2.h | 2 +-
=20arch/arm/mm/cache-l2x0.c                        | 4 ++--
=202 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-aurora-l2.h b/arch/arm/i=
nclude/asm/hardware/cache-aurora-l2.h
index c86124769831..dc5c479ec4c3 100644
--- a/arch/arm/include/asm/hardware/cache-aurora-l2.h
+++ b/arch/arm/include/asm/hardware/cache-aurora-l2.h
@@ -41,7 +41,7 @@
=20#define AURORA_ACR_FORCE_WRITE_THRO_POLICY	\
=20	(2 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
=20
-#define MAX_RANGE_SIZE		1024
+#define AURORA_MAX_RANGE_SIZE	1024
=20
=20#define AURORA_WAY_SIZE_SHIFT	2
=20
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index a00d6f7fd34c..7d2d2a3c67d0 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1364,8 +1364,8 @@ static unsigned long aurora_range_end(unsigned long=
=20start, unsigned long end)
=20	 * since cache range operations stall the CPU pipeline
=20	 * until completion.
=20	 */
-	if (end > start + MAX_RANGE_SIZE)
-		end =3D start + MAX_RANGE_SIZE;
+	if (end > start + AURORA_MAX_RANGE_SIZE)
+		end =3D start + AURORA_MAX_RANGE_SIZE;
=20
=20	/*
=20	 * Cache range operations can't straddle a page boundary.
--=20
2.19.1
