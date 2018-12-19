Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5877C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF64218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="RO2l4PhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbeLSPMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:12:21 -0500
Received: from mail-eopbgr20134.outbound.protection.outlook.com ([40.107.2.134]:15799
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728746AbeLSPMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/vO9mgShZenUz1A9N7XTadlOHd/TpKKmGtTuD2TTuY=;
 b=RO2l4PhLUz7rsilteQ1UcmOGG12T6Mq5kgqoYRtfZPjNfEgH+5TNv+ng2W+JjALt65/WNE7SYQ5v6uemE5/5s9mVUvDQk3LgfDFmOrdmAQfUTzSVyhev10cSI5RybS1jwNfGIvrB+LZZyIxEZ6ej86p4OUsrIUSSgsUJZZnYgSU=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2109.eurprd05.prod.outlook.com (10.167.196.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Wed, 19 Dec 2018 15:11:33 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5808:701d:d1ac:9df8]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::5808:701d:d1ac:9df8%5]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 15:11:33 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "lukma@denx.de" <lukma@denx.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>
Subject: Re: [REGRESSION] imx_v6_v7_defconfig: undefined reference to
 `__hyp_stub_vectors'
Thread-Topic: [REGRESSION] imx_v6_v7_defconfig: undefined reference to
 `__hyp_stub_vectors'
Thread-Index: AQHUl5hS3YQwM2HAUkyF1f0Av+JOLaWGCwaAgAAEEoCAAA2lgIAADlIA
Date:   Wed, 19 Dec 2018 15:11:33 +0000
Message-ID: <de72ae0470f02d34833a3f2bd0521a94ae83b3eb.camel@toradex.com>
References: <fcbce8f7ba22014a8f06b7f52ad56faaa03b948b.camel@toradex.com>
         <8d6905f9aed82a0181d1d8eb2259946c47825a7f.camel@nxp.com>
         <CAEnQRZAHE77GsaES--LtWs3F4uHP2ePp3-KmP4xmZDh7NM4njw@mail.gmail.com>
         <CAOMZO5AmaQgz+X_dYgafVYHooY649CBBP6ERbX6B+Gt_A-1s5A@mail.gmail.com>
In-Reply-To: <CAOMZO5AmaQgz+X_dYgafVYHooY649CBBP6ERbX6B+Gt_A-1s5A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2109;6:mwfrJP+cVGqD5q34Vka4Or1MtYoZWkiV0SozxTzgOsYItLnYjTgbXYfPyElVpXtd1oym0EWLIVSqlxetOgwoRV/fUj9U6inMzq2L/06tA24ExHl09eEuUU4bF8q8kZwuuWx5eSqb29qyJE1EYquRukbce7ik+lfX85jbPdIGaNOzccquCh80MbtnxW5vmiL7wQY4jpO5MbpRxyGfO3JLyvetuGyvMlnMr6IwFwpN4AvmB+EevV9zfQ6/GSJtFL67RjXeykNJhihKzruvRrAjfULps4XGh4CoMqcCMOG7VYJo8KhU2APvrPTIlJ0m3LfaCupwVDpwPNnz/M2SBP7zh8V/8ygUOAUxJ+oOJ8UK+2kZ4yeeZFWE9dW50ccerY6x/8Yk85V9wzPHbkIlYnSPaLulVolpyh+De31QuWW2KKAHT/Z80epyS9pq7FxqF2PJ88ITXShlFohMVJh7jZkuhQ==;5:+uBEnmcJ4EvzEzWVzs7KkB6VtIIqNe1KfAu/i2UPi3qhFBOEbFer9axFSVTBohulAmE0lN12KHQVAvn0/Ao/0pPoUR7jrNu6yGsZ7PFDYfVJMHDQbqFIzIYxMgAejUI6IURXvqOeydaifZNTi49py0I9NOJXoz3M63M7PEW+J/Y=;7:XClMoOBTLqe+YsE7+G2XWR1eG5NbkhlFWhQf+yAEJgqMK+gb5P3n6hI6Ebb/oBUGTQgkcblIkN7fxFNnjEnwtexzPjETnnBefojVanI2OE7uFldxMgPP0bMSaINNbJHdaW2Y0HmdavTYvZPgaCiQmA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3789cbfb-f3eb-4131-2b73-08d665c44347
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2109;
x-ms-traffictypediagnostic: VI1PR0501MB2109:
x-microsoft-antispam-prvs: <VI1PR0501MB210941A04EC6BC8EA74B0CD7FBBE0@VI1PR0501MB2109.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(4982022)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0501MB2109;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2109;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(136003)(346002)(396003)(366004)(199004)(189003)(186003)(7736002)(71200400001)(71190400001)(8936002)(8676002)(3846002)(6116002)(81156014)(81166006)(2201001)(25786009)(6486002)(86362001)(6306002)(6512007)(2906002)(105586002)(106356001)(5660300001)(76176011)(68736007)(53936002)(118296001)(256004)(14444005)(6436002)(102836004)(26005)(6246003)(4326008)(36756003)(39060400002)(6506007)(53546011)(97736004)(508600001)(2616005)(110136005)(4001150100001)(316002)(476003)(99286004)(66066001)(54906003)(14454004)(11346002)(446003)(44832011)(93886005)(2501003)(305945005)(966005)(486006)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2109;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xI+MlgkBHuN4OwPiet3fT+xFngHqFgbM9HHD5CXjTcR/Ev+FmpxseTSidlIPmZj0oN1G1G3r7PdY1Hi0UVvdI4OtB7N5t/mz0PEfZplQBU647AWRyC2nk26vQ8MZeUQs2oEI1xgkG0/U+UEr3Zv3U5EF6iR4pYoyHwfBUF6oWYP2mOS1I3KjdDGUnSEYAbK5mxnGUXWlc7bGxhLqLiUOYzjqbS+UXc5n6sKARLnpPI/1tvsqeUeRILUUEihcMxjOM60bZmu5KB7PohVQ+vJ0NWLtxaayul68H+Gvmtaihra0fFqAijcmvj76zQX2rP41
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EF404B5E1FD664F9BAEE9EE6D1A5F40@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3789cbfb-f3eb-4131-2b73-08d665c44347
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 15:11:33.4986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEyLTE5IGF0IDEyOjIwIC0wMjAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBIaSBEYW5pZWwsDQo+IA0KPiBPbiBXZWQsIERlYyAxOSwgMjAxOCBhdCAxMTozMiBBTSBEYW5p
ZWwgQmFsdXRhIDwNCj4gZGFuaWVsLmJhbHV0YUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IE9uIFdl
ZCwgRGVjIDE5LCAyMDE4IGF0IDM6MTcgUE0gRGFuaWVsIEJhbHV0YSA8DQo+ID4gZGFuaWVsLmJh
bHV0YUBueHAuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24gV2VkLCAyMDE4LTEyLTE5IGF0
IDEyOjQyICswMDAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4gPiA+IEhpIHRoZXJlDQo+
ID4gPiA+IA0KPiA+ID4gPiBJIG5vdGljZWQgdGhhdCBhdCBsZWFzdCB0b2RheSdzIGFuZCB5ZXN0
ZXJkYXlzIC1uZXh0IHdvbid0DQo+ID4gPiA+IGJ1aWxkIHdpdGgNCj4gPiA+ID4gdGhlIGlteF92
Nl92N19kZWZjb25maWcgZ2l2aW5nIHRoZSBmb2xsb3dpbmcgZXJyb3I6DQo+ID4gPiA+IA0KPiA+
ID4gPiAgIExEICAgICAgYXJjaC9hcm0vYm9vdC9jb21wcmVzc2VkL3ZtbGludXgNCj4gPiA+ID4g
YXJjaC9hcm0vYm9vdC9jb21wcmVzc2VkL2hlYWQubzogSW4gZnVuY3Rpb24gYHJlc3RhcnQnOg0K
PiA+ID4gPiAoLnRleHQrMHhhOCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYF9faHlwX3N0dWJf
dmVjdG9ycycNCj4gPiA+ID4gKC50ZXh0KzB4YWMpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBf
X2h5cF9zdHViX3ZlY3RvcnMnDQo+ID4gPiA+IA0KPiA+ID4gPiBIYXMgYW55Ym9keSBzZWVuIHRo
YXQgYXMgd2VsbCBhbmQga25vd3Mgd2hhdCBpcyBnb2luZyBvbj8NCj4gPiA+IA0KPiA+ID4gSG1t
LCB3b3JrcyBmb3IgbWUuDQo+IA0KPiBZZXMsIEkgaGF2ZW4ndCBzZWVuIGJ1aWxkIGZhaWx1cmVz
IHJlcG9ydGVkIGJ5IHRoZSBhdXRvYnVpbGRlcnM6DQo+IGh0dHA6Ly9raXNza2IuZWxsZXJtYW4u
aWQuYXUva2lzc2tiL3RhcmdldC83NDY0Lw0KDQpIbSwgc3RyYW5nZS4gQSBjbGVhbiByZS1idWls
ZCB1c2luZyBBUk0ncyBsYXRlc3QgZ2NjIDguMi4xIG5vdyB3b3JrZWQNCmZpbmUgYXMgd2VsbC4g
U29ycnksIGZvciB0aGUgbm9pc2UuDQoNCj4gPiBPbiB0aGUgb3RoZXIgaGFuZCBJJ20gZ2V0dGlu
ZyB0aGlzIHdhcm5pbmc6DQo+ID4gDQo+ID4gYXJjaC9hcm0vYm9vdC9kdHMvdmZ4eHguZHRzaTo1
NTAuMjQtNTYzLjY6IFdhcm5pbmcNCj4gPiAoc3BpX2J1c19icmlkZ2UpOg0KPiA+IC9zb2MvYWlw
cy1idXNANDAwODAwMDAvc3BpQDQwMGFkMDAwOiBpbmNvcnJlY3QgI2FkZHJlc3MtY2VsbHMgZm9y
DQo+ID4gU1BJDQo+ID4gYnVzDQo+ID4gICBhbHNvIGRlZmluZWQgYXQgYXJjaC9hcm0vYm9vdC9k
dHMvdmY2MTAtYms0LmR0czoxMDcuOC0xMTkuMw0KPiA+IGFyY2gvYXJtL2Jvb3QvZHRzL3ZmNjEw
LWJrNC5kdGI6IFdhcm5pbmcgKHNwaV9idXNfcmVnKTogRmFpbGVkDQo+ID4gcHJlcmVxdWlzaXRl
ICdzcGlfYnVzX2JyaWRnZScNCj4gPiANCj4gPiANCj4gPiBNYXliZSBSb2IgY2FuIGp1bXAgaW4/
DQo+IA0KPiBZZXMsIEkgaGF2ZSBhbHJlYWR5IHJlcG9ydGVkIHRoaXMgd2FybmluZyB0byBSb2Ig
YW5kIEx1a2Fzei4NCj4gSG9wZWZ1bGx5DQo+IHRoZXkgY291bGQgaGVscCBmaXhpbmcgaXQuDQo=
