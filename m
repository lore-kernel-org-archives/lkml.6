Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C93C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D731620857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="PNV6khlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D731620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIEJuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 05:50:08 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56320 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeIEJuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 05:50:08 -0400
Received: from trochilidae.hsd1.wa.comcast.net (unknown [IPv6:2601:602:8700:fb00:81ae:bc59:4e6c:42ca])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D16D85C08C8;
        Wed,  5 Sep 2018 07:21:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536124901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fa2S8LkXKohqrWuWhRZbOwlP6LWKzejzFHDyJGyXd2w=;
        b=PNV6khlZJgT9VlN1Q0OA4NCbVVhcbMRH8x/W9R6fD99R2nzHZxOKM9T6pHYX/ElFoRAezm
        mEQQttyd+krIFpam9eheNdezDTLmwF3Dz8hnMBE+lfmVrssMkaztE4bJadEesuJC1A4CtN
        lluVzmhSX+navEhvFNoC1vUbRkTY3QY=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        p.zabel@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/6] dt-bindings: display: add data-enable polarity property
Date:   Tue,  4 Sep 2018 22:21:10 -0700
Message-Id: <20180905052113.21262-3-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905052113.21262-1-stefan@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to specify the data-enable polarity required by a dumb VGA
DAC converting parallel RGB to VGA.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../devicetree/bindings/display/bridge/dumb-vga-dac.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
index 164cbb15f04c..adbd2ca0af2f 100644
--- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
+++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
@@ -18,6 +18,7 @@ graph bindings specified in Documentation/devicetree/bindings/graph.txt.
 
 Optional properties:
 - vdd-supply: Power supply for DAC
+- de-active: data-enable pulse is active low/high/ignored
 
 Example
 -------
-- 
2.18.0

