Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9B920661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9B920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbeHaTTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:19:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47031 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbeHaTTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:19:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AA98D22A39; Fri, 31 Aug 2018 17:11:57 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9DAFF22A3E;
        Fri, 31 Aug 2018 17:11:29 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 7/7] MIPS: dts: mscc: enable i2c on ocelot_pcb123
Date:   Fri, 31 Aug 2018 17:11:14 +0200
Message-Id: <20180831151114.25739-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
References: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the i2c controller on ocelot PCB123. While there are no i2c devices
on the board itself, it can be used to control the SFP transceivers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
index 2266027759f9..ef852f382da8 100644
--- a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
@@ -36,6 +36,12 @@
 	};
 };
 
+&i2c {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	status = "okay";
+};
+
 &mdio0 {
 	status = "okay";
 };
-- 
2.19.0.rc1

