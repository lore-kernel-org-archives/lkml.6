Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1992DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F2920652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="AwtPPMXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfAQMYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:24:08 -0500
Received: from mail-eopbgr1410108.outbound.protection.outlook.com ([40.107.141.108]:12320
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbfAQMYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiVrN3UIhETGvgU9+AZS+zyffBB/KPMYnaazt6JDLZw=;
 b=AwtPPMXuZ1fjtspiBmAekT1z3ijT6I2spJLuNJmaHPVEsz/O+d5bEE1FBbhl5Hi5HpnechfCFW87dcwahktXfVOLycrWaaG6km6RW40NvatCkbxtbBg8sMIRgzXELgyJcXW43oZL45NeAVGseHwBtZ7uBQJPJGNLCwfmKk45yN0=
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com (52.133.177.145) by
 TYAPR01MB4429.jpnprd01.prod.outlook.com (20.179.173.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Thu, 17 Jan 2019 12:23:55 +0000
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::9163:fe8d:ceb8:8d88]) by TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::9163:fe8d:ceb8:8d88%6]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 12:23:55 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Simon Horman <horms@verge.net.au>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Majewski <lukma@denx.de>,
        Michal Simek <monstr@monstr.eu>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ebiharaml@si-linux.co.jp" <ebiharaml@si-linux.co.jp>
Subject: RE: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Thread-Topic: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Thread-Index: AQHUrcqnH6R130HrTUOjTRMxo1hVaaWzUQEAgAARJ4CAAADusA==
Date:   Thu, 17 Jan 2019 12:23:55 +0000
Message-ID: <TYAPR01MB228595A79ABDB0D7826FED0FB7830@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <bb5b27ed-a077-f639-b97b-4da22c9bb3ad@suse.de>
 <20190117121919.c5u66sorut5a5nib@verge.net.au>
In-Reply-To: <20190117121919.c5u66sorut5a5nib@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Paterson2@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB4429;20:24wG0S9/EpmT+bMaex/Gn+yow0eRADlATNYXrF3M1NlnECP/E/9nPYb3B4g/MDxS7556RdcFxygo1kEATh4TVmZcEXKxjrYgwYes+Qu6iRNdDQP3NhngIisRWYYLDDuycqKz5TekqGto2L+D8zxE0Abqdxs0fwYwS0ia7XVZAsk=
x-ms-office365-filtering-correlation-id: e3d5d057-9843-4e7c-309b-08d67c76a667
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB4429;
x-ms-traffictypediagnostic: TYAPR01MB4429:
x-microsoft-antispam-prvs: <TYAPR01MB44291808856A26E5941995F0B7830@TYAPR01MB4429.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(366004)(346002)(396003)(136003)(189003)(199004)(25786009)(9686003)(6306002)(53386004)(186003)(26005)(71200400001)(305945005)(81166006)(7736002)(4326008)(54906003)(2906002)(81156014)(71190400001)(476003)(97736004)(74316002)(39060400002)(446003)(102836004)(6246003)(16799955002)(256004)(53936002)(14444005)(66574012)(110136005)(11346002)(345774005)(93886005)(86362001)(7696005)(6506007)(99286004)(5660300001)(72206003)(478600001)(316002)(55016002)(6116002)(6436002)(486006)(7416002)(3846002)(966005)(33656002)(76176011)(8936002)(14454004)(8676002)(66066001)(105586002)(68736007)(229853002)(347745004)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4429;H:TYAPR01MB2285.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CQEZaQ75kVIXm+eSDy5Qjl8jn8cHL01tD5E9ZAVqbC2QcdrC6McKUBqdvddXoCmNBoC6moSe/nYVRdB/1hGw4UOcMckNNuJU7ioX19vCuCBaWJEMQPVMjJNct7FoK74eIofXQYInDrgVOC53tKEMKN37r6sY6ZU9QqcLDDTuzMZPQ5yDEJzl8c/1/W4AUrODdxE94XFVPTdyz10GFFZOshlftBWdTchYJG1pIc6CnoElA1oyX52ItqVjnYnceVFyhPtqWeWbgKVA3zuPpBoiBJ/Is8vB/3P2A5LLy2U9J4je6IoflOwlZk49rQVgObLfvat29+V2DJDU9LMMyejwvn3q0abV6dKVUK1fKBcQQcnwi4FJpV98OGMEDT9d0RHH0VV8FtMQrZVNr1gSpzpUZOlc6HsQOOnLpc7puiRCkpw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d5d057-9843-4e7c-309b-08d67c76a667
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 12:23:55.5767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4429
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQW5kcmVhcywgU2ltb24sDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXdzLg0KDQo+
IEZyb206IFNpbW9uIEhvcm1hbiA8aG9ybXNAdmVyZ2UubmV0LmF1Pg0KPiBTZW50OiAxNyBKYW51
YXJ5IDIwMTkgMTI6MTkNCj4gDQo+IE9uIFRodSwgSmFuIDE3LCAyMDE5IGF0IDEyOjE3OjU2UE0g
KzAxMDAsIEFuZHJlYXMgRsOkcmJlciB3cm90ZToNCj4gPiBIaSBGYWJyaXppbywNCj4gPg0KPiA+
IEFtIDE2LjAxLjE5IHVtIDE5OjM3IHNjaHJpZWIgRmFicml6aW8gQ2FzdHJvOg0KPiA+ID4gRnJv
bTogQmlqdSBEYXMgPGJpanUuZGFzQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4NCj4gPiA+IEFkZCBT
aWxpY29uIExpbnV4IHRvIHRoZSBsaXN0IG9mIGRldmljZXRyZWUgdmVuZG9yIHByZWZpeGVzLg0K
PiA+ID4NCj4gPiA+IFdlYnNpdGU6IGh0dHA6Ly93d3cuc2ktbGludXguY28uanANCj4gPiA+DQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXNAYnAucmVuZXNhcy5jb20+DQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryb0BicC5y
ZW5lc2FzLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5OiBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMuUGF0
ZXJzb24yQHJlbmVzYXMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy50eHQgfCAxICsNCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy50eHQNCj4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnR4dA0KPiA+ID4g
aW5kZXggNGIxYTJhOC4uMDJhNzAzNyAxMDA2NDQNCj4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0DQo+ID4gPiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnR4dA0KPiA+ID4g
QEAgLTM0NCw2ICszNDQsNyBAQCBzZ3gJU0dYIFNlbnNvcnRlY2gNCj4gPiA+ICBzaGFycAlTaGFy
cCBDb3Jwb3JhdGlvbg0KPiA+ID4gIHNoaW1hZnVqaQlTaGltYWZ1amkgRWxlY3RyaWMsIEluYy4N
Cj4gPiA+ICBzaS1lbglTaS1FbiBUZWNobm9sb2d5IEx0ZC4NCj4gPiA+ICtzaS1saW51eAlTaWxp
Y29uIExpbnV4IENvcnBvcmF0aW9uDQo+ID4NCj4gPiBXaXRoIHRoZSB3ZWJzaXRlIGJlaW5nIEph
cGFuZXNlIG9ubHksIEkgaGF2ZW4ndCBiZWVuIGFibGUgdG8gY29uZmlybSB0aGUNCj4gPiBzcGVs
bGluZyBvZiB0aGUgY29tcGFueSBuYW1lLiBMb29rcyBzZW5zaWJsZSB0aG91Z2guDQo+IA0KPiBB
Y2NvcmRpbmcgdG8gdGhlIGNvbXBhbnkgd2ViIHNpdGUNCj4gKGh0dHA6Ly9zaS0NCj4gbGludXgu
Y28uanAvaW5kZXgucGhwPyVFNCVCQyU5QSVFNyVBNCVCRSVFNiVBMSU4OCVFNSU4NiU4NSkNCj4g
dGhlIGNvbXBhbnkgbmFtZSBpcy4NCj4gDQo+IEphcGFuZXNlOiDjgrfjg6rjgrPjg7Pjg6rjg4rj
g4Pjgq/jgrnmoKrlvI/kvJrnpL4NCj4gRW5nbGlzaDogIFNpbGljb24gTGludXggQ29ycG9yYXRp
b24NCg0KSSBjYW4gYWxzbyBjb25maXJtIHRoYXQgdGhpcyBpcyB3aGF0IHdlJ3ZlIGJlZW4gdG9s
ZCBieSBTaS1MaW51eCB0aGVtc2VsdmVzIPCfmIoNCg0KS2luZCByZWdhcmRzLCBDaHJpcw0KDQo+
IA0KPiBBbmQgaW4gbXkgb3BpbmlvbiB0aGVzZSBhcmUgZXF1aXZhbGVudCAoYWx0aG91Z2ggb3Ro
ZXIgdHJhbnNsYXRpb25zIG9mDQo+IHRoZSBjb3Jwb3JhdGlvbiBiaXQgYXJlIHBvc3NpYmxlKS4N
Cj4gDQo+ID4gRHVlIHRvICJlbiIgY29taW5nIGJlZm9yZSAiZml2ZSIgSSd2ZSBkb3VibGUtY2hl
Y2tlZCB0aGF0IGVsc2V3aGVyZSB3ZQ0KPiA+IGRvIG9yZGVyIGRhc2hlcyBiZWZvcmUgbGV0dGVy
cywgc28gcGxhY2VtZW50IGluIGZpbGUgYW5kIHRhYi1pbmRlbnRhdGlvbg0KPiA+IGlzIGZpbmUs
IHRvby4NCj4gPg0KPiA+ID4gIHNpZml2ZQlTaUZpdmUsIEluYy4NCj4gPiA+ICBzaWdtYQlTaWdt
YSBEZXNpZ25zLCBJbmMuDQo+ID4gPiAgc2lpCVNlaWtvIEluc3RydW1lbnRzLCBJbmMuDQo+ID4N
Cj4gPiBQZXJzb25hbGx5IEkgd291bGQgZHJvcCB0aGUgZnVsbCBzdG9wIGF0IHRoZSBlbmQgb2Yg
dGhlIHN1YmplY3QsIGJ1dCBhbnl3YXk6DQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogQW5kcmVhcyBG
w6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEFuZHJlYXMN
Cj4gPg0KPiA+IFAuUy4gUGxlYXNlIGRvdWJsZS1jaGVjayBob3cgdGhpcyBleGNlc3NpdmUgQ0Mg
bGlzdCBjYW1lIHRvIGxpZmUhDQo+ID4NCj4gPiAtLQ0KPiA+IFNVU0UgTGludXggR21iSCwgTWF4
ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55DQo+ID4gR0Y6IEZlbGl4IEltZW5k
w7ZyZmZlciwgSmFuZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbg0KPiA+IEhSQiAyMTI4NCAoQUcg
TsO8cm5iZXJnKQ0KPiA+DQo=
