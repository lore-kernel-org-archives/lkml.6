Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6628C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14842229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406666AbfBNKlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:41:35 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3237 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388972AbfBNKlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:41:04 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EAa3EO000645;
        Thu, 14 Feb 2019 11:40:51 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qmxr72gn1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 11:40:51 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 66AE138;
        Thu, 14 Feb 2019 10:40:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node2.st.com [10.75.127.11])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F41F4EB0;
        Thu, 14 Feb 2019 10:40:50 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG4NODE2.st.com (10.75.127.11)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb 2019 11:40:49
 +0100
From:   <gabriel.fernandez@st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: [PATCH v2 0/7] update STM32MP1 clocks
Date:   Thu, 14 Feb 2019 11:40:40 +0100
Message-ID: <20190214104047.1173-1-gabriel.fernandez@st.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Changes:
v2:
- add more explanation in commit mesages
- add one comment to the code

This patch-set fixes minor corrections (fixes and documentation alignment)
- add missing parent clocks
- don't change parent on set rate for kernel clocks
- set ck_csi clock as critical
- fix divider configuration



Gabriel Fernandez (7):
  clk: stm32mp1: parent clocks update
  clk: stm32mp1: add CLK_SET_RATE_NO_REPARENT to Kernel clocks
  clk: stm32mp1: set ck_csi as critical clock
  clk: stm32mp1: fix mcu divider table
  clk: stm32mp1: fix HSI divider flag
  clk: stm32mp1: remove unnecessary CLK_DIVIDER_ALLOW_ZERO flag
  clk: stm32mp1: fix bit width of hse_rtc divider

 drivers/clk/clk-stm32mp1.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

-- 
2.17.0

