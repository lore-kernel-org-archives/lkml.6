Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC14FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93352146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93352146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeINNnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:43:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33172 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeINNnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:43:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id m26-v6so7168417lfb.0;
        Fri, 14 Sep 2018 01:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJ8OQY9Tv0r2rVN79rUGwkvQb5t3lj0UF49ST2HLebU=;
        b=K3ebTbAMyvRrsdW0Njd4YnMLMmg+zuDNVOUR/Kk0aW4ks1QjPcr2vVea2P4YdiOMoU
         hwJkTOQQAiRlDPOf4hYzwjp+3X9olP+ZSbzj1iP0jOrcfyx/1GIiP/XS5K/se8jIhLeI
         4k8INo0FAagLIwTaSa5ucRPJNUZlMnyht+TwJEONaTkGZYj68eFKQIaq44EglfS6jdZS
         pWmbLBxwYZTGBuyB6fSNWa80/1j1qjssBfUqW1cACGMBl+HKVfV73rNEjC+B2cra8AY0
         Hjg5gdGuD7gX/UA45Zv1vVi1x07L4fqIcbhsQAmQ5PekNPoVKLncQRAIz+FLr7sy7N3X
         Z+VQ==
X-Gm-Message-State: APzg51AMXN9LUE8Xj8Y3yJQwtLHViMi9ltyvVYAM4bNW8rQ3mLgChuw/
        DjdoIWIBF4jnqhcXtRuWTkJ6NIcAfhM=
X-Google-Smtp-Source: ANB0VdY+TcHHej2joMSTBqx6AGT/kaa6zrETvLEjRi4aHzuL57pJizTRQJLPhTVmJUFONSQvidCirw==
X-Received: by 2002:a19:c449:: with SMTP id u70-v6mr2642859lff.141.1536913814034;
        Fri, 14 Sep 2018 01:30:14 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t8-v6sm145520lfd.13.2018.09.14.01.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 01:30:13 -0700 (PDT)
Date:   Fri, 14 Sep 2018 11:30:06 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, sboyd@kernel.org,
        mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 2/7] regulator: dt bindings: add BD71847 device-tree
 binding documentation
Message-ID: <1ad7584e0e610de5564226dfb189e7e75d21951d.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ROHM BD71847 Power Management IC regulator binding information to
device-tree binding documents.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/regulator/rohm,bd71837-regulator.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
index 76ead07072b1..4b98ca26e61a 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
@@ -1,7 +1,9 @@
-ROHM BD71837 Power Management Integrated Circuit (PMIC) regulator bindings
+ROHM BD71837 and BD71847 Power Management Integrated Circuit regulator bindings
 
 Required properties:
- - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7"
+ - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7" for
+                   BD71837. For BD71847 names should be "buck1", ..., "buck6"
+		   and "ldo1", ..., "ldo6"
 
 List of regulators provided by this controller. BD71837 regulators node
 should be sub node of the BD71837 MFD node. See BD71837 MFD bindings at
@@ -16,10 +18,14 @@ disabled by driver at startup. LDO5 and LDO6 are supplied by those and
 if they are disabled at startup the voltage monitoring for LDO5/LDO6 will
 cause PMIC to reset.
 
-The valid names for regulator nodes are:
+The valid names for BD71837 regulator nodes are:
 BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6, BUCK7, BUCK8
 LDO1, LDO2, LDO3, LDO4, LDO5, LDO6, LDO7
 
+The valid names for BD71847 regulator nodes are:
+BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6
+LDO1, LDO2, LDO3, LDO4, LDO5, LDO6
+
 Optional properties:
 - Any optional property defined in bindings/regulator/regulator.txt
 
-- 
2.14.3

