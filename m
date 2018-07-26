Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08191C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5F92083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5F92083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeGZIg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:36:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17510 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728749AbeGZIgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:36:25 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6Q7JRtM025932;
        Thu, 26 Jul 2018 09:20:23 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kf8sq0caf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 26 Jul 2018 09:20:23 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0887D34;
        Thu, 26 Jul 2018 07:20:22 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D4A9127BB;
        Thu, 26 Jul 2018 07:20:22 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 26 Jul 2018 09:20:22
 +0200
From:   <patrice.chotard@st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alexandre.torgue@st.com>, <lee.jones@linaro.org>
CC:     <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH 0/4] Remove cd-inverted property for STM32Fx boards
Date:   Thu, 26 Jul 2018 09:19:52 +0200
Message-ID: <1532589596-22181-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-26_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

This series remove cd-inverted property from STM32Fx boards DT files.
As GPIOS are used for card detect, the polarity can be indicated using 
GPIO_ACTIVE_(HIGH|LOW), so cd-inverted becomes useless.

Patrice Chotard (4):
  ARM: dts: stm32: Remove cd-inverted property for stm32429i-eval
  ARM: dts: stm32: Remove cd-inverted property for stm32f469-disco
  ARM: dts: stm32: Remove cd-inverted property for stm32f769-disco
  ARM: dts: stm32: Remove cd-inverted property for stm32f746-disco

 arch/arm/boot/dts/stm32429i-eval.dts  | 3 +--
 arch/arm/boot/dts/stm32f469-disco.dts | 3 +--
 arch/arm/boot/dts/stm32f746-disco.dts | 3 +--
 arch/arm/boot/dts/stm32f769-disco.dts | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

-- 
1.9.1

