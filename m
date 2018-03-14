Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752471AbeCNPzo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:55:44 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35550 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbeCNPzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:55:38 -0400
X-Google-Smtp-Source: AG47ELty18r4hhDks9RH2ZO9qRex381Nvi+jfJO7oDyrc5F57hLXrETzWWJ/3JM/i5pAOvqoICEV9w==
From: Thierry Escande <thierry.escande@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Bluetooth: hci_qca: Add serdev support
Date: Wed, 14 Mar 2018 16:55:11 +0100
Message-Id: <20180314155514.3374-1-thierry.escande@linaro.org>
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
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |  32 ++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  10 ++
 drivers/bluetooth/Kconfig                          |   1 +
 drivers/bluetooth/hci_qca.c                        | 109 ++++++++++++++++++++-
 7 files changed, 215 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt

-- 
2.14.1
