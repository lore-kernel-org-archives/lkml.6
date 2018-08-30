Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A5EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B0B2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="TYJIB5UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B0B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeH3SjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:39:09 -0400
Received: from mail-bn3nam01on0055.outbound.protection.outlook.com ([104.47.33.55]:44880
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729008AbeH3SjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+aZcF9XjpBTuvK/p7TL1XGaTS2SzBCxv0AWXrPChE8=;
 b=TYJIB5UHf/PzuKQ6FyG9jee1h493iQr5474d+xZn03D2ensxP7WmrjfBLtn13aTZfiB3pNgwcIBUHyCSzDMkJS6tWRCrx3TxWz4Scb0byljUcyrfdVoQs7ZSutcJ9L82eH2BrdGPTdvw5lwHGTRsbbe5PuHS7KcBsuW3wZ9KeHU=
Received: from BN6PR07MB3491.namprd07.prod.outlook.com (10.161.153.30) by
 BN6PR07MB3569.namprd07.prod.outlook.com (10.161.153.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Thu, 30 Aug 2018 14:33:45 +0000
Received: from BN6PR07MB3491.namprd07.prod.outlook.com
 ([fe80::1818:5ea9:4c35:b0bf]) by BN6PR07MB3491.namprd07.prod.outlook.com
 ([fe80::1818:5ea9:4c35:b0bf%3]) with mapi id 15.20.1080.015; Thu, 30 Aug 2018
 14:33:45 +0000
From:   Alan Douglas <adouglas@cadence.com>
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] PCI: remove unnecessary check of device_type == pci
Thread-Topic: [PATCH] PCI: remove unnecessary check of device_type == pci
Thread-Index: AQHUP8b1NBCTjlmCo0CFsHXjwBjqcqTYWmew
Date:   Thu, 30 Aug 2018 14:33:45 +0000
Message-ID: <BN6PR07MB3491262D6674CC2F9734FB3CD8080@BN6PR07MB3491.namprd07.prod.outlook.com>
References: <20180829183440.13601-1-robh@kernel.org>
In-Reply-To: <20180829183440.13601-1-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iN2UxNDIyOS1hYzYxLTExZTgtYWI4OC1hNDRjYzhlYzVlY2RcYW1lLXRlc3RcYjdlMTQyMmEtYWM2MS0xMWU4LWFiODgtYTQ0Y2M4ZWM1ZWNkYm9keS50eHQiIHN6PSIzODQzIiB0PSIxMzE4MDExMzIzNDE5NjA5ODAiIGg9IklRTE9OS1BxdHVKcTlMbUg4WjNoVDJiRGlkST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR07MB3569;20:03GWleddUjYK6ZU/+D70DL4Qy7/NmNiC7tp8I62Q6pc+A2hiMVuOrE4ETVb8l+zE5E0hFkQycVuz62AN5D4J4xY9mXhpkuaAkenLwDz2p6P579ShEPIG8jyQKLL7YzPzx0gHEmzGhfGY4vSGqKTssGMjzbgD6w8hq+7ibo8kjNxM6xytpVfGhbHIOhbSURpx1kcB5PxFkYvEUwciEIKcwxgQp4S9RayTVS2d9mmd10JwSZ+BnpfTSY8alDncOmIU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c8c8a6d5-b255-47db-6a8c-08d60e859766
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN6PR07MB3569;
x-ms-traffictypediagnostic: BN6PR07MB3569:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com; 
x-microsoft-antispam-prvs: <BN6PR07MB35698D6BD463DF92F438982BD8080@BN6PR07MB3569.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592)(211936372134217)(153496737603132)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:BN6PR07MB3569;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3569;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(366004)(396003)(199004)(189003)(36092001)(6246003)(8676002)(6116002)(86362001)(97736004)(53936002)(4326008)(99286004)(2900100001)(6506007)(11346002)(53546011)(5660300001)(9686003)(81156014)(2906002)(55016002)(476003)(3846002)(478600001)(14454004)(68736007)(446003)(486006)(186003)(106356001)(33656002)(8936002)(256004)(26005)(105586002)(76176011)(66066001)(229853002)(7696005)(305945005)(5250100002)(7736002)(25786009)(110136005)(74316002)(102836004)(316002)(54906003)(6436002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3569;H:BN6PR07MB3491.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ez1lscjlrU/kuICUjcNqQ737wDQPIl2MTcPv+KekCbEuUlHVdjErcDqwo/T81zGvCxYGl2o2dccfrzkJ9eABPlMLTLnhBEY7Lqwq8K0c2/CXJuqetPZ85VT4UV7W73az7W1ENnCwIM79gtXIvb7CoPiW8+mCgNhIBMVUQWhIPdYYPxZXlsn1ZEo8srVpEOfK1etv5fo8n2KLprYobzj4QTI8sts2evFxppEqOI+vxrVWYP95Io//EZpxJHpkUVkY7mPtmD6zYPhV6Pq+0JUpW1do6qr0wjPUA+VILkyNf2KpIQFieQvw0K6kYC7TDI+kFt21itBLs896TlfG7f9DBQW1y4xMXHBwPA2XOa7Ltnw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c8a6d5-b255-47db-6a8c-08d60e859766
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 14:33:45.2384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDI5IEF1Z3VzdCAyMDE4IDE5OjM1LCBSb2IgSGVycmluZyB3cm90ZToNCj4gVG86
IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPg0KPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5j
b20+OyBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgQWxhbiBEb3VnbGFzDQo+
IDxhZG91Z2xhc0BjYWRlbmNlLmNvbT47IFN1YnJhaG1hbnlhIExpbmdhcHBhIDxsLnN1YnJhaG1h
bnlhQG1vYml2ZWlsLmNvLmluPjsgTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNv
bT47IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBQQ0k6IHJlbW92ZSB1bm5lY2Vzc2Fy
eSBjaGVjayBvZiBkZXZpY2VfdHlwZSA9PSBwY2kNCj4gDQo+IEVYVEVSTkFMIE1BSUwNCj4gDQo+
IA0KPiBQQ0kgaG9zdCBkcml2ZXJzIGhhdmUgYWxyZWFkeSBtYXRjaGVkIG9uIGNvbXBhdGlibGUg
c3RyaW5ncywgc28gY2hlY2tpbmcNCj4gZGV2aWNlX3R5cGUgaXMgcmVkdW5kYW50LiBBbHNvLCBk
ZXZpY2VfdHlwZSBpcyBjb25zaWRlcmVkIGRlcHJlY2F0ZWQgZm9yDQo+IEZEVCB0aG91Z2ggd2Un
dmUgc3RpbGwgYmVlbiByZXF1aXJpbmcgaXQgZm9yIFBDSSBob3N0cyBhcyBpdCBpcyB1c2VmdWwN
Cj4gZm9yIGZpbmRpbmcgUENJIGJ1c2VzLg0KPiANCj4gQ2M6IFdpbGwgRGVhY29uIDx3aWxsLmRl
YWNvbkBhcm0uY29tPg0KPiBDYzogTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNp
QGFybS5jb20+DQo+IENjOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiBD
YzogQWxhbiBEb3VnbGFzIDxhZG91Z2xhc0BjYWRlbmNlLmNvbT4NCj4gQ2M6IFN1YnJhaG1hbnlh
IExpbmdhcHBhIDxsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluPg0KPiBDYzogTWljaGFsIFNp
bWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmcNCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTaWdu
ZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpLWhvc3QtY29tbW9uLmMgICB8IDggLS0tLS0tLS0NCj4gIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1jYWRlbmNlLWhvc3QuYyB8IDcgLS0tLS0tLQ0KPiAg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMgICAgIHwgNyAtLS0tLS0tDQo+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LW53bC5jICAgfCA5IC0tLS0tLS0t
LQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXhpbGlueC5jICAgICAgIHwgNyAtLS0t
LS0tDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDM4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWhvc3QtY29tbW9uLmMgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaS1ob3N0LWNvbW1vbi5jDQo+IGluZGV4IGQ4ZjEwNDUxZjI3My4uYzc0
Mjg4MWI1MDYxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1ob3N0
LWNvbW1vbi5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWhvc3QtY29tbW9u
LmMNCj4gQEAgLTU4LDkgKzU4LDcgQEAgc3RhdGljIHN0cnVjdCBwY2lfY29uZmlnX3dpbmRvdyAq
Z2VuX3BjaV9pbml0KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gIGludCBwY2lfaG9zdF9jb21tb25f
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gIAkJCSAgc3RydWN0IHBjaV9l
Y2FtX29wcyAqb3BzKQ0KPiAgew0KPiAtCWNvbnN0IGNoYXIgKnR5cGU7DQo+ICAJc3RydWN0IGRl
dmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gLQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2
LT5vZl9ub2RlOw0KPiAgCXN0cnVjdCBwY2lfaG9zdF9icmlkZ2UgKmJyaWRnZTsNCj4gIAlzdHJ1
Y3QgcGNpX2NvbmZpZ193aW5kb3cgKmNmZzsNCj4gIAlzdHJ1Y3QgbGlzdF9oZWFkIHJlc291cmNl
czsNCj4gQEAgLTcwLDEyICs2OCw2IEBAIGludCBwY2lfaG9zdF9jb21tb25fcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gIAlpZiAoIWJyaWRnZSkNCj4gIAkJcmV0dXJuIC1F
Tk9NRU07DQo+IA0KPiAtCXR5cGUgPSBvZl9nZXRfcHJvcGVydHkobnAsICJkZXZpY2VfdHlwZSIs
IE5VTEwpOw0KPiAtCWlmICghdHlwZSB8fCBzdHJjbXAodHlwZSwgInBjaSIpKSB7DQo+IC0JCWRl
dl9lcnIoZGV2LCAiaW52YWxpZCBcImRldmljZV90eXBlXCIgJXNcbiIsIHR5cGUpOw0KPiAtCQly
ZXR1cm4gLUVJTlZBTDsNCj4gLQl9DQo+IC0NCj4gIAlvZl9wY2lfY2hlY2tfcHJvYmVfb25seSgp
Ow0KPiANCj4gIAkvKiBQYXJzZSBhbmQgbWFwIG91ciBDb25maWd1cmF0aW9uIFNwYWNlIHdpbmRv
d3MgKi8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1jYWRlbmNl
LWhvc3QuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1jYWRlbmNlLWhvc3QuYw0KPiBp
bmRleCBlYzM5NGY2YTE5YzguLjk3ZTI1MTA5MGI0ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9wY2llLWNhZGVuY2UtaG9zdC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1jYWRlbmNlLWhvc3QuYw0KPiBAQCAtMjM1LDcgKzIzNSw2IEBAIHN0YXRp
YyBpbnQgY2Ruc19wY2llX2hvc3RfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IA0KPiAgc3Rh
dGljIGludCBjZG5zX3BjaWVfaG9zdF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiAgew0KPiAtCWNvbnN0IGNoYXIgKnR5cGU7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0g
JnBkZXYtPmRldjsNCj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0K
PiAgCXN0cnVjdCBwY2lfaG9zdF9icmlkZ2UgKmJyaWRnZTsNCj4gQEAgLTI2OCwxMiArMjY3LDYg
QEAgc3RhdGljIGludCBjZG5zX3BjaWVfaG9zdF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiAgCXJjLT5kZXZpY2VfaWQgPSAweGZmZmY7DQo+ICAJb2ZfcHJvcGVydHlfcmVh
ZF91MTYobnAsICJkZXZpY2UtaWQiLCAmcmMtPmRldmljZV9pZCk7DQo+IA0KPiAtCXR5cGUgPSBv
Zl9nZXRfcHJvcGVydHkobnAsICJkZXZpY2VfdHlwZSIsIE5VTEwpOw0KPiAtCWlmICghdHlwZSB8
fCBzdHJjbXAodHlwZSwgInBjaSIpKSB7DQo+IC0JCWRldl9lcnIoZGV2LCAiaW52YWxpZCBcImRl
dmljZV90eXBlXCIgJXNcbiIsIHR5cGUpOw0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gLQl9DQo+
IC0NCj4gIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYsIElPUkVTT1VS
Q0VfTUVNLCAicmVnIik7DQo+ICAJcGNpZS0+cmVnX2Jhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3Vy
Y2UoZGV2LCByZXMpOw0KPiAgCWlmIChJU19FUlIocGNpZS0+cmVnX2Jhc2UpKSB7DQpXaXRoIHJl
Z2FyZHMgdG8gZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWNhZGVuY2UtaG9zdC5jDQpBY2tl
ZC1ieTogQWxhbiBEb3VnbGFzIDxhZG91Z2xhc0BjYWRlbmNlLmNvbT4NCg0K
