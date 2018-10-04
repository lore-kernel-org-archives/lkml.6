Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9605C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A5021470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClL6YEnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A5021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeJDOoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:44:19 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40968 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeJDOoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:44:19 -0400
Received: by mail-yb1-f194.google.com with SMTP id e16-v6so3501938ybk.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 00:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fLHgpLjSv8k+4DVY3yW5PAxD2p6dAcbI0bIxDcdLZmc=;
        b=ClL6YEnJn4F+sx2aaOiXVmZ8wVeGJtVeVy4JFvposwLugLyYG8mQc8pDse86MNphKJ
         i7MK6ArpLcz763CnoztI3y6IihwUCAaIrsAYTzZumJc4ymbwQ5J91Kmaf0ILM94xkLrA
         LgMDw8VxEqIRDz4jxmXrMgOlxnGOsWAoTqYcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fLHgpLjSv8k+4DVY3yW5PAxD2p6dAcbI0bIxDcdLZmc=;
        b=mj/ybJrUXeK5SPQWqJFEQMxoM99da3L3a7E4IVTG07LZjOsWpsvkcCpAF31tT32llH
         ozJvp6MtnNJjSnYlt60Lz3pnnLQhdN6BhT9wJMHOkFv/tkBw83XIOJfVu6WmRlQgf8fL
         Pe5sIy8A6BwRdwpGCC7eu6vzjPpHGsjCfU4u1iu+eiXsVl+Ndr0h9ZoBuS0vRfHpWdt6
         DlSuOFfqEuupbn3iK6fo0Lec4MXtXtdhoryIYEioHbJ2xkPcBMg/YEQaw74iOgUevMth
         sYDf5cTJQ7EuaYUSmKZi5HJi5E968uSeeB2o1UejO+t40b3pdRqAGPnUnh2Fuka/SOBe
         herA==
X-Gm-Message-State: ABuFfohQaltk58xTsWj7uFdLlwYvMUeBzrpFFGEp2CbaEFCHDZAHE1gK
        M4lbfwLB76cvVoysuvvwMYFqGJfS7vmx8A==
X-Google-Smtp-Source: ACcGV61mYUScbUM/ZKjNrD1/9B2uAhk5+cVlrlTuGiRYcyAvvprHO0sTdERQcrpOggsr5DlObw5Jyw==
X-Received: by 2002:a25:9b43:: with SMTP id u3-v6mr2868812ybo.86.1538639540817;
        Thu, 04 Oct 2018 00:52:20 -0700 (PDT)
Received: from localhost ([202.189.238.75])
        by smtp.gmail.com with ESMTPSA id e82-v6sm3110848ywa.60.2018.10.04.00.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 00:52:20 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     mka@chromium.org, rui.zhang@intel.com, edubezval@gmail.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 0/2] driver: thermal: Move some drivers into subdirs
Date:   Thu,  4 Oct 2018 13:22:10 +0530
Message-Id: <cover.1538638640.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the various drivers for Intel platforms into their own subdir. Also
consolidate Qualcomm drivers into the qcom subdir.

This cleans up the directory making it easier to find things.

There is no great time to send patches that move files around, but I'm told
that towards the end of the merge window is nicer. So here's an attempt to
sneak it into 4.20 after everything else and hoping that these files won't
change after 4.19-rc6. :-)

This was generated and compile-tested against 4.19-rc6. If you would like
me to try again a bit later, I'm happy to do so.

Changes since v1:
- Removed a stray character that snuck into the Makefile
- Added Acks
- Rebased to v4.19-rc6

Amit Kucheria (2):
  drivers: thermal: Move various drivers for intel platforms into a
    subdir
  drivers: thermal: Move QCOM_SPMI_TEMP_ALARM into the qcom subdir

 drivers/thermal/Kconfig                       | 94 +------------------
 drivers/thermal/Makefile                      | 10 +-
 drivers/thermal/intel/Kconfig                 | 77 +++++++++++++++
 drivers/thermal/intel/Makefile                | 12 +++
 .../{ => intel}/int340x_thermal/Kconfig       |  0
 .../{ => intel}/int340x_thermal/Makefile      |  0
 .../int340x_thermal/acpi_thermal_rel.c        |  0
 .../int340x_thermal/acpi_thermal_rel.h        |  0
 .../int340x_thermal/int3400_thermal.c         |  0
 .../int340x_thermal/int3402_thermal.c         |  0
 .../int340x_thermal/int3403_thermal.c         |  0
 .../int340x_thermal/int3406_thermal.c         |  0
 .../int340x_thermal/int340x_thermal_zone.c    |  0
 .../int340x_thermal/int340x_thermal_zone.h    |  0
 .../processor_thermal_device.c                |  0
 .../{ => intel}/intel_bxt_pmic_thermal.c      |  0
 .../thermal/{ => intel}/intel_pch_thermal.c   |  0
 .../thermal/{ => intel}/intel_powerclamp.c    |  0
 .../{ => intel}/intel_quark_dts_thermal.c     |  0
 .../thermal/{ => intel}/intel_soc_dts_iosf.c  |  0
 .../thermal/{ => intel}/intel_soc_dts_iosf.h  |  0
 .../{ => intel}/intel_soc_dts_thermal.c       |  0
 .../{ => intel}/x86_pkg_temp_thermal.c        |  0
 drivers/thermal/qcom/Kconfig                  | 11 +++
 drivers/thermal/qcom/Makefile                 |  1 +
 .../thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  0
 26 files changed, 107 insertions(+), 98 deletions(-)
 create mode 100644 drivers/thermal/intel/Kconfig
 create mode 100644 drivers/thermal/intel/Makefile
 rename drivers/thermal/{ => intel}/int340x_thermal/Kconfig (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/Makefile (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.c (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/acpi_thermal_rel.h (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int3400_thermal.c (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int3402_thermal.c (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int3403_thermal.c (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int3406_thermal.c (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int340x_thermal_zone.c (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/int340x_thermal_zone.h (100%)
 rename drivers/thermal/{ => intel}/int340x_thermal/processor_thermal_device.c (100%)
 rename drivers/thermal/{ => intel}/intel_bxt_pmic_thermal.c (100%)
 rename drivers/thermal/{ => intel}/intel_pch_thermal.c (100%)
 rename drivers/thermal/{ => intel}/intel_powerclamp.c (100%)
 rename drivers/thermal/{ => intel}/intel_quark_dts_thermal.c (100%)
 rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.c (100%)
 rename drivers/thermal/{ => intel}/intel_soc_dts_iosf.h (100%)
 rename drivers/thermal/{ => intel}/intel_soc_dts_thermal.c (100%)
 rename drivers/thermal/{ => intel}/x86_pkg_temp_thermal.c (100%)
 rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (100%)

-- 
2.17.1

