Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC88C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC8F204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fmxZV8Ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC8F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeKERHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:07:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32790 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeKERHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:07:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id q5-v6so3846581pgv.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 23:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GMamYhMEle5zZRUIf2BW/VRpXWPE7SAmpDCvvm5fmss=;
        b=fmxZV8EivFc6tMqWgoH5DCh1kjiuYNZMKQRc4quu/86Wh7Iur7KKE53qldYyIee2mm
         ta+d044h7EXLeedFZ7a8xOtIEkDF26I5KP8Kto649jmGRbJT3ZIrBNGehpQdzJWXIUEI
         f99BuoGD30T9L4jjH8S7lEGAWp5spgd76wkjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GMamYhMEle5zZRUIf2BW/VRpXWPE7SAmpDCvvm5fmss=;
        b=U2otz8gw+OnFzzTwdetpzV7gdlbH3w6RPI38mjxLWLM4zcKobPmN/BGZVg8/jllpyf
         n4Et1MZ+ZwxxiPK6YE25L69Ug2y+XbQHP8uKVOJF3oOGKSApL7NVzuFHLdV++KIUVnvy
         cdTEPXaFkL/d1IX7iFaf9LUn+wFsezbAyWJFyw6BNbw8J6PlMbpy9pFgprLzfI9ONRQN
         sNCyannATJxdJ1MOEAKit3hTx3iaB4Afxeo7sn1vjoscTmiJyJ26ChvRLOczHMGsngxh
         d/cDXwVYc89IpZSLA49W6bSu76+hNoJEFN5b+xM8KMKm6crGyrk4SrKuMJo+3x3L9Z1V
         9tuw==
X-Gm-Message-State: AGRZ1gJb+NbIHZ5ZCKHhOwdOYRjvZPeaA1BCt3qDaOS3kBe+QMnCS3IY
        c36gUAdvq5etkRTZcvEILLHFbg==
X-Google-Smtp-Source: AJdET5c9hXAbw7HtfKN5cVpK67Jarr05cpGFCab5CK0IMijp+7I/sQ4hns6dfWbr4tIppStjYaJyQw==
X-Received: by 2002:a63:a001:: with SMTP id r1mr19383019pge.268.1541404138738;
        Sun, 04 Nov 2018 23:48:58 -0800 (PST)
Received: from localhost.localdomain ([2405:204:638e:987d:4588:e264:3e7b:ee8])
        by smtp.gmail.com with ESMTPSA id n189-v6sm14790630pfn.163.2018.11.04.23.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 23:48:58 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/3] clk: sunxi-ng: sun50i: h6: Fix MMC clock mux width
Date:   Mon,  5 Nov 2018 13:18:40 +0530
Message-Id: <20181105074842.21988-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MUX bits for MMC clock register range are 25:24 where 24 is shift
and 2 is width So fix the width number from 3 to 2.

Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 2193e1495086..e2bc612f1d3e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -411,7 +411,7 @@ static const char * const mmc_parents[] = { "osc24M", "pll-periph0-2x",
 static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0", mmc_parents, 0x830,
 					  0, 4,		/* M */
 					  8, 2,		/* N */
-					  24, 3,	/* mux */
+					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
 					  0);
@@ -419,7 +419,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0", mmc_parents, 0x830,
 static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
 					  0, 4,		/* M */
 					  8, 2,		/* N */
-					  24, 3,	/* mux */
+					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
 					  0);
@@ -427,7 +427,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
 static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
 					  0, 4,		/* M */
 					  8, 2,		/* N */
-					  24, 3,	/* mux */
+					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
 					  0);
-- 
2.18.0.321.gffc6fa0e3

