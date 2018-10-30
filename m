Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30024C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E178320823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E178320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJ3Ths (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:37:48 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:9905 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726692AbeJ3Ths (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:37:48 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 30 Oct 2018 19:44:49 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 7821C95C4C;
        Tue, 30 Oct 2018 19:44:49 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,444,1534777200"; 
   d="scan'208";a="296394845"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 30 Oct 2018 19:44:46 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] irqchip: Add support for Renesas RZ/N1 GPIO interrupt multiplexer
Date:   Tue, 30 Oct 2018 10:44:36 +0000
Message-Id: <20181030104438.27827-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RZ/N1 devices, there are lots of GPIO interrupts that are multiplexed before
getting to the GIC interrupt controller. Other than the multiplexing, there is
no other logic applied to the signals.

The multiplexing cannot be handled dynamically because there is another CPU that
runs firmware. It's likely that the firmware will use some of these GPIO
interrupts and so we don't want them to move around.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v2:
 - Split DT bindings into separate patch.
 - Use interrupt-map to allow the GPIO controller info to be specified
   as part of the irq.
 - Don't show status in binding examples.
 - Don't show the soc/board split in binding doc.
 - Renamed struct and funcs from 'girq' to a more comprehenisble 'irqmux'.

Phil Edworthy (2):
  dt-bindings/interrupt-controller: rzn1: Add RZ/N1 gpio irq mux binding
  irqchip: Add support for Renesas RZ/N1 GPIO interrupt multiplexer

 .../interrupt-controller/renesas,rzn1-mux.txt |  92 +++++++
 drivers/irqchip/Kconfig                       |  10 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/rzn1-irq-mux.c                | 235 ++++++++++++++++++
 4 files changed, 338 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt
 create mode 100644 drivers/irqchip/rzn1-irq-mux.c

-- 
2.17.1

