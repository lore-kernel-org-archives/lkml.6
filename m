Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED6DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237C5253DC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 02:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rgT72zRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237C5253DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeFYCuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 22:50:08 -0400
Received: from mail-db5eur01on0057.outbound.protection.outlook.com ([104.47.2.57]:31603
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752471AbeFYCuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 22:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vLAY6abl+sHe0jdSJ1xB+KMfp6Q6fT1NXk/jXMjcpw=;
 b=rgT72zROL0ZGXbY3RefKNecEnyIwuGMd0x5RYXXsvtg91dprdO8yJ4vfnxPC9q6ThwZzcPELDz9+P0bRA59RwDDFxxmySt7E1Oyr1KsaqsBE5Fq08+r0QSC+qrWSlz5PrL+WfFiZIbi46crfgUIvjfKJSkU+iBfWX+qtPNcmago=
Received: from AM4PR0401MB2260.eurprd04.prod.outlook.com (10.165.45.7) by
 AM4PR0401MB1699.eurprd04.prod.outlook.com (10.165.244.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Mon, 25 Jun 2018 02:50:01 +0000
Received: from AM4PR0401MB2260.eurprd04.prod.outlook.com
 ([fe80::15c0:692d:9a1:e2df]) by AM4PR0401MB2260.eurprd04.prod.outlook.com
 ([fe80::15c0:692d:9a1:e2df%7]) with mapi id 15.20.0884.024; Mon, 25 Jun 2018
 02:50:01 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     "A.s. Dong" <aisheng.dong@nxp.com>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Li <frank.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RFC] Configure i.MX6 RGMII pad group control registers from
 device tree
Thread-Topic: [RFC] Configure i.MX6 RGMII pad group control registers from
 device tree
Thread-Index: AQHUAl9pYBbZ62f8UEeJ1a4UTLMPsaRu3l7QgAF6dyA=
Date:   Mon, 25 Jun 2018 02:50:01 +0000
Message-ID: <AM4PR0401MB2260FB90A3B243A60D027F46FF4A0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <f5a01de5-fc81-52c1-c2ea-edb77ecff076@ysoft.com>
 <5ab5c58a-dc44-d1bc-2132-8704d05bf1de@ysoft.com>
 <AM0PR04MB42111E25172F6068F937ECCB804B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42111E25172F6068F937ECCB804B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB1699;7:hF7nnunB+E2lRyqdsc4jO5+4NliL2no0pelgLmAG0FmaeP0HDMSjBrxELST8EBD2p9GNmj2kEPXLKsJw03gaHnCek9+YLsxOO1TReIze8l5dau1ynoUS3s9UaHjojlm7Fhd3jp7k+O4x+lhGqSFv48FEToYxk+gBoBOIp7P82V+Q80e0o2CCJd+psKpB6jp12AI1TZ8QL4Nlhd8LP/n/K5nYu7+jnqQKIGlvWTwIfHE/E8scMcAlQqkw/m92uSwr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 04fa720f-3e6c-47aa-aec7-08d5da4658ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB1699;
x-ms-traffictypediagnostic: AM4PR0401MB1699:
x-microsoft-antispam-prvs: <AM4PR0401MB1699FBCFF853F530C0709B7DFF4A0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM4PR0401MB1699;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB1699;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39380400002)(39860400002)(346002)(396003)(376002)(366004)(13464003)(51874003)(189003)(199004)(39060400002)(3280700002)(6346003)(6246003)(6436002)(53546011)(105586002)(6506007)(25786009)(4326008)(86362001)(966005)(3660700001)(229853002)(45080400002)(97736004)(59450400001)(478600001)(2906002)(53936002)(76176011)(74316002)(99286004)(2501003)(5660300001)(305945005)(5250100002)(33656002)(6116002)(3846002)(7736002)(26005)(102836004)(11346002)(66066001)(7416002)(446003)(7696005)(68736007)(8676002)(2900100001)(316002)(6306002)(14454004)(9686003)(8936002)(486006)(106356001)(81156014)(476003)(55016002)(81166006)(110136005)(54906003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB1699;H:AM4PR0401MB2260.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-microsoft-antispam-message-info: QBrDATz/+oP+t42FRJJUsioJS4zfpnj3KNmOjBf41ZTaw4EP3u9Vd+NVCG5INb6tZkF7WT3tfS/P1waXMvSQ5ASjFutHTDDfS48X4sXxlBjuG6yiHBd/ZXYvYZUiJ220rV7fLQfj07acAp951LYk5O3PvSZ1J763MLxc1fYBi+viYoI33otNZxh8SPPxVDV33Tx+jJwSnccht1tyo6Z2JlxqzpK0EDEiW5ewpS6SlsB5eXjZU+D1hWHcM9busMy3V7sFG3IWJZWIiKKPvRFy/Z9ICJWenCLq4AYKr+O1vVAucTk/NwZf3zX5aVHXVAQInxrnuwV3X3NADMa8Nadii0eONI+6SwRBAHQlX7CtN88=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fa720f-3e6c-47aa-aec7-08d5da4658ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 02:50:01.7339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB1699
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQS5zLiBEb25nIFNlbnQ6IDIwMTjlubQ25pyIMjTml6UgMTI6MjQNCj4gQ29weSBBbmR5
ICYgRnJhbmssDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTog
TWljaGFsIFZva8OhxI0gW21haWx0bzptaWNoYWwudm9rYWNAeXNvZnQuY29tXQ0KPiA+IFNlbnQ6
IFR1ZXNkYXksIEp1bmUgMTIsIDIwMTggMTE6MTAgUE0NCj4gPiBUbzogbGludXgtZ3Bpb0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4gPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBTaGF3biBHdW8NCj4gPiA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlciA8a2Vy
bmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gRmFiaW8NCj4gPiBFc3RldmFtIDxmYWJpby5lc3RldmFt
QG54cC5jb20+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPjsNCj4gPiBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsgQS5zLiBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47
DQo+IEZhYmlvDQo+ID4gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgU2hhd24gR3VvIDxz
aGF3bmd1b0BrZXJuZWwub3JnPjsNCj4gU3RlZmFuDQo+ID4gQWduZXIgPHN0ZWZhbkBhZ25lci5j
aD47IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtDQo+ID4gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47
IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz47DQo+ID4gbGludXgtIGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBSZTogW1JGQ10gQ29uZmlndXJlIGku
TVg2IFJHTUlJIHBhZCBncm91cCBjb250cm9sIHJlZ2lzdGVycw0KPiA+IGZyb20gZGV2aWNlIHRy
ZWUNCj4gPg0KPiA+IE9uIDExLjYuMjAxOCAxNDozNiwgTWljaGFsIFZva8OhxI0gd3JvdGU6DQo+
ID4gPiBBaG9qLA0KPiA+ID4NCj4gPiA+IFRvIGNvbmZpZ3VyZSBpbmRpdmlkdWFsIHBhZCdzIGNo
YXJhY3RlcmlzdGljcyBvbiBpLk1YNiBTb0MgYQ0KPiA+ID4gZnNsLHBpbnMgPSA8UElOX0ZVTkNf
SUQgQ09ORklHPiBwcm9wZXJ0eSBjYW4gYmUgdXNlZC4gSXMgdGhlcmUgYW55DQo+ID4gPiBjb252
ZW5pZW50IHdheSB0byBjb25maWd1cmUgdGhlIHBhZCBncm91cCBjb250cm9sIHJlZ2lzdGVycz8N
Cj4gPiA+DQo+ID4gPiBUaGUgaXNzdWUgaXMgdGhhdCBzb21lIGJpdHMgKEREUl9TRUwgYW5kIE9E
VCkgaW4gdGhlIGluZGl2aWR1YWwNCj4gPiA+IFJHTUlJIHBhZCBjb250cm9sIHJlZ2lzdGVycyBh
cmUgcmVhZC1vbmx5LiBUbyB0d2VhayB0aG9zZSBwYXJhbWV0ZXJzDQo+ID4gPiAoc2lnbmFsIHZv
bHRhZ2UgYW5kIHRlcm1pbmF0aW9uIHJlc2lzdG9ycykgb25lIG5lZWQgdG8gd3JpdGUgdG8gdGhl
DQo+ID4gPiBwYWQgZ3JvdXAgY29udHJvbCByZWdpc3RlcnMgZm9yIHRoZSB3aG9sZSBSR01JSSBw
YWQgZ3JvdXAuIE5hbWVseQ0KPiA+ID4gSU9NVVhDX1NXX1BBRF9DVExfR1JQX0REUl9UWVBFX1JH
TUlJIGFuZA0KPiA+ID4gSU9NVVhDX1NXX1BBRF9DVExfR1JQX1JHTUlJX1RFUk0uIFRoZSBncm91
cCByZWdpc3RlcnMgaW4NCj4gZ2VuZXJhbA0KPiA+IGFyZSBub3QgYWNjZXNzaWJsZSBmcm9tIHRo
ZSBsaXN0IGluIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZkbC1waW5mdW5jLmguDQo+ID4gPg0KPiA+
ID4gSSBjb3VsZCBub3QgZmluZCBhbnkgb3RoZXIgd2F5IHRvIGNoYW5nZSB0aGUgZ3JvdXAgcmVn
aXN0ZXJzIHRoYW4NCj4gPiA+IGhhY2tpbmctaW4gc29tZSBsaW5lcyBpbnRvIHRoZSBpbXg2cV9p
bml0X21hY2hpbmUodm9pZCkgZnVuY3Rpb24gaW4NCj4gPiA+IGFyY2gvYXJtL21hY2gtaW14L21h
Y2gtaW14NnEuYyBzb3VyY2UuIEFzIEkgd29yayB0b3dhcmRzDQo+IHVwc3RyZWFtaW5nDQo+ID4g
PiBteSBib2FyZCB0aGlzIHNob3VsZCBiZSBkb25lIGZyb20gbXkgZGV2aWNlIHRyZWUgb3Igc29s
dmVkIGluIHNvbWUNCj4gPiB1bml2ZXJzYWwgd2F5Lg0KPiA+ID4NCj4gPiA+IEFueSBoaW50cyB3
aWxsIGJlIG11Y2ggYXBwcmVjaWF0ZWQuDQo+ID4gPiBNaWNoYWwNCj4gPg0KPiA+IEkgZmlndXJl
ZCBvdXQgdGhpcyBpcyBtb3JlICJwaW5jdHJsLWlteC5jIiB0aGFuICJkZXZpY2UtdHJlZSIgcmVs
YXRlZA0KPiA+IHNvIEkgYW0ga2luZGx5IGFkZGluZyBtYWludGFpbmVycyBvZiB0aGF0IGZpbGUg
aW4gaG9wZSBzb21lYm9keSB3aWxsDQo+ID4gc2hlZCBzb21lIGxpZ2h0IHRvIGl0Lg0KPiA+DQo+
ID4gSSBhbSBkaXZpbmcgZGVlcGVyIGludG8gdGhlIGNvZGUgYW5kIGl0IHNlZW1zIHRoZXJlIHJl
YWxseSBpcyBubw0KPiA+IGdlbmVyaWMgb3B0aW9uIHRvIHNldCB0aGUgaS5NWDYgcGFkIGdyb3Vw
IGNvbnRyb2wgcmVnaXN0ZXJzIGZyb20gZGV2aWNlDQo+IHRyZWUuDQo+ID4gT3IgYW0gSSBsb29r
aW5nIGF0IHRoZSBwcm9ibGVtIGZyb20gYSB3cm9uZyBhbmdsZT8NCj4gPg0KPiANCj4gWWVzLCB0
aGVyZSdzIGEgZmV3IHNwZWNpYWwgcGFkIGdyb3VwIGN0cmwgcmVnaXN0ZXJzIChlLmcuIERSQU0g
YW5kIFJHTUlJDQo+IGZvciBteDZxKSB3aGljaCBhcmUgbm90IGFkZGVkIEluIHRoZSBwaW5jdHJs
IGRyaXZlciBzdXBwb3J0Lg0KPiANCj4gPiBIb3cgc2hvdWxkIHdlIGRlYWwgd2l0aCBib2FyZHMg
dGhhdCBuZWVkIHRvIGNvbmZpZ3VyZSBzb21lIHBhZA0KPiA+IGNoYXJhY3RlcmlzdGljcyBhdmFp
bGFibGUgb25seSB0aHJvdWdoIHRoZSBwYWQgZ3JvdXAgY29udHJvbCByZWdpc3RlcnM/DQo+ID4N
Cj4gDQo+IEFuZHksDQo+IEhvdyBkbyB3ZSBoYW5kbGUgaXQgaW50ZXJuYWxseT8NCk5vLCB3ZSBk
b24ndCBoYW5kbGUgdGhlIHBpbi4NCkkgcmVtZW1iZXJlZCBJQyBvd25lciBzYWlkIEl0IHNlZW1z
IG9ubHkgUkdNSUkgMi41diBuZWVkIHRvIGhhbmRsZSB0aGUgcGluLg0KDQo+IA0KPiA+IEkgYWxz
byByYWlzZWQgdGhpcyBxdWVzdGlvbiBhdCB0aGUgTlhQIGNvbW11bml0eSBmb3J1bSBbMV0gYW5k
IGdldA0KPiA+IHF1aXRlIHVuc2F0aXNmeWluZyBhbnN3ZXIgc28gZmFyLiBJIHdvdWxkIGxvdmUg
dG8gZmluZC9pbXBsZW1lbnQgYQ0KPiA+IHByb3BlciBhbmQgdW5pdmVyc2FsIHNvbHV0aW9uLg0K
PiA+DQo+IA0KPiBUaGVyZSdyZSBwcm9iYWJseSB0d28gd2F5cyB0byBkbyBpdDoNCj4gMSkgaGFu
ZGxlIGl0IGluIGZlYyBkcml2ZXIgYnkgcGFyc2luZyBhIHNwZWNpZmljIHByb3BlcnR5DQo+IDIp
IEFkZCBhIG5ldyBwYWQgZ3JvdXAgaW50byBwaW5jdHJsIGRyaXZlciBzdXBwb3J0IGUuZy4NCj4g
TVg2UV9QQURfQ1RMX0dSUF9SR01JSV9URVJNDQo+IE1YNlFfUEFEX0NUTF9HUlBfRERSX1RZUEVf
UkdNSUkNCj4gDQo+IEkgbWF5IHByZWZlciB0byAyKS4NCj4gDQo+IFJlZ2FyZHMNCj4gRG9uZyBB
aXNoZW5nDQo+IA0KPiA+IFRoYW5rcyBpbiBhZHZhbmNlIGZvciB5b3VyIHRpbWUsDQo+ID4gTWlj
aGFsDQo+ID4NCj4gPiBbMV0NCj4gPg0KPiBodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGYw0KPiBvDQo+ID4NCj4gbW11bml0
eS5ueHAuY29tJTJGdGhyZWFkJTJGNDc3NDY0JmRhdGE9MDIlN0MwMSU3Q2Fpc2hlbmcuZG9uZw0K
PiAlNA0KPiA+DQo+IDBueHAuY29tJTdDYTNlNTQ2M2ViMDZhNDdmMTEyMTAwOGQ1ZDA3NjhhMDQl
N0M2ODZlYTFkM2JjMmINCj4gNGM2ZmE5DQo+ID4NCj4gMmNkOTljNWMzMDE2MzUlN0MwJTdDMSU3
QzYzNjY0NDEyOTkxNDE2MjQ5NSZzZGF0YT14cXRCUzh1WA0KPiAlMkJTenENCj4gPiA1bTZ0Yk5h
THpDa0I3ZXpnSFNueXU5R1EzSzEzY1c4JTNEJnJlc2VydmVkPTANCg==
