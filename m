Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC24C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E70B2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fHDsGnUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E70B2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbeJRXoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:44:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:32768 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeJRXoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:44:11 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9IFeUg4067077;
        Thu, 18 Oct 2018 10:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539877230;
        bh=SeWuOChOhwoXkaqqWM0kVgRIDhpb3mdaOvWn73fk0cQ=;
        h=From:To:CC:Subject:Date;
        b=fHDsGnUQOZxf+nHmh3O8OQFzhMzVndyTzl8fDzKST3cFEpHYphIgsHbWHOlBbQ4It
         mkes2AH7YFHHZFkLchU3v8ktu7/Sx1lO+rYHdIn13kMBgCwxbJTpu0mCb0AGYQf0CU
         0bxjHaWMT4kNG2G6yGPA9VM4ewmaujgjfij/Vx3w=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9IFeUb8016487;
        Thu, 18 Oct 2018 10:40:30 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 18
 Oct 2018 10:40:29 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 18 Oct 2018 10:40:29 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9IFePOf006432;
        Thu, 18 Oct 2018 10:40:26 -0500
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
Subject: [PATCH v2 00/10] Add support for TISCI irqchip drivers
Date:   Thu, 18 Oct 2018 21:10:07 +0530
Message-ID: <20181018154017.7112-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Changes since v1:
- Consolidated both TISCI and irqchip drivers as suggested by Marc.
- Each patch contains respective changes.

Grygorii Strashko (1):
  firmware: ti_sci: Add support to get TISCI handle using of_phandle

Lokesh Vutla (8):
  firmware: ti_sci: Add support for RM core ops
  firmware: ti_sci: Add support for IRQ management
  firmware: ti_sci: Add helper apis to manage resources
  dt-bindings: irqchip: Introduce TISCI Interrupt router bindings
  irqchip: ti-sci-intr: Add support for Interrupt Router driver
  dt-bindings: irqchip: Introduce TISCI Interrupt Aggregator bindings
  irqchip: ti-sci-inta: Add support for Interrupt Aggregator driver
  soc: ti: am6: Enable interrupt controller drivers

Peter Ujfalusi (1):
  firmware: ti_sci: Add RM mapping table for am654

 .../bindings/arm/keystone/ti,sci.txt          |   3 +-
 .../interrupt-controller/ti,sci-inta.txt      |  74 ++
 .../interrupt-controller/ti,sci-intr.txt      |  81 ++
 MAINTAINERS                                   |   4 +
 drivers/firmware/ti_sci.c                     | 850 ++++++++++++++++++
 drivers/firmware/ti_sci.h                     | 102 +++
 drivers/irqchip/Kconfig                       |  22 +
 drivers/irqchip/Makefile                      |   2 +
 drivers/irqchip/irq-ti-sci-inta.c             | 613 +++++++++++++
 drivers/irqchip/irq-ti-sci-intr.c             | 302 +++++++
 drivers/soc/ti/Kconfig                        |   3 +
 include/linux/irqchip/irq-ti-sci-inta.h       |  35 +
 include/linux/soc/ti/ti_sci_protocol.h        | 169 ++++
 13 files changed, 2259 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
 create mode 100644 drivers/irqchip/irq-ti-sci-intr.c
 create mode 100644 include/linux/irqchip/irq-ti-sci-inta.h

-- 
2.19.1

