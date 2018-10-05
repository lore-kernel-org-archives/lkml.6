Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D65C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EDA208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSrZroaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EDA208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeJEWhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:37:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46730 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbeJEWhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:37:17 -0400
Received: by mail-lf1-f68.google.com with SMTP id z144-v6so1149790lff.13;
        Fri, 05 Oct 2018 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEkMidX6FxpiZSTFa8KISKNbf0++dhdesLBYR/Rbies=;
        b=GSrZroaUf5AOHNuqOF41WdXLoyG59HDiX2qeyBcCVtJ71aNkPPezwfR8PcsYKG1AE5
         urobSipTdm3rq6y9HjnpqGzV0zNl491rhaO4AD0pol97TJHm1f+QV+hyjyElaLedE1BH
         gkUaOAXpoAx1QKnMX2/bKDwlsiZe6vWFj9LjMg9cvVI80KICQw3DdejkYuWRHImYLHrc
         sPjsZ2lZJEaqFCVVt0bsZUqB54obIUgbKi8Dmn9bdcuXDu60Z1iDgqGihjiOHRXLLgFK
         9EvPF+IMJ6UN2yxbVpMqQIDlYn8UT8dHLf1YAj4B3/v73C0p2g3VoS6vo5TI9UL35IFP
         8P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEkMidX6FxpiZSTFa8KISKNbf0++dhdesLBYR/Rbies=;
        b=oabazvVLKN4edEMmmH3MLFWuZy4Ews3cuyWMn4cRDtm/G+lFO3ay+p3c48RO31/tUH
         mAJV5vQB+h0hBHEkQiksGyj3/kuxtepYe/9Q7lM90jNISuwOQq9F5SxOrjUL4F3r6x9F
         asTHB/U3EKgkFiRDyJLL+8Y9cOMfzm41OPweGsy7Y618mdGQeXlpZZm55KuOR/u/FHme
         XL9m8oW12zeqwslguB5ROgpA3UkT+zVkXdhNOfu1oou5yHSlh8O33BWquNOzyReiapZ1
         Lx+cAvHLbWm2XJUxyX8AJ5POC9Vv8Tdeh8Z2NFYOLYMK4qKulEuS4qUo/CMqJg58KEtq
         TkAA==
X-Gm-Message-State: ABuFfoiF6G9AQaT6Ic8hbKFnyg+N5WU5MfzfpYnCZNlDaZoPjuICnXlt
        s7u00mk6SKa57cPnSNM1fl8=
X-Google-Smtp-Source: ACcGV60sUESNjMBioepOaWBIT4jaCs+E/WyNbSCiW4Lg1PT8d7swZtjtBtQiH67UlcQRa3tArGEZLQ==
X-Received: by 2002:a19:c650:: with SMTP id w77-v6mr7448587lff.108.1538753881679;
        Fri, 05 Oct 2018 08:38:01 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1879373lfd.72.2018.10.05.08.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:38:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v1 07/11] dt-bindings: regulator: Document new regulator-max-step-microvolt property
Date:   Fri,  5 Oct 2018 18:36:34 +0300
Message-Id: <20181005153638.1886-8-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain hardware may require supply voltage to be changed in steps. Define
new property that allow to describe such hardware.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 9b525b657fca..0c3a243c95df 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -79,6 +79,8 @@ Optional properties:
 - regulator-coupled-max-spread: Array of maximum spread between voltages of
   coupled regulators in microvolts, each value in the array relates to the
   corresponding couple specified by the regulator-coupled-with property.
+- regulator-max-step-microvolt: Maximum difference between current and target
+  voltages that can be changed safely in a single step.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
-- 
2.19.0

