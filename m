Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98573C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AD02082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="W784EwOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AD02082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeH3XEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:04:22 -0400
Received: from mail-by2nam01on0088.outbound.protection.outlook.com ([104.47.34.88]:3637
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbeH3XEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go1OvAkn50hvfHb+FO9et6GMG/038ftWhmegjMmClQg=;
 b=W784EwOoRPNpjDyp1B8P7+2fF0bOlyvFn7SA1tujXHPXbI8wTJRKNrjmENmjZ7BThimObeM3ruBOVnBLZVRut+HpZx19SUZkB5+dqSkNgg2Y10dyB/KJYVbg+t75IZMjiM64HhxwrU3GuKsfEldB1A18JcS2/B9xU2UZhwvsuk0=
Received: from BYAPR07MB5144.namprd07.prod.outlook.com (20.176.254.209) by
 BYAPR07MB5269.namprd07.prod.outlook.com (20.177.124.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 30 Aug 2018 19:00:39 +0000
Received: from BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99]) by BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99%4]) with mapi id 15.20.1080.015; Thu, 30 Aug 2018
 19:00:39 +0000
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
Thread-Index: AQHUH3VT99XuaYWr3kWHpjq9POOKYqTML50AgALgfQCAAFeJAIAABncAgAXdiQCAAANWgIAAMGEAgAMUiwCAAHYxAA==
Date:   Thu, 30 Aug 2018 19:00:39 +0000
Message-ID: <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
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
In-Reply-To: <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgaj@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5269;20:xaGh80wSuD8XB1J0yU0AkiQY7J1dDirgTV1cVYY8wwtMqBMUuogh+9BoVO0GR3CV8tsbhToHJuAJSM59kJaL3ZH2w+7wlyvAlVbxOqKytZWDdZwXyJEItSThw78cb9EicTdHXzlbdB39zELEcu60i62gi+LDx+ypF/nfNz2MTRUjNWsyMsnz3fed7O/zD2AOhcwOmSjKTTL8LQdzQCW7PqzaL0ghwLYQf3XmkbNkcS95MPsHX9vH9Vza9N2K3eh5
x-ms-office365-filtering-correlation-id: 67a7ee48-7896-42ca-0b97-08d60eaae097
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5269;
x-ms-traffictypediagnostic: BYAPR07MB5269:
x-microsoft-antispam-prvs: <BYAPR07MB52690F6436E8215C16CBCBDCC2080@BYAPR07MB5269.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(60795455431006);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR07MB5269;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5269;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(52164004)(52314003)(36092001)(51444003)(7736002)(4326008)(305945005)(25786009)(86362001)(6246003)(5250100002)(6116002)(8676002)(106356001)(3846002)(105586002)(33656002)(14454004)(478600001)(93886005)(66066001)(2900100001)(5660300001)(81156014)(53936002)(316002)(82746002)(83716003)(6506007)(102836004)(53546011)(6512007)(54906003)(256004)(81166006)(36756003)(7416002)(26005)(68736007)(110136005)(2906002)(76176011)(446003)(486006)(97736004)(6436002)(476003)(6486002)(186003)(14444005)(2616005)(11346002)(229853002)(8936002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5269;H:BYAPR07MB5144.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1dO8x4OieuEMpH1bXPbHtlMFdsAYNqEKVFQdn+EV4PVBiYZlaAheYzpYyxdmzaUliiG1LfqkCfpzPk1EEwief1xmC5p9fMz9kTOoLgwmiEDeOijIJwihPo5U7tCr8m6n/4vC5VZu/cJw3xwqcTsy2FA+3coCuXvx9Mn3FrRmY7o8cLy2deHKTHwyHvnDmaEXi49OTQg91MEqJlRMRLHmXZ0h6IXs2bgaoaQGTYoRuHW8Yhw4qE42mGvHX5jRBzOxODsL6D5AWjm1w1mqLcEI4Q9kwxSVYka0STdjIFYElRn028buzL6KtR0y2eYBUg8XVEGI7KDheisOQ8/M6s/gdySHxU5vvODXMh97y/o5MW0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <709EFCE5C7083243B8CC2CE09EBDB8DB@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a7ee48-7896-42ca-0b97-08d60eaae097
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 19:00:39.3817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVml0b3IsDQoNCu+7v09uIDgvMzAvMTgsIDM6NTcgUE0sICJ2aXRvciIgPFZpdG9yLlNvYXJl
c0BzeW5vcHN5cy5jb20+IHdyb3RlOg0KDQogICAgRVhURVJOQUwgTUFJTA0KICAgIA0KICAgIA0K
ICAgIEhpIFByemVteXNsYXcNCiAgICANCkp1c3QgUHJ6ZW1layA6KQ0KICAgIA0KICAgIE9uIDI4
LTA4LTIwMTggMTM6NTUsIFByemVteXNsYXcgR2FqIHdyb3RlOg0KICAgID4gSGkgVml0b3IsDQog
ICAgPg0KICAgID4gSSBoYXZlIGFscmVhZHkgaW1wbGVtZW50ZWQgTWFzdGVyc2hpcCByZXF1ZXN0
L2hhbmRvdmVyIGJ1dCB3ZSBhcmUgd2FpdGluZyBmb3IgQm9yaXPigJlzIHBhdGNoIHRvIGJlIGFj
Y2VwdGVkIGFuZCBtZXJnZWQuIEFueXdheSwgbXkgY29tbWVudHMgYmVsb3cuDQogICAgPg0KICAg
ID4gT24gOC8yOC8xOCwgMjowMiBQTSwgIkJvcmlzIEJyZXppbGxvbiIgPGJvcmlzLmJyZXppbGxv
bkBib290bGluLmNvbT4gd3JvdGU6DQogICAgPg0KICAgID4gICAgICBFWFRFUk5BTCBNQUlMDQog
ICAgPiAgICAgIA0KICAgID4gICAgICANCiAgICA+ICAgICAgSGkgVml0b3IsDQogICAgPiAgICAg
IA0KICAgID4gICAgICBPbiBUdWUsIDI4IEF1ZyAyMDE4IDEyOjUwOjEyICswMTAwDQogICAgPiAg
ICAgIHZpdG9yIDxWaXRvci5Tb2FyZXNAc3lub3BzeXMuY29tPiB3cm90ZToNCiAgICA+ICAgICAg
DQogICAgPiAgICAgID4gSGkgQm9yaXMsDQogICAgPiAgICAgID4NCiAgICA+ICAgICAgPiBUaGUg
RFQgQmluZGluZ3Mgc2F5ICJUaGUgbm9kZSBkZXNjcmliaW5nIGFuIEkzQyBidXMgc2hvdWxkIGJl
IG5hbWVkDQogICAgPiAgICAgID4gaTNjLW1hc3Rlci4iLiBEbyB5b3UgaGF2ZSBhIGZpZWxkIGZv
ciBzZWNvbmRhcnkgbWFzdGVyPw0KICAgID4NCiAgICA+IEkgdGhpbmsgd2UgZG9u4oCZdCBuZWVk
IHNlcGFyYXRlIGZpZWxkIGZvciBzZWNvbmRhcnkgbWFzdGVyLiBNYWluIGFuZCBzZWNvbmRhcnkg
bWFzdGVycw0KICAgID4gc3VwcG9ydCBzaW1pbGFyIGZ1bmN0aW9uYWxpdGllcy4gSXTigJlzIGVu
b3VnaCB0byBoYXZlIHRoaXMgc3RhdGUgaW50ZXJuYWxseSBhbmQgZG8gbWFzdGVyc2hpcCBpdCBp
dCdzIG5lZWRlZC4NCiAgICANCiAgICBZZXMsIHlvdSBhcmUgcmlnaHQuDQogICAgDQogICAgPg0K
ICAgID4gICAgICA+DQogICAgPiAgICAgID4gT24gMjQtMDgtMjAxOCAxOToxNiwgQm9yaXMgQnJl
emlsbG9uIHdyb3RlOg0KICAgID4gICAgICA+ID4gV2VsbCwgYmVmb3JlIGV2ZW4gY29uc2lkZXJp
bmcgc3VwcG9ydGluZyBzZWNvbmRhcnkgbWFzdGVyIHJlZ2lzdHJhdGlvbiwNCiAgICA+ICAgICAg
PiA+IHdlIG5lZWQgdG8gaGFuZGxlIG1hc3RlcnNoaXAgaGFuZG92ZXIuIEFzIGZvciB0aGUgREFB
IG9wZXJhdGlvbiwgaXQncw0KICAgID4gICAgICA+ID4gbGlrZWx5IHRvIGJlIGhvc3Qgc3BlY2lm
aWMsIHNvIHdlJ2xsIGhhdmUgdG8gYWRkIGEgbmV3IGhvb2sgdG8gdGhlDQogICAgPiAgICAgID4g
PiBpM2NfbWFzdGVyX2NvbnRyb2xsZXJfb3BzIHN0cnVjdC4NCiAgICA+ICAgICAgPiBEbyB5b3Ug
bWVhbiB3aGVuIG1hc3RlciB0cnkgdG8gZGVsZWdhdGUgdGhlIGJ1cyBvd25lcnNoaXAgdGhyb3Vn
aA0KICAgID4gICAgICA+IEdFVEFDQ01TVD8gb3IgdG8gZ2V0IHRoZSBidXMgb3duZXJzaGlwIHdp
dGggSUJJLU1SPw0KICAgID4gICAgICANCiAgICA+ICAgICAgSSB0aGluayB3ZSBuZWVkIHRvIHN1
cHBvcnQgYm90aC4NCiAgICA+DQogICAgPiBJIGFncmVlLg0KICAgIA0KICAgIFRoYXQncyBvayB0
byBtZS4NCiAgICANCiAgICA+ICAgICAgDQogICAgPiAgICAgID4NCiAgICA+ICAgICAgPiBJIHRo
aW5rIHRoYXQgY291bGQgYmUgdXNlZnVsIHRvIHBhc3MgdGhlIGliaSB0eXBlIG9uIHJlcXVlc3Rf
aWJpKCksDQogICAgPiAgICAgID4gdGhlcmUgaXMgc29tZSBjYXNlIHdoZXJlIHRoZSBtYXN0ZXIg
ZG9lc24ndCBzdXBwb3J0IElCSS1NUi4NCiAgICA+ICAgICAgDQogICAgPiAgICAgIEFjdHVhbGx5
LCBJIHdhcyBwbGFubmluZyBvbiBtYWtpbmcgaXQgY29tcGxldGVseSBzZXBhcmF0ZSBmcm9tDQog
ICAgPiAgICAgIHJlZ3VsYXIgc2xhdmUgSUJJcy4gVGhhdCBpcywgdGhlIG1hc3RlciBjb250cm9s
bGVyIGRyaXZlciB3b3VsZCBkZW11eA0KICAgID4gICAgICB0aGUgc2xhdmUsIE1SIGFuZCBIb3Qg
Sm9pbiBJQklzLCBhbmQgaWYgdGhlcmUncyBhbiBNUiByZXF1ZXN0LCBxdWV1ZSBhDQogICAgPiAg
ICAgIG1hc3RlcnNoaXAgaGFuZG92ZXIgd29yayB0byB0aGUgd29ya3F1ZXVlIChwcmV0dHkgbXVj
aCB3aGF0IHdlIGRvIGZvcg0KICAgID4gICAgICBIb3QtSm9pbiBhbHJlYWR5KS4gTWFzdGVyc2hp
cCBoYW5kb3ZlciBpcyBhbnl3YXkgbGlrZWx5IHRvIGJlIElQDQogICAgPiAgICAgIHNwZWNpZmlj
LCBzbyBJIGRvbid0IHRoaW5rIHRoZXJlJ3MgYSBuZWVkIHRvIG1ha2UgaXQgbG9vayBsaWtlIGEN
CiAgICA+ICAgICAgcmVndWxhciBJQkkuDQogICAgPg0KICAgID4gSSB0aGluayBpdCdzIGJldHRl
ciB0byBoYXZlIHNlcGFyYXRlIGZ1bmN0aW9uIHRvIGRvIG1hc3RlcnNoaXAgcmVxdWVzdC4NCiAg
ICA+ICAgICAgDQogICAgPiAgICAgIFJlZ2FyZGluZyB3aGV0aGVyIElCSS1NUiBzdXBwb3J0IHNo
b3VsZCBiZSBleHBvc2VkIHRvIHRoZSBJM0MgZnJhbWV3b3JrDQogICAgPiAgICAgIG9yIG5vdCBk
ZXBlbmRzIG9uIGhvdyBtdWNoIHdpbGwgYmUgYXV0b21hdGVkIG9uIHRoZSBmcmFtZXdvcmsgc2lk
ZS4gSQ0KICAgID4gICAgICBkb24ndCB0aGUgYW5zd2VyIHlldCwgYnV0IHRoYXQncyBwcm9iYWJs
eSBzb21ldGhpbmcgd2lsbCBmaWd1cmUgb3V0DQogICAgPiAgICAgIGFsb25nIHRoZSByb2FkLg0K
ICAgID4NCiAgICA+IE15IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaXM6IHdoZW4gcmVxdWVzdF9t
YXN0ZXJzaGlwIGZpZWxkDQogICAgPiBvZiBpM2NfbWFzdGVyX2NvbnRyb2xsZXJfb3BzIHN0cnVj
dHVyZSBpcyBzZXQsIG1hc3RlciBkcml2ZXIgc3VwcG9ydHMgbWFzdGVyc2hpcCByZXF1ZXN0cy4N
CiAgICA+IFRoYXQncyBob3cgSSBjaGVjayBpZiB0aGlzIGlzIHN1cHBvcnRlZCBvciBub3QuDQog
ICAgPiAgICAgIA0KICAgID4gICAgICBSZWdhcmRzLA0KICAgID4gICAgICANCiAgICA+ICAgICAg
Qm9yaXMNCiAgICA+ICAgICAgDQogICAgPiBSZWdhcmRzLA0KICAgID4gUHJ6ZW1law0KICAgID4N
CiAgICB3aGVuIHlvdSBzYXkgcmVxdWVzdF9tYXN0ZXJzaGlwLCBkbyB5b3UgbWVhbiB0aGUgY3Vy
cmVudCBtYXN0ZXIgZG8gdGhlIA0KICAgIG1hc3RlcnNoaXAgaGFuZC1vZmYgb3IgdGhlIHNlY29u
ZGFyeSBtYXN0ZXIgcmVxdWVzdCB0byBiZSBjdXJyZW50IG1hc3Rlcj8NCg0KSSBtZWFuIHNlY29u
ZGFyeSBtYXN0ZXIgcmVxdWVzdHMgdG8gYmUgY3VycmVudCBtYXN0ZXIuIEN1cnJlbnQgbWFzdGVy
IGRvIHRoZSBtYXN0ZXJzaGlwDQpoYW5kLW9mZiB1c2luZyBHRVRBQ0NNU1QgY29tbWFuZC4NCiAg
ICANCiAgICBTbywgcGVyIG15IHVuZGVyc3RhbmRpbmcgc2luY2UgdGhlIE1haW4gbWFzdGVyIHN1
cHBvcnQgdGhlIGhhbmQtb2ZmIG9mIA0KICAgIHRoZSBidXMgeW91IGFjY2VwdCBhbGwgaW5jb21p
bmcgTVIsIHJpZ2h0PyBPciBkbyB5b3UgY2hlY2sgYWxsIGRldmljZXMgQkNSPw0KDQpJJ20gbm90
IHN1cmUgd2hhdCBkbyB5b3UgbWVhbiBoZXJlLiBNYXN0ZXJzaGlwIHJlcXVlc3QoTVIpIGlzIGZy
b20gc2Vjb25kYXJ5IG1hc3Rlcg0KdG8gY3VycmVudCBtYXN0ZXIuIEN1cnJlbnQgbWFzdGVyIGNh
biBOQUNLIHRoaXMgcmVxdWVzdCBpZiBmb3IgZXhhbXBsZSBpdCBjb21lcyBmcm9tIA0Kd3Jvbmcg
ZGV2aWNlLiBJZiBpdCdzIG9rLCBjdXJyZW50IG1hc3RlciBzZW5kcyBHRVRBQ0NNU1QgY29tbWFu
ZCBhbmQgc2Vjb25kYXJ5IG1hc3RlciANCm1heSBBQ0sgb3IgTkFDSyB0aGlzIGNvbW1hbmQuIEl0
IGl0J3MgYWNrZWQsIHNlY29uZGFyeSBtYXN0ZXIgYmVjb21lcyBjdXJyZW50IG1hc3Rlci4NCiAg
ICANCiAgICBCZXN0IHJlZ2FyZHMsDQogICAgVml0b3IgU29hcmVzDQoNClBsZWFzZSBsZXQgbWUg
a25vdyBpZiBzb21ldGhpbmcgaXMgdW5jbGVhci4NCg0KUmVnYXJkcywNClByemVtZWsNCiAgICAN
Cg0K
