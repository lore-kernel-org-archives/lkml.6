Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBE1C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98E720875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98E720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeJERHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:07:21 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58114 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727540AbeJERHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:07:20 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w95A4HjD013788;
        Fri, 5 Oct 2018 12:08:46 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mv4mjjp09-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Oct 2018 12:08:46 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 88EF238;
        Fri,  5 Oct 2018 10:08:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30A1E2758;
        Fri,  5 Oct 2018 10:08:45 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Oct
 2018 12:08:44 +0200
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Fri, 5 Oct 2018 12:08:44 +0200
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
Subject: [PATCH 0/3] Introduce STM32 thermal driver
Thread-Topic: [PATCH 0/3] Introduce STM32 thermal driver
Thread-Index: AQHUXJNmC/U7gP1+c02jn8j+ynqa9Q==
Date:   Fri, 5 Oct 2018 10:08:44 +0000
Message-ID: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F86A427D7D4744EB8EA4FD180BDA474@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBTVE1pY3JvZWxlY3Ryb25pY3MgRGlnaXRhbCBU
ZW1wZXJhdHVyZQ0KU2Vuc29yIChEVFMpLCB1c2VkIG9uIHNvbWUgU1RNMzIgU29Dcy4NCg0KRHJp
dmVyIGlzIGJhc2VkIG9uIHRoZXJtYWwgc3lzZnMgYW5kIGl0IGhhcyBiZWVuIHRlc3RlZCBPSyBv
biBhIDQuMTktcmM1IGxpbnV4DQpyZWxlYXNlLg0KDQpQbGVhc2UgZmVlbCBmcmVlIHRvIGNvbnRh
Y3QgbWUgYmFjayBmb3IgZnVydGhlciBpbmZvcm1hdGlvbg0KYW5kIHRvIGRpc2N1c3MgYWJvdXQg
dGhpcyBpbXBsZW1lbnRhdGlvbi4NCg0KQnIsDQpEYXZpZCBIRVJOQU5ERVogU0FOQ0hFWg0KDQpE
YXZpZCBIZXJuYW5kZXogU2FuY2hleiAoMyk6DQogIGR0LWJpbmRpbmdzOiBzdG0zMi10aGVybWFs
OiBhZGQgYmluZGluZyBkb2N1bWVudGF0aW9uDQogIHRoZXJtYWw6IGFkZCBzdG0zMiB0aGVybWFs
IGRyaXZlcg0KICBBUk06IGR0czogc3RtMzI6IGFkZCB0aGVybWFsIHNlbnNvciBzdXBwb3J0IG9u
IFNUTTMyTVAxNTdjDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3N0bTMyLXRo
ZXJtYWwudHh0ICB8ICA2MSArKw0KIGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLmR0c2kg
ICAgICAgICAgICAgICAgIHwgIDM1ICsNCiBkcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KIGRyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQogZHJpdmVycy90aGVybWFsL3N0L0tj
b25maWcgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTQgKw0KIGRyaXZlcnMvdGhlcm1hbC9z
dC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL3RoZXJt
YWwvc3Qvc3RtX3RoZXJtYWwuYyAgICAgICAgICAgICAgICAgICB8IDc2MCArKysrKysrKysrKysr
KysrKysrKysNCiA3IGZpbGVzIGNoYW5nZWQsIDg3MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdGhlcm1hbC9zdG0zMi10aGVybWFsLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L3RoZXJtYWwvc3Qvc3RtX3RoZXJtYWwuYw0KDQotLQ0KMi43LjQNCg==
