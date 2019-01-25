Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59155C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EDD2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjkIfraW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfAYHCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:02:52 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:34303 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfAYHCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:02:51 -0500
Received: by mail-ed1-f53.google.com with SMTP id b3so6593652ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cyLosbw975pFE25Y2vfzwPuN8/wk+kN4j80s9bRHwe4=;
        b=YjkIfraWX8lxLQ8cGi6MkrIdQxnCp/M421VYz7v5jtMHz4OSFLCQF2G8fcaOqM8Mi0
         b8M7FlN0Hp8OLqSRWstF6FJIcMHF+BrfEhDjVfMTxE/KFhRATuaossCsCZztkLqSn5rl
         FSB3WWby34rQutSqSnKub+MKY9OFnWAZTUf0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cyLosbw975pFE25Y2vfzwPuN8/wk+kN4j80s9bRHwe4=;
        b=HQtpbThFTVdqNhtKjXxBmGWUza6CHIkK39ytKJnqmw9w6zFyrJedbWcnt1qJbxudFA
         y19ZotyDsdcSCWLfXxKPEK0Pdr8MSWZ41yxJMYGU2BCwhL/10g0218PqUcWtFLNu/gVs
         TPuSf5rxVy7hDy0Ig3u6uE8CMfnbnqA0UVS3ikG+1lma4EgICKHii28XIuurCltQQXZD
         jjEjNRaU5KVeOzOL25+2e/CI2XhTBqLywvT2YLY4XFkS24nV1QLUCF2/H9krQQeT0LZ4
         sZYn7hcjv1FOVim50+Z71z13DFZWVfhgofAPwBF1YpEeFpJX7uN7F5oFO2TJT+n3dljB
         5sEA==
X-Gm-Message-State: AJcUukcTLmrlycVMLyKSwWz2Gq/nxhgJPmRxWLDQZ/hFyruUJJDuX9Sq
        4Ay1yOmn8IxQttyV3pZkjLgkphY/yuk=
X-Google-Smtp-Source: ALg8bN5g4aavWdMqMtIL3By+udehsRSZVXv41h+ZMTiqy0c+hxDeesoxs/MIYpFMI3AGMUu2dlb6fQ==
X-Received: by 2002:a50:bae3:: with SMTP id x90mr9829519ede.221.1548399769658;
        Thu, 24 Jan 2019 23:02:49 -0800 (PST)
Received: from localhost ([49.248.181.51])
        by smtp.gmail.com with ESMTPSA id x47sm11711410eda.91.2019.01.24.23.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 23:02:49 -0800 (PST)
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
Subject: [PATCHv3 0/9] cpufreq: Add flag to auto-register as cooling device
Date:   Fri, 25 Jan 2019 12:32:20 +0530
Message-Id: <cover.1548398851.git.amit.kucheria@linaro.org>
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
 drivers/cpufreq/cpufreq.c          |  6 ++++++
 drivers/cpufreq/imx6q-cpufreq.c    | 24 ++----------------------
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
 drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
 drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-------------
 drivers/cpufreq/scmi-cpufreq.c     | 14 ++------------
 drivers/cpufreq/scpi-cpufreq.c     | 14 ++------------
 drivers/thermal/Kconfig            |  1 +
 include/linux/cpufreq.h            | 21 +++++++++++++++++++++
 12 files changed, 42 insertions(+), 92 deletions(-)

-- 
2.17.1

