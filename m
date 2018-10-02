Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501C1C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B67206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OTzfv2SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B67206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbeJBU0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:26:11 -0400
Received: from mail-eopbgr10075.outbound.protection.outlook.com ([40.107.1.75]:64736
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730957AbeJBU0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPkBVNJ2HfOGIgOMHIY7qBsxiEtGcZJD3Htyp8X9zq4=;
 b=OTzfv2SINVLIuoqCcq5BGFdysQaWRnxtLc/GaHmC05jqKVhyHXJnFSIFNd7BWOgqTYGfOw9C08/MkHBwziyHSKGrwQrvPLZ0CAaLcC7fcqPhejbx/zH772lXluqnJ7ssRHMVteflGCB/60ah8L5Gy0LmmdlV7/3KDa3B6P6O4Xs=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4163.eurprd04.prod.outlook.com (52.134.125.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Tue, 2 Oct 2018 13:42:38 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 13:42:38 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Andy Duan <fugang.duan@nxp.com>
CC:     "anders.roxell@linaro.org" <anders.roxell@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH] regulator: fixed: Default enable high on DT regulators
Thread-Topic: [PATCH] regulator: fixed: Default enable high on DT regulators
Thread-Index: AQHUWcd49bv0W/6vgk+3Fmf6b/rzB6UL9/8A
Date:   Tue, 2 Oct 2018 13:42:38 +0000
Message-ID: <28e88d54f6503cf1be577eb1872cdf2c50d7dfa3.camel@nxp.com>
References: <20181001204346.4655-1-linus.walleij@linaro.org>
In-Reply-To: <20181001204346.4655-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4163;6:Bl5rbtSc1AUhowuyW6CouyTz2W6nWjT7aThVvU8cBbgkwbvb/FDmsOgk03s2lVraqcC7rUJYCGBaISn6TdWXe4jXUus6oA85X2HTUq1Sbiwaqx7rsTVzCqaeNjEaNB4GwenSYmRTYGCaaaZpzyBFeu9OM0FupIVef+H9ed53EbomMfqEHdTn9rk0mvHCHCLbteqRffKRFsHGPXLp2/a8gNn+4Xqouw1eeQx/3Oei749Myq19E1cbDvHJU2HNNr/kHiLgOFuCqeFRYiAYiYZa4nLctzkmuT839LVKtth0rUXh8AXvYse2fyD6gN8AkmeZMVLc6j1aTeOj0AwUfiyy21lN7elt8TKcNX8ft/Hxhq4x12dEjf5OS4gVnSnz5bJ0bfk+S98enuhbugwIH72CpzG/rLqaEsN6jgkzUqYfLfhKuNoj7BSuYukxNafOAoK9fwVitzkuaU5oUaPJuVO/lg==;5:7Z3y3geQrBdoWJBnDnOmMYzSz0GwE8GSwKAjrHxbLY9EKodS+LwTCtYNr8rjcP9cd9jotvbZXJzryHsTQahjpN2qIm4I9c22Nf6yGBrVx1r/E1/N20Q5QFrD1BL2bz9XvzQk6ydZo+ap4SVMOlEVt1VXVE+AqT3ew2wfFHaU48c=;7:uEQ30hlPVZ4CEgrUSXAevs+rjJTZZDWdkKTb7fyQfETz4XB8VQ1+Ax4j+I/mtBoWvWdEVjBwo2Txz1kjdYG43M5NvOHOpxa9wUY4MS90RkTYmfaEkYOGP4HoWI1G21qunXW6ll/kHP0oG3akJHldk2+Iyd85rXpK7QEOKuAbMVqZSCbLKtIlY5WFbNurBK+Lmu2eMAAIEh9UnNDxU9xgNkwDxHkeBaFU7O6F0/5GddK00d8thOm6LqLoETt6234f
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 40c86273-bfe9-4426-1664-08d6286ceb2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4163;
x-ms-traffictypediagnostic: AM0PR04MB4163:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB41631506A056FF880BBBD7AAEEE80@AM0PR04MB4163.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(21532816269658)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:AM0PR04MB4163;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4163;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(50226002)(110136005)(66066001)(2616005)(476003)(6512007)(316002)(486006)(8676002)(81166006)(81156014)(8936002)(86362001)(53936002)(25786009)(118296001)(39060400002)(105586002)(2900100001)(106356001)(4326008)(3846002)(6116002)(6486002)(71200400001)(71190400001)(68736007)(102836004)(6246003)(186003)(229853002)(478600001)(2906002)(6506007)(26005)(2501003)(6436002)(5250100002)(14444005)(256004)(6636002)(7736002)(54906003)(97736004)(305945005)(99286004)(5660300001)(11346002)(446003)(36756003)(44832011)(76176011)(14454004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4163;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OuYSf22yBvQLbaIwzl0WG6ldp6dVj//RK51I5i39iTIotwNnrU1+J0hsRu8zDWCvGs0nPlBz8m9R7xyPMri7sPVSu8/d/4w+/wAFQc+kqpXWlMkuy++tdDUKbupZXo4MgxxCSqdik0s20mAOQyDJ7MP/2H0jwSkqr8vqmS2oXklV3xQF630jL/5MeVb5Pzw2uOn1fd1ZtKKraZk+vsJ+qNCND444r3TXSVFlbQ4y5KdK3L9fOyuWNHyxG8wzMdyQFhiDuyGTLZ4bX1TFQr5Pp8o5OyA0EoFCm+slx52Rr/5hij3wHc7XJuZ+SvHFT9dra3wFOdq9fdeXsDGmh8zqeGXdB/OMa6TvL7KVRE9SJxc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C64D050B69D1847AA4C101B074D9A44@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c86273-bfe9-4426-1664-08d6286ceb2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 13:42:38.5868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTEwLTAxIGF0IDIyOjQzICswMjAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBjb21taXQgZWZkZmViMDc5Y2MzDQo+ICgicmVndWxhdG9yOiBmaXhlZDogQ29udmVydCB0byB1
c2UgR1BJTyBkZXNjcmlwdG9yIG9ubHkiKQ0KPiBzd2l0Y2hlZCB0byB1c2UgZ3Bpb2RfZ2V0KCkg
dG8gbG9vayB1cCB0aGUgcmVndWxhdG9yIGZyb20gdGhlDQo+IGdwaW9saWIgY29yZSB3aGV0aGVy
IHRoYXQgaXMgZGV2aWNlIHRyZWUgb3IgYm9hcmRmaWxlLg0KPiANCj4gVGhpcyBtZWFudCB0aGF0
IHdlIGFjdGl2YXRlIHRoZSBjb2RlIGluDQo+IGE2MDNhMmI4ZDg2ZSAoImdwaW86IG9mOiBBZGQg
c3BlY2lhbCBxdWlyayB0byBwYXJzZSByZWd1bGF0b3IgZmxhZ3MiKQ0KPiB3aGljaCBtZWFucyB0
aGUgZGVzY3JpcHRvcnMgY29taW5nIGZyb20gdGhlIGRldmljZSB0cmVlIGFscmVhZHkNCj4gaGF2
ZSB0aGUgcmlnaHQgaW52ZXJzaW9uIGFuZCBvcGVuIGRyYWluIHNlbWFudGljcyBzZXQgdXAgZnJv
bQ0KPiB0aGUgZ3Bpb2xpYiBjb3JlLg0KPiANCj4gQXMgdGhlIGZpeGVkIHJlZ3VsYXRvciB3YXMg
aW5zcGVjdGVkIGFnYWluIHdlIGdvdCB0aGUNCj4gaW52ZXJ0ZWQgaW52ZXJzaW9uIGFuZCB0aGlu
Z3MgYnJva2UuDQo+IA0KPiBGaXggaXQgYnkgaWdub3JpbmcgdGhlIGNvbmZpZyBpbiB0aGUgZGV2
aWNlIHRyZWUgZm9yIG5vdzogdGhlDQo+IGxhdGVyIHBhdGNoZXMgaW4gdGhlIHNlcmllcyB3aWxs
IHB1c2ggYWxsIGludmVyc2lvbiBoYW5kbGluZw0KPiBvdmVyIHRvIHRoZSBncGlvbGliIGNvcmUg
YW5kIHNldCBpdCB1cCBwcm9wZXJseSBpbiB0aGUNCj4gYm9hcmRmaWxlcyBmb3IgbGVnYWN5IGRl
dmljZXMsIGJ1dCBJIGRpZCBub3QgZmluaXNoIHRoYXQNCj4gZm9yIHRoaXMga2VybmVsIGN5Y2xl
Lg0KPiANCj4gRml4ZXM6IGNvbW1pdCBlZmRmZWIwNzljYzMgKCJyZWd1bGF0b3I6IGZpeGVkOiBD
b252ZXJ0IHRvIHVzZSBHUElPIGRlc2NyaXB0b3Igb25seSIpDQo+IFJlcG9ydGVkLWJ5OiBMZW9u
YXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiBSZXBvcnRlZC1ieTogRmFi
aW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBSZXBvcnRlZC1ieTogSm9obiBTdHVs
dHogPGpvaG4uc3R1bHR6QGxpbmFyby5vcmc+DQo+IFJlcG9ydGVkLWJ5OiBBbmRlcnMgUm94ZWxs
IDxhbmRlcnMucm94ZWxsQGxpbmFyby5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IExpbnVzIFdhbGxl
aWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCg0KVGhpcyBkb2Vzbid0IHdvcmsgZm9yIGlt
eDZzeC1zZGIgYnV0IEkgc3VzcGVjdCBhbiBpbXggaXNzdWUuIExvZzoNCg0KWyAgICAwLjE1MDE5
OF0gcmVndWxhdG9yLWVuZXQtM3YzIEdQSU8gaGFuZGxlIHNwZWNpZmllcyBhY3RpdmUgbG93IC0g
aWdub3JlZA0KWyAgICAwLjE1MDI1OF0gZ3Bpb192YWx1ZTogMzggc2V0IDENClsgICAgMC4xNTAy
ODNdIGdwaW9fZGlyZWN0aW9uOiAzOCBvdXQgKDApDQouLi4NClsgICAgMS45NjI0OTNdIHJlZ3Vs
YXRvcl9lbmFibGU6IG5hbWU9ZW5ldF8zdjMNClsgICAgMS45NjY3MDldIGdwaW9fdmFsdWU6IDM4
IHNldCAwDQpbICAgIDEuOTcwMDA1XSByZWd1bGF0b3JfZW5hYmxlX2RlbGF5OiBuYW1lPWVuZXRf
M3YzDQpbICAgIDEuOTc0NzMwXSByZWd1bGF0b3JfZW5hYmxlX2NvbXBsZXRlOiBuYW1lPWVuZXRf
M3YzDQouLi4NClsgICAgNC4wOTcwNzddIGZlYyAyMTg4MDAwLmV0aGVybmV0IGV0aDA6IFVuYWJs
ZSB0byBjb25uZWN0IHRvIHBoeQ0KWyAgICA0LjEwOTIxOV0gSVAtQ29uZmlnOiBGYWlsZWQgdG8g
b3BlbiBldGgwDQpbICAgIDQuMTE1NTU3XSBmZWMgMjFiNDAwMC5ldGhlcm5ldCBldGgxOiBVbmFi
bGUgdG8gY29ubmVjdCB0byBwaHkNClsgICAgNC4xMjM2OTBdIElQLUNvbmZpZzogRmFpbGVkIHRv
IG9wZW4gZXRoMQ0KDQpUaGlzIHR1cm5zIHRoZSBwaHkgb2ZmIGFuZCBvbiBhZ2FpbiBpbnN0ZWFk
IG9mIGxlYXZpbmcgaXQgdXAgZnJvbSB1Ym9vdA0KYW5kIGl0IGRvZXNuJ3Qgd29yayBmb3Igc29t
ZSByZWFzb24uIEhvd2V2ZXIgbG9va2luZyBhdA0KcmVnX2ZpeGVkX3ZvbHRhZ2VfcHJvYmUgaW50
cm9kdWNpbmcgYW4gZWRnZSBzZWVtcyB0byBiZSBpbnRlbnRpb25hbCBmb3INCnJlZ3VsYXRvcnMg
d2hpY2ggYXJlIG5vdCBtYXJrZWQgd2l0aCAiZW5hYmxlZC1hdC1ib290Ii4gUmlnaHQ/DQoNCkl0
J3MgcG9zc2libGUgdGhhdCB5b3UgZXhwb3NlZCBhbiBpbXggYm9hcmQtc3BlY2lmaWMgYnVnOiBt
YXliZSBwb3dlcg0KY3ljbGluZyB0aGUgcGh5IGFmdGVyIHVib290IG5lZWRzIHNvbWUgbWlzc2lu
ZyBmaXh1cD8NCg0KQXBwYXJlbnRseSBpZiBJIHJldmVydCB5b3VyIHBhdGNoIHRoZSBvbGQgYmVo
YXZpb3IgaXMgdG8gbmV2ZXIgdG91Y2gNCnRoaXMgR1BJTy4gSSBzcGVudCBhIHdoaWxlIGRlYnVn
Z2luZyB0aGlzIGFuZCB0aGUgY2F1c2Ugc2VlbXMgdG8gYmUNCnRoYXQgdGhpcyByZWd1bGF0b3Ig
aGFzIHRoZSAiZ3Bpb3MiIHByb3BlcnR5IGluc3RlYWQgb2YgImdwaW8iLg0KDQpUaGUgImdwaW9z
IiBwcm9wZXJ0eSBpcyBub3QgYWN0dWFsbHkgaGFuZGxlZCBieSBvbGQgcmVndWxhdG9yLWZpeGVk
DQpvZl9nZXRfbmFtZWRfZ3BpbyhucCwgImdwaW8iLCAwKSBjYWxsIGJ1dCBvbmx5IGJ5IHRoZSBu
ZXcgcGF0aCBnb2luZw0KdGhyb3VnaCBvZl9maW5kX2dwaW8uDQoNCkkgY2FuIGFsc28gYnJlYWsg
Ym9vdCBieSBmaXhpbmcgdGhlIGdwaW9zIHByb3BlcnR5IG9uIHN0YWJsZSA0LjE4Og0KDQogICAg
ICAgIHJlZ19lbmV0XzN2MzogcmVndWxhdG9yLWVuZXQtM3YzIHsNCiAgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQogICAgICAgICAgICAgICAgcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IjsNCiAgICAgICAgICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxf
ZW5ldF8zdjM+Ow0KICAgICAgICAgICAgICAgIHJlZ3VsYXRvci1uYW1lID0gImVuZXRfM3YzIjsN
CiAgICAgICAgICAgICAgICByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCiAg
ICAgICAgICAgICAgICByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCi0gICAg
ICAgICAgICAgICBncGlvcyA9IDwmZ3BpbzIgNiBHUElPX0FDVElWRV9MT1c+Ow0KKyAgICAgICAg
ICAgICAgIGdwaW8gPSA8JmdwaW8yIDYgR1BJT19BQ1RJVkVfTE9XPjsNCiAgICAgICAgfTsNCg0K
QW55IHN1Z2dlc3Rpb25zPyBUaGlzIHR1cm5lZCBvdXQgdG8gYmUgcXVpdGUgbWVzc3kuDQoNCi0t
DQpSZWdhcmRzLA0KTGVvbmFyZA0K
