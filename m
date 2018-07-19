Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46C5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798B920673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798B920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeGSFKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:10:46 -0400
Received: from hermes.aosc.io ([199.195.250.187]:40590 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbeGSFKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:10:46 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 0BCF49ED91;
        Thu, 19 Jul 2018 04:29:12 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 1/3] dt-binding: mmc: sunxi: add H6 compatible (with A64 fallback)
Date:   Thu, 19 Jul 2018 12:28:08 +0800
Message-Id: <20180719042810.6546-2-icenowy@aosc.io>
In-Reply-To: <20180719042810.6546-1-icenowy@aosc.io>
References: <20180719042810.6546-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MMC controllers on H6 is similar to the ones on A64, but with some
new features.

Add compatible strings for them (with the A64 compatible strings as
fallback, in order to make them to work with A64 drivers).

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Add A64 fallback.

 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
index 132e0007d7d6..e9cb3ec5e502 100644
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -16,6 +16,8 @@ Required properties:
    * "allwinner,sun9i-a80-mmc"
    * "allwinner,sun50i-a64-emmc"
    * "allwinner,sun50i-a64-mmc"
+   * "allwinner,sun50i-h6-emmc", "allwinner.sun50i-a64-emmc"
+   * "allwinner,sun50i-h6-mmc", "allwinner.sun50i-a64-mmc"
  - reg : mmc controller base registers
  - clocks : a list with 4 phandle + clock specifier pairs
  - clock-names : must contain "ahb", "mmc", "output" and "sample"
-- 
2.17.1

