Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4DAC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E044279B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E044279B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934272AbeF1VJb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:09:31 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33677 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeF1VJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:09:28 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so3362436plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 14:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JBU7uHykidcwWem0rObndhcLMBekFhLE9LHPR8w3OuQ=;
        b=GLxJXRnfojAnjb9GXXusl0yaBiWGEwhEzV1D6mqOY/AkHSsoKDJLK7Asf5tQSEaOdI
         xI9uMutkvtst5phdS5wwFoH4AuCW6eKv0HzKMBh1SXotMWfTJk3vMEHUzZSnEBKEmXow
         AaMHViKMhY2DkI7wXGBXwc1vqp3L3qrmouEL0iYKljLv6m+6+39EZv9IJVtN+wdc6WtG
         /jHobia/wVBVRPU0xLQICMir7+VFlkhNFXQieblAyxjG0EaCDNcw0uA0yDjlEg/EuLYn
         zzGCPPX9zHt35j46XnG7KMfhqwhTYRc0nXp1E3T3kGHC/funaDzya02xZjgL5pik3xQx
         hL4g==
X-Gm-Message-State: APt69E3YocE9eubtqLLc6GoQ2xWAZztE7hVgXXMjRKPFhSELK1nm0z6X
        o0zKtNtiDnpFZo8jJPAv5KWtuA==
X-Google-Smtp-Source: ADUXVKLlL91Ah22tnI8L0rDVQPyPD9XkBvsqTPCxH4a772DJg0ueEYtxx74dH0/N3dNa6p9PJw8zSQ==
X-Received: by 2002:a17:902:321:: with SMTP id 30-v6mr12228158pld.122.1530220167353;
        Thu, 28 Jun 2018 14:09:27 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id w18-v6sm9006838pgq.1.2018.06.28.14.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 14:09:26 -0700 (PDT)
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
Subject: [PATCH 1/3] arm64: dts: qcom: sdm845: Add thermal-zones node
Date:   Thu, 28 Jun 2018 14:09:13 -0700
Message-Id: <20180628210915.160893-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node is empty for now. It is needed to allow other DT snippets
to add thermal zone entries.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Sorry if you received this twice, lists were missing in cc in the first attempt ...

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 00722b533a92..968390fb0933 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -1087,4 +1088,7 @@
 			};
 		};
 	};
+
+	thermal_zones: thermal-zones {
+	};
 };
-- 
2.18.0.rc2.346.g013aa6912e-goog

