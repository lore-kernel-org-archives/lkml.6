Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C39BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E0620879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fiGUbUhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfAVFv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:51:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36123 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfAVFv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:51:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so10531321pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 21:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aQfgLHGyafHU7tICKZQbQ4yyQ9JsXlWjf2VqfyIq9Jw=;
        b=fiGUbUhb9l2DipnjkvZ0h2+2b9iVpp69SCrJkHXzAqLeHidpciQw8velfCQwBOB1zm
         afq5WAq5+uIzHJbQgT6rVIpdAc9y9IidtdJqKVhH7itqEEUhkQGP0cQOQHZYGNql8ArR
         Ja8XOZLgFpyqOSgbthbawW5eneAdOq7Pi9KIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aQfgLHGyafHU7tICKZQbQ4yyQ9JsXlWjf2VqfyIq9Jw=;
        b=IscFwuJTkxTi+WRuA2M98HOf0s/ja3MNcXE5cOX9fTnDqBKxvWCZgaO8BRL3EddLp5
         ccAXyZUaM9JJhGiqfSuU3cosplI+u1HRopvQ4jV9ZdF96myrkKk9cWga09EQl8by6uwP
         v2nrxlOHKEieQiatCNdVWZvmn+RQjLUyC6cHhrfhchjgI3lDhs8YKivi/aSl3ZKTG8jk
         xMo3JXfmqT39xOsq2jfFXX6PQZXkTvNk5z8TNb+THexdUxFLFc7yWvZuGSZkmw2YRZN9
         s4w2GlX5sXmqn92J5wiDIBtNZgOjtuWQV7+n1SCTTDfVlzh7D8bvTc/dQim6+4Acb6qH
         inKg==
X-Gm-Message-State: AJcUukfdLSxGYyvdLYL8erpf0+uP+rne9gdecu8SrCr769dayUrlKeL1
        Oo4jif707hjmU7e1EOuV06EMmg==
X-Google-Smtp-Source: ALg8bN4Y6v6Bu6nMswZhdAyn+EbeFHnL67poESjxYF4CgBdqoKPZFrGRZ79H8LaM4qk8bnzNQEk88Q==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr30197186pgd.110.1548136316194;
        Mon, 21 Jan 2019 21:51:56 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z62sm23771572pfl.33.2019.01.21.21.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 21:51:55 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] arm64: dts: qcom: Add AOSS QMP node
Date:   Mon, 21 Jan 2019 21:51:11 -0800
Message-Id: <20190122055112.30943-10-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190122055112.30943-1-bjorn.andersson@linaro.org>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS QMP provides a number of power domains, used for QDSS and
PIL, add the node for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- New patch

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1033b77856e6..5cc2615461da 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/clock/qcom,videocc-sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
+#include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
@@ -2070,6 +2071,15 @@
 			#reset-cells = <1>;
 		};
 
+		aoss_qmp: qmp@c300000 {
+			compatible = "qcom,sdm845-aoss-qmp";
+			reg = <0 0x0c300000 0 0x100000>;
+			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&apss_shared 0>;
+
+			#power-domain-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c440000 0 0x1100>,
-- 
2.18.0

