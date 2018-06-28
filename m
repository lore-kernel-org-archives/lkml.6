Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DDAC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F3F279C9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F3F279C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935629AbeF1VKA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:10:00 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33678 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933615AbeF1VJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:09:29 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so3362459plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 14:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5aJoBAFTkZOAuMwvCVIY3zpivZHdtFBkCOPhmPF6jAA=;
        b=OX61CKqxi0t+hqN4B3eAouajsxeuHz2Y/pk/DgA2EbKabz9X/V5DwT7cbR8LZs0d/I
         Wtdksnr1vD5sPPZthErI4iFhqL0LeQe14Ne/quNwg1aL1cObnLzjfQCyXPcy5rg97vWZ
         /m2ZxUVwH4XGHwLU7l9kPp+2EBNLSkMpmrjBlDhRLF4+pUS81lCygXhgvBfmGNtyCqTj
         /DldQxLkIG6/CD1koQX0PFJ1cjzMn2d1iZ1eJTXAgQ3Sy7hjn4kz+xAEY4wgXgEFruQm
         XMB1C8NqLjHZQTKQHjW5lAvDQL4pNlQ+GW9JgypKH5aZxP3rVPSx5d84c/x9x4mVaKx2
         WXuw==
X-Gm-Message-State: APt69E0ab2lqmAYMwvc/miWgN594EaiP9pUfVrO+zaEIVbIzj4v4LjOm
        btVHG413tfvd5pykXW4tdRX2gA==
X-Google-Smtp-Source: ADUXVKKNFOB5H9PHmkvAvsWkPghRTfR01mUlRpZJEnb+A5cU/8y5RDrmxdfX/4DWEM99KVHpPVF7wg==
X-Received: by 2002:a17:902:6bca:: with SMTP id m10-v6mr12120407plt.6.1530220168807;
        Thu, 28 Jun 2018 14:09:28 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id w18-v6sm9006838pgq.1.2018.06.28.14.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 14:09:27 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/3] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
Date:   Thu, 28 Jun 2018 14:09:14 -0700
Message-Id: <20180628210915.160893-2-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180628210915.160893-1-mka@chromium.org>
References: <20180628210915.160893-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the spmi-temp-alarm node to pm8998 based on the examples in the
bindings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 92bed1e7d4bb..f2d39074ed74 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -44,6 +44,12 @@
 				     <0 0xd9 0 IRQ_TYPE_NONE>;
 		};
 
+		pm8998_temp: qcom,temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400 0x100>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
 	};
 
 	pm8998_lsid1: pmic@1 {
-- 
2.18.0.rc2.346.g013aa6912e-goog

