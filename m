Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92441C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580D620989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyNKRWAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580D620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbeLFHby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:31:54 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:34591 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbeLFHbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:31:51 -0500
Received: by mail-pg1-f182.google.com with SMTP id 17so10269489pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 23:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/QmRvqqSNqT4d/eAE++l7YofJ1lKOQigAYWENYxaOI=;
        b=IyNKRWAOr5pKVwfoTxXwpzLr0QwRJE9m2q2Okjf7QAhtCPDe7rf+vHWY0KsWee6qmX
         UPFvnIfy/9G7oQyLDozZ9SCYvoO9QvrebssBDi+yZX+8kKWjaKJNMQVN6K7qkp6o4ctE
         XI6o47yWEwaim6rY2w2Nx4O5vQvQngkW6A/jNfwEnDSFkXDLGCDSDAae/oRA63pAU/F2
         HaiFthRVORTvkyCn7Mv/RICBXbYbu3JNMtsBqJx9YB/Jlvkt1EJFu/IrWIpPxa9Lzx+H
         fqiprcSBzO7Qfh+N2zcT9kpEaG1INfvNKNSK6JuPZDjSaZAVBn50FaKUPVZBiXAUkqHQ
         GzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/QmRvqqSNqT4d/eAE++l7YofJ1lKOQigAYWENYxaOI=;
        b=Dep6oTjCHTWuy/D1j5KKPGuU0HLYon6OCtptWEKac29Oka+2xPffREZZLYFKPel1Rw
         oJWu0nv9IH8TJWJSpfk9DLfC3dyVvJh+YoM3Jkes228Zcor5cAZbjrN8a15rC8rZ3ui7
         HDlKiQfRdq+8w/JMtyW3/2uTRgZZvEAWja20ALzg/CEQ8iRTZKHIquO4qaZBvcCbO/fy
         enI6kX9/HBAxgJM/c1Pe6IFFum8NRwCAwzUtxTgooQ/PBb8QlWBMlVjjY4rs85w7PfMH
         GI1D3Ugg6o6pWiXOkHgHgB1E0go7EeU43gB/BO48TxwtIvJJvPE3rS+UVuUrI0hBOXdl
         f9/A==
X-Gm-Message-State: AA+aEWZQXbG/Ys5aQScb2nUGj9SWMSIzXbLNVvnh7HRGwfT6OyyYyzzJ
        EGf1PycjCLAPV0mdz2ArBtQ=
X-Google-Smtp-Source: AFSGD/Wa9mdeLmI7KZDw62UJwvBDn8ds+J8+PLv/7me8kzkLfxM4Oci/hajdzDuDlHuQsGYx7Jp98g==
X-Received: by 2002:a63:1f4e:: with SMTP id q14mr22251175pgm.88.1544081510018;
        Wed, 05 Dec 2018 23:31:50 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o8sm55023141pfa.42.2018.12.05.23.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:31:49 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] irqchip/irq-imx-gpcv2: Make error messages more consistent
Date:   Wed,  5 Dec 2018 23:31:24 -0800
Message-Id: <20181206073125.7255-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073125.7255-1-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make error messages more consistent by making sure each starts with
"%pOF:".

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 077d56b3183a..c2b2b3128ddd 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -212,7 +212,7 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 
 	cd = kzalloc(sizeof(struct gpcv2_irqchip_data), GFP_KERNEL);
 	if (!cd) {
-		pr_err("kzalloc failed!\n");
+		pr_err("%pOF: kzalloc failed!\n", node);
 		return -ENOMEM;
 	}
 
@@ -220,7 +220,7 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 
 	cd->gpc_base = of_iomap(node, 0);
 	if (!cd->gpc_base) {
-		pr_err("fsl-gpcv2: unable to map gpc registers\n");
+		pr_err("%pOF: unable to map gpc registers\n", node);
 		kfree(cd);
 		return -ENOMEM;
 	}
-- 
2.19.1

