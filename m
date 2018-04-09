Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeDIWZx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 18:25:53 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44076 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDIWZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 18:25:50 -0400
X-Google-Smtp-Source: AIpwx4/+HKqBMdecbjterKSjnbt4PgjYsHT/hiv9KzxWN2JsmGY8+YInI0MaXmR2T9bWchTWfUnWpA==
Date: Mon, 9 Apr 2018 15:25:46 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sarangdhar Joshi <spjoshi@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, Jitendra Sharma <shajit@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [GIT PULL] remoteproc updates for v4.17
Message-ID: <20180409222546.GD17344@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/rproc-v4.17

for you to fetch changes up to 730b2ad8f72898029160a6832141ba954122a0c8:

  remoteproc: fix null pointer dereference on glink only platforms (2018-04-05 22:53:16 -0700)

----------------------------------------------------------------
remoteproc updates for v4.17

This adds support for generating coredumps for remoteprocs using
devcoredump, adds the Qualcomm sysmon driver for intra-remoteproc crash
handling and a number of fixes in Qualcomm and IMX drivers.

----------------------------------------------------------------
Arnd Bergmann (1):
      soc: qcom: qmi: add CONFIG_NET dependency

Bjorn Andersson (5):
      remoteproc: Rename "load_rsc_table" to "parse_fw"
      soc: qcom: mdt-loader: Return relocation base
      remoteproc: Pass type of shutdown to subdev remove
      remoteproc: qcom: Introduce sysmon
      samples: Introduce Qualcomm QMI sample client

Christophe JAILLET (3):
      remoteproc: imx_rproc: Fix an error handling path in 'imx_rproc_probe()'
      remoteproc: imx_rproc: Re-use existing error handling path in 'imx_rproc_probe()'
      remoteproc: imx_rproc: Slightly simplify code in 'imx_rproc_probe()'

Jitendra Sharma (1):
      remoteproc: Remove null character write of shared mem

Sarangdhar Joshi (2):
      remoteproc: Add remote processor coredump support
      remoteproc: qcom: Register segments for core dump

Sibi Sankar (1):
      remoteproc: fix null pointer dereference on glink only platforms

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c        |   4 +-
 drivers/media/platform/qcom/venus/firmware.c |   2 +-
 drivers/remoteproc/Kconfig                   |  19 +
 drivers/remoteproc/Makefile                  |   1 +
 drivers/remoteproc/imx_rproc.c               |  23 +-
 drivers/remoteproc/qcom_adsp_pil.c           |  20 +-
 drivers/remoteproc/qcom_common.c             |  56 ++-
 drivers/remoteproc/qcom_common.h             |  23 +
 drivers/remoteproc/qcom_q6v5_pil.c           |   9 +-
 drivers/remoteproc/qcom_sysmon.c             | 579 +++++++++++++++++++++++++
 drivers/remoteproc/qcom_wcnss.c              |  11 +-
 drivers/remoteproc/remoteproc_core.c         | 152 ++++++-
 drivers/remoteproc/remoteproc_internal.h     |   7 +-
 drivers/soc/qcom/Kconfig                     |   2 +-
 drivers/soc/qcom/mdt_loader.c                |   7 +-
 include/linux/remoteproc.h                   |  27 +-
 include/linux/soc/qcom/mdt_loader.h          |   3 +-
 samples/Kconfig                              |  10 +
 samples/Makefile                             |   2 +-
 samples/qmi/Makefile                         |   1 +
 samples/qmi/qmi_sample_client.c              | 622 +++++++++++++++++++++++++++
 21 files changed, 1524 insertions(+), 56 deletions(-)
 create mode 100644 drivers/remoteproc/qcom_sysmon.c
 create mode 100644 samples/qmi/Makefile
 create mode 100644 samples/qmi/qmi_sample_client.c
