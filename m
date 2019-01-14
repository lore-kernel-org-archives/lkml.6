Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF5CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F80A20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VB0OtnA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfANKVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40291 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfANKVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so8208972wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+q/dK73tHXxtdjEDrD8QwoRGWsQ9m1+k89z7XhmwxY0=;
        b=VB0OtnA+R0ybHWQ8Ch+8EXfaWlytMUpKxFsHZCDgqf7Wo6QVZ2in4hp7ZuGxKLdklL
         Mms9S6vXh/M9tnVX/rI3JP/flQgigSnx5IO/0F1fnj6EJ6aHpV2WYmoDes2BN8x9JIH9
         HX/nt5WPmkXjHQyWyoNZJA65er0vnRLrjAmTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+q/dK73tHXxtdjEDrD8QwoRGWsQ9m1+k89z7XhmwxY0=;
        b=Uv2U+Sc4euTrNh9Lr61g2JiIcXrVdYitBXZ5c076TblqmQKzwVC8HVNhn98b5oFFHe
         3sNs1rfLVv83+oLmPMFJYE4MjnqcygBQZNwswxSvWcBKbQ0gx5807QgecXc09+GHdz03
         XPFTNuLs4XrxNneK9OlLs3T25kpzHsJ+QCCHKm5zna+98LPhtWY/d9Nxe5yHb3KJvuft
         9SsjMJqd35PFTdX2+4OxNZdRXdV2G4NBtDVAvg7iDY+I56EWK3cn//Xrc//J6NQZTDpk
         5WoMsHyu8MDDAb0G2sSnBevSIA/6Mt68+NJlH/ZLmJCTWXrasAo5ZQJQS4DwR9PAxANo
         U8yg==
X-Gm-Message-State: AJcUukeUU9VGxL0qM1SzBidfvHjMullC88RPjvkz5j/b2/Zyn+5IOJw5
        g686e2oq0e8lt8w0pgyfaeRY56Jexi4=
X-Google-Smtp-Source: ALg8bN7fEXvR7cR+oF/SipIA0HAeI4o9xQ5bXmHXgfZWjJ4o3EUehLznFFZwL57+vfUHlzxPeB4TcQ==
X-Received: by 2002:a1c:70b:: with SMTP id 11mr11661449wmh.74.1547461278843;
        Mon, 14 Jan 2019 02:21:18 -0800 (PST)
Received: from localhost ([49.248.81.155])
        by smtp.gmail.com with ESMTPSA id t70sm44682285wmd.36.2019.01.14.02.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:21:18 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS)
Subject: [PATCH v2 0/9] Thermal throttling for SDM845
Date:   Mon, 14 Jan 2019 15:51:02 +0530
Message-Id: <cover.1547458732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for thermal throttling on SDM845. 

We introduce a generic flag to be used by cpufreq drivers to tell the
cpufreq core to auto-register a thermal cooling device.

There are a few miscellaneous fixes to keep checkpatch happy.

If this approach is acceptable I can send a series converting other cpufreq
drivers to use this flag and get rid of driver code.

Amit Kucheria (9):
  [ALREADY QUEUED] cpufreq: qcom-hw: Move to device_initcall
  drivers: thermal: of-thermal: Print name of device node with error
  drivers: cpufreq: Add thermal_cooling_device pointer to struct
    cpufreq_policy
  cpufreq: Add a flag to auto-register a cooling device
  cpufreq: Replace open-coded << with BIT()
  cpufreq: qcom-hw: Register as a cpufreq cooling device
  arm64: dts: sdm845: Increase alert trip point to 95 degrees
  arm64: dts: sdm845: wireup the thermal trip points to cpufreq
  thermal: cpu_cooling: Clarify error message

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 193 +++++++++++++++++++++++----
 drivers/cpufreq/cpufreq.c            |  13 ++
 drivers/cpufreq/qcom-cpufreq-hw.c    |   5 +-
 drivers/thermal/cpu_cooling.c        |   2 +-
 drivers/thermal/of-thermal.c         |   4 +-
 include/linux/cpufreq.h              |  34 +++--
 6 files changed, 210 insertions(+), 41 deletions(-)

-- 
2.17.1

