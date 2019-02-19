Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C5F21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfBSKE5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:04:57 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28363 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728056AbfBSKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:04:44 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JA1wJF005510;
        Tue, 19 Feb 2019 11:04:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qpc6kq317-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 19 Feb 2019 11:04:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4304434;
        Tue, 19 Feb 2019 10:04:35 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 21A6D2796;
        Tue, 19 Feb 2019 10:04:35 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Feb
 2019 11:04:34 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Tue, 19 Feb 2019 11:04:34 +0100
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     Pascal PAILLET-LME <p.paillet@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 6/8] regulator: stpmic1: Change buck1 voltage range
Thread-Topic: [PATCH 6/8] regulator: stpmic1: Change buck1 voltage range
Thread-Index: AQHUyDqDtPJ98jbuB0CViS+ZBGtAUQ==
Date:   Tue, 19 Feb 2019 10:04:34 +0000
Message-ID: <1550570647-9555-7-git-send-email-p.paillet@st.com>
References: <1550570647-9555-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1550570647-9555-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change buck1 voltage range to be conform with the data-sheet.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 drivers/regulator/stpmic1_regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 6970e45..41128c4 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -56,8 +56,9 @@ enum {
 #define PMIC_ENABLE_TIME_US 2200
 
 static const struct regulator_linear_range buck1_ranges[] = {
-	REGULATOR_LINEAR_RANGE(600000, 0, 30, 25000),
-	REGULATOR_LINEAR_RANGE(1350000, 31, 63, 0),
+	REGULATOR_LINEAR_RANGE(725000, 0, 4, 0),
+	REGULATOR_LINEAR_RANGE(725000, 5, 36, 25000),
+	REGULATOR_LINEAR_RANGE(1500000, 37, 63, 0),
 };
 
 static const struct regulator_linear_range buck2_ranges[] = {
-- 
1.9.1
