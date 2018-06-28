Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D209C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F169C27288
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F169C27288
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934276AbeF1LXV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:23:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45245 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934048AbeF1LXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:23:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id g3-v6so4189020ljk.12;
        Thu, 28 Jun 2018 04:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2fCC7Oq0RDTr2j0iuG45YdJUOWsTLRAo7V8ksKknsiI=;
        b=ewOzlBM++lkTO7Z+phjAY+QTu0BvJzeekvIORh6e1qk31QDbVAgC2WmmCPTijWhKQV
         ilC2sY8izfeBvakzGRfdMISVEgvNH4to6HCOopq4KgbGuHHK7BaMFdOHP7V3SSdkfs+i
         p3aho4QVunPaDv6vJmnw7RLLG61xLyvmLDIK0UBpCEXkNTWRoxCL1s3ujF++9mzDTe3d
         34/C3FJ9eygSWmc0T9YFi3+4FdL6d7crOG4yF8sVhtp+QancMvyhJpGLBd8VVf6Dt7ix
         rJyM0fW8g8kYGAvnaVy7na4gHHw2QOzwdmKiN5vnk0BGhVzrXKjWaBwzNShzX+ExUjAW
         9HTg==
X-Gm-Message-State: APt69E1sIXZtayXmo0YVe54u00rV1BBg3Nq/bapmLFEepMzvYW3MVyDE
        TKr27xRG4NKC9ru2CTBOeRU=
X-Google-Smtp-Source: AAOMgpeMSLa95W3PJ3FtuFMvwE2TJei7qmCMLsmBv0SnImd7Thj2ZbcWGcVE4OlCdXBweDsO9u1w9w==
X-Received: by 2002:a2e:96c6:: with SMTP id d6-v6mr1001680ljj.21.1530184997288;
        Thu, 28 Jun 2018 04:23:17 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q14-v6sm1237919lfh.87.2018.06.28.04.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 04:23:16 -0700 (PDT)
Date:   Thu, 28 Jun 2018 14:23:04 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.shevchenko@gmail.com,
        axel.lin@ingics.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] regulator: bd71837: Remove duplicate description from DT
 bindings
Message-ID: <b4d847919a7c72365478240f443debd2601a073e.1530184909.git.matti.vaittinen@fi.rohmeurope.com>
References: <3f1f74f57cbe2d4af395219da841df63daedc1f7.1530184909.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f1f74f57cbe2d4af395219da841df63daedc1f7.1530184909.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same general chip description was written in MFD and Regulator
binding documents for ROHM bd71837 PMIC. Remove description from
regulator binding as suggested by Rob H.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../devicetree/bindings/regulator/rohm,bd71837-regulator.txt      | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
index 4edf3137d9f7..76ead07072b1 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
@@ -1,13 +1,5 @@
 ROHM BD71837 Power Management Integrated Circuit (PMIC) regulator bindings
 
-BD71837MWV is a programmable Power Management
-IC (PMIC) for powering single-core, dual-core, and
-quad-core SoC’s such as NXP-i.MX 8M. It is optimized
-for low BOM cost and compact solution footprint. It
-integrates 8 Buck regulators and 7 LDO’s to provide all
-the power rails required by the SoC and the commonly
-used peripherals.
-
 Required properties:
  - regulator-name: should be "buck1", ..., "buck8" and "ldo1", ..., "ldo7"
 
-- 
2.14.3

