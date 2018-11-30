Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF39AC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954A62145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3LyYkJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954A62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeK3SD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:03:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40432 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3SD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:03:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so2079583pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=W2WRzoA1lng3HhEM9HJNkyXzf+k3zuNVW/6U4xRIx3s=;
        b=Z3LyYkJ3U/V79arrEveQ3i/soQa4xMItd8mBx2QpriSmb8gqmOFaU1OMBFyoNw03GD
         uoYIKAm6kPFKDebF9mitSaC9I/mPxlJfnfRsBFyvLiklzeFGeabiZ//0qAEvTaqIzZCa
         Fi1cWcbou8TQDvC9W8st0XeIBBY08DSOt7BQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W2WRzoA1lng3HhEM9HJNkyXzf+k3zuNVW/6U4xRIx3s=;
        b=RRgwmoqIgqY390rOTThTPRXepOWWC+q+qEe5c8zPF3sCP98ThCnjhPLTXtn41vQ4V8
         U4NvF54nrV2VpLc1oldh81T0KhvDEChOi3KzijSFzO3FmS6L/7AIqBsBiZJsnIwNNlZL
         CtTw/w8sNrxGx+QbzTmy4T4NeZ5uCkz3tPhR1SgzmbPljGuOwesG5iLmNCi5ZcMm2v0N
         MLryY5HAT4fZ13uUZxYxlE4VHDOr6Isdg6yiEHMZhF7DohasnO/uk5siSUR0+65tLsYN
         AUpXh4EENUQtRdISlc0Yd5/iVXL+AHm+yZa9fiYfj7KmQq+AdnA5wCumBYrtgpvHEre7
         EKgQ==
X-Gm-Message-State: AA+aEWbSZ+ZVFeaZNcjbCzQaCZQwHO8z3HxmX9XcU8Id7LqrJGImelNv
        ATcSgY0i9+8T5EWED3P440u1/A==
X-Google-Smtp-Source: AFSGD/V4RDLdsNKV6Te6Z6OjotT3lwvrpAYrJheSinqBEBBquvzE8CgXsbMPhYp09xbk3FimwnMt+A==
X-Received: by 2002:a63:1321:: with SMTP id i33mr3957739pgl.380.1543560908783;
        Thu, 29 Nov 2018 22:55:08 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w128sm5859175pfw.79.2018.11.29.22.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 22:55:08 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH 0/3] clk: qcom: gcc-msm8998: Fixes and clkref clocks
Date:   Thu, 29 Nov 2018 22:52:56 -0800
Message-Id: <20181130065259.26497-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark critical clocks critical, don't halt-check UFS clocks and add clkref
branches.

Bjorn Andersson (3):
  clk: qcom: gcc-msm8998: Mark hmss_dvm and lpass_at critical
  clk: qcom: gcc-msm8998: Disable halt check of UFS clocks
  clk: qcom: gcc-msm8998: Add clkref clocks

 drivers/clk/qcom/gcc-msm8998.c               | 83 +++++++++++++++++++-
 include/dt-bindings/clock/qcom,gcc-msm8998.h |  5 ++
 2 files changed, 85 insertions(+), 3 deletions(-)

-- 
2.18.0

