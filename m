Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B1EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D922B20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fOUDdTXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D922B20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeGKIT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:19:26 -0400
Received: from mail-by2nam01on0054.outbound.protection.outlook.com ([104.47.34.54]:11072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbeGKITZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLTtHsdhcJXRD9wf/g1F/aWn/7S0+MD2ZfSRvlHdpqs=;
 b=fOUDdTXxiLsGuFzkGTev7CuVRAQK5TmmhFfco2Wy5P+WAQY6fUBTQUbXRa+MV1UYTbf0zhLWYqeBQTKrHjE8YAS+ttslbfTgXX+DUYW/M7FSID+t5DL4rpqA6KE7jmUj54DD9Z6uU/qCgA4O0hPh4jKVYaXXBT3L06inC+qWok8=
Received: from MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) by
 MWHPR07MB2783.namprd07.prod.outlook.com (10.169.237.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Wed, 11 Jul 2018 08:16:17 +0000
Received: from MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::bddd:185e:610a:91b5]) by MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::bddd:185e:610a:91b5%5]) with mapi id 15.20.0930.022; Wed, 11 Jul 2018
 08:16:17 +0000
From:   Alan Douglas <adouglas@cadence.com>
To:     Colin King <colin.king@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: pcie-candence-ep: remove redundant variable mmc
Thread-Topic: [PATCH] PCI: pcie-candence-ep: remove redundant variable mmc
Thread-Index: AQHUGO1T4VSJRma6m0eEjkSb4F1rhaSJqgrw
Date:   Wed, 11 Jul 2018 08:16:17 +0000
Message-ID: <MWHPR07MB350280DBA03402F078C80ACCD85A0@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <20180711080103.4581-1-colin.king@canonical.com>
In-Reply-To: <20180711080103.4581-1-colin.king@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iNzBkNjhjMi04NGUyLTExZTgtODZlNy1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcYjcwZDY4YzMtODRlMi0xMWU4LTg2ZTctZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSIxNjU5IiB0PSIxMzE3NTc3MDU5MTM2OTcyOTEiIGg9InRhZE9WWDlaMUpnTjVKcVM4SjJlcDZUckVncz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB2783;7:VbvvG8wLSfM89nAwPyOnBAJZrf/vXQxAvNGnhz7LtcoEW+knuJfn4X/NCK+CzXFEq31CiXlWtQHs2WFHpDQDSQb3WxcDnfDvTW/JbRaBI9kcKu1jmrzlBE7/59sK/6F60CZCtDPTeaCW+MNTW9+ZaX/or6mFHV0b+6Z2r1q7V2r5EercdLuRui8za0qmyZXSEXi1vfAB5z3QOJWIdPL0l6egyluGDbjNQUeZqmzeT5H7WmKV8Z2gbQfBTGZQbpx1;20:d0FUbr7boR9DHTuSO8iQf6odTe/NA2C8TA9vJPNBLchtrzIUCfCmG6/OOTmI0+Y/AyP1Tu7e9kH5/gg9SwZnw7AJvlBXF0wRyWKdHf7VPex63SwRKKC516B1CeyoQr7CMXP3NyXVxUg++Egc80SZzC2LoVkPDn0/E/ThQCIJ2SIjZVudwKIEqfvvXS5D4nurqAlR9Faz2RSNpqZvl2aWMv69g/+Dc5WG13HvXqYFNIc0oe0clvXAxcwg9qES3Umu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 19fb47b5-6e25-4a63-98d5-08d5e70693ca
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB2783;
x-ms-traffictypediagnostic: MWHPR07MB2783:
x-microsoft-antispam-prvs: <MWHPR07MB278324003BF4B0DEC3CAED62D85A0@MWHPR07MB2783.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(198206253151910)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR07MB2783;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2783;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(36092001)(55016002)(26005)(6246003)(33656002)(68736007)(8936002)(7696005)(229853002)(305945005)(7736002)(2900100001)(2501003)(9686003)(53936002)(4326008)(14454004)(6436002)(186003)(476003)(478600001)(5250100002)(76176011)(25786009)(11346002)(102836004)(81166006)(81156014)(74316002)(8676002)(53546011)(5660300001)(86362001)(97736004)(105586002)(14444005)(54906003)(66066001)(106356001)(486006)(256004)(110136005)(6116002)(3846002)(99286004)(6506007)(2906002)(446003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2783;H:MWHPR07MB3502.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o1txAb2M8wwJMbRXiEXV2UV/nMnvZgCc1KaLAZ008CRJftsSs8ElyZoeBqEY1Uhd4psZ/dh2H4UD//S0yGOHPKHcCNJjbz3YOHGUtvMAPeTCj0/p7c9x+waHv4dWyf44MkzoOIqW3x+eTDDw9f7s1+0LYb/4pZ8mxWPUrKkzUInNLkKTg8IYHpPcdFUVIubJ6aruGlsy81hn2i//ttmj1UmdJSkg6lnY7I5BIy5/KLNsLSay2n8plDU42HCx177dxMxL8OLuwFv2wKIRa96ZEjJuSsEaT0QZinNW4sSZUvXk6dK8obC2hhrrgKb/y67f/ziMKBnOM8LXXaxPPfx29U24FAY5kZ5YEW1+YyrrJ5c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fb47b5-6e25-4a63-98d5-08d5e70693ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 08:16:17.6880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2783
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEgSnVseSAyMDE4IDA5OjAxLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBGcm9tOiBDb2xpbiBJ
YW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gVmFyaWFibGUgbW1jIGlz
IGJlaW5nIGFzc2lnbmVkIGJ1dCBpcyBuZXZlciB1c2VkIGhlbmNlIGl0IGlzIHJlZHVuZGFudA0K
PiBhbmQgY2FuIGJlIHJlbW92ZWQuDQo+IA0KPiBDbGVhbnMgdXAgY2xhbmcgd2FybmluZzoNCj4g
d2FybmluZzogdmFyaWFibGUgJ21tYycgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNl
dC12YXJpYWJsZV0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5r
aW5nQGNhbm9uaWNhbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ll
LWNhZGVuY2UtZXAuYyB8IDMgKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLWNhZGVuY2UtZXAuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1jYWRlbmNl
LWVwLmMNCj4gaW5kZXggZTNmZTQxMjRlM2FmLi42MzU0OWUwM2VhZTggMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1jYWRlbmNlLWVwLmMNCj4gKysrIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLWNhZGVuY2UtZXAuYw0KPiBAQCAtMjM4LDcgKzIzOCw3IEBA
IHN0YXRpYyBpbnQgY2Ruc19wY2llX2VwX2dldF9tc2koc3RydWN0IHBjaV9lcGMgKmVwYywgdTgg
Zm4pDQo+ICAJc3RydWN0IGNkbnNfcGNpZV9lcCAqZXAgPSBlcGNfZ2V0X2RydmRhdGEoZXBjKTsN
Cj4gIAlzdHJ1Y3QgY2Ruc19wY2llICpwY2llID0gJmVwLT5wY2llOw0KPiAgCXUzMiBjYXAgPSBD
RE5TX1BDSUVfRVBfRlVOQ19NU0lfQ0FQX09GRlNFVDsNCj4gLQl1MTYgZmxhZ3MsIG1tYywgbW1l
Ow0KPiArCXUxNiBmbGFncywgbW1lOw0KPiANCj4gIAkvKiBWYWxpZGF0ZSB0aGF0IHRoZSBNU0kg
ZmVhdHVyZSBpcyBhY3R1YWxseSBlbmFibGVkLiAqLw0KPiAgCWZsYWdzID0gY2Ruc19wY2llX2Vw
X2ZuX3JlYWR3KHBjaWUsIGZuLCBjYXAgKyBQQ0lfTVNJX0ZMQUdTKTsNCj4gQEAgLTI0OSw3ICsy
NDksNiBAQCBzdGF0aWMgaW50IGNkbnNfcGNpZV9lcF9nZXRfbXNpKHN0cnVjdCBwY2lfZXBjICpl
cGMsIHU4IGZuKQ0KPiAgCSAqIEdldCB0aGUgTXVsdGlwbGUgTWVzc2FnZSBFbmFibGUgYml0Zmll
bGQgZnJvbSB0aGUgTWVzc2FnZSBDb250cm9sDQo+ICAJICogcmVnaXN0ZXIuDQo+ICAJICovDQo+
IC0JbW1jID0gKGZsYWdzICYgUENJX01TSV9GTEFHU19RTUFTSykgPj4gMTsNCj4gIAltbWUgPSAo
ZmxhZ3MgJiBQQ0lfTVNJX0ZMQUdTX1FTSVpFKSA+PiA0Ow0KPiANCj4gIAlyZXR1cm4gbW1lOw0K
PiAtLQ0KPiAyLjE3LjENClRoYW5rcyBmb3Igc3BvdHRpbmcgdGhpcywgbW1jIGlzIG5vdCBuZWVk
ZWQgaGVyZSwganVzdCBpbnRlcmVzdGVkIGluIG1tZS4NCkFja2VkLWJ5OiBBbGFuIERvdWdsYXMg
PGFkb3VnbGFzQGNhZGVuY2UuY29tPg0KDQo=
