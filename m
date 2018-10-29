Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B401C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224742080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="1BL5M7Is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224742080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeJ2QNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:13:25 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51822 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbeJ2QNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:13:25 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D87F9886B5;
        Mon, 29 Oct 2018 20:25:53 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1540797953;
        bh=n51SL/YmzPg7vRBQ7CrnlxwLGtYG3UyWpyFXNCOkfm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=1BL5M7Is/gwA1Ih2nz75rkZpcFEKHixYaRcbd7bAarBZeAvqx+Zim/o+y8KWC2MHD
         1cmkXOXTzf+WpLJ4M1IqIbEbrhLK9dLuO8rKH6/djCJSFOmPJKZUoqBCDnEoXqRqP4
         w8ge00nrPHc/8UjwKS+8zIpC+jS60P4EzQeXcJhMh7re7gmfgS240QZ/QiueY0sU3Y
         DkF5ODXrGItjkxi0AJjBCNUPYCK3D0HW1jhXS5P7ys64GTgTByNNQgP1mzPNXnn6kJ
         9S0oyz/l6MQ2fz10OK3ZeVon1Qtsk+QI7ih0OzL/gx0pJE10O4Ur/M6djdsGTTquD1
         KLqIQy0ByRS6w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bd6b5fc0001>; Mon, 29 Oct 2018 20:25:53 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 39A6C13EF0F;
        Mon, 29 Oct 2018 20:25:53 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 605901E21FF; Mon, 29 Oct 2018 20:25:48 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk
Cc:     u.kleine-koenig@pengutronix.de, jlu@pengutronix.de, bp@alien8.de,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 1/8] ARM: l2c: move cache-aurora-l2.h to asm/hardware
Date:   Mon, 29 Oct 2018 20:25:28 +1300
Message-Id: <20181029072535.31667-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181029072535.31667-1-chris.packham@alliedtelesis.co.nz>
References: <20181029072535.31667-1-chris.packham@alliedtelesis.co.nz>
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
