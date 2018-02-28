Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeB1Ol2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:41:28 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40500 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeB1Ol1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:41:27 -0500
X-Google-Smtp-Source: AH8x2256ldoN+uUMzT7rtjRb9ZLL/3ikgXaBxx15Grl8rC8TCQ7K4i5pyZQgviv0LlaVfuukT+em9w==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, cphealy@gmail.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 00/22] Verbatim device names and devm_nvmem_(un)register()
Date: Wed, 28 Feb 2018 06:40:44 -0800
Message-Id: <20180228144106.16363-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivas, all:

This patchset contains various small changes that I recently made to
ppNVMEM, more specifically:

 - Patches 1 and 3 are two changes I am hoping are acceptable upstream

 - Patches 4 to 15 are a follow up to patch 2

 - Patches 16 to 22 are just trivial fixups and I am more than happy
   to drop them if they seem to add more pointless churn rather then
   value.

Feedback is appreciated!

Thanks,
Andrey Smirnov

Changes since [v3]:

 - Patchset rebased on post 4.16-rc1 master from Linus

Changes since [v2]:

 - Added a patch with kerenl doc for struct nvmem_config as a
   prerequsite for patch #2

 - Documented behaviour of nvmem_register() when id is set to -1

 - Added kernel doc for devm_nvmem_(un)register()


Changes since [v1]:

 - Fixed a build break detected by kbuild test robot

 - Added a patch to unconditionally enable COMPILE_TEST for meson-efuse

 - Dropped Joachim Eastwood from CC list due to bouncing e-mail

[v3] lkml.kernel.org/r/20180103200114.23922-1-andrew.smirnov@gmail.com
[v2] lkml.kernel.org/r/20180101232310.30420-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20171227225956.14442-1-andrew.smirnov@gmail.com

Andrey Smirnov (22):
  nvmem: Document struct nvmem_config
  nvmem: core: Allow specifying device name verbatim
  nvmem: Introduce devm_nvmem_(un)register()
  nvmem: vf610-ocotp: Convert to use devm_nvmem_register()
  nvmem: imx-ocotp: Convert to use devm_nvmem_register()
  nvmem: uniphier-efuse: Convert to use devm_nvmem_register()
  nvmem: snvs_lgpr: Convert to use devm_nvmem_register()
  nvmem: qfprom: Convert to use devm_nvmem_register()
  nvmem: rockchip-efuse: Convert to use devm_nvmem_register()
  nvmem: mtk-efuse: Convert to use devm_nvmem_register()
  nvmem: meson-mx-efuse: Convert to use devm_nvmem_register()
  nvmem: meson-efuse: Convert to use devm_nvmem_register()
  nvmem: lpc18xx_otp: Convert to use devm_nvmem_register()
  nvmem: imx-iim: Convert to use devm_nvmem_register()
  nvmem: bcm-ocotp: Convert to use devm_nvmem_register()
  nvmem: meson-efuse: Do no gate COMPILE_TEST with MESON_SM
  nvmem: snvs_lpgpr: Convert commas to semicolons
  nvmem: rockchip-efuse: Make use of of_device_get_match_data()
  nvmem: vf610-ocotp: Do not use "&pdev->dev" explicitly
  nvmem: rockchip-efuse: Do not use "&pdev->dev" explicitly
  nvmem: imx-iim: Do not use "&pdev->dev" explicitly
  nvmem: bcm-ocotp: Do not use "&pdev->dev" explicitly

 drivers/nvmem/Kconfig          |  2 +-
 drivers/nvmem/bcm-ocotp.c      | 15 ++--------
 drivers/nvmem/core.c           | 68 ++++++++++++++++++++++++++++++++++++++++--
 drivers/nvmem/imx-iim.c        | 14 ++-------
 drivers/nvmem/imx-ocotp.c      | 12 +-------
 drivers/nvmem/lpc18xx_otp.c    | 12 +-------
 drivers/nvmem/meson-efuse.c    | 12 +-------
 drivers/nvmem/meson-mx-efuse.c | 12 +-------
 drivers/nvmem/mtk-efuse.c      | 12 +-------
 drivers/nvmem/qfprom.c         | 12 +-------
 drivers/nvmem/rockchip-efuse.c | 28 ++++++-----------
 drivers/nvmem/snvs_lpgpr.c     | 26 +++++-----------
 drivers/nvmem/uniphier-efuse.c | 12 +-------
 drivers/nvmem/vf610-ocotp.c    | 15 ++--------
 include/linux/nvmem-provider.h | 42 ++++++++++++++++++++++++++
 15 files changed, 138 insertions(+), 156 deletions(-)

-- 
2.14.3
