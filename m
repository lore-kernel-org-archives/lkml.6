Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324A9C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AE121872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJSyOcn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBGKt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:49:57 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33654 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfBGKt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:49:56 -0500
Received: by mail-yw1-f68.google.com with SMTP id p17so4453420ywg.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kVT9iAxvzOjKqSkEyh9thKD23Da+mMk5HveGSav0+r8=;
        b=cJSyOcn3O6VQmC0G+0Rwys4o9ETADrqDB2S7j1ltvl0TljqhCPfYrhLSStZe+0RRtl
         xE2R7gQjO3avbDSJArCS3mC3gEE7tAXcKnA5sxrEVtEer+nv7MaqjklmUHpibOsjL2Yd
         rvZ/ydoZvZ35PG1a68eyVB5P6bTIQpVTE7+In76wUG8tixN4OZyhPX9bQaVxgMHMWeoC
         59xVyg4nU11Gz65F32+jDKlUUAvF2ViIq4AEfdl43thk5jhDnYypciPvKd0dN8Wlylej
         63dtLGde6WQsxInMxpgVAevxojynFEFRDQNU0AnWGXkJ3vhrpYCiT1p8k5z8CQzaSfeI
         T4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kVT9iAxvzOjKqSkEyh9thKD23Da+mMk5HveGSav0+r8=;
        b=MEPPkoKxtsY/7NU9/a492vYs9LuAsHLrn2HyTyi77s79IkgOhl3svNCMWpAzYMVZ1V
         JLtAqubRt5u5jC6WMQ08fwUhS4kAL0Wvw4JWXk99BOHwwgC5Z/26qldKSp8m7mlE3NUP
         TNO+8/iwtxu1qSgS4lhSdv/VT6OKpV04AMFIDiqXWwfG8O00xfdg6v4savRUgNKCbv/v
         MKG6kFOqo7QZbx9DQVt6d4BENenKgXiWLqVaxjUVco9WDhFmhK0Nv5Umw2naDu0KUQFG
         T+iNAO2hKUFYFazU68GVlqA5YAR41e/RvSPS00++QSfd+HDvBNxdWISyiZkligNP/iYu
         z6kg==
X-Gm-Message-State: AHQUAuax5WhK/VHSWoeyKevz8bVeQH0RkRK+sC+glXalh/2jjNW/vKR6
        aSbzJ1QlhTY3oVWYH9qp1UzFoqmRz/U=
X-Google-Smtp-Source: AHgI3IablMIrKzXidjN2AFKYUhlhUCrdPAdAVn7utKewykX2wxNV9XSXnTi8vr3GlbLXILmGRz/bVQ==
X-Received: by 2002:a81:3c14:: with SMTP id j20mr12375875ywa.139.1549536594553;
        Thu, 07 Feb 2019 02:49:54 -0800 (PST)
Received: from localhost ([49.248.196.115])
        by smtp.gmail.com with ESMTPSA id s126sm430287ywc.11.2019.02.07.02.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 02:49:53 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 00/24] thermal: tsens: Refactor to use regmap_field
Date:   Thu,  7 Feb 2019 16:19:18 +0530
Message-Id: <cover.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short term bandaid fixes to add support for more versions of the TSENS IP
is not proving to be very scalable. Here is a series to finally convert the
driver's core to use regmap_fields so that register addresses and bitfields
can be abstracted away from the code.

This series is posted as one to give a complete view of where I'm going
with this refactor. We can probably split it into smaller sets if required.
Currently it consists of the following parts:

- Patch 01-06: Style changes to make code easier to read (mostly naming
  related). This has no functional change in the driver, it is a series of
  search and replace operations. Ideally this will get merged first,
  otherwise everything else will become painful :-)

- Patch 07-09: Merge the 8916 and 8974 source files into a single one
  called v0_1.c denoting the version of the IP and open up more
  opportunities for reuse.

- Patch 10: This is the core patch that adds IP-specific data based on two
  data structures: tsens_features has bit flags to identify if a certain
  feature is available in a version or not and an array of reg_field
  pointers.

  regfield_ids list the important fields across IP versions and are used as
  an index.

  This patch converts over all platforms except 8960 which currently
  doesn't use DT data for tsens and has custom functions for everything. We
  will get to it eventually, but it's conversion is not a necessity for
  this series to be merged.

- Patch 11-16: Clean ups and new functionality based on regmap_field

- Patch 17-19: Refactor the get_temp routine. We expect to have a single
  get_temp routine once all the conversion is finished.

- Patch 20-23: Introduce qcs404 support using new regmap infrastructure.

Testing
-------

Since these changes affect every platform using TSENS, it should be
clarified that I have only been focussing on developing/testing this on
sdm845 and qcs404. I will test this more thoroughly on msm8916, msm8996,
msm8998 but it is still pending.

Future work
-----------

a. Get rid of get_temp_common in favour of get_temp_tsens_valid
b. irq support
c. Convert over 8960 to use regmap_field and as a result common functions

Regards,
Amit

Amit Kucheria (24):
  drivers: thermal: tsens: Document the data structures
  drivers: thermal: tsens: Rename tsens_data
  drivers: thermal: tsens: Rename tsens_device
  drivers: thermal: tsens: Rename variable tmdev
  drivers: thermal: tsens: Use consistent names for variables
  drivers: thermal: tsens: Function prototypes should have argument
    names
  drivers: thermal: tsens: Rename tsens-8916 to prepare to merge with
    tsens-8974
  drivers: thermal: tsens: Rename constants to prepare to merge with
    tsens-8974
  drivers: thermal: tsens: Merge tsens-8974 into tsens-v0_1
  drivers: thermal: tsens: Introduce reg_fields to deal with register
    description
  drivers: thermal: tsens: Save reference to the device pointer and use
    it
  drivers: thermal: tsens: Don't print error message on -EPROBE_DEFER
  drivers: thermal: tsens: Print IP version
  drivers: thermal: tsens: Add new operation to check if a sensor is
    enabled
  drivers: thermal: tsens: change data type for sensor IDs
  drivers: thermal: tsens: Introduce IP-specific max_sensor count
  drivers: thermal: tsens: simplify get_temp_tsens_v2 routine
  drivers: thermal: tsens: Move get_temp_tsens_v2 to allow sharing
  drivers: thermal: tsens: Common get_temp() learns to do ADC conversion
  dt: thermal: tsens: Add bindings for qcs404
  drivers: thermal: tsens: Add generic support for TSENS v1 IP
  arm64: dts: qcom: qcs404: Add tsens controller
  arm64: dts: qcom: qcs404: Add thermal zones for each sensor
  drivers: thermal: tsens: Move calibration constants to header file

 .../bindings/thermal/qcom-tsens.txt           |  14 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 263 ++++++++++++++++++
 drivers/thermal/qcom/Makefile                 |   4 +-
 drivers/thermal/qcom/tsens-8916.c             | 105 -------
 drivers/thermal/qcom/tsens-8960.c             |  84 +++---
 drivers/thermal/qcom/tsens-common.c           | 172 +++++++++---
 .../qcom/{tsens-8974.c => tsens-v0_1.c}       | 167 ++++++++++-
 drivers/thermal/qcom/tsens-v1.c               | 229 +++++++++++++++
 drivers/thermal/qcom/tsens-v2.c               | 148 ++++++----
 drivers/thermal/qcom/tsens.c                  | 100 ++++---
 drivers/thermal/qcom/tsens.h                  | 238 ++++++++++++++--
 11 files changed, 1191 insertions(+), 333 deletions(-)
 delete mode 100644 drivers/thermal/qcom/tsens-8916.c
 rename drivers/thermal/qcom/{tsens-8974.c => tsens-v0_1.c} (55%)
 create mode 100644 drivers/thermal/qcom/tsens-v1.c

-- 
2.17.1

