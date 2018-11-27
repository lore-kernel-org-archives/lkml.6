Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8DAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3F2208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5M38MmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3F2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbeK1F5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:57:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55984 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbeK1F5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:57:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so85982wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 10:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OT5nsCKO9rArKb1RDtp4XquD4PLnE65JHJWkLHZOvIg=;
        b=E5M38MmTYDPujNvuQJHA3K1axYqDQ3Dd2G3vQtKmCI1m0RomN9x5FXClrQ6/UilUHS
         QeffQHR4s2RtOBg1VMvQ5SoifPZFuzDmEhmdBvIGvnHZcr9VowxOiynYU/erQQ4ukwBD
         v7UdCqvS+sFnAJAY6SiIcYNbK/EGXTntsYawM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OT5nsCKO9rArKb1RDtp4XquD4PLnE65JHJWkLHZOvIg=;
        b=cNmF0rD+QlB6MgrU4PYWacaJTudhIgFWAvDbyhwRoPns0nvbJIWiu/afreKRQAJaTw
         xXkhR1O/whpyyo47HGyqeLNbt+7PHz0/vdvv31ngPdXZv99OfdCCynmqqk/oQFnaST5K
         xTBNXwf1Auepsx1NtRT1UHSQXga9YSxKle5cdseTb2GHXeIvTzOngGfpbOcrhdrndFoU
         wPoh+eSVsh0LwyqeX3E7JzDtpGR9woWJ845tS71l6KZ4RRhNCXANClJ+qGgUCYKSJklh
         nTxkifOcDroacG0LZOH8zm3eZniAzZOGh7RShWE1+x/IK+n8kMcH8gUQ1ZxT8xX1MMY9
         rFuA==
X-Gm-Message-State: AA+aEWbx8fit8WrAbey4Km1fvrSqclGYvGyoZHIwLmOYZ7vvzUh8YUM7
        qnRC4hePfV2YMyHCouVhVWWhG4gAvKA=
X-Google-Smtp-Source: AFSGD/WN0WqnTOGvOCR5AA7nYRvv9t+qCb6Zoj9mTAyC3L5l6DqUtTYXS1+92fqiQ0KcHewLFbbqgg==
X-Received: by 2002:a1c:5702:: with SMTP id l2mr86017wmb.31.1543345134883;
        Tue, 27 Nov 2018 10:58:54 -0800 (PST)
Received: from localhost ([49.248.92.105])
        by smtp.gmail.com with ESMTPSA id e190sm4760823wmf.0.2018.11.27.10.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 10:58:53 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v3 0/2] driver: thermal: Move some drivers into subdirs
Date:   Wed, 28 Nov 2018 00:28:39 +0530
Message-Id: <cover.1543343156.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the various drivers for Intel platforms into their own subdir. Also
consolidate Qualcomm drivers into the qcom subdir.

This cleans up the directory making it easier to find things.

There is no great time to send patches that move files around. So here's an
attempt to sneak it into 4.21 before everything else.

This was generated and compile-tested against 4.20-rc4. If you would like
me to try again a bit later, I'm happy to do so.

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
 drivers/thermal/Makefile                      | 12 +--
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
 rename drivers/thermal/{ => qcom}/qcom-spmi-temp-alarm.c (100%)

-- 
2.17.1

