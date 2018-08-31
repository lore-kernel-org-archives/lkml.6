Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC0EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6BA2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6BA2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeHaQK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:10:59 -0400
Received: from mout.perfora.net ([74.208.4.194]:42655 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeHaQK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:10:59 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lp5Pe-1fSA9t2Ice-00ejDI; Fri, 31 Aug 2018 14:03:22 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: pxa: fix power i2c base address
Date:   Fri, 31 Aug 2018 14:03:09 +0200
Message-Id: <20180831120309.8723-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:eDmLJ0B69IWVxihcjvSfxC4hxuxTDA63fcROwj7U6Ox05+L/Y1I
 yBOFOJsp01kGz+46VI6MNRo4P7ok8nj4TVI3KMEg+7YMay+pZ0h0JxBDQ2+b80oErVabPzv
 p5joKo7yX9P8OYDZLUgFgH6z7+I7fYkSCgr++g8R0/3R0etCJDVcd5v6AwDz5zI2PvBu1B9
 Ta6iG3NsDI9WA3tQUCBPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ihx8F3ZSrfo=:qJdYM4TvY5sZGZNZEX6Dz7
 wx17Fmt6ZWycae7kuglBgiFUT2OfTeE5OBCMCl06cV2mS5ZyBDGomfsJvvdbf32Fifo+qjMwK
 rxsrfnYuxz2kn/7lUcJ6dlq024LAXUolsn0gZtS+jPD8vMp5fXNMuMSYKLyKLM0qRjREaxh44
 DMitGd695iXnUBtvWnCY7Fc5NZ7WQ0gTjma/BZZUZAMLV4gAhcwRw6QNErlA/e3YO/Vm2yhP+
 xnMQGwjMSV1otPWLyQI0JEluTS7JMQmNXRB8SfVbpnGfc/Ls2QOEAN8eGXbw1wVgHx1G5Kmv0
 STtjZPz9uvAt4cJCALtf8RcVpmTm4shjXxJjko1G2Wyk/mtb+um1PQUjRGx8cw5ivRFVfA6js
 kETcrinMwuH0uKQzVG4PlymoaGKAPPKIT7Kfy/fA2jrW1FFsbL9Qp5d2tSEYw4w5vQDLj23/1
 ruLn/BTKfwGq38NA9braFl9H5L6a+V3fN/B1v+mh2grSHtn0Ab2j9bHFjReDlkKmqCZiVqHOU
 NETTEAJmnLa1ieeAlzLMlDVZ8QbvNsMWcWITetEPbH4+xIq8KC0RByzZGFOD/3KrncLC1D83C
 2CQBcgw8qXtAT/fAvhbP7dHHsMx7vcf6SCQRwHLi3ORwy6ddHVzGp1C7gV6NL4jlN2i6oHNDp
 t9i1AnxHWh1Fox9HFLZo0QbC5aTIDsZzhOBvN7+zh8eYLqdBmfD+CQKDyWf6CI0t1z2M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one too many zeroes in the Power I2C base address. Fix this.

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>

---

 arch/arm/boot/dts/pxa27x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 747f750f675d..837343370761 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -71,7 +71,7 @@
 			clocks = <&clks CLK_PWM1>;
 		};
 
-		pwri2c: i2c@40f000180 {
+		pwri2c: i2c@40f00180 {
 			compatible = "mrvl,pxa-i2c";
 			reg = <0x40f00180 0x24>;
 			interrupts = <6>;
-- 
2.14.4

