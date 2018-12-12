Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D852AC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86752086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86752086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeLLItA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:49:00 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11792 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbeLLIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:48:50 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBC8jdo1000815;
        Wed, 12 Dec 2018 09:48:28 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2p84a3dc6t-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 12 Dec 2018 09:48:28 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7452938;
        Wed, 12 Dec 2018 08:48:27 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D3E52761;
        Wed, 12 Dec 2018 08:48:27 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 12 Dec 2018 09:48:26
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <mark.rutland@arm.com>, <gabriel.fernandez@st.com>,
        <fabrice.gasnier@st.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/3] mfd: syscon: Add optional clock support needed on stm32
Date:   Wed, 12 Dec 2018 09:48:12 +0100
Message-ID: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 syscfg registers are accessed using syscon. It needs syscfg clock
to be enabled while accessing registers.
This adds support for optional clock on syscon, and the relevant clock
in stm32mp157 device tree.

Changes in v2:
- move clocks to specific bindings using syscon as per Rob's comment

Fabrice Gasnier (3):
  dt-bindings: stm32: syscon: add clock support
  mfd: syscon: Add optional clock support
  ARM: dts: stm32: Add clock on stm32mp157c syscfg

 .../devicetree/bindings/arm/stm32/stm32-syscon.txt    |  2 ++
 arch/arm/boot/dts/stm32mp157c.dtsi                    |  1 +
 drivers/mfd/syscon.c                                  | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)

-- 
1.9.1

