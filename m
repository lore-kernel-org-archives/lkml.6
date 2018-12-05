Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A61C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF30B206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF30B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeLEPhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:37:17 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32665 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727240AbeLEPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:37:16 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB5Fajqd018899;
        Wed, 5 Dec 2018 16:36:45 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2p3uhmy62g-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 05 Dec 2018 16:36:45 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 890F231;
        Wed,  5 Dec 2018 15:36:44 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2F38B2C96;
        Wed,  5 Dec 2018 15:36:44 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 5 Dec
 2018 16:36:43 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Wed, 5 Dec 2018 16:36:43 +0100
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
Date:   Wed, 5 Dec 2018 15:36:43 +0000
Message-ID: <5C07F08B.2010701@st.com>
References: <1543571742-17995-1-git-send-email-p.paillet@st.com>
 <20181203071145.GA26661@dell> <5C069C47.6080305@st.com>
 <20181205093604.GZ26661@dell>
In-Reply-To: <20181205093604.GZ26661@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <817148D5BE30EA4E85D250CA2CFDBDB4@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpwYXNjYWwgcGFpbGxldCAocC5wYWlsbGV0QHN0LmNvbSkgTGUgTWFucyAvIEZyYW5jZQ0KTWlj
cm9jb250cm9sbGVycyBhbmQgRGlnaXRhbCBJQ3MgR3JvdXAgfCBBcHBsaWNhdGlvbiBEZXZlbG9w
bWVudA0KVEVMOiArMzMuKDApMi40NC4wMi43NC42OSB8IFRJTkE6IDE2NiA3NDY5DQoNCkxlIDEy
LzA1LzIwMTggMTA6MzYgQU0sIExlZSBKb25lcyBhIMOpY3JpdCA6DQo+IE9uIFR1ZSwgMDQgRGVj
IDIwMTgsIFBhc2NhbCBQQUlMTEVULUxNRSB3cm90ZToNCj4+IExlIDEyLzAzLzIwMTggMDg6MTEg
QU0sIExlZSBKb25lcyBhIMOpY3JpdCA6DQo+Pj4gT24gRnJpLCAzMCBOb3YgMjAxOCwgUGFzY2Fs
IFBBSUxMRVQtTE1FIHdyb3RlOg0KPj4+DQo+Pj4+IFRoZSBnb2FsIG9mIHRoaXMgcGF0Y2gtc2V0
IGlzIHRvIHByb3Bvc2UgYSBkcml2ZXIgZm9yIHRoZSBTVFBNSUMxIFBNSUMgZnJvbQ0KPj4+PiBT
VE1pY3JvZWxlY3Ryb25pY3MuDQo+Pj4+IFRoZSBTVFBNSUMxIHJlZ3VsYXRvcnMgc3VwcGx5IHBv
d2VyIHRvIGFuIGFwcGxpY2F0aW9uIHByb2Nlc3NvciBhcyB3ZWxsIGFzDQo+Pj4+IHRvIGV4dGVy
bmFsIHN5c3RlbSBwZXJpcGhlcmFscyBzdWNoIGFzIEREUiwgRmxhc2ggbWVtb3JpZXMgYW5kIHN5
c3RlbQ0KPj4+PiBkZXZpY2VzLiBJdCBhbHNvIGZlYXR1cmVzIG9ua2V5IGJ1dHRvbiBpbnB1dCBh
bmQgYW4gaGFyZHdhcmUgd2F0Y2hkb2cuDQo+Pj4+IFRoZSBTVFBNSUMxIGlzIGNvbnRyb2xsZWQg
dmlhIEkyQy4NCj4+Pj4NCj4+Pj4gTWFpbiBkcml2ZXIgaXMgZHJpdmVycy9tZmQvc3RwbWljMSB0
aGF0IGhhbmRsZSBJMkMgcmVnbWFwIGNvbmZpZ3VyYXRpb24gYW5kDQo+Pj4+IGlycWNoaXAuIHN0
cG1pYzFfcmVndWxhdG9yLCBzdHBtaWMxX29ua2V5IGFuZCBzdHBtaWMxX3dkdCBuZWVkIHN0cG1p
YzEgbWZkDQo+Pj4+IGFzIHBhcmVudC4NCj4+Pj4NCj4+Pj4gU1RQTUlDMSBNRkQgYW5kIHJlZ3Vs
YXRvciBkcml2ZXJzIG1heWJlIG1hbmRhdG9yeSBhdCBib290IHRpbWUuDQo+Pj4+DQo+Pj4+IFBh
c2NhbCBQYWlsbGV0ICg3KToNCj4+Pj4gY2hhbmdlcyBpbiB2NzoNCj4+Pj4gKiByZWJhc2Ugb24g
cmVndWwvZm9yLW5leHQNCj4+Pj4NCj4+Pj4gICAgIGR0LWJpbmRpbmdzOiBtZmQ6IGRvY3VtZW50
IHN0cG1pYzENCj4+Pj4gICAgIG1mZDogc3RwbWljMTogYWRkIHN0cG1pYzEgZHJpdmVyDQo+Pj4+
ICAgICBkdC1iaW5kaW5nczogaW5wdXQ6IGRvY3VtZW50IHN0cG1pYzEgcG1pYyBvbmtleQ0KPj4+
PiAgICAgaW5wdXQ6IHN0cG1pYzE6IGFkZCBzdHBtaWMxIG9ua2V5IGRyaXZlcg0KPj4+PiAgICAg
ZHQtYmluZGluZ3M6IHdhdGNoZG9nOiBkb2N1bWVudCBzdHBtaWMxIHBtaWMgd2F0Y2hkb2cNCj4+
Pj4gICAgIHdhdGNoZG9nOiBzdHBtaWMxOiBhZGQgc3RwbWljMSB3YXRjaGRvZyBkcml2ZXINCj4+
Pj4gICAgIHJlZ3VsYXRvcjogc3RwbWljMTogZml4IHJlZ3VsYXRvcl9sb2NrIHVzYWdlDQo+Pj4+
DQo+Pj4+ICAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L3N0LHN0cG1pYzEtb25rZXku
dHh0IHwgIDI4ICsrKw0KPj4+PiAgICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvc3Qsc3Rw
bWljMS50eHQgICAgICAgICB8ICA2MSArKysrKysNCj4+Pj4gICAgLi4uL2JpbmRpbmdzL3dhdGNo
ZG9nL3N0LHN0cG1pYzEtd2R0LnR4dCAgICAgICAgICAgfCAgMTEgKysNCj4+Pj4gICAgZHJpdmVy
cy9pbnB1dC9taXNjL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTEgKysNCj4+
Pj4gICAgZHJpdmVycy9pbnB1dC9taXNjL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDIgKw0KPj4+PiAgICBkcml2ZXJzL2lucHV0L21pc2Mvc3RwbWljMV9vbmtleS5jICAgICAg
ICAgICAgICAgICB8IDE5OCArKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIGRyaXZlcnMvbWZk
L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE2ICsrDQo+Pj4+ICAg
IGRyaXZlcnMvbWZkL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAx
ICsNCj4+Pj4gICAgZHJpdmVycy9tZmQvc3RwbWljMS5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAyMTMgKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIGRyaXZlcnMvcmVndWxh
dG9yL3N0cG1pYzFfcmVndWxhdG9yLmMgICAgICAgICAgICAgIHwgICAyICstDQo+Pj4gSXMgaXQg
anVzdCBNYXJrIHlvdSdyZSB3YWl0aW5nIG9uIG5vdz8NCj4+IEl0IGlzIG9rIG5vdywgTWFyayBo
YXMgYXBwbGllZCB0aGUgcGF0Y2guDQo+PiBFdnJleSB0aGluZyBoYXMgYmVlbiBhY2tlZCBub3cu
IFdoYXQgaXMgdGhlIG5leCBzdGVwID8NCj4gTWFyayBoYXMgYXBwbGllZCBwYXRjaCA3Pw0KPg0K
PiBXaHkgZG9uJ3QgSSBzZWUgdGhhdD8gIFNob3VsZCB5b3UgaGF2ZSByZW1vdmVkIGl0IGZyb20g
dGhpcyBzZXQ/DQpIaSBMZWUsIEkgaGF2ZSByZWNlaXZlZCBhbiBlbWFpbCBmcm9tIE1hcmsgdGVs
bGlpbmcgdGhhdCB0aGUgcmVndWxhdG9yIA0KcGF0Y2ggaXMgYXBwbGllZCBvbg0KDQogIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Jyb29uaWUvcmVndWxh
dG9yLmdpdCAgDQoNCkkgY2FuIHNlZSBpdCBvbiB0aGUgYnJhbmNoIHJlZ3VsL2Zvci1uZXh0Lg0K
DQoNCnRoYW5rIHlvdSwNCnBhc2NhbA0KDQoNCj4NCg==
