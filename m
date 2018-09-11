Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AC4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E732086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E732086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeIKNp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:45:56 -0400
Received: from foss.arm.com ([217.140.101.70]:39940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbeIKNpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:45:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A655A7A9;
        Tue, 11 Sep 2018 01:47:38 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89EF03F71F;
        Tue, 11 Sep 2018 01:47:36 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, robert.walker@arm.com,
        devicetree@vger.kernel.org, robh@kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pierlisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] dts: juno: Enable coresight tmc scatter gather in ETR
Date:   Tue, 11 Sep 2018 09:47:21 +0100
Message-Id: <1536655641-26192-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not enable scatter-gather mode in the TMC-ETR by default
to prevent malfunctioning of systems where the ETR may not be
properly connected to the memory subsystem to allow for simultaneous
READ/WRITE transactions when used in SG mode. Instead we whitelist
the platforms where we know that it is safe to use the mode.

All revisions of Juno have a proper ETR connection and hence
white list them.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pierlisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index ce56a4a..3596e5d 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -199,6 +199,7 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
+		arm,scatter-gather;
 		port {
 			etr_in_port: endpoint {
 				slave-mode;
-- 
2.7.4

