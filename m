Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF409C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B248520883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547041973;
	bh=V8Aa4L9MFustJlRlebWUaU+P7eKpfXr/Qrn9gilL8z4=;
	h=From:To:Subject:Date:List-ID:From;
	b=iWDD0D0kRdzwleIjqhBHUiSfnDoJ1Qqnm/qIT9QnLW6dZlEyA6elDL4gMIJmvb7Gv
	 0iZM4uhToaaUrtTXnDws2omn0R7O2JYF7XVMT5Yp4H7jBM3Jr3lncXIUTOT4m33GOJ
	 eBFaYJq1nLUpzXCzMp/XQFVDDnVXcPGOcqP0NDyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbfAINwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:52:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbfAINww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:52:52 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD78C206B7;
        Wed,  9 Jan 2019 13:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547041972;
        bh=V8Aa4L9MFustJlRlebWUaU+P7eKpfXr/Qrn9gilL8z4=;
        h=From:To:Subject:Date:From;
        b=UOTn7Q86pqZSU6hEoTv3iPwc3WyUH6edcMQCFiA440hU9ZA0bEBU3HbU1njsDaNN9
         vR8l0JizBLHVWTrIbrLi4DvohQKh8V1wJC02bIaAGvbfaJlA/sPkQ6D8QyRWr6oH/+
         P2e4uKrz8zpvOLxVi3alcZBQxaHFkpazgiAhfKHw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: s3c2416: Fix xti node's missing reg property warning
Date:   Wed,  9 Jan 2019 14:52:48 +0100
Message-Id: <1547041968-7513-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the DTC warning for xti node:

    arch/arm/boot/dts/s3c2416-smdk2416.dts:23.12-28.5:
        Warning (simple_bus_reg): /clocks/xti: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c2416-smdk2416.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
index 5164386aff3a..cb371bf72f64 100644
--- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
+++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
@@ -19,9 +19,12 @@
 
 	clocks {
 		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		xti: xti {
+		xti: xti@0 {
 			compatible = "fixed-clock";
+			reg = <0>;
 			clock-frequency = <12000000>;
 			clock-output-names = "xti";
 			#clock-cells = <0>;
-- 
2.7.4

