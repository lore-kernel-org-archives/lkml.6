Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F678C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB4C20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KKvZeKe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB4C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeLFBqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:46:16 -0500
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:15585
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727741AbeLFBqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/UnAVoHjWzfh3ioGEPcE8aeQl5AJuONShRcg4B5Fzk=;
 b=KKvZeKe8oxSnUj5LT9Od73UDyfizvuCzcCkQnZP6a7HUZTHo1HG3BoqXAupKy7xttK7SyK4hP4o9Fmp+vRigdV7KfKxnsB5pjk5VhW5RpDjDE5sQrnVFREihLyC/ZD8yrERGCWqNSLjStK3CHnDeJ8t0dTif1HUbgii1ODyA6JU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 01:46:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 01:46:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] ARM: dts: imx6qdl-sabresd: add light sensor support
Thread-Topic: [PATCH 1/3] ARM: dts: imx6qdl-sabresd: add light sensor support
Thread-Index: AQHUjHurf4tHrcB58kqn5WYLMeeHcqVwD1kAgADhkhA=
Date:   Thu, 6 Dec 2018 01:46:10 +0000
Message-ID: <DB3PR0402MB3916BEACB5693F50A41A8A04F5A90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5ACrqY9FusUG7E-vMWJ4pKpVgw-yLOYqJncOJ+H9A5k5w@mail.gmail.com>
In-Reply-To: <CAOMZO5ACrqY9FusUG7E-vMWJ4pKpVgw-yLOYqJncOJ+H9A5k5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3947;6:+g7aD40/zzP6pPr+HXoQ7FsQoxeOYYjFG0MKTslgrv0t4gCfKOZyOAFa7my3CRsS2rb/kGOF2/7Gd8VP2NNWq7hS6KHgosjEFa68w1zmKiJxSKTDywOumi2gAfgmBjej6E5Ytz3jP4MAwUTpaZSa7dZw+kvEChTwqB4La2xxYWoyg8Gzrm87fjGxkkwo6ZpdLKg1vIBpS2HhWc9wE23EmEMQfN/yAoTglpJcnXHxzkXl6UmrhKdUcXbztGdswU38v6jMSGzMy8YfLfA4ff7f9gcIm5Utag4X59w7ZytFWcwOXzkFHKYrsPvZJU7Yi2bSIOVixyQ4E6jB0gDOVPOcFBs+BlcbBiJtE/+HIDRZaNdYwt36p9AqwXxPb9WPZAkL3i/mtxk5MjvaN4DmRLF3N1PnEt1ybwvWwAGYJYF+VueSMTu2Jxmi0rweIA7E/IDt8BG25vKeLlmX/nIW/zvUrw==;5:Zyk+VgoP0SKQHHYI9krv8zHgq0dahAkC6mJeJkUxcqJOBu//C6BpDsGtS91TelGh1IH5JEt6As/7yCRM/eDDTffmPngGuVnJiUKNLqc7YA/9FVzHn6XcRvB5mTQkTN9z6fAjDzStaDEnjf4x64GOXlbl4PyN5xQoQ8L10jcWM/g=;7:YRsy6jQkoZA3hW3rk4daZJ3jsF3QCp5+qE2P9A5rRxwX1FULOLS2rvluexyS3yYvHiNK89gWyypRhtuP/ZoLFBoopMljxSIgEKMj99qMSLyuC/qYEdxMkq35jTMnt93Gc9P+pjakjvIBm58eW7HApA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 50655c41-6ec4-4d2e-52d5-08d65b1c9937
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3947;
x-ms-traffictypediagnostic: DB3PR0402MB3947:
x-microsoft-antispam-prvs: <DB3PR0402MB39471406E0CB3A33BD77D088F5A90@DB3PR0402MB3947.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3947;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3947;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(13464003)(102836004)(86362001)(76176011)(11346002)(229853002)(7696005)(97736004)(6506007)(53546011)(99286004)(3846002)(44832011)(6916009)(476003)(6436002)(256004)(2906002)(26005)(446003)(486006)(6116002)(186003)(54906003)(106356001)(74316002)(6246003)(14454004)(39060400002)(105586002)(1411001)(305945005)(478600001)(7736002)(4326008)(66066001)(33656002)(25786009)(8936002)(81166006)(81156014)(71190400001)(71200400001)(5660300001)(55016002)(9686003)(68736007)(53936002)(8676002)(316002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3947;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WnXQyUnUtr5xgLIYe+wlvhYOhgYqt4QfHRuFjTqvybc3TwQT6v8nDSTGVWD/Q1hQAiHpqswC1gBAQNnkMLvNJMYq+9e1jdiLHkOw/zAwQ8NnXkSWmcOsNPGtLeMRsebkFFfVIqmm6k/ayRZ9W1PDkjdT1ovUqXubsgOM9jxJ4oxe3EZHm8OZqmE0jakIC8NdGN9UAREwXpgp532Kqe4ougUIooViDCcq07EadEmOPC4a9tosexUHKoZY+aWaWmKSX2OIKsCdyXIm6U5Cg5V11bz27YngAGnYlYzGYjmM4srRA8MLqz8/G4ucngueME9l09lANotny3CQ/j1F8zjAlcSZuYHczueCwNxgJijaKrg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50655c41-6ec4-4d2e-52d5-08d65b1c9937
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 01:46:10.6404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdt
YWlsLmNvbV0NCj4gU2VudDogMjAxOOW5tDEy5pyINeaXpSAyMDoxNQ0KPiBUbzogQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5l
bC5vcmc+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBTYXNjaGEg
SGF1ZXIgPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvDQo+IEVzdGV2YW0gPGZhYmlvLmVz
dGV2YW1AbnhwLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Ow0KPiBNYXJr
IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgbW9kZXJhdGVkIGxpc3Q6QVJNL0ZSRUVT
Q0FMRSBJTVgNCj4gLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRSA8bGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnPjsgb3Blbg0KPiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5F
RCBERVZJQ0UgVFJFRSBCSU5ESU5HUw0KPiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBs
aW51eC1rZXJuZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gQVJNOiBk
dHM6IGlteDZxZGwtc2FicmVzZDogYWRkIGxpZ2h0IHNlbnNvciBzdXBwb3J0DQo+IA0KPiBIaSBB
bnNvbiwNCj4gDQo+IE9uIFdlZCwgRGVjIDUsIDIwMTggYXQgNzoyMCBBTSBBbnNvbiBIdWFuZyA8
YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBBZGQgaXNsMjkwMjMgbGln
aHQgc2Vuc29yIHN1cHBvcnQgb24gaTJjMyBidXMsIHRoZSBsaWdodCBzZW5zb3Incw0KPiA+IHBv
d2VyIGlzIGNvbnRyb2xsZWQgYnkgYSBmaXhlZCByZWd1bGF0b3IsIHNpbmNlIHRoZSBpc2wyOTAy
MyBkcml2ZXINCj4gPiBhbmQgbW9zdCBvZiBvdGhlciBzZW5zb3JzIG9uIHNhbWUgYm9hcmQgbGlr
ZSBtYWczMTEwIGFuZCBtbWE4NDUxIGRvDQo+ID4gTk9UIHN1cHBvcnQgcmVndWxhdG9yIG9wZXJh
dGlvbiBjdXJyZW50bHksIHRoZXkgYXJlIGFsbCBjb250cm9sbGVkIGJ5DQo+ID4gdGhpcyByZWd1
bGF0b3IsIHNvIHRoaXMgcGF0Y2ggYWxzbyBhZGRzIHRoZSBmaXhlZCByZWd1bGF0b3Igc3VwcG9y
dA0KPiA+IGFuZCBtYWtlIGl0IGFsd2F5cyBvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFu
c29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9i
b290L2R0cy9pbXg2cWRsLXNhYnJlc2QuZHRzaSB8IDM0DQo+ID4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtc2FicmVzZC5k
dHNpDQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLXNhYnJlc2QuZHRzaQ0KPiA+IGlu
ZGV4IGQ3Mzg5YjUuLmY5NmFlNTQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnFkbC1zYWJyZXNkLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRs
LXNhYnJlc2QuZHRzaQ0KPiA+IEBAIC02Miw2ICs2MiwxOSBAQA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIGdwaW8gPSA8JmdwaW8zIDE5IDA+Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGVuYWJsZS1hY3RpdmUtaGlnaDsNCj4gPiAgICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+
ID4gKyAgICAgICAgICAgICAgIHJlZ19zZW5zb3I6IHJlZ3VsYXRvckA0IHsNCj4gDQo+IEkga25v
dyB0aGF0IHlvdSBmb2xsb3dlZCB0aGUgZXhpc3RpbmcgcGF0dGVybiBmb3IgcmVndWxhdG9ycyBp
biB0aGlzIGZpbGUsIGJ1dCBpdCBpcw0KPiBub3QgcmVjb21tZW5kZWQgdG8gcHV0IHJlZ3VsYXRv
cnMgdW5kZXIgInNpbXBsZS1idXMiLg0KPiANCj4gSSB3b3VsZCBzdWdnZXN0IHlvdSB0byBtYWtl
IGEgZmlyc3QgcGF0Y2ggb2YgdGhlIHNlcmllcyB0aGF0IHJlbW92ZXMgYWxsIG9mIHRoZQ0KPiBl
eGlzdGluZyByZWd1bGF0b3JzIGZyb20gInNpbXBsZS1idXMiLCB0aGVuIHlvdSBhZGQgdGhpcyBz
ZXJpZXMgb24gdG9wLg0KPiANCj4gVGhlbiB0aGlzIHJlZ3VsYXRvciBiZWNvbWVzOg0KPiANCj4g
cmVnX2xpZ2h0X3NlbnNvcjogcmVndWxhdG9yLWxpZ2h0LXNlbnNvciB7DQo+IA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8ND47DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfc2Vuc29yX3JlZz47DQo+IA0KPiBwaW5jdHJsX3Nl
bnNvcl9yZWcgaXMgdG9vIGdlbmVyaWMuIFlvdSBjb3VsZCB1c2UgcGluY3RybF9saWdodF9zZW5z
b3JfcmVnDQoNCkFzIHRoaXMgcmVndWxhdG9yIGNvbnRyb2xzIGFsbCB0aGUgc2Vuc29ycyBwb3dl
ciBvbiBib2FyZCwgaW5jbHVkaW5nIGxpZ2h0IHNlbnNvciwNCm1hZ25ldG9tZXRlciBzZW5zb3Ig
YW5kIGFjY2VsZXJvbWV0ZXIgc2Vuc29ycywgc28gSSB0aGluayBpdCBpcyBiZXR0ZXIgdG8NCnVz
ZSAicGluY3RybF9zZW5zb3JzX3JlZyIgaW5zdGVhZCBvZiAicGluY3RybF9saWdodF9zZW5zb3Jf
cmVnIiwgc28gSSB1c2UNCiIgcGluY3RybF9zZW5zb3JzX3JlZyIgaW4gVjIgcGF0Y2guDQoNCj4g
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVndWxhdG9yLW5hbWUgPSAic2Vuc29yLXN1
cHBseSI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVndWxhdG9yLW1pbi1taWNyb3Zv
bHQgPSA8MzMwMDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVndWxhdG9yLW1h
eC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ3Bp
byA9IDwmZ3BpbzIgMzEgR1BJT19BQ1RJVkVfSElHSD47DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgZW5hYmxlLWFjdGl2ZS1oaWdoOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJl
Z3VsYXRvci1hbHdheXMtb247DQo+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gICAgICAgICB9
Ow0KPiA+DQo+ID4gICAgICAgICBncGlvLWtleXMgew0KPiA+IEBAIC00MjAsNiArNDMzLDE1IEBA
DQo+ID4gICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8NyAyPjsNCj4gPiAgICAgICAgICAg
ICAgICAgd2FrZXVwLWdwaW9zID0gPCZncGlvNiA3IDA+Ow0KPiA+ICAgICAgICAgfTsNCj4gPiAr
DQo+ID4gKyAgICAgICBpc2wyOTAyM0A0NCB7DQo+IA0KPiBOb2RlIG5hbWVzIHNob3VsZCBiZSBn
ZW5lcmljLCBzbzogbGlnaHQtc2Vuc29yQDQ0DQoNCkltcHJvdmVkIGl0IGluIFYyIHBhdGNoLCBh
bmQgYWxzbyBhcHBseSB0aGUgcGF0Y2ggeW91IHNlbnQgbWUgYXMNCnRoZSBmaXJzdCBwYXRjaCwg
cGxlYXNlIGhlbHAgcmV2aWV3IHRoZW0sIHRoYW5rcy4NCg0KQW5zb24uDQoNCg==
