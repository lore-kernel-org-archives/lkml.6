Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A596C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E3E20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E3E20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeJERHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:07:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31467 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727535AbeJERHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:07:19 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w95A4KPP013928;
        Fri, 5 Oct 2018 12:08:46 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mv4mjjp0a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Oct 2018 12:08:46 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0F60631;
        Fri,  5 Oct 2018 10:08:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CF4042759;
        Fri,  5 Oct 2018 10:08:45 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Oct
 2018 12:08:45 +0200
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Fri, 5 Oct 2018 12:08:45 +0200
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
Subject: [PATCH 1/3] dt-bindings: stm32-thermal: add binding documentation
Thread-Topic: [PATCH 1/3] dt-bindings: stm32-thermal: add binding
 documentation
Thread-Index: AQHUXJNmDlW1JR5qKkC57EPjreM94w==
Date:   Fri, 5 Oct 2018 10:08:45 +0000
Message-ID: <1538734081-26585-2-git-send-email-david.hernandezsanchez@st.com>
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
Content-ID: <E487A1F7C65E5F43AA7A6227DA3D91A0@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHRoZXJtYWwgYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciBTVE0zMiBEVFMgc2Vuc29yDQoN
ClNpZ25lZC1vZmYtYnk6IERhdmlkIEhlcm5hbmRleiBTYW5jaGV6IDxkYXZpZC5oZXJuYW5kZXpz
YW5jaGV6QHN0LmNvbT4NCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy90aGVybWFsL3N0bTMyLXRoZXJtYWwudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3RoZXJtYWwvc3RtMzItdGhlcm1hbC50eHQNCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQppbmRleCAwMDAwMDAwLi44YzBkNWE0DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC9zdG0zMi10aGVybWFsLnR4dA0KQEAg
LTAsMCArMSw2MSBAQA0KK0JpbmRpbmcgZm9yIFRoZXJtYWwgU2Vuc29yIGZvciBTVE1pY3JvZWxl
Y3Ryb25pY3MgU1RNMzIgc2VyaWVzIG9mIFNvQ3MuDQorDQorT24gU1RNMzIgU29DcywgdGhlIERp
Z2l0YWwgVGVtcGVyYXR1cmUgU2Vuc29yIChEVFMpIGlzIGluIGNoYXJnZSBvZiBtYW5hZ2luZyBh
bg0KK2FuYWxvZyBibG9jayB3aGljaCBkZWxpdmVycyBhIGZyZXF1ZW5jeSBkZXBlbmRpbmcgb24g
dGhlIGludGVybmFsIFNvQydzDQordGVtcGVyYXR1cmUuIEJ5IHVzaW5nIGEgcmVmZXJlbmNlIGZy
ZXF1ZW5jeSwgRFRTIGlzIGFibGUgdG8gcHJvdmlkZSBhIHNhbXBsZQ0KK251bWJlciB3aGljaCBj
YW4gYmUgdHJhbnNsYXRlZCBpbnRvIGEgdGVtcGVyYXR1cmUgYnkgdGhlIHVzZXIuDQorDQorRFRT
IHByb3ZpZGVzIGludGVycnVwdCBub3RpZmljYXRpb24gbWVjaGFuaXNtIGJ5IHRocmVzaG9sZC4g
VGhpcyBtZWNoYW5pc20NCitvZmZlcnMgdHdvIHRlbXBlcmF0dXJlIHRyaXAgcG9pbnRzOiBwYXNz
aXZlIGFuZCBjcml0aWNhbC4gVGhlIGZpcnN0IGlzIGludGVuZGVkDQorZm9yIHBhc3NpdmUgY29v
bGluZyBub3RpZmljYXRpb24gd2hpbGUgdGhlIHNlY29uZCBpcyB1c2VkIGZvciBvdmVyLXRlbXBl
cmF0dXJlDQorcmVzZXQuDQorDQorUmVxdWlyZWQgcGFyYW1ldGVyczoNCistLS0tLS0tLS0tLS0t
LS0tLS0tDQorDQorY29tcGF0aWJsZTogCVNob3VsZCBiZSAic3Qsc3RtMzItdGhlcm1hbCINCity
ZWc6IAkJVGhpcyBzaG91bGQgYmUgdGhlIHBoeXNpY2FsIGJhc2UgYWRkcmVzcyBhbmQgbGVuZ3Ro
IG9mIHRoZQ0KKwkJc2Vuc29yJ3MgcmVnaXN0ZXJzLg0KK2Nsb2NrczogCVBoYW5kbGUgb2YgdGhl
IGNsb2NrIHVzZWQgYnkgdGhlIHRoZXJtYWwgc2Vuc29yLg0KKwkJICBTZWU6IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9jbG9jay1iaW5kaW5ncy50eHQNCitjbG9jay1u
YW1lczogCVNob3VsZCBiZSAicGNsayIgZm9yIHJlZ2lzdGVyIGFjY2VzcyBjbG9jayBhbmQgcmVm
ZXJlbmNlIGNsb2NrLg0KKwkJICBTZWU6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9yZXNvdXJjZS1uYW1lcy50eHQNCisjdGhlcm1hbC1zZW5zb3ItY2VsbHM6IFNob3VsZCBiZSAw
LiBTZWUgLi90aGVybWFsLnR4dCBmb3IgYSBkZXNjcmlwdGlvbi4NCitpbnRlcnJ1cHRzOglTdGFu
ZGFyZCB3YXkgdG8gZGVmaW5lIGludGVycnVwdCBudW1iZXIuDQorDQorRXhhbXBsZToNCisNCisJ
dGhlcm1hbC16b25lcyB7DQorCQljcHVfdGhlcm1hbDogY3B1LXRoZXJtYWwgew0KKwkJCXBvbGxp
bmctZGVsYXktcGFzc2l2ZSA9IDwwPjsNCisJCQlwb2xsaW5nLWRlbGF5ID0gPDA+Ow0KKw0KKwkJ
CXRoZXJtYWwtc2Vuc29ycyA9IDwmdGhlcm1hbD47DQorDQorCQkJdHJpcHMgew0KKwkJCQljcHVf
YWxlcnQxOiBjcHUtYWxlcnQxIHsNCisJCQkJCXRlbXBlcmF0dXJlID0gPDg1MDAwPjsNCisJCQkJ
CWh5c3RlcmVzaXMgPSA8MD47DQorCQkJCQl0eXBlID0gInBhc3NpdmUiOw0KKwkJCQl9Ow0KKw0K
KwkJCQljcHUtY3JpdDogY3B1LWNyaXQgew0KKwkJCQkJdGVtcGVyYXR1cmUgPSA8MTIwMDAwPjsN
CisJCQkJCWh5c3RlcmVzaXMgPSA8MD47DQorCQkJCQl0eXBlID0gImNyaXRpY2FsIjsNCisJCQkJ
fTsNCisJCQl9Ow0KKw0KKwkJCWNvb2xpbmctbWFwcyB7DQorCQkJfTsNCisJCX07DQorCX07DQor
DQorCXRoZXJtYWw6IHRoZXJtYWxANTAwMjgwMDAgew0KKwkJY29tcGF0aWJsZSA9ICJzdCxzdG0z
Mi10aGVybWFsIjsNCisJCXJlZyA9IDwweDUwMDI4MDAwIDB4MTAwPjsNCisJCWNsb2NrcyA9IDwm
cmNjIFRNUFNFTlM+Ow0KKwkJY2xvY2stbmFtZXMgPSAicGNsayI7DQorCQkjdGhlcm1hbC1zZW5z
b3ItY2VsbHMgPSA8MD47DQorCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTQ3IElSUV9UWVBFX0xF
VkVMX0hJR0g+Ow0KKwl9Ow0KLS0NCjIuNy40DQo=
