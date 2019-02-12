Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTTP_ESCAPED_HOST,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286A4C4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D42214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hiQPRecF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfBLKok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:44:40 -0500
Received: from mail-eopbgr140059.outbound.protection.outlook.com ([40.107.14.59]:54221
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728184AbfBLKoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nG/cLDkZV2kfQY13aslkSH3iV/oXHjzZsbwNouJakRE=;
 b=hiQPRecFZlIuNpt6tBpzNut9ttSLD6pXF38oGBWfsnHeEk26Q1kbKAxuwicR0F562hXVUABOiVD6VQjb0mMO3Gzzz2smUY4t5XSF812KoKl3/tRL2x5ppHw42Oz3InAQFUhCHo7ldC2dpVvUQwRD4joSYxWP6yRZxyrNIbVuZdM=
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com (20.177.55.216) by
 VI1PR04MB5824.eurprd04.prod.outlook.com (20.178.204.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 12 Feb 2019 10:44:35 +0000
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::b0fe:dee7:b2d3:9355]) by VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::b0fe:dee7:b2d3:9355%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 10:44:35 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/9] device connection: Add support for device graphs
Thread-Topic: [PATCH v2 0/9] device connection: Add support for device graphs
Thread-Index: AQHUuLVJsqWvJprsFUulAzwGV1ziqKXcDa5A
Date:   Tue, 12 Feb 2019 10:44:35 +0000
Message-ID: <VI1PR04MB4558A1B67430533C843EA47D89650@VI1PR04MB4558.eurprd04.prod.outlook.com>
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5824;6:QgLYZ+wHkWY+sZRooTMhU6n8kbUYufiHIjUvIhbZ1DG+LwiA1wgpy1nrgq+gKTyuOzEPrpn1/GjtuEXOu6/DIkf6IRgyucrxICD5imGwjAgSKhRGBjzPPR2llObjqu+ZiOhAmv2OQ6rHUfMq9uHKYkvwU0hSzLS0kioyp1+yS8fJ4cgZsdlfEiwBHuTUhKk8oucx90vWQJO79cOLu3vGGQ0IaLFIUTWLB8nI93Vwf/GmOYun8/fU7onasu7RkUihqjI46wp6A3KDu3yXLZdUijFMKQm6txBkLeZ5urR+Pn71W0wOlORxE6nLG4izPQek5esO3e4HewI9KIEZddDh+pGj/5hzBwZNUhWKNKNffCngGMWasALGMwrg2pyJtdMP8EANm274B+0rgMJJ8I76qvwWNqSvT8D05lPy1aY4nrEM4by7Jq7twfA/8gIaR4JsZyULBmilRjMLpimJrB7QgA==;5:0SAC9DvAmqS9gISasrAydn3fUYj2f5IjEzPPnG7U0zuK/X+5C+8Jls3vDDAQlKe+0S5YuNLbTpVGh6Bv4qhvx5Seh1GKKqni7lxLxebOiEuERTQA2VcLFo2aB8E5PU1P7AYBBOxI9G4nzlxxKvnz4/slugJ+nBTlQKmnxsFALjcsdXlWUHOsN5UID0d0nzi6nTy9HUKqj5VNtMAzeCaSQw==;7:aLTjPkc0hYublZuLtVqS3vUySI659posMz7AiveKVbWwwLULEKRDfhRGvfQSIbG8izHDc1M6PyC1j5F2UFaIkeh5aYV8CjBLk4IXIgZAAaBlzUTjk9Xkc1wt7EfnNKSEtN0/+EJlI3P6ji89XCYYaQ==
x-ms-office365-filtering-correlation-id: 4275039e-942b-4e16-7fc0-08d690d7144b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5824;
x-ms-traffictypediagnostic: VI1PR04MB5824:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB58246032062769DACF3AE17A89650@VI1PR04MB5824.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(199004)(13464003)(189003)(99286004)(74316002)(316002)(81156014)(11346002)(68736007)(8676002)(6436002)(6116002)(3846002)(256004)(81166006)(26005)(446003)(110136005)(6246003)(9686003)(6306002)(53936002)(186003)(14454004)(8936002)(33656002)(305945005)(54906003)(478600001)(45080400002)(7696005)(86362001)(7736002)(106356001)(71190400001)(2906002)(71200400001)(105586002)(229853002)(55016002)(76176011)(25786009)(102836004)(966005)(53546011)(66066001)(4326008)(476003)(486006)(6506007)(44832011)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5824;H:VI1PR04MB4558.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dRVVUkFO7VNgUyfhEWLN8UD+XZRDo/eSvzmV4qcxEtg6l6w8fV0PaSIb4k7KY8iRJ/E8T/Aa5Pu4D0+hMyr0mDN4Q50PMLhi3CNIGORmztjYw6YJrmDDQhT+PyWednmXDddTwrecDCDkQE2ij96e3UtftWe9eDgoOGCzyiND16hAQrwB/Djhd8lsVvZCFM8vMW7YxIUwKW/BfGZgb24L6vdeZYYoL+1ugcmUKumFtHWtRS5X8G8mLMeAZp8NxiY4CZUBusL/7J/XWdQV4WGJYX8234lBmooWojgfSdRrvTcD0pQA1PgcKMyMQ2hfmC0QF0CMV50wFuHgApHNoEzWOsue99HxZELgNDUquoPCZFWisTua8AtzR6pbvSkJQBgx/taARFkqrOcQoFaF6CRULWvNcp7iQVgmTkOLiLQVZ+M=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4275039e-942b-4e16-7fc0-08d690d7144b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 10:44:35.0833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpa2tpIEtyb2dlcnVz
IDxoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiAyMDE5xOox1MIzMcjV
IDA6MDMNCj4gVG86IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+DQo+IENjOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+OyBD
aGVuIFl1DQo+IDxjaGVueXU1NkBodWF3ZWkuY29tPjsgSnVuIExpIDxqdW4ubGlAbnhwLmNvbT47
IEhhbnMgZGUgR29lZGUNCj4gPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBsaW51eC11c2JAdmdlci5r
ZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQ
QVRDSCB2MiAwLzldIGRldmljZSBjb25uZWN0aW9uOiBBZGQgc3VwcG9ydCBmb3IgZGV2aWNlIGdy
YXBocw0KPiANCj4gSGksDQo+IA0KPiBUaGlzIGlzIHRoZSBzZWNvbmQgdmVyc2lvbiBvZiB0aGlz
IHNlcmllcy4gT24gdG9wIHRoZSB0d28gY29kZSBzdHlsZSBpbXByb3ZlbWVudHMNCj4gcmVxdWVz
dGVkIGJ5IEFuZHksIEkgYWxzbyByZW5hbWVkIHRoZSBjb25uZWN0aW9uIGlkZW50aWZpZXJzIHVz
ZWQgd2l0aCB0aGUgVVNCDQo+IFR5cGUtQyBtdXhlcyBmb3Igc29tZXRoaW5nIHRoYXQgSSBmZWx0
IGFyZSBiZXR0ZXIsIGVzcGVjaWFsbHkgYWZ0ZXIgd2Ugc3RhcnQgdXNpbmcNCj4gdGhlbSB0byBu
YW1lIHJlZmVyZW5jZSBkZXZpY2UgcHJvcGVydGllcyBpbiBmd25vZGVzLiBUaGF0J3Mgd2h5IHRo
ZSBmaXJzdCBwYXRjaCBpcw0KPiBub3cgc3BsaXQgaW4gdHdvLCAxLzkgYW5kIDMvOS4NCj4gDQo+
IEhhbnMhIFBsZWFzZSBub3RlIHRoYXQgdGhlcmUgaXMgbm8gZnVuY3Rpb25hbCBjaGFuZ2UuIFRo
ZSBhbHQgbW9kZSBkZXZpY2UgaXMgc3RpbGwNCj4gZ2V0dGluZyBhIGhhbmRsZSB0byB0aGUgbXV4
LCBqdXN0IGxpa2UgYmVmb3JlLg0KPiBUaGF0IHdhcyBhY3R1YWxseSBoYXBwZW5pbmcgYWxzbyBp
biB0aGUgZmlyc3QgdmVyc2lvbiBvZiB0aGUgc2VyaWVzLg0KPiANCj4gVGhlIGNvbW1pdCBtZXNz
YWdlIGZyb20gdjE6DQo+IA0KPiBUaGlzIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIE9GIGFuZCBB
Q1BJIGRldmljZSBncmFwaCBwYXJzaW5nIHRvIHRoZSBkZXZpY2UNCj4gY29ubmVjdGlvbiBBUEku
DQo+IA0KPiBIYW5kbGluZyB0aGUgZ3JhcGggaXMgc3RyYWlnaHRmb3J3YXJkLCBidXQgYmVjYXVz
ZSBJJ20gYWRkaW5nIHRoYXQgZndub2RlIG1lbWJlcg0KPiB0byBzdHJ1Y3QgZGV2aWNlX2Nvbm5l
Y3Rpb24sIEkgaGFkIHRvIG1ha2Ugc3VyZSBhbGwgdGhlIGV4aXN0aW5nIHVzZXJzIGNvbnNpZGVy
IGl0Lg0KPiANCj4gVGhlIHBsYW4gaXMgdG8gb25seSBzdXBwb3J0IG1hdGNoaW5nIHdpdGggZndu
b2RlIGluIHRoZSBmdXR1cmUsIHNvIG5vIG1vcmUgZGV2aWNlDQo+IG5hbWUgbWF0Y2hpbmcuIFRo
ZSBzb2Z0d2FyZSBmd25vZGVzIHRoYXQgd2Ugbm93IGhhdmUgaW4ga2VybmVsIHNob3VsZCBtYWtl
IHRoYXQNCj4gcG9zc2libGUsIG9uY2Ugd2UgYWRkIHN1cHBvcnQgZm9yIHJlZmVyZW5jZXMgdG8g
dGhlbS4NCj4gDQo+IFRoZSBvcmlnaW5hbCBSRkM6DQo+IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsa21sLm9yZyUNCj4g
MkZsa21sJTJGMjAxOCUyRjEwJTJGMjQlMkY2MTkmYW1wO2RhdGE9MDIlN0MwMSU3Q2p1bi5saSU0
MG54cC5jbw0KPiBtJTdDMmZkN2M4YzI4ZDY3NDM0MzU0YmUwOGQ2ODZjYzZiNTUlN0M2ODZlYTFk
M2JjMmI0YzZmYTkyY2Q5OWM1Yw0KPiAzMDE2MzUlN0MwJTdDMCU3QzYzNjg0NDYwOTg1ODg0NjE2
NyZhbXA7c2RhdGE9QVdERDlXYU8lMkJYeE0NCj4gSXpsbGk2R1VORXElMkZxVXBhNWhTeUxiQnNq
SUNkTElvJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBIZWlra2kgS3Jv
Z2VydXMgKDkpOg0KPiAgIHBsYXRmb3JtL3g4NjogaW50ZWxfY2h0X2ludDMzZmU6IFByZXBhcmUg
Zm9yIGJldHRlciBtdXggbmFtaW5nIHNjaGVtZQ0KPiAgIHVzYjogdHlwZWM6IFJhdGlvbmFsaXpl
IHRoZSBBUEkgZm9yIHRoZSBtdXhlcw0KPiAgIHBsYXRmb3JtL3g4NjogaW50ZWxfY2h0X2ludDMz
ZmU6IFJlbW92ZSBvbGQgc3R5bGUgbXV4IGNvbm5lY3Rpb25zDQo+ICAgZGV2aWNlIGNvbm5lY3Rp
b246IEFkZCBmd25vZGUgbWVtYmVyIHRvIHN0cnVjdCBkZXZpY2VfY29ubmVjdGlvbg0KPiAgIHVz
YjogdHlwZWM6IG11eDogRmluZCB0aGUgbXV4ZXMgYnkgYWxzbyBtYXRjaGluZyBhZ2FpbnN0IHRo
ZSBkZXZpY2UNCj4gICAgIG5vZGUNCj4gICB1c2I6IHJvbGVzOiBGaW5kIHRoZSBtdXhlcyBieSBh
bHNvIG1hdGNoaW5nIGFnYWluc3QgdGhlIGRldmljZSBub2RlDQo+ICAgdXNiOiB0eXBlYzogRmlu
ZCB0aGUgcG9ydHMgYnkgYWxzbyBtYXRjaGluZyBhZ2FpbnN0IHRoZSBkZXZpY2Ugbm9kZQ0KPiAg
IGRldmljZSBjb25uZWN0aW9uOiBQcmVwYXJlIHN1cHBvcnQgZm9yIGZpcm13YXJlIGRlc2NyaWJl
ZCBjb25uZWN0aW9ucw0KPiAgIGRldmljZSBjb25uZWN0aW9uOiBGaW5kIGRldmljZSBjb25uZWN0
aW9ucyBhbHNvIGZyb20gZGV2aWNlIGdyYXBocw0KPiANCj4gIGRyaXZlcnMvYmFzZS9kZXZjb24u
YyAgICAgICAgICAgICAgICAgICAgfCA2MiArKysrKysrKysrKysrKy0NCj4gIGRyaXZlcnMvcGxh
dGZvcm0veDg2L2ludGVsX2NodF9pbnQzM2ZlLmMgfCAxNSArKy0tDQo+ICBkcml2ZXJzL3VzYi9y
b2xlcy9jbGFzcy5jICAgICAgICAgICAgICAgIHwgMjEgKysrKystDQo+ICBkcml2ZXJzL3VzYi90
eXBlYy9jbGFzcy5jICAgICAgICAgICAgICAgIHwgMzEgKysrKysrLS0NCj4gIGRyaXZlcnMvdXNi
L3R5cGVjL211eC5jICAgICAgICAgICAgICAgICAgfCA5NiArKysrKysrKysrKysrKysrKysrKy0t
LS0NCj4gIGluY2x1ZGUvbGludXgvZGV2aWNlLmggICAgICAgICAgICAgICAgICAgfCAgNiArKw0K
PiAgaW5jbHVkZS9saW51eC91c2Ivcm9sZS5oICAgICAgICAgICAgICAgICB8ICAxICsNCj4gIGlu
Y2x1ZGUvbGludXgvdXNiL3R5cGVjX211eC5oICAgICAgICAgICAgfCAgMyArLQ0KPiAgOCBmaWxl
cyBjaGFuZ2VkLCAxOTUgaW5zZXJ0aW9ucygrKSwgNDAgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0K
PiAyLjIwLjENCg0KSSB0ZXN0ZWQgdGhpcyBzZXJpZXMgb24gZHdjMyt0eXBlYywgZm9yIHVzYiBy
b2xlIHN3aXRjaCBhbmQgdHlwZWMgc3dpdGNoIGNvbW1vbiBwYXJ0DQpSZXZpZXdlZC1ieTogSnVu
IExpIDxqdW4ubGlAbnhwLmNvbT4NClRlc3RlZC1ieTogSnVuIExpIDxqdW4ubGlAbnhwLmNvbT4N
Cg==
