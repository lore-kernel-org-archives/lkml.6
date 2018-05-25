Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966003AbeEYLSJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:18:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35570 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965907AbeEYLSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:18:06 -0400
X-Google-Smtp-Source: ADUXVKIxCqr3eBlpQUjda6VoKcCOQ6Oy0rhX/4baHFSqqpo6k4TY8OvOuEkUfavnKGKPrFRED078Ng==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc: kramasub@codeaurora.org, sdharia@quicinc.com, girishm@quicinc.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Subject: [PATCH v2 0/2] slimbus: Add QCOM SLIMBus NGD driver
Date: Fri, 25 May 2018 12:15:45 +0100
Message-Id: <20180525111547.18556-1-srinivas.kandagatla@linaro.org>
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

Tested this patchset on DB820c with WCD9335 codec.
I have pushed my working branch to [1] incase someone want to try.

This patch has dependency on https://lkml.org/lkml/2018/5/17/251

Changes sinc v1 (https://lwn.net/Articles/754679):
- Fixed DT binding making NGD slave of the slim controller.
- Fixed few typos spotted by Vinod.
- Removed unnessary dmaengine_slave_config suggested by Vinod
- Removed few unnessary initializations.
- fixed commit log to remove reference to B family suggested by Trilok

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
