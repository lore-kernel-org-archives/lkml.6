Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167A7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2E82177F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="THyZtBVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2E82177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeHUUC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:02:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35167 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeHUUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:02:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so592791wre.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lFOHFpR+amS5x9JJ70VCAqgX8mu7REL4MivPg0W8qQs=;
        b=THyZtBVkw0x53a14WAFgTnz3v6p60e5IDwa3P+1sHdJL7wzE1SutmJg0Ujt5mi/jK7
         bhk1vXf7kRlxGD5F1c4+78pT6JMFl0vqklzjvvmgmxcMPZfVn6O5sdwaQAY17LGBaKKo
         ODeIW27jOkyDzvNxLTBPo/inm9si3QgA0ewW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lFOHFpR+amS5x9JJ70VCAqgX8mu7REL4MivPg0W8qQs=;
        b=f96BbyRorUNDPUW2ogJRFNy1jCzMTQ7nAeuiFJPz1HZJQiUasa0R7sE3gtzpNeyc9T
         VEHES6fBq9phVbtkUmFLg1/pT8Y1xV0pIbYd2PBn12Eqq9lQhXqjfDNQYONSF9N/Q0mk
         UYoSd5uLn76AH1NxrOeEX72F2BxCOKcoEF4DKK8Le7gzp70bzIoMx9ONquwm9nlVtppn
         Q9Q9/8ztTX9UoZUmiS9lKu5wj4NxfzYsUxkhEw0HNVMLQ9Av0l0ZLLvA0Mjqk+GB5+Dc
         zLcT9uarqStmDhD1Qdif5QemoQGA81UQqe4RlG41o4h3UsasSf8N6F97M4LLUOU8IDI8
         KZCA==
X-Gm-Message-State: APzg51B6qnEnK9csTM1tNktW6LkOdoOCUoRg5CVAfvVQI14tbLAMT8QP
        slEbsoXDOe1xRzjGPMGrBgDQzw==
X-Google-Smtp-Source: ANB0Vdafax72hB2E5n3+W+szE83xbu7Ew/QPp2YoHC6c6cLDKeAmtXrBiZJTBW1sV9ycwAhydh12qg==
X-Received: by 2002:adf:fa4d:: with SMTP id y13-v6mr9706329wrr.155.1534869694602;
        Tue, 21 Aug 2018 09:41:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:3439:d494:ce42:6719])
        by smtp.gmail.com with ESMTPSA id l16-v6sm2165294wmc.38.2018.08.21.09.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Aug 2018 09:41:33 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, punit.agrawal@arm.com
Cc:     edubezval@gmail.com, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] dt-binding: arm/cpus.txt: fix dynamic-power-coefficient unit
Date:   Tue, 21 Aug 2018 18:41:25 +0200
Message-Id: <1534869685-22221-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unit of dynamic-power-coefficient is described as mW/MHz/uV^2 whereas
its usage in the code assumes that unit is mW/GHz/V^2

In drivers/thermal/cpu_cooling.c, the code is :

power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
do_div(power, 1000000000);

which can be summarized as :
power (mW) = capacitance * freq_mhz/1000 * (voltage_mv/1000)^2

Furthermore, if we test basic values like :
voltage_mv = 1000mV = 1V
freq_mhz = 1000Mhz = 1Ghz

The minimum possible power, when dynamic-power-coefficient equals 1, will
be :
min power = 1 * 1000  * (1000000)^2 = 10^15 mW
which is not realistic

With the unit used by the code, the min power is
min power =  1 * 1 * 1^2 = 1mW which is far more realistic

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 29e1dc5..0148d7d 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -274,7 +274,7 @@ described below.
 		Usage: optional
 		Value type: <prop-encoded-array>
 		Definition: A u32 value that represents the running time dynamic
-			    power coefficient in units of mW/MHz/uV^2. The
+			    power coefficient in units of mW/GHz/V^2. The
 			    coefficient can either be calculated from power
 			    measurements or derived by analysis.
 
@@ -285,7 +285,7 @@ described below.
 
 			    Pdyn = dynamic-power-coefficient * V^2 * f
 
-			    where voltage is in uV, frequency is in MHz.
+			    where voltage is in V, frequency is in GHz.
 
 Example 1 (dual-cluster big.LITTLE system 32-bit):
 
-- 
2.7.4

