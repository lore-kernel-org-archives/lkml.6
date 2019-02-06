Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCB3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AC22081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfBFIrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:47:10 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59256 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbfBFIrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:47:10 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x168kQWh016804;
        Wed, 6 Feb 2019 09:46:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qfv9ng0sf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 06 Feb 2019 09:46:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 87066370;
        Wed,  6 Feb 2019 08:46:58 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E05516B8;
        Wed,  6 Feb 2019 08:46:58 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 Feb
 2019 09:46:58 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Wed, 6 Feb 2019 09:46:58 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     wen yang <yellowriver2010@hotmail.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: dwc3: add missing of_node_put()
Thread-Topic: [PATCH] USB: dwc3: add missing of_node_put()
Thread-Index: AQHUu3PhlWt5p92k+kmajluToxxENKXSaV2A
Date:   Wed, 6 Feb 2019 08:46:57 +0000
Message-ID: <d969fab6-7658-c88a-ee01-a7fd75b8e9c0@st.com>
References: <HK0PR02MB363451C20715075F224345CEB26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
In-Reply-To: <HK0PR02MB363451C20715075F224345CEB26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <93E4B6A8CD0D964A802A8E1B5747D8ED@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VuDQoNCk9uIDIvMy8xOSA0OjUyIEFNLCB3ZW4geWFuZyB3cm90ZToNCj4gVGhlIGNhbGwg
dG8gb2ZfZmluZF9ub2RlX2J5X25hbWUgcmV0dXJucyBhIG5vZGUgcG9pbnRlciB3aXRoIHJlZmNv
dW50DQo+IGluY3JlbWVudGVkIHRodXMgaXQgbXVzdCBiZSBleHBsaWNpdGx5IGRlY3JlbWVudGVk
IGhlcmUgYWZ0ZXIgdGhlIGxhc3QNCj4gdXNhZ2UuDQo+IFRoZSBvZl9maW5kX2RldmljZV9ieV9u
b2RlKCkgdGFrZXMgYSByZWZlcmVuY2UgdG8gdGhlIHVuZGVybHlpbmcgZGV2aWNlDQo+IHN0cnVj
dHVyZSwgd2UgYWxzbyBzaG91bGQgcmVsZWFzZSB0aGF0IHJlZmVyZW5jZS4NCj4gVGhpcyBwYXRj
aCBmaXhlcyB0aG9zZSAyIGlzc3Vlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdlbiBZYW5nIDx5
ZWxsb3dyaXZlcjIwMTBAaG90bWFpbC5jb20+DQo+IENjOiBQYXRyaWNlIENob3RhcmQgPHBhdHJp
Y2UuY2hvdGFyZEBzdC5jb20+DQo+IENjOiBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5vcmc+
DQo+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBsaW51eC11
c2JAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXN0LmMgfCAxMCArKysrKysrLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1zdC5jIGIvZHJpdmVycy91c2IvZHdjMy9k
d2MzLXN0LmMNCj4gaW5kZXggMTYwODEzOC4uZmRkOTBkMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMy9kd2MzLXN0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXN0LmMN
Cj4gQEAgLTI2MiwxNyArMjYyLDE4IEBAIHN0YXRpYyBpbnQgc3RfZHdjM19wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXJldCA9IG9mX3BsYXRmb3JtX3BvcHVsYXRlKG5v
ZGUsIE5VTEwsIE5VTEwsIGRldik7DQo+ICAJaWYgKHJldCkgew0KPiAgCQlkZXZfZXJyKGRldiwg
ImZhaWxlZCB0byBhZGQgZHdjMyBjb3JlXG4iKTsNCj4gLQkJZ290byB1bmRvX3NvZnRyZXNldDsN
Cj4gKwkJZ290byBwdXRfbm9kZTsNCj4gIAl9DQo+ICANCj4gIAljaGlsZF9wZGV2ID0gb2ZfZmlu
ZF9kZXZpY2VfYnlfbm9kZShjaGlsZCk7DQo+ICAJaWYgKCFjaGlsZF9wZGV2KSB7DQo+ICAJCWRl
dl9lcnIoZGV2LCAiZmFpbGVkIHRvIGZpbmQgZHdjMyBjb3JlIGRldmljZVxuIik7DQo+ICAJCXJl
dCA9IC1FTk9ERVY7DQo+IC0JCWdvdG8gdW5kb19zb2Z0cmVzZXQ7DQo+ICsJCWdvdG8gcHV0X25v
ZGU7DQo+ICAJfQ0KPiAgDQo+ICAJZHdjM19kYXRhLT5kcl9tb2RlID0gdXNiX2dldF9kcl9tb2Rl
KCZjaGlsZF9wZGV2LT5kZXYpOw0KPiArCXB1dF9kZXZpY2UoJmNoaWxkX3BkZXYtPmRldik7DQo+
ICANCj4gIAkvKg0KPiAgCSAqIENvbmZpZ3VyZSB0aGUgVVNCIHBvcnQgYXMgZGV2aWNlIG9yIGhv
c3QgYWNjb3JkaW5nIHRvIHRoZSBzdGF0aWMNCj4gQEAgLTI4MywxNSArMjg0LDE4IEBAIHN0YXRp
YyBpbnQgc3RfZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXJl
dCA9IHN0X2R3YzNfZHJkX2luaXQoZHdjM19kYXRhKTsNCj4gIAlpZiAocmV0KSB7DQo+ICAJCWRl
dl9lcnIoZGV2LCAiZHJkIGluaXRpYWxpc2F0aW9uIGZhaWxlZFxuIik7DQo+IC0JCWdvdG8gdW5k
b19zb2Z0cmVzZXQ7DQo+ICsJCWdvdG8gcHV0X25vZGU7DQo+ICAJfQ0KPiAgDQo+ICAJLyogU1Qg
Z2x1ZSBsb2dpYyBpbml0ICovDQo+ICAJc3RfZHdjM19pbml0KGR3YzNfZGF0YSk7DQo+ICANCj4g
IAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBkd2MzX2RhdGEpOw0KPiArCW9mX25vZGVfcHV0
KGNoaWxkKTsNCj4gIAlyZXR1cm4gMDsNCj4gIA0KPiArcHV0X25vZGU6DQo+ICsJb2Zfbm9kZV9w
dXQoY2hpbGQpOw0KPiAgdW5kb19zb2Z0cmVzZXQ6DQo+ICAJcmVzZXRfY29udHJvbF9hc3NlcnQo
ZHdjM19kYXRhLT5yc3RjX3JzdCk7DQo+ICB1bmRvX3Bvd2VyZG93bjoNCj4gDQoNClJldmlld2Vk
LWJ5OiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQoNClRoYW5rcw==
