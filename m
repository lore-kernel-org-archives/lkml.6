Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7C0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495B720898
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="PkiDsPSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495B720898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeH2Lhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:37:31 -0400
Received: from mail-eopbgr710073.outbound.protection.outlook.com ([40.107.71.73]:40880
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727072AbeH2Lhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tym9i1SDiWl8av8W/5QCkBK3f6ptWLCSrgmoDYiDE2M=;
 b=PkiDsPSRJNpumyT7ewcQkFK3upbw9ikPW6ZcDYSx8Eroh7Ti2jOnqOmReWAmp3WG8jA8OclSTXtOFMGYNKpua6hrbLZRdqkQOqgMWS3o3tveqnVaMmn0Um8fGHFRlFACwYtPzB9zFrA8qCBRLdPseGvzR2iuoTpwA/97HITB85Y=
Received: from BYAPR07MB5144.namprd07.prod.outlook.com (20.176.254.209) by
 BYAPR07MB4744.namprd07.prod.outlook.com (52.135.205.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Wed, 29 Aug 2018 07:41:54 +0000
Received: from BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99]) by BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99%4]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 07:41:54 +0000
From:   Przemyslaw Gaj <pgaj@cadence.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     vitor <Vitor.Soares@synopsys.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Thread-Topic: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Thread-Index: AQHUH3VT99XuaYWr3kWHpjq9POOKYqTML50AgALgfQCAAFeJAIAABncAgAXdiQCAAANWgIAAMGEA///gIQCAAVqhAA==
Date:   Wed, 29 Aug 2018 07:41:53 +0000
Message-ID: <BC0C856B-BC5C-4404-8DEC-075FC84312B7@cadence.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
 <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon>
 <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon>
 <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
 <20180828150114.2a816c4a@bbrezillon>
In-Reply-To: <20180828150114.2a816c4a@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgaj@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4744;20:9YAH3ELwo/hVArsLXIARh9BbWfSI5eAcyoVbuFFhi7hf0Ck0S1pT1MtqmroAwxcSesJeZtRKwKnrlqL5rVGvFwS/9M3KMRE0FJS69LMFayAAKcOkksPd0hn8uyfld7liLd11Mr/zjD6FEZDXIqjCVwYEFJJ7soLQbHkzoOngrZUFnlopsR0jENGoNr+p+p2MWP9Nx5r5/xtkyNJGYNb1Vm3xAjn88yDmf6SLlxcA/ApNXy8eJsh7Tye1wfaTo9d9
x-ms-office365-filtering-correlation-id: 1172f6df-6dd5-404f-0586-08d60d82e405
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4744;
x-ms-traffictypediagnostic: BYAPR07MB4744:
x-microsoft-antispam-prvs: <BYAPR07MB47444A4BCFE93A8111AD7D8BC2090@BYAPR07MB4744.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(60795455431006)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR07MB4744;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4744;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(52314003)(36092001)(52164004)(189003)(199004)(51444003)(478600001)(6436002)(6916009)(54906003)(6506007)(53546011)(6486002)(53936002)(5660300001)(14454004)(97736004)(14444005)(6512007)(256004)(4326008)(25786009)(82746002)(99286004)(7416002)(6246003)(83716003)(305945005)(93886005)(229853002)(7736002)(76176011)(33656002)(81166006)(81156014)(36756003)(8936002)(106356001)(6116002)(3846002)(86362001)(2906002)(446003)(11346002)(68736007)(476003)(2616005)(186003)(26005)(105586002)(102836004)(316002)(66066001)(2900100001)(5250100002)(486006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4744;H:BYAPR07MB5144.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VAB834hxYpFUadWQWZXTM0NoSe+Y52bjyJE2PDW+QUD6bB6HX+8IbRf6E0z2qsxF0QTMW2nP7hQlHYygH9hKCSg9wrJDqn7OTAjrJyBGcy3+d5hKuQUFuS08Hv8KMl2stP9ICoKVIW23zCWdygcgMlxEINx95HXEc9p+BH5FRqzsQmIppmcyiVH2w0qmli6k74NZLq4PtjsJ1M3Zm8hwtKKUR6OP9qVL1HuIiaaXvbpYGR1KsiBOBCwblF8IdJPvoO7lGgTsVSGVTKqku6cr9z57RknX4J5XszLAkpBVrMsLFz+QOGmE7+NzcBRxXTEH7N19ZkD8CHK3Fe4KutykAssfWpuclbTkubv50Yawm1E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAD3960BB6FE7848AF2F5863AF1963B0@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1172f6df-6dd5-404f-0586-08d60d82e405
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 07:41:54.0106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCu+7v09uIDgvMjgvMTgsIDM6MDEgUE0sICJCb3JpcyBCcmV6aWxsb24iIDxi
b3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+IHdyb3RlOg0KDQogICAgRVhURVJOQUwgTUFJTA0K
ICAgIA0KICAgIA0KICAgIEhpIFByemVtZWssDQogICAgDQogICAgT24gVHVlLCAyOCBBdWcgMjAx
OCAxMjo1NToyMCArMDAwMA0KICAgIFByemVteXNsYXcgR2FqIDxwZ2FqQGNhZGVuY2UuY29tPiB3
cm90ZToNCiAgICANCiAgICA+IEhpIFZpdG9yLA0KICAgID4gDQogICAgPiBJIGhhdmUgYWxyZWFk
eSBpbXBsZW1lbnRlZCBNYXN0ZXJzaGlwIHJlcXVlc3QvaGFuZG92ZXIgYnV0IHdlIGFyZSB3YWl0
aW5nIGZvciBCb3Jpc+KAmXMgcGF0Y2ggdG8gYmUgYWNjZXB0ZWQgYW5kIG1lcmdlZC4gQW55d2F5
LCBteSBjb21tZW50cyBiZWxvdy4NCiAgICA+IA0KICAgID4gT24gOC8yOC8xOCwgMjowMiBQTSwg
IkJvcmlzIEJyZXppbGxvbiIgPGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbT4gd3JvdGU6DQog
ICAgPiANCiAgICA+ICAgICBFWFRFUk5BTCBNQUlMDQogICAgPiAgICAgDQogICAgPiAgICAgDQog
ICAgPiAgICAgSGkgVml0b3IsDQogICAgPiAgICAgDQogICAgPiAgICAgT24gVHVlLCAyOCBBdWcg
MjAxOCAxMjo1MDoxMiArMDEwMA0KICAgID4gICAgIHZpdG9yIDxWaXRvci5Tb2FyZXNAc3lub3Bz
eXMuY29tPiB3cm90ZToNCiAgICA+ICAgICANCiAgICA+ICAgICA+IEhpIEJvcmlzLA0KICAgID4g
ICAgID4gDQogICAgPiAgICAgPiBUaGUgRFQgQmluZGluZ3Mgc2F5ICJUaGUgbm9kZSBkZXNjcmli
aW5nIGFuIEkzQyBidXMgc2hvdWxkIGJlIG5hbWVkIA0KICAgID4gICAgID4gaTNjLW1hc3Rlci4i
LiBEbyB5b3UgaGF2ZSBhIGZpZWxkIGZvciBzZWNvbmRhcnkgbWFzdGVyPyAgDQogICAgPiANCiAg
ICA+IEkgdGhpbmsgd2UgZG9u4oCZdCBuZWVkIHNlcGFyYXRlIGZpZWxkIGZvciBzZWNvbmRhcnkg
bWFzdGVyLiBNYWluIGFuZCBzZWNvbmRhcnkgbWFzdGVycyANCiAgICA+IHN1cHBvcnQgc2ltaWxh
ciBmdW5jdGlvbmFsaXRpZXMuIEl04oCZcyBlbm91Z2ggdG8gaGF2ZSB0aGlzIHN0YXRlIGludGVy
bmFsbHkgYW5kIGRvIG1hc3RlcnNoaXAgaXQgaXQncyBuZWVkZWQuDQogICAgPiANCiAgICA+ICAg
ICA+IA0KICAgID4gICAgID4gT24gMjQtMDgtMjAxOCAxOToxNiwgQm9yaXMgQnJlemlsbG9uIHdy
b3RlOiAgDQogICAgPiAgICAgPiA+IFdlbGwsIGJlZm9yZSBldmVuIGNvbnNpZGVyaW5nIHN1cHBv
cnRpbmcgc2Vjb25kYXJ5IG1hc3RlciByZWdpc3RyYXRpb24sDQogICAgPiAgICAgPiA+IHdlIG5l
ZWQgdG8gaGFuZGxlIG1hc3RlcnNoaXAgaGFuZG92ZXIuIEFzIGZvciB0aGUgREFBIG9wZXJhdGlv
biwgaXQncw0KICAgID4gICAgID4gPiBsaWtlbHkgdG8gYmUgaG9zdCBzcGVjaWZpYywgc28gd2Un
bGwgaGF2ZSB0byBhZGQgYSBuZXcgaG9vayB0byB0aGUNCiAgICA+ICAgICA+ID4gaTNjX21hc3Rl
cl9jb250cm9sbGVyX29wcyBzdHJ1Y3QuICAgIA0KICAgID4gICAgID4gRG8geW91IG1lYW4gd2hl
biBtYXN0ZXIgdHJ5IHRvIGRlbGVnYXRlIHRoZSBidXMgb3duZXJzaGlwIHRocm91Z2ggDQogICAg
PiAgICAgPiBHRVRBQ0NNU1Q/IG9yIHRvIGdldCB0aGUgYnVzIG93bmVyc2hpcCB3aXRoIElCSS1N
Uj8gIA0KICAgID4gICAgIA0KICAgID4gICAgIEkgdGhpbmsgd2UgbmVlZCB0byBzdXBwb3J0IGJv
dGguDQogICAgPiANCiAgICA+IEkgYWdyZWUuDQogICAgPiAgICAgDQogICAgPiAgICAgPiANCiAg
ICA+ICAgICA+IEkgdGhpbmsgdGhhdCBjb3VsZCBiZSB1c2VmdWwgdG8gcGFzcyB0aGUgaWJpIHR5
cGUgb24gcmVxdWVzdF9pYmkoKSwgDQogICAgPiAgICAgPiB0aGVyZSBpcyBzb21lIGNhc2Ugd2hl
cmUgdGhlIG1hc3RlciBkb2Vzbid0IHN1cHBvcnQgSUJJLU1SLiAgDQogICAgPiAgICAgDQogICAg
PiAgICAgQWN0dWFsbHksIEkgd2FzIHBsYW5uaW5nIG9uIG1ha2luZyBpdCBjb21wbGV0ZWx5IHNl
cGFyYXRlIGZyb20NCiAgICA+ICAgICByZWd1bGFyIHNsYXZlIElCSXMuIFRoYXQgaXMsIHRoZSBt
YXN0ZXIgY29udHJvbGxlciBkcml2ZXIgd291bGQgZGVtdXgNCiAgICA+ICAgICB0aGUgc2xhdmUs
IE1SIGFuZCBIb3QgSm9pbiBJQklzLCBhbmQgaWYgdGhlcmUncyBhbiBNUiByZXF1ZXN0LCBxdWV1
ZSBhDQogICAgPiAgICAgbWFzdGVyc2hpcCBoYW5kb3ZlciB3b3JrIHRvIHRoZSB3b3JrcXVldWUg
KHByZXR0eSBtdWNoIHdoYXQgd2UgZG8gZm9yDQogICAgPiAgICAgSG90LUpvaW4gYWxyZWFkeSku
IE1hc3RlcnNoaXAgaGFuZG92ZXIgaXMgYW55d2F5IGxpa2VseSB0byBiZSBJUA0KICAgID4gICAg
IHNwZWNpZmljLCBzbyBJIGRvbid0IHRoaW5rIHRoZXJlJ3MgYSBuZWVkIHRvIG1ha2UgaXQgbG9v
ayBsaWtlIGENCiAgICA+ICAgICByZWd1bGFyIElCSS4NCiAgICA+IA0KICAgID4gSSB0aGluayBp
dCdzIGJldHRlciB0byBoYXZlIHNlcGFyYXRlIGZ1bmN0aW9uIHRvIGRvIG1hc3RlcnNoaXAgcmVx
dWVzdC4NCiAgICA+ICAgICANCiAgICA+ICAgICBSZWdhcmRpbmcgd2hldGhlciBJQkktTVIgc3Vw
cG9ydCBzaG91bGQgYmUgZXhwb3NlZCB0byB0aGUgSTNDIGZyYW1ld29yaw0KICAgID4gICAgIG9y
IG5vdCBkZXBlbmRzIG9uIGhvdyBtdWNoIHdpbGwgYmUgYXV0b21hdGVkIG9uIHRoZSBmcmFtZXdv
cmsgc2lkZS4gSQ0KICAgID4gICAgIGRvbid0IHRoZSBhbnN3ZXIgeWV0LCBidXQgdGhhdCdzIHBy
b2JhYmx5IHNvbWV0aGluZyB3aWxsIGZpZ3VyZSBvdXQNCiAgICA+ICAgICBhbG9uZyB0aGUgcm9h
ZC4NCiAgICA+IA0KICAgID4gTXkgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBpczogd2hlbiByZXF1
ZXN0X21hc3RlcnNoaXAgZmllbGQgDQogICAgPiBvZiBpM2NfbWFzdGVyX2NvbnRyb2xsZXJfb3Bz
IHN0cnVjdHVyZSBpcyBzZXQsIG1hc3RlciBkcml2ZXIgc3VwcG9ydHMgbWFzdGVyc2hpcCByZXF1
ZXN0cy4NCiAgICA+IFRoYXQncyBob3cgSSBjaGVjayBpZiB0aGlzIGlzIHN1cHBvcnRlZCBvciBu
b3QuDQogICAgDQogICAgQ2FuIHlvdSBtYXliZSBob3N0IHlvdXIgY29kZSBvbiBhIHB1YmxpYyBy
ZXBvIChJIGNhbiBwdXNoIGl0IGZvciB5b3UgaWYNCiAgICBuZWVkZWQpIHNvIHRoYXQgeW91IGFu
ZCBWaXRvciBjYW4gc3RhcnQgZGlzY3Vzc2luZyBpbXBsZW1lbnRhdGlvbg0KICAgIGRldGFpbHMu
DQoNClN1cmUhIFBsZWFzZSBnaXZlIG1lIHNvbWUgdGltZS4gSSdsbCB0cnkgdG8gZG8gaXQgdGhp
cyB3ZWVrIG9yIGVhcmx5IG5leHQgd2Vlay4NCiAgICANCiAgICBUaGFua3MsDQogICAgDQogICAg
Qm9yaXMNCiAgICANClRoYW5rcywNClByemVtZWsNCg0K
