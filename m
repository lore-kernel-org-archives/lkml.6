Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E89C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2424D21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQOI3Zeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbfBRMfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:35:39 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:33252 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbfBRMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:35:39 -0500
Received: by mail-wm1-f49.google.com with SMTP id h22so12026485wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/nKMhwFC3vNAnPzrfbYyJBsfL19ejkDU9zvlyTGWy/o=;
        b=nQOI3Zeo59FmeiHoq6HFA7FJ36zglG7ydnF/Pmzetz55yBX5TWfwZfunZ8aW5ytJoY
         EJI/KaPLOr+7BG5cbX8fdYgdwKtjvOIVskptVwXBOMP7by6wlRzEA4GwKuLgbZSgihUG
         aw9IlWFNkEqB8GxV6yjUaV8CkdzSSvq2AvDbLaI72v3TVHN20ulk/Rq41HWss0VZFmlV
         gBVbIzNLSNJZWAVMN7aIr1Dz6KppABX+NdtIPzrAewl3dsRscGgh39v+f43y6o6z7HW8
         hRiz/nrUo7VwvP9DiHRo0MgxBaRiS2ZzP5mIX1LkIPMXKc/+BqjTotRQIVZhOqbmpymf
         IepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/nKMhwFC3vNAnPzrfbYyJBsfL19ejkDU9zvlyTGWy/o=;
        b=KusGKhnVqV3tVWvdx8SAIl1IWaGBCCDzYwkmXJwTnZKp3NMgEfSLAa7ytaLEu1jJS2
         JwpfFxEz+j/QN+fXMUyK33vGulyplPeJZqD+j9NPxsCSVuf0wYo0/LRv2FqfLY3zobKo
         Exig2cMWjMzFG0aawZnfNd3p0N9BLbVvn0C0hJOHnaRZDy5JcOTQmg6e2XIJJXU3TFKY
         fYVW1/tiokP17IL5nGk5QbngKYSUsVIjxD2dS0B/P+Qrb+mN3Q3HxAbIWankT4YrhuBP
         o0epWG1AwpfObT+cHwNgLdplGHxhcjqjCVg/ZhZxWTRdSzcaTZkeSvcYwNaI3DyewBSB
         RKpQ==
X-Gm-Message-State: AHQUAua7izw1ErrNbkq+LBOlyxoc+odWHq0One0hJSL88b7JHb16Ok8h
        nZgqMMZpRyGnh64NLDkUi5W8NCV0qfY=
X-Google-Smtp-Source: AHgI3IYIDxRs/B5+Y06iTkB6oYKBxmwRT+SIWl85SnjBAOC18JyhFCobMlqrlE2/T7IjHwCxm8RnSw==
X-Received: by 2002:a1c:a74a:: with SMTP id q71mr16423593wme.45.1550493336599;
        Mon, 18 Feb 2019 04:35:36 -0800 (PST)
Received: from localhost ([49.248.190.152])
        by smtp.gmail.com with ESMTPSA id d15sm28726585wrw.36.2019.02.18.04.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 04:35:35 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 00/12] qcom: dts: thermal cleanups
Date:   Mon, 18 Feb 2019 18:05:14 +0530
Message-Id: <cover.1550493113.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Expose all temperature sensors on msm8916, msm996, msm8998, sdm845
- split up the register address map for msm8998
- standardize names of the various thermal-zones across boards to make it
  easy for test scripts to parse

Amit Kucheria (12):
  arm64: dts: msm8998: thermal: split address space into two
  arm64: dts: msm8998: efficiency is not valid property
  arm64: dts: msm8916: thermal: Add sensor for modem
  arm64: dts: msm8996: thermal: Add temperature sensors near major
    peripherals
  arm64: dts: msm8998: thermal: Fix the cpu sensor numbers
  arm64: dts: msm8998: thermal: Fix the gpu sensor number
  arm64: dts: msm8998: thermal: GPU has two sensors, add the second
  arm64: dts: msm8998: thermal: Add temperature sensors near major
    peripherals
  arm64: dts: sdm845: thermal: Add temperature sensors near major
    peripherals
  arm64: dts: msm8998: thermal: Make trip names consistent
  arm64: dts: msm8916: thermal: Make trip names consistent
  arm64: dts: msm8996: thermal: Make trip names consistent

 arch/arm64/boot/dts/qcom/msm8916.dtsi |  30 +++--
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 122 ++++++++++++++++++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 154 ++++++++++++++++++--------
 arch/arm64/boot/dts/qcom/sdm845.dtsi  |  91 +++++++++++++++
 4 files changed, 328 insertions(+), 69 deletions(-)

-- 
2.17.1

