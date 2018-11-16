Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5456C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F1C208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F1C208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389530AbeKPWc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:32:58 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:12050 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728024AbeKPWc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:32:57 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAGCIl2b028611;
        Fri, 16 Nov 2018 13:20:27 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nr7d4qhgg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 16 Nov 2018 13:20:27 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EF15631;
        Fri, 16 Nov 2018 12:20:25 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 957A12A17;
        Fri, 16 Nov 2018 12:20:25 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 16 Nov 2018 13:20:24
 +0100
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] SYSCFG Fast Mode Plus support for I2C STM32F7
Date:   Fri, 16 Nov 2018 13:20:20 +0100
Message-ID: <1542370822-14721-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-16_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Append optional bindings to update SYSCFG Fast Mode Plus bits if
Fast Mode Plus speed is selected.

---
  Version history:
    v1:
       * Initial
---

Pierre-Yves MORDRET (2):
  dt-bindings: i2c-stm32: SYSCFG Fast Mode Plus support for I2C STM32F7
  i2c: i2c-stm32f7: SYSCFG Fast Mode Plus support for I2C STM32F7

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  6 ++++
 drivers/i2c/busses/i2c-stm32f7.c                   | 37 ++++++++++++++++++++--
 2 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.7.4

