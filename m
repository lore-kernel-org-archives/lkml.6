Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EABC28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADB92098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cqoq1xot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADB92098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeJLJyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 05:54:15 -0400
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:51456
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbeJLJyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 05:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YCgQrV8od5gugzxd3CSZLTvkAvdqVB9p+5xblVju5g=;
 b=Cqoq1xotVrZOOKTkc6gY+8NPAcDYrEzq1gUddZZJKXRerJs0GC0ap6baUIPmgCw6FCwKBDXMykJyd2aRp8HzVytbaVqvcFA35JOMv53KQ1dGVGLX/wn+CNFnItwPoKNzcVkyp/F4aULPuvPSx7AHNcwAqq4Ru3HkURiZP61nd0Y=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1166.eurprd04.prod.outlook.com (10.162.121.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Fri, 12 Oct 2018 02:24:07 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Fri, 12 Oct 2018
 02:24:07 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] mtd: spi-nor: add entry for mt35xu512aba flash
Thread-Topic: [PATCH v2 2/2] mtd: spi-nor: add entry for mt35xu512aba flash
Thread-Index: AQHUYTqbs6sSLLIYmE2VBnAqytu3EaUaNVmAgACtNZA=
Date:   Fri, 12 Oct 2018 02:24:06 +0000
Message-ID: <VI1PR04MB10387F73D1F4550ACC8B8CBD99E20@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1539245630-26611-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1539245630-26611-3-git-send-email-yogeshnarayan.gaur@nxp.com>
 <d390e12b-94e3-ab5a-3b7e-05381c090724@microchip.com>
In-Reply-To: <d390e12b-94e3-ab5a-3b7e-05381c090724@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [112.196.150.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1166;6:asmE7maG60uKXxHmxohnQ+lyljsnXLpM6jP1izMSMtlZE0LkR1sH9FyQ283Yc+M3jvyStKsMOG/hZMTN65JvaNntzh/ys4vgVW/XsprIF3t8TDI/kEuodmqjSIvK7OnjBuhLqmm/7xo7Rr/RiXB3pA+xg8jyzEOwUdxdcu6iXhFDOUxF6VkGJ2htvV/4GqLlbuBjTR5r2yYXPCEifF0U4+aKROvFtZrLFbNYBiFch2SIpTOLtktPan0LbldDn9TFxsfKJ0JoGMvpikYrKU26+40xIw6XrNpO8naWQrOyCur4XsrdK7DHKxaw/Bi5vXtH0xlhRpJfRrz6a4rw+/NA7lhNcUE1MoxVui3iz4T2Oq7fNUYOUE8FvU4KgWRf1ftuyE92tDzymy5AlfM2xFjhI2ydI2or/MwqEtMNF3EO1aICjx0d+yKhzXKiDVR81ZfwxMlaL5CFWBts2uR9C6naIQ==;5:z9tHGA4dT0CuIvhhvGHNT88txaC5FnbqxskCodzvpZ8ZS0pQAUvO+EZDeDoUHPkz1uQqnzeNioBoLuGO4mEXcCUnwOw09hy292cOvD8jR7PirFuJAORNQE7bFWauocrMDAhcmRddCFfniF4gAYYNrlYTrcpYQbHU+sk0Cu5I3UA=;7:ZKaqJNb6BDazWkes7wCzAuM0yVhWUyJPjiID79/gtda7El34z/EtW7t9+ZVQxXITc2i6HtG4srPvLoJ82KW/Yae3m4RKd9ybKHWeSXCXuN7LCxWDVnKJyutjDgXsebl1+2XfEcEY+NBGjEDTp/ZibAXseE9L4wwg5aZGqJ/nxRRzQGS1UIAs3NyCVyw51EtZ/1Am6cqlwgVBlhmL8Dej171riUxLqNbq2ydIqucHoGEofrrcj9SNnliqLqxFG2NU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2c51b5bf-8a18-48d4-d2ad-08d62fe9c946
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1166;
x-ms-traffictypediagnostic: VI1PR04MB1166:
x-microsoft-antispam-prvs: <VI1PR04MB1166C79A3B00568BA2454C3499E20@VI1PR04MB1166.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(85827821059158)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB1166;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1166;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(13464003)(199004)(189003)(446003)(6506007)(486006)(53546011)(4326008)(53936002)(7696005)(11346002)(476003)(6436002)(25786009)(110136005)(54906003)(102836004)(99286004)(9686003)(55016002)(33656002)(316002)(76176011)(66066001)(3846002)(2906002)(6116002)(97736004)(5660300001)(575784001)(86362001)(2201001)(2900100001)(229853002)(5250100002)(2501003)(39060400002)(68736007)(305945005)(26005)(14454004)(81166006)(81156014)(256004)(8676002)(14444005)(8936002)(478600001)(71200400001)(6246003)(186003)(7736002)(106356001)(105586002)(74316002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1166;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pOpzYk6fhfXpnSn0vLTwzmppotO7km/V7oetKKFeGB+mr3Z4bQOA5Q7xv+hMb5s644SP0cJpUJ1uPKqhYUj1nXBQVPQcX/T4QD0nbRg8KKau40iXdrqd1En38z6PjJ85PvI/PBXhsKnmO4Emy5MTvuiGLOExI6WddrirMFywy8HUh4y7Hyn/3g//kXloAWCa5XgMv0zOtfe80OlI5wYQrr4Y3wqoCTBL15I6IGia1NfygNRpv3ln8eUtpQpHG54MKPy1uuc3rXEuL7V2GBWJvMTXFj9I7xv1Rzgh6Tx5O55CUWoS8xLTFhOfX7FCwuLRb6fcz5q62/YyBCqv3Q6NOPJCXEy+getfdVI5+O+tKpE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c51b5bf-8a18-48d4-d2ad-08d62fe9c946
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 02:24:06.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3Ig
QW1iYXJ1cyBbbWFpbHRvOnR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbV0NCj4gU2VudDogVGh1
cnNkYXksIE9jdG9iZXIgMTEsIDIwMTggOTozMyBQTQ0KPiBUbzogWW9nZXNoIE5hcmF5YW4gR2F1
ciA8eW9nZXNobmFyYXlhbi5nYXVyQG54cC5jb20+OyBsaW51eC0NCj4gbXRkQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IG1hcmVrLnZhc3V0QGdt
YWlsLmNvbTsgY3lyaWxsZS5waXRjaGVuQHdlZGV2NHUuZnI7DQo+IGJvcmlzLmJyZXppbGxvbkBi
b290bGluLmNvbTsgY29tcHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tOw0KPiBmcmllZGVyLnNjaHJl
bXBmQGV4Y2VldC5kZTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyIDIvMl0gbXRkOiBzcGktbm9yOiBhZGQgZW50cnkgZm9yIG10MzV4dTUxMmFi
YSBmbGFzaA0KPiANCj4gDQo+IA0KPiBPbiAxMC8xMS8yMDE4IDExOjE1IEFNLCBZb2dlc2ggTmFy
YXlhbiBHYXVyIHdyb3RlOg0KPiA+IEFkZCBlbnRyeSBmb3IgbXQzNXh1NTEyYWJhIE1pY3JvbiBO
T1IgZmxhc2guDQo+ID4gVGhpcyBmbGFzaCBpcyBoYXZpbmcgdW5pZm9ybSBzZWN0b3IgZXJhc2Ug
c2l6ZSBvZiAxMjhLQiwgaGF2ZSBzdXBwb3J0DQo+ID4gb2YgRlNSKGZsYWcgc3RhdHVzIHJlZ2lz
dGVyKSwgZmxhc2ggc2l6ZSBpcyA2NE1CIGFuZCBzdXBwb3J0cyA0LWJ5dGUNCj4gPiBjb21tYW5k
cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdh
dXJAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGZvciB2MjoNCj4gPiAtIFJlbW92ZWQg
Y2hlY2twYXRjaCB3YXJuaW5nLCA4MCBjaGFyYWN0ZXIgbGltaXQuDQo+ID4NCj4gPiAgZHJpdmVy
cy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
c3BpLW5vci5jDQo+ID4gYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBpbmRleCBiOGI0
OTRmLi5lMGQ5NWFjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5v
ci5jDQo+ID4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gPiBAQCAtMTQw
NSw2ICsxNDA1LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBzcGlfbm9yX2lk
c1tdID0gew0KPiA+ICAJeyAibjI1cTAwYSIsICAgICBJTkZPKDB4MjBiYjIxLCAwLCA2NCAqIDEw
MjQsIDIwNDgsIFNFQ1RfNEsgfCBVU0VfRlNSDQo+IHwgU1BJX05PUl9RVUFEX1JFQUQgfCBOT19D
SElQX0VSQVNFKSB9LA0KPiA+ICAJeyAibXQyNXF1MDJnIiwgICBJTkZPKDB4MjBiYjIyLCAwLCA2
NCAqIDEwMjQsIDQwOTYsIFNFQ1RfNEsgfA0KPiBVU0VfRlNSIHwgU1BJX05PUl9RVUFEX1JFQUQg
fCBOT19DSElQX0VSQVNFKSB9LA0KPiA+DQo+ID4gKwkvKiBNaWNyb24gKi8NCj4gPiArCXsgIm10
MzV4dTUxMmFiYSIsIElORk8oMHgyYzViMWEsIDAsIDEyOCAqIDEwMjQsIDUxMiwNCj4gPiArCQlT
RUNUXzRLIHwgVVNFX0ZTUiB8IFNQSV9OT1JfNEJfT1BDT0RFUykgfSwNCj4gPiArDQo+IA0KPiBU
aGUgc3R5bGUgaXMgc2xpZ2h0bHkgZGlmZmVyZW50IGZyb20gd2hhdCBCcmlhbiBwcm9wb3NlZCBi
YWNrIGluDQo+IDk2NDgzODhmYzc3MzczNjViZTdhODA5MmU3N2RmNzhjY2MyY2QxYTQuIEZvciBj
b25zaXN0ZW5jeSByZWFzb25zLCBJIHRoaW5rDQo+IHdlIHNob3VsZCB1c2UgdGhlIHNhbWUgc3R5
bGUgaW4gYWxsIGVudHJpZXMuDQo+IA0KDQpPaywgSSBoYXZlIHNlbmQgdGhlIG5leHQgdmVyc2lv
biBvZiB0aGUgcGF0Y2hlcyB3aXRoIHRoZSBzdHlsZSBjaGFuZ2VzIGFzIHByb3Bvc2VkIGJ5IEJy
aWFuLg0KDQotLQ0KUmVnYXJkcw0KWW9nZXNoIEdhdXIuDQoNCj4gU2luY2UgSSB2ZXJpZmllZCB0
aGUgY29ycmVjdG5lc3Mgb2YgdGhlIHBhdGNoIGFuZCBteSBjb21tZW50IHRhcmdldHMganVzdCBh
DQo+IGNvc21ldGljIGNoYW5nZSwgSSdsbCBsZXQgdGhlIG1haW50YWluZXJzIGRlY2lkZToNCj4g
DQo+IFJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5j
b20+DQo=
