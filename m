Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE77C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818E6204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pJeGgEZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfACDK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 22:10:29 -0500
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:23830
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbfACDK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 22:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzRgTFc4C7ytXjhrb9R6bbs1QyZvCalmzwFfvIualfY=;
 b=pJeGgEZAy9aP0Zio0CzdggZQJ9h3NrbASh7mF4Pkns/Ic6TXQ6SN8d2Duje/lqnUmF90VA+PfTyzNaYAc7az6sx/xUx3NW0+vqjWDO1Y9wAHivmaivO9yJIbBywr8W4N9ay8pge9qbdGUdQ4R345jnVFU0BsBFU1Y6JV4/ePD98=
Received: from VI1PR04MB5135.eurprd04.prod.outlook.com (20.177.50.160) by
 VI1PR04MB5408.eurprd04.prod.outlook.com (20.178.121.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Thu, 3 Jan 2019 03:10:21 +0000
Received: from VI1PR04MB5135.eurprd04.prod.outlook.com
 ([fe80::c5c:ec01:4a6b:5f4b]) by VI1PR04MB5135.eurprd04.prod.outlook.com
 ([fe80::c5c:ec01:4a6b:5f4b%3]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 03:10:21 +0000
From:   Po Liu <po.liu@nxp.com>
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "haustad@cisco.com" <haustad@cisco.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Subject: RE: [PATCH] net: tsn: add an netlink interface between kernel and
 application layer
Thread-Topic: [PATCH] net: tsn: add an netlink interface between kernel and
 application layer
Thread-Index: AQHUnl7Q0OQhsXkvlE2k4BYXbHWC16WTgwIAgAAAzoCAAQbfAIAAXHywgAd3SICAAIPIoA==
Date:   Thu, 3 Jan 2019 03:10:20 +0000
Message-ID: <VI1PR04MB5135F7AAA3B9288316C822DC928D0@VI1PR04MB5135.eurprd04.prod.outlook.com>
References: <1545968772-7237-1-git-send-email-Po.Liu@nxp.com>
 <1545968945-7290-1-git-send-email-Po.Liu@nxp.com> <87r2e14fgr.fsf@intel.com>
 <VI1PR04MB51359EB3614797A89185C9D292B00@VI1PR04MB5135.eurprd04.prod.outlook.com>
 <87k1jm51ey.fsf@intel.com>
In-Reply-To: <87k1jm51ey.fsf@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=po.liu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5408;6:y+VtadwN8iD7zr0kSX+3UTXfZCDLpf/ZtJWkZ/SAYrGeSGUlYjuc/xAntcY2PQmh4MVj416oYPd1yKH7vS1SbkG7ST4+7vYB73y3NGD29RfI1XEaL5+oisE6T79vjv8xUaOLHsz2ydsvUiI/wS9OTlfteUW9IdMKexIPS3iEzYsOmrilbs05JVfhCfbHLtiERu7u190zFEeJrtIfQ5zDv1XS9NL5eiFtIgg5VONdVEmFHkAy6vKd+KkuK1BZJ95/t0GO/0YkM1tsS4YB6H9hzP562YBPuO0L84TFhTkoRFK+m/zhLqntnjzSorGvHuo5FfrGEyfQG46aTnn9j9fSUV/CF+Q8WMQLiiKnoGTcRYaYPoEjGEgVOfqNzYWtVjtEB4Yy4uWSx5t86XYfbp8k2/ejXysItL9WctX/PEBN6pYQdoWXJFMRosH2bc2ywWQ/T5MgF854mHVDORUMdxnEjA==;5:CtttSLHMgyAiZKLNX7Vguw/f4jOcecnwiCajzTkj29/gNh1YMSNP4fVNGfSUer+lhDrPAniCU6Ycxa+jsiGPbVwERfVb72PgCV8o/6wL3DLyMTFEWibicKILULKtKBd49vxJZaouAFpMXWRj38xpmbyP47kukkQK0xVFX7HgO6U=;7:SK7vntB4Cm1XDoCzbCUshrEWPxbL/srBJxIXCLyQ4pzqtuWPaJDYLXyILFRM+pcfHGq5aLVtYr5jG57563uBr+JjGpkAxOTqren53BywWuVGTQPOlhZId2ly4wbsdFXX6o4rcPcqA9OElOsfxLHWfg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: da7422db-0440-4280-39e9-08d67128ff1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5408;
x-ms-traffictypediagnostic: VI1PR04MB5408:
x-microsoft-antispam-prvs: <VI1PR04MB5408E9A57855635DE099E7DB928D0@VI1PR04MB5408.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5408;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5408;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(366004)(189003)(199004)(13464003)(51914003)(2201001)(68736007)(86362001)(66066001)(97736004)(3846002)(6116002)(8676002)(55016002)(9686003)(7736002)(93886005)(2906002)(14444005)(256004)(81156014)(6436002)(81166006)(4326008)(71190400001)(25786009)(8936002)(486006)(71200400001)(14454004)(478600001)(2501003)(54906003)(53546011)(6246003)(26005)(316002)(76176011)(11346002)(446003)(99286004)(7696005)(5660300001)(102836004)(53936002)(74316002)(110136005)(33656002)(44832011)(476003)(229853002)(186003)(6506007)(106356001)(305945005)(105586002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5408;H:VI1PR04MB5135.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lRM5JWHxQG0+7bq6vTyPEpdPgTw7PF1IhYnPsl5A4M1+NDypHy5dkrOBnvlk826bdKc7HDBmRpAlUxg07KcBmuwWCMJ9xwYFcCncBX88/itTldc3niLZT90x0WB5EYouQUJkDrIEE31+0vfehHm1iq4GRBlO3q8VJOoy2DSIZfvh/UFsemVcH9UyvnL7Ec1bQmzGIGhwxON+6lmWY8O9kBureimCuW9hR8IizobTxbn1cltU3mWt8S1ZQFbrqlJRQRHn338w5fxaUV28R8/TdkulmEU5pXoekKghj22rJgp12MR5ggCy1Qk5Ooyh0Nd/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7422db-0440-4280-39e9-08d67128ff1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 03:10:21.0858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5408
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluaWNpdXMsIA0KDQpUaGFua3MhDQpBcyBjb21tZW50cyBiZWxvdy4NCg0KDQpCciwNClBv
IExpdQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpbmljaXVzIENv
c3RhIEdvbWVzIFttYWlsdG86dmluaWNpdXMuZ29tZXNAaW50ZWwuY29tXQ0KPiBTZW50OiAyMDE5
xOox1MIzyNUgMzowMg0KPiBUbzogUG8gTGl1IDxwby5saXVAbnhwLmNvbT47IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBkYXZl
bUBkYXZlbWxvZnQubmV0OyBoYXVzdGFkQGNpc2NvLmNvbTsgbmljb2xhcy5mZXJyZUBtaWNyb2No
aXAuY29tOw0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgTWluZ2thaSBIdSA8bWluZ2th
aS5odUBueHAuY29tPjsgUm95IFphbmcNCj4gPHJveS56YW5nQG54cC5jb20+DQo+IFN1YmplY3Q6
IFJFOiBbUEFUQ0hdIG5ldDogdHNuOiBhZGQgYW4gbmV0bGluayBpbnRlcmZhY2UgYmV0d2VlbiBr
ZXJuZWwgYW5kDQo+IGFwcGxpY2F0aW9uIGxheWVyDQo+IA0KPiBIaSBQbyBMaXUsDQo+IA0KPiBQ
TyBMSVUgPHBvLmxpdUBueHAuY29tPiB3cml0ZXM6DQo+IA0KPiA+IEhpIFZpbmljaXVzLA0KPiA+
DQo+ID4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBmZWVkYmFjay4NCj4gPg0KPiA+IEkg
a25vdyB0aGUgQ0JTIGlzIHVzZWQgdG8gYmUgbW9zdCBpbXBvcnRhbnQgcGFydCBvZiBBVkIuIEFu
ZCBxZGlzY3MgaXMgZ29vZA0KPiB0b29sIHRvIGNvbmZpZ3VyZSBxb3MuDQo+ID4NCj4gPiBCdXQg
YXMgeW91IGtub3csIHRoZSBUU04gZmFtaWx5IGlzIGEgY2x1c3RlciBvZiBwcm90b2NvbHMgYW5k
IG11Y2ggZXh0ZW5kaW5nDQo+IHRoZSBBVkIuIFRoZSBwcm90b2NvbHMgaGF2ZSBkaWZmZXJlbnQg
IGZ1bmN0aW9uYWxpdGllcyBhbmQgdGhleSBtYXkgaGF2ZSBtb3JlDQo+IHRoYW4gaHVuZHJlZCAg
cGFyYW1ldGVycy4gRm9yIGV4YW1wbGUgTlhQIGxzMTAyOGEgc3VwcG9ydA0KPiBRYnYvUWNpL1Fi
dS9RYXYgYW5kIGFsc28gdGhlIDgwMjFDQiAobm90IGluY2x1ZGVkIGluIHRoaXMgcGF0Y2ggeWV0
KS4NCj4gPg0KPiA+IFNvbWUgcHJvdG9jb2xzIHRhcmdldCB0byBjb25maWd1cmUgdGhlIHRyYWZm
aWMgY2xhc3MobGlrZSBRYXYgQ0JTKS4NCj4gPiBTb21lIHRvIGNvbmZpZyB0aGUgcG9ydChsaWtl
IFFidikuIEJ1dCBzb21lIGZvciB0aGUgd2hvbGUgZXRoZXJuZXQNCj4gPiBjb250cm9sbGVyKGxp
a2UgUWNpLCB0aGUgY29udHJvbCBlbnRyaWVzIGZvciB0aGUgd2hvbGUgY29udHJvbGxlciwNCj4g
PiB3aGljaCBpbnB1dCBwb3J0cyBhbmQgd2hpY2ggb3V0cHV0IHBvcnRzKS4NCj4gDQo+IFJlYWRp
bmcgeW91ciBlbWFpbCwgbm93IEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50IGEgbGl0dGxlIGJldHRl
ci4gWW91IGFyZQ0KPiBpbnRlcmVzdGVkIGluIG11bHRpLXBvcnQgZGV2aWNlcy4gSSBhZG1pdCB0
aGF0IEkgYW0gbm90IHRvbyBmYW1pbGlhciB3aXRoIGhvdw0KPiBtdWx0aS1wb3J0IGRldmljZXMg
YXJlIGV4cG9zZWQgaW4gTGludXgsIEkgd2FzIG9ubHkgZm9jdXNlZCBvbiB0aGUgZW5kLXN0YXRp
b24NCj4gdXNlIGNhc2VzLCB1bnRpbCBub3cuDQo+IA0KPiA+DQo+ID4gU28gSSBkbyB0aGluayBh
bGwgdGhlIFRTTiBjb25maWd1cmF0aW9uIHNob3VsZCBub3QgbWl4IGluIHRoZSBldGhlcm5ldA0K
PiA+IGRyaXZlciBpdHNlbGYuIEkgbWVhbiB0aGUgZHJpdmVyIHNob3VsZCBzZXBhcmF0ZSBhIHh4
eF90c24uYyhmb3IgSTIxMCwNCj4gPiBtYXkgaWdiX3Rzbi5jKSB0byBtYWludGFpbiB0aGUgdHNu
IG9wZXJhdGlvbnMuDQo+IA0KPiA+IEFzIGZhciBhcyB1c2luZyBxZGlzY3Mgb3IgdGhlIGludGVy
ZmFjZSBvZiBnZW5lcmljIG5ldGxpbmsuIEkgdGhpbmsNCj4gPiBib3RoIGNvdWxkIGNvbmZpZ3Vy
aW5nIHRoZSBUU04gcHJvdG9jb2xzIGludGVyZmFjZSBsYXllci4gSnVzdCB3aGF0IEkNCj4gPiBw
cm92aWRlZCB0aGUgcGF0Y2ggbmV0L3Rzbi9nZW5sX3Rzbi5jLiBCdXQgSSBkbyBiZWxpZXZlIGl0
IGlzIGJldHRlcg0KPiA+IHVzaW5nIGEgc3RhbmRhbG9uZSBUU04gbWlkZGxlIGxheWVyIHRvIG1h
aW50YWluIHRoZSBUU04gY2FwYWJpbGl0eQ0KPiA+IHBvcnRzLiBCZWNhdXNlIHRoZSBUU04gcG9y
dHMgaW5jbHVkZSBub3Qgb25seSB0aGUgZW5kIHN0YXRpb24gYW5kIGFsc28NCj4gPiB0aGUgc3dp
dGNoLiBMUzEwMjggaXMgc3VjaCBhIGtpbmQgb2YgZGV2aWNlLg0KPiANCj4gSSB0aGluayB0aGlz
IGlzIHRoZSAiaW50ZXJlc3RpbmciIHBhcnQgb2YgdGhlIGRpc2N1c3Npb24uIEZyb20gbXkgcG9p
bnQgb2YgdmlldyB0aGUNCj4gcXVlc3Rpb24gbm93IGlzOg0KPiANCj4gIldlIGFscmVhZHkgaGF2
ZSBhbiBhY2NlcHRhYmxlIHdheSB0byBleHBvb3NlIFRTTiBmZWF0dXJlcyBmb3IgZW5kIHN0YXRp
b25zLg0KPiBXaGF0IGNhbiB3ZSBkbyBmb3IgbXVsdGktcG9ydCBkZXZpY2VzPyINCg0KW1BvIExp
dV0gY29ycmVjdCwgdGhhdCBpcyB3aGF0IHdlIGV4cGVjdCB0byBkby4gIFRoZXJlIGNvdWxkIGJl
IHdpdGggbW9yZSB0aGFuIG9uZSBldGhlcm5ldCBjb250cm9sbGVycyhvciBzd2l0Y2gpIHdpdGgg
VFNOIGNhcGFiaWxpdHkuIEV0aGVyIHBjaSBwbHVnIGluLCBvciBTT0MgY2hpcHMuIFRoaXMgcGF0
Y2ggdHJ5IHRvIG1hbmFnZSBhbGwuDQogDQo+IA0KPiBXaGF0IGFyZSB0aGUgb3B0aW9ucyBoZXJl
PyBGcm9tIGEgcXVpY2sgbG9vaywgaXQgc2VlbXMgdGhhdCBleHRlbmRpbmcNCj4gc3dpdGNoZGV2
IGlzIGEgcG9zc2libGUgc29sdXRpb24uIFdoYXQgZWxzZT8NCg0KW1BvIExpdV0gdGhhdCdzIGl0
LiBDb3VsZCBleHRlbmQgaXQuDQogDQo+IA0KPiBUaGlua2luZyBhIGxpdHRsZSBtb3JlLCBpZiBh
bGwgdGhlIHBvcnRzIGhhdmUgbmV0ZGV2aWNlcyBhc3NvY2lhdGVkIHdpdGggdGhlbSwNCj4gdGhl
biBpdCBjb3VsZCBiZSB0aGF0IGV4cG9zaW5nIHRob3NlIGZlYXR1cmVzIHZpYSBxZGlzY3MgY291
bGQgYmUgY29uc2lkZXJlZCBzdGlsbC4NCj4gUGVyaGFwcyB0YWtpbmcgYSBsb29rIGF0IGhvdyB0
Yy1mbG93ZXIgb2ZmbG9hZGluZyBpcyBkb25lIGNhbiBnaXZlIHNvbWUgaWRlYXMuDQoNCltQbyBM
aXVdIEkgZGlkIHVzaW5nIHRoZSB0Yy1mbG93ZXIgYXQgYXBwbGljYXRpb24gbGF5ZXIgdG8gZmls
dGVyIHRoZSBmcmFtZXMgdG8gZGlmZmVyZW50IHF1ZXVlLiBJIGF2b2lkIHRvIHVzaW5nIHRoZSBx
b3MgYnV0IG9ubHkgdXNpbmcgdGhlIG11bHRpcSB0byBtYWtlIGFsbCB0cmFmZmljIGNsYXNzZXMg
dG8gYmUgZXhwb3NlZCB0byB1c2VyIHNwYWNlLiBJIGFtIHRyeWluZyB0byAgdW5kZXJzdGFuZCB3
aGF0IHlvdXIgcGF0Y2ggd29ya2luZyBvbiB0aGUgcWRpc2MgYW5kIGhvdyBpdCBoZWxwIGZvciBU
U04uDQoNCj4gDQo+IEFuZCBhYm91dCB0aGUgcHJvY2VzcywgdXN1YWxseSB3aGVuIGEgbmV3IGlu
dGVyZmFjZSBpcyBwcm9wb3NlZCwgdGhlIHBhdGNoZXMNCj4gYXJlIGRpcmVjdGVkIHRvIG5ldC1u
ZXh0IGFuZCBoYXZlIHRoZSBSRkMgdGFnLCBzbyB0aGUgcmVhZGVycyAoYW5kIHRoZWlyIHRvb2xz
KQ0KPiBrbm93IHdoYXQgdG8gZXhwZWN0Lg0KDQpbUG8gTGl1XSB0aGFua3MgZm9yIHRoZSBtZW50
aW9uLCBJIHdvdWxkIHVwZGF0ZS4gDQoNCj4gDQo+ID4NCj4gPiBBbmQgeW91ciBhZHZpc2VzIGFy
ZSBwcmVjaW91cyBmb3IgdXMuIExldCdzIG1ha2Ugb3V0IGFuIGVhc3kgYW5kDQo+ID4gZmxleGli
bGUgaW50ZXJmYWNlIGZvciBUU04uDQo+ID4NCj4gPiBCciwNCj4gPiBQbyBMaXUNCj4gPg0KPiAN
Cj4gQ2hlZXJzLA0KPiAtLQ0KPiBWaW5pY2l1cw0K
