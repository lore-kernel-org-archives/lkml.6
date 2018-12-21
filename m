Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABECC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F117F2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 04:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g5tUNGj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbeLUE2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 23:28:24 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:62528
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732806AbeLUE2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 23:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KaOyv7tEp6oZqEHyww1zVRWx+YndU2z+O7NAP2jpMM=;
 b=g5tUNGj62lpZs4JlE278vkjcK15W3U9q1daiIvIomJAIUp/wGNFTYh2I/fWtdyYQdYBizmgs1a5MHd/5vZzTrweKwmIvCUCfVL0q4gXxT8lwyRuzo0NmPOCdTp2Gct9MpCGB1C+Ae1Ji4g85tOl11c4SA8N6itoGA9U0baAWn2I=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5564.eurprd04.prod.outlook.com (20.178.106.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Fri, 21 Dec 2018 04:28:16 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9%4]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 04:28:16 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH 1/2] Documentation: can: flexcan: add PE clock source
 property to device tree
Thread-Topic: [PATCH 1/2] Documentation: can: flexcan: add PE clock source
 property to device tree
Thread-Index: AQHUkrKTIckHgyi7wUKqieTSsLQm46WIHiWAgACEZMA=
Date:   Fri, 21 Dec 2018 04:28:16 +0000
Message-ID: <DB7PR04MB46185ACEDA227BEFCED6971DE6B80@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
 <20181213070537.25095-2-qiangqing.zhang@nxp.com>
 <20181220202247.GA26362@bogus>
In-Reply-To: <20181220202247.GA26362@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5564;6:LT+IAdfy//KDXOfwtx8NCjDo4eVrsVBgZa2VafpkCjO0TRlksoYBYMevYOZpErDF1YVCYRyGcijQT/s4D31kTtzow9cRjfysxGDd1Mg0oLr9IezOlwYKyRWlCpgD/wDrJezQCo0ob+iOyOjpJfU4jAngOHswqU81zWorUSmQaZTeSPqH7GyZ7YAJ7fQCtSRFc4uZn5l2kyN9xQqEE6JViOMMX1sabK61ljoMBi8Zcz0hMJNVk8EXG0Gl/8cZ4Wr4cmgTgE2fHWF/gLKe39BE1SfEvEzLRrO7HhEcML9+axoIetA5IoRQZnl2hEEL37hG9BHYueVqFq7mKT3nXyC5j8t9+d3qGt1xkb2o8TRXwthbon1cs2K6OE9DCnpHLVczxxbD2CZb32tyOoRJ9bNW/viF5FCJV4mNg5RKM+Qv+A8ccVgodNpd9lx1DsTVPKj+8IZpOTWaV6ZWlGRK/OGMow==;5:0EpuIQL8vIQbxSHBtVCYVBGPoVsgUQCXBQOHP6uYazb5wH8YcZOhcTQbbRnTMFQmFDenkTtJbN7xK/ryMV+yFMuljH3Fj6WfE/70HMmQW2gxPbudN1EWD5YRaragXV30/g5izzJQQw+LsDZYSgOOaITYKQAfWgQDCXoxFrkNnEw=;7:i1HrrFwZJEKhhswV46Yiu8qtTQLmweQEdmI6TUGSXPN/4dHBpmLMM6Y4aQ6h3qTlVfD35fa232EIl7YXq6TibDBDIqB2OvPHTbxoPrtBmj5+3fbvE9xExjzdk60pvfqOanLvb0sxnwW9hxFdmHB4gA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1a3cfd28-7c77-4cda-d87f-08d666fcba61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5564;
x-ms-traffictypediagnostic: DB7PR04MB5564:
x-microsoft-antispam-prvs: <DB7PR04MB5564CD49627E65324CC6C28CE6B80@DB7PR04MB5564.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(8220043)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5564;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5564;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(13464003)(305945005)(11346002)(7696005)(71200400001)(25786009)(81166006)(81156014)(71190400001)(86362001)(316002)(33656002)(8676002)(7736002)(54906003)(6916009)(74316002)(68736007)(106356001)(105586002)(2906002)(66066001)(55016002)(26005)(256004)(478600001)(99286004)(5660300001)(53936002)(6506007)(6246003)(102836004)(53546011)(9686003)(14454004)(4326008)(186003)(6436002)(229853002)(76176011)(8936002)(476003)(486006)(446003)(97736004)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5564;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mx+PJFuuT/XFDrvzK+Wk8gkJwp4riPIsh6Jic/0H/0jDr7i9hgSC25Tq0CvGNbWAI2VI970RdrvGdihUCD2TOfu4edNufmnkGZy+/n2Xll/VLQ0OWDPErJ1k3eLSDtyWIgv8or5h0DVhgy5tHm4XC3inXFkpeTGtyiWwzgOsWYjxNDsKncMnJ6sCwcv9FqzIGHOCiTd1Bl0dGuEaAyJEQoFqqZDdDRev/2q/0XFtfH5yt4g3Do1NmxV1X9PvKrtT5gqFGN+YixwUpQql9Wne2kFpZQlxoiuTrSiVlEPr9WstgTsYo1Q8rm6eqLXwMSVd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3cfd28-7c77-4cda-d87f-08d666fcba61
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 04:28:16.3789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMTjE6jEy1MIyMcjVIDQ6MjMNCj4gVG86IEpvYWtpbSBa
aGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+IENjOiBta2xAcGVuZ3V0cm9uaXguZGU7
IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlt
eEBueHAuY29tPjsgQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzJdIERvY3VtZW50YXRpb246IGNhbjogZmxleGNhbjogYWRkIFBFIGNs
b2NrIHNvdXJjZQ0KPiBwcm9wZXJ0eSB0byBkZXZpY2UgdHJlZQ0KPiANCj4gT24gVGh1LCBEZWMg
MTMsIDIwMTggYXQgMDc6MDc6NTdBTSArMDAwMCwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+IEZy
b206IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+ID4NCj4gPiBUaGUgRmxl
eENBTiBjb250cm9sbGVyIGNhbiBwYXJzZSBjbG9jayBzb3VyY2UgcHJvcGVydHkgZnJvbSBEVFMg
ZmlsZQ0KPiA+IHRvIHNlbGVjdCBQRSBjbG9jayBzb3VyY2UuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4g
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL2ZzbC1mbGV4Y2FuLnR4
dCB8IDgNCj4gPiArKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9jYW4vZnNsLWZsZXhjYW4udHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbmV0L2Nhbi9mc2wtZmxleGNhbi50eHQNCj4gPiBpbmRleCBiYzc3NDc3YzY4Nzgu
LmEwNDE2ODYwNTk5OCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbmV0L2Nhbi9mc2wtZmxleGNhbi50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9mc2wtZmxleGNhbi50eHQNCj4gPiBAQCAtMzIs
NiArMzIsMTMgQEAgT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiAgCQkgYWNrX2dwciBpcyB0aGUg
Z3ByIHJlZ2lzdGVyIG9mZnNldCBvZiBDQU4gc3RvcCBhY2tub3dsZWRnZS4NCj4gPiAgCQkgYWNr
X2JpdCBpcyB0aGUgYml0IG9mZnNldCBvZiBDQU4gc3RvcCBhY2tub3dsZWRnZS4NCj4gPg0KPiA+
ICstIGZzbCxjbGstc291cmNlOiBTZWxlY3QgdGhlIGNsb2NrIHNvdXJjZSB0byB0aGUgQ0FOIFBy
b3RvY29sIEVuZ2luZSAoUEUpLg0KPiA+ICsJCSAgSXQncyBTb0MgSW1wbGVtZW50YXRpb24gZGVw
ZW5kZW50LiBSZWZlciB0byBSTSBmb3IgZGV0YWlsZWQNCj4gDQo+IElmIFNvQyBkZXBlbmRlbnQs
IHRoZW4gaXQgc2hvdWxkIGJlIGltcGxpZWQgYnkgdGhlIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxl
Lg0KPiBBbHNvLCBzZWVtcyBsaWtlIHlvdSBzaG91bGQgYWRkIGNsb2NrIGJpbmRpbmcgc3VwcG9y
dCBoZXJlIGlmIHlvdSBuZWVkIG1vcmUNCj4gY2xvY2sgY29udHJvbC4NCg0KSGksDQoNCk15IGV4
cHJlc3Npb24gaGVyZSBtaWdodCBub3QgYmUgdmVyeSBhY2N1cmF0ZSwgdGhpcyBwcm9wZXJ0eSBq
dXN0IGhlbHAgdG8gc2VsZWN0IHRoZSBjbG9jayBzb3VyY2UgZm9yDQpQcm90b2NvbCBFbmdpbmUg
KFBFKS4gRmxleENBTiBpcCBzdXBwb3J0IHR3byBQRSBjbG9jayBzb3VyY2VzLCBzbyB3ZSBoYXZl
IHRvIGFkZCB0aGlzIHByb3BlcnR5IHRvDQpsZXQgZHJpdmVyIGtub3cgdGhhdCBTb0MgaGFzIHNl
bGVjdGVkIHdoaWNoIG9uZS4NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQoNCj4gPiAr
CQkgIGRlZmluaXRpb24uIElmIHRoaXMgcHJvcGVydHkgaXMgbm90IHNldCBpbiBkZXZpY2UgdHJl
ZSBub2RlDQo+ID4gKwkJICB0aGVuIGRyaXZlciBzZWxlY3RzIGNsb2NrIHNvdXJjZSAxIGJ5IGRl
ZmF1bHQuDQo+ID4gKwkJICAwOiBjbG9jayBzb3VyY2UgMCAob3NjaWxsYXRvciBjbG9jaykNCj4g
PiArCQkgIDE6IGNsb2NrIHNvdXJjZSAxIChwZXJpcGhlcmFsIGNsb2NrKQ0KPiA+ICsNCj4gPiAg
RXhhbXBsZToNCj4gPg0KPiA+ICAJY2FuQDFjMDAwIHsNCj4gPiBAQCAtNDAsNCArNDcsNSBAQCBF
eGFtcGxlOg0KPiA+ICAJCWludGVycnVwdHMgPSA8NDggMHgyPjsNCj4gPiAgCQlpbnRlcnJ1cHQt
cGFyZW50ID0gPCZtcGljPjsNCj4gPiAgCQljbG9jay1mcmVxdWVuY3kgPSA8MjAwMDAwMDAwPjsg
Ly8gZmlsbGVkIGluIGJ5IGJvb3Rsb2FkZXINCj4gPiArCQlmc2wsY2xrLXNvdXJjZSA9IDwwPjsg
Ly8gc2VsZWN0IGNsb2NrIHNvdXJjZSAwIGZvciBQRQ0KPiA+ICAJfTsNCj4gPiAtLQ0KPiA+IDIu
MTcuMQ0KPiA+DQo=
