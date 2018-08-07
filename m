Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD02C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA52A21707
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA52A21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbeHGNVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:21:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40263 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727286AbeHGNVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:21:12 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w77B3sqi010403;
        Tue, 7 Aug 2018 13:06:52 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kq7gv0vqb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 07 Aug 2018 13:06:52 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8839B38;
        Tue,  7 Aug 2018 11:06:51 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 555752BDA;
        Tue,  7 Aug 2018 11:06:51 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 7 Aug 2018 13:06:50
 +0200
From:   <patrice.chotard@st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alexandre.torgue@st.com>, <lee.jones@linaro.org>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH 0/3] ARM: dts: stm32: Fix DT dtc warnings for STM32 MCU's
Date:   Tue, 7 Aug 2018 13:06:32 +0200
Message-ID: <1533639995-27047-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

This series fixes DT dtc warnings for following STM32 MCU's boards:
	- stm32f429i evaluation
	- stm32f429 discovery
	- stm32f469 discovery
	- stm32746g evaluation
	- stm32f746 discovery
	- stm32h743i discovery
	- stm32h743i evaluation

Patrice Chotard (3):
  ARM: dts: stm32: Fix DT dtc warnings for stm32h7
  ARM: dts: stm32: Fix DT dtc warnings for stm32f7
  ARM: dts: stm32: Fix DT dtc warnings for stm32f4

 arch/arm/boot/dts/stm32429i-eval.dts     | 11 +++--
 arch/arm/boot/dts/stm32746g-eval.dts     |  9 ++--
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi   | 30 ++++++-------
 arch/arm/boot/dts/stm32f429-disco.dts    |  7 ++-
 arch/arm/boot/dts/stm32f429-pinctrl.dtsi | 74 +++++++++++++++----------------
 arch/arm/boot/dts/stm32f429.dtsi         |  8 ++--
 arch/arm/boot/dts/stm32f469-disco.dts    | 11 +++--
 arch/arm/boot/dts/stm32f469-pinctrl.dtsi | 76 +++++++++++++++-----------------
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi   | 24 +++++-----
 arch/arm/boot/dts/stm32f746-disco.dts    |  6 +--
 arch/arm/boot/dts/stm32f746.dtsi         |  8 ++--
 arch/arm/boot/dts/stm32f769-disco.dts    | 11 +++--
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 10 ++---
 arch/arm/boot/dts/stm32h743.dtsi         |  8 ++--
 arch/arm/boot/dts/stm32h743i-disco.dts   |  2 +-
 arch/arm/boot/dts/stm32h743i-eval.dts    |  2 +-
 16 files changed, 140 insertions(+), 157 deletions(-)

-- 
1.9.1

