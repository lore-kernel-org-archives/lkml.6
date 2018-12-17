Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9162C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5E020874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbeLQOXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:23:05 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29770 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731916AbeLQOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:23:02 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBHELmjt018492;
        Mon, 17 Dec 2018 15:22:34 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pcr8xjc8r-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 17 Dec 2018 15:22:33 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE5DC31;
        Mon, 17 Dec 2018 14:22:32 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A26022424;
        Mon, 17 Dec 2018 14:22:32 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 17 Dec
 2018 15:22:32 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 17 Dec 2018 15:22:31
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.torgue@st.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 0/3] Make STM32 interrupt controller use hwspinlock
Date:   Mon, 17 Dec 2018 15:22:12 +0100
Message-ID: <20181217142215.17493-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allow to protect STM32 interrupt controller configuration registers
with a hwspinlock to avoid conflicting accesses between processors. 

version 3:
- with bindings patch

version 2:
- rework hwspinlock locking sequence in stm32 irqchip to take care of the
  cases where hwspinlock node is disabled or not yet probed

Benjamin Gaignard (3):
  dt-bindings: interrupt-controller: stm32: Document hwlock properties
  irqchip: stm32: protect configuration registers with hwspinlock
  ARM: dts: stm32: Add hwlock for irqchip on stm32mp157

 .../interrupt-controller/st,stm32-exti.txt         |   4 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   1 +
 drivers/irqchip/irq-stm32-exti.c                   | 116 ++++++++++++++++++---
 3 files changed, 105 insertions(+), 16 deletions(-)

-- 
2.15.0

