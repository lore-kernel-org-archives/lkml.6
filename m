Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F98CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF72820652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fyBdAUQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF72820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbeGTRrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:47:16 -0400
Received: from mail-bl2nam02on0053.outbound.protection.outlook.com ([104.47.38.53]:8377
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731556AbeGTRrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUpFkPwaFQXNcjZfUxXE6UWPl/DIOEpfAdbRO3yAJno=;
 b=fyBdAUQO6Mp1/wFjLUTe+SDft7csyAj0MKYFWy3F6pUKF+eaxWVgKACpmEonyLTXFjqGlYrN8PwFb7ZEIn92t5LwlfAMsjyhSbefSpielXpmkalLrZTorJa5hxbin3ByuK+DEzZqReMgWF8Iwhpgw5wzvjcEMMqC2bBJjXplqH4=
Received: from SN1PR02MB3758.namprd02.prod.outlook.com (52.132.200.144) by
 SN1PR02MB3838.namprd02.prod.outlook.com (52.132.194.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Fri, 20 Jul 2018 16:57:59 +0000
Received: from SN1PR02MB3758.namprd02.prod.outlook.com
 ([fe80::65b3:44a4:cfbe:43d4]) by SN1PR02MB3758.namprd02.prod.outlook.com
 ([fe80::65b3:44a4:cfbe:43d4%2]) with mapi id 15.20.0952.021; Fri, 20 Jul 2018
 16:57:56 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?utf-8?B?QmrDtnJuIEFuZGVyc3Nvbg==?= <bjorn.andersson@linaro.org>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        Michal Simek <michals@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain bindings
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain bindings
Thread-Index: AQHTsCaamP0koL1TzECLJA1Z1b6jPaPCRTqAgACcrACAAAHWAIAOxs/wgGM70SCAAJzXgIAA9cZAgGK8PaA=
Date:   Fri, 20 Jul 2018 16:57:55 +0000
Message-ID: <SN1PR02MB37582A80B36517973F287F82B8510@SN1PR02MB3758.namprd02.prod.outlook.com>
References: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
        <1519775750-21297-2-git-send-email-jollys@xilinx.com>
        <20180305223905.65nnunv63fyg7bye@rob-hp-laptop>
        <CGME20180306075954epcas5p2bbfb21f146ab879b60d004b73187a5e5@epcas5p2.samsung.com>
        <CAMuHMdVpWciek2xow1Y1W7jga6BEbAZ7OhnyviRsXK39vYGyXw@mail.gmail.com>
        <d47ed37f-057f-b510-de70-1140dad1b7ad@samsung.com>
        <DM2PR0201MB07670C06F504F97EF4E4BAD4B8D00@DM2PR0201MB0767.namprd02.prod.outlook.com>
        <SN1PR02MB37588BFF357865F4C9628D99B8910@SN1PR02MB3758.namprd02.prod.outlook.com>
 <be5cecb2-3d0d-22f8-48a2-f94ed9546e04@samsung.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB3838;7:w0aNGSU/8+G4ZdIIhOp+GVFfF4GqVAnRhLsp3OG6q0CvhLNDW4WsF81A/89TVq77PqWsRTQ/9KRVcerdSxdA0VgrmKT8ewYv5NaRfqaKDTHLet+C5UCrpaXlCGIGNSqTBH6Zoaz9Ul045zeibqy1lfyW5Ba6RHcbpuDMhOtz9VrpGIwOwg0qjfvnnCDgUDD1Nqueyj5InOtkKQu60fMdY+l+QPThJW3CQmYbv23+DHs39zmM+02Uv473Gq66OIK0
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(136003)(39860400002)(189003)(199004)(13464003)(5660300001)(3846002)(54906003)(102836004)(4326008)(6506007)(26005)(229853002)(66066001)(53546011)(256004)(9686003)(81166006)(8676002)(316002)(186003)(6436002)(55016002)(486006)(476003)(446003)(33656002)(97736004)(7696005)(2900100001)(93886005)(6116002)(99286004)(81156014)(5024004)(14444005)(76176011)(5250100002)(7416002)(74316002)(86362001)(72206003)(39060400002)(2906002)(7736002)(6916009)(305945005)(25786009)(53936002)(478600001)(6246003)(106356001)(8936002)(14454004)(68736007)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3838;H:SN1PR02MB3758.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 974e62b5-f592-4d35-8f9d-08d5ee61f0b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB3838;
x-ms-traffictypediagnostic: SN1PR02MB3838:
x-microsoft-antispam-prvs: <SN1PR02MB38383EEC6817B1CC96023AC7B8510@SN1PR02MB3838.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB3838;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB3838;
x-forefront-prvs: 073966E86B
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hCy2os517W+Jwgk4UJ2PvVSbIoAqiF66nIQ8Pu0CivFbfJ3BJmB8e3nMp4xh5g1/CxytGRkKPYp1SuYcOB3gBvyjeKABlLMRIZaoLV/ThfNSGHN9/iXAhYg8OZ0Wa5F91yd+l4TeNjcsL0GQA9kw/OSQVATrQxcvjch2SZ+UpmWro8+oBF7fDB0n2U790itwP5gqH5hcd2EkIAreW0Ntq69vAHI3qsW6IMZUGWLYenDrnT0C9L8DsmPBlm0tlp3zXbODbkZ533FJ100a9G7iRkcj3ZYDw2O/SY/lqQ004KtU/chrFKSMtwvBTdr7cguhd8iALGpTzBHP5y+4Og2y0GYYcrJjnjKcAUld10+/jWY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974e62b5-f592-4d35-8f9d-08d5ee61f0b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:57:55.9590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9sbHkg
U2hhaA0KPiBTZW50OiBGcmlkYXksIE1heSAxOCwgMjAxOCAyOjE5IFBNDQo+IFRvOiAnTWFyZWsg
U3p5cHJvd3NraScgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4NCj4gQ2M6IE1hdHRoaWFzIEJy
dWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+OyBBbmR5IEdyb3NzDQo+IDxhbmR5Lmdyb3Nz
QGxpbmFyby5vcmc+OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBHZWVydA0KPiBV
eXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsgQmrDtnJuIEFuZGVyc3Nvbg0K
PiA8Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc+OyBzZWFuLndhbmdAbWVkaWF0ZWsuY29tOyBN
aWNoYWwgU2ltZWsNCj4gPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPjsgTWFyayBSdXRsYW5kIDxt
YXJrLnJ1dGxhbmRAYXJtLmNvbT47IFJhamFuDQo+IFZhamEgPFJBSkFOVkB4aWxpbnguY29tPjsg
b3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRA0KPiBERVZJQ0UgVFJFRSBCSU5E
SU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBBUk0gPGxpbnV4LWFybS0N
Cj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0
IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IEdlZXJ0IFV5dHRlcmhvZXZlbiA8
Z2VlcnRAbGludXgtbTY4ay5vcmc+OyBSb2INCj4gSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0K
PiBTdWJqZWN0OiBSRTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IHBvd2VyOiBBZGQgWnlucU1Q
IHBvd2VyIGRvbWFpbg0KPiBiaW5kaW5ncw0KPiANCj4gSGkgTWFyZWssDQo+IA0KPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogTWFyZWsgU3p5cHJvd3NraSBbbWFpbHRv
Om0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbV0NCj4gPiBTZW50OiBUaHVyc2RheSwgTWF5IDE3LCAy
MDE4IDExOjMxIFBNDQo+ID4gVG86IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbnguY29tPjsgR2Vl
cnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC0NCj4gPiBtNjhrLm9yZz47IFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJn
Z0BnbWFpbC5jb20+OyBBbmR5IEdyb3NzDQo+ID4gPGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47IFNo
YXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IEdlZXJ0DQo+ID4gVXl0dGVyaG9ldmVuIDxn
ZWVydCtyZW5lc2FzQGdsaWRlci5iZT47IEJqw7ZybiBBbmRlcnNzb24NCj4gPiA8Ympvcm4uYW5k
ZXJzc29uQGxpbmFyby5vcmc+OyBzZWFuLndhbmdAbWVkaWF0ZWsuY29tOyBNaWNoYWwgU2ltZWsN
Cj4gPiA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFu
ZEBhcm0uY29tPjsgUmFqYW4NCj4gPiBWYWphIDxSQUpBTlZAeGlsaW54LmNvbT47IG9wZW4gbGlz
dDpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQNCj4gREVWSUNFDQo+ID4gVFJFRSBCSU5ESU5H
UyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBBUk0gPGxpbnV4LWFybS0NCj4g
PiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3Qg
PGxpbnV4LQ0KPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBwb3dlcjogQWRkIFp5bnFNUCBwb3dlciBkb21haW4NCj4g
PiBiaW5kaW5ncw0KPiA+DQo+ID4gSGkgSm9sbHksDQo+ID4NCj4gPiBPbiAyMDE4LTA1LTE3IDIz
OjEwLCBKb2xseSBTaGFoIHdyb3RlOg0KPiA+DQo+ID4gPj4+Pj4+ICtFeGFtcGxlOg0KPiA+ID4+
Pj4+PiArICAgICB6eW5xbXAtZ2VucGQgew0KPiA+ID4+Pj4+PiArICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAieGxueCx6eW5xbXAtZ2VucGQiOw0KPiA+ID4+Pj4+IFdoYXQncyB0aGUgY29udHJv
bCBpbnRlcmZhY2UgZm9yIGNvbnRyb2xsaW5nIHRoZSBkb21haW5zPw0KPiA+ID4+Pj4+PiArDQo+
ID4gPj4+Pj4+ICsgICAgICAgICAgICAgcGRfdXNiMDogcGQtdXNiMCB7DQo+ID4gPj4+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgICBwZC1pZCA9IDwyMj47DQo+ID4gPj4+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICAjcG93ZXItZG9tYWluLWNlbGxzID0gPDA+Ow0KPiA+ID4+Pj4+IFRoZXJlJ3Mg
bm8gbmVlZCBmb3IgYWxsIHRoZXNlIHN1YiBub2Rlcy4gTWFrZQ0KPiA+ID4+Pj4+ICNwb3dlci1k
b21haW4tY2VsbHMNCj4gPiA+Pj4+PiAxIGFuZCBwdXQgdGhlIGlkIGluIHRoZSBjZWxsIHZhbHVl
Lg0KPiA+ID4+Pj4gVGhhdCB3YXMgbXkgZmlyc3QgcmVhY3Rpb24sIHRvby4uLg0KPiA+ID4+Pj4+
PiArICAgICAgICAgICAgIH07DQo+ID4gPj4+Pj4+ICsNCj4gPiA+Pj4+Pj4gKyAgICAgICAgICAg
ICBwZF9zYXRhOiBwZC1zYXRhIHsNCj4gPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHBk
LWlkID0gPDI4PjsNCj4gPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICNwb3dlci1kb21h
aW4tY2VsbHMgPSA8MD47DQo+ID4gPj4+Pj4+ICsgICAgICAgICAgICAgfTsNCj4gPiA+Pj4+Pj4g
Kw0KPiA+ID4+Pj4+PiArICAgICAgICAgICAgIHBkX2dwdTogcGQtZ3B1IHsNCj4gPiA+Pj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgIHBkLWlkID0gPDU4IDIwIDIxPjsNCj4gPiA+Pj4+IC4uLiB1
bnRpbCBJIHNhdyB0aGUgYWJvdmUuDQo+ID4gPj4+PiBDb250cm9sbGluZyB0aGUgR1BVIHBvd2Vy
IGFyZWEgcmVxdWlyZXMgY29udHJvbGxpbmcgMyBwaHlzaWNhbCBhcmVhcz8NCj4gPiA+Pj4+DQo+
ID4gPj4+PiBIb3dldmVyLCBkb2luZyBpdCB0aGlzIHdheSBtYXkgYml0ZSB5b3UgaW4gdGhlIGZ1
dHVyZSwgaWYgYSBuZWVkDQo+ID4gPj4+PiBhcmlzZXMgdG8gY29udHJvbCBhIHN1YnNldC4gQW5k
IHdoYXQgYWJvdXQgcG93ZXIgdXAvZG93biBvcmRlcj8NCj4gPiA+Pj4gV2hhdCBhYm91dCBkZWZp
bmluZyAzIHNlcGFyYXRlIGRvbWFpbnMgYW5kIGFycmFuZ2luZyB0aGVtIGluDQo+ID4gPj4+IHBh
cmVudC1jaGlsZCByZWxhdGlvbnNoaXA/IGdlbmVyaWMgcG93ZXIgZG9tYWlucyBhbHJlYWR5IHN1
cHBvcnRzDQo+ID4gPj4+IHRoYXQgYW5kIHRoaXMgYWxsb3dzIHRvIG5pY2VseSBkZWZpbmUgdGhl
IHBvd2VyIG9uL29mZiBvcmRlci4NCj4gPiA+Pj4NCj4gPiA+Pj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICNwb3dlci1kb21haW4tY2VsbHMgPSA8MHgwPjsNCj4gPiA+Pj4+Pj4gKyAgICAgICAg
ICAgICB9Ow0KPiA+ID4+Pj4+PiArICAgICB9Ow0KPiA+ID4+IEkgYWdyZWUgaXQgc2hvdWxkIGJl
IGFycmFuZ2VkIGluIGFzIHBhcmVudCBjaGlsZCBvcmRlciB0byBjb250cm9sDQo+ID4gPj4gc3Vi
c2V0IG9yIGNvbnRyb2wgb3JkZXIuIFdpbGwgaW5jb3Jwb3JhdGUgdGhvc2UgY2hhbmdlcyBpbiBu
ZXh0IHZlcnNpb24uDQo+ID4gPg0KPiA+ID4gQXMgc3VnZ2VzdGVkLCBJIHRyaWVkIG91dCBwYXJl
bnQsIGNoaWxkIGFwcHJvYWNoLiBIb3dldmVyIHdoYXQgSQ0KPiA+ID4gZm91bmQgaXMNCj4gPiBH
ZW5wZCBjb3JlIHRha2VzIGNhcmUgb2YgcGFyZW50IGNoaWxkIGRlcGVuZGVuY2llcyBmb3IgcG93
ZXIgb24gb2ZmDQo+ID4gcm91dGluZXMgb25seS4gSW4gb3VyIGNhc2UsIFdlIG5lZWQgdGhlbSBp
biBhdHRhY2gtZGV0YWNoIHJvdXRpbmVzDQo+ID4gdG9vLiBJbiB0aGF0IGNhc2UsIHdlIG5lZWQg
dG8gaGFuZGxlIGRlcGVuZGVuY2llcyBtYW51YWxseSBmb3IgdGhvc2UNCj4gPiByb3V0aW5lcy4g
UGxlYXNlIHN1Z2dlc3QgYmV0dGVyIGFwcHJvYWNoLCBpZiBhbnkuDQo+ID4NCj4gPiBXaGF0IGRv
IHlvdSBtZWFuIHRvIGhhbmRsZSBhdHRhY2gtZGV0YWNoPw0KPiA+DQo+ID4gQmVzdCByZWdhcmRz
DQo+ID4gLS0NCj4gPiBNYXJlayBTenlwcm93c2tpLCBQaEQNCj4gPiBTYW1zdW5nIFImRCBJbnN0
aXR1dGUgUG9sYW5kDQo+IA0KPiBGb3Igb3VyIHBvd2VyIGRvbWFpbiBkcml2ZXIsICB3ZSByZXF1
ZXN0IHVzYWdlIG9mIHRoZXNlIG5vZGVzIGluIGF0dGFjaA0KPiByb3V0aW5lcyBhbmQgcG93ZXIg
dGhlbSBvbiBpbiBwb3dlciBvbiByb3V0aW5lLiBTbyBmb3IgYmVsb3cgc3BlY2lmaWMgY2FzZSwN
Cj4gd2hlbiBhdHRhY2hfZGV2IGlzIGNhbGxlZCwgYWxsIDMgbm9kZXMgbmVlZCB0byBiZSByZXF1
ZXN0ZWQuDQo+IA0KPiA+ID4+Pj4+PiArICAgICAgICAgICAgIHBkX2dwdTogcGQtZ3B1IHsNCj4g
PiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHBkLWlkID0gPDU4IDIwIDIxPjsNCj4gDQo+
IFRoYW5rcywNCj4gSm9sbHkgU2hhaA0KPiANCg0KUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgb3Bp
bmlvbi4NCg0KVGhhbmtzLA0KSm9sbHkgU2hhaA0KDQoNCg==
