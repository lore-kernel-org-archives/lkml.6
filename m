Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B395C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26BF20659
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QBsR/Gm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26BF20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeH1Qq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:46:56 -0400
Received: from mail-sn1nam01on0073.outbound.protection.outlook.com ([104.47.32.73]:63363
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbeH1Qq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4YQMV90wEOXR6AUaqU/03RyW2T4l+e2jKYzZRSVWDA=;
 b=QBsR/Gm/uY7pcIuejufj8E1vTvKgsKhiObdG0p1IX3Echis/MxbdJRoZrffsWwoz93oXes2TO2YeXG2QO0UZzHKSER+1O+fRiuKyEmrAvVr3VVy4pboezA9p1byTM76cojfEnFbUevX76ZvPpkSSqfT81wmQp8/6PojoNSA/cXE=
Received: from BYAPR07MB5144.namprd07.prod.outlook.com (20.176.254.209) by
 BYAPR07MB4229.namprd07.prod.outlook.com (52.135.223.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 12:55:20 +0000
Received: from BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99]) by BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99%4]) with mapi id 15.20.1080.015; Tue, 28 Aug 2018
 12:55:20 +0000
From:   Przemyslaw Gaj <pgaj@cadence.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        vitor <Vitor.Soares@synopsys.com>
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
Thread-Index: AQHUH3VT99XuaYWr3kWHpjq9POOKYqTML50AgALgfQCAAFeJAIAABncAgAXdiQCAAANWgIAAMGEA
Date:   Tue, 28 Aug 2018 12:55:20 +0000
Message-ID: <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com>
 <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon>
 <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon>
 <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon>
In-Reply-To: <20180828140209.29155d00@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgaj@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4229;20:xZG52yl8w186pTlut8WEhzO51qPJ1jQf11uXVa4NkCPls9uHz6Pp1WRsRdmjCtmuDbtVDGfbwPHPDu3iMOa7tNal96vIjsVcwjWWw/u2RKjKF+MbMOuaxWB4ht55lcmI9VwrP9kleECXs8T0LS6Uf1lsiMb9eVkT3mC+cLzZo2ZTWlxmj7sz1yKeQYGjert0ypCXcb2TUaCMgmMATRosZQ0+YI1p3DI6l5+xHi3IhvwWjx3KAUMckrmumOAUO94y
x-ms-office365-filtering-correlation-id: 65112e40-7bfb-4bdd-5007-08d60ce5833c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4229;
x-ms-traffictypediagnostic: BYAPR07MB4229:
x-microsoft-antispam-prvs: <BYAPR07MB4229CA0A8FE31C79F2251B87C20A0@BYAPR07MB4229.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(60795455431006);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:BYAPR07MB4229;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4229;
x-forefront-prvs: 077884B8B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(346002)(396003)(52164004)(189003)(199004)(36092001)(52314003)(51444003)(478600001)(105586002)(26005)(186003)(82746002)(6486002)(7416002)(256004)(2900100001)(5250100002)(486006)(53936002)(102836004)(14454004)(83716003)(14444005)(2906002)(11346002)(229853002)(6512007)(476003)(2616005)(446003)(93886005)(53546011)(6506007)(97736004)(66066001)(99286004)(106356001)(25786009)(8936002)(81156014)(81166006)(7736002)(54906003)(8676002)(4326008)(305945005)(110136005)(33656002)(316002)(6436002)(68736007)(86362001)(6116002)(5660300001)(3846002)(76176011)(6246003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4229;H:BYAPR07MB5144.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: s8xj7rOrxSfq85sMf+zh2RHQc1LRJLB2skdb0wK1Bbzw8GDKt5/W6R2ByLppAY/6gcuYqg8cAFqGKcLn3QM4hbxuCKPmyok+TPUJXyGgBIEykrqVcGDgPt+Tqd4W7eob/QebSyrOzL/zF6E7rJixPs52PFPEa/efPI0kWPds0Yo4Qljsmw9gc8NBAV5CXHMELBpO5aV77D2HDnnEJV7tbPCTtxWc0WCj8QfKICFpadoV8sPgpoM/tSlFEYT/Ju+2X05A40jfMGHFLX/QGZLpb9+DZzGYQyqeWakuEBVXkp2o+86M1PXCpDVfbXlVyFLBTz6ChcBcIhpDE9s8A7eOvh2tCPABExTbvKXLw2Vj4qw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7221CDCC1D9B3D43B80DADC4629BDEAB@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65112e40-7bfb-4bdd-5007-08d60ce5833c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 12:55:20.7185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVml0b3IsDQoNCkkgaGF2ZSBhbHJlYWR5IGltcGxlbWVudGVkIE1hc3RlcnNoaXAgcmVxdWVz
dC9oYW5kb3ZlciBidXQgd2UgYXJlIHdhaXRpbmcgZm9yIEJvcmlz4oCZcyBwYXRjaCB0byBiZSBh
Y2NlcHRlZCBhbmQgbWVyZ2VkLiBBbnl3YXksIG15IGNvbW1lbnRzIGJlbG93Lg0KDQrvu79PbiA4
LzI4LzE4LCAyOjAyIFBNLCAiQm9yaXMgQnJlemlsbG9uIiA8Ym9yaXMuYnJlemlsbG9uQGJvb3Rs
aW4uY29tPiB3cm90ZToNCg0KICAgIEVYVEVSTkFMIE1BSUwNCiAgICANCiAgICANCiAgICBIaSBW
aXRvciwNCiAgICANCiAgICBPbiBUdWUsIDI4IEF1ZyAyMDE4IDEyOjUwOjEyICswMTAwDQogICAg
dml0b3IgPFZpdG9yLlNvYXJlc0BzeW5vcHN5cy5jb20+IHdyb3RlOg0KICAgIA0KICAgID4gSGkg
Qm9yaXMsDQogICAgPiANCiAgICA+IFRoZSBEVCBCaW5kaW5ncyBzYXkgIlRoZSBub2RlIGRlc2Ny
aWJpbmcgYW4gSTNDIGJ1cyBzaG91bGQgYmUgbmFtZWQgDQogICAgPiBpM2MtbWFzdGVyLiIuIERv
IHlvdSBoYXZlIGEgZmllbGQgZm9yIHNlY29uZGFyeSBtYXN0ZXI/DQoNCkkgdGhpbmsgd2UgZG9u
4oCZdCBuZWVkIHNlcGFyYXRlIGZpZWxkIGZvciBzZWNvbmRhcnkgbWFzdGVyLiBNYWluIGFuZCBz
ZWNvbmRhcnkgbWFzdGVycyANCnN1cHBvcnQgc2ltaWxhciBmdW5jdGlvbmFsaXRpZXMuIEl04oCZ
cyBlbm91Z2ggdG8gaGF2ZSB0aGlzIHN0YXRlIGludGVybmFsbHkgYW5kIGRvIG1hc3RlcnNoaXAg
aXQgaXQncyBuZWVkZWQuDQoNCiAgICA+IA0KICAgID4gT24gMjQtMDgtMjAxOCAxOToxNiwgQm9y
aXMgQnJlemlsbG9uIHdyb3RlOg0KICAgID4gPiBXZWxsLCBiZWZvcmUgZXZlbiBjb25zaWRlcmlu
ZyBzdXBwb3J0aW5nIHNlY29uZGFyeSBtYXN0ZXIgcmVnaXN0cmF0aW9uLA0KICAgID4gPiB3ZSBu
ZWVkIHRvIGhhbmRsZSBtYXN0ZXJzaGlwIGhhbmRvdmVyLiBBcyBmb3IgdGhlIERBQSBvcGVyYXRp
b24sIGl0J3MNCiAgICA+ID4gbGlrZWx5IHRvIGJlIGhvc3Qgc3BlY2lmaWMsIHNvIHdlJ2xsIGhh
dmUgdG8gYWRkIGEgbmV3IGhvb2sgdG8gdGhlDQogICAgPiA+IGkzY19tYXN0ZXJfY29udHJvbGxl
cl9vcHMgc3RydWN0LiAgDQogICAgPiBEbyB5b3UgbWVhbiB3aGVuIG1hc3RlciB0cnkgdG8gZGVs
ZWdhdGUgdGhlIGJ1cyBvd25lcnNoaXAgdGhyb3VnaCANCiAgICA+IEdFVEFDQ01TVD8gb3IgdG8g
Z2V0IHRoZSBidXMgb3duZXJzaGlwIHdpdGggSUJJLU1SPw0KICAgIA0KICAgIEkgdGhpbmsgd2Ug
bmVlZCB0byBzdXBwb3J0IGJvdGguDQoNCkkgYWdyZWUuDQogICAgDQogICAgPiANCiAgICA+IEkg
dGhpbmsgdGhhdCBjb3VsZCBiZSB1c2VmdWwgdG8gcGFzcyB0aGUgaWJpIHR5cGUgb24gcmVxdWVz
dF9pYmkoKSwgDQogICAgPiB0aGVyZSBpcyBzb21lIGNhc2Ugd2hlcmUgdGhlIG1hc3RlciBkb2Vz
bid0IHN1cHBvcnQgSUJJLU1SLg0KICAgIA0KICAgIEFjdHVhbGx5LCBJIHdhcyBwbGFubmluZyBv
biBtYWtpbmcgaXQgY29tcGxldGVseSBzZXBhcmF0ZSBmcm9tDQogICAgcmVndWxhciBzbGF2ZSBJ
QklzLiBUaGF0IGlzLCB0aGUgbWFzdGVyIGNvbnRyb2xsZXIgZHJpdmVyIHdvdWxkIGRlbXV4DQog
ICAgdGhlIHNsYXZlLCBNUiBhbmQgSG90IEpvaW4gSUJJcywgYW5kIGlmIHRoZXJlJ3MgYW4gTVIg
cmVxdWVzdCwgcXVldWUgYQ0KICAgIG1hc3RlcnNoaXAgaGFuZG92ZXIgd29yayB0byB0aGUgd29y
a3F1ZXVlIChwcmV0dHkgbXVjaCB3aGF0IHdlIGRvIGZvcg0KICAgIEhvdC1Kb2luIGFscmVhZHkp
LiBNYXN0ZXJzaGlwIGhhbmRvdmVyIGlzIGFueXdheSBsaWtlbHkgdG8gYmUgSVANCiAgICBzcGVj
aWZpYywgc28gSSBkb24ndCB0aGluayB0aGVyZSdzIGEgbmVlZCB0byBtYWtlIGl0IGxvb2sgbGlr
ZSBhDQogICAgcmVndWxhciBJQkkuDQoNCkkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gaGF2ZSBzZXBh
cmF0ZSBmdW5jdGlvbiB0byBkbyBtYXN0ZXJzaGlwIHJlcXVlc3QuDQogICAgDQogICAgUmVnYXJk
aW5nIHdoZXRoZXIgSUJJLU1SIHN1cHBvcnQgc2hvdWxkIGJlIGV4cG9zZWQgdG8gdGhlIEkzQyBm
cmFtZXdvcmsNCiAgICBvciBub3QgZGVwZW5kcyBvbiBob3cgbXVjaCB3aWxsIGJlIGF1dG9tYXRl
ZCBvbiB0aGUgZnJhbWV3b3JrIHNpZGUuIEkNCiAgICBkb24ndCB0aGUgYW5zd2VyIHlldCwgYnV0
IHRoYXQncyBwcm9iYWJseSBzb21ldGhpbmcgd2lsbCBmaWd1cmUgb3V0DQogICAgYWxvbmcgdGhl
IHJvYWQuDQoNCk15IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaXM6IHdoZW4gcmVxdWVzdF9tYXN0
ZXJzaGlwIGZpZWxkIA0Kb2YgaTNjX21hc3Rlcl9jb250cm9sbGVyX29wcyBzdHJ1Y3R1cmUgaXMg
c2V0LCBtYXN0ZXIgZHJpdmVyIHN1cHBvcnRzIG1hc3RlcnNoaXAgcmVxdWVzdHMuDQpUaGF0J3Mg
aG93IEkgY2hlY2sgaWYgdGhpcyBpcyBzdXBwb3J0ZWQgb3Igbm90Lg0KICAgIA0KICAgIFJlZ2Fy
ZHMsDQogICAgDQogICAgQm9yaXMNCiAgICANClJlZ2FyZHMsDQpQcnplbWVrDQoNCg==
