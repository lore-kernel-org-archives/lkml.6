Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D29AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440F220846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440F220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbeGZIg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:36:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47455 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726734AbeGZIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:36:27 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6Q7J9Dc009119;
        Thu, 26 Jul 2018 09:20:25 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2kbuqdyac8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 26 Jul 2018 09:20:25 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A60FC3A;
        Thu, 26 Jul 2018 07:20:24 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8681127CB;
        Thu, 26 Jul 2018 07:20:24 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 26 Jul 2018 09:20:24
 +0200
From:   <patrice.chotard@st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alexandre.torgue@st.com>, <lee.jones@linaro.org>
CC:     <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>
Subject: [PATCH 2/4] ARM: dts: stm32: Remove cd-inverted property for stm32f469-disco
Date:   Thu, 26 Jul 2018 09:19:54 +0200
Message-ID: <1532589596-22181-3-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532589596-22181-1-git-send-email-patrice.chotard@st.com>
References: <1532589596-22181-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-26_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Remove cd-inverted property and update cd-gpios active level
accordingly

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 3ee768cb86fc..7937b43d7788 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -210,8 +210,7 @@
 &sdio {
 	status = "okay";
 	vmmc-supply = <&mmc_vcard>;
-	cd-gpios = <&gpiog 2 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpiog 2 GPIO_ACTIVE_LOW>;
 	broken-cd;
 	pinctrl-names = "default", "opendrain";
 	pinctrl-0 = <&sdio_pins>;
-- 
1.9.1

