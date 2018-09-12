Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680EEC4167B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124A020854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="wrccSuDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124A020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeILXim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:38:42 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52608 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeILXim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:38:42 -0400
Received: from trochilidae.toradex.int (75-146-58-181-Washington.hfc.comcastbusiness.net [75.146.58.181])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 914D35C0119;
        Wed, 12 Sep 2018 20:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536777175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ggryZPm7Nbcl1+QmrAzFq0FnTQl2UAMh8dfW1kDXmuc=;
        b=wrccSuDKe3c44HMkSHD1WM5Pn27XMPelmUv/tBMXAFNAqGqpfI2+OLOycpJJHDSvR046Ax
        6c9k62FWBbVC0Y3GJ61wFlQOQT+N1tvEYj16NbdTFuEm0u3TgOsIIG2SECqN1HPLhCYs47
        JTQRjeQVM9itJFIn5vZWM5Nl7yq+jbk=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, p.zabel@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        architt@codeaurora.org, a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 5/8] dt-bindings: display: add data-enable polarity property
Date:   Wed, 12 Sep 2018 11:32:19 -0700
Message-Id: <20180912183222.25414-6-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to specify the data-enable polarity required by a dumb VGA
DAC converting parallel RGB to VGA.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../devicetree/bindings/display/bridge/dumb-vga-dac.txt         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
index 164cbb15f04c..727111ade203 100644
--- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
+++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
@@ -18,6 +18,8 @@ graph bindings specified in Documentation/devicetree/bindings/graph.txt.
 
 Optional properties:
 - vdd-supply: Power supply for DAC
+- de-active: Polarity of the data enable signal. 0 for active low, 1 for
+  active high, unset for system-specific defaults.
 
 Example
 -------
-- 
2.18.0

