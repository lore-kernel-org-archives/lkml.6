Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991BFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4757420824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="gM4hG/3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4757420824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405963AbeKWDCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:02:43 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:31995 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404304AbeKWDCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:02:43 -0500
X-IronPort-AV: E=Sophos;i="5.56,266,1539673200"; 
   d="scan'208";a="21445174"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Nov 2018 09:22:39 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 22 Nov 2018 09:22:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al+yz3mdWzm/Ej42wwmZacp2AwNUEI/f9J1kcvU0ZIk=;
 b=gM4hG/3Dl2mHQdJw7bZv4sp+lGcLpb9M0DzU6bD42n80ZDsPwGoYboe9clJL1hOLkvcc3xhlia60+wFsoPNJmYaejltiwAKJQID5InCtriahNBYza2vHS4qhifY/HEH4rjqrd0HV1wf25MVnlCpF8x//Ewc+eRqX8Z/IwB41gPg=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1697.namprd11.prod.outlook.com (10.173.28.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Thu, 22 Nov 2018 16:22:35 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1339.029; Thu, 22 Nov 2018
 16:22:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexander.sverdlin@nokia.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Topic: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Index: AQHUgmAPRuGauPbUmUaN5hsWx0CViKVb+CkAgAACOYA=
Date:   Thu, 22 Nov 2018 16:22:34 +0000
Message-ID: <1869052d-1be2-243d-0901-afcf34d6e1dd@microchip.com>
References: <20181122123552.15756-1-tudor.ambarus@microchip.com>
 <f05c60c9-7b19-29d6-0ad2-b1593da11263@nokia.com>
In-Reply-To: <f05c60c9-7b19-29d6-0ad2-b1593da11263@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0159.eurprd07.prod.outlook.com
 (2603:10a6:802:16::46) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1697;6:IW2XQyIwtVYuMcYcmQwiV75uh200tWoppZazTSgNug+6sfdwBTySA8X1bGcJUO3HRT5C3uGV0flVD3vZiSio859am523fVaY+wYdnsm4HA9BLwhEA5YxvMKOEyWfxe1wtqe6khKzutt6iyBaAYh8GA3GZElcqbNQuucXV1ryZXV48rje026SEpNGqY1lpNLFuXyCOmD+ulxSzfDGPFj0j9tXxMgnpbOQZ/G40d4j5Xytht+tu+OkjZrjh1ubQ0NLw7Z9f2ZlYXtMRjh6S5ecU7vxJPn2tjqp19ycDh/GFrlDJA8xhzNGq56BIp2WPHV2S6leocSwztG1aJ7oPEgys5eqNBRDwkb4yVKY4c3c+5ccXQ2+AYQY1D+F4E0VEKfavBiwKsgPJ3a7xalcPrrVTnLXttJr0DYy9hT7qPn9WQrsMO/b4BiXwmaFwoxXzC0Wt1QbtfiECg3AscX/z9Uerw==;5:2ymIYPxi9mxBXTsVH57N8w5s5xRFycAif4ed+lcq3cX4pQUkCz8b+jbW5Df7Yk7USaeWgdmNr8XltXs0z93Ir6e8Rbu/w1hJ+d3lI8mt/uVxxvaHs4ot5wsWDkCGsQxP2MJ4oFi6XITTWH5WgcZZjnWV7QtnLHO9rxwxW1WCJpU=;7:2/aS3auDQmvL3uPgCEegGAAqm6zcg51SZOOH6bZKASIR4Fr8HSvIpSQtwXHScjwy2DVApvubSeVbozozl0j+XG1IUQS9SEC1nnxUgVLGBtaCpv1MN2qU2Y37odneCuNfVfHnbTLJS3IjpibXLf5B8w==
x-ms-office365-filtering-correlation-id: 323e4f0d-1e08-4bdd-fbea-08d65096b5b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1697;
x-ms-traffictypediagnostic: BN6PR11MB1697:
x-microsoft-antispam-prvs: <BN6PR11MB16972695A85BF04165A3DE0DF0DB0@BN6PR11MB1697.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1697;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1697;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(316002)(25786009)(81156014)(81166006)(8676002)(478600001)(54906003)(110136005)(2900100001)(5660300001)(3846002)(97736004)(6116002)(305945005)(7736002)(68736007)(4326008)(72206003)(14454004)(8936002)(53546011)(36756003)(256004)(14444005)(386003)(6506007)(229853002)(102836004)(6486002)(2201001)(76176011)(26005)(86362001)(6436002)(2501003)(39060400002)(52116002)(53936002)(6512007)(66066001)(31696002)(105586002)(106356001)(31686004)(71200400001)(71190400001)(486006)(186003)(6246003)(99286004)(446003)(2616005)(476003)(2906002)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1697;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z2DQKkmnx36lJuEw94exTcDB76DQDpxGTmLag0zO8lTd1LfqKQOFxyNfMbRzHzm/QiMuUCVTRA7zHRh2qHxaXfKKN9Se7mL2J/BEW8s5TCEXrVfcToqf+aPi5xLpDVNeGNIT+EbZ3BElFgYQTelW0RcsihU145ZcE18/oVLS1P/7rVleTXl8bYaymJzHs6YvS60E5sY0pjZcOIdJ9VD+8tYAIvUyDw6rQ/MPlbLGeHfdYnmz8xmoN1al3XI2JQsI9u14y4pVNDD42j71zhK2ZDD51hKnPFhtLqWxg5DdrzH4mNGlyRcxNPH9IcobyENQKYy845gP4V5gNBnj5UTZ+/BPq7CGjdAxARGoIN4Xm1k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7588137775F5C347937C26BBBE40585C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 323e4f0d-1e08-4bdd-fbea-08d65096b5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 16:22:34.8866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1697
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzIyLzIwMTggMDY6MTQgUE0sIFN2ZXJkbGluLCBBbGV4YW5kZXIgKE5va2lhIC0g
REUvVWxtKSB3cm90ZToNCj4gSGVsbG8gVHVkb3IsDQo+IA0KPiBPbiAyMi8xMS8yMDE4IDEzOjM2
LCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBGcm9tOiBUdWRvciBBbWJh
cnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gQnVnIHJlcG9ydGVkIGZv
ciB0aGUgb3V0LW9mLXRyZWUgUzI1RlMxMjhTIGZsYXNoIG1lbW9yeS4NCj4+DQo+PiBCRlBUIHRh
YmxlIGFkdmVydGlzZXMgYWxsIHRoZSBlcmFzZSB0eXBlcyBzdXBwb3J0ZWQgYnkgYWxsIHRoZQ0K
Pj4gcG9zc2libGUgbWFwIGNvbmZpZ3VyYXRpb25zLiBVcGRhdGUgdGhlIGVyYXNlX3R5cGUgYXJy
YXkgdG8gaW5kaWNhdGUNCj4+IHdoaWNoIGVyYXNlIHR5cGVzIGFyZSBhcHBsaWNhYmxlIHRvIHRo
ZSBjdXJyZW50IG1hcCBjb25maWd1cmF0aW9uLg0KPj4NCj4+IEJhY2t3YXJkIGNvbXBhdGliaWxp
dHkgdGVzdCBkb25lIG9uIHNzdDI2dmYwNjRiLg0KPj4NCj4+IEZpeGVzOiBiMDM4ZThlM2JlNzIg
KCJtdGQ6IHNwaS1ub3I6IHBhcnNlIFNGRFAgU2VjdG9yIE1hcCBQYXJhbWV0ZXIgVGFibGUiKQ0K
Pj4gUmVwb3J0ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQG5v
a2lhLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNA
bWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5j
IHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+ICAxIGZpbGUgY2hhbmdlZCwg
MjggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5j
DQo+PiBpbmRleCA5M2M5YmM4OTMxZmMuLmE3MWFkY2Q2ZGRmYSAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9y
L3NwaS1ub3IuYw0KPj4gQEAgLTMwMDAsNyArMzAwMCw4IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9p
bml0X25vbl91bmlmb3JtX2VyYXNlX21hcChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4gIAl1NjQg
b2Zmc2V0Ow0KPj4gIAl1MzIgcmVnaW9uX2NvdW50Ow0KPj4gIAlpbnQgaSwgajsNCj4+IC0JdTgg
ZXJhc2VfdHlwZSwgdW5pZm9ybV9lcmFzZV90eXBlOw0KPj4gKwl1OCB1bmlmb3JtX2VyYXNlX3R5
cGUsIHNhdmVfdW5pZm9ybV9lcmFzZV90eXBlOw0KPj4gKwl1OCBlcmFzZV90eXBlLCByZWdpb25z
X2VyYXNlX3R5cGU7DQo+PiAgDQo+PiAgCXJlZ2lvbl9jb3VudCA9IFNNUFRfTUFQX1JFR0lPTl9D
T1VOVCgqc21wdCk7DQo+PiAgCS8qDQo+PiBAQCAtMzAxNCw2ICszMDE1LDcgQEAgc3RhdGljIGlu
dCBzcGlfbm9yX2luaXRfbm9uX3VuaWZvcm1fZXJhc2VfbWFwKHN0cnVjdCBzcGlfbm9yICpub3Is
DQo+PiAgCW1hcC0+cmVnaW9ucyA9IHJlZ2lvbjsNCj4+ICANCj4+ICAJdW5pZm9ybV9lcmFzZV90
eXBlID0gMHhmZjsNCj4+ICsJcmVnaW9uc19lcmFzZV90eXBlID0gMDsNCj4+ICAJb2Zmc2V0ID0g
MDsNCj4+ICAJLyogUG9wdWxhdGUgcmVnaW9ucy4gKi8NCj4+ICAJZm9yIChpID0gMDsgaSA8IHJl
Z2lvbl9jb3VudDsgaSsrKSB7DQo+PiBAQCAtMzAzMCwxMyArMzAzMiwzOCBAQCBzdGF0aWMgaW50
IHNwaV9ub3JfaW5pdF9ub25fdW5pZm9ybV9lcmFzZV9tYXAoc3RydWN0IHNwaV9ub3IgKm5vciwN
Cj4+ICAJCSAqLw0KPj4gIAkJdW5pZm9ybV9lcmFzZV90eXBlICY9IGVyYXNlX3R5cGU7DQo+PiAg
DQo+PiArCQkvKg0KPj4gKwkJICogcmVnaW9uc19lcmFzZV90eXBlIG1hc2sgd2lsbCBpbmRpY2F0
ZSBhbGwgdGhlIGVyYXNlIHR5cGVzDQo+PiArCQkgKiBzdXBwb3J0ZWQgaW4gdGhpcyBjb25maWd1
cmF0aW9uIG1hcC4NCj4+ICsJCSAqLw0KPj4gKwkJcmVnaW9uc19lcmFzZV90eXBlIHw9IGVyYXNl
X3R5cGU7DQo+PiArDQo+PiAgCQlvZmZzZXQgPSAocmVnaW9uW2ldLm9mZnNldCAmIH5TTk9SX0VS
QVNFX0ZMQUdTX01BU0spICsNCj4+ICAJCQkgcmVnaW9uW2ldLnNpemU7DQo+PiAgCX0NCj4+ICAN
Cj4+ICsJc2F2ZV91bmlmb3JtX2VyYXNlX3R5cGUgPSBtYXAtPnVuaWZvcm1fZXJhc2VfdHlwZTsN
Cj4+ICAJbWFwLT51bmlmb3JtX2VyYXNlX3R5cGUgPSBzcGlfbm9yX3NvcnRfZXJhc2VfbWFzayht
YXAsDQo+PiAgCQkJCQkJCSAgdW5pZm9ybV9lcmFzZV90eXBlKTsNCj4+ICANCj4+ICsJaWYgKCFy
ZWdpb25zX2VyYXNlX3R5cGUpIHsNCj4+ICsJCS8qDQo+PiArCQkgKiBSb2xsIGJhY2sgdG8gdGhl
IHByZXZpb3VzIHVuaWZvcm1fZXJhc2VfdHlwZSBtYXNrLCBTTVBUIGlzDQo+PiArCQkgKiBicm9r
ZW4uDQo+PiArCQkgKi8NCj4+ICsJCW1hcC0+dW5pZm9ybV9lcmFzZV90eXBlID0gc2F2ZV91bmlm
b3JtX2VyYXNlX3R5cGU7DQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsJfQ0KPj4gKw0KPj4g
KwkvKg0KPj4gKwkgKiBCRlBUIHRhYmxlIGFkdmVydGlzZXMgYWxsIHRoZSBlcmFzZSB0eXBlcyBz
dXBwb3J0ZWQgYnkgYWxsIHRoZQ0KPj4gKwkgKiBwb3NzaWJsZSBtYXAgY29uZmlndXJhdGlvbnMu
IFVwZGF0ZSB0aGUgZXJhc2VfdHlwZSBhcnJheSB0byBpbmRpY2F0ZQ0KPj4gKwkgKiB3aGljaCBl
cmFzZSB0eXBlcyBhcmUgYXBwbGljYWJsZSB0byB0aGUgY3VycmVudCBtYXAgY29uZmlndXJhdGlv
bi4NCj4+ICsJICovDQo+PiArCWZvciAoaSA9IDA7IGkgPCBTTk9SX0VSQVNFX1RZUEVfTUFYOyBp
KyspDQo+PiArCQlpZiAoIShyZWdpb25zX2VyYXNlX3R5cGUgJiBCSVQoZXJhc2VbaV0uaWR4KSkp
DQo+PiArCQkJc3BpX25vcl9zZXRfZXJhc2VfdHlwZSgmZXJhc2VbaV0sIDAsIDB4RkYpOw0KPiAN
Cj4gaGF2ZSB5b3Ugbm90aWNlZCB0aGUgZm9sbG93aW5nOg0KPiANCj4gLi4uL2RyaXZlcnMvbXRk
L3NwaS1ub3Ivc3BpLW5vci5jOiBJbiBmdW5jdGlvbiDigJhzcGlfbm9yX2luaXRfbm9uX3VuaWZv
cm1fZXJhc2VfbWFw4oCZOg0KPiAuLi4vZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmM6Mjk0
MDoyNzogZXJyb3I6IHBhc3NpbmcgYXJndW1lbnQgMSBvZiDigJhzcGlfbm9yX3NldF9lcmFzZV90
eXBl4oCZIGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1YWxpZmllcg0KPiAgZnJvbSBwb2ludGVyIHRh
cmdldCB0eXBlIFstV2Vycm9yPWRpc2NhcmRlZC1xdWFsaWZpZXJzXQ0KPiAgICAgc3BpX25vcl9z
ZXRfZXJhc2VfdHlwZSgmZXJhc2VbaV0sIDAsIDB4RkYpOw0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBeDQo+IC4uLi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYzoyMzY4OjEzOiBu
b3RlOiBleHBlY3RlZCDigJhzdHJ1Y3Qgc3BpX25vcl9lcmFzZV90eXBlICrigJkgYnV0IGFyZ3Vt
ZW50IGlzIG9mIHR5cGUg4oCYY29uc3Qgc3RydQ0KPiBjdCBzcGlfbm9yX2VyYXNlX3R5cGUgKuKA
mQ0KPiAgc3RhdGljIHZvaWQgc3BpX25vcl9zZXRfZXJhc2VfdHlwZShzdHJ1Y3Qgc3BpX25vcl9l
cmFzZV90eXBlICplcmFzZSwNCj4gICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4N
Cj4gDQo+PiArDQoNCg0KT29wcywgbm8sIHRoYW5rcyEgUmVtb3ZpbmcgdGhlIGNvbnN0IHF1YWxp
ZmllciB3aWxsIGRvIHRoZSB0cmljazoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1u
b3Ivc3BpLW5vci5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCmluZGV4IGE3MWFk
Y2Q2ZGRmYS4uMDYwODY5MTZlYzNjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9z
cGktbm9yLmMNCisrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQpAQCAtMjk5NSw3
ICsyOTk1LDcgQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfbm9uX3VuaWZvcm1fZXJhc2VfbWFw
KHN0cnVjdCBzcGlfbm9yICpub3IsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3QgdTMyICpzbXB0KQ0KIHsNCiAgICAgICAgc3RydWN0IHNwaV9ub3Jf
ZXJhc2VfbWFwICptYXAgPSAmbm9yLT5lcmFzZV9tYXA7DQotICAgICAgIGNvbnN0IHN0cnVjdCBz
cGlfbm9yX2VyYXNlX3R5cGUgKmVyYXNlID0gbWFwLT5lcmFzZV90eXBlOw0KKyAgICAgICBzdHJ1
Y3Qgc3BpX25vcl9lcmFzZV90eXBlICplcmFzZSA9IG1hcC0+ZXJhc2VfdHlwZTsNCiAgICAgICAg
c3RydWN0IHNwaV9ub3JfZXJhc2VfcmVnaW9uICpyZWdpb247DQogICAgICAgIHU2NCBvZmZzZXQ7
DQogICAgICAgIHUzMiByZWdpb25fY291bnQ7DQoNCg==
