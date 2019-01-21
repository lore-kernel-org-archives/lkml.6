Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D3C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AAA2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2zXGAAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfAUSIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:08:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38429 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfAUSIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:08:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so11793738wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hLGo8VUWyiT36PicwFTRp+yGXOi2MahS6wnd97C7uQs=;
        b=V2zXGAAK1igCRie0IVtea/09JwpqyYF7zfW8Z/BPmXZ+1BhzsSeN5AM9V9rKkTVKGe
         kHnYf8QQVvxNIhLDgy2HzcnmMdJm4EirvKxA3ih4w7CNL/wUWJFWzP8O0DbIXzV4QdBO
         h2TvXvrSlteouPmQaJRxsy8M39YGvGBWH31Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hLGo8VUWyiT36PicwFTRp+yGXOi2MahS6wnd97C7uQs=;
        b=qf4WMaSVkGwTu2L8JN54g474uO6hUnhbfcUllp1Ti3uxuUtkS/VoDguq+PbG+6EOZ9
         OCln8CMEp8kWhYoQRsikaRMcKS7g9/xc/NqWg02BbTPdd9cAVg0xN0262LDmiuWZUV8s
         iEszVlgQXPTJBYlIgLPJLYFXZQz/Rp55Xzz9ktF8QiGoJUxocScingfrbP3cwJIhPZJT
         tQM8FiV9HIQ4+GTlvKZv/sosVxFA72bZZ9PQEgMBUDbpNEdFoNHgAgzPJP6M/CWOeMWa
         VQ495ZWvmUAzNxlSJl1cfAYRNUuJFIy5H8sxHNoeIZIqcwGYMhUbrn8Yu2hef2SR9Gtx
         8e2A==
X-Gm-Message-State: AJcUukfyuPcTIa8iZS592DesqF2m+HZl6by/EKSbEL8wGNz8MCb7+C6O
        yCOQZU3DFTnEA+5bj+DrTCUj90ViiY0=
X-Google-Smtp-Source: ALg8bN6QycTleGD+70yCHMF8VqtUefRONjdarWDp3aw2ZhnMg/5MQ8/YE9boeh5lUIQ3T+J8Zg4Etw==
X-Received: by 2002:a1c:a755:: with SMTP id q82mr481825wme.6.1548094120592;
        Mon, 21 Jan 2019 10:08:40 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id y13sm66320243wrw.85.2019.01.21.10.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 10:08:40 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org,
        swboyd@chromium.org, dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v3 0/1] Thermal throttling for SDM845
Date:   Mon, 21 Jan 2019 23:38:33 +0530
Message-Id: <cover.1548093127.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only one patch left in this series. This patch can be applied independently
but needs [1] and [2] merged to have throttling work out of the box.

Changes since v2:
 - Split up the series into auto-register series for cpufreq[1] and
   miscellaneous patches[2][3]. [1] and [2] are needed for this patch to
   work.
 - Merged the two DT patches into one. We end up with 2 passive and 1
   critical trip point.
 - Remove unncessary cooling map for critical trip point, we're shutting down at
   that trip, duh!

 [1] https://lore.kernel.org/lkml/cover.1548084260.git.amit.kucheria@linaro.org/
 [2] https://lore.kernel.org/patchwork/patch/1033953/
 [3] https://lore.kernel.org/patchwork/cover/1033970/

Amit Kucheria (1):
  arm64: dts: sdm845: wireup the thermal trip points to cpufreq

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 225 +++++++++++++++++++++++++--
 1 file changed, 209 insertions(+), 16 deletions(-)

-- 
2.17.1

