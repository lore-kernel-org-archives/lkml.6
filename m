Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CB0252C1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sdObzi/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CB0252C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeGBRSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:18:23 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:4844
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752620AbeGBRSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85CFi6HzVHzMmyK9B8GOnS+knaIUskm9sPjGe3/jE3s=;
 b=sdObzi/tnfOyU49GkeY/kQOWHU/dHdS3+n4YoIrh8TfiU+lRrQfp6EM1v8PbyCixzvjT3MOZ/OJrtRskZNdiRRVhBZPc14A87gs+3zFgh/I6lgx+Z7FGkQejCpxQZTBZi1emrpOcsuWRi+XDgkpn9Kx2FtHJDKPJcyaUgCp+8z4=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4913.eurprd04.prod.outlook.com (20.176.215.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Mon, 2 Jul 2018 17:18:17 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::1cd1:a089:87a0:25ec]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::1cd1:a089:87a0:25ec%2]) with mapi id 15.20.0906.026; Mon, 2 Jul 2018
 17:18:17 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: imx: Initial imx7d pm support
Thread-Topic: [PATCH 2/2] PCI: imx: Initial imx7d pm support
Thread-Index: AQHT/zW2MJXwgkaSqkWoaZZ+xNMvtaR8UuMA
Date:   Mon, 2 Jul 2018 17:18:17 +0000
Message-ID: <02207512447db4585a4e879e2a059ba223d57dbe.camel@nxp.com>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
         <a6176c8bcfbca08ce4e93e304bdcd48c4600f8e2.1527621510.git.leonard.crestez@nxp.com>
         <1528468422.26356.20.camel@pengutronix.de>
In-Reply-To: <1528468422.26356.20.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4913;7:PEv1Lw6mhU8uWer9e0tNgo6wBDXfvQVxKvEeulyKebT2BLqPJvYAv77yC4ARqjDJYMLR6ObanjynWT8wwNbK3+K9a/e05NlZ1jLvW/xUMp3mKsjy0goUf9mnrw94K+4bmpBEQ/z+w552dZLAK600F9eG2aeGDUZIW/Eld02X02I+tQZCsbe49qTVlge4ZweNTsAZaDdg0D3dWZ2hBgTUhihZJCxxrP+5bDUrwz3f3XlVEEcyaHqFbQQxV0ZFVzCY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 57c53732-1cbb-4dc5-3cdc-08d5e03fcd73
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4913;
x-ms-traffictypediagnostic: AM0PR04MB4913:
x-microsoft-antispam-prvs: <AM0PR04MB4913586B402560BABF6AB9F0EE430@AM0PR04MB4913.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4913;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4913;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(189003)(199004)(2501003)(478600001)(2900100001)(5250100002)(6512007)(66066001)(4326008)(39060400002)(106356001)(105586002)(68736007)(25786009)(3846002)(6116002)(86362001)(6246003)(53936002)(6636002)(2906002)(186003)(305945005)(14444005)(14454004)(26005)(6436002)(316002)(7416002)(6506007)(118296001)(102836004)(256004)(5660300001)(229853002)(81156014)(81166006)(8676002)(110136005)(50226002)(2616005)(7736002)(54906003)(76176011)(36756003)(446003)(6486002)(11346002)(97736004)(99286004)(44832011)(486006)(476003)(8936002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4913;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GF7wmS+RE7p9GuVBoW3ntaScSJUNw9w74lGVSTPq+5F8JD+wOeEbR1t2ndt3od5ObNQbZRsjynYWfbKQtZPgdZ+CMgxUQkKeiRHSc8OOffiiWQI8ft+k2+3DHOh2vid7YpvRA6Lffg1T1CC38HJmilplrWcmSJ04PIeVYER/NQg9mp6yYwh1vPAzwWgBDBh/D5+PtAGK/xFOS7CUBgO9s3tAcUT+01UIiejGEeJCWEXyNgCkUaiz4ppbEc/ASaEzA8lrlkZKm6z32VWL8nunrlElRmXgEnvhy38bBgAAGVys1LIlW+rZtbveO2nK9qBFZThltf0NDyU/OuNtAs+Yis67M1HTq/WoSP6L5/VKLJA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <307DAE26A944334983407BC6B86DC578@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c53732-1cbb-4dc5-3cdc-08d5e03fcd73
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 17:18:17.6585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA2LTA4IGF0IDE2OjMzICswMjAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4g
QW0gRGllbnN0YWcsIGRlbiAyOS4wNS4yMDE4LCAyMjozOSArMDMwMCBzY2hyaWViIExlb25hcmQg
Q3Jlc3RlejoNCj4gPiBPbiBpbXg3ZCB0aGUgcGh5IGlzIHR1cm5lZCBvZmYgaW4gc3VzcGVuZCBh
bmQgbXVzdCBiZSByZXNldCBvbiByZXN1bWUuDQo+ID4gUmlnaHQgbm93IGxzcGNpIC12IGZhaWxz
IGFmdGVyIGEgc3VzcGVuZC9yZXN1bWUgY3ljbGUsIGZpeCB0aGlzIGJ5DQo+ID4gYWRkaW5nIG1p
bmltYWwgc3VzcGVuZC9yZXN1bWUgY29kZSBmcm9tIHRoZSBueHAgdmVuZG9yIHRyZWUuDQo+ID4g
DQo+ID4gVGhpcyBpcyBjdXJyZW50bHkgb25seSBlbmFibGVkIGZvciBpbXg3IGJ1dCB0aGUgc2Ft
ZSBzZXF1ZW5jZSBjYW4gYmUNCj4gPiBhcHBsaWVkIHRvIG90aGVyIGlteCBwY2llIHZhcmlhbnRz
Lg0KDQo+ID4gKyNpZmRlZiBDT05GSUdfUE1fU0xFRVANCj4gPiArc3RhdGljIGludCBpbXg2X3Bj
aWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBpbXg2X3BjaWUgKmlteDZfcGNpZSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsNCj4g
PiArCWlmIChpbXg2X3BjaWUtPnZhcmlhbnQgPT0gSU1YN0QpIHsNCj4gDQo+IEluc3RlYWQgb2Yg
dGhpcyBsYXJnZSBpbmRlbnRlZCBibG9jaywgcGxlYXNlIGp1c3QgaGF2ZSBhbiBlYXJseSByZXR1
cm4NCj4gYXQgdGhlIHN0YXJ0IG9mIHRoaXMgZnVuY3Rpb24sIGxpa2U6DQo+IA0KPiBpZiAoaW14
Nl9wY2llLT52YXJpYW50ICE9IElNWDdEKQ0KPiAJcmV0dXJuIDA7DQo+IA0KPiBTYW1lIGZvciB0
aGUgcmVzdW1lIGZ1bmN0aW9uLg0KDQpPSy4gVGhlIHJlc3VtZSBzZXF1ZW5jZSBpcyBtb3N0bHkg
dGhlIHNhbWUgZm9yIGFsbCBTT0NzIHdoZXJlIGl0DQphcHBsaWVzLg0KDQo+ID4gK3N0YXRpYyBp
bnQgaW14Nl9wY2llX3Jlc3VtZV9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gK3sNCj4g
PiArCWludCByZXQgPSAwOw0KPiA+ICsJc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llID0gZGV2
X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKwlzdHJ1Y3QgcGNpZV9wb3J0ICpwcCA9ICZpbXg2X3Bj
aWUtPnBjaS0+cHA7DQo+ID4gDQo+ID4gKw0KPiA+ICsJaWYgKGlteDZfcGNpZS0+dmFyaWFudCA9
PSBJTVg3RCkgew0KPiA+ICsJCWlteDZfcGNpZV9sdHNzbV9kaXNhYmxlKGRldik7DQo+IA0KPiBU
aGUgTFRTU00gZGlzYWJsZSBzZWVtcyBtaXNwbGFjZWQgaGVyZS4gSSB3b3VsZCBoYXZlIGV4cGVj
dGVkIGl0IHRvIGJlDQo+IGluIHRoZSBzdXNwZW5kIGZ1bmN0aW9uLg0KDQpUaGlzIGlzIGEgcmVx
dWlyZW1lbnQgZm9yIHJlaW5pdGlhbGl6aW5nIHRoZSBjb3JlOiBMVFNTTSBuZWVkcyB0byBiZQ0K
dHVybmVkIG9mZiBkdXJpbmcgaW5pdGlhbGl6YXRpb24uDQoNCj4gPiArCQkvKg0KPiA+ICsJCSAq
IGNvbnRyb2xsZXIgbWF5YmUgdHVybiBvZmYsIHJlLWNvbmZpZ3VyZSBhZ2Fpbg0KPiA+ICsJCSAq
Lw0KPiA+ICsJCWR3X3BjaWVfc2V0dXBfcmMocHApOw0KPiA+ICsNCj4gPiArCQlpbXg2X3BjaWVf
bHRzc21fZW5hYmxlKGRldik7DQo+ID4gKw0KPiA+ICsJCXJldCA9IGlteDZfcGNpZV93YWl0X2Zv
cl9saW5rKGlteDZfcGNpZSk7DQo+ID4gKwkJaWYgKHJldCA8IDApDQo+ID4gKwkJCXByX2luZm8o
InBjaWUgbGluayBpcyBkb3duIGFmdGVyIHJlc3VtZS5cbiIpOw0KPiANCj4gSWYgdGhlIFBIWSBo
YXMgYmVlbiBwb3dlcmVkIGRvd24gYW5kIExUU1NNIHN0b3BwZWQgSSBndWVzcyB3ZSBuZWVkIHRv
DQo+IGRvIHRoZSBmdWxsIGlteDZfcGNpZV9lc3RhYmxpc2hfbGluaygpIGRhbmNlIGFnYWluIGhl
cmUgdG8gcmVsaWFibHkgcmUtDQo+IGVzdGFibGlzaCB0aGUgbGluay4gVGhlIGFib3ZlIHNlZW1z
IHVuc2FmZS4NCg0KV2hhdCBpbXg2X3BjaWVfZXN0YWJsaXNoX2xpbmsgZG9lcyBhZGRpdGlvbmFs
bHkgaXMgc29tZSB3b3JrYXJvdW5kIGZvcg0KbGluayBnZW4gZGV0ZWN0aW9uLiBJIGFncmVlIHRo
YXQgaXQgc2hvdWxkIGJlIGluY2x1ZGVkLg0KDQpUaGlzIHdvdWxkIG1ha2UgcmVzdW1lIG1vc3Rs
eSB0aGUgc2FtZSBhcyBpbXhfcGNpZV9ob3N0X2luaXQgZXhjZXB0IGZvcg0KZHdfcGNpZV9tc2lf
aW5pdDsgdGhhdCBuZWVkcyB0byBiZSBzYXZlZC9yZXN0b3JlZCBzZXBhcmF0ZWx5Lg0KDQoNCkFu
b3RoZXIgaXNzdWUgdGhhdCBzaG91bGQgYmUgZGlzY3Vzc2VkIGhlcmUgaXMgdGhhdCBvbiA2c3gg
YW5kIDdkIHRoZQ0KZ3BjIFBDSUUgcG93ZXIgZG9tYWluIGlzIG5vdCBkZWZpbmVkIGNvcnJlY3Rs
eTogdGhlIFBDSUUgYmxvY2sgaXMgaW4NCnRoZSBESVNQTUlYIGRvbWFpbiBvbiBib3RoIFNPQ3Mg
YW5kIGl0IGlzIG9ubHkgUENJRV9QSFkgd2hpY2ggaGFzIGENCnNlcGFyYXRlIHBvd2VyIGRvbWFp
bi4NCg0KVGhpcyBtYXR0ZXJzOiBlbmFibGluZyBwb3dlci1nYXRpbmcgZm9yIGRpc3BsYXlzIHdp
bGwgYnJlYWsgcGNpZSBpZg0KdGhpcyByZWxhdGlvbnNoaXAgaXMgbm90IHRha2VuIGludG8gYWNj
b3VudC4gSGVyZSBhcmUgc29tZSBvcHRpb25zOg0KDQoxKSBNYWtlICZwZF9wY2llIGEgY2hpbGQg
b2YgJnBkX2Rpc3AgYnkgaGFja2luZyBpbnRvIGdwYyBwcm9iZQ0KZnVuY3Rpb25zIGFuZCBjYWxs
aW5nIHBtX2dlbnBkX2FkZF9zdWJkb21haW4uIE5vdCB2ZXJ5IG5pY2UuDQoNCjIpIFN1cHBvcnQg
bmVzdGluZyBQR0NzIGluIEdQQyBjb2RlPyBMb3RzIG9mIGNvZGUgYW5kIHN0aWxsIGFuDQppbmNv
cnJlY3QgcmVwcmVzZW50YXRpb24gb2YgaGFyZHdhcmUuDQoNCjMpIFNldCBwb3dlci1kb21haW5z
ID0gPCZwZF9kaXNwPiBhbmQgZW5hYmxlIHJ1bnRpbWUgUE0gb24gJnBkX3BjaWU/DQoNCjQpIEFk
ZCBzZXBhcmF0ZSBkZXZpY2VzIGZvciB0aGUgcGNpZS1waHkuIFRoZXNlIHdvdWxkIGJlIG1vc3Rs
eSBlbXB0eQ0KYnV0IHN0aWxsIGRpZmZlcmVudCwgZm9yIGV4YW1wbGUgb24gaW14NnN4IHRoZSBQ
SFkgaXMgbm90IGV2ZW4NCmFjY2Vzc2libGUgb24gdGhlIGJ1cyBidXQgb25seSB0aG91Z2ggUENJ
RSByZWdpc3RlcnMuDQoNClNvbHV0aW9ucyAxLTMgc2VlbSBsaWtlIHdvcmthcm91bmRzIHdoaWxl
IDQgc2VlbXMgZXhjZXNzaXZlLCB3b3VsZA0KYXBwcmVjaWF0ZSBzb21lIGZlZWRiYWNrLg0KDQot
LQ0KUmVnYXJkcywNCkxlb25hcmQ=
