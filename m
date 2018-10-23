Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A2C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25B42075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="TgIQ1hFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25B42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbeJXHs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 03:48:29 -0400
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com ([104.47.33.40]:60794
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbeJXHs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 03:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRfysxup4iJ8PTxiGesa809MvHH3VKagpv7a8LMruVI=;
 b=TgIQ1hFIQRl3NsK6Obo6zj0T5EREjN/Fctfgnk7uI9oj5gZLQ77JLT0Lo0k1lpDshEbjH/oWBFKVK4N1Z5SSIPm8LT6kcb0Ieyd2gAlrzWFvrNfSZ+I1phW34HWHHhxSmp0ogZHMDuC9U10R8l2GqnRxhnbF0hnf2OZB/nVkBHY=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5640.namprd05.prod.outlook.com (20.177.186.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.13; Tue, 23 Oct 2018 23:22:48 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1273.014; Tue, 23 Oct 2018
 23:22:48 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86: Remove -pipe from KBUILD_CFLAGS
Thread-Topic: [PATCH] x86: Remove -pipe from KBUILD_CFLAGS
Thread-Index: AQHUayXF2vBP2dvUJkOrZN0DDVF6vqUteFAA
Date:   Tue, 23 Oct 2018 23:22:48 +0000
Message-ID: <E44AA2AF-D0B6-4501-B123-901A704989FE@vmware.com>
References: <20181023231125.27976-1-natechancellor@gmail.com>
In-Reply-To: <20181023231125.27976-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5640;20:VbGFZXc9eLZhvh/g4JmHxQ+94hlz5yU/LcaO6jUyF0279GkN1ezJqBvDFHGphoU8/H1evgNImf2RIdHHZpKjU9NoFy0QbVf7QPq49xYI3KqW6s7VzbMDNWxKT2jvbcjItBZh0Mt3IvHCZqcLjqsKfVqnhAs8GWT+aqaA2Quump4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 267780aa-9d4c-42a0-a494-08d6393e7259
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5640;
x-ms-traffictypediagnostic: BYAPR05MB5640:
x-microsoft-antispam-prvs: <BYAPR05MB564054F23FF481BFA7122E42D0F50@BYAPR05MB5640.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(219752817060721)(189930954265078)(262104967686372)(85827821059158)(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5640;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5640;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(26005)(2906002)(446003)(8936002)(82746002)(2616005)(316002)(5250100002)(6306002)(2900100001)(68736007)(229853002)(6486002)(6512007)(6436002)(66066001)(256004)(476003)(11346002)(81166006)(81156014)(486006)(8676002)(3846002)(39060400002)(575784001)(86362001)(6116002)(110136005)(6246003)(102836004)(105586002)(106356001)(76176011)(54906003)(36756003)(478600001)(45080400002)(25786009)(966005)(4326008)(7736002)(305945005)(97736004)(6346003)(33656002)(53936002)(71190400001)(186003)(83716004)(14454004)(53546011)(6506007)(71200400001)(5660300001)(7416002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5640;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: H9i8nTE9Z6n4qe3j+A5AmzIMsGgtjhofVypeDZoIwBZ2smWU92ERiECArldnVaRRoXhRZEe4WaK+jPzjvc0NEQR0KKnULdV++amEJbjIvEBaJc75pQqXe4pXWT34XB4U90Ei9osxBMqTwi4Q0AFlwjyQG9nJI/Bu6czThQ6Qfk5iTCXSsCzKPZcRQl0C5hlAHbkd1UUE/xhK7Ojfg18/PKeZNhMHprWUnC2EMyWnNoSKwWlC1wz92YF6b6R0iLfuVkhmSr/LEcwx2NTpiG8IBmKfG2ANs5MNqhNUgeeeNGxIwfkbittET/hHPF+/fpOam+qJj0FBaefUXr3WPKU/+rNgudLCK0NGaRp2O1DCmoc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <433FC754C85B8149A476A7A1ECA1CC8D@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267780aa-9d4c-42a0-a494-08d6393e7259
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 23:22:48.6735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmF0aGFuIENoYW5jZWxsb3IgPG5hdGVjaGFuY2VsbG9yQGdtYWlsLmNvbT4NClNlbnQ6
IE9jdG9iZXIgMjMsIDIwMTggYXQgMTE6MTE6MjUgUE0gR01UDQo+IFRvOiBUaG9tYXMgR2xlaXhu
ZXI7IEluZ28gTW9sbmFyOyBCb3Jpc2xhdiBQZXRrb3YNCj4gQ2M6IEguIFBldGVyIEFudmluOyB4
ODZAa2VybmVsLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgTmFkYXYgQW1pdDsg
S2VlcyBDb29rOyBNYXNhaGlybyBZYW1hZGE7IE5pY2sgRGVzYXVsbmllcnM7IE5hdGhhbiBDaGFu
Y2VsbG9yDQo+IFN1YmplY3Q6IFtQQVRDSF0geDg2OiBSZW1vdmUgLXBpcGUgZnJvbSBLQlVJTERf
Q0ZMQUdTDQo+IA0KPiANCj4gQ29tbWl0IDc3YjBiZjU1YmM2NyAoImtidWlsZC9NYWtlZmlsZTog
UHJlcGFyZSBmb3IgdXNpbmcgbWFjcm9zIGluDQo+IGlubGluZSBhc3NlbWJseSBjb2RlIHRvIHdv
cmsgYXJvdW5kIGFzbSgpIHJlbGF0ZWQgR0NDIGlubGluaW5nIGJ1Z3MiKQ0KPiBhZGRlZCAtV2Es
LSB0byBLQlVJTERfQ0ZMQUdTLCB3aGljaCBicmVha3MgY29tcGlsaW5nIHdpdGggQ2xhbmcgKGhh
bmdzDQo+IGluZGVmaW5pdGVseSBhdCBjb21waWxpbmcgaW5pdC9tYWluLm8pLiBUaGlzIGhhcHBl
bnMgYmVjYXVzZSB3aGlsZSBDbGFuZw0KPiBhY2NlcHRzIC1waXBlIChhbmQgaGFzIGl0IGRvY3Vt
ZW50ZWQgaW4gaXRzIGxpc3Qgb2Ygc3VwcG9ydGVkIGZsYWdzKSwgaXQNCj4gc2lsZW50bHkgaWdu
b3JlcyBpdCBhZnRlciB0aGlzIDIwMTAgY29tbWl0ICh0aGFua3MgdG8gTmljayBEZXNhdWxuaWVy
cw0KPiBmb3IgdHJhY2tpbmcgdGhpcyBkb3duKSwgbWVhbmluZyB0aGF0IGdhcyBqdXN0IGluZmlu
aXRlbHkgd2FpdHMgZm9yDQo+IHN0ZGluIGFuZCBuZXZlciByZWNlaXZlcyBpdC4NCj4gDQo+IGh0
dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGZ2l0aHViLmNvbSUyRmxsdm0tbWlycm9yJTJGY2xhbmclMkZjb21taXQlMkZjMTlhMTJk
YzNkNDQxYmVjNjJlZWQ1NWUzMTJiNzZjMTJkNmQ5MDIyJmFtcDtkYXRhPTAyJTdDMDElN0NuYW1p
dCU0MHZtd2FyZS5jb20lN0M1NjY3OGUwMDE4ODk0OTU1NjAxOTA4ZDYzOTNjZTZkMiU3Q2IzOTEz
OGNhM2NlZTRiNGFhNGQ2Y2Q4M2Q5ZGQ2MmYwJTdDMSU3QzAlN0M2MzY3NTkzMzEwNzIwNzIyMTUm
YW1wO3NkYXRhPUFqb1AlMkJlclMyNks1OFFRSU5FMFVESjAwZnR5R01hNW92bGFLdlpWaVo0dyUz
RCZhbXA7cmVzZXJ2ZWQ9MA0KPiANCj4gSW5pdGlhbGx5LCBJIGhhZCBzdWdnZXN0ZWQganVzdCBh
ZGQgLVdhLC0gdG8gS0JVSUxEX0NGTEFHUyB3aGVuIEdDQyB3YXMNCj4gYmVpbmcgdXNlZCBidXQg
dGhhdCB3YXMgYmVmb3JlIHJlYWxpemluZyBpdCBpcyBiZWNhdXNlIENsYW5nIGRvZXNuJ3QgZG8N
Cj4gYW55dGhpbmcgd2l0aCAtcGlwZS4gSC4gUGV0ZXIgQW52aW4gc3VnZ2VzdGVkIGNoZWNraW5n
IHRvIHNlZSBpZiAtcGlwZQ0KPiBnaXZlcyB1cyBhbnkgZ2FpbnMgb3V0IG9mIEdDQy4gVHVybnMg
b3V0IGl0IG1pZ2h0IGFjdHVhbGx5IGJlIGh1cnRpbmc6DQo+IA0KPiBXaXRoIC1waXBlOg0KPiAN
Cj4gcmVhbCAgICAzbTQwLjgxM3MNCj4gcmVhbCAgICAzbTQ0LjQ0OXMNCj4gcmVhbCAgICAzbTM5
LjY0OHMNCj4gDQo+IFdpdGhvdXQgLXBpcGU6DQo+IA0KPiByZWFsICAgIDNtMzguNDkycw0KPiBy
ZWFsICAgIDNtMzguMzM1cw0KPiByZWFsICAgIDNtMzguOTc1cw0KPiANCj4gVGhlIGlzc3VlIG9m
IC1XYSwtIGJlaW5nIHBhc3NlZCBhbG9uZyB0byBnYXMgd2l0aG91dCAtcGlwZSBiZWluZw0KPiBz
dXBwb3J0ZWQgc2hvdWxkIHN0aWxsIHByb2JhYmx5IGJlIGZpeGVkIG9uIHRoZSBMTFZNIHNpZGUg
KG9wZW4gaXNzdWU6DQo+IGh0dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGYnVncy5sbHZtLm9yZyUyRnNob3dfYnVnLmNnaSUzRmlk
JTNEMzk0MTAmYW1wO2RhdGE9MDIlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3QzU2Njc4ZTAw
MTg4OTQ5NTU2MDE5MDhkNjM5M2NlNmQyJTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgzZDlkZDYy
ZjAlN0MxJTdDMCU3QzYzNjc1OTMzMTA3MjA4MjIxNSZhbXA7c2RhdGE9TWxPZVIxcDglMkJSUk9G
eGhqdzNTUWkwVWFpOXp1VWVFZXNCeFNNYU04d3NnJTNEJmFtcDtyZXNlcnZlZD0wKSBidXQgdGhp
cyBpcyBub3QgYXMgbXVjaCBvZg0KPiBhIHdvcmthcm91bmQgYW55bW9yZSBzaW5jZSBpdCBoZWxw
cyBib3RoIEdDQyBhbmQgQ2xhbmcuDQo+IA0KPiBMaW5rOiBodHRwczovL25hMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGh1Yi5jb20lMkZD
bGFuZ0J1aWx0TGludXglMkZsaW51eCUyRmlzc3VlcyUyRjIxMyZhbXA7ZGF0YT0wMiU3QzAxJTdD
bmFtaXQlNDB2bXdhcmUuY29tJTdDNTY2NzhlMDAxODg5NDk1NTYwMTkwOGQ2MzkzY2U2ZDIlN0Ni
MzkxMzhjYTNjZWU0YjRhYTRkNmNkODNkOWRkNjJmMCU3QzElN0MwJTdDNjM2NzU5MzMxMDcyMDgy
MjE1JmFtcDtzZGF0YT1xOWlDZFlhODBWNDlvMEJuWnFGZjNXWWNNd1JNbCUyQnR1UzFNTjhSWkNQ
RkklM0QmYW1wO3Jlc2VydmVkPTANCj4gU3VnZ2VzdGVkLWJ5OiBILiBQZXRlciBBbnZpbiA8aHBh
QHp5dG9yLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTmF0aGFuIENoYW5jZWxsb3IgPG5hdGVjaGFu
Y2VsbG9yQGdtYWlsLmNvbT4NCj4gLS0tDQo+IGFyY2gveDg2L01ha2VmaWxlIHwgNCArLS0tDQo+
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9NYWtlZmlsZSBiL2FyY2gveDg2L01ha2VmaWxlDQo+IGluZGV4
IDczZjQ4MzEyODNhYy4uNjcyYzY4OWMxZmFhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9NYWtl
ZmlsZQ0KPiArKysgYi9hcmNoL3g4Ni9NYWtlZmlsZQ0KPiBAQCAtMjEzLDggKzIxMyw2IEBAIGlm
ZGVmIENPTkZJR19YODZfNjQNCj4gS0JVSUxEX0xERkxBR1MgKz0gJChjYWxsIGxkLW9wdGlvbiwg
LXogbWF4LXBhZ2Utc2l6ZT0weDIwMDAwMCkNCj4gZW5kaWYNCj4gDQo+IC0jIFNwZWVkIHVwIHRo
ZSBidWlsZA0KPiAtS0JVSUxEX0NGTEFHUyArPSAtcGlwZQ0KPiAjIFdvcmthcm91bmQgZm9yIGEg
Z2NjIHByZWxlYXNlIHRoYXQgdW5mb3J0dW5hdGVseSB3YXMgc2hpcHBlZCBpbiBhIHN1c2UgcmVs
ZWFzZQ0KPiBLQlVJTERfQ0ZMQUdTICs9IC1Xbm8tc2lnbi1jb21wYXJlDQo+ICMNCj4gQEAgLTIz
OSw3ICsyMzcsNyBAQCBhcmNoaGVhZGVyczoNCj4gYXJjaG1hY3JvczoNCj4gCSQoUSkkKE1BS0Up
ICQoYnVpbGQpPWFyY2gveDg2L2tlcm5lbCBhcmNoL3g4Ni9rZXJuZWwvbWFjcm9zLnMNCj4gDQo+
IC1BU01fTUFDUk9fRkxBR1MgPSAtV2EsYXJjaC94ODYva2VybmVsL21hY3Jvcy5zIC1XYSwtDQo+
ICtBU01fTUFDUk9fRkxBR1MgPSAtV2EsYXJjaC94ODYva2VybmVsL21hY3Jvcy5zDQo+IGV4cG9y
dCBBU01fTUFDUk9fRkxBR1MNCj4gS0JVSUxEX0NGTEFHUyArPSAkKEFTTV9NQUNST19GTEFHUykN
Cj4gDQo+IC0tIA0KPiAyLjE5LjENCg0KVGhpcyBwaXBlIHdhcyBhIHBhaW4gaW4gdGhlIOKApiBJ
IGhhdmUgYWN0dWFsbHkgYWxyZWFkeSByZW1vdmVkIGl0IGluIG9uZQ0KdmVyc2lvbiBvZiB0aGUg
dmVyc2lvbnMgb2YgbXkgcGF0Y2gtc2V0Lg0KDQpSZXZpZXdlZC1ieTogTmFkYXYgQW1pdCA8bmFt
aXRAdm13YXJlLmNvbT4NCg0K
