Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FB2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7143E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBDFvHX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeLRDm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:42:57 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38256 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbeLRDmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:42:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so7158215plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
        b=YBDFvHX7AiucyPS8BT+C9ypYixQsdfJG7w9Nw/JM1sLJJBbysciZj38Z7NbumJjmEb
         Zikib+uZNRRj8XAUHEFg6sQ+1yZbNOphofHiQavO4CeKVEb+FhcCnHL/mTqjVwpfNRtV
         kUlMAkNyD3vs80tduMbIGmsdT92ra6ei0ckCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
        b=sEtFs0bm3pLsB7flkWCyq6A/dGKBkAdfnPbhLvvcMQmatNchUHHGruJ4A0A/CodD0E
         CwdT/VLJewI234k/dYCF+8Go0BSghl1/q7ZvyzbCk7LveIVk6MAXcXuxpeUKmYxSXgnb
         69Z017dQRHdSAUp1bEl6LdAJ6GwX2ss70VMBre2lGdiXBnF3DQPAbbzwbeufP+1DaDuf
         7htIgacQ3FHC0FMv1b6iIs0Al8EPt+W58t+fGcl+XxoDWuuoETfWiqAYy9b618XC5KhZ
         tmr03VfZBdLsBY+YjngICDhyXcntoBwqZrhw9Gs9GFYsUv4e6M39yS5mddMdMgWDWgr2
         661g==
X-Gm-Message-State: AA+aEWY1Wi7d1djbqtHRMYDGnb+sGTFCDNqjhlyfEFPHBGd9R04thcfC
        0NXF+Nusj1GppVj8vBwzD4BU
X-Google-Smtp-Source: AFSGD/XHItxOIu1KkoZQlSL6eFA4WYQq8HdFiNJ7nJINZBrDQhCI33qZh6eC7nwl7lgfYaQ7/DXApQ==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr14993867pld.236.1545104573365;
        Mon, 17 Dec 2018 19:42:53 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 19:42:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 07/11] ARM: dts: rda8810pl: Add timer support
Date:   Tue, 18 Dec 2018 09:11:28 +0530
Message-Id: <20181218034132.5070-8-manivannan.sadhasivam@linaro.org>
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

Add timer support for RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index 15547b138977..84baa4c0a14c 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -6,6 +6,8 @@
  * Copyright (c) 2018 Manivannan Sadhasivam
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
+
 / {
 	compatible = "rda,8810pl";
 	interrupt-parent = <&intc>;
@@ -50,6 +52,14 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x20900000 0x100000>;
+
+		timer@10000 {
+			compatible = "rda,8810pl-timer";
+			reg = <0x10000 0x1000>;
+			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+				     <17 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hwtimer", "ostimer";
+		};
 	};
 
 	apb@20a00000 {
-- 
2.17.1

