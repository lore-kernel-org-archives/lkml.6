Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20265C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89EB2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="j2rBtxZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89EB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeIEO2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:28:32 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:45901 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727575AbeIEO2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:28:31 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie2.idc.renesas.com with ESMTP; 05 Sep 2018 18:59:00 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 88BB583075;
        Wed,  5 Sep 2018 18:59:00 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,333,1531753200"; 
   d="scan'208";a="290066452"
Received: from mail-ty1jpn01lp0176.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.176])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2018 18:59:00 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0Rmi5ujpico4bz7iVgKK1sfhnVqp+Hal16lTLaoB9M=;
 b=j2rBtxZQ6xBzStv3y8Je3v7ttf2AMZnXDDX7uBJdrXEeYvaFnj8HgWimCau5aIAgxbEHsiKnX0d+u8x+2FY4yrFXeGu2NOowYglWXFB2CMjiRxrk4RT3P9Bl6kRd+zot84OmhTeAnMQDXQBcSgoDLf2ZteWMn+wyKJxageGQ9cA=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB0223.jpnprd01.prod.outlook.com (10.161.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Wed, 5 Sep 2018 09:58:58 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::90da:703e:a3a9:cd97]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::90da:703e:a3a9:cd97%5]) with mapi id 15.20.1101.016; Wed, 5 Sep 2018
 09:58:58 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
Thread-Topic: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
Thread-Index: AQHUQGMu6ROdNPJdbkaf+nPyB2h7vKTeYncAgAADtzCAAxDxAIAABayQ
Date:   Wed, 5 Sep 2018 09:58:58 +0000
Message-ID: <TY1PR01MB17697A2D3BCA85B3BFC1FE21F5020@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
 <20180903103358.GC20333@w540>
 <TY1PR01MB17697F04004A7C8CF1D21CC1F50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdU-CcckKueeT5r9-jCoNr0H5KhzrAMbL4LeFta_fAqWuA@mail.gmail.com>
In-Reply-To: <CAMuHMdU-CcckKueeT5r9-jCoNr0H5KhzrAMbL4LeFta_fAqWuA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0223;20:X2jvvyK7l+ecqWXBkPDN45hoD/XxPcD9pR6eWzPs5zEoJXU4d5LfJ8/k3nGHlUfqkD8oRTvmntTdmYb3CMYdceo/bhQLfLub6o/rpLdNKq2zUjkL6dLkDg/egeSWKgeDqStgTtRkCCNcGqwS4zMklG/XrjvniFqUpTA48TmLlvc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: eb66e92f-2ddd-4d70-c7ca-08d6131632e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0223;
x-ms-traffictypediagnostic: TY1PR01MB0223:
x-microsoft-antispam-prvs: <TY1PR01MB0223860F605F7FDC3C53C4DAF5020@TY1PR01MB0223.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:TY1PR01MB0223;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0223;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(44832011)(2900100001)(66066001)(256004)(6506007)(53546011)(102836004)(478600001)(74316002)(2906002)(33656002)(54906003)(6116002)(26005)(53936002)(3846002)(25786009)(55016002)(5250100002)(186003)(9686003)(7736002)(4326008)(97736004)(6246003)(7416002)(14454004)(305945005)(7696005)(99286004)(229853002)(8676002)(68736007)(486006)(6916009)(476003)(5660300001)(81156014)(86362001)(81166006)(8936002)(76176011)(106356001)(316002)(6436002)(446003)(11346002)(105586002)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0223;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zYc8b/BwD4UEGuRhP01Q5Tcz6kwYPukR1u5xGLKQv94iGpL8TIndVwgQjqyphdQsP5ZfFMvPBWYH35+T3Y4On6xRWWlpALtFv5mUciosgvDgZgk3B5OXaQ96zlae4KUkw+X+Z8xJf51VQ+ziY5Pq8Bdq6jDDgS4XMh6BqwwDPxkCPDVSnQOLFMMy5dQOUbhEi2g8KqmXp2Dtbobhx6dqj9b1BsQdyEaenrWing4e4Dg1fr/7Le4n/cEUZRYhqw+qB2JQl5q3szP51AtI+xVaCVKOe7UrK3l3fut49bCPfxTEmCURuXcfQ8teHrxis3R8gr1td5bE4KuWg51Vk4BPro2gVLVxDCmWvupRbfG1tmw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb66e92f-2ddd-4d70-c7ca-08d6131632e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 09:58:58.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDA1IFNlcHRlbWJlciAyMDE4IDEwOjM3LCBHZWVydCBVeXR0ZXJob2V2
ZW4gd3JvdGU6DQo+IE9uIE1vbiwgU2VwIDMsIDIwMTggYXQgMTowMyBQTSBQaGlsIEVkd29ydGh5
IHdyb3RlOg0KPiA+IE9uIDAzIFNlcHRlbWJlciAyMDE4IDExOjM0LCBqYWNvcG8gbW9uZGkgd3Jv
dGU6DQo+ID4gPiBPbiBUaHUsIEF1ZyAzMCwgMjAxOCBhdCAwMjoxMjo1MlBNICswMTAwLCBQaGls
IEVkd29ydGh5IHdyb3RlOg0KPiA+ID4gPiBUaGlzIGltcGxlbWVudHMgdGhlIHBpbmN0cmwgZHJp
dmVyIGZvciB0aGUgUlovTjEgZmFtaWx5IG9mDQo+ID4gPiA+IGRldmljZXMsIGluY2x1ZGluZyB0
aGUgUjlBMDZHMDMyIChSWi9OMUQpIGRldmljZS4NCj4gPiA+ID4NCj4gPiA+ID4gT25lIGFyZWEg
dGhhdCBpcyBsaWtlbHkgdG8gYmUgY29udGVudGlvdXMgaXMgdGhlIHVzZSBvZiAndmlydHVhbA0K
PiA+ID4gPiBwaW5zJyBmb3IgdGhlIE1ESU8gcGlubXV4aW5nLiBUaGUgZHJpdmVyIHVzZXMgdHdv
IHBpbnMgKDE3MCBhbmQNCj4gPiA+ID4gMTcxKSB0aGF0IGRvbid0IGV4aXN0IG9uDQo+ID4gPiB0
aGUNCj4gPiA+ID4gZGV2aWNlIHRvIGNvbmZpZ3VyZSB0aGUgTURJTyBzb3VyY2Ugd2l0aGluIHRo
ZSBSWi9OMSBkZXZpY2VzLiBPbg0KPiA+ID4gPiB0aGVzZQ0KPiA+ID4gZGV2aWNlcywNCj4gPiA+
ID4gdGhlcmUgYXJlIHR3byBFdGhlcm5ldCBNQUNzLCBhIDUtUG9ydCBTd2l0Y2gsIG51bWVyb3Vz
IGluZHVzdHJpYWwNCj4gPiA+IEV0aGVybmV0DQo+ID4gPiA+IHBlcmlwaGVyYWxzLCBhbnkgb2Yg
d2hpY2ggY2FuIGJlIHRoZSBNRElPIHNvdXJjZS4gQ29uZmlndXJpbmcgdGhlDQo+ID4gPiA+IE1E
SU8NCj4gPiA+IHNvdXJjZQ0KPiA+ID4gPiBjb3VsZCBiZSBkb25lIHdpdGhvdXQgdGhlIHZpcnR1
YWwgcGlucywgZS5nLiBieSBleHRlbmRpbmcgdGhlDQo+ID4gPiA+IGZ1bmN0aW9ucyB0byBjb3Zl
ciBhbGwgTURJTyB2YXJpYW50cyAoYSB0b3RhbCBvZiAzMiBhZGRpdGlvbmFsDQo+ID4gPiA+IGZ1
bmN0aW9ucyksIGJ1dCB0aGlzIHdvdWxkIGFsbG93IHVzZXJzIHRvIG1pc2NvbmZpZ3VyZSBpbmRp
dmlkdWFsDQo+ID4gPiA+IE1ESU8gcGlucywgcmF0aGVyIHRoYW4gYXNzaWduIGFsbA0KPiA+ID4g
TURJTw0KPiA+ID4gPiBwaW5zIHRvIGEgTURJTyBzb3VyY2UuIFRoZSBjaG9pY2Ugb2YgaG93IHRv
IGltcGxlbWVudCB0aGlzIHdpbGwNCj4gPiA+ID4gYWZmZWN0IHRoZSBEVCBiaW5kaW5ncy4NCj4g
PiA+ID4NCj4gPiA+ID4gVGhpcyBzZXJpZXMgd2FzIG9yaWdpbmFsbHkgd3JpdHRlbiBieSBNaWNo
ZWwgUG9sbGV0IHdoaWxzdCBhdA0KPiA+ID4gPiBSZW5lc2FzLCBhbmQgSSBoYXZlIHRha2VuIG92
ZXIgdGhpcyB3b3JrLg0KPiA+ID4gPg0KPiA+ID4gPiBPbmUgcG9pbnQgZnJvbSBNaWNoZWwncyB2
MSBzZXJpZXM6DQo+ID4gPiA+ICJOb3RlLCBJIHVzZWQgcmVuZXNhcyxyem4xLXBpbm11eCBub2Rl
IHRvIHNwZWNpZnkgdGhlIHBpbm11eA0KPiA+ID4gPiBjb25zdGFudHMsIGFuZCBJIGFsc28gZG9u
J3QgdXNlIHNvbWUgb2YgdGhlIHByb3BlcnRpZXMgZG9jdW1lbnRlZA0KPiA+ID4gPiBpbiBwaW5j
dHJsLWJpbmRpbmdzLnR4dCBvbiBwdXJwb3NlLCBhcyB0aGV5IGFyZSB0b28gbGltaXRlZCBmb3Ig
bXkNCj4gPiA+ID4gdXNlIChJIG5lZWQgdG8gYmUgYWJsZSB0byBzZXQsIGNsZWFyLCBpZ25vcmUg
b3IgcmVzZXQgbGV2ZWwsIHB1bGwNCj4gPiA+ID4gdXAvZG93biBhbmQgZnVuY3Rpb24gYXMgdGhl
IHBpbm11eCBtaWdodCBiZSBzZXQgYnkgYW5vdGhlciBPUy9jb3JlDQo+ID4gPiA+IHJ1bm5pbmcg
Y29uY3VyZW50bHkpLiINCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBJIHN0YXJ0IGJ5IHNheWluZyB0
aGF0IEkgZG9uJ3Qga25vdyB0aGlzIEhXIHBpbiBjb250cm9sbGVyIHdlbGwsIHNvDQo+ID4gPiBJ
IG1pZ2h0IGJlIG1pc3Npbmcgc29tZXRoaW5nLCBidXQgYXMgY29tbWVudGVkIG9uIHRoZSBvcmln
aW5hbA0KPiA+ID4gc2VyaWVzIGZyb20gTWljaGVhbCwgSSBzdGlsbCBkb24ndCBzZWUgd2h5IHlv
dSBuZWVkIGEgY3VzdG9tIHByb3BlcnR5DQo+IGhlcmUuLi4NCj4gPiA+DQo+ID4gPiBNeSB1bmRl
cnN0YW5kaW5nLCBsb29raW5nIGF0IHRoaXMgY29tbWVudCBhbmQgdGhlIGhlYWRlciBwcm92aWRl
ZCBieQ0KPiA+ID4gcGF0Y2ggWzEvM10gKGluY2x1ZGUvZHQtYmluZGluZ3MvcGluY3RybC9yem4x
LXBpbmN0cmwuaCkgaXMgdGhhdA0KPiA+ID4gYmFzaWNhbGx5IG5lZWQgdG8gY29udHJvbCBwdWxs
LXVwL2Rvd24gYW5kIHRoZSBvdXRwdXQgZHJpdmVyIHN0cmVuZ3RoLg0KPiA+ID4NCj4gPiA+IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL3BpbmN0cmwtYmluZGluZ3Mu
dHh0DQo+ID4gPiByZXBvcnRzIGEgc2V0IG9mIGdlbmVyaWMgcGluIGNvbmZpZ3VyYXRpb24gcHJv
cGVydGllcyB0byBiZSBhcHBsaWVkDQo+ID4gPiB0byBhIHBpbiBjb25maWd1cmF0aW9uIChhbmQg
bXVsdGlwbGV4aW5nKSBwaW4gY29udHJvbGxlciBjaGlsZCBub2RlDQo+ID4gPiB0aGF0IGZ1bGx5
IGV4cHJlc3MgYWxsIChtb3N0Pykgb2YgeW91ciBuZWVkcy4NCj4gPiA+DQo+ID4gPiBFZy4gYSBw
aW4gY29uZmlndXJhdGlvbiB3aXRoIHB1bGwgdXAgYXBwbGllZCwgdXNpbmcgZXhhbXBsZXMgZnJv
bQ0KPiA+ID4geW91ciBjb3ZlciBsZXR0ZXIgc2hvdWxkIGJlIGV4cHJlc3NlZCBhcw0KPiA+ID4N
Cj4gPiA+IFlvdXIgZXhhbXBsZToNCj4gPiA+ICAgICAgICAgICZwaW5jdHJsIHsNCj4gPiA+ICAg
ICAgICAgICAgICAgICAgcGluc3VhcnQwOiBwaW5zdWFydDAgew0KPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgIHJlbmVzYXMscnpuMS1waW5tdXgtaWRzID0gPA0KPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgUlpOMV9NVVgoMTAzLCBVQVJUMF9JKSAgLyogVUFSVDBf
VFhEICovDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSWk4xX01VWF9Q
VVAoMTA0LCBVQVJUMF9JKSAgICAgIC8qIFVBUlQwX1JYRCAqLw0KPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgID47DQo+ID4gPiAgICAgICAgICAgICAgICAgIH07DQo+ID4gPiAgICAgICAg
ICB9Ow0KPiA+ID4NCj4gPiA+IFVzaW5nIHN0YW5kYXJkIHBpbmN0cm9sbGVyIGJpbmRpbmdzIHBp
biBjb25maWd1cmF0aW9uIHByb3BlcnRpZXM6DQo+ID4gPg0KPiA+ID4gICAgICAgICAgJnBpbmN0
cmwgew0KPiA+ID4gICAgICAgICAgICAgICAgICBwaW5zdWFydDA6IHVhcnQwICB7DQo+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBwaW5zdWFydF90eDAgew0KPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBwaW5tdXggPSA8MTAzLCBVQVJUMF9JPjsgIC8qIFVBUlQwX1RY
RCAqLw0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+DQo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICBwaW5zdWFydF9yeDAgew0KPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcGlubXV4ID0gPDEwNCwgVUFSVDBfST47IC8qIFVBUlQwX1JYRCAq
Lw0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmlhcy1wdWxsLXVwOw0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gPiA+ICAgICAgICAgICAgICAgICAg
fTsNCj4gPiA+ICAgICAgICAgIH07DQo+ID4gPg0KPiA+ID4gSXMgdGhlcmUgYW55dGhpbmcgSSBh
bSBtaXNzaW5nPyBNYXliZSBmcm9tIHRoZSBpbnRlcmFjdGlvbiB3aXRoDQo+ID4gPiAiYW5vdGhl
ciBPUy9jb3JlIHJ1bm5pbmcgY29uY3VycmVudGx5IiB5b3UgbWVudGlvbmVkPyBJbiB0aGlzIGNh
c2UNCj4gPiA+IGlmIHlvdSBvbmx5IGhhdmUgdG8gcGVyZm9ybSBwaW4gY29uZmlndXJhdGlvbiAo
YmVjYXVzZSBtdXhpbmcgaXMNCj4gPiA+IGhhbmRsZWQNCj4gPiA+IGFscmVhZHkpIHRoaW5ncyBh
cmUgZXZlbiBzaW1wbGVyLCBqdXN0IHVzZSB0aGUgcGluIGNvbmZpZ3VyYXRpb24NCj4gPiA+IGJp
bmRpbmdzLCB3aXRob3V0IGludm9sdmluZyBtdXhpbmcgYXQgYWxsOg0KPiA+ID4NCj4gPiA+ICAg
ICAgICAgJnBpbmN0cmwgew0KPiA+ID4gICAgICAgICAgICAgICAgIHBpbnN1YXJ0X2NvbmY6IHVh
cnQwIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHBpbnMgPSA8MTAzLCAxMDQ+Ow0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgYmlhcy1wdWxsLXVwOw0KPiA+ID4gICAgICAg
ICAgICAgICAgICB9Ow0KPiA+ID4gICAgICAgICAgfTsNCj4gPg0KPiA+IFNvcnJ5IEkgZGlkbuKA
mXQgYWRkcmVzcyB5b3VyIHBvaW50Lg0KPiA+IFRoZSBvbmx5IHJlYXNvbiB3ZSB3YW50IHRvIHVz
ZSBuZXcgcHJvcGVydGllcyBpcyBzbyB0aGUgZHJpdmVyIGNhbg0KPiA+IHByb2Nlc3MgZHRzIGZp
bGVzIHRoYXQgaGF2ZSBiZWVuIGdlbmVyYXRlZCBmcm9tIGFuIGV4aXN0aW5nIFBpbk11eA0KPiA+
IEFwcC4gVGhhdCBvdXRwdXQgaXMgdXNlZCBieSBWeFdvcmtzIGFzIHdlbGwgYXMgb3VyIG91dC1v
Zi10cmVlIExpbnV4DQo+ID4gcG9ydC4gSWYgdGhhdCBpcyBub3QgYSBnb29kIGVub3VnaCByZWFz
b24gdG8gYWRkIG5ldyBwcm9wZXJ0aWVzLCB0aGVuDQo+ID4gSSBjYW4ndCBzZWUgYW55IHRlY2hu
aWNhbCByZWFzb24gbm90IHRvIHVzZSB0aGUgZXhpc3RpbmcgYmluZGluZ3MuDQo+ID4gVGhlIHVz
ZSB3aXRoIGFub3RoZXIgT1MgcnVubmluZyBvbiBhIGRpZmZlcmVudCBjb3JlIHNob3VsZCBub3Qg
YmUgYQ0KPiA+IGJhcnJpZXIgYXMgaXQgbXVzdCBub3QgdXNlIHRoZSBzYW1lIHBpbnMgYXMgTGlu
dXguDQo+IA0KPiBIYXZlIHRoZSBWeFdvcmtzIERUIGJpbmRpbmdzIGJlZW4gc3VibWl0dGVkIGZv
ciByZXZpZXcgdG8gdGhlIGRldmljZXRyZWUNCj4gbWFpbGluZyBsaXN0Pw0KSSdtIG5vdCBpbnZv
bHZlZCB3aXRoIHRoZSBWeFdvcmtzIHBvcnQsIGJ1dCBJIGFtIHByZXR0eSBzdXJlIHRoYXQgdGhl
eSBoYXZlDQpub3QgYmVlbiBzdWJtaXR0ZWQgZm9yIHJldmlldy4NCg0KVGhhbmtzDQpQaGlsDQo=
