Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A895C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068B12084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHwvBlsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068B12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeH2LEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:04:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39114 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeH2LEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:04:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so4342075wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hGYHtsxP6qJIBkowwqLcEfY3ekjpkezQKD1guvAXw6I=;
        b=UHwvBlsSs4XACcwYmxO4D1gLt7a1zWh8LQs/0u7Sgx0bnfu8OPQPZWis4+vS3byauQ
         tbAK7E5BwoMZXaITymAjZBMfOTM8gkwK3uO89deOBLu7e6nrfA8e858huEvhLcv2QX/2
         2KLtAXLxdAzBkqYtVQAcYeKpa3aR8yrWOHCoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hGYHtsxP6qJIBkowwqLcEfY3ekjpkezQKD1guvAXw6I=;
        b=BnLR7wUsDE8uJ2cq1y6ZY5xD8mGTSOPR2fdPO4PWYisrWL1eZaTzOwY6ZtUqdJu4fy
         9nBKkVRybx/vssjvC5ZQYp5QcDAQEF4hyncWIwhfZ/CabqVquMgVhLdUr2k/NA49ek+B
         TsHLJrsykwrjxrhAI3aTHGHPieJhbDp1o5sVD4Lm4k8fmhrfqRTuHI0QyYPUCAeh5QaE
         pAtLvZHo6TSxdBkceM/i84YN6HLCkUB3tvbwzmMrWeYj2841zfQm7tpk83bLXXq2Fyot
         5rRaWTeFtJ17Yvg41MCBc561LwGEifmd712Y9iGEMoTYLtDE765vjCr+fNh1uhjYqDeX
         lrOw==
X-Gm-Message-State: APzg51AxuinaJPqEkvw1/mYFBRs5g2ecSw7SJ7pBDuSxFVtHlW96/8QL
        IXuc9uj9S5/00kV7u1o4p0m3Yg==
X-Google-Smtp-Source: ANB0VdbH+c3/oiUJ452jLs3yR/8xS/wiT6Qxc0hB1TmzKXFnos3bajaDM+RJ2aGUV0xxbGGciw1j7Q==
X-Received: by 2002:a1c:ae8d:: with SMTP id x135-v6mr3412241wme.20.1535526523911;
        Wed, 29 Aug 2018 00:08:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:4c23:4749:7ea6:c5af])
        by smtp.gmail.com with ESMTPSA id 34-v6sm4984283wra.20.2018.08.29.00.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 00:08:43 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, punit.agrawal@arm.com
Cc:     edubezval@gmail.com, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] dt-binding: arm/cpus.txt: fix dynamic-power-coefficient unit
Date:   Wed, 29 Aug 2018 09:08:38 +0200
Message-Id: <1535526518-29022-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unit of dynamic-power-coefficient is described as mW/MHz/uV^2 whereas
its usage in the code assumes that unit is uW/MHz/V^2

In drivers/thermal/cpu_cooling.c, the code is :

power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
do_div(power, 1000000000);

which can be summarized as :
power (mW) = capacitance * freq_mhz/1000 * (voltage_mv/1000)^2
or
power (mW) = (capacitance * freq_mhz * (voltage_mv/1000)^2) / 1000
then
power (mW) = power (uW) / 1000
so
power (uW) = capacitance * freq_mhz * (voltage_mv/1000)^2

Furthermore, if we test basic values like :
voltage_mv = 1000mV = 1V
freq_mhz = 1000Mhz

The minimum possible power, when dynamic-power-coefficient equals 1, will
be with current unit:
min power = 1 * 1000  * (1000000)^2 = 10^15 mW
which is not realistic

With the unit used by the code, the min power is
min power =  1 * 1000 * 1^2 = 1000uW = 1mW which is far more realistic

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 29e1dc5..71d8cd0 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -274,7 +274,7 @@ described below.
 		Usage: optional
 		Value type: <prop-encoded-array>
 		Definition: A u32 value that represents the running time dynamic
-			    power coefficient in units of mW/MHz/uV^2. The
+			    power coefficient in units of uW/MHz/V^2. The
 			    coefficient can either be calculated from power
 			    measurements or derived by analysis.
 
@@ -285,7 +285,7 @@ described below.
 
 			    Pdyn = dynamic-power-coefficient * V^2 * f
 
-			    where voltage is in uV, frequency is in MHz.
+			    where voltage is in V, frequency is in MHz.
 
 Example 1 (dual-cluster big.LITTLE system 32-bit):
 
-- 
2.7.4

