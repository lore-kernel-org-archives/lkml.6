Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E380C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBE420874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tm6g49O+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeLRDmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:42:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42576 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeLRDmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:42:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so7124818pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cmd8SlBcQNfIa1nb8LLATghfQmGnWfI4U+QKliynNZE=;
        b=Tm6g49O+RRHfWZtvubic6SeVrt2fHUwKabPBv2ob0nb1OM6kshsILlg1evZ47yCWU9
         aARGR82ToU9h0ElUCinl+FVOIc3mdIRR1M5AaN13IB+ZRVa8vRXFBOGZyixULa4H3vNh
         KdciPI06/UK9CWYU7QgIUdACSJNgFhbOTtbeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cmd8SlBcQNfIa1nb8LLATghfQmGnWfI4U+QKliynNZE=;
        b=Hp7FUnkcs+pui4Yd6obZtzInn94jXLkfd2cq7EA7iwAXL/q6qS5wtxkcwRLrs/72dz
         IUN5drIa5GpZtA7wMUxvMC5rNF5j6SvE/VddRQw87rd+B+Tl0x9tDhvHmuXGeZQcaEZX
         BRtS02CvXHZ2cw5CUgiPMtTlRBNPntvf92/OfSe5i123xvPAg1XPTche+GFHp+1FfERY
         6Scu3hIFDaW5DOiIw0VfS5qtt7E5zhWM9SYluKSfMHiFU8iipkBkQikUfpPRe+6qFyaW
         /Iv98l1PNkAWNew408FinepzwppIvPBNGEepcClPAIzZMepN6JXkBX0ZtnqaHQlVcG+9
         gGXQ==
X-Gm-Message-State: AA+aEWYsR64HWxNXc36kjiDGCyGIrcfkTkfsHMSPlBvfPP+ll7CQsxPZ
        U+dDiNkVXKAiajfCnE9G/HIv
X-Google-Smtp-Source: AFSGD/Ub6mPRKxF/E8ahh/Cn2J27S0hcRX1HDhxBahENNulVpIPMcfaFpFnGBqiavjWWyZ01AeOdOA==
X-Received: by 2002:a63:6b05:: with SMTP id g5mr13961670pgc.15.1545104535506;
        Mon, 17 Dec 2018 19:42:15 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 19:42:14 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 02/11] dt-bindings: arm: Document RDA8810PL and reference boards
Date:   Tue, 18 Dec 2018 09:11:23 +0530
Message-Id: <20181218034132.5070-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
References: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add bindings for RDA Micro RDA8810PL SoC and below reference boards:

1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/

Cc: zhao_steven@263.net
Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/rda.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rda.txt

diff --git a/Documentation/devicetree/bindings/arm/rda.txt b/Documentation/devicetree/bindings/arm/rda.txt
new file mode 100644
index 000000000000..43c80762c428
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rda.txt
@@ -0,0 +1,17 @@
+RDA Micro platforms device tree bindings
+----------------------------------------
+
+RDA8810PL SoC
+=============
+
+Required root node properties:
+
+ - compatible :  must contain "rda,8810pl"
+
+
+Boards:
+
+Root node property compatible must contain, depending on board:
+
+ - Orange Pi 2G-IoT: "xunlong,orangepi-2g-iot"
+ - Orange Pi i96: "xunlong,orangepi-i96"
-- 
2.17.1

