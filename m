Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9B7C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55F82075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfBEJHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:07:34 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1545 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725898AbfBEJHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:07:33 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x158uNOc002818;
        Tue, 5 Feb 2019 10:07:19 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qd17bp1uh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Feb 2019 10:07:19 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9426931;
        Tue,  5 Feb 2019 09:07:17 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6B012247E;
        Tue,  5 Feb 2019 09:07:17 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 Feb 2019 10:07:16
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add STM32MP157 discovery boards support
Date:   Tue, 5 Feb 2019 10:07:03 +0100
Message-ID: <1549357625-7229-1-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support of two new discovery boards based on
STM32MP157 MPU: stm32mp157a-dk1 and stm32mp157c-dk2.

stm32mp157a-dk1 board embeds a STM32MP157a SOC with AC package (TFBGA361,
148 ios) and 512MB of DDR3. Several connections are available on this boards:
4*USB2.0, 1*USB2.0 typeC, SDcard, RJ45, HDMI, Arduino connector, ...

stm32mp157c-dk2 board complements stm32mp157a-dk1 board with a display panel
(otm8009a) and a Murata Wifi/BT combo. It embeds a STM32MP157c SOC with AC
package.

Those patches enable basic support for a kernel boot.

regards
Alex

Alexandre Torgue (2):
  ARM: dts: stm32: add initial support of stm32mp157a-dk1 board
  ARM: dts: stm32: add initial support of stm32mp157c-dk2 board

 arch/arm/boot/dts/Makefile            |  2 +
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 77 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-dk2.dts | 75 ++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-dk1.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-dk2.dts

-- 
2.7.4

