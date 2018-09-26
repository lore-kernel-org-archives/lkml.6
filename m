Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555DFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DCD214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="zmd/Kf+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DCD214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeIZRuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:50:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35105 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbeIZRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:50:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id o18-v6so1954918wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 04:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=oJgyjfFnB/c0ld5gvsQrTib86D/xgAZeu+wwpVVWjmU=;
        b=zmd/Kf+rTLIC9deyHP+JbHYP24UabfGrQpug8+gFK138wE6s2epjWOeyFnOkMbLwkT
         uLkxpJvKb5OaxjNiHjLPVhnp1fvQZSSuYIMmKA13gA4gW1vpB18W7A88VKrE83ODitSl
         5kHMH0jKclQMkzmwXSSJz8z+Q0vTN1XfjazQGLg5IxwDviuUxoCKrn/V4NCsEVIRAO+b
         Y76haUhx05kVepC/60Gip/o7PbWP2NnLmheTnhbK8/XffwxYnXZLqlwPCmrdD1S0ps13
         Ip9vfLLZJxUnjNwH+LwTvcfexVfteMZgxfwdUAgnudc0DVCBsXGNyBvQZK5vsyOomgOr
         avJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=oJgyjfFnB/c0ld5gvsQrTib86D/xgAZeu+wwpVVWjmU=;
        b=fss6uu+0b0FK/HrixVT/0T/qEcOnxx49USc8tHG3fqAERjf51aF/R46rpIB5VvK1TM
         oaBUv67+z9NNvunS68eU9sP3i7JR8MOTFve8Q9skbWQUPioqgp4islSgDjHi34nEJ1VJ
         krqpYUcw6M1Qqa7qiZU1FVlik3LKSK6Sh9GZ4f0Mtev9mGKzyxAilc0UVLqNLP/Id0vP
         mkMNFD3QLj+/5QTr0MM+fspaOwSfPcbLr2iJ+3MmmHTTiYkXkIbvBjJ/tjQg4HfK3LVV
         IQ6YOZv5QLqSu2Ssa2ubqu2JBHJPIzL/XAsIN0thMZpVJjvpCwIhLB3KEU2xoH2mnwh8
         W1HA==
X-Gm-Message-State: ABuFfogWBsZiH1kMwAJ7oOnele61keMXJDfofLAKr7KcH1nVQdlCPzgA
        PBOoZhh6jEEhnPOia3J8w23Ps8KjLmZuTA==
X-Google-Smtp-Source: ACcGV6196wZ8RaUvSAZMLmPgQX0Co28ROn7mdeYKsP+PPmh8XOgI5CO29L/2+sLb8XH9zZHuvdr2Vg==
X-Received: by 2002:a1c:b54b:: with SMTP id e72-v6mr3893146wmf.117.1537961888839;
        Wed, 26 Sep 2018 04:38:08 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3551658wro.84.2018.09.26.04.38.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 04:38:08 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: Use mmc@ instead sdhci@
Date:   Wed, 26 Sep 2018 13:38:07 +0200
Message-Id: <84c0bf4f601d9bb30d8caeafa7df3c081009c971.1537961882.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc name is recommended based on devicetree specification.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index e22507e23303..ca6425ad794c 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -219,7 +219,7 @@
 			#size-cells = <0>;
 		};
 
-		sdhci0: sdhci@e0100000 {
+		sdhci0: mmc@e0100000 {
 			compatible = "arasan,sdhci-8.9a";
 			status = "disabled";
 			clock-names = "clk_xin", "clk_ahb";
@@ -229,7 +229,7 @@
 			reg = <0xe0100000 0x1000>;
 		};
 
-		sdhci1: sdhci@e0101000 {
+		sdhci1: mmc@e0101000 {
 			compatible = "arasan,sdhci-8.9a";
 			status = "disabled";
 			clock-names = "clk_xin", "clk_ahb";
-- 
1.9.1

