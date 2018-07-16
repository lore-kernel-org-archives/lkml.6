Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB4CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06974208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vsm5n3pH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06974208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbeGPMEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:04:04 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41238 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731334AbeGPMED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:04:03 -0400
Received: by mail-lf0-f65.google.com with SMTP id v22-v6so18501337lfe.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jx2CIOdp7BkYXfoJzNq6Y7YBmIGYyL+f3gQ6kZgoC6M=;
        b=Vsm5n3pHCBcRDfrNF4wdefTBN/7CkXzvSFk8URZmCnHzeEJdlJZVupqylyEKVfeTeW
         om0Zt56wgrb2gWqXnt3JOk+DX1GLQAhDB6BmM5QIIL6l/OwyrqxHhNvAH47ciKCNfIaI
         U6LiO2Y3V+39dMZfNfR8PrEaolY3/RgZzg5E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jx2CIOdp7BkYXfoJzNq6Y7YBmIGYyL+f3gQ6kZgoC6M=;
        b=mWVqHRYUFpzV2AlxZJ/49vThAdOnEQKj60U0kJFt2GWYa5wLREPUEU+vdv6D5bix5J
         YiSiubVoSYSGrGDbtnZ01NrqsAFxYmt7ewKQYX6OVWyz8PKrnDOMrWYxGKi8dRR8pEHJ
         7t/LVFoL2YHnfA1Mt31FJ8xxSnYAj1jdPyGD4GJdcVoXJDJcHFVkfAe7n4O6T1yMIGI8
         vJ9PQyjbADedRs0OcdSe+kMKjiYbVCIrc00aw9FpH0VTXOJSVmzH/adBK1qgKqsGCap+
         PKslAPCyj2+WHkPhx0djIcoGOMA0dNtfyhspT2JQLOUvd0VvhHyQVr2lFkN0REhvalF3
         4eEQ==
X-Gm-Message-State: AOUpUlET8K5ylMDdce0+/PdLLt1e5EdCc2ks/Xo+76gfyVAt4NI3AY5l
        PRq+9sGrQTqKy9ZQTnGCE1j8PzrFI2w=
X-Google-Smtp-Source: AAOMgpcq7hEeLdVv/I2/lUlIcB0Pm70aNN0uFvOvDtSweic1bGuJYxwJr47+ZQwTV79qu85bMAqGXQ==
X-Received: by 2002:a19:63dc:: with SMTP id v89-v6mr12138999lfi.23.1531741020695;
        Mon, 16 Jul 2018 04:37:00 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id g11-v6sm2375691ljk.45.2018.07.16.04.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 04:37:00 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] regulator: qcom_spmi: Indent with tabs instead of spaces
Date:   Mon, 16 Jul 2018 13:35:25 +0200
Message-Id: <20180716113525.9335-5-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716113525.9335-1-niklas.cassel@linaro.org>
References: <20180716113525.9335-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error:

ERROR: code indent should use tabs where possible
+        { }$

Fixes: ca5cd8c9400c ("regulator: qcom_spmi: Add support for pmi8994")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index dbe6ecc34859..a4a6c1711bc4 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1728,7 +1728,7 @@ static const struct spmi_regulator_data pmi8994_regulators[] = {
 	{ "s2", 0x1700, "vdd_s2", },
 	{ "s3", 0x1a00, "vdd_s3", },
 	{ "l1", 0x4000, "vdd_l1", },
-        { }
+	{ }
 };
 
 static const struct of_device_id qcom_spmi_regulator_match[] = {
-- 
2.17.1

