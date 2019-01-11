Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BF1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F11C20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbfAKReu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:34:50 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27018 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728499AbfAKRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:34:49 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0BHQDoW010536;
        Fri, 11 Jan 2019 18:34:34 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ptybng97d-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 11 Jan 2019 18:34:34 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E119231;
        Fri, 11 Jan 2019 17:34:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9250655A4;
        Fri, 11 Jan 2019 17:34:32 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 11 Jan
 2019 18:34:32 +0100
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Fri, 11 Jan 2019 18:34:32 +0100
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/1] irqchip: stm32-exti: add domain translate function
Thread-Topic: [PATCH 1/1] irqchip: stm32-exti: add domain translate function
Thread-Index: AQHUqbXR7xrMy0xrkECi13pJpL3NPqWqJw+AgAAkTxA=
Date:   Fri, 11 Jan 2019 17:34:32 +0000
Message-ID: <fb407c82a8fc44cdb0fd4c8954c4c12d@SFHDAG7NODE2.st.com>
References: <1547215132-85612-1-git-send-email-loic.pallardy@st.com>
 <7e36a9f2-2b43-5af3-2094-198a61030687@arm.com>
In-Reply-To: <7e36a9f2-2b43-5af3-2094-198a61030687@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNClRoYW5rcyBmb3IgdGhlIHJldmlldw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IE1hcmMgWnluZ2llciA8bWFyYy56eW5naWVyQGFybS5jb20+DQo+IFNl
bnQ6IHZlbmRyZWRpIDExIGphbnZpZXIgMjAxOSAxNjo1Mg0KPiBUbzogTG9pYyBQQUxMQVJEWSA8
bG9pYy5wYWxsYXJkeUBzdC5jb20+OyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+IGphc29uQGxha2Vk
YWVtb24ubmV0OyBtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tOyBBbGV4YW5kcmUgVE9SR1VFDQo+
IDxhbGV4YW5kcmUudG9yZ3VlQHN0LmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LXN0bTMyQHN0LW1kLQ0KPiBtYWlsbWFuLnN0b3JtcmVwbHkuY29tOyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAx
LzFdIGlycWNoaXA6IHN0bTMyLWV4dGk6IGFkZCBkb21haW4gdHJhbnNsYXRlIGZ1bmN0aW9uDQo+
IA0KPiBPbiAxMS8wMS8yMDE5IDEzOjU4LCBMb2ljIFBhbGxhcmR5IHdyb3RlOg0KPiA+IERvbWFp
biB0cmFuc2xhdGUgZnVuY3Rpb24gaXMgbmVlZGVkIHRvIHJlY292ZXIgaXJxDQo+ID4gY29uZmln
dXJhdGlvbiBwYXJhbWV0ZXJzIGZyb20gRFQgbm9kZQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TG9pYyBQYWxsYXJkeSA8bG9pYy5wYWxsYXJkeUBzdC5jb20+DQo+IA0KPiBTdXJlbHkgdGhpcyBm
aXhlcyBzb21ldGhpbmcsIHJpZ2h0PyBDYW4geW91IHBsZWFzZSBhZGQgYSBGaXhlczogdGFnPw0K
WWVzIEkgd2lsbCBhZGQgdGFnIG9mIHBhdGNoIGludHJvZHVjaW5nIGhpZXJhcmNoaWNhbCBkb21h
aW4NCg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pcnFjaGlwL2lycS1zdG0zMi1leHRpLmMg
fCAxOCArKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLXN0bTMyLWV4
dGkuYyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtc3RtMzItDQo+IGV4dGkuYw0KPiA+IGluZGV4IDZl
ZGZkNGJmYTE2OS4uNzE3ODc5MDI4Y2M0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaXJxY2hp
cC9pcnEtc3RtMzItZXh0aS5jDQo+ID4gKysrIGIvZHJpdmVycy9pcnFjaGlwL2lycS1zdG0zMi1l
eHRpLmMNCj4gPiBAQCAtODE5LDkgKzgxOSwyNyBAQCBzdGF0aWMgaW50IF9faW5pdCBzdG0zMl9l
eHRpX2luaXQoY29uc3Qgc3RydWN0DQo+IHN0bTMyX2V4dGlfZHJ2X2RhdGEgKmRydl9kYXRhLA0K
PiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgc3RtMzJfZXh0
aV9oX3RyYW5zbGF0ZShzdHJ1Y3QgaXJxX2RvbWFpbiAqZCwNCj4gPiArCQkJCSAgc3RydWN0IGly
cV9md3NwZWMgKmZ3c3BlYywNCj4gPiArCQkJCSAgdW5zaWduZWQgbG9uZyAqb3V0X2h3aXJxLA0K
PiA+ICsJCQkJICB1bnNpZ25lZCBpbnQgKm91dF90eXBlKQ0KPiA+ICt7DQo+ID4gKwlpZiAoaXNf
b2Zfbm9kZShmd3NwZWMtPmZ3bm9kZSkpIHsNCj4gDQo+IElzIHRoZXJlIGFueSBjYXNlIHdoZXJl
IHRoaXMgd291bGRuJ3QgYmUgdHJ1ZT8gaS5lLiBhbiBzdG0zMiBBQ1BJIHN5c3RlbT8NCg0KWW91
J3JlIHJpZ2h0LCBubyBBQ1BJIHNvIGNoZWNrIHVzZWxlc3MNCg0KPiANCj4gPiArCQlpZiAoZndz
cGVjLT5wYXJhbV9jb3VudCAhPSAyKQ0KPiA+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+
ID4gKwkJKm91dF9od2lycSA9IGZ3c3BlYy0+cGFyYW1bMF07DQo+ID4gKwkJKm91dF90eXBlID0g
ZndzcGVjLT5wYXJhbVsxXSAmIElSUV9UWVBFX1NFTlNFX01BU0s7DQo+ID4gKwkJcmV0dXJuIDA7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIC1FSU5WQUw7DQo+ID4gK30NCj4gDQo+IEJl
Y2F1c2Ugb3RoZXJ3aXNlLCB0aGlzIGlzIGV4YWN0bHkgd2hhdCBpcnFfZG9tYWluX3hsYXRlX3R3
b2NlbGwoKSBkb2VzLg0KDQpUaGFua3MgZm9yIHBvaW50aW5nIG1lIHRoaXMgaGVscGVyLiBJbmRl
ZWQgbm8gbmVlZCB0byBkdXBsaWNhdGUgY29kZQ0KSSdsbCBzZW5kIGEgdjIgDQoNClJlZ2FyZHMs
DQpMb2ljDQo+IA0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpcnFfZG9tYWluX29w
cyBzdG0zMl9leHRpX2hfZG9tYWluX29wcyA9IHsNCj4gPiAgCS5hbGxvYwk9IHN0bTMyX2V4dGlf
aF9kb21haW5fYWxsb2MsDQo+ID4gIAkuZnJlZQk9IGlycV9kb21haW5fZnJlZV9pcnFzX2NvbW1v
biwNCj4gPiArCS50cmFuc2xhdGUgPSBzdG0zMl9leHRpX2hfdHJhbnNsYXRlLA0KPiA+ICB9Ow0K
PiA+DQo+ID4gIHN0YXRpYyBpbnQNCj4gPg0KPiANCj4gVGhhbmtzLA0KPiANCj4gCU0uDQo+IC0t
DQo+IEphenogaXMgbm90IGRlYWQuIEl0IGp1c3Qgc21lbGxzIGZ1bm55Li4uDQo=
