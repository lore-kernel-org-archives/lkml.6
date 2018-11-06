Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBF4C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDB420685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RGqN01Ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDB420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbeKGAXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:23:18 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:52246 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388851AbeKGAXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:23:17 -0500
Received: by mail-wm1-f51.google.com with SMTP id l66-v6so5331363wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JJNL3Neu3SfVjw1khgrCqtvFkSG2b/5akHq7tkxYu/8=;
        b=RGqN01SsHX12NyLzsgTiQz0n59uDG3TzYmAINMThRPQ85AQOwMsn48Ar9elt1j87b8
         N1Z3huYbtjsJYq6A57dT4WxfnCvmH6V1FvExgCWniNvoFymv3NVs6m4oUshbxyfaHA/f
         ampTCzRomRtHFN/BCG2nFVNODBVD4+Yj/z/iwWAX/AS2DfcEtlDEUQpV0Jxso95IP1V6
         v9mrcRsRPgdzO2zUbdZJMR6XTruTt7CNhxlbbo2XyiTth7k2U1qrhFUEU77dUo2Z19pD
         ohTgq6yTD7mtqhhPAuvekbdOdY8kz36ubMJkGjQhKZs/avgLQYnoGT0LCbvejnFNiF8t
         fhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JJNL3Neu3SfVjw1khgrCqtvFkSG2b/5akHq7tkxYu/8=;
        b=VzvxnwW87KLlkEMFZAHhRggRMSwyCTeEQqoW97FXYgnBF/DKmMVrXIR4GqMMzr5Ya0
         ECOKsRnqv6a16EEqQMzwk8pM/4FBxx90ichr4ZmzThKaNqHldNFaiLhuwE6WNFeYqwvk
         SZ8NyGSL/1h7GUJJeET68AYaW4GTbFWZW6nrDwfqVPDVA+jtvExmkbKceizS8t/FOZHF
         ruXX2OblXA0GEOpWZCXYxRfWDBbdxSOs8NjBvRaAaDIOkypWElqXf1/AGguU7Va1eSav
         k10g5z/dO7VNyJwgPl6fLggIyVB/VlTwSB/qtkFi4PakN7sb8qN2aSRLoR3G7GAXEW+R
         NEqA==
X-Gm-Message-State: AGRZ1gJqWy375eZak3kA18GZQzg3qZ1l1P/jvQQE+pKf0F60rSus4RiD
        FqtEwHvdSqxqVwJrRHktrue6+Q==
X-Google-Smtp-Source: AJdET5fg0C3uvA9xcG2U7/++bq8gkj06T3bjJaWh7jcyu6FjorilvxtZEMAK45xi+n35DiFOtGVHQg==
X-Received: by 2002:a1c:6c0f:: with SMTP id h15-v6mr2170552wmc.123.1541516259858;
        Tue, 06 Nov 2018 06:57:39 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y131-v6sm1825375wmc.16.2018.11.06.06.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 06:57:39 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] clk: meson: Add video clocks path
Date:   Tue,  6 Nov 2018 15:57:33 +0100
Message-Id: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is an attempt to handle the Amlogic Meson GX Video clock
in the Common Clock Framework in order to move the video pipeline and
HDMI controller clock management out of the Meson DRM Driver.

In order :
- Add support the VID_PLL fully programmable divider used right after the
  HDMI PLL clock source.
- Fix the GXL HDMI PLL DCO
- Add the video clock bindings covering all the video graphics pipeline
  and the HDMI controller.
- Add the clocks entries used in the video clock path

The vid_pll programmable divider is introduced in its R/O form right now,
but will be extended to be R/W in a next iteration.

All dividers are flagged with CLK_GET_RATE_NOCACHE, and all gates are flagged
with CLK_IGNORE_UNUSED since they are currently directly handled by the
Meson DRM Driver.

Once the DRM Driver is fully migrated to using the Common Clock Framework
to handle the video clock tree, the CLK_GET_RATE_NOCACHE and CLK_IGNORE_UNUSED
will be dropped.

Changes since v1 at [1]:
 - Fixed comments from Martin
 - Fixed GXL HDMI PLL DCO
 - Added the missing HDMI controller clock
 - Moved bindings to a separate patch
 - Updated the commit logs

[1] https://lkml.kernel.org/r/1532079581-978-1-git-send-email-narmstrong@baylibre.com

Neil Armstrong (4):
  clk: meson: Add vid_pll divider driver
  clk: meson-gxbb: Fix HDMI PLL for GXL SoCs
  dt-bindings: clk: meson-gxbb: Add Video clock bindings
  clk: meson-gxbb: Add video clocks

 drivers/clk/meson/Makefile            |   2 +-
 drivers/clk/meson/clkc.h              |   6 +
 drivers/clk/meson/gxbb.c              | 773 +++++++++++++++++++++++++++++++++-
 drivers/clk/meson/gxbb.h              |  26 +-
 drivers/clk/meson/vid-pll-div.c       |  91 ++++
 include/dt-bindings/clock/gxbb-clkc.h |  18 +
 6 files changed, 911 insertions(+), 5 deletions(-)
 create mode 100644 drivers/clk/meson/vid-pll-div.c

-- 
2.7.4

