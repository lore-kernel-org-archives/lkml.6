Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205C6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B472085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B472085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbeKFSGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:06:06 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33916 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbeKFSGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:06:06 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA68fPt2053781;
        Tue, 6 Nov 2018 02:41:25 -0600
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA68fPHZ122558
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 02:41:25 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 02:41:24 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 02:41:24 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA68fJ3j032677;
        Tue, 6 Nov 2018 02:41:20 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 00/13] Add support for TISCI irqchip drivers
Date:   Tue, 6 Nov 2018 14:10:52 +0530
Message-ID: <20181106084105.32483-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TISCI abstracts the handling of IRQ routes where interrupt sources
are not directly connected to host interrupt controller. This series
adds support for:
- TISCI commands needed for IRQ configuration
- Interrupt Router(INTR) and Interrupt Aggregator(INTA) drivers

More information on TISCI IRQ management can be found here[1].
Complete TISCI resource management information can be found here[2].
AM65x SoC related TISCI information can be found here[3].
INTR and INTA related information can be found in TRM[4].

[1] http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
[2] http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/index.html#resource-management-rm
[3] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/index.html#am6-soc-family
[4] http://www.ti.com/lit/pdf/spruid7

Changes since v2:
- Added MSI support for allocating INTA interrupts
- Each patch contains respective changes.

Changes since v1:
- Consolidated both TISCI and irqchip drivers as suggested by Marc.
- Each patch contains respective changes.


Grygorii Strashko (1):
  firmware: ti_sci: Add support to get TISCI handle using of_phandle

Lokesh Vutla (11):
  firmware: ti_sci: Add support for RM core ops
  firmware: ti_sci: Add support for IRQ management
  firmware: ti_sci: Add helper apis to manage resources
  dt-bindings: irqchip: Introduce TISCI Interrupt router bindings
  irqchip: ti-sci-intr: Add support for Interrupt Router driver
  genirq/msi: Add support for allocating single MSI for a device
  genirq/msi: Add support for .msi_unprepare callback
  soc: ti: Add MSI domain support for K3 Interrupt Aggregator
  dt-bindings: irqchip: Introduce TISCI Interrupt Aggregator bindings
  irqchip: ti-sci-inta: Add support for Interrupt Aggregator driver
  soc: ti: am6: Enable interrupt controller drivers

Peter Ujfalusi (1):
  firmware: ti_sci: Add RM mapping table for am654

 .../bindings/arm/keystone/ti,sci.txt          |   3 +-
 .../interrupt-controller/ti,sci-inta.txt      |  74 ++
 .../interrupt-controller/ti,sci-intr.txt      |  84 ++
 MAINTAINERS                                   |   4 +
 drivers/firmware/ti_sci.c                     | 850 ++++++++++++++++++
 drivers/firmware/ti_sci.h                     | 102 +++
 drivers/irqchip/Kconfig                       |  23 +
 drivers/irqchip/Makefile                      |   2 +
 drivers/irqchip/irq-ti-sci-inta.c             | 543 +++++++++++
 drivers/irqchip/irq-ti-sci-intr.c             | 310 +++++++
 drivers/soc/ti/Kconfig                        |   9 +
 drivers/soc/ti/Makefile                       |   1 +
 drivers/soc/ti/k3_inta_msi.c                  | 163 ++++
 include/linux/irqdomain.h                     |   1 +
 include/linux/msi.h                           |  12 +
 include/linux/soc/ti/k3_inta_msi.h            |  21 +
 include/linux/soc/ti/ti_sci_protocol.h        | 169 ++++
 kernel/irq/msi.c                              |  72 +-
 18 files changed, 2420 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
 create mode 100644 drivers/irqchip/irq-ti-sci-intr.c
 create mode 100644 drivers/soc/ti/k3_inta_msi.c
 create mode 100644 include/linux/soc/ti/k3_inta_msi.h

-- 
2.19.1

