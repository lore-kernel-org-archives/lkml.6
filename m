Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CEDC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E2A20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zv2SmyqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E2A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeLLKSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:18:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54596 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeLLKSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:18:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so5149410wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aA3D1IhSCKQz7ydTdRheC5zDEQ2AVfQeUKpiJ99CzJc=;
        b=Zv2SmyqNk0ZcoT3RgrBsgFumoEIbGymgm22C+BHHXZUfCyiY5TkYc8cCYA6mE9VjJR
         M361CR7pgrv2jS/+TXJ8HG5ahEaX5xp123DMPVhSUVmeETKSDEaA64xY0heVa4dVVJ/G
         oUBIxrMbIzuINVi4/8opKMxTHgQE3HoTaGxKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aA3D1IhSCKQz7ydTdRheC5zDEQ2AVfQeUKpiJ99CzJc=;
        b=DlMtsUTBz4o4Z9WtXDs8X2nlCmHvyCrBDAG8YuGtZsYLHajqfavO8CypU1U89OLMp3
         LjXmeyzHXYyQ8GLO6oemR54xWMzLJFwaJuot7P95raFiTkAGhSbsxpOiBpWqpTmh46Oc
         Hi1rScXy3x5rjgioNu96NcKzQesS9ZmUaFAEw7ko/aERBF4M8ipQrfT1MIg3XCLlhp0L
         m2wVzbMSsyPdL9+SLcL3Ht9Av79Wr6vnRIUyeOvM2KlLRjg3WyG90Sn8jR8ClXNLZMnF
         Rno6NjokU2dP3HJPR/nDgGIkWd9/EAhvBUUtwUTyzN/FN/EGghT5ho0I92gq4TViEELi
         L0VA==
X-Gm-Message-State: AA+aEWaGGgXjVh9e8+Sf/5Y1z4E47yrKf/039vbH3QInBsS7L2FbnlY8
        A6//zuiYWjEuHRAN8xtCV013ogeevx0=
X-Google-Smtp-Source: AFSGD/WCHmUqRCJ3JZHBdYVvgonU86SXO4d60OEblqmQxipUmuJ+0ei9zUZD5t22o0QbSPcIWdDe5w==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr5535109wmd.63.1544609890293;
        Wed, 12 Dec 2018 02:18:10 -0800 (PST)
Received: from localhost ([49.248.93.253])
        by smtp.gmail.com with ESMTPSA id q9sm2941791wrv.26.2018.12.12.02.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:18:09 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, mka@chromium.org,
        khasim.mohammed@linaro.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: [PATCH v1 1/2] dt-bindings: iio: adc: Add binding for ADC on pms405 PMIC
Date:   Wed, 12 Dec 2018 15:47:54 +0530
Message-Id: <3aac8c4cd7648589d0eef994376357509e284030.1544599950.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1544599950.git.amit.kucheria@linaro.org>
References: <cover.1544599950.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1544599950.git.amit.kucheria@linaro.org>
References: <cover.1544599950.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMS405 contains a variant of the spmi-adc-rev2 ADC. Create a new
compatible inorder to handle any differences.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
index b3c86f4ac7cd..7ee94496b144 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
@@ -13,6 +13,7 @@ VADC node:
     Definition: Should contain "qcom,spmi-vadc".
                 Should contain "qcom,spmi-adc5" for PMIC5 ADC driver.
                 Should contain "qcom,spmi-adc-rev2" for PMIC rev2 ADC driver.
+                Should contain "qcom,pms405-adc" for PMS405 PMIC
 
 - reg:
     Usage: required
-- 
2.17.1

