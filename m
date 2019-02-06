Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90978C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C000218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cBp87rb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfBFKe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:34:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37687 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbfBFKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:34:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id c8so120321wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 02:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+ipfF1PBVtslo4J3gUi0zpCU6rmLyfF9RJXKa7xVM3g=;
        b=cBp87rb8YX1mzeQUWsFo0KA42oa+uUOEU+JK7iIUDtr9fxgdMSkj9FD4Qb+7HGlBNR
         cqCmzn0OIQ9tymn8NNuv12LCVb3UVTotf/U9EfYhoPZvh9d0C0+fRu1bNBowTrsITsu8
         icHXWIzKSboWclzNcxLSRgVTl2PRL4U8h9Yv/525pRdEv/XV6xL0NnskyVI1k4czKLK+
         Cq4BAX3Rhm2U1n7+75VyGIAedNpCdCZTXUs2cPbJyAwF9IqqXLKNGcrU2nfDpn/eslV3
         E00MIiAxz67QdJG6mKpcXAjlAMTLnrMY6cNyA8dAiytX57+UNjY+ERq60avd9fQajGWP
         efrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+ipfF1PBVtslo4J3gUi0zpCU6rmLyfF9RJXKa7xVM3g=;
        b=rtg9gopl5EuHroiqfEUEVEbQc/EVzFglQ6jsV+CLbRd7ucpc0Aadj3bE+aMxqbzLq0
         HUpJMzXrUE14opwvIfoCWP9EG46q9Zb/QJa/iezNIW87t6d7pm+/ojMw5I/5UvKHs3LD
         wdSCNpD9SyQCeM4RXQ62251+cXUBqwjfPSbpFYWxC3N2t0k9j9Bi4TiF2S1c0CA0oE7s
         0uFu73FrOOVCDZMLhFnJhCgdAXyAXji618KT3+FHgZDwRkxjPsRZESTEjI7UM8/cH1FF
         F8/jrd9Zo3EWirZM8S2jxMnzU8AolTJbdPgwtm5T9JVA7vX/pQjkIBzaH6sGSEPQGH+C
         ITJA==
X-Gm-Message-State: AHQUAuai5W1y2Rmam/A/v0QQSreAbtb57I6OmhKUpZsO/HxyyZFDn+ha
        bI7VaP3QyU/YyitVqlq2VBi4YT0FCnc=
X-Google-Smtp-Source: AHgI3IaEogdMfv5O4d7TdoUwyj7qaRcbLWvNfnGiACof6/LKSPqN/zGpBr3KpPOk6f15iGS0yFDj3w==
X-Received: by 2002:adf:f0c6:: with SMTP id x6mr7300555wro.258.1549449296560;
        Wed, 06 Feb 2019 02:34:56 -0800 (PST)
Received: from localhost ([49.248.48.35])
        by smtp.gmail.com with ESMTPSA id x3sm28118213wrd.19.2019.02.06.02.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 02:34:55 -0800 (PST)
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
Subject: [PATCH v4 0/1] Thermal throttling for SDM845
Date:   Wed,  6 Feb 2019 16:04:48 +0530
Message-Id: <cover.1549448839.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only one patch left in this series. This patch depends on [1] and [2] which have been merged through by Rafael through the power tree.

Changes since v3:
 - first trip point increased to 90 degrees based on Matthias' testing
 - Added Acks

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

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 241 ++++++++++++++++++++++++---
 1 file changed, 217 insertions(+), 24 deletions(-)

-- 
2.17.1

