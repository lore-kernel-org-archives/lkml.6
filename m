Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24860C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF702081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF702081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeLDPZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:25:26 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51914 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726152AbeLDPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:25:25 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB4FHb4L030071;
        Tue, 4 Dec 2018 16:24:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2p53maygdw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Dec 2018 16:24:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 57E3431;
        Tue,  4 Dec 2018 15:24:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB5F95219;
        Tue,  4 Dec 2018 15:24:56 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 4 Dec
 2018 16:24:56 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Tue, 4 Dec 2018 16:24:56 +0100
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH v7 0/7] Introduce STPMIC1 PMIC Driver
Thread-Topic: [PATCH v7 0/7] Introduce STPMIC1 PMIC Driver
Thread-Index: AQHUiJLeeq7QfrCAGEO3Ka1UbW9pkA==
Date:   Tue, 4 Dec 2018 15:24:56 +0000
Message-ID: <5C069C47.6080305@st.com>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
 <20181203071145.GA26661@dell>
In-Reply-To: <20181203071145.GA26661@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8941E439D67E03489AE4B2FE7009C7A9@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlLA0KDQpMZSAxMi8wMy8yMDE4IDA4OjExIEFNLCBMZWUgSm9uZXMgYSDDqWNyaXQgOg0K
PiBPbiBGcmksIDMwIE5vdiAyMDE4LCBQYXNjYWwgUEFJTExFVC1MTUUgd3JvdGU6DQo+DQo+PiBU
aGUgZ29hbCBvZiB0aGlzIHBhdGNoLXNldCBpcyB0byBwcm9wb3NlIGEgZHJpdmVyIGZvciB0aGUg
U1RQTUlDMSBQTUlDIGZyb20NCj4+IFNUTWljcm9lbGVjdHJvbmljcy4NCj4+IFRoZSBTVFBNSUMx
IHJlZ3VsYXRvcnMgc3VwcGx5IHBvd2VyIHRvIGFuIGFwcGxpY2F0aW9uIHByb2Nlc3NvciBhcyB3
ZWxsIGFzDQo+PiB0byBleHRlcm5hbCBzeXN0ZW0gcGVyaXBoZXJhbHMgc3VjaCBhcyBERFIsIEZs
YXNoIG1lbW9yaWVzIGFuZCBzeXN0ZW0NCj4+IGRldmljZXMuIEl0IGFsc28gZmVhdHVyZXMgb25r
ZXkgYnV0dG9uIGlucHV0IGFuZCBhbiBoYXJkd2FyZSB3YXRjaGRvZy4NCj4+IFRoZSBTVFBNSUMx
IGlzIGNvbnRyb2xsZWQgdmlhIEkyQy4NCj4+DQo+PiBNYWluIGRyaXZlciBpcyBkcml2ZXJzL21m
ZC9zdHBtaWMxIHRoYXQgaGFuZGxlIEkyQyByZWdtYXAgY29uZmlndXJhdGlvbiBhbmQNCj4+IGly
cWNoaXAuIHN0cG1pYzFfcmVndWxhdG9yLCBzdHBtaWMxX29ua2V5IGFuZCBzdHBtaWMxX3dkdCBu
ZWVkIHN0cG1pYzEgbWZkDQo+PiBhcyBwYXJlbnQuDQo+Pg0KPj4gU1RQTUlDMSBNRkQgYW5kIHJl
Z3VsYXRvciBkcml2ZXJzIG1heWJlIG1hbmRhdG9yeSBhdCBib290IHRpbWUuDQo+Pg0KPj4gUGFz
Y2FsIFBhaWxsZXQgKDcpOg0KPj4gY2hhbmdlcyBpbiB2NzoNCj4+ICogcmViYXNlIG9uIHJlZ3Vs
L2Zvci1uZXh0DQo+Pg0KPj4gICAgZHQtYmluZGluZ3M6IG1mZDogZG9jdW1lbnQgc3RwbWljMQ0K
Pj4gICAgbWZkOiBzdHBtaWMxOiBhZGQgc3RwbWljMSBkcml2ZXINCj4+ICAgIGR0LWJpbmRpbmdz
OiBpbnB1dDogZG9jdW1lbnQgc3RwbWljMSBwbWljIG9ua2V5DQo+PiAgICBpbnB1dDogc3RwbWlj
MTogYWRkIHN0cG1pYzEgb25rZXkgZHJpdmVyDQo+PiAgICBkdC1iaW5kaW5nczogd2F0Y2hkb2c6
IGRvY3VtZW50IHN0cG1pYzEgcG1pYyB3YXRjaGRvZw0KPj4gICAgd2F0Y2hkb2c6IHN0cG1pYzE6
IGFkZCBzdHBtaWMxIHdhdGNoZG9nIGRyaXZlcg0KPj4gICAgcmVndWxhdG9yOiBzdHBtaWMxOiBm
aXggcmVndWxhdG9yX2xvY2sgdXNhZ2UNCj4+DQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lucHV0L3N0LHN0cG1pYzEtb25rZXkudHh0IHwgIDI4ICsrKw0KPj4gICAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZmQvc3Qsc3RwbWljMS50eHQgICAgICAgICB8ICA2MSArKysrKysNCj4+ICAg
Li4uL2JpbmRpbmdzL3dhdGNoZG9nL3N0LHN0cG1pYzEtd2R0LnR4dCAgICAgICAgICAgfCAgMTEg
KysNCj4+ICAgZHJpdmVycy9pbnB1dC9taXNjL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMTEgKysNCj4+ICAgZHJpdmVycy9pbnB1dC9taXNjL01ha2VmaWxlICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDIgKw0KPj4gICBkcml2ZXJzL2lucHV0L21pc2Mvc3RwbWljMV9vbmtl
eS5jICAgICAgICAgICAgICAgICB8IDE5OCArKysrKysrKysrKysrKysrKysrDQo+PiAgIGRyaXZl
cnMvbWZkL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE2ICsrDQo+
PiAgIGRyaXZlcnMvbWZkL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAxICsNCj4+ICAgZHJpdmVycy9tZmQvc3RwbWljMS5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAyMTMgKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGRyaXZlcnMvcmVndWxhdG9y
L3N0cG1pYzFfcmVndWxhdG9yLmMgICAgICAgICAgICAgIHwgICAyICstDQo+IElzIGl0IGp1c3Qg
TWFyayB5b3UncmUgd2FpdGluZyBvbiBub3c/DQpJdCBpcyBvayBub3csIE1hcmsgaGFzIGFwcGxp
ZWQgdGhlIHBhdGNoLg0KRXZyZXkgdGhpbmcgaGFzIGJlZW4gYWNrZWQgbm93LiBXaGF0IGlzIHRo
ZSBuZXggc3RlcCA/DQoNCj4+ICAgZHJpdmVycy93YXRjaGRvZy9LY29uZmlnICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMTIgKysNCj4+ICAgZHJpdmVycy93YXRjaGRvZy9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPj4gICBkcml2ZXJzL3dhdGNoZG9nL3N0
cG1pYzFfd2R0LmMgICAgICAgICAgICAgICAgICAgICB8IDEzOSArKysrKysrKysrKysrKw0KPj4g
ICBpbmNsdWRlL2R0LWJpbmRpbmdzL21mZC9zdCxzdHBtaWMxLmggICAgICAgICAgICAgICB8ICA1
MCArKysrKw0KPj4gICBpbmNsdWRlL2xpbnV4L21mZC9zdHBtaWMxLmggICAgICAgICAgICAgICAg
ICAgICAgICB8IDIxMiArKysrKysrKysrKysrKysrKysrKw0KPj4gICAxNSBmaWxlcyBjaGFuZ2Vk
LCA5NTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L3N0LHN0cG1pYzEtb25r
ZXkudHh0DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWZkL3N0LHN0cG1pYzEudHh0DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvc3Qsc3RwbWljMS13ZHQudHh0
DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lucHV0L21pc2Mvc3RwbWljMV9vbmtl
eS5jDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21mZC9zdHBtaWMxLmMNCj4+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvd2F0Y2hkb2cvc3RwbWljMV93ZHQuYw0KPj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9tZmQvc3Qsc3RwbWljMS5oDQo+
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L21mZC9zdHBtaWMxLmgNCj4+DQo=
