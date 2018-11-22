Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EDAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2892C2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="k9la+vKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2892C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390840AbeKVKsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:48:51 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36656 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390785AbeKVKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:48:50 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5556589158;
        Thu, 22 Nov 2018 13:12:07 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1542845527;
        bh=n51SL/YmzPg7vRBQ7CrnlxwLGtYG3UyWpyFXNCOkfm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=k9la+vKbYMpIsIL1IzBOqof2k7RXjC/YZuGsRrPwLzmkLyzDj0xRPSoYrtdJFcWPC
         zLn0/USCm8j4Wxs4IDTl+yeKJIYm95v9TFbwcWzK+Rp3i05vZa2vnKhZBRa+5iM2TG
         X1qsstsFd25Ap40WQHqFWx1aUQBKQXHp/Dwk9bw+JS/G5p6IOKiRuHH/bi+5luj2K7
         xyWpA/KGQcQeq4u1YudLfXQxjk/vO+lAneQqm7UXFkOrABiNnjlwBERU1R2d16gfC+
         D24gwXT9s+OWVktksZRnILOJGItB3RzM4cwst4+CeSt3BL0uFJIGSEeEo2e131GBVA
         u8npLeTq7FdUg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bf5f4520001>; Thu, 22 Nov 2018 13:12:07 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 8BED413EEF0;
        Thu, 22 Nov 2018 13:12:07 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 240A91E08D9; Thu, 22 Nov 2018 13:12:02 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v7 1/9] ARM: l2c: move cache-aurora-l2.h to asm/hardware
Date:   Thu, 22 Nov 2018 13:11:34 +1300
Message-Id: <20181122001142.19187-2-chris.packham@alliedtelesis.co.nz>
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
