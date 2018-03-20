Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeCTDYC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:24:02 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34832 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCTDX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:23:58 -0400
X-Google-Smtp-Source: AG47ELt0Ht5Xx/eiQI2UcyZc02He6NzWrLp6HrECr9WGoJG6Kn9gHvTKd21eFvCOxQOFWfsEh2Xcmg==
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
Subject: [PATCH v5 0/3] Bluetooth: hci_qca: Add serdev support
Date: Tue, 20 Mar 2018 04:23:28 +0100
Message-Id: <20180320032331.29865-1-thierry.escande@linaro.org>
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

v5:
- Rename 'bt-disable-n' gpio as 'enable'

v4:
- Fix dt binding documentation
- Address some other issues in patch #3

v3:
- Address comments for patch #3 (details in patch)

v2:
- Fix author email

Thierry Escande (3):
  arm64: dts: apq8096-db820c: enable bluetooth node
  dt-bindings: net: bluetooth: Add qualcomm-bluetooth
  Bluetooth: hci_qca: Add serdev support

 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  34 +++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi  |  14 +++
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    |  17 ++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |  33 +++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  10 ++
 drivers/bluetooth/Kconfig                          |   1 +
 drivers/bluetooth/hci_qca.c                        | 109 ++++++++++++++++++++-
 7 files changed, 216 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt

-- 
2.14.1
