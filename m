Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06BBC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDAB2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ffVm78Rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDAB2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbeKFWkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:40:53 -0500
Received: from mail-ty1jpn01on0134.outbound.protection.outlook.com ([104.47.93.134]:55816
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387537AbeKFWkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI7um+CnBb2phsgJ2/DeD3ia9ISgOWtoptxPwHdyQnY=;
 b=ffVm78RrYerm1rXfrh+e/otzIs+t+xTI+qXbO+yyLl2w75cFSriMk/DJ4nymE9Xi1rrfTleXCzr3Xh16/JNztRdhoHHtlTzF29RiA7HCsZ1+MTy+B+89z9lZzd59OPZxxGaUqJZ+GVFTzZkX5MOSDhJqmCL/eesYWrNpA2tZT9Y=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1200.jpnprd01.prod.outlook.com (10.174.226.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Tue, 6 Nov 2018 13:15:36 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 13:15:36 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Topic: [PATCH v2 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Index: AQHUcD2lJIxNUCxga0G4J4tYz/ve2aU4/58AgABgR3CAAB0GAIAAAMBggAk3nWA=
Date:   Tue, 6 Nov 2018 13:15:35 +0000
Message-ID: <TY1PR01MB17696E2B10CA447CD3508ADAF5CB0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181030104438.27827-1-phil.edworthy@renesas.com>
 <20181030104438.27827-3-phil.edworthy@renesas.com>
 <86d0rq35o1.wl-marc.zyngier@arm.com>
 <TY1PR01MB176959B0CF663D0ECB298924F5CD0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <b95c7fc3-7fda-48b7-6933-b7b183b6fa67@arm.com>
 <TY1PR01MB1769D6F84F7BCD91C1018922F5CD0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1769D6F84F7BCD91C1018922F5CD0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1200;20:dqD9qrd3HPV3UvFrqqpg+GWzJNdnmvOCM7nMjhcTI62a3j2DpLSxC+OrxSl/Seq4ND1py9mT2G91W1QaeYvb61PvIY/pCpvgsiNV1NMTVpilj6O4kYIG+ksq6COX88QAkXyBG6qwteDMJpDVdjXsL6Aeq2mq+rU0MA9T/2SSLCg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ed6b57de-b4fb-4084-9013-08d643e9f0bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1200;
x-ms-traffictypediagnostic: TY1PR01MB1200:
x-microsoft-antispam-prvs: <TY1PR01MB120044E2E9CED60E19E0BA10F5CB0@TY1PR01MB1200.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1200;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1200;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(5660300001)(6506007)(6246003)(53546011)(2906002)(26005)(102836004)(476003)(53936002)(486006)(186003)(9686003)(55016002)(106356001)(74316002)(76176011)(7696005)(86362001)(44832011)(446003)(11346002)(7736002)(6436002)(305945005)(97736004)(316002)(478600001)(54906003)(93886005)(110136005)(229853002)(105586002)(2900100001)(99286004)(4326008)(14454004)(256004)(3846002)(6116002)(25786009)(33656002)(66066001)(68736007)(71190400001)(81156014)(8936002)(71200400001)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1200;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BKH6EKxOsibzlWIlK3vj5g3Qx0EhCKo/AQXPn3IqedXhfsli6syxFXS8L9ki8QZQHMZD9IaM19r5/nmjl+2t/83QGYrpAJQ5qm4uNtxun3FHWlgDaIIrLSOvKeKUOn8oWGTTPed724XhLVioM2GPY3nIPRcO3HtrXEp5WgeX57zERWzry+1WgbiizNwex7F4/VRYeS+RDeZLdtPWCjT/V7C0ZFCrl0cDwgSJzSs67czK5YuMtr4ZfqvnCgJA/n2BAemBI4RRu2wnFfIgFqFWJnF+M+F+v4LugBUaf/7NaIAl927e5Xr4Y6luwomhU+IxbXLdrkJ54DuSgPlS2WGU/F/XFcsRsrbmXDKBfwsDYE0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6b57de-b4fb-4084-9013-08d643e9f0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:15:35.8025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KT24gMzEgT2N0b2JlciAyMDE4IDE1OjM5LCBQaGlsIEVkd29ydGh5IHdyb3Rl
DQo+IE9uIDMxIE9jdG9iZXIgMjAxOCAxNTozMSwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiA+IE9u
IDMxLzEwLzE4IDE1OjA5LCBQaGlsIEVkd29ydGh5IHdyb3RlOg0KPiA+ID4gT24gMzEgT2N0b2Jl
ciAyMDE4IDA4OjAyLCBNYXJjIFp5bmdpZXIgd290ZToNCj4gPiA+PiBPbiBUdWUsIDMwIE9jdCAy
MDE4IDEwOjQ0OjM4ICswMDAwLCBQaGlsIEVkd29ydGh5IHdyb3RlOg0KPiA+ID4+Pg0KPiA+ID4+
PiBPbiBSWi9OMSBkZXZpY2VzLCB0aGVyZSBhcmUgMyBTeW5vcHN5cyBEZXNpZ25XYXJlIEdQSU8g
YmxvY2tzIGVhY2gNCj4gPiA+Pj4gY29uZmlndXJlZCB0byBoYXZlIDMyIGludGVycnVwdCBvdXRw
dXRzLCBzbyB3ZSBoYXZlIGEgdG90YWwgb2YgOTYNCj4gPiA+Pj4gR1BJTyBpbnRlcnJ1cHRzLiBB
bGwgb2YgdGhlc2UgYXJlIHBhc3NlZCB0byB0aGUgR1BJTyBJUlEgTXV4ZXIsDQo+ID4gPj4+IHdo
aWNoIHNlbGVjdHMNCj4gPiA+Pj4gOCBvZiB0aGUgR1BJTyBpbnRlcnJ1cHRzIHRvIHBhc3Mgb250
byB0aGUgR0lDLiBUaGUgaW50ZXJydXB0DQo+ID4gPj4+IHNpZ25hbHMgYXJlbid0IGxhdGNoZWQs
IHNvIHRoZXJlIGlzIG5vdGhpbmcgdG8gZG8gaW4gdGhpcyBkcml2ZXINCj4gPiA+Pj4gd2hlbiBh
biBpbnRlcnJ1cHQgaXMgcmVjZWl2ZWQsIG90aGVyIHRoYW4gdGVsbCB0aGUgY29ycmVzcG9uZGlu
ZyBHUElPDQo+IGJsb2NrLg0KPHNuaXA+DQoNCj4gPiBUaGVyZSBhcmUgdHdvIGNhc2VzOg0KPiA+
IDEpIHRoZXJlIGlzIDE6MSBtYXBwaW5nIGJldHdlZW4gYSB1c2VkIGlucHV0IGFuZCBhbiBvdXRw
dXQsIGxlYXZpbmcNCj4gPiBzb21lIGlucHV0IHVudXNlZA0KPiA+IDIpIHRoZXJlIGlzIGFuIG46
MSBtYXBwaW5nIGJldHdlZW4gaW5wdXQgYW5kIG91dHB1dCwgYW5kIGFsbCB0aGUgaW5wdXQNCj4g
PiBjYW4gYmUgdXNlZCBhdCBhbnkgZ2l2ZW4gdGltZQ0KPiA+DQo+ID4gSWYgd2hhdCB5b3UgaGF2
ZSBpcyAoMSksIHlvdSBuZWVkIHRvIGltcGxlbWVudCBhbiBoaWVyYXJjaHkuDQo+ID4gSWYgd2hh
dCB5b3UgaGF2ZSBpcyAoMiksIHlvdSBuZWVkIHRvIGltcGxlbWVudCBhIGNoYWluZWQgY29udHJv
bGxlci4NCj4gPg0KPiA+ICgxKSByZXF1aXJlcyB5b3UgdG8gcmV2aXNpdCB0aGlzIGRyaXZlciwg
bWFraW5nIGl0IGEgbG90IG1vcmUgbGlrZQ0KPiA+IHRpJ3MgaXJxLWNyb3NzYmFyDQo+ID4gKDIp
IHJlcXVpcmVzIHlvdSB0byBhY3R1YWxseSBkbyBzb21lIGRlY29kaW5nIGluIHRoZSBjaGFpbmVk
IGhhbmRsZXINCj4gPg0KPiA+IEkgYmVsaWV2ZSB5b3UncmUgaW4gY29uZmlndXJhdGlvbiAoMSku
IEFtIEkgcmlnaHQ/DQo+IFJpZ2h0LCBpdCdzIGEgMToxIG1hcHBpbmcuIFRoZSBpbmZvcm1hdGlv
biBhYm91dCB3aGljaCBpbnB1dCB0byBiZSB1c2VkIG5lZWRzDQo+IHRvIGJlIHNwZWNpZmllZCBp
biBkdC4NCj4gSSBkaWRu4oCZdCB0aGluayBJIGNvdWxkIGltcGxlbWVudCBhIGhpZXJhcmNoeSB0
aGF0IGRpZG7igJl0IG1hc2sgdGhlIGludGVycnVwdHMsDQo+IHNvIEkgbmVlZCB0byBnbyBiYWNr
IG92ZXIgdGhhdCBhbmQgbG9vayBhZ2Fpbi4uLg0KDQpPaywgSSBoYXZlIGNoYW5nZWQgdGhlIGRy
aXZlciB0byBpbXBsZW1lbnQgYSBoaWVyYXJjaHksIGkuZS4NCmNhbGwgaXJxX2RvbWFpbl9jcmVh
dGVfaGllcmFyY2h5KCkgaW4gcHJvYmUsDQpjYWxsIGlycV9kb21haW5fc2V0X2h3aXJxX2FuZF9j
aGlwKCkgYW5kIGlycV9kb21haW5fYWxsb2NfaXJxc19wYXJlbnQoKQ0KaW4gdGhlIGlycV9kb21h
aW5fb3BzLmFsbG9jIGZ1bmN0aW9uLg0KDQpJJ3ZlIGdvdCBhIGNvdXBsZSBvZiBpc3N1ZXMgdGhh
dCBJIGhvcGUgeW91IGNhbiBwcm92aWRlIHNvbWUgaW5wdXQgb24uDQoNCkZpcnN0IGlzIHdoYXQg
dG8gZG8gd2l0aCBpcnFzIHRoYXQgYXJlIGlucHV0IHRvIHRoaXMgbXV4IGJ1dCBub3Qgc2VsZWN0
ZWQuDQpJZiBJIGRvbid0IGNhbGwgaXJxX2RvbWFpbl9zZXRfaHdpcnFfYW5kX2NoaXAoKSBhbmQg
aXJxX2RvbWFpbl9hbGxvY19pcnFzX3BhcmVudCgpLA0KaXQgY2F1c2VzIHRoZSBkcml2ZXIgZm9y
IHRoZSBoYXJkd2FyZSB0aGF0IGdlbmVyYXRlcyB0aGVzZSBpbnRlcnJ1cHRzIChpbg0KdGhpcyBj
YXNlLCBTeW5vcHN5cyBkd2FwYl9ncGlvKSB0byB0aHJvdyBhbiBleGNlcHRpb24gaW4NCmlycV9z
ZXRfY2hhaW5lZF9oYW5kbGVyX2FuZF9kYXRhKCkuDQpBcyBhIGhhY2ssIEkgaGF2ZSBzaW1wbHkg
dXNlZCBhbiB1bnVzZWQgb3V0cHV0IGlycS4NCg0KU2Vjb25kIGlzIHNwZWNpZnlpbmcgdGhlIG91
dHB1dCBpcnFzLiBDdXJyZW50bHksIEkgc3BlY2lmeSB0aGVtIGxpa2UgdGhpczoNCglpbnRlcnJ1
cHRzID0NCgkJPEdJQ19TUEkgMTAzIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KCQk8R0lDX1NQSSAx
MDQgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQoJCS4uLg0KCQk8R0lDX1NQSSAxMTAgSVJRX1RZUEVf
TEVWRUxfSElHSD47DQpIb3dldmVyLCBJIGFtIG9ubHkgcmVhZGluZyB0aGUgcHJvcGVydHkgc28g
SSBjYW4gcGFzcyB0aGUgZndzcGVjIHRvDQppcnFfZG9tYWluX2FsbG9jX2lycXNfcGFyZW50KCku
IEkgYW0gbm90IHVzaW5nIGFueXRoaW5nIHRoYXQgZW5kcyB1cA0KaW4gb2ZfaXJxX3BhcnNlX3Jh
dygpLg0KDQpSb2IgSCBoYXMgcHJldmlvdXNseSBzYWlkIHRoYXQgSSBzaG91bGQgdXNlIGludGVy
cnVwdC1tYXAgdG8gZGVzY3JpYmUgdGhlDQpyZWxhdGlvbnNoaXAgYmV0d2VlbiB0aGUgaW5wdXQg
YW5kIG91dHB1dCBpcnFzLiBVbmZvcnR1bmF0ZWx5LCBpcnENCmhpZXJhcmNoeSBzZWVtcyB0byBi
ZSBzb21ld2hhdCBhdCBvZGRzIHdpdGggdXNpbmcgaW50ZXJydXB0LW1hcC4NCk9yIGF0IGxlYXN0
LCBJIGNhbuKAmXQgc2VlIGhvdyB0aGUgdHdvIGNhbiBiZSBjb21iaW5lZC4NCg0KWW91ciBmZWVk
YmFjayBvbiB0aGlzIGlzIGdyZWF0bHkgYXBwcmVjaWF0ZWQhDQpUaGFua3MNClBoaWwNCg==
