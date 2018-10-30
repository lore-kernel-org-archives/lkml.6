Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08383C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C351B2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="krN9fpah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C351B2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJ3TPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:15:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52327 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeJ3TPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:15:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so11148078wmw.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LLrFK+YRmk7r6/C5e+K5O5DNC2H0ChSiQcyKfu/3Cr4=;
        b=krN9fpahlQsQxq5OeXZh6U5/htbiWFQ1JX/bIW0XLXhiAqbOJLgiPwIyt/xquXBQ2M
         xfQICSgFwaaGK8BMyqlyodcv0EhrLXXu5PTp76IniQ3rze4+nBY0PdPPUjNN4w+upK+/
         WSk8whdEbYriDWt1h5Q/4wNKKJxtTM7U7e0VgcdKjLlrU0jNvLX1MfKuywhET+oJAPV7
         ylQOsoDp8g2DH2cYuDIFgEJGAkRE3QA9OxvIQ7pOh18WluUCQ16ktm6xnJ35wsxWJlE8
         8wG5XTmL1Ao0avStZJro/5CENjKJzbM7aE0ke1WJxJRwKgPFP3oio5Iyc/ri2YHQOTQc
         enhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LLrFK+YRmk7r6/C5e+K5O5DNC2H0ChSiQcyKfu/3Cr4=;
        b=lV7hvq4ka9d+C36beZ+uzu/V/sUpw3as2v61Wz7Vev6yWgbCgCQjjrvEjRnazU4vbD
         pjeyA+hq4OQnm79FKlIEtea2YhJ+0WFbBNoqLHSVn9iFCs/fMvg/qMuB2HxPk1gbRCgN
         Tdl2KWK9IxsrdILi23Le4Kp+QeCfxRmdBunnfRmluTIuNetlgDbYW7PmZaN+Osp0g2Wv
         f+TNT0xyK5ydAQllOGBaY8Ib8PPk11nx2J+S40ewnMKzSf0yrYUNH4JZH1w6B6OoywMD
         SMPOpTfDJBBY2TRQ/AUjFOw0XXjF0Ku+s0ABL2Z6OCK0kyC+VG9hQh+StUA1HmBR2bvT
         ++vQ==
X-Gm-Message-State: AGRZ1gI9+EMW5iQbtHH/A8YJ+8eqMMRGO7ZH+MzTDzsIczzWxENe5Apt
        b9N7YNSSQ6mpIe5+vOnEtZktiQ==
X-Google-Smtp-Source: AJdET5ff+5LmypP42LGKTaQnSm4G0BfTECA7OdU1dR87xJX2Sw2iiWzL5GNoCvnW49UhtW2EV+LkrQ==
X-Received: by 2002:a1c:6:: with SMTP id 6-v6mr1193057wma.126.1540894960691;
        Tue, 30 Oct 2018 03:22:40 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i204-v6sm26638614wmd.28.2018.10.30.03.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 03:22:40 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] nvmem: meson-efuse: bindings: add peripheral clock
Date:   Tue, 30 Oct 2018 11:22:29 +0100
Message-Id: <20181030102231.4851-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181030102231.4851-1-jbrunet@baylibre.com>
References: <20181030102231.4851-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The efuse found in gx SoC requires a peripheral clock to properly operate.
We have been able to work without it until now because the clock was on by
default, and left on by the CCF. Soon, it will not be the case anymore, so
the device needs to claim the clock it needs

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
index e3298e18de26..2e0723ab3384 100644
--- a/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/amlogic-efuse.txt
@@ -2,6 +2,8 @@
 
 Required properties:
 - compatible: should be "amlogic,meson-gxbb-efuse"
+- clocks: phandle to the efuse peripheral clock provided by the
+	  clock controller.
 
 = Data cells =
 Are child nodes of eFuse, bindings of which as described in
@@ -11,6 +13,7 @@ Example:
 
 	efuse: efuse {
 		compatible = "amlogic,meson-gxbb-efuse";
+		clocks = <&clkc CLKID_EFUSE>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-- 
2.17.2

