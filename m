Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754812AbeCVM7P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:59:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754735AbeCVM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:59:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AFC9601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com, richardcochran@gmail.com
Cc: sricharan@codeaurora.org
Subject: [PATCH v4 00/13] ARM: dts: ipq: updates to enable a few peripherals
Date: Thu, 22 Mar 2018 18:28:39 +0530
Message-Id: <1521723532-28361-1-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v4]
    * Fixed more comments.
    * Dropped reserved-memory nodes from board files as
      that might break existing users whose u-boot do not
      specify the fdt_high accordingly.
    * Added chosen serial node for all boards to have
      the default serial console specified from DT.

[v3]
    * Fixed minor comments from v2,
      https://www.spinics.net/lists/arm-kernel/msg641480.html

    * Added Abhishek's review tags

[v2]
    * Addressed all comments from Abhishek
    * Removed dk01-c2 and dk04-c5 spinand based boards
      as support for spinand is not complete
    * Based all patches on top of Andy's for-next branch

[V1]
    * https://www.spinics.net/lists/arm-kernel/msg631318.html

Sricharan R (13):
  firmware: qcom: scm: Add ipq4019 soc compatible
  ARM: dts: ipq4019: Add a default chosen node
  ARM: dts: ipq4019: Add a few peripheral nodes
  ARM: dts: ipq4019: Change the max opp frequency
  ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
  ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1 board file
  ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk04.1-c3 board file
  ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
  ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c1 board file
  ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c2 board file
  ARM: dts: ipq8074: Add peripheral nodes
  ARM: dts: ipq8074: Add pcie nodes
  ARM: dts: ipq8074: Enable few peripherals for hk01 board

 .../devicetree/bindings/firmware/qcom,scm.txt      |   3 +-
 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi      |   8 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts    |  20 ++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts    |   8 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi      | 115 +++++++++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts    |  65 +++++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts    |  26 ++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi      |  68 ++++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi                | 140 ++++++++++-
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          | 103 ++++++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 262 ++++++++++++++++++++-
 drivers/firmware/qcom_scm.c                        |   3 +
 13 files changed, 820 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
