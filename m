Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72490C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013702173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="StDG90U4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013702173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeI1O2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:28:40 -0400
Received: from mail-co1nam03on0089.outbound.protection.outlook.com ([104.47.40.89]:16208
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbeI1O2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u+ZOioiuszSrn/IdYXlP6GwkJMoNdlWK/UsEwqTF1c=;
 b=StDG90U4fP53IB/OsmqkF8Q2i9o3gXAFPhHtqK5s1mX440EwQeKs7ti1s6/5EZrpvRiNFFNPznJisTdDPXfiaudoRnWRSUVYOsv4CzU0a9RUAV/WKsWf73jvxkhYof2MmsdGNtzl9dbqMjioREex/atYmCnG/3KlAJb2rYPQrkE=
Received: from BLUPR0701MB1635.namprd07.prod.outlook.com (10.163.84.17) by
 BLUPR0701MB1875.namprd07.prod.outlook.com (10.162.88.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 08:06:02 +0000
Received: from BLUPR0701MB1635.namprd07.prod.outlook.com
 ([fe80::3d1a:5425:b869:df57]) by BLUPR0701MB1635.namprd07.prod.outlook.com
 ([fe80::3d1a:5425:b869:df57%8]) with mapi id 15.20.1164.024; Fri, 28 Sep 2018
 08:06:01 +0000
From:   "Kalderon, Michal" <Michal.Kalderon@cavium.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
CC:     "Elior, Ariel" <Ariel.Elior@cavium.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] RDMA/qedr: Remove enumerated type qed_roce_ll2_tx_dest
Thread-Topic: [PATCH v2] RDMA/qedr: Remove enumerated type
 qed_roce_ll2_tx_dest
Thread-Index: AQHUVqSpI2hcL/IS70i+18aHY4S5pqUEteWAgACfhcA=
Date:   Fri, 28 Sep 2018 08:06:00 +0000
Message-ID: <BLUPR0701MB1635C34CB86CA111E277CB8C88EC0@BLUPR0701MB1635.namprd07.prod.outlook.com>
References: <20180927011820.13608-1-natechancellor@gmail.com>
 <20180927205557.32026-1-natechancellor@gmail.com>
 <CAKwvOdkqcKdGnUdYXpmLhEGBzyxeGvmGAwow868y+sDFE56yFA@mail.gmail.com>
In-Reply-To: <CAKwvOdkqcKdGnUdYXpmLhEGBzyxeGvmGAwow868y+sDFE56yFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Kalderon@cavium.com; 
x-originating-ip: [31.168.140.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR0701MB1875;6:zkO+G6oR6j734AtYMZd3143ctByP3+LpwXfbUGOF6oq/KmTx/Nd8uABGL0oNqRw0sg6/ZNR6tnDYZWfggC650m2Pm+omfpEjScoa/t5H1fxd5hR5pgtJkCiss1vbZAtYpjTii111HpwEzQA+/pMVWZnuklo+etfJJeuA6yJt0mDsgZm2J/okMaYUSguovmvuKxV136QdzXRkEuCTwt6OeuptQL3sJUjPhOhBRPifV5aN6muCDEZXj9zv8SwF5wC8hglh7JXbiDXuhbZDpTJJYLGWApICdfR9Yyr4Jh7o9HQ8hHwpthsafY6HeS6FVO6GugvrGL/USps+LL3uGeSc+7A6kvaWGBtjMWuVnmo9k+Q9axhO60cB86fieqnR2E/KC/6aWRqg1sFRn++eeYf7ax8EQokbn0KXJOWpyKE77wOUgDMAD8N9+mpGGgAEVBLbvAZfCN3wsfq5jUwya293cQ==;5:J48sWlwTG9ZgW11PyKJ/IGN0miFlLcLIBp7zLXjbtREIXqfWCzsA9LvvbHdUr6zfmGOme2sfijymv0TnRi6JE2wc5S4CWpgVPEUtvmnen1HqKf5scupiuQiD+u8/T36p/nocLMYs1P9Gmf9z0f5cj1Uk3IxoerrUJpSTuOJyM4w=;7:TpH+s1wIU+W5HzZFy6EEcEvlpvNWFjcNEnf02wWJUSxxNcRNJEzQLE2IylctCOoYESHHugKEd/M/rq3CQ6tv5sUovjCQcKw1ol2nrC30J74gw72+aBAZCwo1mjGyFlZsY10iioPOMGgOHs6Y/6qYmicg5oNI7791cSLaxddV7MvNLSVp+hr+KEEcALYxZqwsWsC95Lg5nrdBPYZXfkO/pblIHJCRXfw+EeqdKXMDaxxr3J3s4nd7O2MpO/KJW093
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(136003)(346002)(199004)(189003)(15760500003)(229853002)(66066001)(9686003)(486006)(72206003)(6436002)(5250100002)(99286004)(106356001)(5660300001)(11346002)(25786009)(446003)(2900100001)(105586002)(6116002)(55016002)(34290500001)(14454004)(256004)(39060400002)(6246003)(68736007)(478600001)(14444005)(3846002)(476003)(2906002)(8936002)(86362001)(110136005)(7696005)(305945005)(54906003)(26005)(186003)(53936002)(76176011)(4326008)(6506007)(53546011)(71200400001)(71190400001)(7736002)(102836004)(97736004)(33656002)(74316002)(81166006)(8676002)(81156014)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1875;H:BLUPR0701MB1635.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: c513e7d6-2ea7-4f9d-b2d3-08d625193ae7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0701MB1875;
x-ms-traffictypediagnostic: BLUPR0701MB1875:
x-microsoft-antispam-prvs: <BLUPR0701MB1875A2B71750F5CA2823BB1B88EC0@BLUPR0701MB1875.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR0701MB1875;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1875;
x-forefront-prvs: 0809C12563
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: geSYmZCTHzn0prdnPAXaYFVmGX+77QfyVtSGFJgTZsH80HajHO9E7ckpLX8eKJ6trxLJxLnzKWPRwTW5uLwM80APubFi4G1/FmWv1QAGiKUh52GbnM2J2gD/71WMfSdofHt8j886Sq8p7GZOmC3o9aODzkW6rmbgNRYfDRI5HZVtzOWpVCBeEpztb878lJ/f9mLwKLOMGjs/iF9d5MkoKIhlzr2k5MJmP8w7thfwHI48HTvmFzuWE8goAWi+F/SIIEsor6ImgSeaDy+/Nr2STH4KuIm1gXol/nE7TWqPXxjFWVL9gU8Ocmz6DCuHBxh77cBgrq0CJPvdymxV5uO+ohjPIhf3tUqpCuIwH5zcDpA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c513e7d6-2ea7-4f9d-b2d3-08d625193ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 08:06:00.9795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1875
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4NCj4gU2Vu
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMjgsIDIwMTggMTozMCBBTQ0KPiANCj4gRXh0ZXJuYWwgRW1h
aWwNCj4gDQo+IE9uIFRodSwgU2VwIDI3LCAyMDE4IGF0IDE6NTcgUE0gTmF0aGFuIENoYW5jZWxs
b3INCj4gPG5hdGVjaGFuY2VsbG9yQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBDbGFuZyB3
YXJucyB3aGVuIG9uZSBlbnVtZXJhdGVkIHR5cGUgaXMgZXhwbGljaXRseSBjb252ZXJ0ZWQgdG8g
YW5vdGhlci4NCj4gPg0KPiA+IGRyaXZlcnMvaW5maW5pYmFuZC9ody9xZWRyL3FlZHJfcm9jZV9j
bS5jOjE5ODoyODogd2FybmluZzogaW1wbGljaXQNCj4gPiBjb252ZXJzaW9uIGZyb20gZW51bWVy
YXRpb24gdHlwZSAnZW51bSBxZWRfcm9jZV9sbDJfdHhfZGVzdCcgdG8NCj4gPiBkaWZmZXJlbnQg
ZW51bWVyYXRpb24gdHlwZSAnZW51bSBxZWRfbGwyX3R4X2Rlc3QnIFstV2VudW0tY29udmVyc2lv
bl0NCj4gPiAgICAgICAgIGxsMl90eF9wa3QudHhfZGVzdCA9IHBrdC0+dHhfZGVzdDsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB+IH5+fn5+Xn5+fn5+fg0KPiA+IDEgd2FybmluZyBn
ZW5lcmF0ZWQuDQo+ID4NCj4gPiBUdXJucyBvdXQgdGhhdCBRRURfUk9DRV9MTDJfVFhfREVTVF9O
VyBhbmQNCj4gUUVEX1JPQ0VfTEwyX1RYX0RFU1RfTEIgYXJlDQo+ID4gb25seSB1c2VkIG9uY2Ug
aW4gdGhlIHdob2xlIHRyZWUgYW5kIFFFRF9ST0NFX0xMMl9UWF9ERVNUX01BWCBpcw0KPiB1c2Vk
DQo+ID4gbm93aGVyZS4gUmVtb3ZlIHRoZW0gYW5kIHVzZSB0aGUgZXF1aXZhbGVudCB2YWx1ZXMg
ZnJvbQ0KPiA+IHFlZF9sbDJfdHhfZGVzdCBpbiB0aGVpciBwbGFjZS4NCj4gPg0KPiA+IFJlcG9y
dGVkLWJ5OiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0ZWNoYW5jZWxsb3JAZ21haWwuY29t
Pg0KPiA+IC0tLQ0KPiA+DQo+ID4gdjEgLT4gdjI6DQo+ID4NCj4gPiAqIFJhdGhlciB0aGFuIHVz
aW5nIGFuIGV4cGxpY2l0IGNhc3QsIGp1c3QgY29udmVydCB0aGUgdXNlcyB0byB0aGUNCj4gPiAg
IGFwcHJvcHJpYXRlIHZhbHVlcyBhbmQgZGVsZXRlIHRoZSBkdXBsaWNhdGVkIGVudW0uDQo+ID4N
Cj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L3FlZHIvcWVkcl9yb2NlX2NtLmMgfCAgNCArKy0t
DQo+ID4gIGluY2x1ZGUvbGludXgvcWVkL3FlZF9yZG1hX2lmLmggICAgICAgICAgIHwgMTEgKy0t
LS0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEyIGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9xZWRy
L3FlZHJfcm9jZV9jbS5jDQo+ID4gYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvcWVkci9xZWRyX3Jv
Y2VfY20uYw0KPiA+IGluZGV4IDg1NTc4ODg3NDIxYi4uZTFhYzJmZDYwYmIxIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9xZWRyL3FlZHJfcm9jZV9jbS5jDQo+ID4gKysr
IGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L3FlZHIvcWVkcl9yb2NlX2NtLmMNCj4gPiBAQCAtNTE5
LDkgKzUxOSw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IHFlZHJfZ3NpX2J1aWxkX3BhY2tldChzdHJ1
Y3QNCj4gcWVkcl9kZXYgKmRldiwNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgaWYg
KGV0aGVyX2FkZHJfZXF1YWwodWRoLmV0aC5zbWFjX2gsIHVkaC5ldGguZG1hY19oKSkNCj4gPiAt
ICAgICAgICAgICAgICAgcGFja2V0LT50eF9kZXN0ID0gUUVEX1JPQ0VfTEwyX1RYX0RFU1RfTEI7
DQo+ID4gKyAgICAgICAgICAgICAgIHBhY2tldC0+dHhfZGVzdCA9IFFFRF9MTDJfVFhfREVTVF9M
QjsNCj4gPiAgICAgICAgIGVsc2UNCj4gPiAtICAgICAgICAgICAgICAgcGFja2V0LT50eF9kZXN0
ID0gUUVEX1JPQ0VfTEwyX1RYX0RFU1RfTlc7DQo+ID4gKyAgICAgICAgICAgICAgIHBhY2tldC0+
dHhfZGVzdCA9IFFFRF9MTDJfVFhfREVTVF9OVzsNCj4gDQo+IFllcCwgbG9va3MgbGlrZSB0aGVz
ZSB3ZXJlIHRoZSBvbmx5IHR3byBzaXRlcyB1c2luZyBlbnVtDQo+IHFlZF9yb2NlX2xsMl90eF9k
ZXN0IGluIHRoZSB3aG9sZSBrZXJuZWwuICBUaGUgbmV3IGVudW0gdmFsdWVzIG1hdGNoIHRoZQ0K
PiBwcmV2aW91cyBlbnVtIHZhbHVlcywgc28gdGhpcyBpcyBubyBmdW5jdGlvbmFsIGNoYW5nZSB3
aGlsZSBzaW1wbGlmeWluZyB0aGUNCj4gY29kZSAob25lIGxlc3MgZW51bSB0byBnZXQgd3Jvbmcp
Lg0KPiBSZXZpZXdlZC1ieTogTmljayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5j
b20+DQo+IA0KPiA+DQo+ID4gICAgICAgICBwYWNrZXQtPnJvY2VfbW9kZSA9IHJvY2VfbW9kZTsN
Cj4gPiAgICAgICAgIG1lbWNweShwYWNrZXQtPmhlYWRlci52YWRkciwgdWRfaGVhZGVyX2J1ZmZl
ciwgaGVhZGVyX3NpemUpOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3FlZC9xZWRf
cmRtYV9pZi5oDQo+ID4gYi9pbmNsdWRlL2xpbnV4L3FlZC9xZWRfcmRtYV9pZi5oIGluZGV4IGRm
NGQxM2Y3ZTE5MS4uZDE1ZjhlNDgxNWUzDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9s
aW51eC9xZWQvcWVkX3JkbWFfaWYuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvcWVkL3FlZF9y
ZG1hX2lmLmgNCj4gPiBAQCAtMzksMTUgKzM5LDYgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3Fl
ZC9xZWRfbGwyX2lmLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9xZWQvcmRtYV9jb21tb24uaD4N
Cj4gPg0KPiA+IC1lbnVtIHFlZF9yb2NlX2xsMl90eF9kZXN0IHsNCj4gPiAtICAgICAgIC8qIExp
Z2h0IEwyIFRYIERlc3RpbmF0aW9uIHRvIHRoZSBOZXR3b3JrICovDQo+ID4gLSAgICAgICBRRURf
Uk9DRV9MTDJfVFhfREVTVF9OVywNCj4gPiAtDQo+ID4gLSAgICAgICAvKiBMaWdodCBMMiBUWCBE
ZXN0aW5hdGlvbiB0byB0aGUgTG9vcGJhY2sgKi8NCj4gPiAtICAgICAgIFFFRF9ST0NFX0xMMl9U
WF9ERVNUX0xCLA0KPiA+IC0gICAgICAgUUVEX1JPQ0VfTEwyX1RYX0RFU1RfTUFYDQo+ID4gLX07
DQo+ID4gLQ0KPiA+ICAjZGVmaW5lIFFFRF9SRE1BX01BWF9DTlFfU0laRSAgICAgICAgICAgICAg
ICgweEZGRkYpDQo+ID4NCj4gPiAgLyogcmRtYSBpbnRlcmZhY2UgKi8NCj4gPiBAQCAtNTgxLDcg
KzU3Miw3IEBAIHN0cnVjdCBxZWRfcm9jZV9sbDJfcGFja2V0IHsNCj4gPiAgICAgICAgIGludCBu
X3NlZzsNCj4gPiAgICAgICAgIHN0cnVjdCBxZWRfcm9jZV9sbDJfYnVmZmVyIHBheWxvYWRbUkRN
QV9NQVhfU0dFX1BFUl9TUV9XUUVdOw0KPiA+ICAgICAgICAgaW50IHJvY2VfbW9kZTsNCj4gPiAt
ICAgICAgIGVudW0gcWVkX3JvY2VfbGwyX3R4X2Rlc3QgdHhfZGVzdDsNCj4gPiArICAgICAgIGVu
dW0gcWVkX2xsMl90eF9kZXN0IHR4X2Rlc3Q7DQo+ID4gIH07DQo+ID4NCj4gPiAgZW51bSBxZWRf
cmRtYV90eXBlIHsNCj4gPiAtLQ0KPiA+IDIuMTkuMA0KPiA+DQo+IA0KPiANCj4gLS0NCj4gVGhh
bmtzLA0KPiB+TmljayBEZXNhdWxuaWVycw0KDQpUaGFua3MsIGRlZmluaXRlbHkgIGxvb2tzIGNs
ZWFuZXIuIA0KQWNrZWQtYnk6IE1pY2hhbCBLYWxkZXJvbiA8bWljaGFsLmthbGRlcm9uQGNhdml1
bS5jb20+DQoNCg0K
