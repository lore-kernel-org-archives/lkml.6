Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA423C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9965720839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9965720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeLLIsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:48:51 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57052 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726519AbeLLIst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:48:49 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBC8kD7l031600;
        Wed, 12 Dec 2018 09:48:29 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2p85qk5pt1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 12 Dec 2018 09:48:29 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 49C9731;
        Wed, 12 Dec 2018 08:48:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2501C275D;
        Wed, 12 Dec 2018 08:48:28 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 12 Dec 2018 09:48:27
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
Subject: [PATCH v2 1/3] dt-bindings: stm32: syscon: add clock support
Date:   Wed, 12 Dec 2018 09:48:13 +0100
Message-ID: <1544604495-4082-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 system configuration controller registers needs to be clocked.
Document clock support on stm32-syscon.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
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

