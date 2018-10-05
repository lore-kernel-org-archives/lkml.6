Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82057C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E9E20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E9E20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeJERHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:07:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35226 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727179AbeJERHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:07:17 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w95A451D017515;
        Fri, 5 Oct 2018 12:08:48 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2msxh72enw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Oct 2018 12:08:48 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 761A831;
        Fri,  5 Oct 2018 10:08:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4796E2759;
        Fri,  5 Oct 2018 10:08:47 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Oct
 2018 12:08:46 +0200
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Fri, 5 Oct 2018 12:08:46 +0200
From:   David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 3/3] ARM: dts: stm32: add thermal sensor support on
 STM32MP157c
Thread-Topic: [PATCH 3/3] ARM: dts: stm32: add thermal sensor support on
 STM32MP157c
Thread-Index: AQHUXJNnQ8tWPiS7A0id/rjY2f04UQ==
Date:   Fri, 5 Oct 2018 10:08:46 +0000
Message-ID: <1538734081-26585-4-git-send-email-david.hernandezsanchez@st.com>
References: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
In-Reply-To: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0932A0602563C245875E65CD0851CD2C@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGNvbmZpZ3VyYXRpb24gb24gRFQgZm9yIHRoZXJtYWwgc2Vuc29yIGRyaXZlcg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBEYXZpZCBIZXJuYW5kZXogU2FuY2hleiA8ZGF2aWQuaGVybmFuZGV6c2FuY2hl
ekBzdC5jb20+DQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy5k
dHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJtcDE1N2MuZHRzaQ0KaW5kZXggNjYxYmU5NC4u
ZTkwYjlmNiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kN
CisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kNCkBAIC04NCw2ICs4NCwz
MSBAQA0KIAkJfTsNCiAJfTsNCg0KKwl0aGVybWFsLXpvbmVzIHsNCisJCWNwdV90aGVybWFsOiBj
cHUtdGhlcm1hbCB7DQorCQkJcG9sbGluZy1kZWxheS1wYXNzaXZlID0gPDA+Ow0KKwkJCXBvbGxp
bmctZGVsYXkgPSA8MD47DQorCQkJdGhlcm1hbC1zZW5zb3JzID0gPCZkdHM+Ow0KKw0KKwkJCXRy
aXBzIHsNCisJCQkJY3B1X2FsZXJ0MTogY3B1LWFsZXJ0MSB7DQorCQkJCQl0ZW1wZXJhdHVyZSA9
IDw4NTAwMD47DQorCQkJCQloeXN0ZXJlc2lzID0gPDA+Ow0KKwkJCQkJdHlwZSA9ICJwYXNzaXZl
IjsNCisJCQkJfTsNCisNCisJCQkJY3B1LWNyaXQgew0KKwkJCQkJdGVtcGVyYXR1cmUgPSA8MTIw
MDAwPjsNCisJCQkJCWh5c3RlcmVzaXMgPSA8MD47DQorCQkJCQl0eXBlID0gImNyaXRpY2FsIjsN
CisJCQkJfTsNCisJCQl9Ow0KKw0KKwkJCWNvb2xpbmctbWFwcyB7DQorCQkJfTsNCisJCX07DQor
CX07DQorDQogCXNvYyB7DQogCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KIAkJI2FkZHJl
c3MtY2VsbHMgPSA8MT47DQpAQCAtOTA4LDYgKzkzMywxNiBAQA0KIAkJCXN0YXR1cyA9ICJkaXNh
YmxlZCI7DQogCQl9Ow0KDQorCQlkdHM6IHRoZXJtYWxANTAwMjgwMDAgew0KKwkJCWNvbXBhdGli
bGUgPSAic3Qsc3RtMzItdGhlcm1hbCI7DQorCQkJcmVnID0gPDB4NTAwMjgwMDAgMHgxMDA+Ow0K
KwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxNDcgSVJRX1RZUEVfTEVWRUxfSElHSD47DQorCQkJ
Y2xvY2tzID0gPCZyY2MgVE1QU0VOUz47DQorCQkJY2xvY2stbmFtZXMgPSAicGNsayI7DQorCQkJ
I3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDA+Ow0KKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQor
CQl9Ow0KKw0KIAkJY3J5cDE6IGNyeXBANTQwMDEwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAic3Qs
c3RtMzJtcDEtY3J5cCI7DQogCQkJcmVnID0gPDB4NTQwMDEwMDAgMHg0MDA+Ow0KLS0NCjIuNy40
DQo=
