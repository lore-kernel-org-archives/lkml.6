Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E393C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E5520891
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E5520891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeILQxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:53:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34655 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:53:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id c29-v6so1421452lfj.1;
        Wed, 12 Sep 2018 04:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OnG4z7E23PL0MxtcV+VBN43uzQ5brhXbeB0dm39JRCM=;
        b=JeNF5anzm1aR53y5kocKEdr0uBdj0zeJ/3MFhavuPNFHL9lsBxJE2drP3xrw/4FQAV
         obKsn0iAbH3E6APiw1NUwtGn7al9lIzKiX/jcwqclOc6JZ9dTgLC4b/9tHavSssJa3m8
         jbY5MSsAwMgn7BxXR+4xOOAmrINXxSbYwwiqCiO+Ch2y9UdknCqjdY12TP86EMG8zgFA
         h0zaS0LbvR0ovusPNKWEKK2Yc9aJtGy3ZHl/62E6eVr8vuUyaFD+aevw6THtAZDIn9va
         W0mmMa3Dq7WK8mG0DeaaH4TGE9MlnwHMaTTTROwAZ05/SMRYPmkmaobjBbBGjwitVnbd
         4JLw==
X-Gm-Message-State: APzg51Cz023dacNSiKoK5yMfZf/SPX3CZR0WI5skCuHhicrTMj7FywzA
        ASEN1wqQiztC8Hd+JPQA5Xk=
X-Google-Smtp-Source: ANB0VdZF5+PtXytoQ1h5SXdVPA9LHlLj5hHDV6HwWlzzj6ZZxEKdbixWTj/hnG/cJHV7UlsjmLCviw==
X-Received: by 2002:a19:2287:: with SMTP id i129-v6mr1229088lfi.20.1536752972027;
        Wed, 12 Sep 2018 04:49:32 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id r22-v6sm149000ljh.22.2018.09.12.04.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 04:49:31 -0700 (PDT)
Date:   Wed, 12 Sep 2018 14:49:18 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH v2 3/7] mfd: dt bindings: add BD71847 device-tree binding
 documentation
Message-ID: <8800d9c24dd98669c6ecf2270355be528901e685.1536750863.git.matti.vaittinen@fi.rohmeurope.com>
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

