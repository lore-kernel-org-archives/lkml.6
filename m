Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DF5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3FC204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3FC204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754454AbeFUJDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:03:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10883 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754359AbeFUJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:03:09 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5L8wfm5022354;
        Thu, 21 Jun 2018 11:02:26 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jqq71v8up-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Jun 2018 11:02:26 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 605DF3F;
        Thu, 21 Jun 2018 09:02:24 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA65A266E;
        Thu, 21 Jun 2018 09:02:23 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.94) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Jun
 2018 11:02:23 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Jun
 2018 11:02:21 +0200
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
Subject: [PATCH V4 0/4] add iwdg2 support for stm32mp157c
Date:   Thu, 21 Jun 2018 11:02:13 +0200
Message-ID: <1529571737-3552-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series updates stm32_iwdg driver to manage pclk
clock by compatible. stm32mp1 requires a pclk clock.

v4:
-dt-bindings: split and review

v3:
-remove stm32_iwdg_config structure, just assign the
 boolean directly to .dat

Ludovic Barre (4):
  dt-bindings: watchdog: add stm32mp1 support
  watchdog: stm32: add pclk feature for stm32mp1
  ARM: dts: stm32: add iwdg2 support for stm32mp157c
  ARM: dts: stm32: add iwdg2 support for stm32mp157c-ed1

 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  13 ++-
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   5 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   8 ++
 drivers/watchdog/stm32_iwdg.c                      | 116 +++++++++++++--------
 4 files changed, 97 insertions(+), 45 deletions(-)

-- 
2.7.4

