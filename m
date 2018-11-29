Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78485C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297E920863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A0utYxMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297E920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbeK3Dgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:36:55 -0500
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:9619
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729301AbeK3Dgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNVjtbwSprJJMShtGI305Ing0V+VQZIytPZbarpXj58=;
 b=A0utYxMKKM777sE3UCQQ3d7N6er/RFRxCGay7pGcXd1xUwLZSQ/LA9xQc7toSCrewUnO5mkyjLBoo4npWm26vTGgZ/aO28F6GT0etGI3JxGHRkzwGe59fshGzBm+/A2U4cpY8OpRg41Ajzs3Kj8WNnYhMzAFXcf5FZVaAcsxTzg=
Received: from AM6PR04MB4967.eurprd04.prod.outlook.com (20.177.33.210) by
 AM6PR04MB4981.eurprd04.prod.outlook.com (20.177.33.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 29 Nov 2018 16:30:55 +0000
Received: from AM6PR04MB4967.eurprd04.prod.outlook.com
 ([fe80::4854:a2d2:fe05:b07e]) by AM6PR04MB4967.eurprd04.prod.outlook.com
 ([fe80::4854:a2d2:fe05:b07e%3]) with mapi id 15.20.1294.048; Thu, 29 Nov 2018
 16:30:55 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH v6 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHUhjth64LQhF053kOn/lJhR11U0aVk3CAAgAHHZYCAAARRAIAATMCg
Date:   Thu, 29 Nov 2018 16:30:55 +0000
Message-ID: <AM6PR04MB496732760F72A0B5B5F4A5A997D20@AM6PR04MB4967.eurprd04.prod.outlook.com>
References: <1543314174-28580-1-git-send-email-frieder.schrempf@kontron.de>
 <1543314174-28580-4-git-send-email-frieder.schrempf@kontron.de>
 <3981845c-327a-bb14-2908-47dd443971bf@kontron.de>
 <VI1PR04MB572644A2AE3214356A62478799D20@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <f4c584e5-8930-bec3-0c4e-2216a89606b0@kontron.de>
In-Reply-To: <f4c584e5-8930-bec3-0c4e-2216a89606b0@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=han.xu@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4981;6:oTqfSJ3PV0w7curdrfaF9dylUPbR7QGn7wDrhCHyLV4Qx1qLv03WCIh9LxmAbMoa6Z+6RJs24EHfKP3oUnyXe+rEmz3ZWtpHIVg6R02Au1QGQSFrMh5xIyuYgCadBY9hiDCivK1c9eUIGXSdtX4h3oznTmKT7j5brk++/2uFziBNox9cYOAb9ZYkJ3pC5nphgZ6SISKeghkfFXFxHi3DLmVHlLZ3tX2mFpf7KCay5I6JkHhaQx1zo8BPZebHtKS0pFyQGgscH7ynC2lJDtAB9RU8rgGUfElUonKT4s011JeqyVUTi6Lzj3WaA2+BbqyJDbyLGS4LP9KMXKtaD+Wp05Qmv7SH+weuQvxQhML1AfECU5TrXkVxEbkT+ae0zMeLOfuUzfr6YwDMsDjHtJarGn+7BWC2g9jcxKhrQ3OLB30XzZ+ttZ2Cg0a7E4JxEeg4wq/HS2khIcpzxWrLm2/jTw==;5:w1ZhT4fRCfiy353Baa7bkWy3RQUu90e9B0cqjJl7RGt9Z/A53wivaYT1SgsgtvYBL1/HEaYP544TmqN8GkV9qWIh/z5HxreGjG74FYqqwT/gn/hQEBIHN8gfBNaagO/+l4YMSynjlN1qL5FliLCnZX7L/quJzM2/T6S7Bk1sWP8=;7:XR4TMrPsh4UcCZB2dgNorarVN9qEKLv9bV3kCMmrmkMjKqd+KMjNm9eRKBFTAOtYESXfBzA2SsdBAzK0/8+D5iAqTWaOG4AC9rXXkKk/eaDS3wWC2SnzCdfCwFAvMNYQD2Xn+1wMrEH/rGxImD/wYA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 39f7bc3e-2733-426e-09fb-08d65618093c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4981;
x-ms-traffictypediagnostic: AM6PR04MB4981:
x-microsoft-antispam-prvs: <AM6PR04MB498129479067148965CC72AA97D20@AM6PR04MB4981.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4981;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4981;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(136003)(13464003)(189003)(199004)(66066001)(7736002)(53936002)(54906003)(110136005)(25786009)(7416002)(97736004)(9686003)(86362001)(2201001)(4326008)(33656002)(55016002)(305945005)(5660300001)(74316002)(6436002)(229853002)(14444005)(256004)(71200400001)(2501003)(316002)(7696005)(6506007)(26005)(6116002)(186003)(99286004)(102836004)(76176011)(53546011)(93886005)(345774005)(68736007)(81166006)(486006)(71190400001)(8936002)(3846002)(14454004)(8676002)(81156014)(478600001)(39060400002)(44832011)(105586002)(2906002)(6246003)(446003)(476003)(11346002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4981;H:AM6PR04MB4967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aRRQQxrVRtouW4WPMg4UpbcdYUbW67uNa5Ss7Va45MoP6qCywRD+zsta70OzbX8gi3S4e3FukPzTLQ5XywwGRZaMkdDvE5fnaB0QV62ToYj26WrlxvYVsGbThDBM6awoDzDEyslPlmasKv8149e+hq/WQZoJge9SXK0sP5hdIHIEJgBvyEIux0Hy7j/Z2r+QJyLwCAB9vskme8Fb5E1CXuD5QeQnZ3sp4nApD3AS797Q889vROFfLk3pQwQ5KaE45gcgNo5y1ERdNUKZ2efu27PZBKW9l/L82fAIZ6Xi3DINlMJzKsk2NaAh8XKCmWih5Dg+172RKdctyTmYi0GOuwUZ6MWw83EJMwx+BFv2ikc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f7bc3e-2733-426e-09fb-08d65618093c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 16:30:55.2196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4981
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NocmVtcGYgRnJpZWRl
ciA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1i
ZXIgMjksIDIwMTggNTo1NCBBTQ0KPiBUbzogWW9nZXNoIE5hcmF5YW4gR2F1ciA8eW9nZXNobmFy
YXlhbi5nYXVyQG54cC5jb20+OyBsaW51eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGJv
cmlzLmJyZXppbGxvbkBib290bGluLmNvbTsgbGludXgtDQo+IHNwaUB2Z2VyLmtlcm5lbC5vcmc7
IE1hcmVrIFZhc3V0IDxtYXJlay52YXN1dEBnbWFpbC5jb20+OyBNYXJrIEJyb3duDQo+IDxicm9v
bmllQGtlcm5lbC5vcmc+OyBIYW4gWHUgPGhhbi54dUBueHAuY29tPg0KPiBDYzogZHdtdzJAaW5m
cmFkZWFkLm9yZzsgY29tcHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tOw0KPiByaWNoYXJkQG5vZC5h
dDsgbWlxdWVsLnJheW5hbEBib290bGluLmNvbTsgRGF2aWQgV29sZmUNCj4gPGRhdmlkLndvbGZl
QG54cC5jb20+OyBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+Ow0KPiBQcmFi
aGFrYXIgS3VzaHdhaGEgPHByYWJoYWthci5rdXNod2FoYUBueHAuY29tPjsNCj4gc2hhd25ndW9A
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY2IDMvOV0gc3BpOiBBZGQgYSBkcml2ZXIgZm9yIHRoZSBGcmVlc2NhbGUvTlhQIFF1
YWRTUEkNCj4gY29udHJvbGxlcg0KPiANCj4gSGkgWW9nZXNoLA0KPiANCj4gT24gMjkuMTEuMTgg
MTI6MzgsIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+ID4gSGkgRnJpZWRlciwNCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBTY2hyZW1wZiBGcmll
ZGVyIFttYWlsdG86ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlXQ0KPiA+PiBTZW50OiBXZWRu
ZXNkYXksIE5vdmVtYmVyIDI4LCAyMDE4IDE6NTggUE0NCj4gPj4gVG86IGxpbnV4LW10ZEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb207DQo+ID4+IGxpbnV4
LSBzcGlAdmdlci5rZXJuZWwub3JnOyBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXRAZ21haWwuY29t
PjsNCj4gTWFyaw0KPiA+PiBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPjsgSGFuIFh1IDxoYW4u
eHVAbnhwLmNvbT4NCj4gPj4gQ2M6IGR3bXcyQGluZnJhZGVhZC5vcmc7IGNvbXB1dGVyc2ZvcnBl
YWNlQGdtYWlsLmNvbTsNCj4gcmljaGFyZEBub2QuYXQ7DQo+ID4+IG1pcXVlbC5yYXluYWxAYm9v
dGxpbi5jb207IERhdmlkIFdvbGZlIDxkYXZpZC53b2xmZUBueHAuY29tPjsgRmFiaW8NCj4gPj4g
RXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgUHJhYmhha2FyIEt1c2h3YWhhDQo+ID4+
IDxwcmFiaGFrYXIua3VzaHdhaGFAbnhwLmNvbT47IFlvZ2VzaCBOYXJheWFuIEdhdXINCj4gPj4g
PHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsgbGludXgt
DQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
NiAzLzldIHNwaTogQWRkIGEgZHJpdmVyIGZvciB0aGUgRnJlZXNjYWxlL05YUA0KPiA+PiBRdWFk
U1BJIGNvbnRyb2xsZXINCj4gPj4NCj4gPj4gT24gMjcuMTEuMTggMTE6MjQsIFNjaHJlbXBmIEZy
aWVkZXIgd3JvdGU6DQo+ID4+PiBUaGlzIGRyaXZlciBpcyBkZXJpdmVkIGZyb20gdGhlIFNQSSBO
T1IgZHJpdmVyIGF0DQo+ID4+PiBtdGQvc3BpLW5vci9mc2wtcXVhZHNwaS5jLiBJdCB1c2VzIHRo
ZSBuZXcgU1BJIG1lbW9yeSBpbnRlcmZhY2Ugb2YNCj4gPj4+IHRoZSBTUEkgZnJhbWV3b3JrIHRv
IGlzc3VlIGZsYXNoIG1lbW9yeSBvcGVyYXRpb25zIHRvIHVwIHRvIGZvdXINCj4gPj4+IGNvbm5l
Y3RlZCBmbGFzaCBjaGlwcyAoMiBidXNlcyB3aXRoIDIgQ1MgZWFjaCkuDQo+ID4+Pg0KPiA+Pj4g
VGhlIGNvbnRyb2xsZXIgZG9lcyBub3Qgc3VwcG9ydCBnZW5lcmljIFNQSSBtZXNzYWdlcy4NCj4g
Pj4+DQo+ID4+PiBUaGlzIHBhdGNoIGFsc28gZGlzYWJsZXMgdGhlIGJ1aWxkIG9mIHRoZSAib2xk
IiBkcml2ZXIgYW5kIHJldXNlcw0KPiA+Pj4gaXRzIEtjb25maWcgb3B0aW9uIENPTkZJR19TUElf
RlNMX1FVQURTUEkgdG8gcmVwbGFjZSBpdC4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBG
cmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+ID4+PiAtLS0N
Cj4gPj4+ICAgIGRyaXZlcnMvbXRkL3NwaS1ub3IvS2NvbmZpZyAgfCAgIDkgLQ0KPiA+Pj4gICAg
ZHJpdmVycy9tdGQvc3BpLW5vci9NYWtlZmlsZSB8ICAgMSAtDQo+ID4+PiAgICBkcml2ZXJzL3Nw
aS9LY29uZmlnICAgICAgICAgIHwgIDExICsNCj4gPj4+ICAgIGRyaXZlcnMvc3BpL01ha2VmaWxl
ICAgICAgICAgfCAgIDEgKw0KPiA+Pj4gICAgZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmMgICB8
IDk2Nw0KPiA+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+Pj4g
ICAgNSBmaWxlcyBjaGFuZ2VkLCA5NzkgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+
ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvS2NvbmZpZw0KPiA+
Pj4gYi9kcml2ZXJzL210ZC9zcGktbm9yL0tjb25maWcgaW5kZXggNmNjOWM5Mi4uZDFjYTMwNyAx
MDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvS2NvbmZpZw0KPiA+Pj4gKysr
IGIvZHJpdmVycy9tdGQvc3BpLW5vci9LY29uZmlnDQo+ID4+PiBAQCAtNTksMTUgKzU5LDYgQEAg
Y29uZmlnIFNQSV9DQURFTkNFX1FVQURTUEkNCj4gPj4+ICAgIAkgIGRldmljZSB3aXRoIGEgQ2Fk
ZW5jZSBRU1BJIGNvbnRyb2xsZXIgYW5kIHdhbnQgdG8gYWNjZXNzIHRoZQ0KPiA+Pj4gICAgCSAg
Rmxhc2ggYXMgYW4gTVREIGRldmljZS4NCj4gPj4+DQo+ID4+PiAtY29uZmlnIFNQSV9GU0xfUVVB
RFNQSQ0KPiA+Pj4gLQl0cmlzdGF0ZSAiRnJlZXNjYWxlIFF1YWQgU1BJIGNvbnRyb2xsZXIiDQo+
ID4+PiAtCWRlcGVuZHMgb24gQVJDSF9NWEMgfHwgU09DX0xTMTAyMUEgfHwgQVJDSF9MQVlFUlND
QVBFIHx8DQo+ID4+IENPTVBJTEVfVEVTVA0KPiA+Pj4gLQlkZXBlbmRzIG9uIEhBU19JT01FTQ0K
PiA+Pj4gLQloZWxwDQo+ID4+PiAtCSAgVGhpcyBlbmFibGVzIHN1cHBvcnQgZm9yIHRoZSBRdWFk
IFNQSSBjb250cm9sbGVyIGluIG1hc3RlciBtb2RlLg0KPiA+Pj4gLQkgIFRoaXMgY29udHJvbGxl
ciBkb2VzIG5vdCBzdXBwb3J0IGdlbmVyaWMgU1BJLiBJdCBvbmx5IHN1cHBvcnRzDQo+ID4+PiAt
CSAgU1BJIE5PUi4NCj4gPj4+IC0NCj4gPj4+ICAgIGNvbmZpZyBTUElfSElTSV9TRkMNCj4gPj4+
ICAgIAl0cmlzdGF0ZSAiSGlzaWxpY29uIFNQSS1OT1IgRmxhc2ggQ29udHJvbGxlcihTRkMpIg0K
PiA+Pj4gICAgCWRlcGVuZHMgb24gQVJDSF9ISVNJIHx8IENPTVBJTEVfVEVTVCBkaWZmIC0tZ2l0
DQo+ID4+PiBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvTWFrZWZpbGUgYi9kcml2ZXJzL210ZC9zcGkt
bm9yL01ha2VmaWxlIGluZGV4DQo+ID4+PiBmNGM2MWQyLi4zZjE2MGMyZTMgMTAwNjQ0DQo+ID4+
PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL01ha2VmaWxlDQo+ID4+PiArKysgYi9kcml2ZXJz
L210ZC9zcGktbm9yL01ha2VmaWxlDQo+ID4+PiBAQCAtMyw3ICszLDYgQEAgb2JqLSQoQ09ORklH
X01URF9TUElfTk9SKQkrPSBzcGktbm9yLm8NCj4gPj4+ICAgIG9iai0kKENPTkZJR19TUElfQVNQ
RUVEX1NNQykJKz0gYXNwZWVkLXNtYy5vDQo+ID4+PiAgICBvYmotJChDT05GSUdfU1BJX0FUTUVM
X1FVQURTUEkpCSs9IGF0bWVsLXF1YWRzcGkubw0KPiA+Pj4gICAgb2JqLSQoQ09ORklHX1NQSV9D
QURFTkNFX1FVQURTUEkpCSs9IGNhZGVuY2UtcXVhZHNwaS5vDQo+ID4+PiAtb2JqLSQoQ09ORklH
X1NQSV9GU0xfUVVBRFNQSSkJKz0gZnNsLXF1YWRzcGkubw0KPiA+Pj4gICAgb2JqLSQoQ09ORklH
X1NQSV9ISVNJX1NGQykJKz0gaGlzaS1zZmMubw0KPiA+Pj4gICAgb2JqLSQoQ09ORklHX01URF9N
VDgxeHhfTk9SKSAgICArPSBtdGstcXVhZHNwaS5vDQo+ID4+PiAgICBvYmotJChDT05GSUdfU1BJ
X05YUF9TUElGSSkJKz0gbnhwLXNwaWZpLm8NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Nw
aS9LY29uZmlnIGIvZHJpdmVycy9zcGkvS2NvbmZpZyBpbmRleA0KPiA+Pj4gN2QzYTVjOS4uOGM4
NDE4NiAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvc3BpL0tjb25maWcNCj4gPj4+ICsrKyBi
L2RyaXZlcnMvc3BpL0tjb25maWcNCj4gPj4+IEBAIC0yNTksNiArMjU5LDE3IEBAIGNvbmZpZyBT
UElfRlNMX0xQU1BJDQo+ID4+PiAgICAJaGVscA0KPiA+Pj4gICAgCSAgVGhpcyBlbmFibGVzIEZy
ZWVzY2FsZSBpLk1YIExQU1BJIGNvbnRyb2xsZXJzIGluIG1hc3RlciBtb2RlLg0KPiA+Pj4NCj4g
Pj4+ICtjb25maWcgU1BJX0ZTTF9RVUFEU1BJDQo+ID4+PiArCXRyaXN0YXRlICJGcmVlc2NhbGUg
UVNQSSBjb250cm9sbGVyIg0KPiA+Pj4gKwlkZXBlbmRzIG9uIEFSQ0hfTVhDIHx8IFNPQ19MUzEw
MjFBIHx8IEFSQ0hfTEFZRVJTQ0FQRSB8fA0KPiA+PiBDT01QSUxFX1RFU1QNCj4gPj4+ICsJZGVw
ZW5kcyBvbiBIQVNfSU9NRU0NCj4gPj4+ICsJaGVscA0KPiA+Pj4gKwkgIFRoaXMgZW5hYmxlcyBz
dXBwb3J0IGZvciB0aGUgUXVhZCBTUEkgY29udHJvbGxlciBpbiBtYXN0ZXIgbW9kZS4NCj4gPj4+
ICsJICBVcCB0byBmb3VyIGZsYXNoIGNoaXBzIGNhbiBiZSBjb25uZWN0ZWQgb24gdHdvIGJ1c2Vz
IHdpdGggdHdvDQo+ID4+PiArCSAgY2hpcHNlbGVjdHMgZWFjaC4NCj4gPj4+ICsJICBUaGlzIGNv
bnRyb2xsZXIgZG9lcyBub3Qgc3VwcG9ydCBnZW5lcmljIFNQSSBtZXNzYWdlcy4gSXQgb25seQ0K
PiA+Pj4gKwkgIHN1cHBvcnRzIHRoZSBoaWdoLWxldmVsIFNQSSBtZW1vcnkgaW50ZXJmYWNlLg0K
PiA+Pj4gKw0KPiA+IFsuLi5dDQo+ID4+PiArc3RhdGljIHZvaWQgZnNsX3FzcGlfc2VsZWN0X21l
bShzdHJ1Y3QgZnNsX3FzcGkgKnEsIHN0cnVjdA0KPiA+Pj4gK3NwaV9kZXZpY2UgKnNwaSkgew0K
PiA+Pj4gKwl1bnNpZ25lZCBsb25nIHJhdGUgPSBzcGktPm1heF9zcGVlZF9oejsNCj4gPj4+ICsJ
aW50IHJldCwgaTsNCj4gPj4+ICsJdTMyIG1hcF9hZGRyOw0KPiA+Pg0KPiA+PiBGb3Jnb3QgdG8g
ZHJvcCBzb21lIHVudXNlZCB2YXJzIGhlcmUuIEkgd2lsbCByZW1vdmUgdGhlbSBpbiB0aGUgbmV4
dA0KPiA+PiB2ZXJzaW9uLg0KPiA+Pg0KPiA+DQo+ID4gWWVzLCBiZWxvdyBhcmUgdGhlIGJ1aWxk
IHdhcm5pbmdzIG1lc3NhZ2VzIGNvbWluZyBmb3IgdGhpcyB2ZXJzaW9uIG9mIHRoZQ0KPiBwYXRj
aC4NCj4gPg0KPiA+IAlkcml2ZXJzL3NwaS9zcGktZnNsLXFzcGkuYzogSW4gZnVuY3Rpb24g4oCY
ZnNsX3FzcGlfc2VsZWN0X21lbeKAmToNCj4gPiAJZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmM6
NTAwOjY6IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSDigJhtYXBfYWRkcuKAmQ0KPiBbLVd1bnVz
ZWQtdmFyaWFibGVdDQo+ID4gCSAgdTMyIG1hcF9hZGRyOw0KPiA+IAkgICAgICBeDQo+ID4gCWRy
aXZlcnMvc3BpL3NwaS1mc2wtcXNwaS5jOjQ5OToxMTogd2FybmluZzogdW51c2VkIHZhcmlhYmxl
IOKAmGnigJkgWy0NCj4gV3VudXNlZC12YXJpYWJsZV0NCj4gPiAJICBpbnQgcmV0LCBpOw0KPiA+
DQo+ID4+PiArDQo+ID4+PiArCWlmIChxLT5zZWxlY3RlZCA9PSBzcGktPmNoaXBfc2VsZWN0KQ0K
PiA+IFsuLi5dDQo+ID4NCj4gPiBWZXJpZmllZCB0aGlzIHBhdGNoIHNlcmllcyBvbiBMYXllclNj
YXBlLTIueCBhcmNoaXRlY3R1cmUgYm9hcmRzLg0KPiA+IExTMTA4OGFyZGIsIGlzIGhhdmluZyB0
d28gY29ubmVjdGVkIGZsYXNoIHNsYXZlIGRldmljZXMgb24gQ1MwIGFuZCBDUzEuDQo+ID4NCj4g
PiBWZXJpZmllZCB3aXRoIHNpbXBsZSBSZWFkL1dyaXRlL0VyYXNlIG9wZXJhdGlvbnMgYWxvbmcg
d2l0aCBKRkZTMg0KPiBtb3VudGluZyBhbmQgYm9vdGluZyBmcm9tIGZsYXNoIE1URCBwYXJ0aXRp
b24gZm9yIGJvdGggc2xhdmUgZGV2aWNlcy4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGVzdGluZyEg
RG9lcyB0aGlzIG1lYW4gSSBjYW4gYWRkIHlvdXIgVGVzdGVkLWJ5IHRhZz8NCj4gSWYgeW91IGhh
dmUgZG9uZSBhIHJldmlldyBvZiBhbnkgb2YgdGhlIHBhdGNoZXMgaW4gdGhpcyBzZXQsIHBsZWFz
ZSBhbHNvIGFkZCBhDQo+IFJldmlld2VkLWJ5IHRhZy4NCg0KSGkgU2NocmVtcGYsIEkgYW0gcmV2
aWV3aW5nIGFuZCB0ZXN0aW5nIG9uIHNvbWUgaS5NWCBwbGF0Zm9ybXMsIHBsZWFzZSBob2xkIG9u
IGZvciBhIHdoaWxlIGZvciB0aGUgcmVzdWx0Lg0KDQo+IA0KPiBUaGFua3MsDQo+IEZyaWVkZXIN
Cg==
