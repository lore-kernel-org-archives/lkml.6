Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E32ECDFB4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222AD20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VM4ZEEep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222AD20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeGPOAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:00:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38219 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeGPOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:00:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so29998888ljc.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dwR2q+9R0Xn4F9WJrQYTuFQ7eo4wf2FGRuz3XTsXO5E=;
        b=VM4ZEEepBQdpvDkIYJyrX+AcUPwTplq3DYEGWYBEysIBrbVAFY1rEFiLgPK/L3f2+u
         ahPKw6l/5cLtn7Cp7z1gMybsjgifdaOm6lP117X4rFyvGjqjJEK6kAL0pBCvcJp7ICpk
         9Y3lQw6uaMAAZWTXTMqNhPpqSU7K30hmSxQvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dwR2q+9R0Xn4F9WJrQYTuFQ7eo4wf2FGRuz3XTsXO5E=;
        b=uGfqsoOrWH5OfNKKgwHu28vIpyRUvpuybEP/x+lpwJ0dA7QHpQR0ng9TEEaJWqH7Xh
         0TdEPi0Nhkzkaezy+fbbz3Li2m6uptLt/hT7H/QAN7aKjONvaWe3H8KTXDNZGk/mu0CR
         OkeX7pBA6yhLC6ZLwtaIBVq40z1bJ9o9YZc+2s239Sy1BlvKRfbrIhVjTvbmr6ayJ4Nh
         tLMfIZEePfFROtrhDOdZta1484coue7P4fDoThBpSLFpUkZ9sYmCpy8nqaXO8nkh0VRQ
         j1tbvSqA+6unvpNbKTNWa7sHkMzbLhebmCCTcCuP+V+N8lNR1rGiP3a/jE5Zc8ChZrWS
         z9iQ==
X-Gm-Message-State: AOUpUlEe9NMHwO+mL/tDmnxcvEbBIgosBDYsw0tZg0HiykS8vpdgghNZ
        eZKfWQdDLBPYmKQu76BHm3R9sw==
X-Google-Smtp-Source: AAOMgpftsfGFTNqjOh6p0GW0PvrZhRZyxRuseX3Np6PSaHRQw5Rt+tA7QF8AfzcdIYujPg3lsGChkQ==
X-Received: by 2002:a2e:869a:: with SMTP id l26-v6mr5770782lji.48.1531747990542;
        Mon, 16 Jul 2018 06:33:10 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id a14-v6sm3820390ljb.49.2018.07.16.06.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 06:33:10 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, johan@kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] regulator: qcom_spmi: Use correct regmap when checking for error
Date:   Mon, 16 Jul 2018 15:32:52 +0200
Message-Id: <20180716133255.1506-3-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716133255.1506-1-niklas.cassel@linaro.org>
References: <20180716133255.1506-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have just assigned saw_regmap, and since the error message
refers to saw_regmap, it feels safe to assume that it is saw_regmap,
and not regmap, that should be checked for errors.

Fixes: 0caecaa87202 ("regulator: qcom_spmi: Add support for SAW")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 4cc14c65d86b..ba3d5e63ada6 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1775,7 +1775,7 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 		syscon = of_parse_phandle(node, "qcom,saw-reg", 0);
 		saw_regmap = syscon_node_to_regmap(syscon);
 		of_node_put(syscon);
-		if (IS_ERR(regmap))
+		if (IS_ERR(saw_regmap))
 			dev_err(dev, "ERROR reading SAW regmap\n");
 	}
 
-- 
2.17.1

