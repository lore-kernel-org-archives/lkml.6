Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D3BC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A982080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="aWoooSEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A982080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbeLNKYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:24:02 -0500
Received: from mail-eopbgr1400093.outbound.protection.outlook.com ([40.107.140.93]:51840
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbeLNKYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU2oWmq4pxLlEfIrB9fQr6ZoWvcWXopcWWWNqrS07aQ=;
 b=aWoooSErydfHmM5UAUs9Lr76Z2L4aC8rMU8vK09wTyEtIpZkKhVpKvP5CTBh6X+HPq1toOQsLzh0dfrc8tuGoa3zQFOYecq+f2izgN7cyu87YueeJFTKPHGv98CrWGhHkrKWJzSFSYpNiyef2xGyArcgmrMiUkZRgpO2heVkE28=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1771.jpnprd01.prod.outlook.com (52.133.163.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 10:23:45 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::dcee:f270:d42b:5b48]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::dcee:f270:d42b:5b48%5]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 10:23:45 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] serial: sh-sci: Document r8a774c0 bindings
Thread-Topic: [PATCH] serial: sh-sci: Document r8a774c0 bindings
Thread-Index: AQHUkyDy6AVlzJMCW0+HMKr6wXG82aV+ArmAgAAD5wA=
Date:   Fri, 14 Dec 2018 10:23:45 +0000
Message-ID: <TY1PR01MB1770B6FE81A7AE8C9391670DC0A10@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1544732274-5904-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdWbBPue+n=Z9GOJVFFKr-stRV4-ozH0sxWjUbRmjDqN6g@mail.gmail.com>
In-Reply-To: <CAMuHMdWbBPue+n=Z9GOJVFFKr-stRV4-ozH0sxWjUbRmjDqN6g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1771;20:ri6ORXpR6Je/UgMZWFe93S3SboPVJUtTaUOc9d10czKiLDIJN32W2RH8j2mRG3cBa7FLuot1Snxl9Aw113zE3oryby9NY2l+ZjoCAJDDt84x2R7AnjLhUTKBMe8ajrfXpyhm3xxLPkD1C27Rz/tpdIWwZU7bfZJHmmor+vEmQcg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 0047f357-6af5-4848-634b-08d661ae3aa1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1771;
x-ms-traffictypediagnostic: TY1PR01MB1771:
x-microsoft-antispam-prvs: <TY1PR01MB1771877F9D0DA6BBD47AE62AC0A10@TY1PR01MB1771.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1771;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1771;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(7736002)(305945005)(71190400001)(71200400001)(74316002)(76176011)(5660300001)(7696005)(4326008)(7416002)(6116002)(3846002)(478600001)(256004)(53546011)(6506007)(54906003)(10126004)(14454004)(102836004)(2906002)(33656002)(68736007)(105586002)(6436002)(81156014)(81166006)(8676002)(106356001)(186003)(55016002)(6306002)(9686003)(53936002)(345774005)(66066001)(99286004)(316002)(11346002)(446003)(486006)(6916009)(25786009)(476003)(6246003)(86362001)(26005)(8936002)(229853002)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1771;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nUIFJCExuio+24fBBBOax3wD87VgPhtNkLJfTIatU+5bmHkjcxm2Y5ZMNFWCLxPl3Q/wV9NHG+rNRBCibUr1M+c/umIXZQo5nPtEvq90E64ugYTQAVIwcWHI2PEEPwaObVCvEFG79kDKVV4OE1CKGmkV69q4AreIVLe8C/+HYT0bC1zw98epWFiNi6/CESpd1kZhKjZmCgd9pAIO0zo3lTwR9018JtFx2szEAUEiLvahzQZhT639ZIvfOFRTWtCL7d+28tFdvYfdhi0pC9iYpw2RukcqUJLmC0OFrAFGn5uO8PY1sXeU8UkvGK+WdjAJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0047f357-6af5-4848-634b-08d661ae3aa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 10:23:45.3411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gR2VlcnQsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBH
ZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAxNCBEZWNl
bWJlciAyMDE4IDEwOjA1DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNlcmlhbDogc2gtc2NpOiBE
b2N1bWVudCByOGE3NzRjMCBiaW5kaW5ncw0KPg0KPiBPbiBUaHUsIERlYyAxMywgMjAxOCBhdCA5
OjE4IFBNIEZhYnJpemlvIENhc3Rybw0KPiA8ZmFicml6aW8uY2FzdHJvQGJwLnJlbmVzYXMuY29t
PiB3cm90ZToNCj4NCj4gZHQtYmluZGluZ3M6IC4uLg0KDQpXaWxsIHNlbmQgYSB2MiB0byBmaXgg
dGhpcw0KDQpUaGFua3MsDQpGYWINCg0KPg0KPiA+IFJaL0cyRSAoUjhBNzc0QzApIFNvQyBhbHNv
IGhhcyB0aGUgUi1DYXIgR2VuMyBjb21wYXRpYmxlIFNDSUYgYW5kDQo+ID4gSFNDSUYgcG9ydHMs
IHNvIGRvY3VtZW50IHRoZSBTb0Mgc3BlY2lmaWMgYmluZGluZ3MuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryb0BicC5yZW5lc2FzLmNvbT4N
Cj4NCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlk
ZXIuYmU+DQo+DQo+IEdye29ldGplLGVldGluZ31zLA0KPg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICBHZWVydA0KPg0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3Rz
IG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+DQo+IEluIHBl
cnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxm
IGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qg
c2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQoNCg0KW2h0dHBzOi8vd3d3Mi5y
ZW5lc2FzLmV1L21lZGlhL2VtYWlsL3VuaWNlZi5qcGddDQoNClRoaXMgQ2hyaXN0bWFzLCBpbnN0
ZWFkIG9mIHNlbmRpbmcgb3V0IGNhcmRzLCBSZW5lc2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBoYXZl
IGRlY2lkZWQgdG8gc3VwcG9ydCBVbmljZWYgd2l0aCBhIGRvbmF0aW9uLiBGb3IgZnVydGhlciBk
ZXRhaWxzIGNsaWNrIGhlcmU8aHR0cHM6Ly93d3cudW5pY2VmLm9yZy8+IHRvIGZpbmQgb3V0IGFi
b3V0IHRoZSB2YWx1YWJsZSB3b3JrIHRoZXkgZG8sIGhlbHBpbmcgY2hpbGRyZW4gYWxsIG92ZXIg
dGhlIHdvcmxkLg0KV2Ugd291bGQgbGlrZSB0byB0YWtlIHRoaXMgb3Bwb3J0dW5pdHkgdG8gd2lz
aCB5b3UgYSBNZXJyeSBDaHJpc3RtYXMgYW5kIGEgcHJvc3Blcm91cyBOZXcgWWVhci4NCg0KDQoN
ClJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIEx0ZCwgRHVrZXMgTWVhZG93LCBNaWxsYm9hcmQg
Um9hZCwgQm91cm5lIEVuZCwgQnVja2luZ2hhbXNoaXJlLCBTTDggNUZILCBVSy4gUmVnaXN0ZXJl
ZCBpbiBFbmdsYW5kICYgV2FsZXMgdW5kZXIgUmVnaXN0ZXJlZCBOby4gMDQ1ODY3MDkuDQo=
