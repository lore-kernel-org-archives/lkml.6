Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7166C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0F62083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfBEMlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:41:04 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16557 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbfBEMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:40:58 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x15CaEJP002718;
        Tue, 5 Feb 2019 13:40:41 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qd1v06pqm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Feb 2019 13:40:41 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C627231;
        Tue,  5 Feb 2019 12:40:40 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 74D3529AC;
        Tue,  5 Feb 2019 12:40:40 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 Feb 2019 13:40:40
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <vilhelm.gray@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/4] Add PM support to STM32 LP Timer drivers
Date:   Tue, 5 Feb 2019 13:40:25 +0100
Message-ID: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds power management support for STM32 LP Timer
drivers:
- PWM driver
- IIO counter driver
- Document the pinctrl states for sleep mode

Fabrice Gasnier (4):
  dt-bindings: pwm-stm32-lp: document pinctrl sleep state
  pwm: stm32-lp: Add power management support
  dt-bindings: iio: stm32-lptimer-counter: document pinctrl sleep state
  iio: counter: stm32-lptimer: Add power management support

 .../bindings/iio/counter/stm32-lptimer-cnt.txt     |  8 ++--
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 ++--
 drivers/iio/counter/stm32-lptimer-cnt.c            | 55 ++++++++++++++++++++++
 drivers/pwm/pwm-stm32-lp.c                         | 38 +++++++++++++++
 4 files changed, 104 insertions(+), 6 deletions(-)

-- 
1.9.1

