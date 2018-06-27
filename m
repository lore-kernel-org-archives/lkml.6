Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82798C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A4B26900
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CuCda7eK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A4B26900
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934654AbeF0BSK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:18:10 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:59561
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751224AbeF0BSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNUxJU/GcgTyyf4c5ZYVrohD0a0DUi7ppSsVBZWi/aM=;
 b=CuCda7eKvuI3VGKckE6fde4RnPnE/SnvPBlzKd3ERskCOmx+NUGpfBawnYWSw9Q7DoG/5kreqLF0KMHetdUfuVJQUb/EnxktOwjQarEOXczijty3WwmPe7Dl6Xt2QQx34o/rUCWDrAxPyF8Ihg8s2st4BNQcZyIcb00mAad1FG8=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3125.eurprd04.prod.outlook.com (10.170.214.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Wed, 27 Jun 2018 01:18:05 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::982d:7c4d:d525:42f9]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::982d:7c4d:d525:42f9%5]) with mapi id 15.20.0884.024; Wed, 27 Jun 2018
 01:18:05 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v5 0/7] add virt-dma support for imx-sdma
Thread-Topic: [PATCH v5 0/7] add virt-dma support for imx-sdma
Thread-Index: AQHUB6ubqqf+VcikvUmzLvpSTD8gdKRyrn4AgACqdHA=
Date:   Wed, 27 Jun 2018 01:18:05 +0000
Message-ID: <DB6PR04MB3223F2B6364A63A00A251DF689480@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
 <1530025442.9910.44.camel@pengutronix.de>
In-Reply-To: <1530025442.9910.44.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3125;7:Si+2KIlWZheRkIu90BjgTU40MYIx6aPEvTjrrytDtW/bX1Bg6UuQfZ6wYdh5paK+hm/mYKWHJ8t1w45MI9RLkl+GxruAjpPIQ2oZPOXMFRFXbYOiqi42nw1rrGefhvrqzfX6fLRIXwlDRyqVa+PCd8W60lHLbvTi+2LfNHEuqMNWj7KF/Hr9cUm+sPhA7bTOlPdsgAs/LWWkkjPRN4hXemwe+a3sZ87cHTVi6K0inhufL8wab3NaBCKtdL5Rjt1+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f6a2debf-8fb6-49fd-185c-08d5dbcbd5de
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3125;
x-ms-traffictypediagnostic: DB6PR04MB3125:
x-microsoft-antispam-prvs: <DB6PR04MB3125BFE4F6F424EC5B77170889480@DB6PR04MB3125.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3125;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3125;
x-forefront-prvs: 0716E70AB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(13464003)(189003)(199004)(6116002)(9686003)(55016002)(33656002)(68736007)(3846002)(7416002)(229853002)(2501003)(5660300001)(66066001)(5250100002)(14444005)(256004)(6436002)(6246003)(53936002)(4326008)(2900100001)(106356001)(74316002)(305945005)(7736002)(105586002)(486006)(478600001)(14454004)(2906002)(53546011)(102836004)(81166006)(81156014)(25786009)(26005)(476003)(8936002)(76176011)(99286004)(446003)(316002)(6506007)(86362001)(11346002)(7696005)(6346003)(110136005)(97736004)(2201001)(186003)(54906003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3125;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-microsoft-antispam-message-info: TvnQFFWacKEkQlDqDOc0Bc0NbbncXa01J+0d5kQJLTnj2CzFdR66qJ5HC3npXbuGYNo78yP5R9Kqmf3R1nTBRRJbRsIsPot9aVDp5XyXcXsMBrLC4u6zf0rD2wgz9zeSyiTMbC0kyzA6fDuuvkJwQEpNGG8m9N8u9ha+O1ZKDfGvmeuF/VIjVVSZlDiRbzKaL6LqBdjn8aUl7uaIvIIi06d9ft2UOs64ayamij1cNiJ6oU9SSqJdrMdXT/8Td23VfWkrGC/Btx34FP4poUjBwsNgJjzpth180qurT0WQhl5ksJ6CuXW3B79vWEaB/CjuucBhcM3BMTVu9F9aFAbDvqF4PZFwGstGdCoXbrq77U0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a2debf-8fb6-49fd-185c-08d5dbcbd5de
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2018 01:18:05.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEx1Y2FzLiBMZXQncyB3YWl0IGZvciBjb21tZW50cyBmcm9tIFZpbm9kLg0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTHVjYXMgU3RhY2ggW21haWx0bzpsLnN0YWNo
QHBlbmd1dHJvbml4LmRlXSANClNlbnQ6IDIwMTjlubQ25pyIMjbml6UgMjM6MDQNClRvOiBSb2Jp
biBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+OyB2a291bEBrZXJuZWwub3JnOyBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOyBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOyBqc2xhYnlAc3VzZS5jb20NCkNjOiBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwu
b3JnOyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvN10gYWRkIHZpcnQt
ZG1hIHN1cHBvcnQgZm9yIGlteC1zZG1hDQoNCkhpIFJvYmluLA0KDQpJJ3ZlIHRlc3RlZCB0aGlz
IHdob2xlIHNlcmllcyB3aXRoIHRoZSBTRE1BIGJlaW5nIHVzZWQgZm9yIFNQSSwgVUFSVCBhbmQg
U1NJIHdpdGggbm8gcmVncmVzc2lvbnMgc3BvdHRlZC4gQXMgdGhpcyBzaG91bGQgY292ZXIgbW9z
dCBjb21tb24gdXNlLWNhc2VzLCBJIHRoaW5rIHRoaXMgc2VyaWVzIGlzIGdvb2QgdG8gZ28gaW4u
DQoNClRlc3RlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQoNClJl
Z2FyZHMsDQpMdWNhcw0KDQpBbSBNaXR0d29jaCwgZGVuIDIwLjA2LjIwMTgsIDAwOjU2ICswODAw
IHNjaHJpZWIgUm9iaW4gR29uZzoNCj4gVGhlIGxlZ2FjeSBzZG1hIGRyaXZlciBoYXMgYmVsb3cg
bGltaXRhdGlvbnMgb3IgZHJhd2JhY2tzOg0KPiDCoCAxLiBIYXJkY29kZSB0aGUgbWF4IEJEcyBu
dW1iZXIgYXMgIlBBR0VfU0laRSAvIHNpemVvZigqKSIsIGFuZCBhbGxvYw0KPiDCoMKgwqDCoMKg
b25lIHBhZ2Ugc2l6ZSBmb3Igb25lIGNoYW5uZWwgcmVnYXJkbGVzcyBvZiBvbmx5IGZldyBCRHMg
bmVlZGVkDQo+IMKgwqDCoMKgwqBtb3N0IHRpbWUuIEJ1dCBpbiBmZXcgY2FzZXMsIHRoZSBtYXgg
UEFHRV9TSVpFIG1heWJlIG5vdCBlbm91Z2guDQo+IMKgIDIuIE9uZSBTRE1BIGNoYW5uZWwgY2Fu
J3Qgc3RvcCBpbW1lZGlhdGxleSBvbmNlIGNoYW5uZWwgZGlzYWJsZWQgDQo+IHdoaWNoDQo+IMKg
wqDCoMKgwqBtZWFucyBTRE1BIGludGVycnVwdCBtYXkgY29tZSBpbiBhZnRlciB0aGlzIGNoYW5u
ZWwgDQo+IHRlcm1pbmF0ZWQuVGhlcmUNCj4gwqDCoMKgwqDCoGFyZSBzb21lIHBhdGNoZXMgZm9y
IHRoaXMgY29ybmVyIGNhc2Ugc3VjaCBhcyBjb21taXQgDQo+ICIyNzQ2ZTJjMzg5ZjkiLA0KPiDC
oMKgwqDCoMKgYnV0IG5vdCBjb3ZlciBub24tY3ljbGljLg0KPiANCj4gVGhlIGNvbW1vbiB2aXJ0
LWRtYSBvdmVyY29tZXMgdGhlIGFib3ZlIGxpbWl0YXRpb25zLiBJdCBjYW4gYWxsb2MgYmQgDQo+
IGR5bmFtaWNhbGx5IGFuZCBmcmVlIGJkIG9uY2UgdGhpcyB0eCB0cmFuc2ZlciBkb25lLiBObyBt
ZW1vcnkgd2FzdGVkIA0KPiBvciBtYXhpbXVtIGxpbWl0aXRhdGlvbiBoZXJlLCBvbmx5IGRlcGVu
ZHMgb24gaG93IG1hbnkgbWVtb3J5IGNhbiBiZSANCj4gcmVxdWVzdGVkIGZyb20ga2VybmVsLiBG
b3IgTm8uMiwgc3VjaCBpc3N1ZSBjYW4gYmUgd29ya2Fyb3VuZCBieSANCj4gY2hlY2tpbmcgaWYg
dGhlcmUgaXMgYXZhaWxhYmxlIGRlc2NyaXB0KCJzZG1hYy0+ZGVzYyIpIG5vdyBvbmNlIHRoZSAN
Cj4gdW53YW50ZWQgaW50ZXJydXB0IGNvbWluZy4gQXQgbGFzdCB0aGUgY29tbW9uIHZpcnQtZG1h
IGlzIGVhc2llciBmb3Igc2RtYSBkcml2ZXIgbWFpbnRhaW4uDQo+IA0KPiBDaGFuZ2UgZnJvbSB2
NDoNCj4gwqAgMS4gaWRlbnRpZnkgbG9ja2RlcCBpc3N1ZSB3aGljaCBjYXVzZWQgYnkgYWxsb2Nh
dGUgbWVtb3J5IHdpdGgNCj4gwqDCoMKgwqDCoCdHRlBfS0VSTkVMJywgY2hhbmdlIHRvICdHRlBf
Tk9XQUlUJyBpbnN0ZWFkIHNvIHRoYXQgbG9ja2RlcA0KPiDCoMKgwqDCoMKgaWdub3JlIGNoZWNr
LiBUaGF0IGFsc28gbWFrZSBzZW5zZSBzaW5jZSBBdWRpby91YXJ0IGRyaXZlciBtYXkNCj4gwqDC
oMKgwqDCoGNhbGwgZG1hIGZ1bmN0aW9uIGFmdGVyIHNwaW5fbG9ja19pcnFzYXZlKCkuLi4NCj4g
wqAgMi4gdXNlIGRtYSBwb29sIGluc3RlYWQgZm9yIGJkIGRlc2NyaXB0aW9uIGFsbG9jYXRlZCxz
aW5jZSBhdWRpbw0KPiDCoMKgwqDCoMKgZHJpdmVyIG1heSBjYWxsIGRtYV90ZXJtaW5hdGVfYWxs
IGluIGlycS4gUGxlYXNlIHJlZmVyIHRvIDcvNy4NCj4gwqAgMy4gcmVtb3ZlIDcvNyBzZXJpYWwg
cGF0Y2ggaW4gdjQsIHNpbmNlIGxvY2tkZXAgaXNzdWVkIGZpeGVkIGJ5IE5vLjENCj4gDQo+IENo
YW5nZSBmcm9tIHYzOg0KPiDCoCAxLiBhZGQgdHdvIHVhcnQgcGF0Y2hlcyB3aGljaCBpbXBhY3Rl
ZCBieSB0aGlzIHBhdGNoc2V0Lg0KPiDCoCAyLiB1bmxvY2sgJ3ZjLmxvY2snIGJlZm9yZSBjeWNs
aWMgZG1hIGNhbGxiYWNrIGFuZCBsb2NrIGFnYWluIGFmdGVyDQo+IMKgwqDCoMKgwqBpdCBiZWNh
dXNlIHNvbWUgZHJpdmVyIHN1Y2ggYXMgdWFydCB3aWxsIGNhbGwgZG1hZW5naW5lX3R4X3N0YXR1
cw0KPiDCoMKgwqDCoMKgd2hpY2ggd2lsbCBhY3F1aXJlICd2Yy5sb2NrJyBhZ2FpbiBhbmQgZGVh
ZCBsb2NrIGNvbWVzIG91dC4NCj4gwqAgMy4gcmVtb3ZlICdSZXZlcnQgY29tbWl0JyBzdHVmZiBz
aW5jZSB0aGF0IHBhdGNoIGlzIG5vdCB3cm9uZyBhbmQNCj4gwqDCoMKgwqDCoGNvbWJpbmUgdHdv
IHBhdGNoIGludG8gb25lIHBhdGNoIGFzIFNhc2NoYSdzIGNvbW1lbnQuDQo+IA0KPiBDaGFuZ2Ug
ZnJvbSB2MjoNCj4gwqAgMS4gaW5jbHVkZSBTYXNjaGEncyBwYXRjaCB0byBtYWtlIHRoZSBtYWlu
IHBhdGNoIGVhc2llciB0byByZXZpZXcuDQo+IMKgwqDCoMKgwqBUaGFua3MgU2FjaGEuDQo+IMKg
IDIuIHJlbW92ZSB1c2VsZXNzICdkZXNjJy8nY2hhbicgaW4gc3RydWN0IHNkbWFfY2hhbm5lLg0K
PiANCj4gQ2hhbmdlIGZyb20gdjE6DQo+IMKgIDEuIHNwbGl0IHYxIHBhdGNoIGludG8gNSBwYXRj
aGVzLg0KPiDCoCAyLiByZW1vdmUgc29tZSB1bm5lY2Vzc2FyeSBjb25kaXRpb24gY2hlY2suDQo+
IMKgIDMuIHJlbW92ZSB1bm5lY2Vzc2FyeSAncGVuZGluZycgbGlzdC4NCj4gDQo+IFJvYmluIEdv
bmcgKDYpOg0KPiDCoCB0dHk6IHNlcmlhbDogaW14OiBjb3JyZWN0IGRtYSBjb29raWUgc3RhdHVz
DQo+IMKgIGRtYWVuZ2luZTogaW14LXNkbWE6IGFkZCB2aXJ0LWRtYSBzdXBwb3J0DQo+IMKgIGRt
YWVuZ2luZTogaW14LXNkbWE6IHJlbW92ZSB1c2VsZXNzICdsb2NrJyBhbmQgJ2VuYWJsZWQnIGlu
ICdzdHJ1Y3QNCj4gwqDCoMKgwqBzZG1hX2NoYW5uZWwnDQo+IMKgIGRtYWVuZ2luZTogaW14LXNk
bWE6IHJlbW92ZSB0aGUgbWF4aW11bSBsaW1pdGF0aW9uIGZvciBiZCBudW1iZXJzDQo+IMKgIGRt
YWVuZ2luZTogaW14LXNkbWE6IGFkZCBzZG1hX3RyYW5zZmVyX2luaXQgdG8gZGVjcmVhc2UgY29k
ZSBvdmVybGFwDQo+IMKgIGRtYWVuZ2luZTogaW14LXNkbWE6IGFsbG9jbGF0ZSBiZCBtZW1vcnkg
ZnJvbSBkbWEgcG9vbA0KPiANCj4gU2FzY2hhIEhhdWVyICgxKToNCj4gwqAgZG1hZW5naW5lOiBp
bXgtc2RtYTogZmFjdG9yIG91dCBhIHN0cnVjdCBzZG1hX2Rlc2MgZnJvbSBzdHJ1Y3QNCj4gwqDC
oMKgwqBzZG1hX2NoYW5uZWwNCj4gDQo+IMKgZHJpdmVycy9kbWEvS2NvbmZpZ8KgwqDCoMKgwqDC
oHzCoMKgwqAxICsNCj4gwqBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jwqDCoMKgfCA0MDAgDQo+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IMKgZHJpdmVy
cy90dHkvc2VyaWFsL2lteC5jIHzCoMKgwqAyICstDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCAyMzUg
aW5zZXJ0aW9ucygrKSwgMTY4IGRlbGV0aW9ucygtKQ0KPiANCg==
