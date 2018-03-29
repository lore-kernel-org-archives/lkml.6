Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeC2TPu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:15:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53041 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeC2TPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:15:47 -0400
X-Google-Smtp-Source: AIpwx4+Ti3FAbWJYihTsvNZvEWoj2F+ooFcI+9y6aUafyIvxOQ5Apwx9OkZ6FtJlXndmI6befIOJsg==
From: Thierry Escande <thierry.escande@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] Bluetooth: hci_qca: Add serdev support
Date: Thu, 29 Mar 2018 21:15:20 +0200
Message-Id: <20180329191524.30225-1-thierry.escande@linaro.org>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset enables the Qualcomm BT controller QCA6174 node in the
device tree of the db820c board. This allows the bluetooth chipset to
be probed and registered against the hci layer by using the serdev
framework.

This patchset also contains the documentation for the compatible
string "qcom,qca6174-bt" related to this chipset.

v7:
- Add a new patch enabling regulators and gpios for the bt/wlan
  combo chip

v6:
- Move pinctrl properties into subnodes
- fix binding documentation

v5:
- Rename 'bt-disable-n' gpio as 'enable'

v4:
- Fix dt binding documentation
- Address some other issues in patch #3

v3:
- Address comments for patch #3 (details in patch)

v2:
- Fix author email


Srinivas Kandagatla (1):
  arm64: dts: apq8096-db820c: Enable wlan and bt en pins

Thierry Escande (3):
  arm64: dts: apq8096-db820c: enable bluetooth node
  dt-bindings: net: bluetooth: Add qualcomm-bluetooth
  Bluetooth: hci_qca: Add serdev support

 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  30 ++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi  |  26 +++++
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    |  32 ++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |  62 ++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  10 ++
 drivers/bluetooth/Kconfig                          |   1 +
 drivers/bluetooth/hci_qca.c                        | 109 ++++++++++++++++++++-
 7 files changed, 268 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt

-- 
2.14.1
