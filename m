Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC66C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B472087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B472087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeIKWBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:01:35 -0400
Received: from foss.arm.com ([217.140.101.70]:46842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbeIKWBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:01:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EED807A9;
        Tue, 11 Sep 2018 10:01:22 -0700 (PDT)
Received: from e107155-lin (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F7973F703;
        Tue, 11 Sep 2018 10:01:21 -0700 (PDT)
Date:   Tue, 11 Sep 2018 18:01:13 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        arm@kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 11/11] dts: tc2: Update coresight bindings for hardware
 ports
Message-ID: <20180911170113.GA27663@e107155-lin>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-12-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536661032-30481-12-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:17:12AM +0100, Suzuki K Poulose wrote:
> Switch to the new coresight bindings
>

I still see the below warnings:

vexpress-v2p-ca15_a7.dtb: Warning (graph_child_address):
	/replicator/in-ports: graph node has single child node 'port@0',
	#address-cells/#size-cells are not necessary
vexpress-v2p-ca15_a7.dtb: Warning (graph_child_address):
	/funnel@20040000/out-ports: graph node has single child node 'port@0',
	#address-cells/#size-cells are not necessary

I need the below patch to fix them, let me know if it looks OK, I can
amend and apply.

Regards,
Sudeep

-->8

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 3a5090616bc6..8b926c30ccd1 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -443,11 +443,7 @@
 		};
 
 		in-ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
+			port {
 				replicator_in_port0: endpoint {
 					remote-endpoint = <&funnel_out_port0>;
 				};
@@ -462,11 +458,7 @@
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
 		out-ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
+			port {
 				funnel_out_port0: endpoint {
 					remote-endpoint =
 						<&replicator_in_port0>;
