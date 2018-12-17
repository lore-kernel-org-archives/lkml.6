Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC22C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F0B20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMkC5urK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbeLQJq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:46:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55870 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732200AbeLQJqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:46:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so11568288wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xY2V4sBj5Ds3+SQmdTspSIBla6JHASTE6hEmXoXtqtk=;
        b=hMkC5urKEck/zn5xSgMuam1rniWk/yQbP4srf4MLONnN9Z6SsKDuVHSY9Zw4tdfAws
         QMGRwRY5tU3zqgRXgGdeb9F5lnl7Cf9rXo7E4dBhmnlHdDxnfVFUOtbhk0tKXYe7GBCN
         dxipQAVzK5xuZEKt97qd3h7gvGGRoSdY0Rh0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xY2V4sBj5Ds3+SQmdTspSIBla6JHASTE6hEmXoXtqtk=;
        b=P7LWxMBQ+/TOkPbaOOpDIfPHl2I2xpfpgZIMlFg+BVfUb2WjmYCxaB2mVEF1/+kSsr
         c951vWhU6HMln9cp75RB6J5pwe3RADhLQbgOSjv+/aKyX8O7vUskrwV7ns2kSToah5ux
         gxvmzB49u6/jDwVeNLzm728n70TbYvV+wq1ihJrpQYRlO4s5P27q5AIUnqd5YI3mhTr8
         +sOf4upvhBRUmJaQcX6HsYJVXNKKa6fG7sQpGLeBuMLGsx8M8hpZAzu9l7SLyIR7CHTG
         2QlRQDk3FwAOse1ABWEK/frkGiaYnrpyCA1BnJ0O3HqUDTiNiD5xjSrbfPd2zdo/tXxO
         xxMw==
X-Gm-Message-State: AA+aEWZhJCSonF5/aNeFZTeZhDyrD4bdF8NCG9pQmKTWl9p2F9CG+Ij0
        0I0UKUOQHpmHBWPVoTtVO1jatA==
X-Google-Smtp-Source: AFSGD/XEAqABFCF+vzzoc6Evp5frnxOq8ZucUcPTzNqlvHX2OCzE6pYNSSCHRNax02pKjaL+IURaxQ==
X-Received: by 2002:a1c:ad43:: with SMTP id w64mr10526130wme.32.1545040013020;
        Mon, 17 Dec 2018 01:46:53 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:46:52 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 09/13] arm64: dts: qcom: qcs404: Add OPP table
Date:   Mon, 17 Dec 2018 10:46:26 +0100
Message-Id: <1545039990-19984-10-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a CPU OPP table to qcs404

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9b5c165..4594fea7 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -62,6 +62,21 @@
 		};
 	};
 
+	cpu_opp_table: cpu_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+		};
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+		};
+	};
+
 	firmware {
 		scm: scm {
 			compatible = "qcom,scm-qcs404", "qcom,scm";
-- 
2.7.4

