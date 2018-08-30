Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6070BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C67E20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJinfBC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C67E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeH3Xum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:50:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41211 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeH3Xul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:50:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id l26-v6so8149310lfc.8;
        Thu, 30 Aug 2018 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J4DgLMSYNnZB6dnaOj/ZHug8J8zcGBQkyGiNMTFAyOA=;
        b=MJinfBC0S7ygek0Yigh1yUHEKxr9VYOiCjwHviS5RX+AFfmiZmx5CwtZNmmkKPl7ry
         R36vP8TsXksvfPzapUMyFAMkle3RaZ5GyxOjn0wkSApoG3GNof4UJ/NyK9pwvVzBZ2Xw
         po+EkcXQBo+uwHoyIyvV/WLIq8EAgRLj77mDWF0s1wnxFOu7TpZpGlUyo3jDDhamO3vc
         s6eA5n7QNUMxjP3LHlSzZfh3B+IEgPAD9z1LfW5yuOo6V6aVutQ53PgEp3L2ze/Drxsd
         h8xwbKbbi6Zs0h02K/6qSwJoeZ7LNcizM+zCofrjgoQU7Iv6qJUak2I5Dn5pj1/AgyWc
         AXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J4DgLMSYNnZB6dnaOj/ZHug8J8zcGBQkyGiNMTFAyOA=;
        b=b0vGfYql+rEBsC+FTQc1/73GQ342ar98Drdb7gMN7wZriDRJlNqKg+7Opt+taAuoeE
         +e3dHt50c58i13z6fwU/9swIBvanaotxYRU3pi/38JtthIiSBkUVuWKm3+gZFPXvjKhx
         rJCMml21zmdv4O9LrAlUTLfHAKPZFtm39lLWS1wRdYxWf09pV0ceiihtMISpvd1pq2wf
         4TCZIu3vfuJnbkH7ThcJlPgvmoNTny/uE+hF7wXjfLB2TcuNWAxo917XsPFzjMMh6zIi
         cJB847PFg+WhJR23YIM5B7JbWn4ph7Y3wQf1PnWyZpGNf3FL59sU04AKe54achPO2fz2
         UBbQ==
X-Gm-Message-State: APzg51BWk67KzusrRNIoe/aWH3Hi5o0RTDLaXIONRKeIxe+fNrWo/pMv
        yV3ss6jaagsXztrto+7YW0w=
X-Google-Smtp-Source: ANB0VdZh0eX/p8t90yulmSF4LytIqHHT3mhc6AbQ4nDEYAc0r0CZiZJPl5hDkSrIne/DKYJeuuJViA==
X-Received: by 2002:a19:ef18:: with SMTP id n24-v6mr8701156lfh.36.1535658412551;
        Thu, 30 Aug 2018 12:46:52 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id x3-v6sm1381191ljb.25.2018.08.30.12.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:46:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
Date:   Thu, 30 Aug 2018 22:43:52 +0300
Message-Id: <20180830194356.14059-2-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830194356.14059-1-digetx@gmail.com>
References: <20180830194356.14059-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding that describes CPU frequency-scaling hardware
found on NVIDIA Tegra20/30 SoC's.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../cpufreq/nvidia,tegra20-cpufreq.txt        | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
new file mode 100644
index 000000000000..2c51f676e958
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
@@ -0,0 +1,38 @@
+Binding for NVIDIA Tegra20 CPUFreq
+==================================
+
+Required properties:
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - pll_x: main-parent for CPU clock, must be the first entry
+  - backup: intermediate-parent for CPU clock
+  - cpu: the CPU clock
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
+- #cooling-cells: Should be 2. See ../thermal/thermal.txt for details.
+
+Example:
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+
+		opp@216000000 {
+			clock-latency-ns = <300000>;
+			opp-hz = /bits/ 64 <216000000>;
+			opp-microvolt = <7500000>;
+			opp-suspend;
+		};
+
+		...
+	};
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+			clocks = <&tegra_car TEGRA20_CLK_PLL_X>,
+				 <&tegra_car TEGRA20_CLK_PLL_P>,
+				 <&tegra_car TEGRA20_CLK_CCLK>;
+			clock-names = "pll_x", "backup", "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
+		};
+	};
-- 
2.18.0

