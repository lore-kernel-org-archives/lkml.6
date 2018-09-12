Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9C6C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9BB20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9BB20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeILVNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:13:15 -0400
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:6651 "EHLO
        g2t2354.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbeILVNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:13:14 -0400
Received: from G9W8454.americas.hpqcorp.net (g9w8454.houston.hp.com [16.216.161.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 327E0C9;
        Wed, 12 Sep 2018 16:08:02 +0000 (UTC)
Received: from G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) by
 G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 12 Sep 2018 16:08:01 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W8456.americas.hpqcorp.net (16.216.161.95) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 12 Sep 2018 16:08:01 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1060.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Wed, 12 Sep 2018 16:08:00 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283%2]) with mapi id 15.20.1122.020; Wed, 12 Sep 2018
 16:08:00 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jack@suse.cz" <jack@suse.cz>
CC:     "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: [PATCH 2/2] ext4, dax: set ext4_dax_aops for dax files
Thread-Topic: [PATCH 2/2] ext4, dax: set ext4_dax_aops for dax files
Thread-Index: AQHUSej7Q67hDcpgxEKY4HwO3VbK/6TrYvcAgAEACACAAGj4AA==
Date:   Wed, 12 Sep 2018 16:08:00 +0000
Message-ID: <1f1cf9db3981390d2ad5a08d5f1987d9c933e687.camel@hpe.com>
References: <20180911154246.6844-1-toshi.kani@hpe.com>
         <20180911154246.6844-3-toshi.kani@hpe.com>
         <CAPcyv4iEZ7q0MV7n-_eovrJw_U9S3=pkY_nYwtw1jSBS7vPqCQ@mail.gmail.com>
         <20180912093140.GB7782@quack2.suse.cz>
In-Reply-To: <20180912093140.GB7782@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1060;6:tqFFcKtdxsY++oTM7dDNwT1IurSoEeZCVcblii731PQiDQiBprSBIPQI2tt0bY6A85nZmR5DQHfEk6Q45yVbnqxPcTAgp9KcAw73Swj62qccqWnArQPLpSiC+ylP7eAUwQ6qSIilKBkm/4lfXHzPAtOoXZy8RY4vFm7TGb7VwCbjlZa5zZEk+072CSqHxH3GKUnL37xZRGl7g6kmuFAVCc4XvJv5XcOSCdF6jxir19hKe2kvaGpT67mDEf7T/4xOB9JxU8sER1WlovSXjfnOJjUMn9YoPxU2dTrNxQRpwUuY63bwMANc3+k3Eu6cmUZKx2fO5ucsjUrCcgmdpThtzFaS+clB7cjg1mgb/OuJu952I6siDckhQX/2uLkBbLA0Cv5HcJsLCUJszaoSBAVDSFzPyVxKR5yr0W1AfPUBGaEn3T2AOzWeLWRVJc4y5Hvh8xsrGziQAtBOQ7y5SnE+LA==;5:vnbCGoFkTOi5U3nDDJex7aGljkZEozDsk3j3ffhi7xmxVkuhGawYe0Roy2HPMMRA1evLYphIu/1sZ78uzWwObqXdtSzImSkvlfogohNoCgKMBKrBilTUiwcG1yF5JKQiwDFFqfghQ17V0CR0uqHoIRYioWrnR+ETXcqhoOzNC2Y=;7:fMagGES6yuWJlYPXS/w8TlPuZSSaBqGp05NF/h21umSKXmNP+nqzRWWT8I/6GyI4OWU4Dl0NyIIdzhZoxDHTVMKjcfuRc9adNH817HnpoISmoedDlZ0EscXYu5dy5XhGP3pav/xLRIo/8PT147wWpiR4c6kQ1Fr+mDoW2QudjYZMqg72pFnRtYQhodRz93ryn78exuumluYv2aY07tkKAzBNyuGr8B5J/39ubZU5LPAT4jToWkXQNOSpJVGeEiBz
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cc161187-ce46-40f8-1f9e-08d618c9e97b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1060;
x-ms-traffictypediagnostic: AT5PR8401MB1060:
x-microsoft-antispam-prvs: <AT5PR8401MB1060216F91F0A0BD8D1A2EAA821B0@AT5PR8401MB1060.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(9452136761055)(240460790083961)(222181515654134)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:AT5PR8401MB1060;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1060;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(136003)(199004)(189003)(5660300001)(8936002)(316002)(54906003)(68736007)(93886005)(110136005)(2906002)(106356001)(6246003)(446003)(105586002)(486006)(14444005)(256004)(102836004)(11346002)(476003)(2616005)(66066001)(99286004)(26005)(186003)(25786009)(81166006)(4326008)(6506007)(53546011)(3846002)(76176011)(2501003)(81156014)(229853002)(2900100001)(478600001)(6116002)(5250100002)(6486002)(7736002)(86362001)(575784001)(118296001)(8676002)(6436002)(53936002)(6512007)(97736004)(36756003)(14454004)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1060;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pxkuTTRyD3gIFBvRUW5LIryH/OISDupZvfZd031+Ttq8g6/pGje/y4BGX5Q0aB0hTz/v239QhsdujtIoehS6o2kAshpEvdMb6A3fX0zxgyqcztT7ZGjySRICYyjsImGcLa1gc/w1fksg86a0zGK1/KJ9elkcX+SdL4QzX8lgKrQM/yzS+w2clwCJAEGk8802fsVlfZLZ+LoFCx7QpsWiVgSGs0ishBQZAaS3nLwrzk99WA4jVANuIJqEj8ajWoTHs4kBheLxhGVxMK+pl+2ldFYXlR6iyEb2uUTYE3trC9oHJqJPIMuJ5VmM382uhfp75+Zly2iCBzIMCO1AjbsnlmkXrSS30iW7hVEFqn1Gsok=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5406065F89EEF84085460FEB5A0ED63E@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cc161187-ce46-40f8-1f9e-08d618c9e97b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 16:08:00.2936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1060
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA5LTEyIGF0IDExOjMxICswMjAwLCBKYW4gS2FyYSB3cm90ZToNCj4gT24g
VHVlIDExLTA5LTE4IDExOjE1OjE4LCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+ID4gT24gVHVlLCBT
ZXAgMTEsIDIwMTggYXQgODo0MiBBTSwgVG9zaGkgS2FuaSA8dG9zaGkua2FuaUBocGUuY29tPiB3
cm90ZToNCj4gPiA+IFN5bmMgc3lzY2FsbCB0byBhbiBleGlzdGluZyBEQVggZmlsZSBuZWVkcyB0
byBmbHVzaCBwcm9jZXNzb3IgY2FjaGUsDQo+ID4gPiBidXQgaXQgZG9lcyBub3QgY3VycmVudGx5
LiAgVGhpcyBpcyBiZWNhdXNlICdleHQ0X2RhX2FvcHMnIGlzIHNldCB0bw0KPiA+ID4gYWRkcmVz
c19zcGFjZV9vcGVyYXRpb25zIG9mIGV4aXN0aW5nIERBWCBmaWxlcywgaW5zdGVhZCBvZiAnZXh0
NF9kYXhfYW9wcycsDQo+ID4gPiBzaW5jZSBTX0RBWCBmbGFnIGlzIHNldCBhZnRlciBleHQ0X3Nl
dF9hb3BzKCkgaW4gdGhlIG9wZW4gcGF0aC4NCj4gPiA+IA0KPiA+ID4gICBOZXcgZmlsZQ0KPiA+
ID4gICAtLS0tLS0tLQ0KPiA+ID4gICBsb29rdXBfb3Blbg0KPiA+ID4gICAgIGV4dDRfY3JlYXRl
DQo+ID4gPiAgICAgICBfX2V4dDRfbmV3X2lub2RlDQo+ID4gPiAgICAgICAgIGV4dDRfc2V0X2lu
b2RlX2ZsYWdzICAgLy8gU2V0IFNfREFYIGZsYWcNCj4gPiA+ICAgICAgIGV4dDRfc2V0X2FvcHMg
ICAgICAgICAgICAvLyBTZXQgYW9wcyB0byBleHQ0X2RheF9hb3BzDQo+ID4gPiANCj4gPiA+ICAg
RXhpc3RpbmcgZmlsZQ0KPiA+ID4gICAtLS0tLS0tLS0tLS0tDQo+ID4gPiAgIGxvb2t1cF9vcGVu
DQo+ID4gPiAgICAgZXh0NF9sb29rdXANCj4gPiA+ICAgICAgIGV4dDRfaWdldA0KPiA+ID4gICAg
ICAgICBleHQ0X3NldF9hb3BzICAgICAgICAgIC8vIFNldCBhb3BzIHRvIGV4dDRfZGFfYW9wcw0K
PiA+ID4gICAgICAgICBleHQ0X3NldF9pbm9kZV9mbGFncyAgIC8vIFNldCBTX0RBWCBmbGFnDQo+
ID4gPiANCj4gPiA+IENoYW5nZSBleHQ0X2lnZXQoKSB0byBjYWxsIGV4dDRfc2V0X2lub2RlX2Zs
YWdzKCkgYmVmb3JlIGV4dDRfc2V0X2FvcHMoKS4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IDVmMDY2
M2JiNGE2NGY1ODhmMGEyZGQ2ZDFiZTY4ZDQwZjlhZjAwODYNCj4gPiANCj4gPiBTYW1lIGZvcm1h
dCBuaXQ6DQo+ID4gDQo+ID4gRml4ZXM6IDVmMDY2M2JiNGE2NCAoImV4dDQsIGRheDogaW50cm9k
dWNlIGV4dDRfZGF4X2FvcHMiKQ0KPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4g
PiANCj4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFRvc2hpIEthbmkgPHRvc2hpLmthbmlAaHBl
LmNvbT4NCj4gPiA+IENjOiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pg0KPiA+ID4gQ2M6IERhbiBX
aWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiA+ID4gQ2M6ICJUaGVvZG9yZSBU
cydvIiA8dHl0c29AbWl0LmVkdT4NCj4gPiA+IENjOiBBbmRyZWFzIERpbGdlciA8YWRpbGdlci5r
ZXJuZWxAZGlsZ2VyLmNhPg0KPiA+ID4gLS0tDQo+ID4gPiAgZnMvZXh0NC9pbm9kZS5jIHwgICAg
MyArKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9leHQ0L2lub2RlLmMgYi9mcy9leHQ0
L2lub2RlLmMNCj4gPiA+IGluZGV4IDc3NWNkOWI0YWY1NS4uOTNjYmJiODU5YzQwIDEwMDY0NA0K
PiA+ID4gLS0tIGEvZnMvZXh0NC9pbm9kZS5jDQo+ID4gPiArKysgYi9mcy9leHQ0L2lub2RlLmMN
Cj4gPiA+IEBAIC00OTk4LDYgKzQ5OTgsOCBAQCBzdHJ1Y3QgaW5vZGUgKmV4dDRfaWdldChzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1bnNpZ25lZCBsb25nIGlubykNCj4gPiA+ICAgICAgICAgaWYg
KHJldCkNCj4gPiA+ICAgICAgICAgICAgICAgICBnb3RvIGJhZF9pbm9kZTsNCj4gPiA+IA0KPiA+
ID4gKyAgICAgICBleHQ0X3NldF9pbm9kZV9mbGFncyhpbm9kZSk7DQo+ID4gPiArDQo+ID4gDQo+
ID4gSG1tLCBkb2VzIHRoaXMgaGF2ZSB1bmludGVuZGVkIGJlaGF2aW9yIGNoYW5nZXM/DQo+ID4g
DQo+ID4gSSBub3RpY2UgdGhhdCB0aGVyZSBhcmUgc29tZSBjaGVja3MgZm9yIGZsYWdzICJJU19B
UFBFTkQoaW5vZGUpIHx8DQo+ID4gSVNfSU1NVVRBQkxFKGlub2RlKSIgKmJlZm9yZSogdGhlIGNh
bGwgdG8gZXh0NF9zZXRfaW5vZGVfZmxhZ3MoKS4gSQ0KPiA+IGRpZG4ndCBsb29rIHRvbyBtdWNo
IGRlZXBlciBhdCB3aGV0aGVyIHRob3NlIGNoZWNrcyBhcmUgYm9ndXMsIGJ1dCBpdA0KPiA+IHdv
dWxkIHNlZW0gc2FmZXIgdG8gZG8gc29tZXRoaW5nIGxpa2UgdGhpcyBmb3IgYSBsb3dlciByaXNr
IGZpeC4NCj4gPiANCj4gPiBUaG91Z2h0cz8NCj4gDQo+IFdlbGwsIHNhZmVyIGJ1dCBpdCB3b3Vs
ZCBsZWF2ZSB0aGUgbGFuZG1pbmUgYXJvdW5kIGZvciBvdGhlcnMgdG8gaGl0Lg0KPiBUb3NoaSwg
cGxlYXNlIG1vdmUgdGhlIGV4dDRfc2V0X2lub2RlX2ZsYWdzKCkgY2FsbCB0byBiZSBqdXN0IGFm
dGVyIHRoZQ0KPiBhc3NpZ25tZW50Og0KPiANCj4gCWVpLT5pX2ZsYWdzID0gbGUzMl90b19jcHUo
cmF3X2lub2RlLT5pX2ZsYWdzKTsNCj4gDQo+IGluIGV4dDRfaWdldCgpLiBUaGF0IHdheSBwZW9w
bGUgd29uJ3QgaW50cm9kdWNlIGNoZWNrcyBmb3IgaV9mbGFncyB0aGF0IGNhbg0KPiBuZXZlciBo
aXQuLi4gQW5kIHllcywgaXQgZml4ZXMgYWxzbyBvdGhlciBidWdzIChtb3N0bHkgaW4gc2FuaXR5
IGNoZWNrcw0KPiBBRkFJQ1MpIHRoYW4gdGhlIERBWCBpc3N1ZS4NCg0KU3VyZS4gIEFzc3VtaW5n
IHlvdSB0aGluayB0aGUgaW1wbGljaXQgY2hhbmdlIERhbiBwb2ludGVkIG91dCBpcyBub3QgYQ0K
cHJvYmxlbSwgeWVzLCBJIHdpbGwgZ28gd2l0aCB0aGlzIGNsZWFuZXIgYXBwcm9hY2guDQoNClRo
YW5rcyENCi1Ub3NoaQ0KDQoNCg==
