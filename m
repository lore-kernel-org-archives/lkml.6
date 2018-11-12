Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8A9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B515A21722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPHqYQNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B515A21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeKLRTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:19:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37765 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeKLRTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:19:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id p6-v6so3904192pll.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 23:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LQZrLz1FZpjiBQ4p0of1aJNeNKSIKiMbtxR/pc+1xGM=;
        b=XPHqYQNA/2L4+Frh7XTpYi8XulKm9Sp3A4D8PAG7zBZ2t6JGhaVEv/Ihog2kllHFeq
         94XQKruPk+8sOmwB1zpZsy8srBNgN2wT3shfvsXlwYh+/vvilT/0GppYVFDixnwOHBmO
         NuL9L/wNpXJoS82UWeyJijM2p+KbMvJtpshuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LQZrLz1FZpjiBQ4p0of1aJNeNKSIKiMbtxR/pc+1xGM=;
        b=UkYcKNfHjyP6qbMl0K1fEulaPQbBnP85u5fb3oYwZxwdUFDtEFPW5KKmldDk31XxnZ
         T1v5KwNa/7ITQpCiVvDnbd24rUejudMApCD3QWMtrJh2nj53vAfjWMKd5WA4PsMMWua0
         vwTBYHz7LhqjCWPIp06JQgGnZOTEXi5Rk9pjdnn/JFBuznfw2CchZSwQhBvubaXWuSeB
         0JwMs/7awl9XWM6OXtEmYGU300x048ppOMYG4XBGYm//MALcepZ0O337/OYlyVYNG7bu
         4R/qs3JTsa+HPzmkawD8ap6Q+7Im/vURADEpJvud/l3zMla6EwjPWBeaj7b7PIaSDHWM
         PW6A==
X-Gm-Message-State: AGRZ1gIPGRMmgUCShmUBcdBnOJYvZxppZDNHCB7IPHSuqmQ+byIC3NAF
        /apcgd5MPWgW5WHgR33TI2aJyg==
X-Google-Smtp-Source: AJdET5eWC4HlasJydR0O4pX24sPw8RI423kzzQRwGON0xIhLJjMyeoqGVAOx9MgKgyXU1/EYLFD3mg==
X-Received: by 2002:a17:902:d206:: with SMTP id t6mr3582020ply.193.1542007625118;
        Sun, 11 Nov 2018 23:27:05 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w2-v6sm18668331pfn.89.2018.11.11.23.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Nov 2018 23:27:04 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: sdhci-omap: Add example for using external dma
Date:   Mon, 12 Nov 2018 15:26:06 +0800
Message-Id: <1542007566-9449-4-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdhci-omap can support both external dma controller via dmaengine
framework as well as ADMA which standard SD host controller
provides.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
index 393848c..c73fd47 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -12,6 +12,11 @@ Required properties:
 		 "ddr_1_8v-rev11", "ddr_1_8v" or "ddr_3_3v", "hs200_1_8v-rev11",
 		 "hs200_1_8v",
 - pinctrl-<n> : Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
+- dmas:		List of DMA specifiers with the controller specific format as described
+		in the generic DMA client binding. A tx and rx specifier is required.
+- dma-names:	List of DMA request names. These strings correspond 1:1 with the
+		DMA specifiers listed in dmas. The string naming is to be "rx"
+		and "tx" for RX and TX DMA requests, respectively.
 
 Example:
 	mmc1: mmc@4809c000 {
@@ -20,4 +25,6 @@ Example:
 		ti,hwmods = "mmc1";
 		bus-width = <4>;
 		vmmc-supply = <&vmmc>; /* phandle to regulator node */
+		dmas = <&sdma 61 &sdma 62>;
+		dma-names = "tx", "rx";
 	};
-- 
2.7.4

