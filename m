Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22AFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4233820850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jvdIWS44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4233820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeH2QWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:22:48 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:5048
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727456AbeH2QWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPpHCDlocL+xgnf2C24DZMn0qbFz0MubSrf8tfacqP0=;
 b=jvdIWS44EpjINM+NkcPwAt6UYtZqmXX/KusN3sSqVHv2UzFUFGL19hGNuD0wuX96YaHl+yEnxUcmKoGHFTUt6ytk2Eoyy8/keOp78B/m/k/JX+D0RwkjugpWAo+EJvGd3EukjLhVRx+YrVHIztowGU+aPfhui75OXjPSSyZd35U=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4577.eurprd04.prod.outlook.com (52.135.149.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Wed, 29 Aug 2018 12:26:04 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5d61:a56c:c249:290]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5d61:a56c:c249:290%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 12:26:04 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V3 0/4] clk: new APIs to handle all available clocks
Thread-Topic: [PATCH V3 0/4] clk: new APIs to handle all available clocks
Thread-Index: AQHT9BSLZakbaB/d6k+ADoO1VMpzWKRom4gQgFsgTNCAEucsAIAAm3vA
Date:   Wed, 29 Aug 2018 12:26:04 +0000
Message-ID: <AM0PR04MB421119CF9432C8D87DFC226080090@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421114F8AFAE56B6D7C2D1E480770@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211368561A415B255782CBE803D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <153551211897.129321.14630649454821319736@swboyd.mtv.corp.google.com>
In-Reply-To: <153551211897.129321.14630649454821319736@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4577;6:1JKerMy5o1eryevp9VXAJxeaX4d9zyEfOum3Wy1v7WC7NDR5RhPRM8mlkH3qr1QNKJNuQqinoOk0rw5bCUuRb8KmEtA47ev2o5FOaWz62B5eulGN1AK1fAC8vKvutP9MD36trvwEGddu3bpMBrCICu03bOSke4Emizt/sVbkGm+41DZKfsjkGBW0hFacQ0jhKZ3n98U4rm3Y8Z9bhoOFMaJzZ4mHAr4twg/pYQn1gLZ25J9JXr1KQVRGhOgQ70G/SbbAEGZfSlbWL3vLkYeawW3QQAJxrEW9L4O8B2ySsw9a4G1Mmeb3sEdCFC7mB6uhRDTNGa17YCSLmhzQ1WQdWu/IqPMXNu9mjtobU8V3TjiskdcvzvNEbSK94CFhhV61s27lfy1A5zddCTOq0ejQCR/Pk7bZMywBh6czJQ4pAdJyp+UFAAYB0eOdhOlBiCQMEsWLtiiFb5DWP2ApX423fQ==;5:nbeJj9sRoAKS7dVYPpLaZlJZqEYSXdfHLhRmRcS+Zai/nGgRSPHXP9wRK5lgd1BphuujPydRMLE4ve7VxUZbvJtZSlrvylmpVv8u7yPVEqKgk6dNdcYS+eJ2mFvp3la4puc27sgyvcH+OqEyGvnfk7FtF7L3W+DuNJ9/lwzXrFY=;7:wlLjk1a8rvdtfGfvue9+2Wx3ZNH6K9HPWH0UNaTgreXdBI57h8P2fq3jglV0zlQzcaiMs7tnOnBCFo/o4Ouu0cmnzioEWhsXuZIOApEMnyGikQdIA9xESpx8ubaAj0QpxZMw+3FvJSlAt44TPcOR3dFOfU3MXLAgPBaVYRfohSZGgi1qwgOJCBWCq8ZFaONdEtCvg80Y9JqtPZd2CHldlSiQJvBLF1SHJvEMaq9VEr9TF1oqaHrfRV6cJIj9XpF4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3d4d87f9-c83a-4976-eb84-08d60daa96df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4577;
x-ms-traffictypediagnostic: AM0PR04MB4577:
x-microsoft-antispam-prvs: <AM0PR04MB45775B30A2D42F73946E34BE80090@AM0PR04MB4577.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR04MB4577;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4577;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(51914003)(13464003)(199004)(106356001)(105586002)(229853002)(74316002)(7736002)(81156014)(81166006)(316002)(305945005)(68736007)(7696005)(2906002)(76176011)(25786009)(54906003)(3846002)(6116002)(2900100001)(5250100002)(478600001)(6916009)(14454004)(5660300001)(33656002)(97736004)(476003)(26005)(53546011)(93886005)(102836004)(6506007)(4326008)(256004)(14444005)(486006)(11346002)(446003)(99286004)(66066001)(6246003)(6436002)(8676002)(86362001)(53936002)(8936002)(186003)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4577;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UEsrI8WTB8kgFhYaB6Yz3ps6AmGZHRwaHILvEj9iPIQBVYMDPEhXKa5nqTax9tn/m57k6hwgRcuWsFKxdpJ3HZhbmgpbJyNhbduXkJfjjqK5XuwmKFtTXLaxXkBxe/wvI0VnmRHrllQDjSG7/mNynT1Fpt1FEykKYJNPuwDKzcmkVScdY8wY0dZ5CIYfK4YFcU2NQ6G6+vb/FWka6Q3fkOltsJOlCM+Ec6PspdURlcrVIHaKgPKCotOHEmTenDIC3zclxcEqLpiv8SkVP1gH4Xt/cCNHcJt826IBcZ7CnKiJa+a6Y/pm8BKP5DNotwbCMIYe344xvwRv3qCpVoMlGO8pEBmxXURY5AE7I3lPleQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4d87f9-c83a-4976-eb84-08d60daa96df
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 12:26:04.5737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0
bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyOSwgMjAxOCAx
MTowOSBBTQ0KPiBUbzogQS5zLiBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyB0aG9yLnRoYXllckBsaW51eC5p
bnRlbC5jb207IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRD
SCBWMyAwLzRdIGNsazogbmV3IEFQSXMgdG8gaGFuZGxlIGFsbCBhdmFpbGFibGUgY2xvY2tzDQo+
IA0KPiBRdW90aW5nIEEucy4gRG9uZyAoMjAxOC0wOC0xNiAxOTozMzo1MikNCj4gPiBIaSBTdGVw
aGVuLA0KPiA+DQo+ID4gRG8geW91IHdhbnQgbWUgdG8gcmVzZW5kIHRoaXMgc2VyaWVzIGZvciBy
ZXZpZXc/DQo+ID4gSXQgc2VlbXMgaGF2ZSBiZWVuIHBlbmRpbmcgZm9yIHF1aXRlIGEgbG9uZyB0
aW1lLg0KPiA+DQo+ID4gVGhvciBqdXN0IHBpbmdlZCBtZSBmb3IgaXRzIHN0YXR1cyBhcyBoZSB3
YW50cyB0byB1c2UgaXQuDQo+ID4NCj4gDQo+IEkgd2FzIHdhaXRpbmcgZm9yIHNvbWVvbmUgdG8g
dHJ5IHRoZW0gb3V0IG9yIHJldmlldyB0aGVtLiBHb29kIHRoYXQgaXQNCj4gaGFwcGVuZWQhDQo+
IA0KPiBJJ3ZlIHRha2VuIGEgbG9vayBhdCB0aGUgcGF0Y2hlcyBhbmQgSSdtIHNsaWdodGx5IGFu
bm95ZWQgd2l0aCB0aGUgQVBJIHRoYXQNCj4gcGFzc2VzIGluIGEgZG91YmxlIHBvaW50ZXIgdG8g
Y2xrX2J1bGtfZGF0YSBhbmQgcmV0dXJucyBhIGNvdW50IG9mIHRoZSBudW1iZXINCj4gb2YgY2xr
cyBmb3VuZC4gSSBndWVzcyBpdCdzIG9rIHRob3VnaC4gSXQncyByZWFsbHkganVzdCB0aGlzDQo+
IGxpbmU6DQo+IA0KPiAJZGV2cmVzLT5jbGtzID0gKmNsa3M7DQo+IA0KPiB3aGljaCBtYWtlcyBt
eSBicmFpbiBhbGwgY29uZnVzZWQgYW5kIGdvIHRoaW5rIGFib3V0IHdoYXQncyBiZWluZyBhc3Np
Z25lZA0KPiBhbmQgaWYgaXQncyBhIHN0cnVjdCBjb3B5IG9yIG5vdC4NCj4gDQo+IE1heWJlIHRo
aXMgb24gdG9wIHdvdWxkIG1ha2UgaXQgZWFzaWVyIHRvIHRha2U/IEknbGwgdGhpbmsgYWJvdXQg
aXQgdG9uaWdodC4NCj4gDQoNCkxvb2tzIGxpa2UgYSBnb29kIGlkZWEgdG8gbWUuDQpXaWxsIHVw
ZGF0ZSBhbmQgcmVzZW5kLg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCg0KUmVnYXJkcw0K
RG9uZyBBaXNoZW5nDQoNCj4gLS0tODwtLS0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Ns
ay1kZXZyZXMuYyBiL2RyaXZlcnMvY2xrL2Nsay1kZXZyZXMuYyBpbmRleA0KPiA2ZDNjYTVlYzVk
ZTguLjEyYzg3NDU3ZWNhMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLWRldnJlcy5j
DQo+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1kZXZyZXMuYw0KPiBAQCAtODEsOSArODEsOSBAQCBp
bnQgX19tdXN0X2NoZWNrIGRldm1fY2xrX2J1bGtfZ2V0X2FsbChzdHJ1Y3QgZGV2aWNlDQo+ICpk
ZXYsDQo+ICAJaWYgKCFkZXZyZXMpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiANCj4gLQlyZXQg
PSBjbGtfYnVsa19nZXRfYWxsKGRldiwgY2xrcyk7DQo+ICsJcmV0ID0gY2xrX2J1bGtfZ2V0X2Fs
bChkZXYsICZkZXZyZXMtPmNsa3MpOw0KPiAgCWlmIChyZXQgPiAwKSB7DQo+IC0JCWRldnJlcy0+
Y2xrcyA9ICpjbGtzOw0KPiArCQkqY2xrcyA9IGRldnJlcy0+Y2xrczsNCj4gIAkJZGV2cmVzLT5u
dW1fY2xrcyA9IHJldDsNCj4gIAkJZGV2cmVzX2FkZChkZXYsIGRldnJlcyk7DQo+ICAJfSBlbHNl
IHsNCg==
