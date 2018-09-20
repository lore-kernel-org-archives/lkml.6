Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5712C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FC52150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JpsIL+PW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FC52150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbeITKNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:13:12 -0400
Received: from mail-he1eur01on0068.outbound.protection.outlook.com ([104.47.0.68]:37600
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbeITKNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34+AiSSnw69MY50SKuCx0Q2k9thbh2QM3MIcqwNMiLo=;
 b=JpsIL+PWnxJUj8Ae3LMu9ZGGD20BwVjw4vPrF8yrFBqgT6Jamm7CWikq4gRpbXuZaBc4ogcF+pxvLqOqzA9yutAT+vihyYU9zIQ08GAC2gFOHc2K2gyJgoc5nHVTmbg9uQ3IXmS7dGjOeI5cGWU/qt/rB+IXTahWN99tiI2GNCQ=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB3294.eurprd04.prod.outlook.com (10.170.231.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 04:31:41 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::2098:afc:1023:6534]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::2098:afc:1023:6534%5]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 04:31:41 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Subject: RE: [RESEND PATCH 1/2] mtd: spi-nor: add macros related to MICRON
 flash
Thread-Topic: [RESEND PATCH 1/2] mtd: spi-nor: add macros related to MICRON
 flash
Thread-Index: AQHUT9SHh5R7raT+cEO6wdw0D8ia66T3zG2AgADG2CA=
Date:   Thu, 20 Sep 2018 04:31:41 +0000
Message-ID: <VI1PR04MB103873DF92DF3380E53C572699130@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1537332608-19561-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537332608-19561-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <bd92d56c-fba6-6b79-07a8-cb426de33639@microchip.com>
In-Reply-To: <bd92d56c-fba6-6b79-07a8-cb426de33639@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3294;6:16gv/lfZRf9DcybFvD+OmDfCFA0lSHLvjUY3ntm9mC1MwCinjDjM7iospzUTMUMvpLfxK5lbYkuDrD9vIiATaPqaQeA7XFobYk8GS93gFPVz1eJV8cAvVWFWbsQVjxEIl/ga9RF5a6YZJ+Bx4wGwpuv9eHFPHJlLQg7LUgiiQBxF154Jix7Knq8iqisaLqjDSQflQh/iDL5/BwjKnGl82YRROx6mXIriQ0iDVZrRYsbNzqYg5Kh01ZjeR+wop8291h7+wthYtmVAJDm0jYODNhiVCbHgoNbPusuRNAWe41pAlnOD/0yxD/biKSM7BVf0vmEIR7+6ht8Png8fY7WdD2ZlIM+cGmEYR1gfISXrgUXAkUZqdR/FUFiicAhAkdNABg5205vmJM86A1rQm5Bah1x1qQJ7suxu+OOSys8usdxJCnHsLY7rZ5A/ehbw7kGF9yBE2KiH3ZDMb0MTxKGvYQ==;5:lO4tHYhtgEbn0paL5W8MspfKlmlYNWV53UwRU4SiLPvO86H1RBm3E3ujZL7dpq5ispvsZnnTFU4M9R1TVSOSojvqOrnFQoiIzT4wFLqhDPj0uezTRIwwAzczNxkgxk3keyPZ37KF5bRsVskUQg+vUIkVTkjdcnl5hmKjc/Cl9J4=;7:oClAyYp81qwIMQcQaLUbLwDsLWRjOT1RrFDYTeQWKlJz3GFNUnJUhfdv5c0PpJLIVb9IEoYU43dO9eTeWMvOwcwQUJGwvZJqfxm2jGDHLV+mAyXSyNm+0ltGTXWzqJBZPLQm7C2bLKEa095SdXAkWpAqInjmXYLjlcNh18eyHmrL312IUq6OelgquppJl1qCmrwY/CQfvUrxOM2GLIJjK94Ry43aQT6DaAivRdNs01NbAJ8/z1EKHnl58OyQpkOm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8c5b4c08-88d8-4e00-d4f4-08d61eb1f68d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3294;
x-ms-traffictypediagnostic: VI1PR04MB3294:
x-microsoft-antispam-prvs: <VI1PR04MB3294C6509D21E5D40E504FF099130@VI1PR04MB3294.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB3294;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3294;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(189003)(199004)(13464003)(6246003)(54906003)(110136005)(305945005)(486006)(478600001)(2900100001)(256004)(53546011)(217873002)(7736002)(6506007)(55236004)(14444005)(105586002)(4326008)(86362001)(106356001)(11346002)(5250100002)(7696005)(102836004)(575784001)(74316002)(2201001)(446003)(8676002)(186003)(26005)(2501003)(66066001)(25786009)(39060400002)(68736007)(2906002)(55016002)(3846002)(53936002)(9686003)(476003)(76176011)(33656002)(8936002)(14454004)(81156014)(99286004)(81166006)(6436002)(6116002)(316002)(97736004)(229853002)(5660300001)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3294;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: j5WoaAhQWLjQK54Sxa+UjwFwDeOriJD+Y8rOQEbtZkcr3ee4Ay5y0nnltPO2XJO2FXIgpXluJsfya0CjPyd1h4t+we9HXmhMSBSNHZ0BUXsPMoFRizz4SReK8SxcXe9OkS5zGgNHH84iDjrETXGoycXs0j5M+KXA+XLpAQv31XGhA1QfwGpz4ZcJWd2FhrVzENJr39RJnozLM/ALk/DTliDu5ggf1LNCOYBXybSgfSrVoHCIasZl+3f5lnT8rG7Vk/mYcEw+mm1ydGSBePGH89An2uQv0ZTgMRkvBPtX4YtL8oDUbDeMuerLxxPr2/RCt/cbr/HLLFCfHdk6rBcRaJK6rQSpk+8fgO3JQN2WJJU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5b4c08-88d8-4e00-d4f4-08d61eb1f68d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 04:31:41.2632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3Ig
QW1iYXJ1cyBbbWFpbHRvOnR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbV0NCj4gU2VudDogV2Vk
bmVzZGF5LCBTZXB0ZW1iZXIgMTksIDIwMTggMTA6MDAgUE0NCj4gVG86IFlvZ2VzaCBOYXJheWFu
IEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPjsgbGludXgtDQo+IG10ZEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnDQo+IENjOiBib3Jpcy5icmV6
aWxsb25AYm9vdGxpbi5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IG1hcmVr
LnZhc3V0QGdtYWlsLmNvbTsgZnJpZWRlci5zY2hyZW1wZkBleGNlZXQuZGU7DQo+IGN5cmlsbGUu
cGl0Y2hlbkB3ZWRldjR1LmZyOyBjb21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb20NCj4gU3ViamVj
dDogUmU6IFtSRVNFTkQgUEFUQ0ggMS8yXSBtdGQ6IHNwaS1ub3I6IGFkZCBtYWNyb3MgcmVsYXRl
ZCB0byBNSUNST04NCj4gZmxhc2gNCj4gDQo+IEhpLA0KPiANCj4gT24gMDkvMTkvMjAxOCAwNzo1
MCBBTSwgWW9nZXNoIEdhdXIgd3JvdGU6DQo+ID4gU29tZSBNSUNST04gcmVsYXRlZCBtYWNyb3Mg
aW4gc3BpLW5vciBkb21haW4gd2VyZSBTVC4NCj4gPiBSZW5hbWUgZW50cmllcyByZWxhdGVkIHRv
IFNUTWljcm9lbGVjdHJvbmljcyB1bmRlciBtYWNybyBTTk9SX01GUl9TVC4NCj4gPg0KPiA+IEFk
ZGVkIGVudHJ5IG9mIE1GUiBJZCBmb3IgTWljcm9uIGZsYXNoZXMsIDB4MDAyQy4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJAbnhwLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCA5ICsrKysrKy0t
LQ0KPiA+ICBpbmNsdWRlL2xpbnV4L210ZC9jZmkuaCAgICAgICB8IDEgKw0KPiA+ICBpbmNsdWRl
L2xpbnV4L210ZC9zcGktbm9yLmggICB8IDMgKystDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ID4gYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1u
b3IuYyBpbmRleCBmMDI4Mjc3Li4zM2E1NWJjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbXRk
L3NwaS1ub3Ivc3BpLW5vci5jDQo+ID4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9y
LmMNCj4gPiBAQCAtMjcxLDYgKzI3MSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHNldF80Ynl0ZShz
dHJ1Y3Qgc3BpX25vciAqbm9yLCBjb25zdA0KPiBzdHJ1Y3QgZmxhc2hfaW5mbyAqaW5mbywNCj4g
PiAgCXU4IGNtZDsNCj4gPg0KPiA+ICAJc3dpdGNoIChKRURFQ19NRlIoaW5mbykpIHsNCj4gPiAr
CWNhc2UgU05PUl9NRlJfU1Q6DQo+IA0KPiBXZSBzaG91bGQgbWFyayBzd2l0Y2ggY2FzZXMgd2hl
cmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2gsIHNvIHRoYXQgd2UNCj4gd2lsbCBi
ZSBwcmVwYXJlZCB3aGVuIGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2guDQoNClBsZWFz
ZSBleHBsYWluIG1vcmUsIG5vdCBhYmxlIHRvIGdldCB0aGlzIGNvbW1lbnQuIFNvcnJ5IGZvciBp
Z25vcmFuY2UuDQoNCj4gDQo+ID4gIAljYXNlIFNOT1JfTUZSX01JQ1JPTjoNCj4gPiAgCQkvKiBT
b21lIE1pY3JvbiBuZWVkIFdSRU4gY29tbWFuZDsgYWxsIHdpbGwgYWNjZXB0IGl0ICovDQo+ID4g
IAkJbmVlZF93cmVuID0gdHJ1ZTsNCj4gPiBAQCAtMTA5Niw3ICsxMDk3LDcgQEAgc3RhdGljIGlu
dCBzcGlfbm9yX2lzX2xvY2tlZChzdHJ1Y3QgbXRkX2luZm8gKm10ZCwNCj4gbG9mZl90IG9mcywg
dWludDY0X3QgbGVuKQ0KPiA+ICAJeyAibXg2NmwxZzQ1ZyIsICBJTkZPKDB4YzIyMDFiLCAwLCA2
NCAqIDEwMjQsIDIwNDgsIFNFQ1RfNEsgfA0KPiBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1Jf
UVVBRF9SRUFEKSB9LA0KPiA+ICAJeyAibXg2NmwxZzU1ZyIsICBJTkZPKDB4YzIyNjFiLCAwLCA2
NCAqIDEwMjQsIDIwNDgsDQo+ID4gU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+ID4NCj4gPiAtCS8q
IE1pY3JvbiAqLw0KPiA+ICsJLyogTWljcm9uIDwtLT4gU1QgTWljcm8gKi8NCj4gPiAgCXsgIm4y
NXEwMTZhIiwJIElORk8oMHgyMGJiMTUsIDAsIDY0ICogMTAyNCwgICAzMiwgU0VDVF80SyB8DQo+
IFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPiA+ICAJeyAibjI1cTAzMiIsCSBJTkZPKDB4MjBiYTE2
LCAwLCA2NCAqIDEwMjQsICAgNjQsDQo+IFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPiA+ICAJeyAi
bjI1cTAzMmEiLAkgSU5GTygweDIwYmIxNiwgMCwgNjQgKiAxMDI0LCAgIDY0LA0KPiBTUElfTk9S
X1FVQURfUkVBRCkgfSwNCj4gPiBAQCAtMjUwMiw2ICsyNTAzLDcgQEAgc3RhdGljIGludCBzcGlf
bm9yX2luaXRfcGFyYW1zKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+ID4gIAkJCXBhcmFtcy0+cXVh
ZF9lbmFibGUgPSBtYWNyb25peF9xdWFkX2VuYWJsZTsNCj4gPiAgCQkJYnJlYWs7DQo+ID4NCj4g
PiArCQljYXNlIFNOT1JfTUZSX1NUOg0KPiA+ICAJCWNhc2UgU05PUl9NRlJfTUlDUk9OOg0KPiA+
ICAJCQlicmVhazsNCj4gPg0KPiA+IEBAIC0yODc2LDggKzI4NzgsOSBAQCBpbnQgc3BpX25vcl9z
Y2FuKHN0cnVjdCBzcGlfbm9yICpub3IsIGNvbnN0IGNoYXINCj4gKm5hbWUsDQo+ID4gIAltdGQt
Pl9yZXN1bWUgPSBzcGlfbm9yX3Jlc3VtZTsNCj4gPg0KPiA+ICAJLyogTk9SIHByb3RlY3Rpb24g
c3VwcG9ydCBmb3IgU1RtaWNyby9NaWNyb24gY2hpcHMgYW5kIHNpbWlsYXIgKi8NCj4gPiAtCWlm
IChKRURFQ19NRlIoaW5mbykgPT0gU05PUl9NRlJfTUlDUk9OIHx8DQo+ID4gLQkJCWluZm8tPmZs
YWdzICYgU1BJX05PUl9IQVNfTE9DSykgew0KPiA+ICsJaWYgKEpFREVDX01GUihpbmZvKSA9PSBT
Tk9SX01GUl9TVCB8fA0KPiA+ICsJICAgIEpFREVDX01GUihpbmZvKSA9PSBTTk9SX01GUl9NSUNS
T04gfHwNCj4gPiArCSAgICBpbmZvLT5mbGFncyAmIFNQSV9OT1JfSEFTX0xPQ0spIHsNCj4gPiAg
CQlub3ItPmZsYXNoX2xvY2sgPSBzdG1fbG9jazsNCj4gPiAgCQlub3ItPmZsYXNoX3VubG9jayA9
IHN0bV91bmxvY2s7DQo+ID4gIAkJbm9yLT5mbGFzaF9pc19sb2NrZWQgPSBzdG1faXNfbG9ja2Vk
OyBkaWZmIC0tZ2l0DQo+ID4gYS9pbmNsdWRlL2xpbnV4L210ZC9jZmkuaCBiL2luY2x1ZGUvbGlu
dXgvbXRkL2NmaS5oIGluZGV4DQo+ID4gOWI1N2E5Yi4uY2JmNzcxNiAxMDA2NDQNCj4gPiAtLS0g
YS9pbmNsdWRlL2xpbnV4L210ZC9jZmkuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbXRkL2Nm
aS5oDQo+ID4gQEAgLTM3Nyw2ICszNzcsNyBAQCBzdHJ1Y3QgY2ZpX2ZpeHVwIHsNCj4gPiAgI2Rl
ZmluZSBDRklfTUZSX1NIQVJQCQkweDAwQjANCj4gPiAgI2RlZmluZSBDRklfTUZSX1NTVAkJMHgw
MEJGDQo+ID4gICNkZWZpbmUgQ0ZJX01GUl9TVAkJMHgwMDIwIC8qIFNUTWljcm9lbGVjdHJvbmlj
cyAqLw0KPiA+ICsjZGVmaW5lIENGSV9NRlJfTUlDUk9OCQkweDAwMkMgLyogTWljcm9uICovDQo+
IA0KPiBDYW4geW91IHBvaW50IHVzIHRvIGEgZGF0YXNoZWV0IHRvIHZlcmlmeSB0aGUgaWQ/DQo+
IA0KDQpDdXJyZW50bHkgZGF0YSBzaGVldCBvZiB0aGlzIGZsYXNoIGlzIHVuZGVyIE5EQSwgSSBo
YXZlIGFza2VkIE1pY3JvbiBndXlzIHRvIHByb3ZpZGUgdGhlIHB1YmxpYyBsaW5rIG9mIHRoaXMg
ZGF0YSBzaGVldC4NCg0KLS0NClJlZ2FyZHMNCllvZ2VzaCBHYXVyLg0KDQo+IEJlc3QsDQo+IHRh
DQo+IA0KPiA+ICAjZGVmaW5lIENGSV9NRlJfVE9TSElCQQkJMHgwMDk4DQo+ID4gICNkZWZpbmUg
Q0ZJX01GUl9XSU5CT05ECQkweDAwREENCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L210ZC9zcGktbm9yLmggYi9pbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmgNCj4gPiBpbmRl
eCBjOTIyZTk3Li5mNDNiZmM1IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbXRkL3Nw
aS1ub3IuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaA0KPiA+IEBAIC0y
Myw3ICsyMyw4IEBADQo+ID4gICNkZWZpbmUgU05PUl9NRlJfQVRNRUwJCUNGSV9NRlJfQVRNRUwN
Cj4gPiAgI2RlZmluZSBTTk9SX01GUl9HSUdBREVWSUNFCTB4YzgNCj4gPiAgI2RlZmluZSBTTk9S
X01GUl9JTlRFTAkJQ0ZJX01GUl9JTlRFTA0KPiA+IC0jZGVmaW5lIFNOT1JfTUZSX01JQ1JPTgkJ
Q0ZJX01GUl9TVCAvKiBTVCBNaWNybyA8LS0+IE1pY3Jvbg0KPiAqLw0KPiA+ICsjZGVmaW5lIFNO
T1JfTUZSX1NUCQlDRklfTUZSX1NUCS8qIFNUIE1pY3JvICovDQo+ID4gKyNkZWZpbmUgU05PUl9N
RlJfTUlDUk9OCQlDRklfTUZSX01JQ1JPTgkvKiBNaWNyb24gKi8NCj4gPiAgI2RlZmluZSBTTk9S
X01GUl9NQUNST05JWAlDRklfTUZSX01BQ1JPTklYDQo+ID4gICNkZWZpbmUgU05PUl9NRlJfU1BB
TlNJT04JQ0ZJX01GUl9BTUQNCj4gPiAgI2RlZmluZSBTTk9SX01GUl9TU1QJCUNGSV9NRlJfU1NU
DQo+ID4NCg==
