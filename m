Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbeFAJOC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:14:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55397 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeFAJN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:13:58 -0400
X-Google-Smtp-Source: ADUXVKIXSE1XLH39rPkBYzpT0rQGKxm/6ZOsXSsz55BtEqRXl8ItY/XG2H0ZogYYreDxGLiZZxtnUg==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: robh+dt@kernel.org, kramasub@codeaurora.org, sdharia@quicinc.com,
        girishm@quicinc.com, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, nicolas.dechesne@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/2] slimbus: Add QCOM SLIMBus NGD driver
Date: Fri,  1 Jun 2018 10:11:39 +0100
Message-Id: <20180601091141.26108-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to basic version of Qualcomm NGD SLIMBus
controller driver found SoCs from B family.

This controller is light-weight SLIMBus controller driver responsible for
communicating with slave HW directly over the bus using messaging
interface, and communicating with master component residing on ADSP
for bandwidth and data-channel management.

Some parts fot the work is derived from Qualcomm downstream kernels
and intial work from
Karthikeyan Ramasubramanian <kramasub@codeaurora.org> and
Sagar Dharia <sdharia@codeaurora.org>

Tested this patchset on DB820c with WCD9335 codec and on msm8974 with
wcd9320 codec.

I have pushed my working branch to [1] incase someone want to try.

This patch has dependency on https://lkml.org/lkml/2018/5/17/251

Changes sinc v1 (https://lkml.org/lkml/2018/5/25/296):
- Added Tested-by and Reviewed-by Tags
- Added Credits to Qualcomm engineers in commit log
- Fixed a spelling mistake for prepare.

Thanks,
srini

[1] https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=slimbus-ngd

Srinivas Kandagatla (2):
  slimbus: ngd: dt-bindings: Add slim ngd dt bindings
  slimbus: ngd: Add qcom SLIMBus NGD driver

 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        |   84 ++
 drivers/slimbus/Kconfig                            |   11 +
 drivers/slimbus/Makefile                           |    3 +
 drivers/slimbus/qcom-ngd-ctrl.c                    | 1342 ++++++++++++++++++++
 drivers/slimbus/slimbus.h                          |    8 +
 5 files changed, 1448 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
 create mode 100644 drivers/slimbus/qcom-ngd-ctrl.c

-- 
2.16.2
