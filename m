Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED2BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E2520672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E2520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeLFKJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:09:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41447 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:09:24 -0500
Received: by mail-qk1-f194.google.com with SMTP id 189so13670051qkj.8;
        Thu, 06 Dec 2018 02:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=ydbINwojpYRSXY/r/4xdFQC3b7eWc6o2T8B/MVbGzqg=;
        b=K2J6oNKms4WZ9jhDVNw/YJULAeDNAtssPXClA2VWhGW33VWexfb10qtUeA7q03UV1T
         X72kk/EzJbLF89L9BAY0Ya9JgtTtAiHVy9LvOboLtLcAcmKM775UMLHm3tsPNbLDw/N6
         hxE8lwQEKZ4jowwxxA334+DcrBlldkaKdzLN+iwMMKYIfgmFLFvE51feNZKBSWfmHVIr
         euFYhk+olnlbMF3jpCdZfPKEQUFJInvMyynfuzejoROX74fiK6rj33Du9PF1ovBIOevr
         H7I51jV3bgRQLMk42pH5bKEFe+J+e43kZvp270zyd+Ul9/vWGlU40MSeSjBV3ZAaz+mp
         lPXQ==
X-Gm-Message-State: AA+aEWYiQG9WH3rx990fUQGaKnTzW3y1ccBRyeObaI0/bRTcRKBIYyW6
        JcCVrnl3nPcO6d5ZNax4aaE=
X-Google-Smtp-Source: AFSGD/WetsjPRoF/iNM53Ts96TKT9tS1KQKgLlwX3lBOVgnV3f3DHpM1cr3sqK6DgjgL726q+pzJ9A==
X-Received: by 2002:a37:4f8a:: with SMTP id d132mr25033506qkb.17.1544090963145;
        Thu, 06 Dec 2018 02:09:23 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id k6sm16111395qtk.41.2018.12.06.02.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 02:09:22 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 06 Dec 2018 08:09:15 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 1/9] ARM: dts: imx7d-pico: Do not harcode the memory size
Date:   Thu,  6 Dec 2018 08:08:57 -0200
Message-Id: <20181206100905.15053-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

Currently the memory size described in dts is 2GB, which is incorrect.

There are 512MB and 1GB versions of imx7d-pico boards, so remove
the hardcoded memory size and let the bootloader pass the correct
value to the kernel.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/boot/dts/imx7d-pico.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 934a019f341e..0df68e53e9fa 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -48,9 +48,10 @@
 	model = "Technexion Pico i.MX7D Board";
 	compatible = "technexion,imx7d-pico", "fsl,imx7d";
 
+	/* Will be filled by the bootloader */
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0x80000000 0x80000000>;
+		reg = <0x80000000 0>;
 	};
 
 	reg_ap6212: regulator-ap6212 {
-- 
2.19.2

