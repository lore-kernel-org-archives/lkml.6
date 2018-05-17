Return-Path: <erin.lo@mediatek.com>
X-Google-Smtp-Source: AB8JxZpvTLYSWqghiIuYRkRRvEjHLS6avAZeXnuCSOecsMK4DrMTBtY5W7ok72yTaXiLbtI1nxVH
ARC-Seal: i=1; a=rsa-sha256; t=1526538137; cv=none;
        d=google.com; s=arc-20160816;
        b=o2vtnFPVv2R2D/Jga6Usw8+QNbY0JGAxpMDJz5bWtdDwrkVSrwTyLo7EwffCSV+xwV
         3+CbbNegMZy5+Nw5TI6dseH1+8v1MEWg189uIvXsoldvH/rgUD7tYz+gYNQ1Y4WIGqMF
         s/C1PekgFl/iXqvyREoXu/bBPJlJiLkFiUDcEQTsTO7bxBTsl07o6+vZMstpiEemlutJ
         f+cYcpVYhQlwqziFfssDGqfHatZnmRkaqt6c9uV4GqLvZaSAq6AbS656q79JhkZkaps5
         EOsTKbWQzde+VWZZQeZWIhyIWjj6B4rDRX+ed3XIzWY6w9JVrYaYCDg63T12KMGAkvSC
         qseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=4TVuVcuqm8rVhHDkdCBa81qpXL1tpTnrU16vA0F0lAw=;
        b=BWoymJg0rQtZ1nNuhWoY4oSA0vh8sH05OXu80DTK9qpgs7OXRsyLR23xZv1pl2aYjy
         3PCMygPQtJtowkwaKPj96YQ//8ASer19fgJd2uxegDvw/S2gdOG0zjF02OX5T/AZc8K8
         Q4SiSYxHHXOjqD+vlFYzjYBcGATXH4gL/0xvOFQjnLHwL695rfKcnwywOHajF7NAM0e4
         /AyZ+++wAxNd2J0kXDD5kp4yr4JUpm5qIN8XO358037iOcOISJJDrELzN54YLaszRHi8
         4YfTFowussHJI2y+JotUOC6aF2iwP0/UyQC2uHgGMFwwoY4mDy7t7P31RIcpgnHzMZpK
         50kQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of erin.lo@mediatek.com designates 210.61.82.183 as permitted sender) smtp.mailfrom=erin.lo@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of erin.lo@mediatek.com designates 210.61.82.183 as permitted sender) smtp.mailfrom=erin.lo@mediatek.com
X-UUID: 55cf72e1da2e401791d6a83b40b95202-20180517
From: Erin Lo <erin.lo@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner
	<tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier
	<marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <devicetree@vger.kernel.org>, srv_heupstream
	<srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <yingjoe.chen@mediatek.com>,
	<erin.lo@mediatek.com>, <mars.cheng@mediatek.com>
Subject: [PATCH v3 0/4] Add basic support for Mediatek MT8183 SoC
Date: Thu, 17 May 2018 14:22:02 +0800
Message-ID: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600691253968751720?=
X-GMAIL-MSGID: =?utf-8?q?1600691253968751720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

MT8183 is a SoC based on 64bit ARMv8 architecture.
It contains 4 CA53 and 4 CA73 cores.
MT8183 share many HW IP with MT65xx series.
This patchset was tested on MT8183 evaluation board, and boot to shell ok.

This series contains document bindings, device tree including interrupt, uart.

Change in v3:
1. Fill out GICC, GICH, GICV regions
2. Update Copyright to 2018

Change in v2:
1. Split dt-bindings into different patches
2. Correct bindings for supported SoCs (mtk-uart.txt)

Ben Ho (1):
  arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
    Makefile

Erin Lo (3):
  dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
  dt-bindings: mtk-sysirq: Add compatible for Mediatek MT8183
  dt-bindings: serial: Add compatible for Mediatek MT8183

 Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
 .../interrupt-controller/mediatek,sysirq.txt       |   1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |  31 ++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           | 182 +++++++++++++++++++++
 6 files changed, 220 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi

--
1.9.1
