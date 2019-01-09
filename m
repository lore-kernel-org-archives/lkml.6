Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907B3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB3F206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547041394;
	bh=B8EnQXnmQF8aRO0BOJvkqohJeQcNtH7sFCi0YBZ+gLw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=opznImp2IHXmhgxslhEfKmNYEWlSQb/4653ZCc8n8sHDVa19fs6/18aGopnWqsK9w
	 gEwd9tffSFbGf1oJpMfjyZFwn0anBxJmrkqN05mRpyd4QkLpbz6UfJ8bMQX7lFLvGv
	 kn2Y7rfe2rNZcigqmQhi6goKytpT8vSeJ8Z/FdP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfAINnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:43:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730694AbfAINnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:43:11 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71B1420660;
        Wed,  9 Jan 2019 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547041391;
        bh=B8EnQXnmQF8aRO0BOJvkqohJeQcNtH7sFCi0YBZ+gLw=;
        h=From:To:Cc:Subject:Date:From;
        b=Okkf2CmbjiQOzyld8AoLl1OfRu0bpXW0JtMFyhkt6OxSU2wEQhbPu0CjL4bGNh0Mn
         OPOq2QJZpjpn5qjX2giALYaHyhaLl6z7WRabhCMpI8qRAF8DNG7fnZzYeEY2xSycE/
         JZA0/SEVK9o2n4nsDieHlTsfbgRVtS4YI4gzkQFM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH] ARM: dts: s5pv210: Fix onenand's unit address format warning
Date:   Wed,  9 Jan 2019 14:43:03 +0100
Message-Id: <1547041383-16924-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Devicetree specification, the unit-address must match the
first address specified in the reg property of the node.  Fix the DTC
warning onenand node:

    arch/arm/boot/dts/s5pv210.dtsi:81.29-93.5:
        Warning (simple_bus_reg): /soc/onenand@b0000000: simple-bus unit address format error, expected "b0600000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

The remaining warning is wrong clock-controller subnode of fimc camera.
    arch/arm/boot/dts/s5pv210.dtsi:578.32-580.6: Warning (simple_bus_reg): /soc/camera/clock-controller: missing or empty reg/ranges property
The subnode in my understanding does not follow bindings and the driver.
The driver with current s5pv210.dtsi will not register a clock provider... but
I do not have a device to confirm this.
---
 arch/arm/boot/dts/s5pv210.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index cc22c9db80d2..26ea5c66d8ce 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -78,7 +78,7 @@
 			};
 		};
 
-		onenand: onenand@b0000000 {
+		onenand: onenand@b0600000 {
 			compatible = "samsung,s5pv210-onenand";
 			reg = <0xb0600000 0x2000>,
 				<0xb0000000 0x20000>,
-- 
2.7.4

