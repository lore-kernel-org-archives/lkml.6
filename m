Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1992C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0E2205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="U6jiYolm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0E2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeIFRTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:19:01 -0400
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:52736
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727609AbeIFRTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6UdJ9TVAcPF2t1SAUtY7izs09EW56dS26OvOGkRtAE=;
 b=U6jiYolmza/dhzkQ52S0hTa15WREtG+RbG3rL8q12mBvKy2BwYiofnfJ60tuvjKg4lPo4fxgLj68SETrl7B6lBPHk8IA8LpqVlQ6V3lB+jxxGw3k9rqbAqNBfnKk29DskHKoBr6tW9mSLBD/5zCx4r8wkxmT1YSROpsekMQ6sLs=
Received: from BYAPR07MB5144.namprd07.prod.outlook.com (20.176.254.209) by
 BYAPR07MB4983.namprd07.prod.outlook.com (52.135.238.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 12:43:35 +0000
Received: from BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99]) by BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99%4]) with mapi id 15.20.1122.009; Thu, 6 Sep 2018
 12:43:35 +0000
From:   Przemyslaw Gaj <pgaj@cadence.com>
To:     vitor <Vitor.Soares@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
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
Thread-Index: AQHUH3VT99XuaYWr3kWHpjq9POOKYqTML50AgALgfQCAAFeJAIAABncAgAXdiQCAAANWgIAAMGEAgAMUiwCAAHYxAIAFiUGAgAUNtQA=
Date:   Thu, 6 Sep 2018 12:43:34 +0000
Message-ID: <25862F03-9823-42B0-87AC-AE36D7E9C780@cadence.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
 <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon>
 <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon>
 <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
 <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com>
 <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
 <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com>
In-Reply-To: <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgaj@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4983;20:XISMk+Bemo02imy6ngfovQWfixbUr7yakh3nSxAcetn+sp5f1uD0FipjWdqpPF2uxzA19S+e3qdkZGdOMpIBdRComMqZKUNPpULxVNuFeLlW1VRpvaNzLSly4vzJT7wNF6RFKXmyoVUYKSgLUSsdmT5OCSmSlk5xkV5z7Ex6B2jRJ5NL2n9SZ7co7xGro9fOmFCjZNGZSIT4NPS7uCuqme3FrU22VPzHlZ5J8hg8WlFigxI3LJ/oe98nVhcGmqS0
x-ms-office365-filtering-correlation-id: af8344f6-f9b7-4649-5f44-08d613f65c5b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4983;
x-ms-traffictypediagnostic: BYAPR07MB4983:
x-microsoft-antispam-prvs: <BYAPR07MB4983B4AE73AF689B462E95B4C2010@BYAPR07MB4983.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:BYAPR07MB4983;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4983;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(376002)(39860400002)(36092001)(52164004)(189003)(199004)(54014002)(106356001)(83716003)(33656002)(105586002)(99286004)(82746002)(102836004)(6306002)(76176011)(2900100001)(53936002)(97736004)(6512007)(316002)(26005)(54906003)(229853002)(256004)(14444005)(110136005)(7416002)(6436002)(2906002)(186003)(575784001)(86362001)(478600001)(6486002)(5660300001)(476003)(446003)(7736002)(68736007)(11346002)(966005)(8936002)(25786009)(2616005)(81166006)(81156014)(93886005)(486006)(36756003)(66066001)(8676002)(6246003)(53546011)(6506007)(4326008)(5250100002)(305945005)(6116002)(3846002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4983;H:BYAPR07MB5144.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AmUW1oREtI9Di0xAlQI6cvIWpVcZaNFdwKgeNj3HgED940NvBlZY+5LiOKvOQyFzWrOPj25zvtOVgyk+65VTPCLlP07vETnC9z+NlR+SOr5u9F4Bd/g/TgQj10HczNBPVtlqOdbQePkdLRgOYPqUKX6UgWHdUjhD4s7jIv14JG1R+IuP8IhwvTUQeajGlpdbv0bU6ziq+Tq4j+/kiuFxf/QcYj1caSIgLq1sgWljappY4qmSHkW26hZj67Hs9ulWax9dalwHbn4r5OnGvIZotS0S+v8ZBqAWQaGo13DvoQH5ahSgufb1/S5MxI2FVARqobG7+VSwGVbCdHop1p1bPvj1j2NhLJwFGKBDoqqJTg8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E3F596F73557C478F42D82B97D172DD@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8344f6-f9b7-4649-5f44-08d613f65c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 12:43:34.7945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4983
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsIFZpdG9yLA0KDQpUaGlzIHJlcG9zaXRvcnkgZG9lcyBub3QgY29udGFpbiBmdWxs
IGtlcm5lbCBzb3VyY2VzLCBidXQgaXQgc2hvdWxkIGJlIGVub3VnaCB0byBkaXNjdXNzIG1hc3Rl
cnNoaXAgcmVxdWVzdCBmZWF0dXJlLiANCmh0dHBzOi8vZ2l0aHViLmNvbS9wcnplbWVrZ2FqL2kz
Yy1saW51eC9jb21taXQvZDU0ZmU2OGE5ZDNlNTczYzBjNDU0YTJjNmYxYWZhZmMyMDE0MmVjNQ0K
DQpQbGVhc2Uga2VlcCBpbiBtaW5kIHRoYXQgdGhpcyBpcyBpbml0aWFsIHZlcnNpb24sIGJ1dCBt
YXN0ZXJzaGlwIHdvcmtzIGNvcnJlY3RseS4gSSBhZGRlZCBvbmUgcHJvcGVydHkgdG8gRFQgdG8g
cmVmbGVjdCByZWxhdGlvbnNoaXAgYmV0d2VlbiBtYXN0ZXJzLg0KSXQgaXMgcG9zc2libGUgdG8g
cmVxdWVzdCBtYXN0ZXJzaGlwIG9uIGRlbWFuZCAodXNpbmcgc3lzZnMuIFVzZWZ1bCBpbiBjYXNl
IHdoZW4gTGludXggbWFjaGluZSBpcyBlcXVpcHBlZCBvbmx5IHdpdGggc2Vjb25kYXJ5IG1hc3Rl
ciBjb250cm9sbGVyKSBvciBhdXRvbWF0aWNhbGx5IGNoYW5nZSBvcGVyYXRpb24gbW9kZSB3aGVu
IGRldmljZSBkcml2ZXIgd2FudHMgdG8gcmVhZC93cml0ZSBzb21ldGhpbmcgZnJvbS90byBkZXZp
Y2UuDQoNCkknbSBzdXJlIEkgd2lsbCBoYXZlIHRvIHJld29yayBzb21ldGhpbmcgYmVjYXVzZSB0
aGlzIHdhcyBpbXBsZW1lbnRlZCBvbiBzb3VyY2VzIGZyb20gUEFUQ0ggdjQuIEkgc2F3IHRoYXQg
Qm9yaXMgcmVsZWFzZWQgdjcgeWVzdGVyZGF5IDopDQoNClRoYW5rcywNClByemVtZWsNCg0K77u/
T24gOS8zLzE4LCAxMTozMyBBTSwgInZpdG9yIiA8Vml0b3IuU29hcmVzQHN5bm9wc3lzLmNvbT4g
d3JvdGU6DQoNCiAgICBFWFRFUk5BTCBNQUlMDQogICAgDQogICAgDQogICAgSGkgUHJ6ZW1laywN
CiAgICANCiAgICANCiAgICBPbiAzMC0wOC0yMDE4IDIwOjAwLCBQcnplbXlzbGF3IEdhaiB3cm90
ZToNCiAgICA+ICAgICAgU28sIHBlciBteSB1bmRlcnN0YW5kaW5nIHNpbmNlIHRoZSBNYWluIG1h
c3RlciBzdXBwb3J0IHRoZSBoYW5kLW9mZiBvZg0KICAgID4gICAgICB0aGUgYnVzIHlvdSBhY2Nl
cHQgYWxsIGluY29taW5nIE1SLCByaWdodD8gT3IgZG8geW91IGNoZWNrIGFsbCBkZXZpY2VzIEJD
Uj8NCiAgICA+DQogICAgPiBJJ20gbm90IHN1cmUgd2hhdCBkbyB5b3UgbWVhbiBoZXJlLiBNYXN0
ZXJzaGlwIHJlcXVlc3QoTVIpIGlzIGZyb20gc2Vjb25kYXJ5IG1hc3Rlcg0KICAgID4gdG8gY3Vy
cmVudCBtYXN0ZXIuIEN1cnJlbnQgbWFzdGVyIGNhbiBOQUNLIHRoaXMgcmVxdWVzdCBpZiBmb3Ig
ZXhhbXBsZSBpdCBjb21lcyBmcm9tDQogICAgPiB3cm9uZyBkZXZpY2UuIElmIGl0J3Mgb2ssIGN1
cnJlbnQgbWFzdGVyIHNlbmRzIEdFVEFDQ01TVCBjb21tYW5kIGFuZCBzZWNvbmRhcnkgbWFzdGVy
DQogICAgPiBtYXkgQUNLIG9yIE5BQ0sgdGhpcyBjb21tYW5kLiBJdCBpdCdzIGFja2VkLCBzZWNv
bmRhcnkgbWFzdGVyIGJlY29tZXMgY3VycmVudCBtYXN0ZXIuDQogICAgPiAgICAgIA0KICAgID4g
ICAgICBCZXN0IHJlZ2FyZHMsDQogICAgPiAgICAgIFZpdG9yIFNvYXJlcw0KICAgID4NCiAgICA+
IFBsZWFzZSBsZXQgbWUga25vdyBpZiBzb21ldGhpbmcgaXMgdW5jbGVhci4NCiAgICA+DQogICAg
PiBSZWdhcmRzLA0KICAgID4gUHJ6ZW1law0KICAgID4gICAgICANCiAgICANCiAgICBTb3JyeSwg
aXQgcyBub3QgY2xlYXIgeWV0Lg0KICAgIA0KICAgIEZvciBpbnN0YW5jZXMgdGhlcmUgaXMgYSBi
dXMgd2l0aCBzZXZlcmFsIHNlY29uZGFyeSBtYXN0ZXIuIElmIGVhY2ggb2YgDQogICAgdGhlbSBy
ZXF1ZXN0IHRoZSBidXMgbWFzdGVyc2hpcCAob25lIGF0IGEgdGltZSksIHdpbGwgeW91IGFjY2Vw
dCBhbGwgYnkgDQogICAgZGVmYXVsdD8gQmVjYXVzZSB5b3UgY2FuIG9ubHkgYWNjZXB0IG9ubHkg
c29tZSBvZiB0aGVtLg0KICAgIA0KICAgIFJlZ2FyZHMsDQogICAgVml0b3IgU29hcmVzDQogICAg
DQoNCg==
