Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B49DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81F420675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/QfC1Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbeLQJqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:46:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36329 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeLQJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:46:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id a18so11920414wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XTyfhH2eCsCUKpKWC/aZRLTEDIsgmMe1VvDgoS4i9HU=;
        b=B/QfC1Ntfl4nY7T5Ah71k0VxA8CeWBU9RJGKuCDjBT8nEf32NMQDD0miFWCBPZNtH9
         CkUzZnZa5o/ZFxgIsNCud6MH9mZHUt4bzrW+XhDnYnXckAdgbPXev4FJnBSwgnfAcCZ1
         9/8u/V75gltfZ09z1QmBvRX1Unpi8Bn4TIQPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XTyfhH2eCsCUKpKWC/aZRLTEDIsgmMe1VvDgoS4i9HU=;
        b=DJRGEWbBe2EvuuJL4cfNuTXdrB3zGOT+gq+YmB7noHU8XpSEmsS2b9y24xiOXzq7Z9
         V9OevIVmpGJb5WoqSgXOSib4GS4iV0BYt8geRBC1GauA4SQOyYKDLIrRv8tlND4oJNwM
         u+Qx0uVHix2NlBWRrrP04drQyJMEfV/skOzpVZgRj0fqPRz2xolfpdW01hTLBpK2B6++
         gZ2mqs2riTYymr2nz+44X6tii7x5RUp+DVgYu2h27DE6N1Wone9nT0nzPO6ltPUIFD8+
         tv4C0Ezy8LqzzHlwPYY0NycR/qBu0qALIs4y53rAIb7gACxSTBbcz29K6u/mD85cfADa
         TNGg==
X-Gm-Message-State: AA+aEWbUyz6LohnwMUIvyyJCGkmE/MB4U8VuqwzHyo0q/9g+4lipExP8
        YbVlpw0bpnVOg3hN0dteyV15Kw==
X-Google-Smtp-Source: AFSGD/WKiBep+PS9VFJ8wt9BZhAWEZIkBQHDBDSzgNn2pdTiof7a5TmX0NFXI/3dVBiwBSV8h1Wbpw==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr9154002wmz.8.1545039995231;
        Mon, 17 Dec 2018 01:46:35 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:46:34 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 00/13] Support CPU frequency scaling on QCS404
Date:   Mon, 17 Dec 2018 10:46:17 +0100
Message-Id: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset enables CPU frequency scaling support on the
QCS404.

Patch 8 "clk: qcom: hfpll: CLK_IGNORE_UNUSED" is a bit controversial;
in this platform, this PLL provides the clock signal to a CPU
core. But in others it might not.

I opted for the minimal ammount of changes without affecting the
default functionality: simply bypassing the COMMON_CLK_DISABLE_UNUSED
framework and letting the firwmare chose whether to enable or disable
the clock at boot. However maybe a DT property and marking the clock
as critical would be more appropriate for this PLL. I'd appreciate the
maintainer's input on this topic.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Jorge Ramirez-Ortiz (13):
  clk: qcom: gcc: limit GPLL0_AO_OUT operating frequency
  mbox: qcom: add APCS child device for QCS404
  mbox: qcom: replace integer with valid macro
  dt-bindings: mailbox: qcom: Add clock-name optional property
  clk: qcom: apcs-msm8916: get parent clock names from DT
  clk: qcom: hfpll: get parent clock names from DT
  clk: qcom: hfpll: register as clock provider
  clk: qcom: hfpll: CLK_IGNORE_UNUSED
  arm64: dts: qcom: qcs404: Add OPP table
  arm64: dts: qcom: qcs404: Add HFPLL node
  arm64: dts: qcom: qcs404: Add the clocks for APCS mux/divider
  arm64: dts: qcom: qcs404: Add cpufreq support
  arm64: defconfig: Enable HFPLL

 .../bindings/mailbox/qcom,apcs-kpss-global.txt     | 21 +++++++++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi               | 35 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  1 +
 drivers/clk/qcom/apcs-msm8916.c                    | 33 ++++++++++++++------
 drivers/clk/qcom/gcc-qcs404.c                      |  6 ++++
 drivers/clk/qcom/hfpll.c                           | 19 +++++++++++-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            | 21 ++++++++-----
 7 files changed, 118 insertions(+), 18 deletions(-)

-- 
2.7.4

