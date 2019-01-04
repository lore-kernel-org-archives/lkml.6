Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127D7C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7C82184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfADBks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 20:40:48 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38811 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfADBkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 20:40:47 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so38987089qtl.5;
        Thu, 03 Jan 2019 17:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=wT9chDbjHabejsC31dm/LWr/Az0apw1XM1hEQNEg7GQ=;
        b=UENiIm6aRMd6veK+D78ZIZ7rxXVK4DxulGqJM9KIWbMTlAZHyCPvwz/vvmz+fxhx9B
         FiwLdX+f3K8kjGdrESK0h4RiOQNMgiq/Hzzn3pIOsXfFoiHLqIDDiW2gnUeFqjDDg7e3
         ++afx/YkER7VgOjEVoRdRxUhN3LJdnZ8Ijde8f2IWjj58HNGwBMbhcAJbXfCgZNJdlM9
         CxJ0A2KcLfbaPG6t95KRpSYBXJ3WHd6WCabsyFvag/N5mFuc5OqhzulToFGqc7OdhR1k
         iLLlsArKM2+3S7hMNJPrky9R0ebI1ZaZaGTIcbkXg0nRKDHURSWrxOUlaDFYPGoeAXs9
         47ww==
X-Gm-Message-State: AJcUukc3vqvejwpxuPoJiuEnOhPzfkLar7GyuczzysFTodK/iQQ3fzDp
        ePaUE1BcrtREWBnMsjmQOyxpMoBd
X-Google-Smtp-Source: ALg8bN5VqXa/bLXMWeIuMaIsPlIKOYFrNEeOfPegytnjMSwQGZ2G8ZZMgvOeWWPVXiEWjFTYLQr0UA==
X-Received: by 2002:a0c:a90a:: with SMTP id y10mr47631078qva.232.1546566046602;
        Thu, 03 Jan 2019 17:40:46 -0800 (PST)
Received: from localhost.localdomain ([181.220.84.254])
        by smtp.gmail.com with ESMTPSA id z207sm23662928qka.57.2019.01.03.17.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 17:40:45 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 03 Jan 2019 23:40:38 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Jason Zhu <jason.zhu@rock-chips.com>,
        Vicent Chi <vicent.chi@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/4] ARM: dts: rockchip: Add missing dma-names SPI support for rv1108
Date:   Thu,  3 Jan 2019 23:40:20 -0200
Message-Id: <20190104014023.17973-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the 'dma-names' property to the SPI ports so that DMA can
be supported.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index d31370ff28f4..cb26d9d98c34 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -207,6 +207,7 @@
 		clocks = <&cru SCLK_SPI>, <&cru PCLK_SPI>;
 		clock-names = "spiclk", "apb_pclk";
 		dmas = <&pdma 8>, <&pdma 9>;
+		dma-names = "tx", "rx";
 		#dma-cells = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.20.1

