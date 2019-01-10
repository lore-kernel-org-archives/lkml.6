Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D5EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5BB21773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rv/SJeGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfAJABG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:01:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38136 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfAJABG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:01:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so10239995wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6tNA+FYLjHsg7Dy70AVQeC2fNb/ZAEx9fCsX0Hi+CaE=;
        b=Rv/SJeGWqNvGJknKqLvm1iUyZL0aCVU7EjlEv/0NGbiCtBg+BETTJzOn+fRp2ID6wn
         DpDiMjylwnG5Gh/oERnlPSGeOhDh5gZq+GUOIUV1SpfJl55ii78dQik/+AUER7eFqW6H
         KtyGwotpT6zHAmyvfrGpa6hila131TEuKl9TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6tNA+FYLjHsg7Dy70AVQeC2fNb/ZAEx9fCsX0Hi+CaE=;
        b=UXoXN9M18DE31NbaveC0llmlhAM4IoYw7/dCRGaFZ269gtI28LlLqtoUP7XOTyicrD
         j66EPc8lT5ydro5oZkZNqLOqJOcCWBUA7wEU3UA0SjwaCyMikQgpgkLMb2ygGWxkk3pi
         w2b7xwqAYHufivZrxSZmYFSSzpQFAn67wd+hUNuYQinRal5K8NepKohsBz5N276jo42P
         VTq38kOYtgj3XZG20OSCaiW9/lCjEcTDdFy+gDgKh1yoZ1Qfxlt/CF22QV3wKqmnej7W
         3b6UwnGHTmA2H5kFJ/QYHBLJVTXhidMB7aztCODtcwTp8yGw8PcDLxa1ekb/eGDp8Ffc
         kznA==
X-Gm-Message-State: AJcUukezJ3EL0yumCKZ6WGVHtlEVP0BLoktxTNPgD0Yne7ansd3jmKWh
        nssbFGrbD+L76FlJ+HFT+Ms9S2hColU=
X-Google-Smtp-Source: ALg8bN66ICxIjFtkFYkIJGMWbrv4D+YJRm7lw5I6N7ncKhWC78HEZIDxfWyFVd3JhFBUPHvU4mPhxQ==
X-Received: by 2002:a1c:1cf:: with SMTP id 198mr7340065wmb.5.1547078464370;
        Wed, 09 Jan 2019 16:01:04 -0800 (PST)
Received: from localhost ([49.248.171.190])
        by smtp.gmail.com with ESMTPSA id 198sm17034018wmt.36.2019.01.09.16.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:01:03 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS)
Subject: [PATCH v1 0/7] Thermal throttling for SDM845
Date:   Thu, 10 Jan 2019 05:30:49 +0530
Message-Id: <cover.1547078153.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for thermal throttling on SDM845. 

We introduce a generic .ready callback to be used by cpufreq drivers to
register as a thermal cooling device. If this approach is acceptable I can
send a series converting other cpufreq drivers to use this callback.

Amit Kucheria (7):
  drivers: thermal: of-thermal: Print name of device node with error
  drivers: cpufreq: Add thermal_cooling_device pointer to struct
    cpufreq_policy
  cpu_cooling: Add generic driver ready callback
  cpufreq: qcom-hw: Move to device_initcall
  cpufreq: qcom-hw: Register as a cpufreq cooling device
  arm64: dts: sdm845: Increase alert trip point to 95 degrees
  arm64: dts: sdm845: wireup the thermal trip points to cpufreq

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 161 +++++++++++++++++++++++++--
 drivers/cpufreq/qcom-cpufreq-hw.c    |   7 +-
 drivers/thermal/cpu_cooling.c        |  18 +++
 drivers/thermal/of-thermal.c         |   4 +-
 include/linux/cpu_cooling.h          |   9 ++
 include/linux/cpufreq.h              |   2 +
 6 files changed, 190 insertions(+), 11 deletions(-)

-- 
2.17.1

