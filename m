Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D955C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A64B21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULyj4kvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfACUfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:35:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55077 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfACUfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:35:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so30353501wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DVQP9Si65CDhY5e0rJnF5Ch9hzreUmDte/QPQ6tm0Nc=;
        b=ULyj4kviKHrh4ICShGCNngSdy94+/SsVhUSoAtwKo2sirP0Pq5187ar9Zucb+i0bln
         IsxNSbLzshQLVjXQNUWkDLKKqtYabsG/jyC3ABcOfY71czBbnDnXfbQPrp3zzkDjY7zW
         h7FnbMEdVA496nXdab9xMKkCcG1FxrQGeRWgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DVQP9Si65CDhY5e0rJnF5Ch9hzreUmDte/QPQ6tm0Nc=;
        b=AbyURERbSXvVal/K2AfBOe6u3Y3kDRQZdrrYe/zgr1yIutkET+/0uAmp+lLmhXKWjf
         PdbFBmFR3y9m0OKacFvv+6N4XZr8jFJukEV37HdrE+i6+RT9TslMMv2zNTisCyz3n6Qg
         rU02wEtffhZbknzjpOAdYY7SQ3kRMHlat/Alrl2G0gbJwPB1SPzUtLF3fDXMgHJ5AMly
         NgmlnxqwjzeKVLBZNzWp27DmqzQ4MvpSFh8XL5YW2WhJuhv+ng1OMqZQCsGxMqqnEwXT
         VOl7se8cW5fxUTDGDR+zEUinYxua2tCPvcL0GLADZ/gvKnn+AwAyFxTPzjl+hkvNa+Vy
         olBw==
X-Gm-Message-State: AA+aEWYKUtvvnr41KuC+YIk9rHobyRvITJHIJGEXNm5Be2Sn5Bihrb5L
        UhJDpnD+kzRJo2EOwU85Qa+cOw==
X-Google-Smtp-Source: AFSGD/Wayh9oW+9o2J8QIf0tR62Y3cd1/Y850iDl54dv2JgYIBi/KZabvAbFzO4CvWn6np06nhvADA==
X-Received: by 2002:a1c:b607:: with SMTP id g7mr40981127wmf.97.1546547699145;
        Thu, 03 Jan 2019 12:34:59 -0800 (PST)
Received: from localhost.localdomain (92.red-83-34-185.dynamicip.rima-tde.net. [83.34.185.92])
        by smtp.gmail.com with ESMTPSA id 14sm83635500wmv.36.2019.01.03.12.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jan 2019 12:34:58 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org
Subject: [PATCH] arm64: dts: qcom: qcs404: sdcc1: enable HS400
Date:   Thu,  3 Jan 2019 21:34:55 +0100
Message-Id: <1546547695-15345-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The controller can support EXT_CSD_CARD_TYPE_HS400_1_8V cards.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index a39924e..2c2c9b0 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -127,6 +127,7 @@
 	status = "ok";
 
 	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
 	bus-width = <8>;
 	non-removable;
 
-- 
2.7.4

