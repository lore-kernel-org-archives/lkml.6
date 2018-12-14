Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC383C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CDC2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="oluMCM9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CDC2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeLNINj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:13:39 -0500
Received: from mail-eopbgr1400105.outbound.protection.outlook.com ([40.107.140.105]:28073
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbeLNINi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UEfFnWLyHig37pRFJ3gaaH5aeRUJyDnxiPMWARHYDE=;
 b=oluMCM9Mp3QoAMCvA+pGIHvx47yYagMbZQFGMfHqLUmmMGl+Xnax94LSVqHquf7CPowbGKWNFJyzyoaiMHgoGMU8FrODGJiZmhsqr64N+xEItVk7lT625GuViywcFphYf+Dm0VLNmwabYUQB1uQuCvXDADuOkamvdXM3MxqDCX4=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1854.jpnprd01.prod.outlook.com (52.133.165.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 08:13:22 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::64fb:82d3:31d2:1a12]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::64fb:82d3:31d2:1a12%2]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 08:13:22 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: i2c: sh_mobile: Add r8a774c0 support
Thread-Topic: [PATCH] dt-bindings: i2c: sh_mobile: Add r8a774c0 support
Thread-Index: AQHUkyEhba8/g2IWXk+7EqJjg8y1D6V9N5CAgACrqTA=
Date:   Fri, 14 Dec 2018 08:13:22 +0000
Message-ID: <TYXPR01MB177545E78D35A44BB1F46324C0A10@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1544732352-6178-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <c987f09c-689f-7e89-d496-f53b0ab6c2c1@axentia.se>
In-Reply-To: <c987f09c-689f-7e89-d496-f53b0ab6c2c1@axentia.se>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1854;20:+pLBsCMBPW0sxi04iMiQwe/nIznuOR243jVLcT503ilEgaEJ4NtFytsSNBORjPdEn3J7z4k86K8+XvoSvBSdjfDO+NXYLUQiJgnO6s2Q1MNZyiqjETyBp3kBXanrF7hHAs3LE7dJH9JLTGs6S3bOXaOt9JuwaWr7m5d9Zcb3UCo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 492d0841-a4c4-4b93-bb94-08d6619c03b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1854;
x-ms-traffictypediagnostic: TYXPR01MB1854:
x-microsoft-antispam-prvs: <TYXPR01MB1854BBD6D57027C36425BAB1C0A10@TYXPR01MB1854.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TYXPR01MB1854;BCL:0;PCL:0;RULEID:;SRVR:TYXPR01MB1854;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(256004)(7696005)(68736007)(5660300001)(4326008)(486006)(26005)(186003)(44832011)(2906002)(76176011)(102836004)(9686003)(53936002)(14454004)(3846002)(53546011)(11346002)(6116002)(99286004)(446003)(476003)(6306002)(6506007)(55016002)(66066001)(4001150100001)(6246003)(14444005)(345774005)(74316002)(97736004)(305945005)(86362001)(7416002)(478600001)(316002)(110136005)(54906003)(106356001)(25786009)(33656002)(71190400001)(229853002)(105586002)(71200400001)(6436002)(8676002)(7736002)(8936002)(81166006)(81156014)(10126004);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1854;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cLCFsq2LogTB677i406NZ4m3cbiLVbb4n12I5pUVNt86BHWRUy7Ki3DuHl17GvyMK+EyRlIoKWtnrTjvo6ixMuD/6Jp8F3Eg9XQ5lGCDu7bH+3NjowF3t8bIDSa3+axcn7LTayZrsHVFQyvqhx2+gwWoPCD1J/biy8G5pMpedIaKuHvaWrVtTZji/jAVDMhmVrIy/ZKkyOkKncocWZBBASEYqSNKgMdZpd1/YM/p4AUnTRipolwewaRx0DASakiotwgHyxrt2fgkCipbHhFoGtVN0DufBZ0VxMbdtORl6dVpX4OsdM3fyf9gXXX9VMhx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492d0841-a4c4-4b93-bb94-08d6619c03b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 08:13:22.3569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUGV0ZXIsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBQ
ZXRlciBSb3NpbiA8cGVkYUBheGVudGlhLnNlPg0KPiBTZW50OiAxMyBEZWNlbWJlciAyMDE4IDIx
OjU4DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGR0LWJpbmRpbmdzOiBpMmM6IHNoX21vYmlsZTog
QWRkIHI4YTc3NGMwIHN1cHBvcnQNCj4NCj4gT24gMjAxOC0xMi0xMyAyMToxOSwgRmFicml6aW8g
Q2FzdHJvIHdyb3RlOg0KPiA+IERvY3VtZW50IFJaL0cyRSAoUjhBNzc0QzApIFNvQyBiaW5kaW5n
cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8uY2Fz
dHJvQGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaTJjL2kyYy1zaF9tb2JpbGUudHh0IHwgMyArKy0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLXNoX21vYmlsZS50
eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1zaF9tb2JpbGUu
dHh0DQo+ID4gaW5kZXggYmM4NzZiNy4uM2RmZjg5ZiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1zaF9tb2JpbGUudHh0DQo+ID4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtc2hfbW9iaWxlLnR4
dA0KPiA+IEBAIC04LDYgKzgsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICAtICJyZW5l
c2FzLGlpYy1yOGE3NzQ0IiAoUlovRzFOKQ0KPiA+ICAtICJyZW5lc2FzLGlpYy1yOGE3NzQ1IiAo
UlovRzFFKQ0KPiA+ICAtICJyZW5lc2FzLGlpYy1yOGE3NzRhMSIgKFJaL0cyTSkNCj4gPiArLSAi
cmVuZXNhcyxpaWMtcjhhNzc0YzAiIChSWi9HMkUpDQo+ID4gIC0gInJlbmVzYXMsaWljLXI4YTc3
OTAiIChSLUNhciBIMikNCj4gPiAgLSAicmVuZXNhcyxpaWMtcjhhNzc5MSIgKFItQ2FyIE0yLVcp
DQo+ID4gIC0gInJlbmVzYXMsaWljLXI4YTc3OTIiIChSLUNhciBWMkgpDQo+ID4gQEAgLTMyLDcg
KzMzLDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAgV2hlbiBjb21wYXRpYmxlIHdpdGgg
InJlbmVzYXMscm1vYmlsZS1paWMiIGl0IHNob3VsZA0KPiA+ICBiZSB0aGUgbGFzdCBjb21wYXRp
YmlsaXR5IHN0cmluZyBsaXN0ZWQuDQo+ID4NCj4gPiAtVGhlIHI4YTc3OTkwIChSLUNhciBFMykg
Y29udHJvbGxlciBpcyBub3QNCj4gPiArVGhlIHI4YTc3OTkwIChSLUNhciBFMykgYW5kIFJaL0cy
RSBjb250cm9sbGVycyBhcmUgbm90DQo+DQo+IFRoZSByZWZlcmVuY2VzIHRvIHRoZXNlIHR3byBj
b250cm9sbGVycyBkbyBub3QgZm9sbG93IHRoZSBzYW1lIHN0eWxlLg0KPiBJJ2QgZWl0aGVyIGRl
bGV0ZSByOGE3Nzk5MCBhbmQgZ2V0ICJSLUNhciBFMyBhbmQgUlovRzJFIiBvciBhZGQNCj4gcjhh
Nzc0YzAgaW4gZnJvbnQgb2YgUlovRzJFIChicmFja2V0ZWQpLCB3aXRoIGEgc2xpZ2h0IHByZWZl
cmVuY2UNCj4gZm9yIHRoZSBsYXR0ZXIuDQoNCllvdSBhcmUgcmlnaHQsIEknbGwgc2VuZCBhIHYy
IHRvIGFkZHJlc3MgdGhpcy4NCg0KVGhhbmtzLA0KRmFiDQoNCj4NCj4gQ2hlZXJzLA0KPiBQZXRl
cg0KPg0KPiA+ICBjb25zaWRlcmVkIGNvbXBhdGlibGUgd2l0aCAicmVuZXNhcyxyY2FyLWdlbjMt
aWljIg0KPiA+ICBvciAicmVuZXNhcyxybW9iaWxlLWlpYyIgZHVlIHRvIHRoZSBhYnNlbmNlIG9m
DQo+ID4gIGF1dG9tYXRpYyB0cmFuc21pc3Npb24gcmVnaXN0ZXJzLg0KPiA+DQoNCg0KW2h0dHBz
Oi8vd3d3Mi5yZW5lc2FzLmV1L21lZGlhL2VtYWlsL3VuaWNlZi5qcGddDQoNClRoaXMgQ2hyaXN0
bWFzLCBpbnN0ZWFkIG9mIHNlbmRpbmcgb3V0IGNhcmRzLCBSZW5lc2FzIEVsZWN0cm9uaWNzIEV1
cm9wZSBoYXZlIGRlY2lkZWQgdG8gc3VwcG9ydCBVbmljZWYgd2l0aCBhIGRvbmF0aW9uLiBGb3Ig
ZnVydGhlciBkZXRhaWxzIGNsaWNrIGhlcmU8aHR0cHM6Ly93d3cudW5pY2VmLm9yZy8+IHRvIGZp
bmQgb3V0IGFib3V0IHRoZSB2YWx1YWJsZSB3b3JrIHRoZXkgZG8sIGhlbHBpbmcgY2hpbGRyZW4g
YWxsIG92ZXIgdGhlIHdvcmxkLg0KV2Ugd291bGQgbGlrZSB0byB0YWtlIHRoaXMgb3Bwb3J0dW5p
dHkgdG8gd2lzaCB5b3UgYSBNZXJyeSBDaHJpc3RtYXMgYW5kIGEgcHJvc3Blcm91cyBOZXcgWWVh
ci4NCg0KDQoNClJlbmVzYXMgRWxlY3Ryb25pY3MgRXVyb3BlIEx0ZCwgRHVrZXMgTWVhZG93LCBN
aWxsYm9hcmQgUm9hZCwgQm91cm5lIEVuZCwgQnVja2luZ2hhbXNoaXJlLCBTTDggNUZILCBVSy4g
UmVnaXN0ZXJlZCBpbiBFbmdsYW5kICYgV2FsZXMgdW5kZXIgUmVnaXN0ZXJlZCBOby4gMDQ1ODY3
MDkuDQo=
