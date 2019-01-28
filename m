Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00E2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B8520989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjN/9A4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfA1GmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:42:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51205 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfA1GmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:42:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so12692235wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=s7lgGPNmk6yzNikPOAgazA8H44bs/2pQ5Wgm9TQ1twA=;
        b=gjN/9A4yevg58U7HPgUuet0K8raeSd4xai9sQWAx/DEtA2Vhcd4oB46FvobTC4vGve
         Jy7ZeUMxIZBlx30jMeRbySIQ6KYpmVZgph6e9Ps0skU2XViWZw26AJhOBjZl1H73EpdT
         cKCo4VY9DOlrx+stQcL3r0c4ae0zEkgnrxWMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s7lgGPNmk6yzNikPOAgazA8H44bs/2pQ5Wgm9TQ1twA=;
        b=JxcT2vqttbEG1fpZ6xakr5s3pJ+gkIfmXD+H2i8lIjTSCFdy+dJp0ExIhStJrgc8fn
         BYaW9PUqaDHCBy4DkPzu0haHWmWF0QcA9BNHXIpb8zQgEQWv2URhFbxOmeDKhfxd0lyp
         xLj6YsoAvVT1O2QLCw3aYI/2CHxrBJdLy+6yxHVaUtFW+i9ZtUJmFB1D/LKMY0MsMwbq
         zfSEo32HZePEP19btcVJdxW2YVYN9Mpxq33OfBRptQz6kiuzwH6ESErspHyBvNbQPzBJ
         2gUDZ64i8Av/sCe5wmuSHqjYpYVvwnLD28oho44lCTL+U5KAEESWQdnwXp0ydUIrX0gP
         W3Kw==
X-Gm-Message-State: AJcUukeMf0AfkLVxOHxapgokqDHZRlQQzkKthC7uPX8afRKxG5ZY0HLD
        VMqZpbzCn9YYHmSH7FGN8bUARY4Q9kc=
X-Google-Smtp-Source: ALg8bN56Oc0AMEP5gfBhIDmLIXlCubXW6Y/E9vYy7dSKP63aUa7PLIv1ymDctNxYrxzeHNRuw/P5uA==
X-Received: by 2002:a1c:9ed7:: with SMTP id h206mr14803086wme.28.1548657726247;
        Sun, 27 Jan 2019 22:42:06 -0800 (PST)
Received: from localhost ([49.248.191.44])
        by smtp.gmail.com with ESMTPSA id t4sm86845856wrb.64.2019.01.27.22.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 22:42:05 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCH v4 0/9] cpufreq: Add flag to auto-register as cooling device
Date:   Mon, 28 Jan 2019 12:11:25 +0530
Message-Id: <cover.1548654899.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag for cpufreq drivers to tell cpufreq core to auto-register
themselves as a thermal cooling device.

There series converts over all the drivers except arm_big_little.c.
Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
others.

Things needing fixing (but not a blocker for the series):
 - Look at how to detect that we're not in IKS mode in arm_big_little's
   .ready callback.

Chnages since v3:
 - Got rid of wrapper function to register/unregister cooling devices.
   Directly call the function in cpufreq.c

Changes since v2:
 - Get rid of #ifdef'ery and let the pointer exist in all cases
 - Get rid of (!CPU_THERMAL || THERMAL) dependency in all cpufreq drivers'
   Kconfig

Changes since v1:
- Fix compilation failures with allmodconfig
- Get rid of #ifdef in cpufreq.c
- Removed miscellaneous patches and sent them separately
- Merged patches 1 and 2 from v1

Amit Kucheria (9):
  thermal: cpu_cooling: Require thermal core to be compiled in
  cpufreq: Auto-register the driver as a thermal cooling device if asked
  cpufreq: qcom-hw: Register as a cpufreq cooling device
  cpufreq: imx6q: Use auto-registration of thermal cooling device
  cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
  cpufreq: mediatek: Use auto-registration of thermal cooling device
  cpufreq: qoriq: Use auto-registration of thermal cooling device
  cpufreq: scmi: Use auto-registration of thermal cooling device
  cpufreq: scpi: Use auto-registration of thermal cooling device

 drivers/cpufreq/Kconfig            |  3 ---
 drivers/cpufreq/Kconfig.arm        |  5 -----
 drivers/cpufreq/cpufreq-dt.c       | 14 ++------------
 drivers/cpufreq/cpufreq.c          |  9 +++++++++
 drivers/cpufreq/imx6q-cpufreq.c    | 24 ++----------------------
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
 drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
 drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-------------
 drivers/cpufreq/scmi-cpufreq.c     | 14 ++------------
 drivers/cpufreq/scpi-cpufreq.c     | 14 ++------------
 drivers/thermal/Kconfig            |  1 +
 include/linux/cpufreq.h            |  9 +++++++++
 12 files changed, 33 insertions(+), 92 deletions(-)

-- 
2.17.1

