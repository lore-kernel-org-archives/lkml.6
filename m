Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67BEC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6652120870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cecMvNOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfAUPmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:42:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52932 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbfAUPmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:42:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so11247854wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MA5crrD4Prr0EwOduSOR30oSBtIqdGdvyHP08sn6BN4=;
        b=cecMvNORUI0LJhDEkXZiJkKGrmrINxViFgzLZLmXH+mfHUy5MUr3camUrdGLMWHInZ
         cYGLQNhxwf0h7JHoMUrNqhHozWFcG5G/1fX0nw6iQLZSxt7DL/IMVB1cgVfoiP+4ZS77
         y72HkXPbiu1T0D2e7j7dQCh/Ykfploq2teC18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MA5crrD4Prr0EwOduSOR30oSBtIqdGdvyHP08sn6BN4=;
        b=X/mjQYnz5Vfqs+KLLe2cpDPcKYpep8zO8SwEAkl1JZg1nsDutEdioPFZDGzsEQQ95j
         34jnQuFB5k95evaEzZzkUslFV2r+LcjQna6POwolkhBNl0ncAizI26qBKmpnDlvdDqza
         EASuzEn6Age+Q5FOVdkdMhpAJOG0KkuF1jR/pO7VjomUrIgNq+xLh2xs2g6SAzqhxqms
         RObu0JK6CWaq05Ey0ZY1kbuIRhLP90Bc3yXkJsJONbkoDlykjSU8xg+aoUsMBEDK4c55
         e3eWhi/8l+tFK6FuSoHelIeBIXVbWYLtevUEOb5hlfK309MmJVFIlPdAqydM+1Zo1n8X
         t9Mw==
X-Gm-Message-State: AJcUukfibjS3sp41LmsKX1x5FFuVKDDqAZex6aZtbmiAWQ51Ca/yKw+M
        K7UyY5mnB7pbFKO3rAV+pqz8Dtl2t6k=
X-Google-Smtp-Source: ALg8bN4HPyB6Ku0qpNyjY1RrtXKwI5Qwnx3O1D/4Dp2dKCdK956kiYV6Vwa5D4uHk2VtyGf9ORdkJA==
X-Received: by 2002:a1c:b70a:: with SMTP id h10mr24359200wmf.125.1548085318345;
        Mon, 21 Jan 2019 07:41:58 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id k15sm127527555wru.8.2019.01.21.07.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:41:57 -0800 (PST)
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
        support), linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v2 0/9] cpufreq: Add flag to auto-register as cooling
Date:   Mon, 21 Jan 2019 21:10:25 +0530
Message-Id: <cover.1548084260.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to be used by cpufreq drivers to tell cpufreq core to
auto-register themselves as a thermal cooling device.

There series converts over all the drivers except arm_big_little.c.
Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
others.

Things needing fixing (but not a blocker for the series):
 - Look at how to detect that we're not in IKS mode in arm_big_little's
   .ready callback.

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

 drivers/cpufreq/cpufreq-dt.c       | 14 ++------------
 drivers/cpufreq/cpufreq.c          |  6 ++++++
 drivers/cpufreq/imx6q-cpufreq.c    | 24 ++----------------------
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
 drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
 drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-------------
 drivers/cpufreq/scmi-cpufreq.c     | 14 ++------------
 drivers/cpufreq/scpi-cpufreq.c     | 14 ++------------
 drivers/thermal/Kconfig            |  1 +
 include/linux/cpufreq.h            | 25 +++++++++++++++++++++++++
 10 files changed, 46 insertions(+), 84 deletions(-)

-- 
2.17.1

