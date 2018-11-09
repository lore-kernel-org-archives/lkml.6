Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36148C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DE920883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="PCuy716V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DE920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeKIQnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:43:33 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45795 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbeKIQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:43:31 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9445E8781F;
        Fri,  9 Nov 2018 20:04:15 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541747055;
        bh=n51SL/YmzPg7vRBQ7CrnlxwLGtYG3UyWpyFXNCOkfm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PCuy716VSMcaHT42h5qVifiveQY+kVgT3x5wGajH0LJMUnQPcdgvXyhNpNovpOyme
         haFmm2uItYAEUuPSkpTcXyHV2UbIGIAcwDM1cmBjJvj8s91Tawyz7pfL6DnvalpL7w
         QkvZTUrqwRv0WNZjptapqJ0wQMctSVRRJy3j1He7781YUqXmzDSS2k/Lh63ubIEks+
         y1gUol72Xfh3Xi4FfPeigCY1305RCTzlJ2pYNR1ZxgL5xC0LT9JPgk8DdU4Rs60w1R
         xEetFGHy3pO1tkTQ0casYnPVDQACENMEMRF3iFsvkizkxG6Kg3PF1FH52oE3INach9
         kQQ+hxTScR4vw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be5315f0001>; Fri, 09 Nov 2018 20:03:59 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 3CECF13EEA1;
        Fri,  9 Nov 2018 20:04:04 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 180F11E0BC9; Fri,  9 Nov 2018 20:03:59 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 1/9] ARM: l2c: move cache-aurora-l2.h to asm/hardware
Date:   Fri,  9 Nov 2018 20:03:41 +1300
Message-Id: <20181109070349.20464-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Luebbe <jlu@pengutronix.de>

This include file will be used by the AURORA EDAC code.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
=20arch/arm/{mm =3D> include/asm/hardware}/cache-aurora-l2.h | 0
=20arch/arm/mm/cache-l2x0.c                                | 2 +-
=202 files changed, 1 insertion(+), 1 deletion(-)
=20rename arch/arm/{mm =3D> include/asm/hardware}/cache-aurora-l2.h (100%=
)

diff --git a/arch/arm/mm/cache-aurora-l2.h b/arch/arm/include/asm/hardwar=
e/cache-aurora-l2.h
similarity index 100%
rename from arch/arm/mm/cache-aurora-l2.h
rename to arch/arm/include/asm/hardware/cache-aurora-l2.h
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 808efbb89b88..a00d6f7fd34c 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -30,8 +30,8 @@
=20#include <asm/cp15.h>
=20#include <asm/cputype.h>
=20#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/cache-aurora-l2.h>
=20#include "cache-tauros3.h"
-#include "cache-aurora-l2.h"
=20
=20struct l2c_init_data {
=20	const char *type;
--=20
2.19.1
