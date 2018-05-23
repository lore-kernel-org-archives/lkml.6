Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753966AbeEWEhs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 00:37:48 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37750 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753856AbeEWEho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 00:37:44 -0400
X-Google-Smtp-Source: AB8JxZqELKv90uPJRxqOJpsE0clKTpXqBzvMtERmf2CESx6M32xvn2epFD2X77EpjP1qUYLgmJQ7Dw==
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [GIT PULL] Qualcomm Driver updates for 4.18
Date: Tue, 22 May 2018 23:37:40 -0500
Message-Id: <1527050261-19887-2-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527050261-19887-1-git-send-email-andy.gross@linaro.org>
References: <1527050261-19887-1-git-send-email-andy.gross@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.18

for you to fetch changes up to f378dab2c576ab1ef30ff26d2a96687a5a855271:

  soc: qcom: smem: introduce qcom_smem_virt_to_phys() (2018-05-14 14:06:49 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.18

* Various SMEM updates/fixes
* Add qcom_smem_virt_to_phys SMEM API
* Update MAINTAINERS to include qcom_scm pattern
* Add Qualcomm Command DB driver
* Fix crash in Qualcomm SCM atomic1 call
* Add Qualcomm SCM compatible for IPQ4019
* Add MSM8998 to smd-rpm compatible list
* Add Qualcomm GENI based QUP wrapper
* Fix Qualcomm QMI buffer sizing bug

----------------------------------------------------------------
Alex Elder (8):
      soc: qcom: smem: fix first cache entry calculation
      soc: qcom: smem: return proper type for cached entry functions
      soc: qcom: smem: byte swap values properly
      soc: qcom: smem: fix off-by-one error in qcom_smem_alloc_private()
      soc: qcom: smem: fix qcom_smem_set_global_partition()
      soc: qcom: smem: check sooner in qcom_smem_set_global_partition()
      soc: qcom: qmi: fix a buffer sizing bug
      soc: qcom: smem: introduce qcom_smem_virt_to_phys()

Bjorn Andersson (1):
      soc: qcom: smd-rpm: Add msm8998 compatible

Guenter Roeck (1):
      soc: Unconditionally include qcom Makefile

Karthikeyan Ramasubramanian (1):
      soc: qcom: Add GENI based QUP Wrapper driver

Mahesh Sivasubramanian (1):
      drivers: qcom: add command DB driver

Niklas Cassel (2):
      firmware: qcom: scm: Fix crash in qcom_scm_call_atomic1()
      MAINTAINERS: Update pattern for qcom_scm

Sricharan R (1):
      firmware: qcom: scm: Add ipq4019 soc compatible

Stephen Boyd (1):
      soc: qcom: cmd-db: Make endian-agnostic

 .../devicetree/bindings/firmware/qcom,scm.txt      |   3 +-
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |   1 +
 MAINTAINERS                                        |   2 +-
 drivers/firmware/qcom_scm-32.c                     |   8 +-
 drivers/firmware/qcom_scm.c                        |   3 +
 drivers/of/platform.c                              |   1 +
 drivers/soc/Makefile                               |   2 +-
 drivers/soc/qcom/Kconfig                           |  18 +
 drivers/soc/qcom/Makefile                          |   2 +
 drivers/soc/qcom/cmd-db.c                          | 317 +++++++++
 drivers/soc/qcom/qcom-geni-se.c                    | 748 +++++++++++++++++++++
 drivers/soc/qcom/qmi_interface.c                   |   5 +-
 drivers/soc/qcom/smd-rpm.c                         |   1 +
 drivers/soc/qcom/smem.c                            |  77 ++-
 include/linux/qcom-geni-se.h                       | 425 ++++++++++++
 include/linux/soc/qcom/smem.h                      |   2 +
 include/soc/qcom/cmd-db.h                          |  45 ++
 17 files changed, 1629 insertions(+), 31 deletions(-)
 create mode 100644 drivers/soc/qcom/cmd-db.c
 create mode 100644 drivers/soc/qcom/qcom-geni-se.c
 create mode 100644 include/linux/qcom-geni-se.h
 create mode 100644 include/soc/qcom/cmd-db.h
