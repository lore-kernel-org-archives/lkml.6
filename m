Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E148EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC10214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DiNdPcUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC10214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbeISQ3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:29:04 -0400
Received: from mail-ve1eur01on0084.outbound.protection.outlook.com ([104.47.1.84]:61312
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbeISQ3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q866RymB7NHdXj1bidMMYs7e8NEmAmLiMSx7e/wx0tc=;
 b=DiNdPcUn6FPsUC6lCkOPPeJJLUjyL/K4nbF0ISDXNQA2LNIO28OLUhVc/lWrng0Xko+PTibKPbTjboRgC8KWrIGt5jGrLRmyyj0tclMYUYNOyJNrFigt6vIeJVrsczvoYqo7RINGTnjFf7msUf2SNozo100DOjvzN3RKsv9PXsI=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1168.eurprd04.prod.outlook.com (10.162.121.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Wed, 19 Sep 2018 10:51:38 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::2098:afc:1023:6534]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::2098:afc:1023:6534%5]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 10:51:38 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUTmvfC0oHQrtTJUq+OAlmHVuv6qT11d2AgAAQJZCAABnugIABUcSw
Date:   Wed, 19 Sep 2018 10:51:38 +0000
Message-ID: <VI1PR04MB103854C46FABEDD88EB2D724991C0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <9a80752f-2db3-bf76-fbf4-e5efaa3974d7@exceet.de>
        <VI1PR04MB1038EDE4B2F5AFC5B0FDE8DF991D0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20180918145201.68adcb8d@bbrezillon>
In-Reply-To: <20180918145201.68adcb8d@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1168;6:zTiXAZYJq/ZvJMjARrGbD/LS6ZyUPGnCD8hgIYSu0MN77saiAs+Gx8X/o3ox2Tw/qDxGEiSvnWQ4vzoMHDTlkfWbOdxnXwI7OFN7IMRUzE58WQuCaiHNEAJ9KFyqjTAJec+dbrq5l8cPqzCHofJ0zlRR22k4DjsXXOQXoQ2w1uz5UfsTpxapLGBcUsmlgF6lw7z80FhnGtevPL2YtTjsIA2GUWM+FyxLlaS1/eVDvqP4jSNzO7mYSlQe2jayBI3jIBJPNXDtF0Npx0477avV7B9xaIhB8fpTjZENjek7InPo6xD0TIvOIybHPX4wWgm4EsBXCod39bvCH+Bnz+f0jJCQg5eu4SyQvhTIdCSvM8kuHGpyS1upZuy0B8Il1DtiNKX7Q9Yt15rF+trSb87faWZWHJxyx8lyLefdSQ5BdbPI8QXAYIJfMTAlbgG3KlrEIhG7tLfI2iw8vMitjsD4/g==;5:xkAM2R1yEOLE40ZRF9PkXjJSq0+iBiz5OROZKMZsAt+gmndfpFI4BNSImeOuKKZXJS/dkV2ZU/LiK3qHe8VwekAjGA63LEZ1sz9BAck+kks72axtlWchC3gL7LdL4QfnYbcziTlY33DCSYeh2kY8o9Ljux1wlqhcRbgFFX0EaZE=;7:2tzfO3jDhXwkoDLrkgWmpSyXMaDgL0MpGRTfRYCy9MySrh8ktmpHEVPNMUWfyE2s9eBCGfB8gpXtD6tFck5dZOdKmzIPOLB09GiqzTwr7sU0543mGKUrbpvZ+xf1XXU5cKEDi8cFrrFO/NFtOC93k4pNF9skw9o7y7o/lNdB1s6Sjpzu6/BsXBG3gQknxC3l5o0vPxpuTCaZDX5ilSB5u7IfexMOx2l7qRcMXHZNg7p0J/N6GAdWy+jFNQIt8Iva
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fff10803-f0fb-4507-fed4-08d61e1de060
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1168;
x-ms-traffictypediagnostic: VI1PR04MB1168:
x-microsoft-antispam-prvs: <VI1PR04MB11681C2392DE842164486B1C991C0@VI1PR04MB1168.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(788757137089)(258649278758335)(21532816269658)(264314650089876);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:VI1PR04MB1168;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1168;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(136003)(376002)(199004)(13464003)(189003)(9686003)(478600001)(55236004)(7696005)(68736007)(8936002)(14454004)(966005)(53546011)(93886005)(76176011)(106356001)(14444005)(99286004)(305945005)(2906002)(86362001)(55016002)(6116002)(6306002)(3846002)(7416002)(105586002)(4326008)(7736002)(74316002)(6246003)(256004)(6506007)(53936002)(54906003)(446003)(102836004)(186003)(316002)(81166006)(81156014)(33656002)(476003)(26005)(39060400002)(6916009)(486006)(25786009)(229853002)(97736004)(5250100002)(8676002)(5660300001)(6436002)(66066001)(561944003)(11346002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1168;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QALBtQYRWX89aNtZ5bNLialzK4eR0GutRPhpdCxUe31KchvsV30kHD9Q6niJxE6zSatEg2FCUDKJcR7vmNSIQBwSdiQKhoAQVnX5uRJBdsij6wYi8VyIPAcTr53NHrsqNUg89aHeQ0kfHGqPaqPXOZtpNqU1pmojrFvlqNDsFtTM5Qbk89gHZwYhYQ4mVMqhdexpxt4cTS56HfVZTagUs8iIsSzfsjiPNvQMsNMDfHOm+q0F5YXlfb9vASSQfVVjYjnxKyhQt1UFJfNB74wgpi015Twl67cyHSy2qZEU+gKJ95YbLR/w84HN+c0tqQN8RSu3thRplm67XVv2uoqdJcmsWxO84kJatLFyqY2bmoE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff10803-f0fb-4507-fed4-08d61e1de060
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 10:51:38.5279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMg
QnJlemlsbG9uIFttYWlsdG86Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tXQ0KPiBTZW50OiBU
dWVzZGF5LCBTZXB0ZW1iZXIgMTgsIDIwMTggNjoyMiBQTQ0KPiBUbzogWW9nZXNoIE5hcmF5YW4g
R2F1ciA8eW9nZXNobmFyYXlhbi5nYXVyQG54cC5jb20+DQo+IENjOiBGcmllZGVyIFNjaHJlbXBm
IDxmcmllZGVyLnNjaHJlbXBmQGV4Y2VldC5kZT47IGxpbnV4LQ0KPiBtdGRAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbWFyZWsudmFzdXRAZ21haWwuY29tOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3Jn
Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBtYXJrLnJ1
dGxhbmRAYXJtLmNvbTsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOw0KPiBjb21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb207IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzVdIHNw
aTogc3BpLW1lbTogQWRkIGRyaXZlciBmb3IgTlhQIEZsZXhTUEkgY29udHJvbGxlcg0KPiANCj4g
SGkgWW9nZXNoLA0KPiANCj4gT24gVHVlLCAxOCBTZXAgMjAxOCAxMTozNDoxOCArMDAwMA0KPiBZ
b2dlc2ggTmFyYXlhbiBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4gd3JvdGU6DQo+
IA0KPiA+ID4NCj4gPiA+IERvIHdlIHJlYWxseSBuZWVkIGFsbCB0aG9zZSBtYWNyb3MgZm9yIHJl
Z2lzdGVycyBhbmQgbW9kZXMsIHRoYXQNCj4gPiA+IGFyZW4ndCBldmVuIHVzZWQgaW4gdGhlIGRy
aXZlcj8gSSBkb24ndCBrbm93IHdoYXQgdGhlIGNvbW1vbg0KPiA+ID4gcHJhY3RpY2UgaXMsIGJ1
dCB0byBtZSBpdCBzZWVtcyBsaWtlIHJlbW92aW5nIGFsbCB0aGUgdW51c2VkIG1hY3Jvcw0KPiA+
ID4gd291bGQgbWFrZSB0aGUgZHJpdmVyIG11Y2ggc21hbGxlciBhbmQgbW9yZSByZWFkYWJsZS4N
Cj4gPiA+DQo+ID4gV2UgZG9uJ3QgbmVlZCBhbGwgTWFjcm9zIGN1cnJlbnRseSwgYnV0IGNhbiBi
ZSBuZWVkZWQgaW4gZnV0dXJlIGFuZA0KPiA+IHRoZW4gaGF2ZSB0byBhZGQgYWdhaW4uIEdlbmVy
YWxseSwgd2UgYWRkIHRoZW0gYWxsIHNvIHRoYXQgaW4gZnV0dXJlDQo+ID4gZG9uJ3QgaGF2ZSB0
byBkaWcgaW4gZGF0YXNoZWV0IHRvIGFkZCBiYXNpYyByZWdpc3RlciBkZXRhaWxzLg0KPiANCj4g
SSBndWVzcyBpdCdzIGp1c3QgYSBtYXR0ZXIgb2YgdGFzdGUsIGJ1dCBJIGFsc28gcHJlZmVyIHdo
ZW4gYWxsIHJlZ3MgYXJlIGRlZmluZWQgZXZlbg0KPiBpZiBub3QgYWxsIG9mIHRoZW0gYXJlIHVz
ZWQuDQo+IA0KT2suDQoNCj4gWy4uLl0NCj4gDQo+ID4gPg0KPiA+ID4gWW91IGFyZSBvbmx5IGNv
bnNpZGVyaW5nIDMgYW5kIDQgYnl0ZSBsb25nIGFkZHJlc3Nlcywgd2hpY2ggaXMgZmluZQ0KPiA+
ID4gZm9yIE5PUiBjaGlwcywgYnV0IHRoZSBTUEkgbWVtIGludGVyZmFjZSBhbGxvd3MgdG8gY29u
bmVjdCBvdGhlcg0KPiA+ID4gY2hpcHMgbGlrZSBTUEkgTkFORCB3aGljaCBhbHNvIHVzZSAxIGJ5
dGUgYWRkcmVzc2VzLg0KPiA+ID4NCj4gPiA+IEluIHRoZSBRU1BJIGRyaXZlciBCb3JpcyB3b3Jr
ZWQgYXJvdW5kIHRoaXMgcmVzdHJpY3Rpb24gYnkgdXNpbmcNCj4gPiA+IExVVF9NT0RFIGluc3Rl
YWQgb2YgTFVUX0FERFJFU1MuDQo+ID4gPg0KPiA+ID4gRG9lcyB0aGlzIHJlc3RyaWN0aW9uIGFs
c28gZXhpc3QgZm9yIEZTUEk/DQo+ID4NCj4gPiBZZXMsIEkgaGF2ZSBzZWVuIHRoYXQgaW1wbGVt
ZW50YXRpb24gYW5kIGZpcnN0IHRyaWVzIHdpdGggdGhhdCBzYW1lDQo+ID4gbG9naWMsIHVzaW5n
IExVVF9NT0RFIGluc3RlYWQgb2YgTFVUX0FERFIsIGJ1dCBkaWRu4oCZdCB3b3JrIGZvciB0aGUN
Cj4gPiBGbGV4U1BJIGNvbnRyb2xsZXIuDQo+ID4NCj4gPiBJbiB0aGlzIGNvbnRyb2xsZXIsIHdl
IGFyZSBoYXZpbmcgc2VwYXJhdGUgTFVUX1hYIGZvciBSb3dBZGRyZXNzIGFuZA0KPiA+IENvbHVt
bkFkZHJlc3MuIEZvciBjYXNlIG9mIHRoZSBOYW5kIGZsYXNoLCB3ZSBuZWVkIHRvIHByb2dyYW0g
Ym90aA0KPiA+IFJvd0FkZHJlc3MgYW5kIENvbHVtbkFkZHJlc3MgaW4gc2luZ2xlIExVVCBzZXF1
ZW5jZS4NCj4gDQo+IEhtLCBJIGRvbid0IGdldCBpdC4gTFVUX01PREUgd2FzIGp1c3QgYSB3YXkg
dG8gcGFzcyByYXcgZGF0YSBvbiB0aGUgSS9PIGJ1cywgc28NCj4gdGhlIHJvdyB2cyBjb2x1bW4g
dGhpbmcgaGFzIG5vIG1lYW5pbmcgaW4gdGhpcyBjYXNlLCBhbmQgdGhlIG9mZnNldCB3aXRoaW5n
IHRoZQ0KPiBRU1BJIEFIQiByYW5nZSBzaG91bGQganVzdCBiZSBpZ25vcmVkLg0KPiANCkkgaGF2
ZSB0cmllZCB0byBwYXNzIHRoZSBhZGRyZXNzIHdpdGggTFVUX01PREUgYW5kIGl0J3Mgbm90IHdv
cmtpbmcgZm9yIG1lLg0KSSBhbSBnZXR0aW5nIGJhc2ljIFJlYWQgZmFpbHVyZSBhdCBhZGRyZXNz
IDB4MDAgd2l0aCBDUzAgYWxzby4NCg0KSSBoYWQgZGlzY3Vzc2lvbiB3aXRoIHRoZSBIVyBJUCBv
d25lciBhbmQgdGhleSBzdWdnZXN0IHRvIHVzaW5nIExVVF9BRERSIGZvciBzZW5kaW5nIGFkZHJl
c3MgYnl0ZSBpbmZvcm1hdGlvbi4NCg0KPiA+DQo+ID4gSU1PLCB3aGVuIHN1cHBvcnQgbmVlZHMg
dG8gYmUgYWRkZWQgZm9yIE5BTkQgZmxhc2gsIHRoZW4gc2xpZ2h0DQo+ID4gbW9kaWZpY2F0aW9u
IGNhbiBiZSBkb25lIGluIHRoZSBsb2dpYy4gQXMgcGVyIG15IGRpc2N1c3Npb24gd2l0aA0KPiA+
IGNvbnRyb2xsZXIgdmFsaWRhdGlvbiBndXlzLCBuZWVkcyB0byBzZW5kIDE2LWJpdCBhZGRybGVu
IGZvcg0KPiA+IFJvd0FkZHJlc3MsIExVVF9BRERSICgweDIpIEFkZHJsZW4gY2FuIHZhcnkgZm9y
IHRoZSBjb2x1bW4tYWRkcmVzcyBhbmQNCj4gPiBuZWVkcyB0byBiZSBwcm9ncmFtbWVkIGZvciBz
ZXF1ZW5jZSBMVVRfQ0FERFJfU0RSICgweDMpDQo+IA0KPiBBbmQgdGhhdCdzIGFnYWluIGZsYXNo
IHNwZWNpZmljIGRldGFpbHMgbGVha2luZyBpbnRvIHRoZSBzcGktbWVtIGxheWVyLCB3aGljaCBJ
J2QNCj4gbGlrZSB0byBhdm9pZCAoYXMgcmVwZWF0ZWQgbWFueSB0aW1lcyBiZWZvcmUpLg0KDQpB
Y3R1YWxseSwgRmxleFNQSSBjb250cm9sbGVyIGhhcyBwcm92aWRlZCB0aGUgbWVjaGFuaXNtIHRv
IHBhc3MgdGhlIHZhbHVlIG9mIHRoZSBhZGRyZXNzIGFzIFJvdyBhbmQgQ29sdW1uIGFkZHJlc3Mg
cmVxdWlyZWQsIGlmIG5lZWRlZCBmb3Igc2xhdmUgZGV2aWNlLg0KVGh1cywgaWYgbmVlZGVkLCB3
ZSBjYW4gdXNlIHRoaXMgZmVhdHVyZSBvZiB0aGUgRmxleFNQSSBjb250cm9sbGVyIHRvIHBhc3Mg
dGhlIGFkZHJlc3MgWzFdLCBzZWN0aW9uIDMwLjcuNiwNCg0KPiANCj4gPiA+DQo+ID4gPiBZb3Ug
YXJlIHVzaW5nIHRoZSByZW1hcHBpbmcgcHJvY2VkdXJlIGFzIGluIHRoZSBRU1BJIE5PUiBkcml2
ZXIuDQo+ID4gPiBUaGUgb3JpZ2luYWwgcHVycG9zZSB3YXMgdG8gc3RhcnQgd2l0aCBhIHJhdGhl
ciBzbWFsbCBtYXBwaW5nIHNpemUNCj4gPiA+IGFuZCBpbmNyZWFzZSBpdCB3aGVuIGEgbGFyZ2Vy
IG1lbW9yeSBkZXZpY2UgaXMgdXNlZC4NCj4gPiA+DQo+ID4gPiBBdCB0aGUgc2FtZSB0aW1lIHlv
dSB1c2UgdGhlIGxvZ2ljIGZyb20gdGhlIFFTUEkgU1BJIG1lbSBkcml2ZXIsDQo+ID4gPiB0aGF0
IGFkanVzdHMgdGhlIGRhdGEubmJ5dGVzIG9mIGVhY2ggcmVhZCBvcCB0byBhIG1heGltdW0gb2YN
Cj4gPiA+IGFoYl9idWZfc2l6ZSBpbiBueHBfZnNwaV9hZGp1c3Rfb3Bfc2l6ZSgpLg0KPiA+ID4g
VGhpcyBpcyB0aGUgbG9naWMgdGhhdCBCb3JpcyBpbnRyb2R1Y2VkIGZvciB0aGUgUVNQSSBkcml2
ZXIgdW50aWwgd2UNCj4gPiA+IHJlcGxhY2UgaXQgd2l0aCBzb21ldGhpbmcgbGlrZSBkaXJtYXAu
DQo+ID4gPg0KPiA+ID4gVW5sZXNzIHRoZXJlIGlzIHNvbWV0aGluZyBJIG1pc3NlZCwgdGhpcyBt
ZWFucyB0aGUgcmFtYXBwaW5nIGlzDQo+ID4gPiB1c2VsZXNzIGFuZCBpdCdzIGVub3VnaCB0byBy
ZXNlcnZlIG1lbW9yeSB3aXRoIHRoZSBmaXhlZCBzaXplIG9mDQo+ID4gPiBhaGJfYnVmX3NpemUu
DQo+ID4NCj4gPiBNeSBjb25jZXJuIHdhcyBmb3IgcGVyZm9ybWFuY2UgYW5kIHRoYXQncyB3aHkg
aGFzIGRvbmUgcmVtYXAgZm9yIHRoZQ0KPiA+IDRNQiBidWZmZXIgc2l6ZSBzbyB0aGF0IGlmIGFu
eSBzdWJzZXF1ZW50IFJlYWQgcmVxdWVzdCB3b3VsZCBjb21lDQo+ID4gd2l0aGluIHRoZSByYW5n
ZSB0aGVuIGRvbuKAmXQgaGF2ZSB0byBwZXJmb3JtIHJlbWFwIGFuZCBjYW4ganVzdA0KPiA+IGRp
cmVjdGx5IGRvIG1lbWNweSgpDQo+ID4NCj4gPiBJIHdvdWxkIHJlLXZpc2l0IGFnYWluIGFuZCBz
ZWUgaWYgZ2V0dGluZyBhbnkgaXNzdWUgaW4gZG9pbmcgZGlyZWN0DQo+ID4gbWVtY3B5KCkgaW5z
dGVhZCBvZiByZW1hcC4gV2UgbmVlZCB0byBwZXJmb3JtIEFIQiBidWZmZXIgaW52YWxpZGF0aW9u
DQo+ID4gd2hlbiB1c2luZyBjb250cm9sbGVyIGluIGJvdGggSVAod3JpdGUsIGVyYXNlIGV0Yykg
YW5kIEFIQiAocmVhZCkNCj4gPiBtb2RlLg0KPiANCj4gVGhlbiB5b3Ugc2hvdWxkIHJlYWxseSBy
ZXZpZXcgbXkgZGlybWFwIHByb3Bvc2FsIGluc3RlYWQgb2YgdHJ5aW5nIHRvIGhhY2sNCj4gdGhp
bmdzIGRpcmVjdGx5IGludG8geW91ciBkcml2ZXIuIFRoZSBvbmx5IHJlYXNvbiBJIGRpZCBubyBz
ZW5kIGEgbmV3IHZlcnNpb24gb2YNCj4gdGhlIGRpcm1hcCBwYXRjaHNldCBpcyBiZWNhdXNlIEkg
Z290IG5vIHJldmlld3MgZnJvbSBwZW9wbGUgdGhhdCBtaWdodCBuZWVkIGl0LA0KPiBzbyBwbGVh
c2UgaGF2ZSBhIGxvb2sgYXQgaXQsIHRyeSB0byBpbXBsZW1lbnQgYSBiYWNrZW5kIGZvciB5b3Vy
IGNvbnRyb2xsZXIsIGFuZA0KPiBsZXQgbWUga25vdyBpZiB5b3UgZmFjZSBhbnkgaXNzdWVzIG9y
IHRoaW5rIHRoaW5ncyBzaG91bGQgYmUgZG9uZSBkaWZmZXJlbnRseS4NCj4gDQpJIHRyaWVkIHdp
dGggc2ltaWxhciBpbXBsZW1lbnRhdGlvbiBhcyBiZWluZyBkb25lIGZvciBRdWFkU1BJIGRyaXZl
ciBhbmQgd2l0aCB0aGF0IG15IEFIQiByZWFkIGFyZSB3b3JraW5nIHdpdGhvdXQgYW55IGlzc3Vl
IGZvciBib3RoIENTLg0KVGh1cywgZG9u4oCZdCByZXF1aXJlIHRvIHBlcmZvcm0gdGhlIHJlLW1h
cCBhZ2FpbiBhbmQgYWdhaW4gd2hlbiBkb2luZyBBSEIgZGF0YSB0cmFuc2Zlci4NCldvdWxkIHNl
bmQgdGhlIGNoYW5nZXMgaW4gbmV4dCB2ZXJzaW9uLg0KDQpSZWdhcmRzDQpZb2dlc2ggR2F1ci4N
Cg0KWzFdIGh0dHBzOi8vd3d3Lm54cC5jb20vZG9jcy9lbi9yZWZlcmVuY2UtbWFudWFsL0lNWFJU
MTA1MFJNLnBkZg0KDQo+IFRoYW5rcywNCj4gDQo+IEJvcmlzDQo=
