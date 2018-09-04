Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69601C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0538620843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="T3IhmUIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0538620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeIDP36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:29:58 -0400
Received: from mail-dm3nam03on0072.outbound.protection.outlook.com ([104.47.41.72]:12992
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727212AbeIDP36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yH4ACNokIJDFb3RHsTWwE+DuALrg50FVS6oNROGo0o=;
 b=T3IhmUIR+72vF/pFr9WYoyhRLtW3G119mPsK+RmIk03HAnKj/HYb1MWLHWqEx5io5QStzJtTPLtDn1E55AL1uTkabPThPohNqTDDq3VicKGzO7GEfQjPJbTXESJ83DMRH6KFw/D3pCmlgq9IQJTYEpDDQ1W2nFbeQpVtJlvHJ74=
Received: from BYAPR07MB5144.namprd07.prod.outlook.com (20.176.254.209) by
 BYAPR07MB4183.namprd07.prod.outlook.com (52.135.222.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 4 Sep 2018 11:03:36 +0000
Received: from BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99]) by BYAPR07MB5144.namprd07.prod.outlook.com
 ([fe80::581:6eee:fab6:4c99%4]) with mapi id 15.20.1080.020; Tue, 4 Sep 2018
 11:03:36 +0000
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
Thread-Index: AQHUH3VT99XuaYWr3kWHpjq9POOKYqTML50AgALgfQCAAFeJAIAABncAgAXdiQCAAANWgIAAMGEAgAMUiwCAAHYxAIAFiUGAgAHNHIA=
Date:   Tue, 4 Sep 2018 11:03:35 +0000
Message-ID: <E73421F5-DC9B-4000-B282-FF71D7E45866@cadence.com>
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
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4183;20:g4dTR0iUWfRo+rkXIpdrXXoEGy1nw6BUp2hj4vrdMmyl7suEcqRivJYexfiKuzoQOOrgW2HBkSWY32bVe8yMSyE52O0nRUOoxOp8t4OySQUxcv/Hx316JWJDQ73mf/zlQieO0gheTvrCECrqAaoqqRBnjQRQFbW9Nmz4UOE2xz77iomwPmnf7Cq3Gtu9Gpc4OPu5N/y95vQJjBN24g18WstBRBiBOnSttNn0wPGbTwIzgl2MUH4sV85RtZ7pH9yD
x-ms-office365-filtering-correlation-id: 29f4b01c-2380-4310-6f19-08d612560ff1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4183;
x-ms-traffictypediagnostic: BYAPR07MB4183:
x-microsoft-antispam-prvs: <BYAPR07MB4183855B12A8F58D7D0D0D67C2030@BYAPR07MB4183.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR07MB4183;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4183;
x-forefront-prvs: 0785459C39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(36092001)(52164004)(6486002)(229853002)(81156014)(33656002)(106356001)(446003)(7736002)(5660300001)(305945005)(53936002)(54906003)(6246003)(6512007)(11346002)(81166006)(8676002)(105586002)(6436002)(486006)(8936002)(476003)(2906002)(2616005)(316002)(110136005)(7416002)(5250100002)(3846002)(6116002)(14454004)(68736007)(6506007)(53546011)(36756003)(76176011)(66066001)(86362001)(25786009)(186003)(256004)(26005)(478600001)(4326008)(97736004)(14444005)(93886005)(6346003)(102836004)(99286004)(82746002)(2900100001)(83716003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4183;H:BYAPR07MB5144.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgaj@cadence.com; 
x-microsoft-antispam-message-info: drlMF+UOEsEePzh8PsRRGjxiiIZBhXMRcpZhiDm5rE88x7FQmccsm1L9O4zKemp5pqp2bkXJ7AsGnpG7FZf3vjeXK17NGwg7njUPxnYvjqFQ1nkxfZPc9U2jvtZ2VTPxIYQAOfVqlKx95tNBttZR2/n01xTZJCYybvPdS/vX/KARoFizSc68XvSz3ZSbW5JOUcZOamCgHx6bTgwjeBkbdUTPqRX4NYdvy6fYiXFqG7Zm+nMiaNrFgcOnpV92x0MikigHgTzZ7Gcv2Nx70r92ZLoIxwzsnG+kjIl41YzBE1P6+Xqao7LR5bnV0L2RIGkqEWc4x3GKukmc6QlYepUVejKwA0cnWv2pWAC1EuBvqUU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <333A476A334B654787EAC7B600AFC919@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f4b01c-2380-4310-6f19-08d612560ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 11:03:36.0570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVml0b3IsDQoNCu+7v09uIDkvMy8xOCwgMTE6MzMgQU0sICJ2aXRvciIgPFZpdG9yLlNvYXJl
c0BzeW5vcHN5cy5jb20+IHdyb3RlOg0KDQogICAgRVhURVJOQUwgTUFJTA0KICAgIA0KICAgIA0K
ICAgIEhpIFByemVtZWssDQogICAgDQogICAgDQogICAgT24gMzAtMDgtMjAxOCAyMDowMCwgUHJ6
ZW15c2xhdyBHYWogd3JvdGU6DQogICAgPiAgICAgIFNvLCBwZXIgbXkgdW5kZXJzdGFuZGluZyBz
aW5jZSB0aGUgTWFpbiBtYXN0ZXIgc3VwcG9ydCB0aGUgaGFuZC1vZmYgb2YNCiAgICA+ICAgICAg
dGhlIGJ1cyB5b3UgYWNjZXB0IGFsbCBpbmNvbWluZyBNUiwgcmlnaHQ/IE9yIGRvIHlvdSBjaGVj
ayBhbGwgZGV2aWNlcyBCQ1I/DQogICAgPg0KICAgID4gSSdtIG5vdCBzdXJlIHdoYXQgZG8geW91
IG1lYW4gaGVyZS4gTWFzdGVyc2hpcCByZXF1ZXN0KE1SKSBpcyBmcm9tIHNlY29uZGFyeSBtYXN0
ZXINCiAgICA+IHRvIGN1cnJlbnQgbWFzdGVyLiBDdXJyZW50IG1hc3RlciBjYW4gTkFDSyB0aGlz
IHJlcXVlc3QgaWYgZm9yIGV4YW1wbGUgaXQgY29tZXMgZnJvbQ0KICAgID4gd3JvbmcgZGV2aWNl
LiBJZiBpdCdzIG9rLCBjdXJyZW50IG1hc3RlciBzZW5kcyBHRVRBQ0NNU1QgY29tbWFuZCBhbmQg
c2Vjb25kYXJ5IG1hc3Rlcg0KICAgID4gbWF5IEFDSyBvciBOQUNLIHRoaXMgY29tbWFuZC4gSXQg
aXQncyBhY2tlZCwgc2Vjb25kYXJ5IG1hc3RlciBiZWNvbWVzIGN1cnJlbnQgbWFzdGVyLg0KICAg
ID4gICAgICANCiAgICA+ICAgICAgQmVzdCByZWdhcmRzLA0KICAgID4gICAgICBWaXRvciBTb2Fy
ZXMNCiAgICA+DQogICAgPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgc29tZXRoaW5nIGlzIHVuY2xl
YXIuDQogICAgPg0KICAgID4gUmVnYXJkcywNCiAgICA+IFByemVtZWsNCiAgICA+ICAgICAgDQog
ICAgDQogICAgU29ycnksIGl0IHMgbm90IGNsZWFyIHlldC4NCiAgICANCiAgICBGb3IgaW5zdGFu
Y2VzIHRoZXJlIGlzIGEgYnVzIHdpdGggc2V2ZXJhbCBzZWNvbmRhcnkgbWFzdGVyLiBJZiBlYWNo
IG9mIA0KICAgIHRoZW0gcmVxdWVzdCB0aGUgYnVzIG1hc3RlcnNoaXAgKG9uZSBhdCBhIHRpbWUp
LCB3aWxsIHlvdSBhY2NlcHQgYWxsIGJ5IA0KICAgIGRlZmF1bHQ/IEJlY2F1c2UgeW91IGNhbiBv
bmx5IGFjY2VwdCBvbmx5IHNvbWUgb2YgdGhlbS4NCg0KRmlyc3Qgb2YgYWxsLCBvbmx5IGRldmlj
ZXMgd2hpY2ggaGF2ZSBNYXN0ZXJzaGlwIHJlcXVlc3QgZXZlbnQgZW5hYmxlZCAoRU5NUiBzbGF2
ZSBldmVudCkNCmNhbiByZXF1ZXN0IG1hc3RlcnNoaXAuIFNlY29uZCB0aGluZyBpcyB0aGF0IHRo
aXMgZGV2aWNlIG5lZWRzIHRvIGhhdmUgSUJJIGVuYWJsZWQgaW4gDQpjdXJyZW50IG1hc3Rlci4g
SSBhY2NlcHQgYWxsIHN1Y2ggZGV2aWNlcy4gVGhlcmUgaXMgbm8gYWRkaXRpb25hbCBsb2dpYyBm
b3Igbm93LCB3ZSBjYW4gYWRkIGl0DQppbiB0aGUgZnV0dXJlLg0KDQpJIHdhcyB2ZXJ5IGJ1c3kg
cmVjZW50bHkuIEknbSBhbG1vc3QgcmVhZHkgdG8gcHVibGlzaCBteSBjaGFuZ2VzIHJlbGF0ZWQg
dG8gbWFzdGVyc2hpcCByZXF1ZXN0Lg0KSSdtIHNvcnJ5IGZvciB0aGUgZGVsYXkuDQogICAgDQog
ICAgUmVnYXJkcywNCiAgICBWaXRvciBTb2FyZXMNCiAgICANClJlZ2FyZHMsDQpQcnplbWVrDQoN
Cg==
