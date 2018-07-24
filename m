Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92D6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC6B20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC6B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbeGXQJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:09:56 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:54192 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388712AbeGXQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:09:56 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41ZhS228r1z1qxDj;
        Tue, 24 Jul 2018 17:02:53 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41ZhRx1qfdz1tLP4;
        Tue, 24 Jul 2018 17:02:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ym8khvugTCaC; Tue, 24 Jul 2018 17:02:51 +0200 (CEST)
X-Auth-Info: xl+9+RaIpcO6eIH9Oc7wAiL/zM+SiL5hg7lctNv9vlA=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 24 Jul 2018 17:02:51 +0200 (CEST)
From:   Parthiban Nallathambi <pn@denx.de>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sravanhome@gmail.com,
        thomas.liau@actions-semi.com, mp-cs@actions-semi.com,
        linux@cubietech.com, edgar.righi@lsitec.org.br,
        laisa.costa@lsitec.org.br, guilherme.simoes@lsitec.org.br,
        mkzuffo@lsi.usp.br, Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH 0/3] Add Actions Semi Owl family sirq support
Date:   Tue, 24 Jul 2018 17:02:16 +0200
Message-Id: <20180724150219.1807724-1-pn@denx.de>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for external interrupt controller
in Actions Semi Owl famil of SoC's (S500, S700 and S900). Actions
provides support for external interrupt controller to be connected
with it's SoC's using 3 SIRQ pins.

Each line can be configures independently, i.e 3 independent external
interrupt controller can be connected and managed parallely.

Device tree node is created only for S700 after testing it in Cubieboard7.

Thanks,
Parthiban
Saravanan

Parthiban Nallathambi (3):
  dt-bindings: interrupt-controller: Actions external interrupt
    controller
  drivers/irqchip: Add Actions external interrupts support
  arm64: dts: actions: Add sirq node for Actions Semi S700

 .../interrupt-controller/actions,owl-sirq.txt      |  34 +++
 arch/arm64/boot/dts/actions/s700.dtsi              |  11 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-owl-sirq.c                     | 275 +++++++++++++++++++++
 4 files changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
 create mode 100644 drivers/irqchip/irq-owl-sirq.c

-- 
2.14.4

