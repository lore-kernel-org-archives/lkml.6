Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D895FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B1320866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B1320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeINNoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:44:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34839 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeINNog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:44:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10-v6so6852174ljg.2;
        Fri, 14 Sep 2018 01:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OnG4z7E23PL0MxtcV+VBN43uzQ5brhXbeB0dm39JRCM=;
        b=l8caesTqwa5WbnJHm7uNRwWZN2NBE3whTkZF/Ml7ZSyY/dP/6NKFKcA7QNaXa7Brvf
         kpqNGKjxRqC4ODfUlf63gNfiUpDJkz/UTFDz6IK1/skJdqAtmMM2ZTiYTN8seA6zwBz8
         plh7rvveRMWwJtOMw/MuQtYLcC00h3qr1ME90FXNaLfyZFtfLZp6RqZUsZl5ZJ/hjAZ7
         rTesqOPj8OlDqaOOov03KhKxAu4IQJsrsy7wuy3xCSqr/001sCdxWFCJ44iKzWvuaOUo
         zUBB3iFJ3FYsZS9D3U/0ahEXtzSFTkAaNXhsOO3p3qlT6DROVsKTaOjA3+WxTOPxKfz3
         o+hw==
X-Gm-Message-State: APzg51AD91AgIwt6m5RXbiMyftrDx+3F+/HuRs1WB32uLDMquF3zpyMC
        WpxIK+3W4lvjUGx41/5TAFg=
X-Google-Smtp-Source: ANB0VdbgSkPb0Pf1BQ54/+mFuN1OxE6aZbbOkB2F1lFc8mhwyI5Z/AiSEOAp8ETz3p0I2KsO9OoH8g==
X-Received: by 2002:a2e:9854:: with SMTP id e20-v6mr6938329ljj.143.1536913870650;
        Fri, 14 Sep 2018 01:31:10 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t15-v6sm1096942lft.41.2018.09.14.01.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 01:31:10 -0700 (PDT)
Date:   Fri, 14 Sep 2018 11:30:58 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, sboyd@kernel.org,
        mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v3 3/7] mfd: dt bindings: add BD71847 device-tree binding
 documentation
Message-ID: <8d07060eab11d1163f0908cf0acdcece25896add.1536912922.git.matti.vaittinen@fi.rohmeurope.com>
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

Add ROHM BD71847 Power Management IC MFD binding information to
device-tree binding documents.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt       | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
index 3ca56fdb5ffe..a4b056761eaa 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
@@ -1,16 +1,17 @@
-* ROHM BD71837 Power Management Integrated Circuit bindings
+* ROHM BD71837 and BD71847 Power Management Integrated Circuit bindings
 
-BD71837MWV is a programmable Power Management IC for powering single-core,
-dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is optimized for
-low BOM cost and compact solution footprint. It integrates 8 Buck
-egulators and 7 LDOs to provide all the power rails required by the SoC and
-the commonly used peripherals.
+BD71837MWV and BD71847MWV are programmable Power Management ICs for powering
+single-core, dual-core, and quad-core SoCs such as NXP-i.MX 8M. They are
+optimized for low BOM cost and compact solution footprint. BD71837MWV
+integrates 8 Buck regulators and 7 LDOs. BD71847MWV contains 6 Buck regulators
+and 6 LDOs.
 
-Datasheet for PMIC is available at:
+Datasheet for BD71837 is available at:
 https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
 
 Required properties:
- - compatible		: Should be "rohm,bd71837".
+ - compatible		: Should be "rohm,bd71837" for bd71837
+				    "rohm,bd71847" for bd71847.
  - reg			: I2C slave address.
  - interrupt-parent	: Phandle to the parent interrupt controller.
  - interrupts		: The interrupt line the device is connected to.
-- 
2.14.3

