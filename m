Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62827C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D58D208A6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D58D208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeHVUQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:16:55 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:18301 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbeHVUQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:16:55 -0400
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id BC46A301F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 16:51:16 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (g1w8108.austin.hp.com [16.193.72.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 0F8F4B5;
        Wed, 22 Aug 2018 16:51:16 +0000 (UTC)
Received: from G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) by
 G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 22 Aug 2018 16:51:16 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.11) by
 G4W9119.americas.hpqcorp.net (16.210.20.214) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 22 Aug 2018 16:51:15 +0000
Received: from TU4PR8401MB0382.NAMPRD84.PROD.OUTLOOK.COM (10.169.42.148) by
 TU4PR8401MB0941.NAMPRD84.PROD.OUTLOOK.COM (10.169.46.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.24; Wed, 22 Aug 2018 16:51:14 +0000
Received: from TU4PR8401MB0382.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5df9:92f5:7a37:fb94]) by TU4PR8401MB0382.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5df9:92f5:7a37:fb94%4]) with mapi id 15.20.1080.010; Wed, 22 Aug 2018
 16:51:14 +0000
From:   "Ernst, Justin" <justin.ernst@hpe.com>
To:     "minyard@acm.org" <minyard@acm.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Anderson, Russ" <russ.anderson@hpe.com>
Subject: RE: [PATCH] Remove redundant cleanup in ipmi_register_smi
Thread-Topic: [PATCH] Remove redundant cleanup in ipmi_register_smi
Thread-Index: AQHUOWLsYaGrtB8V5kqWq3RHz4zJhqTL90+AgAACjbA=
Date:   Wed, 22 Aug 2018 16:51:14 +0000
Message-ID: <TU4PR8401MB0382843799568DCB93E5F2D087300@TU4PR8401MB0382.NAMPRD84.PROD.OUTLOOK.COM>
References: <20180821152534.30367-1-justin.ernst@hpe.com>
 <42513566-6982-c9c4-dbbb-ed98bd332fe9@gmail.com>
In-Reply-To: <42513566-6982-c9c4-dbbb-ed98bd332fe9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=justin.ernst@hpe.com; 
x-originating-ip: [15.203.227.12]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TU4PR8401MB0941;6:mJcytFDeegxdk8keX0Z8jZqna0D55/oqcgMoS9XgO90+spoXljukf1om5NhfoUHeui17yQjwTCOZTMQ/tFQovmAWPguMoRONK9zSqh7oQW1MV9o2Vkhb7wSg7a0UJ4OLQ4hxtvDeiWPfPL3MWyw4vSBSxssMdUUSnqjpd4OQy3pfO8fjTggDQ18HBdPr2vjqOkVLZmRcbMgNpqxXHwMUK9DMKFora2IMtqPu2Hn5JX0cU7f5QWQlEOGZ+0mSzECJB/ssd/E8PvtMla/+myyMaB3H/R9G1hUjFgBzkeDJ9a4fiRyQSU15UVjlYMbhbmw0FEGquM0GZEbZ7symcKhNcI2IlBG9oOwpPOt4HYogmo8u7TvdfXJk3NysukJ5jZ1Y3HFADyD8oVgnXJhVwvhjzHteIbFm4mjmvvXNqDOHAHcWYfCGvv5dYuANznDu+dfx9SJUnQe+BjBwrVgSraLuUQ==;5:dXjWFaAry0PIj1VMUZt1YT8btwbwrDVIfwJwliOtVBOEzsUWffBsmfEIPVolA0LnlifNyfP6jUPnjgKADyd25ppRgjjic52WNciWKUU+XvNvPEuEx/CoAylRp1nXUr1gqg8eo6XPaDcx0hzBtFr58TsuiasO8x2LB/1u+LTe5GI=;7:tRQ5D/eMMczkhIByhei3C7xRBt2J7wXHG7MPx6MO351AQ73MLd1KRuUCOvbMPeRmIq4yt6vFSPVSyID8ON7ld9eq3Gxu9PPM0mg+xLqUBXFV58UFLCuWslP+cNgk5DKijyFKp/Y3N0EfKRLrYHlRWtkup/ysC59+t1qODZHRdiyoR9NrETzo7ykCzfhMbQPjJDW2QHfsVqbS1AdvIsfGR9e2KbR0/JtEDFYGdRQ/HzcNBX0+p04PQa2b8hQVG0Xw
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(39860400002)(366004)(13464003)(189003)(199004)(51914003)(4326008)(11346002)(9686003)(446003)(6116002)(3846002)(25786009)(55016002)(66066001)(2906002)(6916009)(575784001)(5640700003)(6246003)(6436002)(5660300001)(86362001)(2501003)(486006)(316002)(1730700003)(76176011)(97736004)(81156014)(74316002)(26005)(33656002)(7696005)(476003)(229853002)(7736002)(68736007)(305945005)(14444005)(14454004)(8936002)(186003)(99286004)(5250100002)(256004)(102836004)(2351001)(478600001)(54906003)(6506007)(106356001)(53936002)(2900100001)(8676002)(53546011)(105586002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0941;H:TU4PR8401MB0382.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 406fa107-cadd-4a8b-643c-08d6084f78dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TU4PR8401MB0941;
x-ms-traffictypediagnostic: TU4PR8401MB0941:
x-microsoft-antispam-prvs: <TU4PR8401MB09418E3C6ADE7F281D26E43F87300@TU4PR8401MB0941.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(143289334528602)(227479698468861)(9452136761055)(85827821059158)(42262312472803)(213716511872227)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:TU4PR8401MB0941;BCL:0;PCL:0;RULEID:;SRVR:TU4PR8401MB0941;
x-forefront-prvs: 0772E5DAD5
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Gwb1xWK6cPsjTSBBZqb/OqoNM67ELUJWwS5rUmODsvNmJOjSJOVj5Ad6GXx8euaqhb/+kb+FefG9ysgr9i9YKNhm4X3+NYpBRahztZHASWMASV/ETzF7NLhHVleMJruU+49alIL26jFeeh0aIDLyXGMpqo/0WRdTjhM3UUWIN5ZeHklloxiBjg/OI1AUo2PM419WBVwLcebFCXrfUBvezg8Qu0YhoRMDL2CC7SYtRW2wwMq993+kT92WQN23ChQ6JHoHlT5Rj871jF3ThnuyTiCQuzB/EbFqTY/WLtBNpqooZqOUMtbzSsw5BiPUsizj9dDkAkgiH/XIQmJxI2C+cd+wHxpaNA4kQseqAbo8SaM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 406fa107-cadd-4a8b-643c-08d6084f78dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2018 16:51:14.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0941
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENvcmV5IE1pbnlhcmQgW21h
aWx0bzp0Y21pbnlhcmRAZ21haWwuY29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyMiwg
MjAxOCAxMToyOCBBTQ0KPiBUbzogRXJuc3QsIEp1c3RpbiA8anVzdGluLmVybnN0QGhwZS5jb20+
OyBDb3JleSBNaW55YXJkDQo+IDxtaW55YXJkQGFjbS5vcmc+DQo+IENjOiBBcm5kIEJlcmdtYW5u
IDxhcm5kQGFybmRiLmRlPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz47IEplcmVteSBLZXJyIDxqa0BvemxhYnMub3JnPjsgb3BlbmlwbWktDQo+IGRl
dmVsb3BlckBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IEFuZGVyc29uLA0KPiBSdXNzIDxydXNzLmFuZGVyc29uQGhwZS5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIFJlbW92ZSByZWR1bmRhbnQgY2xlYW51cCBpbiBpcG1pX3JlZ2lzdGVyX3Nt
aQ0KPiANCj4gT24gMDgvMjEvMjAxOCAxMDoyNSBBTSwgSnVzdGluIEVybnN0IHdyb3RlOg0KPiA+
IFdoZW4gaXBtaV9yZWdpc3Rlcl9zbWkgZmFpbHMsIGl0IHBlcmZvcm1zIGEgc21hbGwgY2xlYW51
cCByb3V0aW5lDQo+ID4gYmVmb3JlIHJldHVybmluZyBpdHMgZXJyb3IgdmFsdWUuIEluIHRyeV9z
bWlfaW5pdCwgb24gdGhlIGNvbmRpdGlvbg0KPiA+IHRoYXQgaXBtaV9yZWdpc3Rlcl9zbWkgZmFp
bHMsIGlwbWlfdW5yZWdpc3Rlcl9zbWkgaXMgY2FsbGVkLg0KPiA+IGlwbWlfdW5yZWdpc3Rlcl9z
bWkgcGVyZm9ybXMgdGhlIHNhbWUgY2xlYW51cCByb3V0aW5lIGFzDQo+ID4gaXBtaV9yZWdpc3Rl
cl9zbWkuIFRoaXMgcmVzdWx0cyBpbiBhIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Uu
DQo+ID4gUmVtb3ZpbmcgdGhlIGNsZWFudXAgcm91dGluZSBpbiBpcG1pX3JlZ2lzdGVyX3NtaSBy
ZXN1bHRzIGluIHByb3Blcg0KPiBjbGVhbnVwIG9mIGEgaXBtaV9yZWdpc3Rlcl9zbWkgZmFpbHVy
ZS4NCj4gDQo+IFRoaXMgaXMgYWxtb3N0IGNlcnRhaW5seSB3cm9uZy7CoCBJZiBpcG1pX3JlZ2lz
dGVyX3NtaSgpIGZhaWxzLCB0aGUgY2FsbGluZyBjb2RlDQo+IHNob3VsZG4ndCBjYWxsIGlwbWlf
dW5yZWdpc3Rlcl9zbWkoKS4NCj4gDQo+IEhvd2V2ZXIsIEkgdGhpbmsgSSBrbm93IHdoYXQgaXMg
Z29pbmcgd3JvbmcuwqAgaXBtaV9yZWdpc3Rlcl9zbWkoKSBjYW4gZmFpbA0KPiBhZnRlciB0aGUg
aW50ZXJmYWNlIGlzIGluaXRpYWxpemVkLCBpZiBzbyB0aGUgcmVnaXN0ZXJpbmcgY29kZSB3aWxs
IHRoaW5rIGl0IGlzDQo+IHJlZ2lzdGVyZWQgYW5kIGNhbGwgaXBtaV91bnJlZ2lzdGVyX3NtaSgp
IG9uIGEgZmFpbHVyZS7CoCBJJ2xsIHNlbmQgYSBwYXRjaCBmb3INCj4gdGhpcy4NCj4gDQo+IC1j
b3JleQ0KDQpUaGFua3MgZm9yIHRoZSByZXBseSBDb3JleS4gSSBhZ3JlZSB3aXRoIHdoYXQgeW91
IGhhdmUgc3RhdGVkLiBJJ2xsIGJlIHdhdGNoaW5nIGZvciB0aGUgcGF0Y2guDQotSnVzdGluDQoN
Cj4gDQo+ID4NCj4gPiBDYzogQ29yZXkgTWlueWFyZCA8bWlueWFyZEBhY20ub3JnPg0KPiA+IENj
OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+IENjOiBHcmVnIEtyb2FoLUhhcnRt
YW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiA+IENjOiBKZXJlbXkgS2VyciA8amtA
b3psYWJzLm9yZz4NCj4gPiBDYzogb3BlbmlwbWktZGV2ZWxvcGVyQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldA0KPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gQ2M6IFJ1c3Mg
QW5kZXJzb24gPHJ1c3MuYW5kZXJzb25AaHBlLmNvbT4NCj4gPiBBY2tlZC1ieTogQW5kcmV3IEJh
bm1hbiA8YWJhbm1hbkBocGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEp1c3RpbiBFcm5zdCA8
anVzdGluLmVybnN0QGhwZS5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2NoYXIvaXBtaS9p
cG1pX21zZ2hhbmRsZXIuYyB8IDEwICsrKysrLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jaGFyL2lwbWkvaXBtaV9tc2doYW5kbGVyLmMNCj4gPiBiL2RyaXZlcnMvY2hhci9pcG1p
L2lwbWlfbXNnaGFuZGxlci5jDQo+ID4gaW5kZXggNTE4MzJiOGEyYzYyLi4zYjBiNTBjNGYwNjQg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jaGFyL2lwbWkvaXBtaV9tc2doYW5kbGVyLmMNCj4g
PiArKysgYi9kcml2ZXJzL2NoYXIvaXBtaS9pcG1pX21zZ2hhbmRsZXIuYw0KPiA+IEBAIC0zMzk1
LDEyICszMzk1LDEyIEBAIGludCBpcG1pX3JlZ2lzdGVyX3NtaShjb25zdCBzdHJ1Y3QNCj4gPiBp
cG1pX3NtaV9oYW5kbGVycyAqaGFuZGxlcnMsDQo+ID4NCj4gPiAgICBvdXQ6DQo+ID4gICAJaWYg
KHJ2KSB7DQo+ID4gLQkJaXBtaV9ibWNfdW5yZWdpc3RlcihpbnRmKTsNCj4gPiAtCQlsaXN0X2Rl
bF9yY3UoJmludGYtPmxpbmspOw0KPiA+ICsJCS8qDQo+ID4gKwkJICogaXBtaV91bnJlZ2lzdGVy
X3NtaSBtdXN0IGJlIGNhbGxlZCB0byBjbGVhbiB1cCBhZnRlcg0KPiA+ICsJCSAqIGZhaWx1cmUu
IFdlIHVubG9jayB0aGUgbXV0ZXggdG8gYWxsb3cgaXBtaV91bnJlZ2lzdGVyX3NtaQ0KPiA+ICsJ
CSAqIHRvIGxvY2sgaXQgYW5kIHBlcmZvcm0gY2xlYW51cC4NCj4gPiArCQkgKi8NCj4gPiAgIAkJ
bXV0ZXhfdW5sb2NrKCZpcG1pX2ludGVyZmFjZXNfbXV0ZXgpOw0KPiA+IC0JCXN5bmNocm9uaXpl
X3NyY3UoJmlwbWlfaW50ZXJmYWNlc19zcmN1KTsNCj4gPiAtCQljbGVhbnVwX3NyY3Vfc3RydWN0
KCZpbnRmLT51c2Vyc19zcmN1KTsNCj4gPiAtCQlrcmVmX3B1dCgmaW50Zi0+cmVmY291bnQsIGlu
dGZfZnJlZSk7DQo+ID4gICAJfSBlbHNlIHsNCj4gPiAgIAkJLyoNCj4gPiAgIAkJICogS2VlcCBt
ZW1vcnkgb3JkZXIgc3RyYWlnaHQgZm9yIFJDVSByZWFkZXJzLiAgTWFrZQ0KPiANCg0K
