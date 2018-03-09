Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607026; cv=none;
        d=google.com; s=arc-20160816;
        b=uzhYqnBxgTqJTx4XuRYedUkuUAp5Cqia6qAi4ujBlccYYZl5d/jVxlhPYH+T82xQWE
         xn0VsRqNQTcb7vmLuBWgXtf/8PYBU69YIiqC3Et03WutUcfI5B+tWladCysYqAuZN0qj
         8+T29whrjjXz4X+8Xs5nGYUkRkUb6n3EEWH+Ewj1Gjye75Iue1DNX+6+OZRxrxXvlVJB
         PW1x4BMNAVBPOTZI1wC8/HKKafk2g4s8DyXuh5tsU58TVqA2uNOzY5+oL8eslpmeCh0u
         4xraZdE43zkahpigJ+hsQr5Dk/3cIecC4//gvtmyR4FQEMn8THohCMuzdV0Qd2bqMQHt
         Mn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=5NGrw82pmIw50gRBGFW7SBu+N6V1wwVBWw9N/jiC6Yg=;
        b=vWv+grmsO1VLZVdiBt6uRysybc450/BARlp3Ll0o9pT69ICxprKIwGU7HD2kAuQRmi
         /VVbtFEDYSFPYAK+LQxnTmEGteLGsjyjJ5J9qE469o98xgTjdJx2+FIEpfdG2W2Gd2L7
         0frYe/1gKcNOBy+XvFs+S25zYty5B2fzQjPrlqljf7Cikfp4jujFq/VNCxLUHJX2Qwq4
         GwFnBSG8SegYVAScQrj4xGnMseL2GvFV7M5OxPwpc57D6e6r+rxfqJu7h6zNAHpskZBp
         ULP04IFjruiCSbG/9u3n//KRUB5KfYkEgFk/r0JYvjqBxew3ejmLzWbgNov8bXP5+X23
         sRHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BY1ko1/I;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BY1ko1/I;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuc/qoNCOKhcKYkEZ5xBWzzKVkpe+hJxNCVfq8EveoGADYOXvPZOapPbk46CyjJgDjVGNdhjQ==
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org
Subject: [PATCH 00/25] nvmem: patches for v4.17
Date: Fri,  9 Mar 2018 14:46:54 +0000
Message-Id: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472033191414139?=
X-GMAIL-MSGID: =?utf-8?q?1594472033191414139?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are some nvmem enhancements, cleanup, and update to documentation
mostly done by Andrey, it also adds support to snvs-lpgpr on i.MX7

Can you queue them up for 4.17.

Thanks,
Srini

Andrey Smirnov (21):
  nvmem: Document struct nvmem_config
  nvmem: core: Allow specifying device name verbatim
  nvmem: Introduce devm_nvmem_(un)register()
  nvmem: vf610-ocotp: Convert to use devm_nvmem_register()
  nvmem: imx-ocotp: Convert to use devm_nvmem_register()
  nvmem: uniphier-efuse: Convert to use devm_nvmem_register()
  nvmem: snvs_lgpr: Convert to use devm_nvmem_register()
  nvmem: rockchip-efuse: Convert to use devm_nvmem_register()
  nvmem: mtk-efuse: Convert to use devm_nvmem_register()
  nvmem: meson-mx-efuse: Convert to use devm_nvmem_register()
  nvmem: meson-efuse: Convert to use devm_nvmem_register()
  nvmem: lpc18xx_otp: Convert to use devm_nvmem_register()
  nvmem: imx-iim: Convert to use devm_nvmem_register()
  nvmem: bcm-ocotp: Convert to use devm_nvmem_register()
  nvmem: qfprom: Convert to use devm_nvmem_register()
  nvmem: snvs_lpgpr: Convert commas to semicolons
  nvmem: rockchip-efuse: Make use of of_device_get_match_data()
  nvmem: vf610-ocotp: Do not use "&pdev->dev" explicitly
  nvmem: rockchip-efuse: Do not use "&pdev->dev" explicitly
  nvmem: imx-iim: Do not use "&pdev->dev" explicitly
  nvmem: bcm-ocotp: Do not use "&pdev->dev" explicitly

Andrey Yurovsky (1):
  nvmem: add i.MX7 support to snvs-lpgpr

Dong Aisheng (2):
  dt-bindings: nvmem: imx-ocotp: update the binding to reflect data
    cells
  nvmem: imx-ocotp: remove unused dead code

Icenowy Zheng (1):
  nvmem: sunxi-sid: fix H3 SID controller support

 .../devicetree/bindings/nvmem/imx-ocotp.txt        | 23 +++++--
 .../devicetree/bindings/nvmem/snvs-lpgpr.txt       |  3 +-
 drivers/nvmem/Kconfig                              |  4 +-
 drivers/nvmem/bcm-ocotp.c                          | 15 +----
 drivers/nvmem/core.c                               | 70 ++++++++++++++++++++-
 drivers/nvmem/imx-iim.c                            | 18 +-----
 drivers/nvmem/imx-ocotp.c                          | 18 +-----
 drivers/nvmem/lpc18xx_otp.c                        | 16 +----
 drivers/nvmem/meson-efuse.c                        | 16 +----
 drivers/nvmem/meson-mx-efuse.c                     | 16 +----
 drivers/nvmem/mtk-efuse.c                          | 16 +----
 drivers/nvmem/qfprom.c                             | 16 +----
 drivers/nvmem/rockchip-efuse.c                     | 32 +++-------
 drivers/nvmem/snvs_lpgpr.c                         | 53 ++++++++--------
 drivers/nvmem/sunxi_sid.c                          | 71 +++++++++++++++-------
 drivers/nvmem/uniphier-efuse.c                     | 16 +----
 drivers/nvmem/vf610-ocotp.c                        | 24 ++------
 include/linux/nvmem-provider.h                     | 42 +++++++++++++
 18 files changed, 244 insertions(+), 225 deletions(-)

-- 
2.15.1
