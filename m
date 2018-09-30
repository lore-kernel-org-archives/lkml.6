Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38E8C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C8E20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c20PoqHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C8E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeI3RVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 13:21:07 -0400
Received: from mail-eopbgr00046.outbound.protection.outlook.com ([40.107.0.46]:17364
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728161AbeI3RVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 13:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4JFqFcVzKYH2wccuofs4y7JwJqPh68l4glUNdyTAWM=;
 b=c20PoqHBsw6CeenwoSWofru5dorLczBaWUXIeHayOXNj1pDKK/uceKUzXB5JRQDnloX/6Ccup2iPXOV4uGnjEIQUdNDYZjuqplwEAvlGak6C2ZzzyV+n5Ei6Axwv6YPBct8qzTv/U1yuOmbMfNQKN0M4LDi7w4aTXDr15MCsfXk=
Received: from AM0PR04MB4353.eurprd04.prod.outlook.com (52.134.125.146) by
 AM0PR04MB5267.eurprd04.prod.outlook.com (20.177.42.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Sun, 30 Sep 2018 10:48:32 +0000
Received: from AM0PR04MB4353.eurprd04.prod.outlook.com
 ([fe80::a5b0:6887:b5b8:671b]) by AM0PR04MB4353.eurprd04.prod.outlook.com
 ([fe80::a5b0:6887:b5b8:671b%2]) with mapi id 15.20.1185.024; Sun, 30 Sep 2018
 10:48:32 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: RE: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Topic: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Index: AQHUWJ+Hb3OQQDlcbEOvxAqFr7DrO6UImK+AgAAAnjCAAAldAIAAAh4A
Date:   Sun, 30 Sep 2018 10:48:31 +0000
Message-ID: <AM0PR04MB4353252D3D6703FA14BCE4BA97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930120425.7715cb29@bbrezillon>
        <AM0PR04MB4353635C85F0D744D090A14C97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
 <20180930124008.365831bf@bbrezillon>
In-Reply-To: <20180930124008.365831bf@bbrezillon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5267;6:Juz8Y6enPoHeJKMfM0+AWbDppvol1ifm81mvA71zeVj5gAuYPEyLQb33NHKrIRJ4rzFAw49EXXqh8V2TeCqpfJ7nsUBQUxdpJEiQ/njdyA80B+VbCAwQZbkDduElb+9MKIrRpcswtB2ukkCb8oSjwRI2b1miLcmoA7xjQi/EtbR0FRbfBBEEkSAoAJg9N/MQwHN2WJfJAG4JWvcNGLdif6dxPE3qJ5/f43jJDiZUcYtMzT9+J30eWC7hF00ylGC3WCRwFbv67xOuhX6qgoltHccdlYpKcSuTOX/DakYfnBwln8iEpyueM51KWuLPW0PjyF4Por8o8fd+0omH8bvfbPhU46+9oqe8KSggF0jI3yAfd8zuus6e/MyA32L7WF9UKqt1J7BfvwGRkhxy82mwNid2ptjvgBdP1I/ftteHl6/IRnu64ayOosbRiUj5h27aHu0tGnvkkXq3/29bMpWPhw==;5:b1n6ceyAFbO9hzheT1ateTM2OsLnAeo4AxXHTQGuOkXwHwGc0sUbIvymnAbSlr5fSlOjJ3bxqPU6ps6bmCKDiLezw1BrXINy0u19VGLk2FMU3no10EiLHezGvhnuLX+pJ8SkHDrt66IOyMcbFRCmjxKlClSi4Gl0HS2RFBf7VE0=;7:IWtveKIK8iRFoIU6h+XPGJ7qT2LK2QOfRaQgPRabo10lzzsf2307htZ+Bl/JpZx1JVPhaWgqDdoI1qxMjBSWjUulQjX5o6v49Slh6rmRDaa8o64Rw523dwvuFhteEpxp/mTODdyGW3xoDXdvHVoC+7DsKiCksy9ex4i6Y66oK8Te/iBMDFz2yvE/PHS49ITcOituNc5IqraYka2rqaZhQFs8QKKKF3gR+yx8uRVeBmc7RmHngjhl4w0arrzC/4hl
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 78fa8f59-5587-4c97-08c3-08d626c243a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5267;
x-ms-traffictypediagnostic: AM0PR04MB5267:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB52677873D9BA9666EB13589797EE0@AM0PR04MB5267.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB5267;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5267;
x-forefront-prvs: 08118EFC2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(396003)(366004)(376002)(39860400002)(136003)(13464003)(199004)(189003)(76176011)(7696005)(7736002)(66066001)(305945005)(99286004)(68736007)(229853002)(54906003)(33656002)(5660300001)(316002)(256004)(106356001)(93886005)(105586002)(74316002)(14444005)(5250100002)(6916009)(97736004)(6506007)(446003)(11346002)(53546011)(26005)(102836004)(486006)(476003)(186003)(6436002)(14454004)(44832011)(71190400001)(6116002)(3846002)(71200400001)(53936002)(6306002)(55016002)(9686003)(6246003)(4326008)(34290500001)(25786009)(2906002)(575784001)(86362001)(81156014)(81166006)(8676002)(2900100001)(8936002)(45080400002)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5267;H:AM0PR04MB4353.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kyTi9cYHPEC5Tzjb8O0Ls9+yQtKkBHr22bGJCzNnQDaJVK04DQRxRQE5kUYuIeEIPstfY/1yLS0bdGkNzCrDDsMnhpSoA65c2Xb3ONg/fwLTKSB4++7R5++c18jixb74s/CxRjvPfaJ+CFs3Cfkfzz4DjnEqYhLLs8zEbiSY2ymaxXwvqGuc2JJHRsVlm+5D6MPpESfuRPy167jcA0I1jxGq20xMFEOUkKHk5biDLd1UtlhKtlBLWn6GNqD+byL1KGgxCb2rvYM7GX87R0We/gZW+3DZOb/9PEW4vLcAPHaNMUXC4c6irUBROXJJCMctbdxZflC2cLmIZenW/lPhb2PSaILi+dcFeslZbGhVyPw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fa8f59-5587-4c97-08c3-08d626c243a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2018 10:48:31.9541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5267
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMgQnJlemlsbG9u
IDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IFNlbnQ6IDIwMTjlubQ55pyIMzDml6Ug
MTg6NDANCj4gVG86IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+DQo+IENjOiBi
cm9vbmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGVoYUBkZWlmLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYyIDEvNF0gc3BpOiBzcGktbWVtOiBBZGQgdGhlIHNwaV9zZXRfeGZlcl9icHcgZnVuY3Rpb24N
Cj4gDQo+IE9uIFN1biwgMzAgU2VwIDIwMTggMTA6MTg6MTggKzAwMDANCj4gQ2h1YW5odWEgSGFu
IDxjaHVhbmh1YS5oYW5AbnhwLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9u
QGJvb3RsaW4uY29tPg0KPiA+ID4gU2VudDogMjAxOOW5tDnmnIgzMOaXpSAxODowNA0KPiA+ID4g
VG86IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+DQo+ID4gPiBDYzogYnJvb25p
ZUBrZXJuZWwub3JnOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgZWhhQGRlaWYuY29tDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDEvNF0gc3BpOiBzcGktbWVtOiBBZGQgdGhlIHNwaV9zZXRfeGZlcl9icHcNCj4gPiA+
IGZ1bmN0aW9uDQo+ID4gPg0KPiA+ID4gSGkgQ2h1YW5odWEsDQo+ID4gPg0KPiA+ID4gT24gU3Vu
LCAzMCBTZXAgMjAxOCAxNzoyNTozMiArMDgwMA0KPiA+ID4gQ2h1YW5odWEgSGFuIDxjaHVhbmh1
YS5oYW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBCZWZvcmUgd2UgYWRkIHRoaXMg
c3BpX3RyYW5zZmVyIHRvIHRoZSBzcGlfbWVzc2FnZSBjaGFpbiB0YWJsZSwgd2UNCj4gPiA+ID4g
bmVlZCBiaXRzX3Blcl93b3JkX21hc2sgYmFzZWQgb24gc3BpX2NvbnRyb2wgdG8gc2V0IHRoZQ0K
PiA+ID4gPiBiaXRzX3Blcl93b3JkIG9mIHRoaXMgc3BpX3RyYW5zZmVyLg0KPiA+ID4NCj4gPiA+
IExldCdzIG1ha2UgaXQgY2xlYXJlcjogdGhpcyBpcyB3cm9uZy4gVGhlIHNwaS1tZW0gcHJvdG9j
b2wgaXMganVzdA0KPiA+ID4gdXNpbmcgYnl0ZXMsIG5vdCBjdXN0b20gc2l6ZSB3b3Jkcy4gRml4
IHRoZSBmc2wtZHNwaSBkcml2ZXIgaWYNCj4gPiA+IG5lZWRlZCwgYnV0IGRvbid0IHRyeSB0byBh
ZGp1c3QNCj4gPiA+IHhmZXItPmJpdHNfcGVyX3dvcmQgaW4gc3BpLW1lbS5jLCBiZWNhdXNlIHRo
aXMgaXMgaW5hcHByb3ByaWF0ZS4NCj4gPiBUaGUgdmFsdWUgb2YgYml0c19wZXJfd29yZCBpcyBv
bmx5IGtub3duIGJlZm9yZSB0aGUNCj4gPiBzcGlfbWVzc2FnZV9hZGRfdGFpbCBmdW5jdGlvbiBp
cyBjYWxsZWQsDQo+IA0KPiBObywgaXQncyBub3QuIEl0J3Mga25vd24gZnJvbSB0aGUgYmVnaW5u
aW5nLCBhbmQgc3BpX3NldHVwKCkgZGVmYXVsdHMgdG8gOCB3aGVuDQo+IHNwaWRldi0+Yml0c19w
ZXJfd29yZCBpcyAwLCB3aGljaCBpcyBleGFjdGx5IHdoYXQgd2Ugd2FudC4gVGhlbiwgd2hlbiB5
b3UNCj4gc2VuZCBhIG1lc3NhZ2UgdGhyb3VnaCwgc3BpX3N5bmMoKSwgc3BpX3ZhbGlkYXRlKCkg
bWFrZXMgc3VyZSB0aGF0IGVhY2gNCj4gdHJhbnNmZXIgaW4gdGhlIG1lc3NhZ2UgaGFzIGENCj4g
eGZlci0+Yml0c19wZXJfd29yZCAhPSAwIGFuZCB3aGVuIHRoYXQncyBub3QgdGhlIGNhc2UsIGl0
IHNldHMgaXQgdG8NCj4gc3BpLT5iaXRzX3Blcl93b3JkIFsyXS4NCj4gDQo+IFJlYWxseSwgdGhl
cmUncyBub3RoaW5nIHRvIGZpeCBpbiBzcGktbWVtLmMsIGJlY2F1c2UgaXQncyBhbHJlYWR5IGRv
aW5nIHRoZSByaWdodA0KPiB0aGluZyAobGVhdmluZyAtPmJpdHNfcGVyX3dvcmQgdG8gMCBzbyB0
aGF0IGl0J3Mgc2V0IHRvDQo+IHNwaS0+Yml0c19wZXJfd29yZCwgd2hpY2ggc2hvdWxkIGJlIDgp
LiBNYXliZSB3ZSBoYXZlIGEgYnVnIHNvbWV3aGVyZQ0KPiBlbHNlIHRob3VnaC4NCj4gDQo+IFsx
XWh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cHMlM0ElMkYlMkZlbGkNCj4geGlyLmJvb3RsaW4uY29tJTJGbGludXglMkZ2NC4xOS1yYzUlMkZz
b3VyY2UlMkZkcml2ZXJzJTJGc3BpJTJGc3BpLmMlMjMNCj4gTDI4MDMmYW1wO2RhdGE9MDIlN0Mw
MSU3Q2NodWFuaHVhLmhhbiU0MG54cC5jb20lN0M0ODY5NGQ1ZDdjZA0KPiBhNDYwYjNlMGIwOGQ2
MjZjMTFlM2YlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlNw0KPiBDMCU3
QzYzNjczOTAwODIxMjI4NzgxNCZhbXA7c2RhdGE9NXdZeUZhWmprOWtrYlp0UjB3MHVTMllGbGZO
akMNCj4gR3ozU044MFdzNTk5ajAlM0QmYW1wO3Jlc2VydmVkPTANCj4gWzJdaHR0cHM6Ly9lbWVh
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmVs
aQ0KPiB4aXIuYm9vdGxpbi5jb20lMkZsaW51eCUyRnY0LjE5LXJjNSUyRnNvdXJjZSUyRmRyaXZl
cnMlMkZzcGklMkZzcGkuYyUyMw0KPiBMMjg2OSZhbXA7ZGF0YT0wMiU3QzAxJTdDY2h1YW5odWEu
aGFuJTQwbnhwLmNvbSU3QzQ4Njk0ZDVkN2NkDQo+IGE0NjBiM2UwYjA4ZDYyNmMxMWUzZiU3QzY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3DQo+IEMwJTdDNjM2NzM5MDA4MjEy
Mjg3ODE0JmFtcDtzZGF0YT1pYndsJTJCWnVrJTJGTUxhZ3N1ZE5ldHdnZGENCj4gaFIxVlZLQnFJ
MkJ5TDYyMjVINTAlM0QmYW1wO3Jlc2VydmVkPTANCkknbGwgdGFrZSB0aGUgdGltZSB0byBzdHVk
eSB0aGlzLg0KT2N0b2JlciAxIHRvIE9jdG9iZXIgNyBpcyB0aGUgTmF0aW9uYWwgRGF5IG9mIG91
ciBjb3VudHJ5LiBJIG5lZWQgdG8gdGFrZSBhIHZhY2F0aW9uLg0KSSBtYXkgbm90IHJlcGx5IHRv
IHRoZSBlbWFpbCBpbiB0aW1lIGR1cmluZyB0aGlzIHBlcmlvZC4gDQpUaGFuayB5b3UgdmVyeSBt
dWNoIGZvciB5b3VyIHZhbHVhYmxlIGFkdmljZSEhIQ0K
