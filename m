Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CDCC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008202088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008202088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeILQvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:51:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43399 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILQvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:51:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id m84-v6so1330065lje.10;
        Wed, 12 Sep 2018 04:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJ8OQY9Tv0r2rVN79rUGwkvQb5t3lj0UF49ST2HLebU=;
        b=Kv5ZacFoHnQffuWYMLeZnstRhEva8etzDYiQ4uOcdNcko/Uz4nAkW49ReSmI0sfiCI
         WMwIltZSJm82rVEqprY0cS6N1UIBjLzrxparROQgdIDxE3NVc6hxj2HnbflyD5B0ENAF
         kkDLlVNNSTXPDuTU0kIhCgoOPg24vjadmgPsjVhogicyqxXMFfHamOpFj7PiJsfN78Fc
         uum4DqFwrVvUSIrl4b/TLGOXOgbeQq0zEyV2OHXtxsBD5rBus42dE8L3Xfx5dGNRHmwB
         ZHyjsPEvATucg6Z+5V0aXA2siyFAI+OAkuNf7GJ41d9FfjshuU1fqFt5atMQxndqimQ5
         4CXQ==
X-Gm-Message-State: APzg51C7tiLUa1mXwleYuJLRRUVHiGQVxHJ8M0NiqzpnNbeibiLNymYH
        9t+dPRhAmdloK0FeJaYdNdA=
X-Google-Smtp-Source: ANB0VdZ1vhcg8JT4HaASGxx3JoYyrML1RLmO7uMzcvx5QLAQfomDTsXZI9OqUh9WJfGoX0Ts6anNaQ==
X-Received: by 2002:a2e:9095:: with SMTP id l21-v6mr1180515ljg.15.1536752847129;
        Wed, 12 Sep 2018 04:47:27 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y23-v6sm148875ljk.28.2018.09.12.04.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 04:47:26 -0700 (PDT)
Date:   Wed, 12 Sep 2018 14:47:11 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH v2 2/7] regulator: dt bindings: add BD71847 device-tree
 binding documentation
Message-ID: <d1daaf5ebae091d6efe0f7ca4253acefab29a791.1536750863.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1536750863.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536750863.git.matti.vaittinen@fi.rohmeurope.com>
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

