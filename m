Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F0CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2352081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WIwmr0Tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2352081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeKHX3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:29:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37602 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeKHX3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:29:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id o15-v6so17709869wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=biN48QhXjlPL6+PrPs5FkgLNiaQcQ3d8ZapoGQWwDGM=;
        b=WIwmr0TvCycOt/qTQMnImtNWfSsE8wfhPg+OZYIUHU7dF1uxIXJBU+Kjug3kbINQSR
         nFLTcq/bYxIUsJKbgOigtBhhcBz6X91UNLkYudIsG9F1G1OO+Fsc9i+3HGqPNBHh6wJk
         tVJv5abV5I1RqYUM7QhtQCZlJzRhV0REasGEM2tYE/Ds7E4UZzJcutDZKZxcP9URWNhS
         AyymguUpHNdED3uu/Q0yuSxdlSNqXxx8TP0qkl9xh5xdFW4lmnuQMVzUrrsHLqlBsdU9
         Z1BHniOysRurxp78mfuTEtX2rvMzd/A/+aQIxzHWiclcMnHH+6xuusgHIeWXke3CnOGL
         mOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=biN48QhXjlPL6+PrPs5FkgLNiaQcQ3d8ZapoGQWwDGM=;
        b=jdPVYYrCojJ2hAZubj4bBfGpP9Ucx6WkFBJxogTuQqbPfgdLb8nlD6XxhDGozQABeY
         a2OR4PM2RabyCz9ELzPnRwOvyPYGsUdBZ8pP6T/yo3kHqejw0x52wcERvGpz2u1Olttv
         bkgPkYPMnMUZPYyUBteNIbMh8yQ/DlQ3bwBAo15gW09///bWaNGMEcvoNpW4mrQtSSox
         BDjddhXb+A0rnE4ytYpSR3OWentkA3X0V3l2Y/1Q+JFEGp1mlGD2RaSn3MZMTomFl/TA
         H4YXwbAKv1dKhezughLOicA3bFp5I9tB1uCvBg+im6eBgzT9q1bvcQVs5M8U37KbRdE0
         /0PQ==
X-Gm-Message-State: AGRZ1gINl3T0G3Op2g6SoF7OGYKEbKlp31L6eGu4hGjEowvJyFnSbgSX
        NlPZSzp7E+TzTRLOWxO5ADmVgTCaQME=
X-Google-Smtp-Source: AJdET5cl0XBF1MHr71F3J01006i/ZUwHebSImNSp1gw6J43kwYWHcHBE93zs6DBj/D9ONmHJkntb9w==
X-Received: by 2002:adf:fb89:: with SMTP id a9-v6mr4046902wrr.219.1541685242649;
        Thu, 08 Nov 2018 05:54:02 -0800 (PST)
Received: from boomer.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p6sm2740329wrx.39.2018.11.08.05.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 05:54:02 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] Documentation: bindings: Add missing Amlogic SCPI sensor bindings
Date:   Thu,  8 Nov 2018 14:53:51 +0100
Message-Id: <20181108135352.8459-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108135352.8459-1-jbrunet@baylibre.com>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amlogic,meson-gxbb-scpi-sensors is both the driver and DT but is not
documented. Just add it to amlogic's scpi documentation

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic,scpi.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic,scpi.txt b/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
index 7b9a861e9306..5ab59da052df 100644
--- a/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
@@ -17,4 +17,11 @@ Required sub-node properties:
 - compatible : should be "amlogic,meson-gxbb-scp-shmem" for SRAM based shared
 		memory on Amlogic GXBB SoC.
 
+Sensor bindings for the sensors based on SCPI Message Protocol
+--------------------------------------------------------------
+SCPI provides an API to access the various sensors on the SoC.
+
+Required properties:
+- compatible : should be "amlogic,meson-gxbb-scpi-sensors".
+
 [0] Documentation/devicetree/bindings/arm/arm,scpi.txt
-- 
2.19.1

