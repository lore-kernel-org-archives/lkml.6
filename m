Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC09EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8189C206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXNUDd3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8189C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409776AbeKWXCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:02:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41199 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388006AbeKWXCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:02:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id z28so10089821edi.8;
        Fri, 23 Nov 2018 04:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdolHecX+PD3w9d/01mrC0dlHHqNTHapniWeqqzgLrM=;
        b=BXNUDd3jG58bw9PdNCGdYunSRzlret0k7K2cM9QciXTh7HOe08+80XrylslpS9l/3Y
         T+i/zeO+Rl86JnvpmB5nAlrId4YEW6VWBiuARmZsAIh8rblwNitJRQpgHHZDC65kJmZg
         wjr2VIiOvSudmeTc27rpE77hUF44Yx9GTKALcj7KBuqznCVyDmR11NoAdQMiQiI8ggvx
         WEmhDUX9LSTMtwEZJUJ5+4ih8gk6Bffu4oKjDpLKMZrGDg22ho6Zo7YMUWbuLAs034EL
         wuTgIJvOSkzLVlj0ed06h17TJY73GLC7wRjqa/ml0VdvDNIzFc0RNs405tv8nAs5KryX
         bbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdolHecX+PD3w9d/01mrC0dlHHqNTHapniWeqqzgLrM=;
        b=MrsjVEDs5OlK7MVjKGbplQGnpJpyUK0fuASz3hKt7wz67HwBMhFBUimQGaSU/+IpoI
         Ixzw03REDhR9dQRao3izcZbdzt9pYL5TpL7Ja0hHE0CXONXAjr3jQDJMoK28XMUxJ5nn
         fDDQrgJa+s0saYW3IQTQ3KhnS3+cKI71D6Y0LeTQ+LdfSqYxpO7rkwJFvN0sJXiTM2vX
         wuBNr6wp332LsI1UcfXrVaagR1zVTOmzyteDdHJ+qd8HM7j8yQLOXeWhnZv4juROs/18
         5h9tltAbT3cNyhDxpeaeCQG/gA4x6keKU5nvIIVJMo9MCKW2kWPycGWsU0flpAt8kMyo
         VDPg==
X-Gm-Message-State: AA+aEWYclv7J9/kIrrb1QuNgZnzn1FVwrvMRu6AMMie8poEY0ruczbR5
        EYP7ZO63DkqX+YhydrXNfLw=
X-Google-Smtp-Source: AFSGD/VSH7EEAqvhJRJdu8wkEFNUK+Noh9VCiorZI41YuoJvhj71yuLvPwhEpb9HzTToLdYOqZMXCA==
X-Received: by 2002:a50:98c5:: with SMTP id j63mr12562905edb.273.1542975523606;
        Fri, 23 Nov 2018 04:18:43 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id e35sm9188084eda.13.2018.11.23.04.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 04:18:42 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: tegra: Add thermal zones on Tegra194
Date:   Fri, 23 Nov 2018 13:18:38 +0100
Message-Id: <20181123121839.18573-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123121839.18573-1-thierry.reding@gmail.com>
References: <20181123121839.18573-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The NVIDIA Tegra194 SoC defines six thermal zones. Define all of them in
device tree.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index cbba7395a286..39169f6b6166 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 #include <dt-bindings/reset/tegra194-reset.h>
 #include <dt-bindings/power/tegra194-powergate.h>
+#include <dt-bindings/thermal/tegra194-bpmp-thermal.h>
 
 / {
 	compatible = "nvidia,tegra194";
@@ -938,6 +939,44 @@
 		mbox-names = "rx", "tx";
 	};
 
+	thermal-zones {
+		cpu {
+			thermal-sensors = <&{/bpmp/thermal}
+					   TEGRA194_BPMP_THERMAL_ZONE_CPU>;
+			status = "disabled";
+		};
+
+		gpu {
+			thermal-sensors = <&{/bpmp/thermal}
+					   TEGRA194_BPMP_THERMAL_ZONE_GPU>;
+			status = "disabled";
+		};
+
+		aux {
+			thermal-sensors = <&{/bpmp/thermal}
+					   TEGRA194_BPMP_THERMAL_ZONE_AUX>;
+			status = "disabled";
+		};
+
+		pllx {
+			thermal-sensors = <&{/bpmp/thermal}
+					   TEGRA194_BPMP_THERMAL_ZONE_PLLX>;
+			status = "disabled";
+		};
+
+		ao {
+			thermal-sensors = <&{/bpmp/thermal}
+					   TEGRA194_BPMP_THERMAL_ZONE_AO>;
+			status = "disabled";
+		};
+
+		tj {
+			thermal-sensors = <&{/bpmp/thermal}
+					   TEGRA194_BPMP_THERMAL_ZONE_TJ_MAX>;
+			status = "disabled";
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.19.1

