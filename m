Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ECEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B1E20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xi871oKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfA2Ezf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:55:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54398 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfA2Ezf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:55:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so16323714wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=M2SV/8aQjo2L+qxKWqLLEIli4Sge3OFMh4QMcOPhDng=;
        b=Xi871oKhsdq0rrYMC0qEbeeYcMpKRS6M9HYgxIe6nn1J1CuL+vOmEccltrF6leCElw
         2CkifFK0rpJimAfXhLmEplx+ceVwPPsbX4rs20txQflEGcetrfZvS19+5IqEtHumjFte
         oV2WgOGHDnhEftO9wCUO0bo2d0IfhlFfuEUwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M2SV/8aQjo2L+qxKWqLLEIli4Sge3OFMh4QMcOPhDng=;
        b=nivRIh5MwxuQfzyGQJUBL1FQ408UexHXjNKXMcSWz79cBwyyZCgZtPNw8/WlWlIyFM
         2Fi6imwJKTC+2WIJi8jtZ5Nu/gM24omevS4fXiE3v/5RQw924OjEugi/3mj7Z41RyCkS
         6v3oNJwQejNK5u3uJDdn7fCYRFOG59bmG3bVqj3oUAwI7SNUEnRCBzHXPSCJq4V1gotH
         YeF9Wdjxn96Gz+U+FSdZC/aG/AAbqQFFIftKHF8m5AVdgNx56nV8mz6HNmr6RZyp4994
         G6ArAHbv420+Hq8wP6bFQmxb+saxd3ruKPvr0PLdBh+r1fYNmOARQEzi/gCVtoW1kbvE
         WdMQ==
X-Gm-Message-State: AJcUukdf7tC4dQ+JGjQqzAA1IGvz08rZ+igqHuJfi+I1dH2veYd1YRd6
        JWjl6DlL9egm9ZwKIsefkiOVg38Wjm4=
X-Google-Smtp-Source: ALg8bN7Bver4xPLrWq5gOA2n3jxdvqaiQge+Oo5+7SI44Sp2IkkqChQ15AWYj+3LFTY/hLtgvjgmVA==
X-Received: by 2002:a1c:e345:: with SMTP id a66mr19092861wmh.12.1548737732549;
        Mon, 28 Jan 2019 20:55:32 -0800 (PST)
Received: from localhost ([49.248.171.30])
        by smtp.gmail.com with ESMTPSA id f3sm2032270wmd.22.2019.01.28.20.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 20:55:31 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCH v5 0/9] cpufreq: Add flag to auto-register as cooling device
Date:   Tue, 29 Jan 2019 10:25:06 +0530
Message-Id: <cover.1548737236.git.amit.kucheria@linaro.org>
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

Changes since v4:
 - Added IS_ENABLED guards in cpufreq.c
 - Changed flag name to CPUFREQ_IS_COOLING_DEV
 - Collected various review tags

Changes since v3:
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
 drivers/cpufreq/cpufreq.c          | 13 +++++++++++++
 drivers/cpufreq/imx6q-cpufreq.c    | 24 ++----------------------
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
 drivers/cpufreq/qcom-cpufreq-hw.c  |  3 ++-
 drivers/cpufreq/qoriq-cpufreq.c    | 15 ++-------------
 drivers/cpufreq/scmi-cpufreq.c     | 14 ++------------
 drivers/cpufreq/scpi-cpufreq.c     | 14 ++------------
 drivers/thermal/Kconfig            |  1 +
 include/linux/cpufreq.h            |  9 +++++++++
 12 files changed, 37 insertions(+), 92 deletions(-)

-- 
2.17.1

