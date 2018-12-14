Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E13DC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82D020879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="DSKBTS9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82D020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbeLNK2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:28:14 -0500
Received: from mail-eopbgr1400107.outbound.protection.outlook.com ([40.107.140.107]:6127
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbeLNK2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4O6kV05si+JI3IlazwrkbtRDAzNio9ciycQW37ICX4=;
 b=DSKBTS9n1teeAJad4aMkmgAWCMjL9nceZ51TK3geTVaJXnignefCgsa/N3DDzXCuoIeTBriqhcsgDi2elJory/zDSGaPpuCYXAwRxY6Ph9NSqpsRAJk6+ByfLfE7KYE1sBm66WKLaPhLq2j+8fBFCfyEJzElNxxsCl7y72xqy7E=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1593.jpnprd01.prod.outlook.com (52.133.162.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 10:28:07 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::dcee:f270:d42b:5b48]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::dcee:f270:d42b:5b48%5]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 10:28:07 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: i2c: rcar: Add r8a774c0 support
Thread-Topic: [PATCH] dt-bindings: i2c: rcar: Add r8a774c0 support
Thread-Index: AQHUkyEcJgA+wpgOfU64mlpSc8tCkKV+A2cAgAAEl/A=
Date:   Fri, 14 Dec 2018 10:28:07 +0000
Message-ID: <TY1PR01MB17701F0A62B0F602D76A593CC0A10@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1544732342-6131-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdUFbkowC9a-2wst_GufizEY2CtWjr2R0yerzS1d5EmB-w@mail.gmail.com>
In-Reply-To: <CAMuHMdUFbkowC9a-2wst_GufizEY2CtWjr2R0yerzS1d5EmB-w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1593;20:8+5qJK2bqzV71U7zK0v01lISYo+D6jQ61TySwA1iIepBupV/WI0FCrsiCA8GVbCJaemHKiku/uBF+pZmGR39kySMqksu5+2vi4DQifv19bvj4k0fBtrIc7nnSv/xlZyMOeFxKuM7NFDhDZBjW5S6/DzQMbq4C4gV0EV2D/e/H6Q=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: be765dac-9e17-4fd4-8d76-08d661aed6d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1593;
x-ms-traffictypediagnostic: TY1PR01MB1593:
x-microsoft-antispam-prvs: <TY1PR01MB1593104F35A9617F24417140C0A10@TY1PR01MB1593.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1593;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1593;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(376002)(396003)(136003)(199004)(189003)(7696005)(14454004)(5660300001)(7736002)(53936002)(9686003)(76176011)(6306002)(71190400001)(71200400001)(486006)(476003)(6116002)(6246003)(102836004)(446003)(345774005)(99286004)(3846002)(44832011)(39060400002)(256004)(7416002)(55016002)(478600001)(6506007)(11346002)(53546011)(6916009)(25786009)(305945005)(66066001)(86362001)(10126004)(4326008)(81156014)(81166006)(186003)(97736004)(8676002)(26005)(8936002)(316002)(68736007)(33656002)(6436002)(105586002)(54906003)(106356001)(229853002)(2906002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1593;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TNNqcOA0Lh6VPD+u4uHfUBBy9V1+004nQwFY6z1J6dxQR+FtJHhN8HsB0jJlCsK4euimegSdbfTGt/wYTgB/agDp3p5fzRn40gh8NX534PCbeTbsTiZZIOWC9ffBNx8rJggxN0xXlI6rInVzaXbWZszP5R+950zMldYBWwSAqSqsNGXs1PvKYJrJ20cibTPwLvkwLlZc8CKtOhKXkwUbR0Bxnf0fRy5OhAuqLzohfMGHAE05/ZzZ5xgPKhskCPcC3VxYlaqjzFzKcunu0OA1h7mSch5eUAdejj9sODgFzcTtPv18zkck9IwYFcMKEycf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be765dac-9e17-4fd4-8d76-08d661aed6d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 10:28:07.3620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gR2VlcnQsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBk
ZXZpY2V0cmVlLW93bmVyQHZnZXIua2VybmVsLm9yZyA8ZGV2aWNldHJlZS1vd25lckB2Z2VyLmtl
cm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBHZWVydCBVeXR0ZXJob2V2ZW4NCj4gU2VudDogMTQgRGVj
ZW1iZXIgMjAxOCAxMDowOA0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogaTJj
OiByY2FyOiBBZGQgcjhhNzc0YzAgc3VwcG9ydA0KPg0KPiBPbiBUaHUsIERlYyAxMywgMjAxOCBh
dCA5OjE5IFBNIEZhYnJpemlvIENhc3Rybw0KPiA8ZmFicml6aW8uY2FzdHJvQGJwLnJlbmVzYXMu
Y29tPiB3cm90ZToNCj4gPiBEb2N1bWVudCBSWi9HMkUgKFI4QTc3NEMwKSBJMkMgY29tcGF0aWJp
bGl0eSB3aXRoIHRoZSByZWxldmFudCBkcml2ZXINCj4NCj4gZGV2aWNlDQoNCldpbGwgc2VuZCBh
IHYyIHRvIGZpeCB0aGlzLg0KDQpUaGFua3MsDQpGYWINCg0KPg0KPiA+IGR0LWJpbmRpbmdzLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm9A
YnAucmVuZXNhcy5jb20+DQo+DQo+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdl
ZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg0KPg0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4NCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4NCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVu
IC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhr
Lm9yZw0KPg0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3Bs
ZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91
cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4N
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0KDQoN
CltodHRwczovL3d3dzIucmVuZXNhcy5ldS9tZWRpYS9lbWFpbC91bmljZWYuanBnXQ0KDQpUaGlz
IENocmlzdG1hcywgaW5zdGVhZCBvZiBzZW5kaW5nIG91dCBjYXJkcywgUmVuZXNhcyBFbGVjdHJv
bmljcyBFdXJvcGUgaGF2ZSBkZWNpZGVkIHRvIHN1cHBvcnQgVW5pY2VmIHdpdGggYSBkb25hdGlv
bi4gRm9yIGZ1cnRoZXIgZGV0YWlscyBjbGljayBoZXJlPGh0dHBzOi8vd3d3LnVuaWNlZi5vcmcv
PiB0byBmaW5kIG91dCBhYm91dCB0aGUgdmFsdWFibGUgd29yayB0aGV5IGRvLCBoZWxwaW5nIGNo
aWxkcmVuIGFsbCBvdmVyIHRoZSB3b3JsZC4NCldlIHdvdWxkIGxpa2UgdG8gdGFrZSB0aGlzIG9w
cG9ydHVuaXR5IHRvIHdpc2ggeW91IGEgTWVycnkgQ2hyaXN0bWFzIGFuZCBhIHByb3NwZXJvdXMg
TmV3IFllYXIuDQoNCg0KDQpSZW5lc2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBMdGQsIER1a2VzIE1l
YWRvdywgTWlsbGJvYXJkIFJvYWQsIEJvdXJuZSBFbmQsIEJ1Y2tpbmdoYW1zaGlyZSwgU0w4IDVG
SCwgVUsuIFJlZ2lzdGVyZWQgaW4gRW5nbGFuZCAmIFdhbGVzIHVuZGVyIFJlZ2lzdGVyZWQgTm8u
IDA0NTg2NzA5Lg0K
