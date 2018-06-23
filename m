Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C7C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 05:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A5924B36
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 05:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBujvk14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A5924B36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeFWFAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 01:00:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40604 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeFWFAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 01:00:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so4100125pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 22:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dLCqypfp2r8AtJ6hMHpArJX54Bn4+lTKKs0nDLyZBDY=;
        b=aBujvk14pMuyo20jIloc3GKOS9yJyMs0btOnsrSdW/ht/xdZndnxZB93Ns9loZ1OXL
         w71pONmdk3clHFbAcka6SAi4TUbLYdR03X281NMcgutTRD63OsSCUFO2MshY3JdFC4Z5
         Fmp5N3JSjFyq/4Ei0D6CdtB2wOKEw2N092kDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dLCqypfp2r8AtJ6hMHpArJX54Bn4+lTKKs0nDLyZBDY=;
        b=ssRqcns3VU+oOJANPOPPO5bl7J0ArH/Nd2WXG4SdWuCW4tZ29s0FxQgYSyEpAADBmJ
         4iC9LcPVlnRXXUzAEfZchT6KKhDgIG+HpPu40WVCqlxyfe7UFxFdVdOguIrIh/bmbsUJ
         7YRE1Guny/zdtouw7H1MG1WaI/tSvBraPP0nQo0e6Z/qV80cBBUypqUY2hBtS1rqU2kg
         32r8NJq/oDiwJArif5O+seyntVMPvOxqQIxap7CkScHRnKZoOXtmCRk+YyhxCIHqyw4S
         ESDOH1YdTyVcfdDZ+LiYo9e0OeugA1/+i+Uyu2UKEpdU1kP35etk1xq33GvPafSoptqk
         elHg==
X-Gm-Message-State: APt69E200SONsFgbQGoUNBi4iwvR6LoAe8ScOgvrTqEZ5yJqrBdkDku9
        QVd4PoMQt02SwqPTsxAceze8
X-Google-Smtp-Source: ADUXVKJppEiUYLmoOazPrgvObir2aqdRSLRSbl9TQY3Rsc3yyxC+/BtzbQUoG3cXjrfR/7wga4y5TA==
X-Received: by 2002:a63:7d1b:: with SMTP id y27-v6mr3642112pgc.418.1529730039341;
        Fri, 22 Jun 2018 22:00:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:70c3:aca:6549:5166:32c7:2dab])
        by smtp.gmail.com with ESMTPSA id y14-v6sm10787603pgv.37.2018.06.22.22.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 22:00:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc:     liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/3] arm64: dts: actions: Add interrupt properties to pinctrl node for S900
Date:   Sat, 23 Jun 2018 10:29:53 +0530
Message-Id: <20180623045954.6729-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180623045954.6729-1-manivannan.sadhasivam@linaro.org>
References: <20180623045954.6729-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt properties to pinctrl node for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index aa3a49b0d646..7ae8b931f000 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -181,6 +181,14 @@
 			gpio-controller;
 			gpio-ranges = <&pinctrl 0 0 146>;
 			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		timer: timer@e0228000 {
-- 
2.17.1

