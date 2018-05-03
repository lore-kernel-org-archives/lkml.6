Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeECKMz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:12:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeECKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:12:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B2F6607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From: Kiran Gunda <kgunda@codeaurora.org>
To: bjorn.andersson@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V2 0/5] backlight: qcom-wled: Support for QCOM wled driver
Date: Thu,  3 May 2018 15:42:27 +0530
Message-Id: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series renames the pm8941-wled.c driver to qcom-wled.c to add
the support for multiple PMICs supported by qualcomm. This patch series
supports both PM8941 and PMI8998 WLED. The PMI8998 WLED has the support
to handle the OVP (over voltage protection) and the SC (short circuit protection)
interrupts. It also has the auto calibration algorithm support to
configure the right strings if the user specified string configuration
is in-correct. These three features are added in this series for PMI8998.

changes from v1:
	Fixed the commit message for 
	backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c

Kiran Gunda (5):
  backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c
  backlight: qcom-wled: Add support for WLED4 peripheral
  backlight: qcom-wled: Add support for short circuit handling
  backlight: qcom-wled: Add support for OVP interrupt handling
  backlight: qcom-wled: Add auto string detection logic

 .../bindings/leds/backlight/pm8941-wled.txt        |   42 -
 .../bindings/leds/backlight/qcom-wled.txt          |  158 +++
 drivers/video/backlight/Kconfig                    |    8 +-
 drivers/video/backlight/Makefile                   |    2 +-
 drivers/video/backlight/pm8941-wled.c              |  432 -------
 drivers/video/backlight/qcom-wled.c                | 1329 ++++++++++++++++++++
 6 files changed, 1492 insertions(+), 479 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
 delete mode 100644 drivers/video/backlight/pm8941-wled.c
 create mode 100644 drivers/video/backlight/qcom-wled.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project
