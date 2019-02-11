Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A0CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98705206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OXYaJIio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfBKGry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:47:54 -0500
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:2147
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfBKGrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DD0blyUHkroQo9xDPrqr+/Sieg/eSyfE7kFZcdsOmM=;
 b=OXYaJIioV9i11Y4O8w7Pfio0PPHyAx+zKc/NPyvvJJYcLDKWuuS4WKzl+Bd5YovAV/K2oxeLt0TWH8GtZleIp4LY+tPYS6Ew1EqlNEliFfHY7qJQOVJf2yBNH1R1UHiSHZvmeDy3lMxyvlHq5jwuy80RFP6WGHFz2158V4vEy40=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB3085.eurprd04.prod.outlook.com (10.170.228.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Mon, 11 Feb 2019 06:47:49 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84%4]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 06:47:49 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Andy Tang <andy.tang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [v5 2/2] arm64: dts: lx2160a: add sata node support
Thread-Topic: [v5 2/2] arm64: dts: lx2160a: add sata node support
Thread-Index: AQHUtIYwnQmxzXZ3L0eB1kWs+99RWKXKhh8AgA96GpCAAC8CAIAAESYg
Date:   Mon, 11 Feb 2019 06:47:48 +0000
Message-ID: <VI1PR04MB4431F6A555EB53418D03DCCFED640@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190125081013.21663-1-peng.ma@nxp.com>
 <20190125081013.21663-2-peng.ma@nxp.com> <20190201063011.GL19882@dragon>
 <VI1PR04MB44313B08539AA7081DC53BAFED640@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20190211053920.GM22487@dragon>
In-Reply-To: <20190211053920.GM22487@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3085;6:IHmsm2rHvdm7VhSjHuJdKVfpmGv2y8zq7q7EVsjiMdjlCa1Sgo5BN22TyuwKD8s/RehNiPQ7+/mxqm3jQtPdUPhdac8Tb9Y64vLLzT+cCswVS/LnNVAIMAcmJM3N4xuzWW161+xTkXOFdQn3Sowh2h2ztjiYUm3f9kozeM2GDtwUcdTh5HeDTogsXZQuvvvtlveEGjSpbQIfXJuEBqKQ21WPYWGlva0iDoLD7FvINK8Sd7VvlprPR546TNStGiSJzMDL/0vdnSVl/RlyOZ5m0fzyNZfJD9rr/7umPtwsTN1+dJkq3q2c6jC+a3pbyV1dZzlLzw5QKCYS8RLz26IdjDS8lGkOGYP4gr3Y8GapO7Kbet4IOQ3GPRtjSRCiov0m8LlK/XPUJp+9Kn/mlQ5fU+IqONDXJeZz3L4KwBLL5px34SMIp4Bcx01jV4Q6z0RnV+JOaZCpM/zziESni3dUTg==;5:MnzV5V1XhUdU3uYLd2gx1qXI3Dm/adf74duBaIWB2DXnD+OwSa/R2BbdNZFoIJ+kyJBseEhfC2FZhdzVnntNWlulOIE10c1j31Pbnyt4lYaDp7i/2ShbejlqouKmS8D39lwqe2tzLCuwxwRAdcNrQPn/nsf884a6wFkdCy+KOuBWvORr/qunVSC3vnKhq8dzmeAFKWsLtBQFkbDinm02Xw==;7:MTR8/NkA+5mr+HQyn6kHrFbFV7hwt53Txr/8VxGU9TOValUPqxyXL0GFuSx4WykFCaZwZBa5yQ79mtdS4mhI3DpFmJiZe43pYOA3tbycFt/nfF/onYW28X+ML0QRVs38aso0/l1Ve4mODnRJpO51tQ==
x-ms-office365-filtering-correlation-id: 69ced8e7-6f48-40ab-c504-08d68fecd66e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3085;
x-ms-traffictypediagnostic: VI1PR04MB3085:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB3085F7163C6134E7F8EAA85EED640@VI1PR04MB3085.eurprd04.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39860400002)(13464003)(199004)(189003)(76176011)(97736004)(99286004)(186003)(71190400001)(71200400001)(26005)(102836004)(68736007)(446003)(11346002)(476003)(74316002)(2906002)(7696005)(486006)(316002)(54906003)(53936002)(6246003)(66066001)(86362001)(305945005)(44832011)(7736002)(6116002)(6306002)(6436002)(55016002)(3846002)(14454004)(9686003)(81156014)(8676002)(81166006)(25786009)(4326008)(6916009)(229853002)(105586002)(6506007)(14444005)(478600001)(33656002)(256004)(45080400002)(966005)(106356001)(93886005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3085;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /enMOyNDMd4cXzCRj+B1BchMFZqxulvWawPiOi9O0ZdmvQeLqRmCTSSvLxwIe7lnXONiK1yme1nCxBKib4SuDlrrSL+TW8vdD6YLgs8gNO5a00hZtb3dAosk9CgUm3lU4/TNUYN+8b4d4AQDx6WegoAS9S49kMq+E5YXFJIDcnBPaotuozqyO/AVD9thjyQJVnGUXzVnUK7xlbgN4WCTYi5uOh/GU5lPZ9c7CiyVVyqVSCVEFUKxgI57EfG8Lqrh6KIasPHnuLqCDd99JdB0coX08jJKmNI0wnst05CDtOdVET48uvg7nl7E6NwSzKxkLPaeP0wBKoaKkvKvyKrbrFEY3Ap4luTaY2Vdo3iZAlOv6OzstwkdD2mDbqhy4LZx2BFAr7xHfGq9vt5kB57FTpoQgx0Awlq69j+vqXwdZAU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ced8e7-6f48-40ab-c504-08d68fecd66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 06:47:49.0500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNoYXduIEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz4NCj5TZW50OiAyMDE55bm0MuaciDEx5pelIDEzOjM5DQo+VG86IFBlbmcg
TWEgPHBlbmcubWFAbnhwLmNvbT4NCj5DYzogYXhib2VAa2VybmVsLmRrOyBtYXJrLnJ1dGxhbmRA
YXJtLmNvbTsgQW5keSBUYW5nDQo+PGFuZHkudGFuZ0BueHAuY29tPjsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGVvIExpIDxsZW95
YW5nLmxpQG54cC5jb20+Ow0KPmxpbnV4LWlkZUB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2Vy
bmVsLm9yZzsNCj5saW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj5TdWJqZWN0
OiBSZTogW3Y1IDIvMl0gYXJtNjQ6IGR0czogbHgyMTYwYTogYWRkIHNhdGEgbm9kZSBzdXBwb3J0
DQo+DQo+T24gTW9uLCBGZWIgMTEsIDIwMTkgYXQgMDI6NTM6MThBTSArMDAwMCwgUGVuZyBNYSB3
cm90ZToNCj4+DQo+Pg0KPj4gPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiA+RnJvbTog
U2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPj4gPlNlbnQ6IDIwMTnlubQy5pyIMeaX
pSAxNDozMA0KPj4gPlRvOiBQZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+PiA+Q2M6IGF4Ym9l
QGtlcm5lbC5kazsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgTGVv
IExpDQo+PiA+PGxlb3lhbmcubGlAbnhwLmNvbT47IGxpbnV4LWlkZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+PiA+ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+PiA+bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBBbmR5IFRh
bmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPj4gPlN1YmplY3Q6IFJlOiBbdjUgMi8yXSBhcm02NDog
ZHRzOiBseDIxNjBhOiBhZGQgc2F0YSBub2RlIHN1cHBvcnQNCj4+ID4NCj4+ID5PbiBGcmksIEph
biAyNSwgMjAxOSBhdCAwODoxMDoxM0FNICswMDAwLCBQZW5nIE1hIHdyb3RlOg0KPj4gPj4gQWRk
IFNBVEEgZGV2aWNlIG5vZGVzIGZvciBmc2wtbHgyMTYwYSBhbmQgZW5hYmxlIHN1cHBvcnQgZm9y
IFFEUw0KPj4gPj4gYW5kIFJEQiBib2FyZHMuDQo+PiA+Pg0KPj4gPj4gU2lnbmVkLW9mZi1ieTog
UGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPj4gPj4gLS0tDQo+PiA+PiBjaGFuZ2VkIGZvciBW
NToNCj4+ID4+IAktIG5vIGNoYW5nZQ0KPj4gPj4NCj4+ID4+ICBhcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRzIHwgICAxNiArKysrKysrDQo+PiA+PiAgYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtcmRiLmR0cyB8ICAgMTYgKysr
KysrKw0KPj4gPj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0
c2kgICAgfCAgIDQ0DQo+PiA+KysrKysrKysrKysrKysrKysrKysrDQo+PiA+PiAgMyBmaWxlcyBj
aGFuZ2VkLCA3NiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KPj4gPj4NCj4+ID4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMu
ZHRzDQo+PiA+PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXFk
cy5kdHMNCj4+ID4+IGluZGV4IDk5YTIyYWIuLjFhNWFjZjYgMTAwNjQ0DQo+PiA+PiAtLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRzDQo+PiA+PiAr
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1xZHMuZHRzDQo+
PiA+PiBAQCAtOTUsNiArOTUsMjIgQEANCj4+ID4+ICAJfTsNCj4+ID4+ICB9Ow0KPj4gPj4NCj4+
ID4+ICsmc2F0YTAgew0KPj4gPj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiA+PiArfTsNCj4+ID4+
ICsNCj4+ID4+ICsmc2F0YTEgew0KPj4gPj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiA+PiArfTsN
Cj4+ID4+ICsNCj4+ID4+ICsmc2F0YTIgew0KPj4gPj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiA+
PiArfTsNCj4+ID4+ICsNCj4+ID4+ICsmc2F0YTMgew0KPj4gPj4gKwlzdGF0dXMgPSAib2theSI7
DQo+PiA+PiArfTsNCj4+ID4+ICsNCj4+ID4+ICAmdWFydDAgew0KPj4gPj4gIAlzdGF0dXMgPSAi
b2theSI7DQo+PiA+PiAgfTsNCj4+ID4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzDQo+PiA+PiBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMNCj4+ID4+IGluZGV4IDY0ODFlNWYuLjVi
Njc5OWUgMTAwNjQ0DQo+PiA+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9m
c2wtbHgyMTYwYS1yZGIuZHRzDQo+PiA+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzDQo+PiA+PiBAQCAtMTAyLDYgKzEwMiwyMiBAQA0KPj4g
Pj4gIAl9Ow0KPj4gPj4gIH07DQo+PiA+Pg0KPj4gPj4gKyZzYXRhMCB7DQo+PiA+PiArCXN0YXR1
cyA9ICJva2F5IjsNCj4+ID4+ICt9Ow0KPj4gPj4gKw0KPj4gPj4gKyZzYXRhMSB7DQo+PiA+PiAr
CXN0YXR1cyA9ICJva2F5IjsNCj4+ID4+ICt9Ow0KPj4gPj4gKw0KPj4gPj4gKyZzYXRhMiB7DQo+
PiA+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+ID4+ICt9Ow0KPj4gPj4gKw0KPj4gPj4gKyZzYXRh
MyB7DQo+PiA+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+ID4+ICt9Ow0KPj4gPj4gKw0KPj4gPj4g
ICZ1YXJ0MCB7DQo+PiA+PiAgCXN0YXR1cyA9ICJva2F5IjsNCj4+ID4+ICB9Ow0KPj4gPj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kN
Cj4+ID4+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaQ0K
Pj4gPj4gaW5kZXggYTc5ZjVjMS4uNTkyMDM0YiAxMDA2NDQNCj4+ID4+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kNCj4+ID4+ICsrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kNCj4+ID4+IEBAIC02NzEs
NiArNjcxLDUwIEBADQo+PiA+PiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+ID4+ICAJCX07
DQo+PiA+Pg0KPj4gPj4gKwkJc2F0YTA6IHNhdGFAMzIwMDAwMCB7DQo+PiA+PiArCQkJY29tcGF0
aWJsZSA9ICJmc2wsbHgyMTYwYS1haGNpIjsNCj4+ID4NCj4+ID5IYXMgdGhlIGtlcm5lbCBkcml2
ZXIgYmVlbiBwYXRjaGVkIHRvIHByb2JlIHRoZSBjb21wYXRpYmxlPw0KPj4gPg0KPj4gPlNoYXdu
DQo+PiBZZXMsIHRoZSBkcml2ZXIgcGF0Y2ggaXMNCj4+IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnBhdGMNCj4+DQo+aHdv
cmsub3psYWJzLm9yZyUyRnBhdGNoJTJGMTAzNDA4MyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDcGVu
Zy5tYQ0KPiU0MG54cA0KPj4gLmNvbSU3QzhkYWVhNGU0YjJlYTQxOWNiMmEwMDhkNjhmZTM0ZjUx
JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmMNCj5kOTljNWMzMA0KPj4NCj4xNjM1JTdDMCU3QzAlN0M2
MzY4NTQ2MDM3OTQxNzA1NzYmYW1wO3NkYXRhPXozaWM4JTJGQVMxME5jRmpkUA0KPmVKRnBuRm9v
DQo+PiBSMllvNG9ZTyUyRkFBU3I3cjJMaGclM0QmYW1wO3Jlc2VydmVkPTANCj4NCj5QaW5nIG1l
IHdoZW4gdGhlIGRyaXZlciBwYXRjaCBpcyBhY2NlcHRlZC4gIElkZWFsbHksIHdlIG9ubHkgYWNj
ZXB0IGR0cw0KPmNoYW5nZXMgYWZ0ZXIgdGhlIGRyaXZlciBjb3VudGVycGFydCBsYW5kcyBvbiBt
YWlubGluZS4NCj4NCj5TaGF3bg0KW1BlbmcgTWFdIGdvdCBpdCwgdGhhbmtzLg0KQlINClBlbmcN
Cg==
