Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09755C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CF924064
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cf1ImKUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CF924064
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbeGFD4Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 23:56:24 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41551 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932348AbeGFD4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 23:56:21 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so2215539ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 20:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2WfBOmihLgE5IfqJ+Pm83qoggVHezr58VMhg/98XCM=;
        b=Cf1ImKUMtfIe4I3pXF3SLLB44uPj7EwUwD7pByrd6Me/BxVw2j7lzu0EOhey2xvpeS
         6JgBB5BNbCPzIWvT7HC6K00P0Tx2Am25Gk1NHDUWyziXGdXg4Mm1E4UxZlxNWL3z1C8C
         AzzDCsa/UK1pn/x8C8CiztXbWJBxjK4GrIZBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2WfBOmihLgE5IfqJ+Pm83qoggVHezr58VMhg/98XCM=;
        b=Vt897jYVkkY/l14zOtZtidMmM3QX4407sfA1bunN25M34AmOmDRGNZsU+LdWFgjbLp
         N4wAmZDMDlWONsimmNqd3YDK3z9SfjJ1RD6RSsX+kzs4dSWE/rAhcummoR+YGz65mVqx
         eRYek5m3DZNUhmjnJNmRjRTfOl1Xoa16jVKTSBdcJUpULJJQN0DS2kcsMOOxWgBCYo/+
         UdriUo0Yii4xtbQelCFPioHIJutf/IsLdTmmMswnRktw8OBiuKZp//lpE1zXe7T38m82
         nbWPxDJDl92gdXCJqvC7D5zkVaUgvYp/bou/tupIpqx9tXCgNGqItKvG3rU65rHJJesu
         A87w==
X-Gm-Message-State: APt69E20jar/564e9HKPCdVJwf3iE4C8BjG+zDv6n8Ad0hBpGUU3qU/N
        d5i7qfJ6lYL2/r1ctmgNdToMWKid7Yo=
X-Google-Smtp-Source: AAOMgpeklL+zU6oPpwkMjAez9XlLuch2BXAQFTxcaNtdcNmm+QWftpzpCWu4FzAREg6h1HIN/0euHw==
X-Received: by 2002:a17:902:3303:: with SMTP id a3-v6mr8702816plc.209.1530849381135;
        Thu, 05 Jul 2018 20:56:21 -0700 (PDT)
Received: from localhost.localdomain ([64.64.108.33])
        by smtp.gmail.com with ESMTPSA id y14-v6sm12568403pgo.22.2018.07.05.20.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 20:56:20 -0700 (PDT)
From:   Guodong Xu <guodong.xu@linaro.org>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, xuwei5@hisilicon.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Guodong Xu <guodong.xu@linaro.org>
Subject: [PATCH v2 3/4] arm64: dts: hi3660: update property name hisilicon,dma-min-chan
Date:   Fri,  6 Jul 2018 11:55:20 +0800
Message-Id: <20180706035521.13736-4-guodong.xu@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706035521.13736-1-guodong.xu@linaro.org>
References: <20180706035521.13736-1-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update property name dma-min-chan to "hisilicon,dma-min-chan"

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 8d477dcbfa58..0cec26976eb6 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -537,7 +537,7 @@
 			#dma-cells = <1>;
 			dma-channels = <16>;
 			dma-requests = <32>;
-			dma-min-chan = <1>;
+			hisilicon,dma-min-chan = <1>;
 			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_DMAC>;
 			dma-no-cci;
-- 
2.17.1

