Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E635C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A804D2151C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pJtctDce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A804D2151C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbeISTpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:45:03 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:44910
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731742AbeISTpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnKagYWEQL/fVSKoQUQwnQJZ08pCT1KrBr0pjDCf4sU=;
 b=pJtctDce1ILzhyJanYDyYNsJTju7Vma0W3uVEqsmzJjQWTqjpF90WJmE8A9FVG3A+4JIp4aY4DYWfpDGzxOibtVARsKYQvNRNL2GxHw+Ll5O5jtluO72WUsLVh0mT2Bw00mQqM/CCVDd17rIVFlg7yJNn9LvAbQOn0oHd2k0364=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3415.eurprd04.prod.outlook.com (52.133.19.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Wed, 19 Sep 2018 14:06:54 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::918c:7f25:5892:764]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::918c:7f25:5892:764%2]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 14:06:53 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH 18/21] arm64: dts: ls104xa: set mask to drop TBU ID from
 StreamID
Thread-Topic: [PATCH 18/21] arm64: dts: ls104xa: set mask to drop TBU ID from
 StreamID
Thread-Index: AQHUUBVvsr4P/EphukOhcC/AP3gJQaT3nNyAgAAHAYA=
Date:   Wed, 19 Sep 2018 14:06:53 +0000
Message-ID: <a4324a5b-abeb-f43a-cac3-7721577e183d@nxp.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
 <20180919123613.15092-19-laurentiu.tudor@nxp.com>
 <fe2af486-3d7d-a38f-ef62-6754f809298f@arm.com>
In-Reply-To: <fe2af486-3d7d-a38f-ef62-6754f809298f@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3415;6:4bmpt8V0vhbg2oJX1EEXB3Xos006SzPvFmaZCzKhpd2HnV2WzCqUB1Z8pMidzmy1N5D0++qy4IVuZ6JkYwI87Eb1w+XV8EsfjgtfHUQRVFx1mz/yhfsuKIuIHaCigomGuUh57xsyl8zX5/qBq7bB1ThnNJFMxe23W5M88a4SFn61GXjsqgpud1wW6xsxUjP83QI88zmc3uRHkpmbRVSdzGtQmpYY7OUY411cWjZMCbisc8EZUT3LNkCnIaar+tVtSjBKK1skupUPJBfZGLSKXk2nEdnkddCZF1rdmMhw6KfPrhNYOURQJTBC+7TIsxOoNGeY8oTBSJMp0+ckNM0Pjj2PLy9rX/NC1oX9Ou6P+i7oWXSw4oefjTalxJRi9AvT6Eek/u+Sdzksn+kBUtrt5ZHGtEyq3mFZ7PVNWi7mJcHwbweyeErQtrdhEHhSZLMWIjvwl3nuem9JgUWx52H2Rw==;5:JzfEjJWNh4YBRELkxsMsbl9ix2H6YR/7ifTBhdFa1LO9KxDFNGikMi8x8PtgJncGBOdkwqSHUwfY+bOGfwUKKmJvdR3XpQdnRmVYXDwzwfetD8Ks7cvAWmq8DOYcHdCSWp5Ciq8W5XDe/Hq6i486Za1bxen0+f8wxV+LMUEvAt0=;7:d8aZ9K1KPXb/fy39IeoRdKEwOpqNFu6oj3oE++rVpYM4Zsid3ItVg5rSmSClVAq3QfW7Nsv+Y85ccpWJ0wlvE/PTfimhWXU48lEqEyEAC/lhbFHz6jQXoM8xGQnDFvnXwuBHFak2blPqqW+oef9JN4WSI5q8/CsQixsdWov1b5rsKxdKH/u7cZaWYNO1aWpQYTtMSp7XuAeIQImSnEWTMb+OOGJn/lPPMHeMtAqobQJwW+pxGRTngpIu2qtieHUK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4ed67c71-7114-40f2-24ee-08d61e39273b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3415;
x-ms-traffictypediagnostic: AM6PR0402MB3415:
x-microsoft-antispam-prvs: <AM6PR0402MB3415935364A7F71B92C104AFEC1C0@AM6PR0402MB3415.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:AM6PR0402MB3415;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3415;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(366004)(376002)(199004)(189003)(66066001)(486006)(86362001)(229853002)(256004)(36756003)(6486002)(5250100002)(81156014)(2501003)(81166006)(6512007)(6436002)(76176011)(186003)(6346003)(2201001)(54906003)(476003)(11346002)(3846002)(31696002)(6116002)(102836004)(2616005)(99286004)(8676002)(478600001)(5660300001)(2900100001)(106356001)(25786009)(305945005)(44832011)(68736007)(53936002)(2906002)(4326008)(97736004)(446003)(26005)(110136005)(14454004)(105586002)(53546011)(8936002)(31686004)(6506007)(7736002)(6246003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3415;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-microsoft-antispam-message-info: OdqBZ742RY7SQqPmSLcbCuPV13lB9W2Q88GD8wxBNruV2SMJJZxgu3Q/dszj87dOvHHA/cbxtrk35lFW7OdZIqln4cOgL08aJEyL8oxgGNX+3r4QtDcJI7qTdCXTenVzLX7qsd938P2dL3sq6A+sCkQZFTNnfUD9ZGd1v2LDSGemJWHHcMOr7BdT/to+h9AN90Nnpr6QgUhAXQOkLKeu1J3kRC2kyYifrgVZ6Sv71vEkpeL5W+4g8kPLLP22CfVSwNM+29mHCykSHltRMC6ou0pQ0k4+r/HxbvJRnrtmVKjEhSYIMLFHF4CfxU5WfuLPILIlgPllCLhheVVCm1S10Xcb5Vfj0agXSZjCUdBLRlg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <322D58CA903F7142826549752DC6FA23@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed67c71-7114-40f2-24ee-08d61e39273b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 14:06:53.8799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sDQoNCk9uIDE5LjA5LjIwMTggMTY6NDEsIFJvYmluIE11cnBoeSB3cm90ZToNCj4g
T24gMTkvMDkvMTggMTM6MzYsIGxhdXJlbnRpdS50dWRvckBueHAuY29tIHdyb3RlOg0KPj4gRnJv
bTogTGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCj4+DQo+PiBUaGUg
U3RyZWFtSUQgZW50ZXJpbmcgdGhlIFNNTVUgaXMgYWN0dWFsbHkgYSBjb25jYXRlbmF0aW9uIG9m
IHRoZQ0KPj4gU01NVSBUQlUgSUQgYW5kIHRoZSBJQ0lEIGNvbmZpZ3VyZWQgaW4gc29mdHdhcmUu
DQo+PiBTaW5jZSB0aGUgVEJVIElEIGlzIGludGVybmFsIHRvIHRoZSBTb0MgYW5kIHNpbmNlIHdl
IHdhbnQgdGhhdCB0aGUNCj4+IGFjdHVhbCB0aGUgSUNJRCBjb25maWd1cmVkIGluIHNvZnR3YXJl
IHRvIGVudGVyIHRoZSBTTU1VIHdpdG91dCBhbnkNCj4+IGFkZGl0aW9uYWwgc2V0IGJpdHMsIG1h
c2sgb3V0IHRoZSBUQlUgSUQgYml0cyBhbmQgbGVhdmUgb25seSB0aGUNCj4+IHJlbGV2YW50IElD
SUQgYml0cyB0byBlbnRlciBTTU1VLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExhdXJlbnRpdSBU
dWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+PiAtLS0NCj4+IMKgIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDNhLmR0c2kgfCAxICsNCj4+IMKgIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLmR0c2kgfCAxICsNCj4+IMKgIDIgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDNhLmR0c2kgDQo+PiBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDNhLmR0c2kNCj4+IGluZGV4IDhiM2ViYTE2NzUw
OC4uOTAyOTZiOWZiMTcxIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWxzMTA0M2EuZHRzaQ0KPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWxzMTA0M2EuZHRzaQ0KPj4gQEAgLTIyNiw2ICsyMjYsNyBAQA0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJhcm0sbW11LTUwMCI7DQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MCAweDkwMDAwMDAgMCAweDQwMDAwMD47DQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWEtY29oZXJlbnQ7DQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJlYW0tbWF0Y2gtbWFzayA9IDwweDdmMDA+Ow0KPiANCj4gVGhlIFRC
VSBJRCBvbmx5IGZvcm1zIHRoZSB0b3AgNSBiaXRzLCBzbyBhbHNvIGlnbm9yaW5nIGJpdHMgOTo4
IHJhaXNlcyANCj4gYW4gZXllYnJvdyAtIGlmIHRoZSBMUzEwNHggU01NVSByZWFsbHkgaXMgY29u
ZmlndXJlZCBmb3IgOC1iaXQgU0lEIGlucHV0IA0KPiB0aGVuIGl0J3MgaGFybWxlc3MsIA0KDQpP
biB0aGVzZSBsb3dlci1lbmQgcGxhdGZvcm1zIHRoZSBTSUQgaW5wdXQgaXMgY29uZmlndXJlZCBh
bmQgZG9jdW1lbnRlZCANCmFzIDgtYml0Lg0KDQo+IGJ1dCBpZiBpdCdzIGFjdHVhbGx5IGEgOSBv
ciAxMC1iaXQgY29uZmlndXJhdGlvbiANCj4gdGhlbiB5b3UgcHJvYmFibHkgd2FudCB0byBhdm9p
ZCBtYXNraW5nIHRoZW0gKG9yIGF0IGxlYXN0IGRvY3VtZW50IHdoeSkgDQo+IC0gSUlSQyB0aGVy
ZSAqd2FzKiBzdHVmZiB3aXJlZCB0aGVyZSBvbiBMUzIwODUgYXQgbGVhc3QuDQoNClllcywgb24g
TFMycyB0aGVyZSBhcmUgMiBleHRyYS1iaXRzIGluIHRoZXJlIGNhcnJ5aW5nIHNvbWUgc2lnbmFs
aW5nLiANCkhvd2V2ZXIsIG9uIExTMXMgdGhleSBhcmUgbm90IHByZXNlbnQuDQoNCi0tLQ0KVGhh
bmtzICYgQmVzdCBSZWdhcmRzLCBMYXVyZW50aXUNCg0KPiANCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICNnbG9iYWwtaW50ZXJydXB0cyA9IDwyPjsNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICNpb21tdS1jZWxscyA9IDwxPjsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGludGVycnVwdHMgPSA8MCAxNDIgND4sIC8qIGdsb2JhbCBzZWN1cmUgZmF1bHQgKi8NCj4+
IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS5k
dHNpIA0KPj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS5kdHNp
DQo+PiBpbmRleCAwNjg2M2QzZTRhN2QuLjE1MDk0ZGQ4NDAwZSAxMDA2NDQNCj4+IC0tLSBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLmR0c2kNCj4+ICsrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLmR0c2kNCj4+IEBAIC0yMzIs
NiArMjMyLDcgQEANCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAi
YXJtLG1tdS01MDAiOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDAgMHg5
MDAwMDAwIDAgMHg0MDAwMDA+Ow0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG1hLWNv
aGVyZW50Ow0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RyZWFtLW1hdGNoLW1hc2sgPSA8
MHg3ZjAwPjsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNnbG9iYWwtaW50ZXJydXB0
cyA9IDwyPjsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNpb21tdS1jZWxscyA9IDwx
PjsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVycnVwdHMgPSA8MCAxNDIgND4s
IC8qIGdsb2JhbCBzZWN1cmUgZmF1bHQgKi8NCj4+
