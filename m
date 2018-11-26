Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBA5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BEC2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="LmyOuSAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BEC2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeK0BOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:14:49 -0500
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:63199
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbeK0BOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNjathb5fssqQqfppx2Ju6XXyaxA9gOu693q8v1/nJM=;
 b=LmyOuSAtcg4cQBiVusbbfl6Tcr2B4mO9qqmtoMQcKpyX65AWdpQ5W3o4dXMcRP4CHXje96kbd5jt9hGWuFJk9AEIxNNHRcjHtJA/xeRxV0CW6RMUUHIbqRLnpPOLyuKEQmSL+CdRdEGz/ffkmHEf85CNxk54EyUsBQf/CN2zPNc=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5097.eurprd04.prod.outlook.com (20.176.235.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 14:20:27 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74%2]) with mapi id 15.20.1339.027; Mon, 26 Nov 2018
 14:20:27 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH fbdev-for-next 2/2] video: ssd1307fb: Add support for the
 reset-active-low property
Thread-Topic: [PATCH fbdev-for-next 2/2] video: ssd1307fb: Add support for the
 reset-active-low property
Thread-Index: AQHUcrw/3qwIrYVC/Uy4SnGDDmELb6VMa6yAgArjgYCAAHrgAIAKVqCAgAAXlgCAAAieAA==
Date:   Mon, 26 Nov 2018 14:20:27 +0000
Message-ID: <6636dd17-1f0f-dbad-0f9d-75e491885e91@ysoft.com>
References: <1541170556-75032-1-git-send-email-michal.vokac@ysoft.com>
 <1541170556-75032-2-git-send-email-michal.vokac@ysoft.com>
 <5bea0e9c.1c69fb81.1f3c8.be5a@mx.google.com>
 <db9537dc-2ba5-b8fc-ae3c-7d85841b0797@ysoft.com>
 <CAL_Jsq+KOqWVdudDGZNJSJ1SZSX1FK2GOSu-4VfmRV-KZrYJZA@mail.gmail.com>
 <f0389ca6-076b-b450-ffd5-d496627d1c58@ysoft.com>
 <CAL_JsqKninqSUJwcoH6+797r2zt_bviraPTUR2QhEp67EcNpgg@mail.gmail.com>
In-Reply-To: <CAL_JsqKninqSUJwcoH6+797r2zt_bviraPTUR2QhEp67EcNpgg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::36) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5097;6:PhVFUfhqtjQE7fsWiFYO/38zfpeO3QelNuchD9woPS9j1bs3XXl2ukzp3Kbqnzps6ZQX1rauBuIrEp9ofICrPqj7xgQTY65N5gDrCA3kycxzt4QHkREDy/dSTlWrTqYOMXKDuYqhjOn5nuQWedb9pz0uZy6LU0gg9pcqeT+2+EmXgl//PRdvvNJm1Zu2g6qvn6lk1FW0thCIVr7SaDDZO9+fzhTnzZbBmqfSQMQUzBC9dWwRADF6v4JaLB5UV6Tg351jFilQmUtwoX91BzB0TV/UXLGAElNGJgusQZ+16vXHYDUVBDrp+JFCUkHUjmIFRmMJkLY0/C+axhrllhh1z+Hyd/V7too7WmBhC2Gui2YrW545UrpkWb+3a3Nnwub7PyjZ+nA4MSOyrKIYbIhLimlJbz6P9LMzUYXXKP5bxXL0dBrg5WeoBnsGaCi9WhPgD0FRpBFjMcUQ1nAN2EWbiw==;5:ZBCFZ+sP+2TASq1lx7N2zSoTddgAvUAP1lGGy3xz2ueBOK+19iimRrv57O/KD4+dCWmXSGP+bivH4NpXLhRsYPMn7BWz4R/C1iLlVLHdr13gLu2B9fiNSM680VsheMiQYCFD/soyl3sE+yWLUobDE8fbONQZ7yFFSzoOxWlb35g=;7:bkh8KmD6oHo8SkD4Zuv89H9Sygoy5Gyu+6/peWSV48S6vI/gvmkKdcExwzkST9V8QOOxj6x3YkUaXZUVX1ZnRgM/yhWx1PSAgNCXzmgiwxvPCRD5LBV6jwBKGLAD1KmroHXUW977tF23AU++9HFJAg==
x-ms-office365-filtering-correlation-id: 9e77a635-0132-45c8-48b5-08d653aa502a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5097;
x-ms-traffictypediagnostic: DB7PR04MB5097:
x-microsoft-antispam-prvs: <DB7PR04MB5097B9CF70853F116813A8989ED70@DB7PR04MB5097.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231443)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5097;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5097;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(51444003)(256004)(14444005)(6436002)(71200400001)(102836004)(26005)(71190400001)(52116002)(76176011)(81156014)(53546011)(186003)(6506007)(386003)(229853002)(8936002)(81166006)(6486002)(93886005)(14454004)(305945005)(54906003)(36756003)(476003)(2616005)(11346002)(446003)(486006)(85182001)(3846002)(31686004)(6512007)(966005)(6306002)(6116002)(97736004)(4326008)(86362001)(5660300001)(68736007)(25786009)(31696002)(7736002)(53936002)(478600001)(99286004)(8676002)(66066001)(316002)(6916009)(105586002)(2906002)(72206003)(6246003)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5097;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d+ahAvRubEjj4aJD9QUtWusjmdEmI6bZRoez/SlfdLjn3qQabBhXN4w0I7eXdzNlIqjQK9hMNXxSbWLLHC07PgySrGRvrAUxr29XKX6gsJHV80YNTKocjEOEn1CTI2D4xU3kAimO4brhFUHEfmJa73NcQxP4hyFvUBStHDg54k2QS113Fts54+DaRYDWvDSA97jDHjRdvPm0shIUx7iR++kFL9lIwPHb0b4Qcq35qN0c6EYxCsQ5zn9nDeF/GbxOKEgWfDgm7OrnkPf+Bfkmd7rcpNaNbehOTDmiMNsA4z1ye7jTPc3HOzq32+ndxpeajCpxAorPcGLMezK0FYT5lReg36aDdRwSGfEJtpvtToA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB791B95054A034E8A1C8DDF5E5A74E0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e77a635-0132-45c8-48b5-08d653aa502a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 14:20:27.8529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMTEuMjAxOCAxNDo0OSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIE1vbiwgTm92IDI2
LCAyMDE4IGF0IDY6MjUgQU0gVm9rw6HEjSBNaWNoYWwgPE1pY2hhbC5Wb2thY0B5c29mdC5jb20+
IHdyb3RlOg0KPj4NCj4+IE9uIDE5LjExLjIwMTggMjM6MzIsIFJvYiBIZXJyaW5nIHdyb3RlOg0K
Pj4+IE9uIE1vbiwgTm92IDE5LCAyMDE4IGF0IDk6MTIgQU0gVm9rw6HEjSBNaWNoYWwgPE1pY2hh
bC5Wb2thY0B5c29mdC5jb20+IHdyb3RlOg0KPj4+PiBPbiAxMi4xMS4yMDE4IDE3OjU1LCBSb2Ig
SGVycmluZyB3cm90ZToNCj4+Pj4+IE9uIEZyaSwgTm92IDAyLCAyMDE4IGF0IDAyOjU2OjM1UE0g
KzAwMDAsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0KPj4+Pj4+IFRoZSBTU0QxMzB4IE9MRUQgZGlz
cGxheSByZXNldCBzaWduYWwgaXMgYWN0aXZlIGxvdy4gTm93IHRoZSByZXNldA0KPj4+Pj4+IHNl
cXVlbmNlIGlzIGltcGxlbWVudGVkIGluIHN1Y2ggYSB3YXkgdGhhdCBEVFMgYXV0aG9ycyBhcmUg
Zm9yY2VkIHRvDQo+Pj4+Pj4gZGVmaW5lIHRoZSByZXNldC1ncGlvcyBwcm9wZXJ0eSB3aXRoIEdQ
SU9fQUNUSVZFX0hJR0ggdG8gbWFrZSB0aGUgcmVzZXQNCj4+Pj4+PiB3b3JrLg0KPj4+Pj4+DQo+
Pj4+Pj4gQWRkIHRoZSByZXNldC1hY3RpdmUtbG93IHByb3BlcnR5IHNvIHRoZSBzaWduYWwgaXMg
aW52ZXJ0ZWQgb25jZSBhZ2Fpbg0KPj4+Pj4+IGFuZCB0aGUgR1BJT19BQ1RJVkVfTE9XIHdvcmsg
YXMgZXhwZWN0ZWQuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgVm9rw6HE
jSA8bWljaGFsLnZva2FjQHlzb2Z0LmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiAgICAgZHJpdmVy
cy92aWRlby9mYmRldi9zc2QxMzA3ZmIuYyB8IDYgKysrKy0tDQo+Pj4+Pj4gICAgIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9mYmRldi9zc2QxMzA3ZmIuYyBiL2RyaXZlcnMvdmlk
ZW8vZmJkZXYvc3NkMTMwN2ZiLmMNCj4+Pj4+PiBpbmRleCBlN2FlMTM1Li43OTBmMWM0IDEwMDY0
NA0KPj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvc3NkMTMwN2ZiLmMNCj4+Pj4+PiAr
KysgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5jDQo+Pj4+Pj4gQEAgLTYwOCw2ICs2
MDgsNyBAQCBzdGF0aWMgaW50IHNzZDEzMDdmYl9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xp
ZW50LA0KPj4+Pj4+ICAgICAgICBzdHJ1Y3QgZmJfZGVmZXJyZWRfaW8gKnNzZDEzMDdmYl9kZWZp
bzsNCj4+Pj4+PiAgICAgICAgdTMyIHZtZW1fc2l6ZTsNCj4+Pj4+PiAgICAgICAgc3RydWN0IHNz
ZDEzMDdmYl9wYXIgKnBhcjsNCj4+Pj4+PiArICAgIGJvb2wgcmVzZXRfYWN0aXZlX2xvdzsNCj4+
Pj4+PiAgICAgICAgdTggKnZtZW07DQo+Pj4+Pj4gICAgICAgIGludCByZXQ7DQo+Pj4+Pj4NCj4+
Pj4+PiBAQCAtNjcxLDYgKzY3Miw3IEBAIHN0YXRpYyBpbnQgc3NkMTMwN2ZiX3Byb2JlKHN0cnVj
dCBpMmNfY2xpZW50ICpjbGllbnQsDQo+Pj4+Pj4gICAgICAgIHBhci0+Y29tX3NlcSA9IG9mX3By
b3BlcnR5X3JlYWRfYm9vbChub2RlLCAic29sb21vbixjb20tc2VxIik7DQo+Pj4+Pj4gICAgICAg
IHBhci0+Y29tX2xycmVtYXAgPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobm9kZSwgInNvbG9tb24s
Y29tLWxycmVtYXAiKTsNCj4+Pj4+PiAgICAgICAgcGFyLT5jb21faW52ZGlyID0gb2ZfcHJvcGVy
dHlfcmVhZF9ib29sKG5vZGUsICJzb2xvbW9uLGNvbS1pbnZkaXIiKTsNCj4+Pj4+PiArICAgIHJl
c2V0X2FjdGl2ZV9sb3cgPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobm9kZSwgInJlc2V0LWFjdGl2
ZS1sb3ciKTsNCj4+Pj4+Pg0KPj4+Pj4+ICAgICAgICBwYXItPmNvbnRyYXN0ID0gMTI3Ow0KPj4+
Pj4+ICAgICAgICBwYXItPnZjb21oID0gcGFyLT5kZXZpY2VfaW5mby0+ZGVmYXVsdF92Y29taDsN
Cj4+Pj4+PiBAQCAtNzI4LDkgKzczMCw5IEBAIHN0YXRpYyBpbnQgc3NkMTMwN2ZiX3Byb2JlKHN0
cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQo+Pj4+Pj4NCj4+Pj4+PiAgICAgICAgaWYgKHBhci0+
cmVzZXQpIHsNCj4+Pj4+PiAgICAgICAgICAgICAgICAvKiBSZXNldCB0aGUgc2NyZWVuICovDQo+
Pj4+Pj4gLSAgICAgICAgICAgIGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwYXItPnJlc2V0LCAw
KTsNCj4+Pj4+PiArICAgICAgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBhci0+cmVz
ZXQsIHJlc2V0X2FjdGl2ZV9sb3cpOw0KPj4+Pj4+ICAgICAgICAgICAgICAgIHVkZWxheSg0KTsN
Cj4+Pj4+PiAtICAgICAgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBhci0+cmVzZXQs
IDEpOw0KPj4+Pj4+ICsgICAgICAgICAgICBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocGFyLT5y
ZXNldCwgIXJlc2V0X2FjdGl2ZV9sb3cpOw0KPj4+Pj4NCj4+Pj4+IEkgdGhpbmsgeW91IGFuZCB3
aG9tZXZlciB3cm90ZSB0aGUgb3JpZ2luYWwgY29kZSBhcmUgbWlzaW50ZXJwcmV0dGluZw0KPj4+
Pj4gaG93IHRoZSBncGlvZCBBUEkgd29ya3MuIDEgbWVhbnMgbWFrZSB0aGUgc2lnbmFsIGFjdGl2
ZSBhbmQgdGhpcyBjYXNlDQo+Pj4+PiBhY3RpdmUgaXMgbG93Lg0KPj4+Pg0KPj4+PiBJIHRvdGFs
bHkgYWdyZWUgYW5kIEkgdGhpbmsgSSB1bmRlcnN0YW5kIHRoYXQgY29ycmVjdGx5Lg0KPj4+Pg0K
Pj4+Pj4gSXQgaXMgc3RyYW5nZSwgYnV0IGRvZXMgbWVhbiBhIHJlc2V0IHNlcXVlbmNlIHNob3Vs
ZCBhbHdheXMgYmUgc2V0IHRvIGENCj4+Pj4+IDEgYW5kIHRoZW4gYSAwIGFuZCBpdCB3aWxsIHdv
cmsgd2l0aCBlaXRoZXIgcG9sYXJpdHkgaW4gdGhlIERULg0KPj4+Pg0KPj4+PiBJIGFncmVlIHRo
ZSByZXNldCBzaG91bGQgYmUgZG9uZSBhcyBhIDAgLT4gMSAtPiAwIHNlcXVlbmNlIGFuZCB0aGF0
IHNob3VsZA0KPj4+PiBqdXN0IHdvcmsuIFRoZSBwcm9ibGVtIGlzIGl0IGlzIGltcGxlbWVudGVk
IHZpY2UgdmVyc2EgYW5kIHNvIGl0IHdvcmtzIG9ubHkNCj4+Pj4gaWYgeW91IGhhdmUgR1BJT19B
Q1RJVkVfSElHSCBpbiBEVCBmb3IgYSBzaWduYWwgdGhhdCBpcyBhY3R1YWxseSBhY3RpdmUgbG93
Lg0KPj4+Pg0KPj4+PiBBbmQgd2hhdCBpdCBhY3R1YWxseSBkb2VzIGlzIHRoYXQgaXQgaG9sZHMg
dGhlIGNvbnRyb2xsZXIgaW4gcmVzZXQgc2luY2UNCj4+Pj4gdGhlIEdQSU8gaXMgc3VjY2Vzc2Z1
bGx5IGFjcXVpcmVkIChiZWNhdXNlIG9mIEdQSU9EX09VVF9MT1cgaGVyZSBbMV0pIGFuZA0KPj4+
PiBsYXRlciBvbiBpdCBvbmx5IHJlbGVhc2VzIHRoZSByZXNldC4NCj4+Pj4NCj4+Pj4gQXMgYSBE
VCBhdXRob3IgSSB3b3VsZCBsaWtlIHRvIHNvbWVob3cgY2xlYXJseSBzdGF0ZSB0aGF0IHRoZSBP
TEVEIGRpc3BsYXkNCj4+Pj4gdXNlcyBhY3RpdmUgbG93IHJlc2V0IGluIG15IERULg0KPj4+Pg0K
Pj4+PiBNeSBmaXJzdCBhdHRlbXB0IHRvIGZpeCB0aGlzIHdhcyB0byBjaGFuZ2UgdGhlIHJlc2V0
IHNlcXVlbmNlIFsyXS4NCj4+Pj4gSXQgd2FzIGFwcGxpZWQgYW5kIHRoZW4gcmV2ZXJ0ZWQgYXMg
aXQgaXMgbm90IGJhY2t3YXJkIGNvbXBhdGlibGUgd2l0aA0KPj4+PiBkZXBsb3llZCBEVEIgZmls
ZXMgWzNdLg0KPj4+Pg0KPj4+PiBbMV0gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgv
djQuMjAtcmMzL3NvdXJjZS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5jI0w1NzANCj4+
Pj4gWzJdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA2MTc3MjkvDQo+Pj4+
IFszXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNjE3NzMxLw0KPj4+DQo+
Pj4gT2theSwgbm93IEkgdW5kZXJzdGFuZCB0aGUgYmFja2dyb3VuZC4gV2UndmUgaGl0IHRoaXMg
c29tZXdoZXJlIGVsc2UgdG9vLg0KPj4+DQo+Pj4gUmF0aGVyIHRoYW4gaGF2ZSBhIGJpbmRpbmcg
ZGVtb25zdHJhdGluZyB3aGF0IG5vdCB0byBkbywgSSdkIGxpa2UgdG8NCj4+PiBmaXggdGhpcyBp
biBhbm90aGVyIHdheS4gSSBhbHNvIGRvbid0IHdhbnQgdG8gbGl2ZSB3aXRoIHRoaXMgZm9yZXZl
cg0KPj4+IHdoZW4gdGhlcmUncyBvbmx5IDEgYm9hcmQgYWZmZWN0ZWQgKGluIHRyZWUgYXQgbGVh
c3QpIGFuZCB0aGVyZSdzIG9ubHkNCj4+PiBhbiBBQkkgaWYgc29tZW9uZSBub3RpY2VzIChJJ20g
aGFwcHkgdGhvdWdoIHRoYXQgdGhlIG1haW50YWluZXJzDQo+Pj4gY2F1Z2h0IHRoaXMpLiBUaGVy
ZSdzIDIgb3RoZXIgb3B0aW9ucy4gVGhlIDFzdCBpcyBhZGQgYSBmaXh1cCB0byB0aGUNCj4+PiBE
VCBmb3IgdGhpcyBwbGF0Zm9ybSB0byBlbnN1cmUgdGhhdCB0aGUgR1BJTyBpcyBjb25maWd1cmVk
IGFjdGl2ZSBsb3cNCj4+PiAodGhlIFZlcnNhdGlsZSBwbGF0Zm9ybSBjb2RlIGhhcyBhbiBleGFt
cGxlIGZpeHVwKS4gV2l0aCB0aGF0LCBhcHBseQ0KPj4+IHdoYXQgd2FzIG9yaWdpbmFsbHkgYXBw
bGllZCAob3IgcmV2ZXJ0IHRoZSByZXZlcnQpLiBUaGUgZml4dXAgY291bGQgYmUNCj4+PiBhcHBs
aWVkIG9ubHkgYWZ0ZXIgc29tZW9uZSBjb21wbGFpbnMgdGhlaXIgZGlzcGxheSBicm9rZS4gVGhl
IDJuZA0KPj4+IG9wdGlvbiBpcyBqdXN0IGFkZCBhbiBvZl9tYWNoaW5lX2lzX2NvbXBhdGlibGUg
Y2hlY2sgd2l0aGluIHRoaXMNCj4+PiBkcml2ZXIuIEluIHRoYXQgY2FzZSwgeW91IHdvdWxkbid0
IGZpeCBkdHMgZmlsZSBmb3IgdGhlIHBsYXRmb3JtDQo+Pj4gKHVubGVzcyB5b3UgYWxzbyB3YW50
IHRvIG1hbnVhbGx5IGNoZWNrIHJlc2V0LWdwaW9zKS4NCj4+DQo+PiBIaSBSb2IsDQo+Pg0KPj4g
SSBhbSBzdGlsbCB0cnlpbmcgdG8gZmlndXJlIG91dCB3aGF0IGV4YWN0bHkgeW91IG1lYW50IGJ5
IHRoZSAxc3QgYW5kDQo+PiAybmQgb3B0aW9uLiBCb3RoIGNvbmNlcHRzIGFyZSBuZXcgdG8gbWUu
DQo+Pg0KPj4gUmVnYXJkaW5nIHRoZSAxc3Qgb3B0aW9uLCB3aGF0IHlvdSBtZWFudCBieSAidGhp
cyBwbGF0Zm9ybSIgaGVyZToNCj4+PiBBZGQgYSBmaXh1cCB0byB0aGUgRFQgZm9yIHRoaXMgcGxh
dGZvcm0NCj4+IFRoZSBvbmx5IGJvYXJkIGluIHRyZWUgdGhhdCB1c2VzIHRoZSBPTEVEIChpbXgy
OC1jZmExMDAzNikgYW5kIGl0cw0KPj4gZHRzIGZpbGU/DQo+IA0KPiBZZXMsIHRoYXQgb25lLg0K
PiANCj4+IEkgYW0gYWxzbyBub3Qgc3VyZSB3aGVyZSB0byBsb29rIGZvciB0aGUgZXhhbXBsZS4g
V2hlbiB5b3Ugc2F5DQo+PiBWZXJzYXRpbGUgcGxhdGZvcm0gY29kZSBJIHRlbmQgdG8gbG9vayBp
bnRvIHBsYXQtdmVyc2F0aWxlIG9yDQo+PiBtYWNoLXZlcnNhdGlsZS4gSSBjb3VsZCBub3QgZmlu
ZCBhbnl0aGluZyBJIGNvdWxkIHVzZSBhcyBhbiBleGFtcGxlDQo+PiBpbiB0aGVyZS4gSSB0aGlu
ayB0aGF0IGlzIG5vdCB3aGF0IHlvdSBtZWFudC4NCj4gDQo+IFNlZSB2ZXJzYXRpbGVfZHRfcGNp
X2luaXQoKS4gT3IgbG9vayBmb3Igb3RoZXIgY2FsbGVycyBvZiBvZl91cGRhdGVfcHJvcGVydHko
KS4NCg0KRXhjZWxsZW50LCBJIHdpbGwgbG9vayBhdCB0aGF0Lg0KICANCj4+IFJlZ2FyZGluZyB0
aGUgMm5kIG9wdGlvbiwgeW91IHN1Z2dlc3QgdG8gdXNlIG9mX21hY2hpbmVfaXNfY29tcGF0aWJs
ZQ0KPj4gdG8gZGVjaWRlIHdoYXQgcmVzZXQgc2VxdWVuY2UgdG8gdXNlPyBJbiBjYXNlIG9mIGlt
eDI4LWNmYTEwMDM2IHVzZQ0KPj4gdGhlIG9sZCAwIC0+IDEsIGluIGFsbCBvdGhlciBjYXNlcyB1
c2UgYSBuZXcgY29ycmVjdCBzZXF1ZW5jZSAxIC0+IDA/DQo+PiBUaGF0IGFsc28gZG9lcyBub3Qg
c2VlbSByaWdodC4NCj4gDQo+IENvcnJlY3QuIFRob3VnaCBpZiB5b3UgZml4IGlteDI4LWNmYTEw
MDM2IGR0cywgdGhlbiB5b3UgaGF2ZSB0byBoYW5kbGUNCj4gdGhhdCBjYXNlIHRvby4NCj4gDQo+
IFdoeSBpcyBpdCBub3QgcmlnaHQ/IFVnbHkgeWVzLCBidXQgaXQncyBub3Qgd3JvbmcuDQoNClVn
bHkgaXMgd2hhdCBJIHByb2JhYmx5IG1lYW50LiBJdCBzZWVtcyBsaWtlIG90aGVyIHVzZXJzIChh
bW9uZyBkcml2ZXJzKQ0Kb2Ygb2ZfbWFjaGluZV9pc19jb21wYXRpYmxlIGFyZSBtb3N0bHkgZHJp
dmVycyBmb3IgSVAgYmxvY2tzIHRoYXQgbmVlZA0Kc2xpZ2h0bHkgZGlmZmVyZW50IGhhbmRsaW5n
IG9uIGRpZmZlcmVudCBTb0MgdmFyaWFudHMuDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2gsDQpNaWNo
YWwNCg==
