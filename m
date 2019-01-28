Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F191DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C258220855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgQTujWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfA1Sdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:33:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36019 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfA1Sdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:33:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so19239795wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nAEdvq5oOukgk1f4NK11o2gbGIkfrBCRV8yGimK9/ag=;
        b=NgQTujWor9c8VTUEHGHbjOFEgPwu0ve769eQ9xvenDaBYyKgxpegvFKTQxN/s4L62/
         Lj1APdMK6Ty1l0V7p70DAqg39xa+A1ji3EU01bGIg1QTzX8XGEhiZbveaMMDjPnnTcl1
         w6c4i+C1/6v5X6xcAzuKryU+xNa2qDOPYZopQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nAEdvq5oOukgk1f4NK11o2gbGIkfrBCRV8yGimK9/ag=;
        b=qNPHuZpWpapoDP/emByjMbs9BZZVbwYxvOQh5S2wNa0xVqYKogEzmrMDJ6IR5HJ7+z
         zYpkGkOJRjNkVHns0d24b08k3aCYz+bHxcJZz2CCcjVgsGYvznjKUj52UoH26IhY2SdQ
         ADimuY/VGoG8KmqP9oZSAp985Rzd4RbYgp78eYgmafd1ri7cIKG3BR8pxwZhxl/BR4Sq
         clXJWUFtZQS/rJ7BMOq+UP4aRrBIwPFD2B9rXbF62/tL/MEr+unj1JAjfF9S6Lw1z1NZ
         XIOk15T+vW7M0IV8xeL0paqTmW2qyxgAYyE2Sz8oCpPsEuEe/7sC2pQ/kQH45GIomaze
         cQ3g==
X-Gm-Message-State: AJcUukeSSDgl6Ajngg04rYm0DcDnsVdmxePr7d8anqGS/cS+knR7sOQW
        suJdZdFuKN0nTxE/Ih6Iz2ONEg==
X-Google-Smtp-Source: ALg8bN67yBhogyL4bLztP2bWrzOaIcBWicT0uuQ3HSZzV8dSmLhZb/MFO/i4OXLnhGrIdQFp/JTbDQ==
X-Received: by 2002:adf:9205:: with SMTP id 5mr22721276wrj.189.1548700421706;
        Mon, 28 Jan 2019 10:33:41 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 10:33:41 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v2 14/14] arm64: defconfig: Enable HFPLL
Date:   Mon, 28 Jan 2019 19:33:01 +0100
Message-Id: <1548700381-22376-15-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The high frequency pll is required on compatible Qualcomm SoCs to
support the CPU frequency scaling feature.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c8432e2..67f0cca 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -628,6 +628,7 @@ CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SDM_GCC_845=y
+CONFIG_QCOM_HFPLL=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
-- 
2.7.4

