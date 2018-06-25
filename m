Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E095CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9945023DFA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9945023DFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeFYPoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:44:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35318 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751513AbeFYPn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:43:56 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5PFcScF029720;
        Mon, 25 Jun 2018 17:43:16 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ju0n98rhd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Jun 2018 17:43:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B7C8E31;
        Mon, 25 Jun 2018 15:43:15 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 985652872;
        Mon, 25 Jun 2018 15:43:15 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.94) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 25 Jun
 2018 17:43:15 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 25 Jun
 2018 17:43:15 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V5 0/5] add iwdg2 support for stm32mp157c
Date:   Mon, 25 Jun 2018 17:42:58 +0200
Message-ID: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series updates stm32_iwdg driver to manage pclk
clock by compatible. stm32mp1 requires a pclk clock.

v5:
-update stm32f429.dtsi

v4:
-dt-bindings: split and review

v3:
-remove stm32_iwdg_config structure, just assign the
 boolean directly to .dat

Ludovic Barre (5):
  dt-bindings: watchdog: add stm32mp1 support
  watchdog: stm32: add pclk feature for stm32mp1
  ARM: dts: stm32: add iwdg2 support for stm32mp157c
  ARM: dts: stm32: add iwdg2 support for stm32mp157c-ed1
  ARM: dts: stm32: update iwdg with lsi clock name for stm32f429

 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  13 ++-
 arch/arm/boot/dts/stm32f429.dtsi                   |   1 +
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   5 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   8 ++
 drivers/watchdog/stm32_iwdg.c                      | 116 +++++++++++++--------
 5 files changed, 98 insertions(+), 45 deletions(-)

-- 
2.7.4

