Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D664AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB872075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB872075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936056AbeFRVhs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:37:48 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:52155 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755344AbeFRVhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:37:45 -0400
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 00DBA634DA;
        Mon, 18 Jun 2018 21:37:44 +0000 (UTC)
Received: from G9W8456.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 4622F91;
        Mon, 18 Jun 2018 21:37:43 +0000 (UTC)
Received: from G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) by
 G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) with Microsoft SMTP
 Server (TLS) id 15.0.1178.4; Mon, 18 Jun 2018 21:37:42 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W8453.americas.hpqcorp.net (16.216.160.211) with Microsoft SMTP Server
 (TLS) id 15.0.1178.4 via Frontend Transport; Mon, 18 Jun 2018 21:37:42 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.145) by
 AT5PR8401MB0706.NAMPRD84.PROD.OUTLOOK.COM (10.169.5.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Mon, 18 Jun 2018 21:37:39 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4477:7ee3:af68:8f51]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4477:7ee3:af68:8f51%8]) with mapi id 15.20.0863.016; Mon, 18 Jun 2018
 21:37:39 +0000
From:   "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To:     'Dan Williams' <dan.j.williams@intel.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Li, Juston" <juston.li@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI
 6.1
Thread-Topic: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI
 6.1
Thread-Index: AQHRnzuRoA+GWvSx3Uq4ciaXUj5K6aRrLxmAgAAKm4CAAAH8gIAADVAA
Date:   Mon, 18 Jun 2018 21:37:39 +0000
Message-ID: <AT5PR8401MB1169FA8B55B36BAE8DF0F6EBAB710@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
 <1461620099-11933-2-git-send-email-toshi.kani@hpe.com>
 <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
 <1529350667.14039.119.camel@hpe.com>
 <CAPcyv4jbctFgCob58sjQZ8msGOT7GBe=+Z_2P6YvNrrK-ztMag@mail.gmail.com>
In-Reply-To: <CAPcyv4jbctFgCob58sjQZ8msGOT7GBe=+Z_2P6YvNrrK-ztMag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.211.195.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0706;7:N+o4Br0ECetdLgl7dYjPKqxOMqHObd31SQ7SumlRALxhJ1aQlADcuvxLFPkCpMwu1ptL7lADb0//T09WgTeCpJbxp6moS1cmkh8uuzKHapBjlVcr4vSQ5Z2U4HV6l5BDwEP+cuJzaSmoA1QxROQ/fu1Rd/lzpwzovCx9oL5NwsWEq5kAApPFOfbFd5yMiLD35ac0on6hOQTfso5lBrNrnnNAJN/aTBSSei7RzDCuZzYYFZkeF66wybZGFkUS8IqE
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39860400002)(366004)(39380400002)(396003)(376002)(346002)(13464003)(189003)(199004)(40224003)(5660300001)(305945005)(229853002)(93886005)(316002)(6636002)(5250100002)(105586002)(106356001)(66066001)(15650500001)(25786009)(2906002)(76176011)(110136005)(186003)(3280700002)(68736007)(54906003)(4326008)(26005)(6436002)(3660700001)(7736002)(86362001)(99286004)(8676002)(446003)(11346002)(486006)(81156014)(81166006)(476003)(74316002)(97736004)(102836004)(53546011)(6506007)(8936002)(59450400001)(2900100001)(478600001)(55016002)(7696005)(14454004)(966005)(33656002)(6246003)(3846002)(6306002)(53936002)(9686003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0706;H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 91903d04-407b-44a7-e8f3-08d5d563b729
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0706;
x-ms-traffictypediagnostic: AT5PR8401MB0706:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=elliott@hpe.com; 
x-microsoft-antispam-prvs: <AT5PR8401MB07063CA58D405A86262D7EFAAB710@AT5PR8401MB0706.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(9452136761055)(162533806227266)(222181515654134)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB0706;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0706;
x-forefront-prvs: 0707248B64
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J7dQerOMZWu9Nppido7C5T4vr5bbRciqJuf4dfoNu8zpmWdsME6AOVdDXFMcZjdnjTZUhRTOoUeVwcl8AfWGTl+vajsIxlHz5DffiKMB5WvJ+j7hqSUcdAHEgTg3lhhH5i43GdpAZDSaHGtVeIcGJPsAH9sqEf7a2BPAxQTJ6T/ewK0lMJPK9tX+PLt0BcC/OTmGBGJMKGxCDQn2nQ00J2ZogMD/UismKi6+GtWqz8CvzrtCDwkLZvfM4hQKL/OusB7Buzq7mh+JExTPh5m6eWH1uYrOF6njDLoW3tkyhV6l7HnXxXr0DRJRc4Gfb1NJqcqf+L4Y/D8CFW52KjGrEw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 91903d04-407b-44a7-e8f3-08d5d563b729
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2018 21:37:39.2686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0706
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxpYW1zIFtt
YWlsdG86ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tXQ0KPiBTZW50OiBNb25kYXksIEp1bmUgMTgs
IDIwMTggMjo0NyBQTQ0KPiBUbzogS2FuaSwgVG9zaGkgPHRvc2hpLmthbmlAaHBlLmNvbT4NCj4g
Q2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5v
cmc7IE1vb3JlLCBSb2JlcnQNCj4gPHJvYmVydC5tb29yZUBpbnRlbC5jb20+OyBMaSwgSnVzdG9u
IDxqdXN0b24ubGlAaW50ZWwuY29tPjsNCj4gcmp3QHJqd3lzb2NraS5uZXQ7IGxpbnV4LWFjcGlA
dmdlci5rZXJuZWwub3JnOyBFbGxpb3R0LCBSb2JlcnQgKFBlcnNpc3RlbnQNCj4gTWVtb3J5KSA8
ZWxsaW90dEBocGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gYWNwaS9uZml0
OiBVcGRhdGUgbmZpdCBkcml2ZXIgdG8gY29tcGx5IHdpdGgNCj4gQUNQSSA2LjENCj4gDQo+IE9u
IE1vbiwgSnVuIDE4LCAyMDE4IGF0IDEyOjM5IFBNLCBLYW5pLCBUb3NoaSA8dG9zaGkua2FuaUBo
cGUuY29tPiB3cm90ZToNCj4gPiBPbiBNb24sIDIwMTgtMDYtMTggYXQgMTI6MDEgLTA3MDAsIERh
biBXaWxsaWFtcyB3cm90ZToNCj4gPj4gT24gTW9uLCBBcHIgMjUsIDIwMTYgYXQgMjo0MyBQTSBU
b3NoaSBLYW5pIDx0b3NoaS5rYW5pQGhwZS5jb20+IHdyb3RlOg0KPiA+PiA+DQo+ID4+ID4gQUNQ
SSA2LjEsIFRhYmxlIDUtMTMzLCB1cGRhdGVzIE5WRElNTSBDb250cm9sIFJlZ2lvbiBTdHJ1Y3R1
cmUNCj4gPj4gPiBhcyBmb2xsb3dzLg0KPiA+PiA+ICAtIFZhbGlkIEZpZWxkcywgTWFudWZhY3R1
cmluZyBMb2NhdGlvbiwgYW5kIE1hbnVmYWN0dXJpbmcgRGF0ZQ0KPiA+PiA+ICAgIGFyZSBhZGRl
ZCBmcm9tIHJlc2VydmVkIHJhbmdlLiAgTm8gY2hhbmdlIGluIHRoZSBzdHJ1Y3R1cmUgc2l6ZS4N
Cj4gPj4gPiAgLSBJRHMgKFNQRCB2YWx1ZXMpIGFyZSBzdG9yZWQgYXMgYXJyYXlzIG9mIGJ5dGVz
IChpLmUuIGJpZy1lbmRpYW4NCj4gPj4gPiAgICBmb3JtYXQpLiAgVGhlIHNwZWMgY2xhcmlmaWVz
IHRoYXQgdGhleSBuZWVkIHRvIGJlIHJlcHJlc2VudGVkDQo+ID4+ID4gICAgYXMgYXJyYXlzIG9m
IGJ5dGVzIGFzIHdlbGwuDQo+ID4+ID4NCj4gPj4NCj4gPj4gQ2lyY2xpbmcgYmFjayBvbiB0aGlz
IGEgY291cGxlIHllYXJzIHRvbyBsYXRlLi4uIHdoZXJlIGFyZSB5b3UgcmVhZGluZw0KPiA+PiB0
aGlzICJhcnJheXMgb2YgYnl0ZXMiIG5vdGUuIEFzIGZhciBhcyBJIGNhbiBzZWUgdGhpcyBpcyB3
cm9uZy4gSkVERUMNCj4gPj4gc2F5cyB0aGF0IHZlbmRvciBpZCBpcyBzdG9yZWQgTFNCIG9mIHRo
ZSBpZCBpcyBzdG9yZWQgYXQgdGhlIGxvd2VzdA0KPiA+PiBieXRlIGluIFNQRCwgd2hpY2ggaXMg
bGl0dGxlIGVuZGlhbi4gU28gaXQgc2VlbXMgTGludXggaGFzIHNob3dpbmcgdGhlDQo+ID4+IGlu
Y29ycmVjdCB2YWx1ZSBmb3IgYSBsb25nIHRpbWUgbm93Lg0KPiA+DQo+ID4gVGhpcyBmb2xsb3dz
IEFDUEkgNi4yYSBzZWN0aW9uIDUuMi4yNS4xMCBOVkRJTU0gUmVwcmVzZW50YXRpb24gRm9ybWF0
LA0KPiA+IHdoaWNoIFJvYmVydCBjaXRlZCBpbiBoaXMgY29tbWVudCBiZWxvdzoNCj4gPiBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwMjM3NjA5Lw0KPiANCj4gUmlnaHQsIHRo
ZSByZXByZXNlbnRhdGlvbiBmb3JtYXQgaGFzIHRoZSBmaWVsZHMgYmlnLWVuZGlhbiBmb3Igc29t
ZQ0KPiByZWFzb24sIGJ1dCB0aGUgaW5kaXZpZHVhbCB2YWx1ZXMgZm9yIHN5c2ZzIHNob3VsZCBi
ZSBzaG93DQo+IGxpdHRsZS1lbmRpYW4gYXMgZmFyIGFzIEkgY2FuIHNlZS4gV2hhdCBhbSBJIG1p
c3Npbmc/DQoNCkluIHByYWN0aWNlLCB0aGUgc2VyaWFsIG51bWJlcnMgZnJvbSB0aHJlZSBtYWpv
ciBERFI0IERJTU0gbWFudWZhY3R1cmVycw0KYXJlIGJlaW5nIGFzc2lnbmVkIGFzIGJpZy1lbmRp
YW4sIGxpa2UgaW4gdGhpcyBzZXQgb2YgTlZESU1NLU5zOg0KL3N5cy9idXMvbmQvZGV2aWNlcy9u
bWVtMC9uZml0L3NlcmlhbDoweDEyMmY4MjU1DQovc3lzL2J1cy9uZC9kZXZpY2VzL25tZW0xL25m
aXQvc2VyaWFsOjB4MTIyZjdmNWUNCi9zeXMvYnVzL25kL2RldmljZXMvbm1lbTIvbmZpdC9zZXJp
YWw6MHgxMjJmODE4Zg0KL3N5cy9idXMvbmQvZGV2aWNlcy9ubWVtMy9uZml0L3NlcmlhbDoweDEy
MmY4MjFjDQovc3lzL2J1cy9uZC9kZXZpY2VzL25tZW00L25maXQvc2VyaWFsOjB4MTIyZjgxN2UN
Ci9zeXMvYnVzL25kL2RldmljZXMvbm1lbTUvbmZpdC9zZXJpYWw6MHgxMjJmODFjZA0KL3N5cy9i
dXMvbmQvZGV2aWNlcy9ubWVtNi9uZml0L3NlcmlhbDoweDEyMmY4MjFlDQovc3lzL2J1cy9uZC9k
ZXZpY2VzL25tZW03L25maXQvc2VyaWFsOjB4MTIyZjgxOWINCi9zeXMvYnVzL25kL2RldmljZXMv
bm1lbTgvbmZpdC9zZXJpYWw6MHgxMjJmODFhMg0KL3N5cy9idXMvbmQvZGV2aWNlcy9ubWVtOS9u
Zml0L3NlcmlhbDoweDEyMmY4MTk4DQovc3lzL2J1cy9uZC9kZXZpY2VzL25tZW0xMC9uZml0L3Nl
cmlhbDoweDEyMmY4MTkzDQovc3lzL2J1cy9uZC9kZXZpY2VzL25tZW0xMS9uZml0L3NlcmlhbDow
eDEyMmY3ZjU4DQovc3lzL2J1cy9uZC9kZXZpY2VzL25tZW0xMi9uZml0L3NlcmlhbDoweDEyMmY4
MWNiDQovc3lzL2J1cy9uZC9kZXZpY2VzL25tZW0xMy9uZml0L3NlcmlhbDoweDEyMmY4MTgxDQov
c3lzL2J1cy9uZC9kZXZpY2VzL25tZW0xNC9uZml0L3NlcmlhbDoweDEyMmY4MjEwDQovc3lzL2J1
cy9uZC9kZXZpY2VzL25tZW0xNS9uZml0L3NlcmlhbDoweDEyMmY4MjFmDQoNCmFuZCB0aGlzIHNl
dCBvZiByZWd1bGFyIERJTU1zOg0KMzk2ODUxQjQNCjM5NjgxMzRDDQozOTY4NTJEQQ0KMzk2ODUw
QUINCjM5Njg1QTEzDQozOTY4NTMxNw0KMzk2ODUyREQNCjM5Njg1MkQ5DQoNCk9mIHRoZSBwb3Nz
aWJsZSBhcHByb2FjaGVzIGZvciB0aGUgc3lzZnMgbmZpdCBmaWVsZCBkZWNvZGVzOg0KZml4ZWQg
YmlnLWVuZGlhbjoNCiAgbWF0Y2hlcyBwcmludGVkIGxhYmVsIGNvbnRlbnQgKHRleHQgYW5kIGJh
cmNvZGUpDQogIG1hdGNoZXMgQUNQSSBkaXNwbGF5IGFkdmljZSBmb3IgbWFuYWdlbWVudCB0b29s
cw0KICBwcm9iYWJseSBtYXRjaGVzIFNNQklPUyBTZXJpYWwgTnVtYmVyIHN0cmluZyBmb3JtYXQg
KGFsdGhvdWdoDQogICAgdGhhdCBkZXBlbmRzIG9uIHRoZSBzeXN0ZW0gZmlybXdhcmUpDQogIHJl
cXVpcmVzIHVzZXIgdG8ga25vdyB0aGF0IHRoaXMgT1MgdXNlcyBiaWctZW5kaWFuDQogIGhhcyBi
ZWVuIHVwc3RyZWFtIGZvciBhIHdoaWxlIG5vdw0KZml4ZWQgbGl0dGxlLWVuZGlhbjoNCiAgaGFy
ZGVyIHRvIHNlZSB0aGF0IGNkODEyZjEyIG1hdGNoZXMgMTIyZjgxY2Qgc2VlbiBlbHNld2hlcmUN
CiAgaGFyZGVyIHRvIG5vdGljZSB0aGF0IEI0NTE2ODM5IGlzIGEgcGVlciBvZiA0QzEzNjgzOQ0K
ICBtaWdodCBtYXRjaCBvdGhlciBsaXR0bGUtZW5kaWFuLW9ubHkgT1Nlcw0KICByZXF1aXJlcyB1
c2VyIHRvIGtub3cgdGhhdCB0aGlzIE9TIHVzZXMgbGl0dGxlLWVuZGlhbg0KbmF0aXZlIGVuZGlh
bjoNCiAgbW9zdCBjb25mdXNpbmcNCiAgY29uZmlnL3N0YXR1cyBmaWxlcyByZWZlcmVuY2luZyB0
aGUgRElNTXMgYXJlIG5vdCBwb3J0YWJsZQ0KICByZXF1aXJlcyB1c2VyIHRvIGtub3cgdGhhdCB0
aGlzIE9TIHVzZXMgbmF0aXZlIGVuZGlhbm5lc3MNCiAgcmVxdWlyZXMgdXNlciB0byBrbm93IHRo
ZSBDUFUgZW5kaWFubmVzcw0KICB3YXMgdXBzdHJlYW0gc2V2ZXJhbCB5ZWFycyBhZ28NCg0KDQo=
