Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0581C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9832720892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9832720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbeLFNYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:24:05 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47024 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727704AbeLFNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:24:04 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB6DL1TU022355;
        Thu, 6 Dec 2018 14:23:33 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2p3wt6vg1q-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 06 Dec 2018 14:23:33 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CD2CD3F;
        Thu,  6 Dec 2018 13:23:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 73EC72AAC;
        Thu,  6 Dec 2018 13:23:32 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Dec
 2018 14:23:32 +0100
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Thu, 6 Dec 2018 14:23:32 +0100
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
Subject: [PATCH] thermal: stm32: Fix stm_thermal_read_factory_settings
Thread-Topic: [PATCH] thermal: stm32: Fix stm_thermal_read_factory_settings
Thread-Index: AQHUjWbiMRW0Xlrdek2MWEX1owVk4w==
Date:   Thu, 6 Dec 2018 13:23:32 +0000
Message-ID: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <902B145001845D4A86B32CFF0A0C3EEE@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-06_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkaW5nIGJyYWNrZXRzIGFsbG93cyB0byBtdWx0aXBseSB0aGUgcmVnaXN0ZXIgdmFsdWUsDQpt
YXNrZWQgYnkgVFMxX1JBTVBfQ09FRkZfTUFTSywgYnkgYW4gQURKVVNUIHZhbHVlDQpwcm9wZXJs
eSBhbmQgbm90IHRvIG11bHRpcGx5IEFESlVTVCBieSByZWdpc3RlciB2YWx1ZSBhbmQNCnRoZW4g
bWFzayB0aGUgd2hvbGUuDQoNClNpZ25lZC1vZmYtYnk6IERhdmlkIEhlcm5hbmRleiBTYW5jaGV6
IDxkYXZpZC5oZXJuYW5kZXpzYW5jaGV6QHN0LmNvbT4NCkZpeGVzOiAxZDY5MzE1NSAoInRoZXJt
YWw6IGFkZCBzdG0zMiB0aGVybWFsIGRyaXZlciIpDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Ro
ZXJtYWwvc3Qvc3RtX3RoZXJtYWwuYyBiL2RyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhlcm1hbC5j
DQppbmRleCBkYWExMjU3Li5iYmQ3M2M1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy90aGVybWFsL3N0
L3N0bV90aGVybWFsLmMNCisrKyBiL2RyaXZlcnMvdGhlcm1hbC9zdC9zdG1fdGhlcm1hbC5jDQpA
QCAtMjQxLDggKzI0MSw4IEBAIHN0YXRpYyBpbnQgc3RtX3RoZXJtYWxfcmVhZF9mYWN0b3J5X3Nl
dHRpbmdzKHN0cnVjdCBzdG1fdGhlcm1hbF9zZW5zb3IgKnNlbnNvcikNCiAJCXNlbnNvci0+dDAg
PSBUUzFfVDBfVkFMMTsNCiANCiAJLyogUmV0cmlldmUgZm10MCBhbmQgcHV0IGl0IG9uIEh6ICov
DQotCXNlbnNvci0+Zm10MCA9IEFESlVTVCAqIHJlYWRsX3JlbGF4ZWQoc2Vuc29yLT5iYXNlICsg
RFRTX1QwVkFMUjFfT0ZGU0VUKQ0KLQkJCQkJICAgICAgJiBUUzFfRk1UMF9NQVNLOw0KKwlzZW5z
b3ItPmZtdDAgPSBBREpVU1QgKiAocmVhZGxfcmVsYXhlZChzZW5zb3ItPmJhc2UgKw0KKwkJCQkg
RFRTX1QwVkFMUjFfT0ZGU0VUKSAmIFRTMV9GTVQwX01BU0spOw0KIA0KIAkvKiBSZXRyaWV2ZSBy
YW1wIGNvZWZmaWNpZW50ICovDQogCXNlbnNvci0+cmFtcF9jb2VmZiA9IHJlYWRsX3JlbGF4ZWQo
c2Vuc29yLT5iYXNlICsgRFRTX1JBTVBWQUxSX09GRlNFVCkgJg0KLS0gDQoyLjcuNA0K
