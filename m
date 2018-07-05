Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E722C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274A124069
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1B6R/Qi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274A124069
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeGEFJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:09:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45610 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752698AbeGEFJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:09:35 -0400
Received: by mail-pf0-f194.google.com with SMTP id y24-v6so4312765pfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+5ItNYTYeiKz+mT0Uq7k5mUE+h7almHMaSv0njAJGPc=;
        b=C1B6R/QiTyttjB+gnxPIQfMOeSYwVVfnSeY4onNWi6WmZ4DTgRecmoX9QKinq8HODh
         sug3aU2uKP0C+2tj3WA+GE/aAPhkD0kQea79sOTWq0btUo8uDSgagQ4MHUz2dB6vg8lq
         p8RLTYovNwyyigN+Ku0KcHBXqVqtHRFVgNUxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+5ItNYTYeiKz+mT0Uq7k5mUE+h7almHMaSv0njAJGPc=;
        b=P1UO/ivWffoRL7Bm/ZNJO1/zXJdMVPa5nrQvPpEG4GoJ/NZ2jA7ZBL5QxWdSazcT+2
         oswTSCdLMZL8PCJEgstgT1YtVPMbn4hB512Oth2HwxKiFbqwmEsqDdRj6eqSKiI5bM4E
         4gK1q522OODLA5q7BGdTBEdv8NHgPwO/tNuzNRBBHWFvPcO1dipdsa+67YLtI+QXd4VG
         CCkhuONE9btJlOPmlUtROhqpi2so9C5GmEGwo0sKSINVTUzaBhqkzmYQwRZ86dd9RsSY
         JMm9lgAUvOUYMWLLrpmLVaXDP1ruv36fqj7r/L9YsZoI0/A0OTOAGXY1E6UdtNwTXmXy
         9EAg==
X-Gm-Message-State: APt69E2s36h5Gi3FPfEDCTkhEEx7D1jLgh4ia5lyC4oVl9ZilhTv2Qvy
        Sx6k1wh5RkWrq7Sl7m2gi/TAiw==
X-Google-Smtp-Source: AAOMgpfD16zRbyggutR+hU2YxXVeYKtpE7KT9ZlIOF8Jek2W9xdERrHhfEsbv1u7vWN7Hr6+ZGLIYg==
X-Received: by 2002:a62:a05:: with SMTP id s5-v6mr4791283pfi.147.1530767374020;
        Wed, 04 Jul 2018 22:09:34 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id s22-v6sm8983090pgs.34.2018.07.04.22.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 22:09:33 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: hi6220: Add all CPUs in cooling maps
Date:   Thu,  5 Jul 2018 10:39:24 +0530
Message-Id: <fd741a8140809406ce86c479bbf6f03319490a64.1530766981.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530766981.git.viresh.kumar@linaro.org>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each CPU can (and does) participate in cooling down the system but the
DT only captures the CPU0 in the cooling maps. Things work by chance as
under normal circumstances its the CPU0 which is used by the operating
systems to probe the cooling devices. But as soon as that ordering
changes and any other CPU is used to bring up the cooling device, we
will start seeing errors.

On the other hand, the hardware is partially defined in DT in these
cases and we must do a better job by capturing all devices.

Add all devices (CPUs here) in the cooling maps which are also affected
by the trip point.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 247024df714f..919d36b91bf3 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -886,7 +886,14 @@
 				cooling-maps {
 					map0 {
 						trip = <&target>;
-						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+								 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 					};
 				};
 			};
-- 
2.18.0.rc1.242.g61856ae69a2c

