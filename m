Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0574EC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93A520859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfAGKIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:08:20 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42938 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726712AbfAGKIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:08:19 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x07A3fDq001096;
        Mon, 7 Jan 2019 11:07:58 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ptvjffee2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 07 Jan 2019 11:07:58 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EBB403D;
        Mon,  7 Jan 2019 10:07:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9F91F2A00;
        Mon,  7 Jan 2019 10:07:57 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 7 Jan 2019 11:07:57
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <lee.jones@linaro.org>, <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <mark.rutland@arm.com>, <gabriel.fernandez@st.com>,
        <fabrice.gasnier@st.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RESEND PATCH v2 1/3] dt-bindings: stm32: syscon: add clock support
Date:   Mon, 7 Jan 2019 11:07:43 +0100
Message-ID: <1546855665-26218-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546855665-26218-1-git-send-email-fabrice.gasnier@st.com>
References: <1546855665-26218-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 system configuration controller registers needs to be clocked.
Document clock support on stm32-syscon.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- move clocks to specific bindings using syscon as per Rob's comment
---
 Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt b/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
index 99980ae..c92d411 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
@@ -5,10 +5,12 @@ Properties:
                  - " st,stm32mp157-syscfg " - for stm32mp157 based SoCs,
                  second value must be always "syscon".
    - reg : offset and length of the register set.
+   - clocks: phandle to the syscfg clock
 
  Example:
          syscfg: syscon@50020000 {
                  compatible = "st,stm32mp157-syscfg", "syscon";
                  reg = <0x50020000 0x400>;
+                 clocks = <&rcc SYSCFG>;
          };
 
-- 
1.9.1

