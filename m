Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6A9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF2621903
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I7e52gwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfABQ3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:29:48 -0500
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:10483
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729471AbfABQ3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puLPhN0xx7eZSJ+mz+4foNcr/FprDpQGvXjuSAAedfA=;
 b=I7e52gwLW6G88QHQRjpUeOJQI/JyMc4JZXIiL5ih+RFY7inHT2cHafmy2dnPreuMfZfbWFbLEnSnE3iczebq2JdsY95Qm17N7qEpnrFEoQOCHyhEO+QKM10SHjFknLQV8vO2XZiUhV0j23Lw8ciffwWOskQsESCwJ7RsrBij+MY=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5220.eurprd04.prod.outlook.com (20.177.42.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Wed, 2 Jan 2019 16:29:41 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%4]) with mapi id 15.20.1495.005; Wed, 2 Jan 2019
 16:29:41 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dongas86@gmail.com" <dongas86@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
Thread-Topic: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
Thread-Index: AQHUngerKaedheUOE0OdzOpUuVXDP6WUSj8AgAD3l8CABpO7AIAASp8g
Date:   Wed, 2 Jan 2019 16:29:41 +0000
Message-ID: <AM0PR04MB421124AE755C01CEEC0CF31D808C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFrP8HOum_4S0-4Bx+sYbTNSyctv3rQDB78zozeNWOuv=A@mail.gmail.com>
 <AM0PR04MB42117D773477A408462D19D180B00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CAPDyKFq4eji_FVKrRJ2k=c1iKuVP_3aERspy6vpXQzeFdBYt9w@mail.gmail.com>
In-Reply-To: <CAPDyKFq4eji_FVKrRJ2k=c1iKuVP_3aERspy6vpXQzeFdBYt9w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5220;6:2qEiRyQFFKTgtBFykD8lsTLXVYvtOUSVLxLslZ+itXt0LZHm6HORgDjPrOaKsSuTcd+YYv8k9blmqWmmdfshcFOGxgZc38Xm608/9HgOllMq4ej73a5MAdiA7+NKPe5HFfQc8M8kvgRY0T+JKKv1UT9zAIKOpsk0xmzFC+owOh2Y1Fx81C1NGZC17LACJUkimfpn+CwbQfndm2tlsU6zBJH2owCYbibzupNF2KFNgGplbFznE08P1J0CIrxDsD/kJM+/bFFNRVtMfQDqmEWVIqgrNWesItzfZZ/ToZLcjV/IjQ5X8PfoI62F691RcZOFiO9S0688OTAAFVHAwAnrmT1YnTwEZkM3MYsOn43uWplZaN0iccvno2ZiMZMXNko3AlzxR1KZLTRs/8lAM3/wkkOy4ICIAfJ86wFV0F9OY5mpqfWSzl/NuyaIS8ICLFrbHD8E3Nsl+afF+x6VzGS2HQ==;5:+pPrtzryJb0HzYKdEiR1P/knrPN2o4+9LEMvp1QQngkFAlEsDPFBqyq7HU1smAAAERGL+cBKj40ne+nX9UvDPEDJEt6Xj1bL3jKLJXFRNcV0xrEp2M+YHdD2YmvE9PkxUCouU4s2aN9pEE67+E78SiD0kwwte+BjkDnhxAmUO0M=;7:7EMWsUy+fTsWjEj53rHDwayk+/bjJOsZ1e514APnn+uIzcEJJEiLVqCaFS5q1vK8VMZx5Lw0OE71keyAY64GvYfYk1SVO1ZtVKJZN8+mT7B/QhSTQ3TNGUw7YIwtZuD2VBMmTihXpfXFBA4LxOKMrQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2d746053-0c12-429a-9089-08d670cf7f47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5220;
x-ms-traffictypediagnostic: AM0PR04MB5220:
x-microsoft-antispam-prvs: <AM0PR04MB5220CC6861678148D23E4C70808C0@AM0PR04MB5220.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5220;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5220;
x-forefront-prvs: 0905A6B2C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(376002)(346002)(52314003)(199004)(51914003)(189003)(13464003)(54534003)(8936002)(102836004)(66066001)(6506007)(14454004)(7696005)(81166006)(3846002)(81156014)(6116002)(76176011)(5660300001)(186003)(256004)(486006)(44832011)(5024004)(217873002)(6916009)(26005)(8676002)(478600001)(7416002)(11346002)(446003)(7736002)(476003)(2906002)(86362001)(305945005)(39060400002)(6246003)(74316002)(99286004)(25786009)(106356001)(6436002)(316002)(9686003)(68736007)(54906003)(97736004)(93886005)(229853002)(71190400001)(53936002)(55016002)(33656002)(71200400001)(105586002)(4326008)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5220;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GWoHWDHrsLdNWtlp7GdEhmwAXN/0KiwHlmP5asjjIe4Sc5Da1cmTLzxflc3rnSA+hd2U9he/JM5Kvi6bsyZ0gWq6Va9apq9xO9cvuvsyMGQhB1F1Y+UcSe4QRmSn5+z3nfJ3/9TwF0rPSQrSFbVsPzwoi24nSDKCtzsgIJ3I1egs6sW+WRGYfvilU2MbH4+4h9//hd8XliRpyDbMc5SWID34BbIBlvmQ/0EXpX8qYG8MIbeJN4efWu7KBz/fFNsCHjHSpyRaSNEkg5OAWGwx37TEml0iux7R2G0OomqiwYYJQ2f2yTxmMtCC6t6+otdk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d746053-0c12-429a-9089-08d670cf7f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 16:29:41.4816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiBbbWFpbHRv
OnVsZi5oYW5zc29uQGxpbmFyby5vcmddDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyLCAy
MDE5IDY6NDkgUE0NCj4NCj4gT24gU2F0LCAyOSBEZWMgMjAxOCBhdCAwNzo0MywgQWlzaGVuZyBE
b25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206IFVsZiBI
YW5zc29uIFttYWlsdG86dWxmLmhhbnNzb25AbGluYXJvLm9yZ10NCj4gPiA+IFNlbnQ6IEZyaWRh
eSwgRGVjZW1iZXIgMjgsIDIwMTggMTE6MzcgUE0NCj4gPiA+DQo+ID4gPiBPbiBUaHUsIDI3IERl
YyAyMDE4IGF0IDE4OjE0LCBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+
ID4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEN1cnJlbnRseSBhdHRhY2hfZGV2KCkgaW4gcG93
ZXIgZG9tYWluIGluZnJhc3RydWN0dXJlIHN0aWxsIGRvZXMNCj4gPiA+ID4gbm90IHN1cHBvcnQg
bXVsdGkgZG9tYWlucyBjYXNlIGFzIHRoZSBzdHJ1Y3QgZGV2aWNlICpkZXYgcGFzc2VkDQo+ID4g
PiA+IGRvd24gZnJvbQ0KPiA+ID4gPiBnZW5wZF9kZXZfcG1fYXR0YWNoX2J5X2lkKCkgaXMgYSB2
aXJ0dWFsIFBEIGRldmljZSwgaXQgZG9lcyBub3QNCj4gPiA+ID4gaGVscCBmb3IgcGFyc2luZyB0
aGUgcmVhbCBkZXZpY2UgaW5mb3JtYXRpb24gZnJvbSBkZXZpY2UgdHJlZSwgZS5nLg0KPiA+ID4g
PiBEZXZpY2UvUG93ZXIgSURzLCBDbG9ja3MgYW5kIGl0J3MgdW53YXJlIG9mIHdoaWNoIHJlYWwg
cG93ZXINCj4gPiA+ID4gZG9tYWluIHRoZSBkZXZpY2Ugc2hvdWxkIGF0dGFjaC4NCj4gPiA+DQo+
ID4gPiBUaGFua3MgZm9yIHdvcmtpbmcgb24gdGhpcyENCj4gPiA+DQo+ID4gPiBJIHdvdWxkIGFw
cHJlY2lhdGUgaWYgdGhlIGNoYW5nZWxvZyBjb3VsZCBjbGFyaWZ5IHRoZSBwcm9ibGVtIGEgYml0
Lg0KPiA+ID4gUGVyaGFwcyBzb21ldGhpbmcgYWxvbmcgdGhlIGxpbmVzIG9mIHRoZSBiZWxvdy4N
Cj4gPiA+DQo+ID4NCj4gPiBTb3VuZHMgZ29vZCB0byBtZS4NCj4gPiBJIHdpbGwgYWRkIHRoZW0g
aW4gY29tbWl0IG1lc3NhZ2UuDQo+ID4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCj4gPg0K
PiA+ID4gIkEgZ2VucGQgcHJvdmlkZXIncyAtPmF0dGFjaF9kZXYoKSBjYWxsYmFjayBtYXkgYmUg
aW52b2tlZCB3aXRoIGEgc28NCj4gPiA+IGNhbGxlZCB2aXJ0dWFsIGRldmljZSwgd2hpY2ggaXMg
Y3JlYXRlZCBieSBnZW5wZCwgYXQgdGhlIHBvaW50IHdoZW4NCj4gPiA+IGEgZGV2aWNlIGlzIGJl
aW5nIGF0dGFjaGVkIHRvIG9uZSBvZiBpdHMgY29ycmVzcG9uZGluZyBtdWx0aXBsZSBQTQ0KPiBk
b21haW5zLg0KPiA+ID4NCj4gPiA+IEluIHRoZXNlIGNhc2VzLCB0aGUgZ2VucGQgcHJvdmlkZXIg
ZmFpbHMgdG8gbG9vayB1cCBhbnkgcmVzb3VyY2UsIGJ5DQo+ID4gPiBhDQo+ID4gPiBjbGtfZ2V0
KCkgZm9yIGV4YW1wbGUsIGZvciB0aGUgdmlydHVhbCBkZXZpY2UgaW4gcXVlc3Rpb24uIFRoaXMg
aXMNCj4gPiA+IGJlY2F1c2UsIHRoZSB2aXJ0dWFsIGRldmljZSB0aGF0IHdhcyBjcmVhdGVkIGJ5
IGdlbnBkLCBkb2VzIG5vdCBoYXZlDQo+ID4gPiB0aGUgdmlydF9kZXYtPm9mX25vZGUgYXNzaWdu
ZWQuIg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gRXh0ZW5kIHRoZSBmcmFtZXdvcmsgYSBiaXQg
dG8gc3RvcmUgdGhlIG11bHRpIFBNIGRvbWFpbnMNCj4gPiA+ID4gaW5mb3JtYXRpb24gaW4gcGVy
LWRldmljZSBzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW5fZGF0YSwgdGhlbg0KPiA+ID4gPiBwb3dl
ciBkb21haW4gZHJpdmVyIGNvdWxkIHJldHJpZXZlIGl0IGZvciBuZWNlc3Nhcnkgb3BlcmF0aW9u
cyBkdXJpbmcNCj4gYXR0YWNoX2RldigpLg0KPiA+ID4gPg0KPiA+ID4gPiBUd28gbmV3IEFQSXMg
Z2VucGRfaXNfbXBkX2RldmljZSgpIGFuZCBkZXZfZ3BkX21wZF9kYXRhKCkgYXJlIGFsc28NCj4g
PiA+ID4gaW50cm9kdWNlZCB0byBlYXNlIHRoZSBkcml2ZXIgb3BlcmF0aW9uLg0KPiA+ID4gPg0K
PiA+ID4gPiBDYzogIlJhZmFlbCBKLiBXeXNvY2tpIiA8cmp3QHJqd3lzb2NraS5uZXQ+DQo+ID4g
PiA+IENjOiBLZXZpbiBIaWxtYW4gPGtoaWxtYW5Aa2VybmVsLm9yZz4NCj4gPiA+ID4gQ2M6IFVs
ZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+ID4gPiBDYzogR3JlZyBLcm9h
aC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+
ID4gPiA+IFRoaXMgcGF0Y2ggaXMgYSBmb2xsb3ctdXAgd29yayBvZiB0aGUgZWFybGllciBkaXNj
dXNzaW9uIHdpdGggVWxmDQo+ID4gPiA+IEhhbnNzb24gYWJvdXQgdGhlIG11bHRpIFBNIGRvbWFp
bnMgc3VwcG9ydCBmb3IgdGhlIGF0dGFjaF9kZXYoKQ0KPiA+ID4gPiBmdW5jdGlvbg0KPiA+ID4g
WzFdLg0KPiA+ID4gPiBBZnRlciBhIGJpdCBtb3JlIHRoaW5raW5nLCB0aGlzIGlzIGEgbGVzcyBp
bnRydXNpdmUgaW1wbGVtZW50YXRpb24NCj4gPiA+ID4gd2l0aCB0aGUgbWluaW51bSBpbXBhY3Qg
b24gdGhlIGV4aXN0IGZ1bmN0aW9uIGRlZmluaXRpb25zIGFuZA0KPiA+ID4gPiBjYWxsaW5nDQo+
ID4gPiBmb2xsb3dzLg0KPiA+ID4gPiBPbmUga25vd24gbGl0dGxlIGRyYXdiYWNrIGlzIHRoYXQg
d2UgaGF2ZSB0byB1c2UgdGhlIGRldmljZSBkcml2ZXINCj4gPiA+ID4gcHJpdmF0ZSBkYXRhIChk
ZXZpY2UuZHJ2ZGF0YSkgdG8gcGFzcyBkb3duIHRoZSBtdWx0aSBkb21haW5zDQo+ID4gPiA+IGlu
Zm9ybWF0aW9uIGluIGEgZWFybGllciB0aW1lLiBIb3dldmVyLCBhcyBtdWx0aSBQRCBkZXZpY2Vz
IGFyZQ0KPiA+ID4gPiBjcmVhdGVkIGJ5IGRvbWFpbiBmcmFtZXdvcmssIHRoaXMgc2VlbXMgdG8g
YmUgc2FmZSB0byB1c2UgaXQgaW4NCj4gPiA+ID4gZG9tYWluIGNvcmUgY29kZSBhcyBkZXZpY2Ug
ZHJpdmVyIGlzIG5vdCBsaWtlbHkgZ29pbmcgdG8gdXNlIGl0Lg0KPiA+ID4gPiBBbnl3YXksIGlm
IGFueSBiZXR0ZXIgaWRlYXMsIHBsZWFzZSBsZXQgbWUga25vdy4NCj4gPiA+ID4NCj4gPiA+ID4g
V2l0aCB0aGUgdHdvIG5ldyBBUElzLCB0aGUgdXNpbmcgY2FuIGJlIHNpbXBseSBhczoNCj4gPiA+
ID4gc3RhdGljIGludCB4eHhfYXR0YWNoX2RldihzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmRv
bWFpbiwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICpk
ZXYpIHsNCj4gPiA+ID4gICAgICAgICAuLi4NCj4gPiA+ID4gICAgICAgICBpZiAoZ2VucGRfaXNf
bXBkX2RldmljZShkZXYpKSB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICBtcGRfZGF0YSA9IGRl
dl9ncGRfbXBkX2RhdGEoZGV2KTsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIG5wID0gbXBkX2Rh
dGEtPnBhcmVudC0+b2Zfbm9kZTsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGlkeCA9IG1wZF9k
YXRhLT5pbmRleDsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIC8vZHRzIHBhcnNpbmcNCj4gPiA+
ID4gICAgICAgICAgICAgICAgIC4uLg0KPiA+ID4gPiAgICAgICAgIH0NCj4gPiA+ID4gICAgICAg
ICAuLi4NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIHdlIGNhbiBtYWtlIHRoaXMgYSBsb3QgbGVzcyBj
b21wbGljYXRlZC4gSnVzdCBhc3NpZ24NCj4gPiA+IHZpcnRfZGV2LT5vZl9ub2RlID0gb2Zfbm9k
ZV9nZXQoZGV2LT5vZl9ub2RlKSwgc29tZXdoZXJlIGluDQo+ID4gPiBnZW5wZF9kZXZfcG1fYXR0
YWNoX2J5X2lkKCkgYW5kIGJlZm9yZSBjYWxsaW5nDQo+IF9fZ2VucGRfZGV2X3BtX2F0dGFjaCgp
Lg0KPiA+ID4NCj4gPiA+IERvaW5nIHRoYXQsIHdvdWxkIG1lYW4gdGhlIGdlbnBkIHByb3ZpZGVy
J3MgLT5hdHRhY2hfZGV2KCkgY2FsbGJhY2ssDQo+ID4gPiBkb24ndCBoYXZlIHRvIGRpc3Rpbmd1
aXNoIGJldHdlZW4gdmlydHVhbCBhbmQgbm9uLXZpcnR1YWwgZGV2aWNlcy4NCj4gPiA+IEluc3Rl
YWQgdGhleSBzaG91bGQgYmUgYWJsZSB0byBsb29rIHVwIHJlc291cmNlcyBpbiB0aGUgc2FtZSB3
YXkgYXMNCj4gPiA+IHRoZXkgZGlkIGJlZm9yZS4NCj4gPiA+DQo+ID4NCj4gPiBZZXMsIHRoYXQg
c2VlbXMgbGlrZSBhIHNtYXJ0IHdheS4NCj4gPiBCdXQgdGhlcmUncyBzdGlsbCBhIHJlbWFpbiBw
cm9ibGVtIHRoYXQgaG93IGFib3V0IHRoZSBkb21haW4gaW5kZXgNCj4gPiBpbmZvcm1hdGlvbiBu
ZWVkZWQgZm9yIGF0dGFjaF9kZXYoKT8NCj4gPg0KPiANCj4gV2hhdCBkbyB5b3UgbWVhbiBieSBk
b21haW4gaW5kZXg/DQo+DQoNCkFzIHdlJ3JlIHVzaW5nIG11bHRpIHBvd2VyIGRvbWFpbnMgaW4g
RGV2aWNldHJlZSwgYXR0YWNoX2RldigpIG5lZWRzIHRvIA0Ka25vdyB3aGljaCBwb3dlciBkb21h
aW4gdGhlIGRldmljZSBpcyBnb2luZyB0byBhdHRhY2guDQplLmcuDQpzZGhjMTogbW1jQDViMDEw
MDAwIHsNCiAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC11c2RoYyIsICJmc2wsaW14
N2QtdXNkaGMiOw0KICAgICAgICBwb3dlci1kb21haW5zID0gPCZwZCBJTVhfU0NfUl9TREhDXzA+
LCA8JnBkIElNWF9TQ19SX1NESENfMT47ICAgLy8gZm9yIHRlc3Qgb25seQ0KICAgICAgICAuLi4g
ICAgIA0KfTsNClRoZW4gYXR0YWNoX2RldigpIGNhbiBwYXJzZSB0aGUgY29ycmVjdCAicmVzb3Vy
Y2UgaWQiIChlLmcuIElNWF9TQ19SX1NESENfMSkgZnJvbSBkZXZpY2UgdHJlZQ0KQW5kIHN0b3Jl
IGl0IGluIHBlci1kZXZpY2Ugc3RydWN0IGdlbmVyaWNfcG1fZG9tYWluX2RhdGEgZm9yIGxhdGVy
IHN0YXJ0KCkvc3RvcCgpIHVzaW5nLg0KDQo+IFRoZSAtPmF0dGFjaF9kZXYoKSBpcyBnaXZlbiBi
b3RoIHRoZSBkZXZpY2UgYW5kIHRoZSBnZW5wZCBpbiBxdWVzdGlvbiBhcw0KPiBpbi1wYXJhbWV0
ZXJzLiBDb3VsZCB5b3Ugc3RvcmUgdGhlIGRvbWFpbiBpbmRleCBhcyBwYXJ0IG9mIHlvdXIgZ2Vu
cGQgc3RydWN0Pw0KPiBObz8NCj4gDQoNCkFGQUlDVCBuby4NCldpdGggdGhlIG9ubHkgZGV2aWNl
IGFuZCB0aGUgZ2VucGQgYXMgaW4tcGFyYW1ldGVycywgdGhlIC0+YXR0YWNoX2RldigpIGRvbid0
IGtub3cNCndoaWNoIHBvd2VyIGRvbWFpbiB0byB0byBwYXJzZSBmcm9tIGRldmljZSB0cmVlLg0K
VGh1cyBubyB3YXkgdG8gc3RvcmUgaXQgaW4gZ2VucGQgc3RydWN0Lg0KDQo+IElmIHlvdSBhcmUg
dGFsa2luZyBhYm91dCB1c2luZyB0aGUgInBvd2VyLWRvbWFpbnMiIHNwZWNpZmllciBmcm9tIHRo
ZSBEVCBub2RlDQo+IG9mIHRoZSBkZXZpY2UsIHRoYXQgc2hvdWxkIHRoZW4gd29yaywgc2ltaWxh
ciB0byBhcyBiZWVuIGRvbmUNCj4gaW46DQo+IA0KPiBkcml2ZXJzL3NvYy90aS90aV9zY2lfcG1f
ZG9tYWlucy5jDQo+IHRpX3NjaV9wZF9hdHRhY2hfZGV2KCkNCj4gDQoNClRJIGFjdHVhbGx5IGRv
ZXMgbm90IHVzZSBtdWx0aSBQTSBkb21haW5zLiBTbyB0aGV5IGNhbiBhbHdheXMgcGFyc2UNCnRo
ZSBmaXJzdCBwb3dlciBkb21haW5zIHRvIGdldCB0aGUgY29ycmVjdCAicmVzb3VyY2UgaWQiIC8g
cG93ZXIgaWQuLg0KDQp3ZHQ6IHdkdEAwMjI1MDAwMCB7DQogICAgICAgIGNvbXBhdGlibGUgPSAi
dGksa2V5c3RvbmUtd2R0IiwgInRpLGRhdmluY2ktd2R0IjsNCiAgICAgICAgcG93ZXItZG9tYWlu
cyA9IDwmazJnX3BkcyAweDIyPjsNCn07ICANCg0Kc3RhdGljIGludCB0aV9zY2lfcGRfYXR0YWNo
X2RldihzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmRvbWFpbiwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2KQ0Kew0KICAgICAgICAuLi4NCgkJLy8g
dGhlIGluZGV4IGlzIGFsd2F5cyAwDQogICAgICAgIHJldCA9IG9mX3BhcnNlX3BoYW5kbGVfd2l0
aF9hcmdzKG5wLCAicG93ZXItZG9tYWlucyIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICIjcG93ZXItZG9tYWluLWNlbGxzIiwgMCwgJnBkX2FyZ3MpOw0KICAgICAg
ICBpZHggPSBwZF9hcmdzLmFyZ3NbMF07DQogICAgICAgIC4uLg0KfQ0KDQo+IFlvdSBtYXkgYWxz
byBwcm92aWRlIHlvdXIgb3duIHhsYXRlIGNhbGxiYWNrIGZvciB5b3VyIGdlbnBkIHByb3ZpZGVy
LCBsaWtlDQo+IHdoYXQgaXMgZG9uZSBpbiBkcml2ZXJzL3NvYy90ZWdyYS9wb3dlcmdhdGUtYnBt
cC4gLSBpZiB0aGF0IGhlbHBzIT8NCj4gDQoNCkknbSBhZnJhaWQgbm8uDQpQZXIgb3VyIGVhcmxp
ZXIgZGlzY3Vzc2lvbiwgd2UncmUgZ29pbmcgdG8gdXNlIGEgc2luZ2xlIGdsb2JhbCBwb3dlciBk
b21haW4NCihUZWdyYSBpcyBub3QpIGFuZCBpbXBsZW1lbnQgdGhlIC0+YXR0YWNofGRldGFjaF9k
ZXYoKSBjYWxsYmFjayBmb3IgdGhlIGdlbnBkDQphbmQgdXNlIHRoZSByZWd1bGFyIG9mX2dlbnBk
X2FkZF9wcm92aWRlcl9zaW1wbGUoKS4NCg0KRnJvbSB3aXRoaW4gdGhlIC0+YXR0YWNoX2Rldigp
LCB3ZSBjb3VsZCBnZXQgdGhlIE9GIG5vZGUgZm9yIHRoZSBkZXZpY2UgdGhhdCBpcw0KYmVpbmcg
YXR0YWNoZWQgYW5kIHRoZW4gcGFyc2UgdGhlIHBvd2VyLWRvbWFpbiBjZWxsIGNvbnRhaW5pbmcg
dGhlICJyZXNvdXJjZSBpZCINCmFuZCBzdG9yZSB0aGF0IGluIHRoZSBwZXIgZGV2aWNlIHN0cnVj
dCBnZW5lcmljX3BtX2RvbWFpbl9kYXRhICh3ZSBoYXZlIHZvaWQgcG9pbnRlcg0KdGhlcmUgZm9y
IHN0b3JpbmcgdGhlc2Uga2luZCBvZiB0aGluZ3MpLg0KDQpBZGRpdGlvbmFsbHksIHdlIG5lZWQg
aW1wbGVtZW50IHRoZSAtPnN0b3AoKSBhbmQgLT5zdGFydCgpIGNhbGxiYWNrcyBvZiBnZW5wZCwN
CndoaWNoIGlzIHdoZXJlIHdlICJwb3dlciBvbi9vZmYiIGRldmljZXMsIHJhdGhlciB0aGFuIHVz
aW5nIHRoZQ0KLT5wb3dlcl9vbnxvZmYoKSBjYWxsYmFja3MuDQoNCk5vdyB0aGUgcHJvYmxlbSBp
cyBjdXJyZW50IGF0dGFjaF9kZXYoKSBoYXMgbm8gaWRlYSB0byBwYXJzZSB0aGUgY29ycmVjdCBw
b3dlciBkb21haW4NCmNvbnRhaW5pbmcgdGhlICJyZXNvdXJjZSBpZCIuDQpUaGF0J3Mgd2h5IEkg
c3RvcmVkIGl0IGluIHBlci1kZXZpY2Ugc3RydWN0IGdlbmVyaWNfcG1fZG9tYWluX2RhdGEgYmVm
b3JlIGNhbGxpbmcNCmF0dGFjaF9kZXYoKSBpbiB0aGlzIHBhdGNoIGltcGxlbWVudGF0aW9uLg0K
DQpBbnkgaWRlYXM/DQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+IE9yIGFtIEkgbWlzc2lu
ZyBzb21ldGhpbmc/DQo+IA0KPiBbLi4uXQ0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==
