Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84550C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51618205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hNo1rEGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfAQQsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:48:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39489 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbfAQQst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:48:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so1776345wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J19q6XdK6LukgFHT/iRLr1xXTdkoFW905MZs5kCf7/Y=;
        b=hNo1rEGVShboS3metNJ44AIwn4nR92zozMUDNX3syV7JN1GZHHmKNPwd/2sVOkb+CR
         /dHN9S8MCTp2MbWkmvFU7Cnhc+349ozgcHJDtGQidFODb14mBWS237FUsUYpCGB63+8y
         ZzZExrfvNqmvMxwjn+Svk8wpl68B73R3gR0HJIy7ztH82vO86eSr5E3w7ZC83q1xij6T
         Xc5Zz+UfLVn8sxMJpllmCcuZ8YfCiHu0qRsQyBo7yQfOPQefh2UTX4pRbEXMniJApArU
         Ug3BVo6RQpnRSthEjD29IE5fGIl94IiL8ECaoUDHtkdoUt0WDy1iGr1htdxqL2FrmsLK
         CliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J19q6XdK6LukgFHT/iRLr1xXTdkoFW905MZs5kCf7/Y=;
        b=J7OIvohhNbH5urC3iUbpo04XcmL2Q0wrrI2BEjct/mMP5NnYmVHrQiKmib3AxS9YCr
         xNqjJRRMVGx/VJ3Sg/SlL/2914i4TXaKIIPwhxVwQpDUL1VgVX85rbaWU5HBSOLp28gN
         llrOP+5Uura6m1eLUdz2oeVokhIX8FZCpVcaqi/0pPayVvzR6xEF3z26wX+P9uYdDKDP
         XfGOUZVXR6U1psumzyL+OYquch33wXwKCB24bgQEbXH9KEPj8mW2VCoxZQ1Rj2oR2SkM
         aWsVSH8KCI2ga0okadrxfWWFdVXlWS7DQA3Ipc5aaz2wMIlWF+t9v7F3dnJpTLoyYeTf
         gOJQ==
X-Gm-Message-State: AJcUukeVGwGKmzRIyowhNTjw1BeaG+p2tHiSLlZb4Ao/OcuJnIutMHuV
        VeVjnlem5r59iWDHfG6j4k+KRw==
X-Google-Smtp-Source: ALg8bN7kCzRQ9THJH4u6nZLJYqB6+A8uiGnq+CdqgRdEYSULdB6PSAVS2R6usFRmt2+4SpTtOXChkA==
X-Received: by 2002:a1c:8484:: with SMTP id g126mr13055931wmd.117.1547743727732;
        Thu, 17 Jan 2019 08:48:47 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id j8sm99263199wmd.0.2019.01.17.08.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 08:48:47 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 1/4] dt-bindings: amlogic: add new compatible devices to clk_measure
Date:   Thu, 17 Jan 2019 17:48:35 +0100
Message-Id: <20190117164838.8008-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117164838.8008-1-jbrunet@baylibre.com>
References: <20190117164838.8008-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the axg and g12a SoC family compatible to the clock measure bindings

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
index 205a54bcd7c7..6bf6b43f8dd8 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
+++ b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
@@ -9,6 +9,8 @@ Required properties:
 			"amlogic,meson-gx-clk-measure" for GX SoCs
 			"amlogic,meson8-clk-measure" for Meson8 SoCs
 			"amlogic,meson8b-clk-measure" for Meson8b SoCs
+			"amlogic,meson-axg-clk-measure" for AXG SoCs
+			"amlogic,meson-g12a-clk-measure" for G12a SoCs
 - reg: base address and size of the Clock Measurer register space.
 
 Example:
-- 
2.20.1

