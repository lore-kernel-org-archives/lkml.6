Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F80C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451C12077C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451C12077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbeKOS7r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:59:47 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53048 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728634AbeKOS7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:59:47 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAF8nJmY012034;
        Thu, 15 Nov 2018 09:52:31 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nr7d8rg5t-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 15 Nov 2018 09:52:31 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 967903A;
        Thu, 15 Nov 2018 08:52:29 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D725130D;
        Thu, 15 Nov 2018 08:52:29 +0000 (GMT)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 15 Nov
 2018 09:52:28 +0100
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1347.000; Thu, 15 Nov 2018 09:52:28 +0100
From:   Bich HEMON <bich.hemon@st.com>
To:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/3] CAN fix for stm32mp157c
Thread-Topic: [PATCH 0/3] CAN fix for stm32mp157c
Thread-Index: AQHUfMCJYzTigdVFjUeihOzOfe8VNA==
Date:   Thu, 15 Nov 2018 08:52:28 +0000
Message-ID: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset changes the CAN RAM mapping and adds CAN sleep pins.

Bich Hemon (3):
  ARM: dts: stm32: change CAN RAM mapping on stm32mp157c
  ARM: dts: stm32: add can1 sleep pins muxing
  ARM: dts: stm32: add can1 sleep pins muxing on stm32mp157c-ev1 board

 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 7 +++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     | 3 ++-
 arch/arm/boot/dts/stm32mp157c.dtsi        | 4 ++--
 3 files changed, 11 insertions(+), 3 deletions(-)

-- 
1.9.1
