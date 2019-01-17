Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD227C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E302205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="x5OMFGL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbfAQQtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:49:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39496 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbfAQQsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:48:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so1776638wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qe4H+2eNPYWTy0WXwleWfBgLcKUZkINmGC1u6LYU6U4=;
        b=x5OMFGL8acKRnOqPLbojSEaTT9XYMuxLPZtLJibk4r/bocq9sUOE3dzBdIoVUHQMCC
         qGm0hEONYIaDXH43xd4sL4Jol3RQrNzmSkYsrbRDT8IGPJOtTwawLAB5zvO571pcPrV1
         o4iLQxwlxHrhKM5svOlXsUcJP1qxnReVv8SB+xG74ErV94h9/mEIdocafBp1yZaSjIw+
         Hgy9OpJBZY/FD/p5uMjDDD0Rcxvl8+iuAAp+bgFKyzDnfGrBINyB9COYYnPThf9aDStR
         ClaGAOTOnYFDyKTtiz5o63G7UFMXqpr01mLfNBNTyGUaLJk3pPjDVMFoWML0U2wxxNmA
         hFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qe4H+2eNPYWTy0WXwleWfBgLcKUZkINmGC1u6LYU6U4=;
        b=hw3Q7hWS+2ciY5xb/t1HM+cQmRdfc+MgocpkCesejrfYQAbdXhwFpxWga/dx8KgTgx
         1cH24bSo7NR2OFr4U6QW3jIo6UFlXtS46k2LDqFHb1j4YFEAmS82XAj0YHrC1moMJPYj
         9haZHKGuyu0TQQpxijGZykGNcHX6Z+m26GU6I3w9NsBNf/QygNQ7NTM4OxhlFkfqIxEh
         xeAL4KeIVxSovV9q6VWJlO1XtiWz3v1RlZwNK3eh6iH/cedhrZUOmtgPAUgXWB4lnwsV
         u4YXCpaVWpb9b4nbSbIulluB+e5rdvxO8GzNHU+6timqy4MlO2TEGXa8WdyiwOxA8/4B
         rRJg==
X-Gm-Message-State: AJcUukcghTXCZZQ72B4imcSCq5o7pQjeSuAC/kQlN6UX2z8ARp5PFu9k
        aMrX6oNx8AV6f8BRWnRgclUbDg==
X-Google-Smtp-Source: ALg8bN5dBCqpxDPx5Fqv1K3bh7nZQBZfNVPzuMBKEHIofvXRO8AnLNWAJczTP81ePhXkARu5+ny46A==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr13203401wmg.42.1547743732589;
        Thu, 17 Jan 2019 08:48:52 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id j8sm99263199wmd.0.2019.01.17.08.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 08:48:52 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 4/4] arm64: dts: meson: g12a: add clk measure support
Date:   Thu, 17 Jan 2019 17:48:38 +0100
Message-Id: <20190117164838.8008-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117164838.8008-1-jbrunet@baylibre.com>
References: <20190117164838.8008-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock measure device to the g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index bd24de947a5b..0d3d3af8ea6f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -181,6 +181,11 @@
 			status = "disabled";
 		};
 
+		clk_msr: clock-sensor@ffd18000 {
+			compatible = "amlogic,meson-g12a-clk-measure";
+			reg = <0x0 0xffd18000 0x0 0x10>;
+		};
+
 		gic: interrupt-controller@ffc01000 {
 			compatible = "arm,gic-400";
 			reg = <0x0 0xffc01000 0 0x1000>,
-- 
2.20.1

