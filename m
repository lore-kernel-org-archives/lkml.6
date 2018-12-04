Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F2EC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0206D20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R4GUHY0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0206D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeLDDT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:19:28 -0500
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:11232
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725969AbeLDDT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeSP5eNKzruYXcQhUG4btpeEkt1OB9R6rh4++AdsUu8=;
 b=R4GUHY0FYP+/Q2zcpzB8JhcSwL9rs/trG48o7mHK18rQe8GAg8JvQ8xd84xDBseQrZi3dV2po2TkTE+c5y1v5In7ipwHaIzesOsKKep95vFCYRxBRrVyetSEabt17bw4IFG4oNvqQUmQEod6oOggyWPUvD1uD1fpxIH37VhqB50=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3692.eurprd04.prod.outlook.com (52.134.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 4 Dec 2018 03:18:41 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 03:18:41 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: imx: update the cpu power up timing setting
Thread-Topic: [PATCH] ARM: imx: update the cpu power up timing setting
Thread-Index: AQHUirI0UtO9K47MFUWyoWpC6YVNRKVs5SIAgAAF3gCAAP9roA==
Date:   Tue, 4 Dec 2018 03:18:41 +0000
Message-ID: <DB3PR0402MB3916A002BCD712C65DFE5396F5AF0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543804767-17650-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Bc2z9mtWN5HDDbLggryEaxF6eay2Wnu8AdBSBNFZSmXw@mail.gmail.com>
 <CAOMZO5CvjtVfQGT2+0k5eGT2=r_7=qDVe7KvFMcPvUythX8m5Q@mail.gmail.com>
In-Reply-To: <CAOMZO5CvjtVfQGT2+0k5eGT2=r_7=qDVe7KvFMcPvUythX8m5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3692;6:/+hP+IoB5VsnXPq4TeDLWlTYhiiqo4Bba+to5h31sB1f2ap04c91WP8SlZ43T40wKW0vyhwtfYhRDd1l+E5W5uNaX//B5glXP8xBPpnfIJpoUxHQyzPmtCiw3WzgWsDMUwyEmZ9/5f8O9W2ITv7nAzmiVQgyFxp5b2UKJe1gh5/G52dqz84L0T/i4FuSYCfdUfc/jthsH42lJyCQ4arbTBlIRLX/XgkmEhID2RcNJeDcyLCAwhQ7ie3NcmJ+zbdrG6osM1c0TKdpH1QLQP3Na+QWYgGpmFhEshtKX8r8eW5Sw55Y7JZDBqiGS8UtwwtmZLvSDPiKfNwbgWPZ/JABiccF539X9uizoeARer9635tNyqQqVUcVE4MNFgcsSKxDtPYIdTfM53cRJIJ0VuI0xjiNI9Y0jAvs/yfPk8iNGExep8ZN75ttrQ9BxtTZpxBoKLcrOYBCm/VCI2Czwb9duw==;5:XppHcOIyBfWTzrim25HVHy4SJlMZLuT8VIxEADXD87N+WeHUQhywRHZusmtpKuf/F6DhDsmX7z5JlzkyMKtCh7PmGfsuTfVxl/LXHFChxc18MatcXAcNmY8nXltVd/hxtaG4rO0qih2LvV04cGIQXyjxZ483f8lUwVoLmvONco4=;7:7N2S2zPI1NhVlJkuahbLExXbmZNVg3ffXxSrXarMgCKSMFZBTTcK9XBlE4ReMXDCU4urw/ZZk6RelhbWtcbYdA/k7XvAlpuDgGZI7nfxFMPpTpMr9ONyu2ukjli1tSnwynLSijqSPuaB0p9kEWQX/A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 73a7efc7-e6b1-4093-b7c6-08d6599730c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3692;
x-ms-traffictypediagnostic: DB3PR0402MB3692:
x-microsoft-antispam-prvs: <DB3PR0402MB3692D3342A4A4536B80A3EE0F5AF0@DB3PR0402MB3692.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3692;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3692;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(13464003)(199004)(189003)(11346002)(1411001)(486006)(316002)(8676002)(54906003)(97736004)(81166006)(68736007)(71200400001)(81156014)(71190400001)(53936002)(106356001)(256004)(186003)(14454004)(229853002)(105586002)(2906002)(15650500001)(6506007)(7736002)(53546011)(476003)(86362001)(14444005)(102836004)(25786009)(8936002)(305945005)(39060400002)(5660300001)(99286004)(478600001)(6436002)(7696005)(6116002)(6246003)(3846002)(4326008)(66066001)(9686003)(33656002)(76176011)(55016002)(44832011)(26005)(74316002)(446003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3692;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ob9+JrFxeMoYVH8viwtHdbNz6S9T8LpAMkxVgVaHFNWg3mGUn5m0MoE9zsfZVNm6L1WiaHhbJVmTEysOaNabeehVXIUUf+9MplxYamrAlOw58zpNPpj4zwQH7hT4CBxsdM5VpsnQpUbmY/z3kIuKXJjhZgRq1L2unglTTn8lXvd4csYZw/NoNzcmRCwTmaCM6C0wmQim8kSji7JUuU16/ni1gLm+jE/5Axz+S6WTL1sXy2eFcMcRoTo615Hdaj0OVQIzNlsfcnkvGUYL+BXRy35sIMHnCkUESsg6E520e69m1D4/Ur85+fqZ6qlJGt19y2z+cAnR1WNzdGeb5e2WnNSTXvOnONwvbQhUR9EjaSU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a7efc7-e6b1-4093-b7c6-08d6599730c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 03:18:41.1364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdt
YWlsLmNvbV0NCj4gU2VudDogMjAxOOW5tDEy5pyIM+aXpSAyMDowMw0KPiBUbzogQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5l
bC5vcmc+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBTYXNjaGEg
SGF1ZXIgPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvDQo+IEVzdGV2YW0gPGZhYmlvLmVz
dGV2YW1AbnhwLmNvbT47IFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eA0KPiA8bGludXhAYXJtbGlu
dXgub3JnLnVrPjsgbW9kZXJhdGVkIGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJNDQo+
IEFSQ0hJVEVDVFVSRSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGlu
dXgta2VybmVsDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gQVJNOiBpbXg6IHVw
ZGF0ZSB0aGUgY3B1IHBvd2VyIHVwIHRpbWluZyBzZXR0aW5nDQo+IA0KPiBPbiBNb24sIERlYyAz
LCAyMDE4IGF0IDk6NDIgQU0gRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+IE9uIE1vbiwgRGVjIDMsIDIwMTggYXQgMTI6NDUgQU0gQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IFRoZSBzdzJp
c28gY291bnQgc2hvdWxkIGNvdmVyIEFSTSBMRE8gcmFtcC11cCB0aW1lLCB0aGUgTUFYIEFSTSBM
RE8NCj4gPiA+IHJhbXAtdXAgdGltZSBtYXkgYmUgdXAgdG8gbW9yZSB0aGFuIDEwMHVzIG9uIHNv
bWUgYm9hcmRzLCB0aGlzIHBhdGNoDQo+ID4gPiBzZXRzIHN3MmlzbyB0byAweGYNCj4gPiA+ICh+
Mzg0dXMpIHdoaWNoIGlzIHRoZSByZXNldCB2YWx1ZSwgYW5kIGl0IGlzIG11Y2ggbW9yZSBzYWZl
IHRvIGNvdmVyDQo+ID4gPiBkaWZmZXJlbnQgYm9hcmRzLCBzaW5jZSB3ZSBoYXZlIG9ic2VydmVk
IHRoYXQgc29tZSBjdXN0b21lciBib2FyZHMNCj4gPiA+IGZhaWxlZCB3aXRoIGN1cnJlbnQgc2V0
dGluZyBvZiAweDIuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IDA1MTM2ZjA4OTdiNSAoIkFSTTogaW14
OiBzdXBwb3J0IGFybSBwb3dlciBvZmYgaW4gY3B1aWRsZSBmb3INCj4gPiA+IGkubXg2c3giKQ0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+
ID4NCj4gPiBSZXZpZXdlZC1ieTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0K
PiANCj4gTWlub3Igbml0IHRoYXQgbWF5YmUgU2hhd24gY2FuIGZpeCB3aGlsZSBhcHBseWluZyBp
dDogU3ViamVjdCBzaG91bGQgY29udGFpbg0KPiBpbXg2c3ggYXMgdGhpcyBjaGFuZ2Ugb25seSBh
ZmZlY3QgdGhpcyBTb0MuDQoNCkkgc2VudCBvdXQgdGhlIFYyIHBhdGNoIHRvIGVhc3kgU2hhd24n
cyB3b3JrLiBUaGFua3MuDQoNCkFuc29uLg0KDQo=
