Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 27A69C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC36208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AapBiY8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC36208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965116AbeFNV4x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:56:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37362 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964969AbeFNVzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:55:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so449714wmg.2;
        Thu, 14 Jun 2018 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bbd9qT5bZb0lQSAgCUgAhMXd16FNojWKGjoe2iKI0uw=;
        b=AapBiY8WefiT22QCoBJAWn3WFqbO8hCpKsOv8vcDefri6T3GI7jNbFmV0giotZl7zA
         E0rXDcu0qN2PJwPaVAARkyymTaDk3BvscIwPVIyQdZOcowZs8hJTTdByYpBMkQaKsmN5
         6CqJp/kBQ9eP5NLq00IfZN+SQ1HBwrcCLpLGgQcQX+FSt2DgFwcZr6QEUsbKaU6LbX5B
         msW5UyYzSfNcgsaECkEZY7eqbFlBy0KR7ZrAZQAtzW6LWNEHkwELAJgDk3Jwj4iHrRjb
         a1n/2HONQZYgiXysGc93JAwjNiYsm3ikHmeJY0zSyk9922at38hUS8wlNRRGsUxio+WP
         CTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bbd9qT5bZb0lQSAgCUgAhMXd16FNojWKGjoe2iKI0uw=;
        b=YYy0kL+kG2C8e+AZyeMVOet463CxpkBCUIdeZlbuXuqar7+Kry43/m6A+9lqQ1u9Qv
         kMvyteR9D+y+Gm3XwbOi7C002Jjg9yuEsyfmMl0R0oFqFRxF+VUW2P056odESiQrApxd
         IgRniVzN86E195IWK/imTgveLx+EccW0v+vQFJ7fOQ337xzYNSmU64s19o7oVohIJxvP
         mu+qCpbDjesxtXO3PGNP4uXPCWdYwH5oC5uBbEDmN5BGkEKgnyPWip45IAks7Vw2w7ze
         Yl6nQq4Y/X2d7PB9lMbTKoSMB8X2E2xKVhrwOTFBruSZWnwc1BEwFaE8ac/eCE9bObB/
         +Q+A==
X-Gm-Message-State: APt69E3ToUkX7H3lO7r2iAzFuRt/uJ4xIDMoFdX5wt0zqqs+6nSk71gs
        JWw+4gkf/HUi5xRJNFJLfpc=
X-Google-Smtp-Source: ADUXVKJMJAovqnyebB2ff0JBWz6eAYF7ZoyZpapQWuxBuZRfjoQj755CxgXH/MdKyJPFv9wOYm2Bsw==
X-Received: by 2002:a1c:ed07:: with SMTP id l7-v6mr3358962wmh.139.1529013330740;
        Thu, 14 Jun 2018 14:55:30 -0700 (PDT)
Received: from gcc67.tetaneutral.net (gcc67.tetaneutral.net. [2a03:7220:8080:c00::1])
        by smtp.gmail.com with ESMTPSA id i76-v6sm285367wmd.20.2018.06.14.14.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 14:55:30 -0700 (PDT)
From:   ilia.lin@gmail.com
To:     ilia.lin@gmail.com
Cc:     Ilia Lin <ilialin@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 5/8] dt-bindings: clk: qcom: Add bindings for CPU clock for msm8996
Date:   Thu, 14 Jun 2018 23:53:52 +0200
Message-Id: <20180614215358.11264-6-ilia.lin@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180614215358.11264-1-ilia.lin@gmail.com>
References: <20180614215358.11264-1-ilia.lin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilia Lin <ilialin@codeaurora.org>

Each of the CPU clusters (Power and Perf) on msm8996 are
clocked via 2 PLLs, a primary and alternate. There are also
2 Mux'es, a primary and secondary all connected together
as shown below

                             +-------+
              XO             |       |
          +------------------>0      |
                             |       |
                   PLL/2     | SMUX  +----+
                     +------->1      |    |
                     |       |       |    |
                     |       +-------+    |    +-------+
                     |                    +---->0      |
                     |                         |       |
+---------------+    |             +----------->1      | CPU clk
|Primary PLL    +----+ PLL_EARLY   |           |       +------>
|               +------+-----------+    +------>2 PMUX |
+---------------+      |                |      |       |
                       |   +------+     |   +-->3      |
                       +--^+  ACD +-----+   |  +-------+
+---------------+          +------+         |
|Alt PLL        |                           |
|               +---------------------------+
+---------------+         PLL_EARLY

The primary PLL is what drives the CPU clk, except for times
when we are reprogramming the PLL itself (for rate changes) when
we temporarily switch to an alternate PLL. A subsequent patch adds
support to switch between primary and alternate PLL during rate
changes.

The primary PLL operates on a single VCO range, between 600MHz
and 3GHz. However the CPUs do support OPPs with frequencies
between 300MHz and 600MHz. In order to support running the CPUs
at those frequencies we end up having to lock the PLL at twice
the rate and drive the CPU clk via the PLL/2 output and SMUX.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,kryocc.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,kryocc.txt b/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
new file mode 100644
index 000000000000..8458783c5a1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,kryocc.txt
@@ -0,0 +1,17 @@
+Qualcomm CPUSS clock controller for Kryo CPUs
+----------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+
+			"qcom,msm8996-apcc"
+
+- reg : shall contain base register location and length
+- #clock-cells : shall contain 1
+
+Example:
+	kryocc: clock-controller@6400000 {
+		compatible = "qcom,msm8996-apcc";
+		reg = <0x6400000 0x90000>;
+		#clock-cells = <1>;
+	};
-- 
2.11.0

