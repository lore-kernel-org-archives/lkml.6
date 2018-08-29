Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF38C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2CE20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2CE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeH2QeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:34:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38387 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2QeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:34:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id i7-v6so4162737lfh.5;
        Wed, 29 Aug 2018 05:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fjv0PQ8mkkp5qGY/FXYoI2L3ON+Ljd7Bmzy4vrqMuwA=;
        b=NIJeM5FngdeQJg146jf9/YxPGsIxzMDEjhX/hjlMtWbui1DqGgkrDMJyhSHfRD7xAU
         zYqpzN2aSngp851HseqTDvUuXlZLCpNWy4Ymnk6XowNR4OFmmJPtgkrUAnlu8SyHfX2g
         V2LoC3k6mqc8VQmVhIEQd1h6zp3e/UiPUfTRdiiUq+GgqDzSTDqJ0R9yL9CEFY5/8Omc
         qWFtavpioDO9Hoj/AEnrpKgzVxLOfdVnEp5yUd4v0xeotXDoh7cyOf/RgdJc884oCDRT
         abyhqD26v+qCgOSy6gL2+G/FO9kUyLm34T3gITdXsnD6rzW53mNPSUymlmnw5Vc8BoBn
         t+Ng==
X-Gm-Message-State: APzg51AeVpNaQxpACHVdSNNyPLbO8hERVsF+PRCLBIuSW9IryW/ZTlgf
        7d0OHRfCC8D1+nIJTNDp3tw=
X-Google-Smtp-Source: ANB0VdbHuSOA1rS25KklrnPNofqleQM6FuOcQffnYE5dbLOXXTs3qhpjxFj7gxaxou33H/7CMwuB3g==
X-Received: by 2002:ac2:428f:: with SMTP id m15-v6mr4120862lfh.52.1535546258783;
        Wed, 29 Aug 2018 05:37:38 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k65-v6sm706127lje.3.2018.08.29.05.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 05:37:38 -0700 (PDT)
Date:   Wed, 29 Aug 2018 15:37:27 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH 3/8] regulator: dt bindings: add BD71847 device-tree binding
 documentation
Message-ID: <091514c79f91a460c6d29d0605cc1f8d4bfdbed0.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ROHM BD71847 Power Management IC regulator binding information to
device-tree binding documents.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
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

