Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780BDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6E5206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rzYf3q3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6E5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeIFSXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:23:14 -0400
Received: from mail-by2nam03on0063.outbound.protection.outlook.com ([104.47.42.63]:21328
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726837AbeIFSXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuJOXB0uOLOA97jyo6fg05iMv8oNbrpHRZLnwFpHGRU=;
 b=rzYf3q3fxUWsnLVGGZdIBzbGH+BWdX1r7dVDwuLoTA0c8u7VO998Yl9nwTP+jw3RpJ3TCUsyAQWByesFB5GFC7usDhem+y9EDEo8LzNLX9JYjCGEXdLEi7c82s36aErOaq1Ppqv46BidaDQJIo5130oK4LHBAJqRwV3ny9+WNC4=
Received: from BYAPR07MB5144.namprd07.prod.outlook.com (20.176.254.209) by
 BYAPR07MB5367.namprd07.prod.outlook.com (20.177.125.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 6 Sep 2018 13:47:29 +0000
Received: from BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99]) by BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99%4]) with mapi id 15.20.1122.009; Thu, 6 Sep 2018
 13:47:29 +0000
From:   Przemyslaw Gaj <pgaj@cadence.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Vitor Soares <Vitor.Soares@synopsys.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
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
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Thread-Topic: [PATCH v6 01/10] i3c: Add core I3C infrastructure
Thread-Index: AQHUH3VT99XuaYWr3kWHpjq9POOKYqTML50AgALgfQCAAFeJAIAABncAgAXdiQCAAANWgIAAMGEAgAMUiwCAAHYxAIAFiUGAgAUNtQD//+MCAIAABCaAgAAqtIA=
Date:   Thu, 6 Sep 2018 13:47:29 +0000
Message-ID: <5AD923AE-E86E-4414-A48F-CE7399E18431@cadence.com>
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
 <25862F03-9823-42B0-87AC-AE36D7E9C780@cadence.com>
 <CAK8P3a3pkddD9VnogYryQKoL9Z_5qVRBXd6yr1z6CqGU692rXg@mail.gmail.com>
 <20180906151437.4259d6fc@bbrezillon>
In-Reply-To: <20180906151437.4259d6fc@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgaj@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5367;20:Xh/+eSjaURb7AzbnLg/sXRDpnuu9OogjtRe2f8fFgyCPwRZGmUguhVNcbHk3C1Eh/VgdbFsNQrw/IQtlF93xOu/9zLqSB7cEcl+YSRIzeCq9gd3UIbK6QpLTdEvP1qjbL5MbSNpkAYpL83SnWXiMaAYRibykb0GmNxfnQw44p80jgfa64bBSrf1tJj9f1Lltd0QU9Sa+US4F+8hutfXmEl7tZBaicfNPTzWn2WtMXC1bbpLahsgoFhCpaTPvX21H
x-ms-office365-filtering-correlation-id: ee557545-a75a-4aee-87ff-08d613ff49f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5367;
x-ms-traffictypediagnostic: BYAPR07MB5367:
x-microsoft-antispam-prvs: <BYAPR07MB5367404CE779F77D3860F416C2010@BYAPR07MB5367.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(60795455431006)(10436049006162)(72170088055959)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR07MB5367;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5367;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(39850400004)(396003)(199004)(189003)(54014002)(36092001)(36756003)(6436002)(76176011)(14444005)(3846002)(6486002)(6246003)(256004)(6116002)(4326008)(82746002)(68736007)(2906002)(83716003)(14454004)(966005)(66066001)(229853002)(8936002)(81156014)(81166006)(2900100001)(7736002)(54906003)(53546011)(25786009)(93886005)(102836004)(6506007)(5250100002)(110136005)(26005)(6512007)(316002)(11346002)(86362001)(186003)(446003)(33656002)(53936002)(97736004)(99286004)(478600001)(8676002)(486006)(575784001)(2616005)(476003)(105586002)(305945005)(6306002)(5660300001)(7416002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5367;H:BYAPR07MB5144.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zfm5Kja7VIigYdo6oOskOpRmx5z1CUdSX81zjvFyTWPmH0CTmG1bVfU6sm0dvEwm4hUt7B+OoIajZuCV0YgmT44WNp3Av5/eECS2z0+1/E22FV3okqDNL0s/Alc3hm74qR847doODZF3jVzIkPj4WD3IEHSPsYyHteCthYWRBFUKOJ4xCTGeclxipKbHEWOQtwkXAXTMZXqpUThRXRptzyCp+jjbvmeyeEecAopUCvaLs4iD2JbRTPhDrNLUAmscnbgAWoV191wmdKEacD/3mLJ5q8p5K8BsePRlxQMHeP2Mrjaw3uos48UPtTGr5aBopyRWlBe8Ott8oF6Em+wgJfFI5FsIq2WtFDu+TfdZ5Pw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA57048406789A41B36F37C802474033@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee557545-a75a-4aee-87ff-08d613ff49f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 13:47:29.5337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDkvNi8xOCwgMzoxNCBQTSwgIkJvcmlzIEJyZXppbGxvbiIgPGJvcmlzLmJyZXpp
bGxvbkBib290bGluLmNvbT4gd3JvdGU6DQoNCiAgICBFWFRFUk5BTCBNQUlMDQogICAgDQogICAg
DQogICAgT24gVGh1LCA2IFNlcCAyMDE4IDE0OjU5OjQ2ICswMjAwDQogICAgQXJuZCBCZXJnbWFu
biA8YXJuZEBhcm5kYi5kZT4gd3JvdGU6DQogICAgDQogICAgPiBPbiBUaHUsIFNlcCA2LCAyMDE4
IGF0IDI6NDMgUE0gUHJ6ZW15c2xhdyBHYWogPHBnYWpAY2FkZW5jZS5jb20+IHdyb3RlOg0KICAg
ID4gPg0KICAgID4gPiBIaSBCb3JpcywgVml0b3IsDQogICAgPiA+DQogICAgPiA+IFRoaXMgcmVw
b3NpdG9yeSBkb2VzIG5vdCBjb250YWluIGZ1bGwga2VybmVsIHNvdXJjZXMsIGJ1dCBpdCBzaG91
bGQgYmUgZW5vdWdoIHRvIGRpc2N1c3MgbWFzdGVyc2hpcCByZXF1ZXN0IGZlYXR1cmUuDQogICAg
PiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9f
Z2l0aHViLmNvbV9wcnplbWVrZ2FqX2kzYy0yRGxpbnV4X2NvbW1pdF9kNTRmZTY4YTlkM2U1NzNj
MGM0NTRhMmM2ZjFhZmFmYzIwMTQyZWM1JmQ9RHdJQ0FnJmM9YVVxOTgzTDJwdWUyRnFLRm9QNlBH
SE1KUXlvSjdrbDNzM0daLV9oYVhxWSZyPUNNbkFmTV9PZnBxY1daUmZpcWNSV3cmbT1PUFNhMjVF
Tm5yRjBRdjcwREc0OVpuZ2ZkeWdKWnViam8zVE9nQkEzcEo0JnM9X0M2aTFLUHBsUUdjV3ZRWVBr
ckd4N1YzVGpLREp2cXQzS0ctdmNkVTJLNCZlPQ0KICAgID4gPg0KICAgID4gPiBQbGVhc2Uga2Vl
cCBpbiBtaW5kIHRoYXQgdGhpcyBpcyBpbml0aWFsIHZlcnNpb24sIGJ1dCBtYXN0ZXJzaGlwIHdv
cmtzIGNvcnJlY3RseS4gSSBhZGRlZCBvbmUgcHJvcGVydHkgdG8gRFQgdG8gcmVmbGVjdCByZWxh
dGlvbnNoaXAgYmV0d2VlbiBtYXN0ZXJzLg0KICAgID4gPiBJdCBpcyBwb3NzaWJsZSB0byByZXF1
ZXN0IG1hc3RlcnNoaXAgb24gZGVtYW5kICh1c2luZyBzeXNmcy4gVXNlZnVsIGluIGNhc2Ugd2hl
biBMaW51eCBtYWNoaW5lIGlzIGVxdWlwcGVkIG9ubHkgd2l0aCBzZWNvbmRhcnkgbWFzdGVyIGNv
bnRyb2xsZXIpIG9yIGF1dG9tYXRpY2FsbHkgY2hhbmdlIG9wZXJhdGlvbiBtb2RlIHdoZW4gZGV2
aWNlIGRyaXZlciB3YW50cyB0byByZWFkL3dyaXRlIHNvbWV0aGluZyBmcm9tL3RvIGRldmljZS4N
CiAgICA+ID4NCiAgICA+ID4gSSdtIHN1cmUgSSB3aWxsIGhhdmUgdG8gcmV3b3JrIHNvbWV0aGlu
ZyBiZWNhdXNlIHRoaXMgd2FzIGltcGxlbWVudGVkIG9uIHNvdXJjZXMgZnJvbSBQQVRDSCB2NC4g
SSBzYXcgdGhhdCBCb3JpcyByZWxlYXNlZCB2NyB5ZXN0ZXJkYXkgOikgIA0KICAgID4gDQogICAg
PiANCiAgICA+IENhbiB5b3UgZXhwbGFpbiB0aGUgcmVhc29uIGZvciBoYXZpbmcgYSB1c2VyIHNw
YWNlIGludGVyZmFjZSBhbmQgRFQgcHJvcGVydHk/DQogICAgPiBJIHRob3VnaHQgd2UgaGFkIGNv
bmNsdWRlZCBlYXJsaWVyIHRoYXQgd2Ugd291bGRuJ3QgbmVlZCB0aGF0LCBidXQgaXQncyBwb3Nz
aWJsZQ0KICAgID4gdGhhdCBJIG1pc3NlZCBzb21ldGhpbmcgaW4gdGhlIGRpc2N1c3Npb24gc2lu
Y2UgdGhlbi4NCiAgICANCiAgICBJIGRvbid0IHRoaW5rIHRoZSBzeXNmcyBrbm9iIGlzIG5lZWRl
ZCwgdGhpcyBiZWluZyBzYWlkLCBhZnRlciB0aGlua2luZw0KICAgIGEgYml0IG1vcmUgYWJvdXQg
bWFzdGVyc2hpcCBoYW5kb3ZlciBhbmQgdGhlIHNlY29uZGFyeSBtYXN0ZXIgY2FzZSwgSQ0KICAg
IHRoaW5rIHdlIGhhdmUgc29tZXRoaW5nIGltcG9ydGFudCB0byBzb2x2ZS4NCiAgICANCiAgICBX
aGVuIGEgbWFzdGVyIGlzIG5vdCBpbiBjb250cm9sIG9mIHRoZSBidXMsIGl0IGdldHMgaW5mb3Jt
ZWQgb2YgZGV2aWNlcw0KICAgIHByZXNlbnQgb24gdGhlIGJ1cyBieSBtb25pdG9yaW5nIERBQSBv
ciBERUZTTFZTIGJyb2FkY2FzdCBldmVudHMuIFRoYXQNCiAgICBtZWFucyB0aGUgc2Vjb25kYXJ5
IG1hc3RlciBzaG91bGQgcG9wdWxhdGUgdGhlIGJ1cyB3aXRoIEkzQy9JMkMgZGV2aWNlcw0KICAg
IG9uIHN1Y2ggZXZlbnRzLCBidXQgdGhhdCdzIG5vdCBlbm91Z2gsIGJlY2F1c2UgREVGU0xWUy9E
QUEgZG8gbm90DQogICAgcHJvdmlkZSBhbGwgZGV2aWNlIGluZm8uIFNvbWUgb2YgdGhlbSAobGlr
ZSByZWFkL3dyaXRlL2liaSBsaW1pdGF0aW9ucykNCiAgICByZXF1aXJlIGV4dHJhIENDQyBjb21t
YW5kcywgYW5kLCB0byBzZW5kIHRob3NlIENDQyBjb21tYW5kcywgdGhlDQogICAgc2Vjb25kYXJ5
IG1hc3RlciBtdXN0IGNsYWltIHRoZSBidXMuIFdlIGNvdWxkIGFkZCBhIGNhc2Ugd2hlcmUgd2UN
CiAgICBkZWNsYXJlIGRldmljZXMgYXMgcGFydGlhbGx5IGRpc2NvdmVyZWQgdW50aWwgdGhlIG1h
c3RlciBhY3F1aXJlcw0KICAgIG93bmVyc2hpcCBvZiB0aGUgYnVzLCBidXQgdGhhdCBtZWFucyBw
YXJ0IG9mIHRoZSBkYXRhIHJldHVybmVkIGJ5DQogICAgaTNjX2RldmljZV9nZXRfaW5mbygpIHdp
bGwgYmUgaW5hY2N1cmF0ZSwgd2hpY2ggbWlnaHQgaGF2ZSBhbiBpbXBhY3Qgb24NCiAgICBzb21l
IGkzYyBkcml2ZXIgLT5wcm9iZSgpIGZ1bmN0aW9ucy4NCg0KSG93IGRvIHlvdSB3YW50IHRvIGhh
bmRsZSBjYXNlcyB3aGVuIHNlY29uZGFyeSBtYXN0ZXIgam9pbnMgdGhlIGJ1cyBhZnRlciANCkRF
RlNMVlM/IE9mIGNvdXJzZSB3ZSBjYW4gc2VuZCBERUZTTFZTIGFmdGVyIHNlY29uZGFyeSBtYXN0
ZXIgam9pbnMgdGhlIGJ1cy4NCiAgICANCiAgICBXZSBjb3VsZCBhbHNvIHNheSB0aGF0IHBhcnRp
YWxseSBkaXNjb3ZlcmVkIGRldmljZXMgc2hvdWxkIG5vdCBiZQ0KICAgIHJlZ2lzdGVyZWQgdG8g
dGhlIGRldmljZSBtb2RlbCwgYnV0IHdlIHRoZW4gaGl0IHRoZSBwcm9ibGVtIG9mICJ3aG8gY2Fu
DQogICAgZm9yY2UgdGhlIHNlY29uZGFyeSBtYXN0ZXIgdG8gY2xhaW0gdGhlIGJ1cyBpZiB0aGVy
ZSdzIG5vIHVzZXJzPyIuDQoNCk5vdyBJIGZlZWwgbGlrZSBJIG1pc3NlZCBzb21ldGhpbmcuIERv
IHlvdSB3YW50IHRvIHBvcHVsYXRlIHNlY29uZCBpbnN0YW5jZQ0Kb2YgdGhlIHNhbWUgcGh5c2lj
YWwgYnVzPyBJZiB5ZXMsIHRoZW4gd2UgZG9uJ3QgbmVlZCB0byBoYXZlIHJlZmVyZW5jZSANCmJl
dHdlZW4gbWFzdGVycyBpbiBEVC4NCiAgICANCg0K
