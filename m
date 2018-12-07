Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F24FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A91520850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bv+QwV34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A91520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLGGzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:55:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42626 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeLGGzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:55:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so2719745wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aO5R1S5k5yKtDvK7i1+VAD6K1XQ23FK/KwHQrsomPkM=;
        b=bv+QwV34Brg/kw2BMK3NHNGkRJ2sbtNjENEugi068BRM4fPwQ2qhmQwzDkgWYW7tqN
         EveZIfYYIo3apHUAYU/XZpfeQMsQckYTl7pNLPnvRNT2jbjBGRf0DfyjP32OvL0/28cx
         7l8S72K/cSN7oSYb1coKQDTe2KANX0UXNJAWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aO5R1S5k5yKtDvK7i1+VAD6K1XQ23FK/KwHQrsomPkM=;
        b=VFKItJoWCXPVVYTeSeFP0d4PvcNt4YKeQPPFWMd8bhutUL2nmqcTl+/bDHXAAKE+S5
         q9mBX4LhQ1KYLPfAlo2C33v0rZIfAHZsbqAo81FeeQ0rJr2Utep+ABxgbojIKvoVtinu
         Unw4vKnecNHreJcxwoYETw83JilY3kLnBshv/kdc98k68r+B16Jrqln8Ahem7yEDHkbq
         ZeaAoJ2Mm9D5XL4qHFvBXYrk5hJHXfO2I96N+byfPmhKQOYrYgR19yJdeqa5etkCfMfQ
         DR6a2jykxAv3MYjtyjQPqRi39fw2ETockl0RLRGqNRlUs/7snzqSszLR8FSafXBbOrty
         HLTQ==
X-Gm-Message-State: AA+aEWZGfke771vs0/P7MXRPqFWwRTbgi9aLCgj924aN40hpTlbgt0Ae
        WoPN1Q1BQsOqN2MgT4HXHjVeuFN2kNI=
X-Google-Smtp-Source: AFSGD/UN51pjfd7FOaHHl9CVSbHsWPQZnwXZ0QaLe5LgUxbiLrlafIY01TIPGhIUr84uXzSydYMNAQ==
X-Received: by 2002:adf:e911:: with SMTP id f17mr843713wrm.126.1544165735862;
        Thu, 06 Dec 2018 22:55:35 -0800 (PST)
Received: from localhost ([49.248.194.38])
        by smtp.gmail.com with ESMTPSA id q12sm2381011wmf.2.2018.12.06.22.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 22:55:34 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com, sfr@canb.auug.org.au,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 0/2] driver: thermal: Move some drivers into subdirs
Date:   Fri,  7 Dec 2018 12:25:25 +0530
Message-Id: <cover.1544165234.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Apologies for the build failure. My scripts to enable these configs and
build-test them failed. They've been fixed now)

Move the various drivers for Intel platforms into their own subdir. Also
consolidate Qualcomm drivers into the qcom subdir.

This cleans up the directory making it easier to find things.

There is no great time to send patches that move files around. So here's an
attempt to sneak it into 4.21 before everything else.

This was generated and compile-tested against 4.20-rc4. If you would like
me to try again a bit later, I'm happy to do so.

Changes since v3:
- Fix build failure on QCOM_SPMI_TEMP_ALARM

Changes since v2:
- Rebased on top of 4.20-rc4

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
 .../thermal/{ => qcom}/qcom-spmi-temp-alarm.c |  2 +-
 26 files changed, 108 insertions(+), 99 deletions(-)
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
 rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (99%)

-- 
2.17.1

