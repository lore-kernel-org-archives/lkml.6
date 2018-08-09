Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B71C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE6621C3C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kcEOi9px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE6621C3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeHIJ2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:28:08 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:10944
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbeHIJ2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC28NkJE4Ag9uvKVQl5dthxIrVsWKkRKeuac5C0ZBVs=;
 b=kcEOi9px+eAzzjn73Xkt06B7ZtYxEorbTswaWXgB4ecAbx67enTYdMT3FQqj4YUnHCTmx4mf+2S42FX7w4tOl8S1nDiuBqvQVs2Y/YAxdCdi4pt1cricYNtGfUNmAXcSxtnQJ+AhASROg7VNixQCp0Q19aBht2rZ+FZ71ik+cUE=
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com (10.169.245.8) by
 AM5PR0401MB2658.eurprd04.prod.outlook.com (10.169.245.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Thu, 9 Aug 2018 07:04:35 +0000
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::a2:591f:fe8f:7c93]) by AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::a2:591f:fe8f:7c93%3]) with mapi id 15.20.1038.023; Thu, 9 Aug 2018
 07:04:35 +0000
From:   Bharat Bhushan <bharat.bhushan@nxp.com>
To:     Scott Wood <oss@buserror.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tyreld@linux.vnet.ibm.com" <tyreld@linux.vnet.ibm.com>,
        "joe@perches.com" <joe@perches.com>
Subject: RE: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
Thread-Topic: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
Thread-Index: AQHUJY+OEK4rmRCzmU6sElTr8iVLCqS02/0AgABrfQCAACZCgIAAAdDggADH3YCAAJ7PEIAALmeAgAAJb3A=
Date:   Thu, 9 Aug 2018 07:04:35 +0000
Message-ID: <AM5PR0401MB2545EA3D59F997C8483AE8E89A250@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
         <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
         <ab2a113620123cb71364b6ae89328ae2fca49821.camel@buserror.net>
         <AM5PR0401MB254592DC0E917FD292B323BA9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
         <aeff83355ee5235cfd6107dba06a5f7957b45c92.camel@buserror.net>
         <AM5PR0401MB2545041D99EEDC3136B201719A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
         <bef421feea16da2fdab333e63a6828741bd59055.camel@buserror.net>
         <AM5PR0401MB25458654D6CEFBF2F05FC7709A250@AM5PR0401MB2545.eurprd04.prod.outlook.com>
 <5c1bcbd2c753f4224764c1932e5a9a99b4a604f5.camel@buserror.net>
In-Reply-To: <5c1bcbd2c753f4224764c1932e5a9a99b4a604f5.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0401MB2658;6:CXBGC5s0lJCZy1uvnzELDiC7HqAg+n95IlwTvM7N8avS75Tfgv2QstR+ChJuGJIENMmodGz1mBUZngOuTEK3t4/Gan/4YuN0NhLIzvPMtBKxRdWYA19od0yAYbasCNOC2zsxAkDson9MCA/BYgJ8TVcNIdzs5N2oE/S8iEi9msdnCu9WZIkI2P3YyumNMj1IpxUQzrPbBfh0Zajbt4XFiPnqBn1sKOmxbW1GVSdcTA/iiGp/VwUoOym0IbdxfvhShjyElspIj50wx7I6UpMrhES++qlyiHDH7XNf37D045Nxd1oUJn6ZVq5t0a7MfmQM0XR7hKrhORZtw/rNQ/1T0Fv0mGntZbf6a4TcU19Ojl40bk1fhLA2L6AcbVPtSE+NgBlp3veOvlUsw/4zQ7jpNMMjB3rms4H8pUWEUl5f/jiholPA8kCFCrsFaCilux7ZG/iYeOGLUtXLYvn+ptOiEw==;5:d5jDn13rLGSo3TuDgdrCOcjmxj7mMNQd0+MO4CCnBkhLWKjUaq3M9u5LbZyJF93uUw9kW460VJkYtaUvWvqdBvM+BDi5qp0YGFRe3CbISDbG4UhlsCHb5e/nVGQVDy9OsT0mKHT1ISaRpPfH2xuZQc6yOZdsb7pTbLdMnoZfnjI=;7:8hKRCoqAwl4ndrbtnq1OM1dcU/tc/nqBY1ohfYsdAXJiTKwL3VSssRLf2WlUykQxaIytRK/NzHpn5R6PHcsqzK45+TybWThlFL6D7H0HNktGZeZ58KG1BdlqB+av9pD9Wl/GsXiQAw0An94c6QuZlnQGXGQumJ82o/7r94m1mikumdmdQd18w9me7YqnuoiJnYG8PG/JA6ONDtM2a1eU41G2f1DQM5OOjENCgvrtbyazik+bCNvC50p47jdBa024
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6026635f-27e2-4f9b-4e44-08d5fdc65d92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2658;
x-ms-traffictypediagnostic: AM5PR0401MB2658:
x-microsoft-antispam-prvs: <AM5PR0401MB26582987DF1A6045D92A9C439A250@AM5PR0401MB2658.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM5PR0401MB2658;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0401MB2658;
x-forefront-prvs: 0759F7A50A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(13464003)(74316002)(2900100001)(66066001)(7416002)(478600001)(486006)(446003)(11346002)(476003)(6246003)(2501003)(305945005)(7736002)(105586002)(5660300001)(106356001)(6116002)(68736007)(86362001)(2201001)(33656002)(3846002)(2906002)(25786009)(4326008)(76176011)(53546011)(6506007)(14454004)(26005)(5250100002)(186003)(102836004)(97736004)(44832011)(8676002)(110136005)(81166006)(81156014)(53936002)(54906003)(7696005)(93886005)(229853002)(99286004)(8936002)(6436002)(9686003)(14444005)(55016002)(256004)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0401MB2658;H:AM5PR0401MB2545.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Kq3EzA8EWVVwbSq7M60uXncomZ+w9zu4mh2BLtGarzxi0iH37lSD38o33yx9DFUjd+41a4YjaaoVkLznhvHQxoWY3Ide3hgcG9WQt/3m+vPq14G0HMDAH0qs4kE6OL3YHg0z1SaDM1vJg09O4mPRvXJxdx0i2r+fNnVZYkhIiylRecqXcc7QAgrj1m6kee0XMgK/FT+/T6T39p13ybgh5F1yU2Kdaf4mcFQavWe7Z1ERJgBHrP6Sa08ly4tKNqeP8QWzAtllbg6ec1DUvbD4hCyUDrUq7a8x3fHqmwBMWgaJViT8SiuB1GXhXMYWFnqa4t2ue6ztwORJSX+Fy5kVkYJrZOxyhERnv2uBngyoQy0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6026635f-27e2-4f9b-4e44-08d5fdc65d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2018 07:04:35.6252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCBbbWFp
bHRvOm9zc0BidXNlcnJvci5uZXRdDQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgOSwgMjAxOCAx
MTo0MiBBTQ0KPiBUbzogQmhhcmF0IEJodXNoYW4gPGJoYXJhdC5iaHVzaGFuQG54cC5jb20+Ow0K
PiBiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc7IHBhdWx1c0BzYW1iYS5vcmc7IG1wZUBlbGxlcm1h
bi5pZC5hdTsNCj4gZ2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZzsgbWFyay5ydXRsYW5kQGFybS5j
b207DQo+IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtZGV2QGxpc3Rz
Lm96bGFicy5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiByb2Jo
QGtlcm5lbC5vcmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsgdHlyZWxkQGxpbnV4LnZuZXQuaWJt
LmNvbTsNCj4gam9lQHBlcmNoZXMuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIDUvNV0gcG93ZXJw
Yy9mc2w6IEFkZCBzdXBwb3J0ZWQtaXJxLXJhbmdlcyBmb3IgUDIwMjANCj4gDQo+IE9uIFRodSwg
MjAxOC0wOC0wOSBhdCAwMzoyOCArMDAwMCwgQmhhcmF0IEJodXNoYW4gd3JvdGU6DQo+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogU2NvdHQgV29vZCBbbWFpbHRv
Om9zc0BidXNlcnJvci5uZXRdDQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCA4LCAyMDE4
IDExOjI3IFBNDQo+ID4gPiBUbzogQmhhcmF0IEJodXNoYW4gPGJoYXJhdC5iaHVzaGFuQG54cC5j
b20+Ow0KPiA+ID4gYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBwYXVsdXNAc2FtYmEub3JnOyBt
cGVAZWxsZXJtYW4uaWQuYXU7DQo+ID4gPiBnYWxha0BrZXJuZWwuY3Jhc2hpbmcub3JnOyBtYXJr
LnJ1dGxhbmRAYXJtLmNvbTsNCj4gPiA+IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiA+ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC0NCj4gPiA+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IENjOiByb2JoQGtlcm5lbC5vcmc7IGtlZXNjb29rQGNocm9t
aXVtLm9yZzsNCj4gPiA+IHR5cmVsZEBsaW51eC52bmV0LmlibS5jb207IGpvZUBwZXJjaGVzLmNv
bQ0KPiA+ID4gU3ViamVjdDogUmU6IFtSRkMgNS81XSBwb3dlcnBjL2ZzbDogQWRkIHN1cHBvcnRl
ZC1pcnEtcmFuZ2VzIGZvcg0KPiA+ID4gUDIwMjANCj4gPiA+DQo+ID4gPiBPbiBXZWQsIDIwMTgt
MDgtMDggYXQgMDY6MjggKzAwMDAsIEJoYXJhdCBCaHVzaGFuIHdyb3RlOg0KPiA+ID4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogU2NvdHQgV29vZCBbbWFp
bHRvOm9zc0BidXNlcnJvci5uZXRdDQo+ID4gPiA+ID4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3Qg
OCwgMjAxOCAxMToyNiBBTQ0KPiA+ID4gPiA+IFRvOiBCaGFyYXQgQmh1c2hhbiA8YmhhcmF0LmJo
dXNoYW5AbnhwLmNvbT47DQo+ID4gPiA+ID4gYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBwYXVs
dXNAc2FtYmEub3JnOyBtcGVAZWxsZXJtYW4uaWQuYXU7DQo+ID4gPiA+ID4gZ2FsYWtAa2VybmVs
LmNyYXNoaW5nLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+ID4gPiA+ID4ga3N0ZXdhcnRA
bGludXhmb3VuZGF0aW9uLm9yZzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+ID4gPiA+
ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMu
b3JnOw0KPiA+ID4gPiA+IGxpbnV4LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiA+ID4g
Q2M6IHJvYmhAa2VybmVsLm9yZzsga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOw0KPiA+ID4gPiA+IHR5
cmVsZEBsaW51eC52bmV0LmlibS5jb207IGpvZUBwZXJjaGVzLmNvbQ0KPiA+ID4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUkZDIDUvNV0gcG93ZXJwYy9mc2w6IEFkZCBzdXBwb3J0ZWQtaXJxLXJhbmdlcyBm
b3INCj4gPiA+ID4gPiBQMjAyMA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gV2VkLCAyMDE4LTA4
LTA4IGF0IDAzOjQ0ICswMDAwLCBCaGFyYXQgQmh1c2hhbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiA+ID4gRnJvbTogU2NvdHQgV29v
ZCBbbWFpbHRvOm9zc0BidXNlcnJvci5uZXRdDQo+ID4gPiA+ID4gPiA+IFNlbnQ6IFdlZG5lc2Rh
eSwgQXVndXN0IDgsIDIwMTggMjo0NCBBTQ0KPiA+ID4gPiA+ID4gPiBUbzogQmhhcmF0IEJodXNo
YW4gPGJoYXJhdC5iaHVzaGFuQG54cC5jb20+Ow0KPiA+ID4gPiA+ID4gPiBiZW5oQGtlcm5lbC5j
cmFzaGluZy5vcmc7IHBhdWx1c0BzYW1iYS5vcmc7DQo+ID4gPiA+ID4gPiA+IG1wZUBlbGxlcm1h
bi5pZC5hdTsgZ2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZzsNCj4gPiA+ID4gPiA+ID4gbWFyay5y
dXRsYW5kQGFybS5jb207IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+ID4gPiA+ID4g
PiA+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsNCj4gPiA+ID4gPiA+ID4gbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7DQo+ID4gPiA+
ID4gPiA+IGxpbnV4LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiA+ID4gPiA+IENjOiBy
b2JoQGtlcm5lbC5vcmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gPiA+ID4gPiA+ID4gdHly
ZWxkQGxpbnV4LnZuZXQuaWJtLmNvbTsgam9lQHBlcmNoZXMuY29tDQo+ID4gPiA+ID4gPiA+IFN1
YmplY3Q6IFJlOiBbUkZDIDUvNV0gcG93ZXJwYy9mc2w6IEFkZCBzdXBwb3J0ZWQtaXJxLXJhbmdl
cw0KPiA+ID4gPiA+ID4gPiBmb3INCj4gPiA+ID4gPiA+ID4gUDIwMjANCj4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gT24gRnJpLCAyMDE4LTA3LTI3IGF0IDE1OjE4ICswNTMwLCBCaGFyYXQg
Qmh1c2hhbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBNUElDIG9uIE5YUCAoRnJlZXNjYWxlKSBQ
MjAyMCBzdXBwb3J0cyBmb2xsb3dpbmcgaXJxDQo+ID4gPiA+ID4gPiA+ID4gcmFuZ2VzOg0KPiA+
ID4gPiA+ID4gPiA+ICAgPiAwIC0gMTEgICAgICAoRXh0ZXJuYWwgaW50ZXJydXB0KQ0KPiA+ID4g
PiA+ID4gPiA+ICAgPiAxNiAtIDc5ICAgICAoSW50ZXJuYWwgaW50ZXJydXB0KQ0KPiA+ID4gPiA+
ID4gPiA+ICAgPiAxNzYgLSAxODMgICAoTWVzc2FnaW5nIGludGVycnVwdCkNCj4gPiA+ID4gPiA+
ID4gPiAgID4gMjI0IC0gMjMxICAgKFNoYXJlZCBtZXNzYWdlIHNpZ25hbGVkIGludGVycnVwdCkN
Cj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gV2h5IGRvbid0IHlvdSBjb252ZXJ0IHRvIHRo
ZSA0LWNlbGwgaW50ZXJydXB0IHNwZWNpZmllcnMNCj4gPiA+ID4gPiA+ID4gdGhhdCBtYWtlIGRl
YWxpbmcgd2l0aCB0aGVzZSByYW5nZXMgbGVzcyBlcnJvci1wcm9uZT8NCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBPayAsIHdpbGwgZG8gaWYgd2UgYWdyZWUgdG8gaGF2ZSB0aGlzIHNlcmllcyBh
cyBwZXIgY29tbWVudCBvbg0KPiA+ID4gPiA+ID4gb3RoZXIgcGF0Y2guDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBJZiB5b3UncmUgY29uY2VybmVkIHdpdGggZXJyb3JzLCB0aGlzIHdvdWxkIGJlIGEg
Z29vZCB0aGluZ3MgdG8NCj4gPiA+ID4gPiBkbyByZWdhcmRsZXNzLg0KPiA+ID4gPiA+ICBBY3R1
YWxseSwgaXQgc2VlbXMgdGhhdCBwMjAyMHNpLXBvc3QuZHRzaSBhbHJlYWR5IHVzZXMgNC1jZWxs
DQo+ID4gPiA+ID4gaW50ZXJydXB0cy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdoYXQgaXMgbW90
aXZhdGluZyB0aGlzIHBhdGNoc2V0PyAgSXMgdGhlcmUgc29tZXRoaW5nIHdyb25nIGluDQo+ID4g
PiA+ID4gdGhlIGV4aXN0aW5nIGR0cyBmaWxlcz8NCj4gPiA+ID4NCj4gPiA+ID4gVGhlcmUgaXMg
bm8gZXJyb3IgaW4gZGV2aWNlIHRyZWUuIE1haW4gbW90aXZhdGlvbiBpcyB0byBpbXByb3ZlDQo+
ID4gPiA+IGNvZGUgZm9yIGZvbGxvd2luZyByZWFzb25zOg0KPiA+ID4gPiAgIC0gV2hpbGUgY29k
ZSBzdHVkeSBpdCB3YXMgZm91bmQgdGhhdCBpZiBhIHJlc2VydmVkIGlycS1udW1iZXINCj4gPiA+
ID4gdXNlZCB0aGVuIHRoZXJlIGFyZSBubyBjaGVjayBpbiBkcml2ZXIuIGlycSB3aWxsIGJlIGNv
bmZpZ3VyZWQgYXMNCj4gPiA+ID4gY29ycmVjdCBhbmQgaW50ZXJydXB0IHdpbGwgbmV2ZXIgZmly
ZS4NCj4gPiA+DQo+ID4gPiBBZ2FpbiwgYSB3cm9uZyBpbnRlcnJ1cHQgbnVtYmVyIHdvbid0IGZp
cmUsIHdoZXRoZXIgYW4gaW50ZXJydXB0IGJ5DQo+ID4gPiB0aGF0IG51bWJlciBleGlzdHMgb3Ig
bm90LiAgSSB3b3VsZG4ndCBtaW5kIGEgc2FuaXR5IGNoZWNrIGluIHRoZQ0KPiA+ID4gZHJpdmVy
IGlmIHRoZSBwcm9ncmFtbWluZyBtb2RlbCBtYWRlIGl0IHByb3Blcmx5IGRpc2NvdmVyYWJsZSwg
YnV0IEkNCj4gPiA+IGRvbid0IHRoaW5rIGl0J3Mgd29ydGggbWVzc2luZyB3aXRoIGRldmljZSB0
cmVlcyBqdXN0IGZvciB0aGlzIChhbmQNCj4gPiA+IGV2ZW4gbGVzcyBzbyBnaXZlbiB0aGF0IHRo
ZXJlIGRvbid0IHNlZW0gdG8gYmUgbmV3IGNoaXBzIGNvbWluZyBvdXQNCj4gPiA+IHRoYXQgdGhp
cyB3b3VsZCBiZSByZWxldmFudCBmb3IpLg0KPiA+DQo+ID4gRmFpciBlbm91Z2gsIHdlIGNhbiB1
c2UgTVBJQyB2ZXJzaW9uIHRvIGRlZmluZSBzdXBwb3J0ZWQgaW50ZXJydXB0cw0KPiByYW5nZXMu
DQo+ID4gV2lsbCB0aGF0IGJlIGFjY2VwdGFibGUuDQo+IA0KPiBJdCdzIGJldHRlciB0aGFuIGRl
dmljZSB0cmVlIGNoYW5nZXMgYnV0IEknbSBub3QgY29udmluY2VkIGl0J3Mgd29ydGh3aGlsZSBq
dXN0DQo+IHRvIHN1cHByZXNzIHNvbWUgc2ltdWxhdG9yIHdhcm5pbmdzLg0KPiAgSWYgdGhlIHdh
cm5pbmdzIHJlYWxseSBib3RoZXIgeW91LCB5b3UNCj4gY2FuIHVzZSBwaWMtbm8tcmVzZXQgaW4g
dGhlIGRldmljZSB0cmVlIChhc3N1bWluZyB0aGlzIGlzbid0IHNvbWUgbmV3IGNoaXANCj4gdGhh
dCB5b3Ugd2FudCB0byBtYWtlIHN1cmUgZG9lc24ndCBmYWxsIG92ZXIgd2hlbiB0aGUgdXN1YWwg
bXBpYyBpbml0DQo+IGhhcHBlbnMpIGFuZC9vciBjb252aW5jZSB0aGUgaGFyZHdhcmUgcGVvcGxl
IHRvIG1ha2UgdGhlIGludGVyZmFjZQ0KPiBwcm9wZXJseSBkaXNjb3ZlcmFibGUgaW5jbHVkaW5n
IGRpc2NvbnRpZ3VvdXMgcmVnaW9ucyAoaWYgdGhlcmUgKmlzKiBzb21lDQo+IG5ldyBjaGlwIEkg
aGF2ZW4ndCBoZWFyZCBhYm91dCkuDQoNClRoZXJlIGlzIG5ldyBjaGlwIHVuZGVyIGRldmVsb3Bt
ZW50IGJhc2VkIG9uIGUyMDAsIHdoaWNoIHVzZXMgc2FtZSBtcGljIGFzIGluIG9sZGVyIFBvd2Vy
UEMgdmVyc2lvbnMuDQpUaGlzIHBhdGNoIHdhcyBub3QganVzdCBhYm91dCBzdXBwcmVzc2luZyB0
aGUgd2FybmluZyBidXQgd2FybmluZyB3YXMgdGhlIG9ic2VydmF0aW9uIHRoYXQgcmVzZXJ2ZWQg
cmVnaW9uIGlzIGdldHRpbmcgYWNjZXNzZWQgZHVyaW5nIGluaXQvdW5pbml0L3NhdmUvcmVzdG9y
ZS4gVGhpcyBwYXRjaCB3YXMganVzdCBhbiBtaW5vciBpbXByb3ZlbWVudCB0byBhdm9pZCB0aGVz
ZSBhY2Nlc3Nlcy4gV2Ugd2lsbCBkcm9wIHRoaXMgc2VyaWVzIGlmIHRoaXMgaW1wcm92ZW1lbnQg
aXMgbm90IGNvbnZpbmNpbmcuDQoNClRoYW5rcw0KLUJoYXJhdA0KDQo+IA0KPiAtU2NvdHQNCg0K
