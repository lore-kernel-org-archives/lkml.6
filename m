Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B50C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40AA206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUpUIyOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40AA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeI1XAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:00:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43955 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeI1XAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:00:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id z14-v6so7035159wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qL3yUFJ0UT1bR43mpkGMugA4fyPt/enfdN4FzCYYm+4=;
        b=NUpUIyOq1lTKWdVNXG6aalKMVKjyckdHmwvo6kgFLf8TUdeO2oRdpe/BR+0oIUjyxe
         ZRj/wU6D0ZkV4JssUAkrb1G1Fy+VQZ3LQEP2WhFN6rXXHjPzEtzQYjFtCvrL45vJ6IfU
         76QKgus0J3nvN4FEn1a5eh9OUI7/lYAMc28gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qL3yUFJ0UT1bR43mpkGMugA4fyPt/enfdN4FzCYYm+4=;
        b=XhDgwEsCVUuv/6QTC4Y+T62wDa3JBztPQKavQ8W0gApm8vUSzn63mt5s78VgOpZA6x
         /56FhaynDD+fDORA3lUgVjg/04txSPtbsFe7QVF0TddUOgyzWB01dNhKZPGOMlIr7lyW
         Rmz2sOc+cJE5ETFKv7oCTRXXSfEb7MO2AnKxfll/A1MkCwbdEVBQOEjwFT2Ukr6WjdnQ
         CyGKXBc4Ssy1h2RIADqLI1Bfy9BA+OacEl1Gt9wc4pFQIrq7+epVQ4DC4DJ4hHrqrtDR
         UkX+S/Nc4Dd0FRy5awGW8pSsCnM0v1Gjj19xraRmEHXzeWLMm8iY/EP5d6fUr+bbMVe0
         3rng==
X-Gm-Message-State: ABuFfoggoW6jZCJ2kdLOTMnAHbZ4x39Dwu4jdvIgz6JZIlh4VqfvLuNW
        BCRsLoG3mpPHbsMIR3WH2A3t8h0xk6rXIw==
X-Google-Smtp-Source: ACcGV603nK5ZMplZt6oFXy+RE86QyFOaRn5mzx1IfRwLwqfCs8WmmexGWLG/UwueUOHFfwFoKZ57ag==
X-Received: by 2002:adf:fb0e:: with SMTP id c14-v6mr12957820wrr.117.1538152573834;
        Fri, 28 Sep 2018 09:36:13 -0700 (PDT)
Received: from localhost ([49.248.49.136])
        by smtp.gmail.com with ESMTPSA id a1-v6sm1029768wrt.79.2018.09.28.09.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 09:36:13 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        mka@chromium.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 0/2] driver: thermal: Move some drivers into subdirs
Date:   Fri, 28 Sep 2018 22:06:04 +0530
Message-Id: <cover.1538141538.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the various drivers for Intel platforms into their own subdir. Also
consolidate Qualcomm drivers into the qcom subdir.

This cleans up the directory making it easier to find things.

There is no great time to send patches that move files around, but I'm told
that towards the end is nicer. So here's an attempt to sneak it into 4.20
after everything else and hoping that these files won't change after
4.19-rc4. :-) 

This was compile-tested and generated against 4.19-rc4. If you would like
me to try another time, I'm happy to do so.

Regards,
Amit

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

