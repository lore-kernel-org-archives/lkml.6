Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD63DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1B920664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="nai1tPX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1B920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeKZXTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:19:22 -0500
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:47712
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbeKZXTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0gCiw9FV6h9Pqgr30dSyRMRlEg79p6Qs5M3c67hjJ0=;
 b=nai1tPX8qQktejDH2ptaaA8nx26KB48w9ghVUYjasytclrwWuR71TZI1Yn6+79DUUwx43m+aEMbKnWJEtBJbe6sEOY3KLGlK1HaQNIkua4dI1j155eTcsx4Ux6OfIntdMDlY31j/cyofhiBoVBZVig+ZGEKLv+oapsVo7RBQ350=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4073.eurprd04.prod.outlook.com (52.135.130.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Mon, 26 Nov 2018 12:25:14 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74%2]) with mapi id 15.20.1339.027; Mon, 26 Nov 2018
 12:25:14 +0000
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
Thread-Index: AQHUcrw/3qwIrYVC/Uy4SnGDDmELb6VMa6yAgArjgYCAAHrgAIAKVqCA
Date:   Mon, 26 Nov 2018 12:25:14 +0000
Message-ID: <f0389ca6-076b-b450-ffd5-d496627d1c58@ysoft.com>
References: <1541170556-75032-1-git-send-email-michal.vokac@ysoft.com>
 <1541170556-75032-2-git-send-email-michal.vokac@ysoft.com>
 <5bea0e9c.1c69fb81.1f3c8.be5a@mx.google.com>
 <db9537dc-2ba5-b8fc-ae3c-7d85841b0797@ysoft.com>
 <CAL_Jsq+KOqWVdudDGZNJSJ1SZSX1FK2GOSu-4VfmRV-KZrYJZA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+KOqWVdudDGZNJSJ1SZSX1FK2GOSu-4VfmRV-KZrYJZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0034.eurprd07.prod.outlook.com
 (2603:10a6:800:90::20) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4073;6:h6HN46vEGUBv1F2yu9IEf2ftBTy23QXdcgsqH07Z/smNCBcxZyrGiNwtuyasEInZEeYlvQ+WM3jGEaJqVN4TXWok6Yy3JEUTj1QYZcXDgcsgSSAvzT0WH/KD05AmXJ1SV4Axn9pOsKNreLB6tJNqrTlCBZXvaBhbGrW/0VUfEYv0hUrU4pr5i9zgak0fbccewrpL2p47F2X8lX4PjbuIM7gSyPRj7RpuacRuVGlwajKhNjefPU1OnGPym9nVMQCioKPWxXlH22bQCSL0poAYzINn/2x2eRLOPPaHZvOr3sLaWAyn1rOBt+ssx9G9VxQ3oDK01H9fJjLXouvbVJ93VkUHaQNJkka+r16W2rpuCkZ/1COZ0gMYryt9gOZY5w6vCLXroR5oQn4RIIBr+DbWt5oRgCyrKAQ2SjC3CBqEUr3ioz7LfqwrAzJfiXK46falWYsqYCEWd2ed6VAMbP3gpA==;5:UHfNIbiZ51pqSSGA/NMXSdoV6zvQihUu8beRsPJ5VUXjx4MNuJZo8xHdUMfgO1DFXViKWeu1ZEBRjmo5CMmrGKEgWW/Z97XsFhNHE8oOsbNhmQ6R6G/9bq9bzDcHEKLlQ9jqEu4VtkXGJgdM6pDQKuAOlj2pzSNpMifZhq7kgJ0=;7:HFVjP0TyWn5v7PFhy3y4zHghqqMbwM6fsGvFYGbelRTofGVQSQEcf3Ip/qTX8M53b2hIA4Z/3wSuPpdBP1NtbXR82tu2Dx6sgwK4TwtW9xkFyI1VGR3YrJqpgqizm/Bte+PHtKPcLbnhelTm1jg4Ww==
x-ms-office365-filtering-correlation-id: ad0a1568-a6a7-4bea-8b79-08d6539a372f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4073;
x-ms-traffictypediagnostic: DB7PR04MB4073:
x-microsoft-antispam-prvs: <DB7PR04MB40737A32613640F276BF9EB59ED70@DB7PR04MB4073.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231443)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(20161123555045)(201703061421075)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4073;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4073;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(189003)(199004)(51444003)(7736002)(6306002)(97736004)(2906002)(6512007)(476003)(25786009)(2616005)(6246003)(71200400001)(256004)(305945005)(71190400001)(486006)(54906003)(36756003)(5660300001)(14444005)(66066001)(446003)(86362001)(31696002)(68736007)(508600001)(6506007)(14454004)(53546011)(386003)(3846002)(229853002)(4326008)(76176011)(6436002)(6116002)(26005)(966005)(102836004)(72206003)(105586002)(81166006)(81156014)(8676002)(85182001)(99286004)(8936002)(186003)(53936002)(106356001)(6916009)(52116002)(6486002)(93886005)(31686004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4073;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xGj65ZfcRW5ZeBp5SGNdtrPkCfjer4igI/I5SfmjZxbPosuTSv48cdBj6Dmb1fZMEQcJDQcEdIn00LjIdFSXt27L5b2DWYhsjN+9J9OkwjUQxx/xABQ4sYZNIzTPNzIVbqH+4yRfGAdW7Jsyv0zmgGPjGH/HChPyM3spJR4EEE7f+bylNavMJ0G5awId8kRQb+bGfxIYKMHgW6q09ylzSIIOWpYCCbT/WZAc/SLmjC0OlD5iGKD2ASQnwzIc+9ku8CvsfTdSN0W8dxFdNjwUs2kluhjJre3LP4fFe9C/ZyiPeT2YP8PJQgNFsCLpGDnlJQNY94mOVH+a7gsDqbrLf2H+BR2zUM/dbT5GHP9QQA0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F2392637A1DEE4EAC212417A4264009@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0a1568-a6a7-4bea-8b79-08d6539a372f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 12:25:14.5123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMTEuMjAxOCAyMzozMiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIE1vbiwgTm92IDE5
LCAyMDE4IGF0IDk6MTIgQU0gVm9rw6HEjSBNaWNoYWwgPE1pY2hhbC5Wb2thY0B5c29mdC5jb20+
IHdyb3RlOg0KPj4gT24gMTIuMTEuMjAxOCAxNzo1NSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+Pj4g
T24gRnJpLCBOb3YgMDIsIDIwMTggYXQgMDI6NTY6MzVQTSArMDAwMCwgVm9rw6HEjSBNaWNoYWwg
d3JvdGU6DQo+Pj4+IFRoZSBTU0QxMzB4IE9MRUQgZGlzcGxheSByZXNldCBzaWduYWwgaXMgYWN0
aXZlIGxvdy4gTm93IHRoZSByZXNldA0KPj4+PiBzZXF1ZW5jZSBpcyBpbXBsZW1lbnRlZCBpbiBz
dWNoIGEgd2F5IHRoYXQgRFRTIGF1dGhvcnMgYXJlIGZvcmNlZCB0bw0KPj4+PiBkZWZpbmUgdGhl
IHJlc2V0LWdwaW9zIHByb3BlcnR5IHdpdGggR1BJT19BQ1RJVkVfSElHSCB0byBtYWtlIHRoZSBy
ZXNldA0KPj4+PiB3b3JrLg0KPj4+Pg0KPj4+PiBBZGQgdGhlIHJlc2V0LWFjdGl2ZS1sb3cgcHJv
cGVydHkgc28gdGhlIHNpZ25hbCBpcyBpbnZlcnRlZCBvbmNlIGFnYWluDQo+Pj4+IGFuZCB0aGUg
R1BJT19BQ1RJVkVfTE9XIHdvcmsgYXMgZXhwZWN0ZWQuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IE1pY2hhbCBWb2vDocSNIDxtaWNoYWwudm9rYWNAeXNvZnQuY29tPg0KPj4+PiAtLS0NCj4+
Pj4gICAgZHJpdmVycy92aWRlby9mYmRldi9zc2QxMzA3ZmIuYyB8IDYgKysrKy0tDQo+Pj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+DQo+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5jIGIvZHJpdmVy
cy92aWRlby9mYmRldi9zc2QxMzA3ZmIuYw0KPj4+PiBpbmRleCBlN2FlMTM1Li43OTBmMWM0IDEw
MDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5jDQo+Pj4+ICsr
KyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvc3NkMTMwN2ZiLmMNCj4+Pj4gQEAgLTYwOCw2ICs2MDgs
NyBAQCBzdGF0aWMgaW50IHNzZDEzMDdmYl9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50
LA0KPj4+PiAgICAgICBzdHJ1Y3QgZmJfZGVmZXJyZWRfaW8gKnNzZDEzMDdmYl9kZWZpbzsNCj4+
Pj4gICAgICAgdTMyIHZtZW1fc2l6ZTsNCj4+Pj4gICAgICAgc3RydWN0IHNzZDEzMDdmYl9wYXIg
KnBhcjsNCj4+Pj4gKyAgICBib29sIHJlc2V0X2FjdGl2ZV9sb3c7DQo+Pj4+ICAgICAgIHU4ICp2
bWVtOw0KPj4+PiAgICAgICBpbnQgcmV0Ow0KPj4+Pg0KPj4+PiBAQCAtNjcxLDYgKzY3Miw3IEBA
IHN0YXRpYyBpbnQgc3NkMTMwN2ZiX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQo+
Pj4+ICAgICAgIHBhci0+Y29tX3NlcSA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChub2RlLCAic29s
b21vbixjb20tc2VxIik7DQo+Pj4+ICAgICAgIHBhci0+Y29tX2xycmVtYXAgPSBvZl9wcm9wZXJ0
eV9yZWFkX2Jvb2wobm9kZSwgInNvbG9tb24sY29tLWxycmVtYXAiKTsNCj4+Pj4gICAgICAgcGFy
LT5jb21faW52ZGlyID0gb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5vZGUsICJzb2xvbW9uLGNvbS1p
bnZkaXIiKTsNCj4+Pj4gKyAgICByZXNldF9hY3RpdmVfbG93ID0gb2ZfcHJvcGVydHlfcmVhZF9i
b29sKG5vZGUsICJyZXNldC1hY3RpdmUtbG93Iik7DQo+Pj4+DQo+Pj4+ICAgICAgIHBhci0+Y29u
dHJhc3QgPSAxMjc7DQo+Pj4+ICAgICAgIHBhci0+dmNvbWggPSBwYXItPmRldmljZV9pbmZvLT5k
ZWZhdWx0X3Zjb21oOw0KPj4+PiBAQCAtNzI4LDkgKzczMCw5IEBAIHN0YXRpYyBpbnQgc3NkMTMw
N2ZiX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQo+Pj4+DQo+Pj4+ICAgICAgIGlm
IChwYXItPnJlc2V0KSB7DQo+Pj4+ICAgICAgICAgICAgICAgLyogUmVzZXQgdGhlIHNjcmVlbiAq
Lw0KPj4+PiAtICAgICAgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBhci0+cmVzZXQs
IDApOw0KPj4+PiArICAgICAgICAgICAgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBhci0+cmVz
ZXQsIHJlc2V0X2FjdGl2ZV9sb3cpOw0KPj4+PiAgICAgICAgICAgICAgIHVkZWxheSg0KTsNCj4+
Pj4gLSAgICAgICAgICAgIGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwYXItPnJlc2V0LCAxKTsN
Cj4+Pj4gKyAgICAgICAgICAgIGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwYXItPnJlc2V0LCAh
cmVzZXRfYWN0aXZlX2xvdyk7DQo+Pj4NCj4+PiBJIHRoaW5rIHlvdSBhbmQgd2hvbWV2ZXIgd3Jv
dGUgdGhlIG9yaWdpbmFsIGNvZGUgYXJlIG1pc2ludGVycHJldHRpbmcNCj4+PiBob3cgdGhlIGdw
aW9kIEFQSSB3b3Jrcy4gMSBtZWFucyBtYWtlIHRoZSBzaWduYWwgYWN0aXZlIGFuZCB0aGlzIGNh
c2UNCj4+PiBhY3RpdmUgaXMgbG93Lg0KPj4NCj4+IEkgdG90YWxseSBhZ3JlZSBhbmQgSSB0aGlu
ayBJIHVuZGVyc3RhbmQgdGhhdCBjb3JyZWN0bHkuDQo+Pg0KPj4+IEl0IGlzIHN0cmFuZ2UsIGJ1
dCBkb2VzIG1lYW4gYSByZXNldCBzZXF1ZW5jZSBzaG91bGQgYWx3YXlzIGJlIHNldCB0byBhDQo+
Pj4gMSBhbmQgdGhlbiBhIDAgYW5kIGl0IHdpbGwgd29yayB3aXRoIGVpdGhlciBwb2xhcml0eSBp
biB0aGUgRFQuDQo+Pg0KPj4gSSBhZ3JlZSB0aGUgcmVzZXQgc2hvdWxkIGJlIGRvbmUgYXMgYSAw
IC0+IDEgLT4gMCBzZXF1ZW5jZSBhbmQgdGhhdCBzaG91bGQNCj4+IGp1c3Qgd29yay4gVGhlIHBy
b2JsZW0gaXMgaXQgaXMgaW1wbGVtZW50ZWQgdmljZSB2ZXJzYSBhbmQgc28gaXQgd29ya3Mgb25s
eQ0KPj4gaWYgeW91IGhhdmUgR1BJT19BQ1RJVkVfSElHSCBpbiBEVCBmb3IgYSBzaWduYWwgdGhh
dCBpcyBhY3R1YWxseSBhY3RpdmUgbG93Lg0KPj4NCj4+IEFuZCB3aGF0IGl0IGFjdHVhbGx5IGRv
ZXMgaXMgdGhhdCBpdCBob2xkcyB0aGUgY29udHJvbGxlciBpbiByZXNldCBzaW5jZQ0KPj4gdGhl
IEdQSU8gaXMgc3VjY2Vzc2Z1bGx5IGFjcXVpcmVkIChiZWNhdXNlIG9mIEdQSU9EX09VVF9MT1cg
aGVyZSBbMV0pIGFuZA0KPj4gbGF0ZXIgb24gaXQgb25seSByZWxlYXNlcyB0aGUgcmVzZXQuDQo+
Pg0KPj4gQXMgYSBEVCBhdXRob3IgSSB3b3VsZCBsaWtlIHRvIHNvbWVob3cgY2xlYXJseSBzdGF0
ZSB0aGF0IHRoZSBPTEVEIGRpc3BsYXkNCj4+IHVzZXMgYWN0aXZlIGxvdyByZXNldCBpbiBteSBE
VC4NCj4+DQo+PiBNeSBmaXJzdCBhdHRlbXB0IHRvIGZpeCB0aGlzIHdhcyB0byBjaGFuZ2UgdGhl
IHJlc2V0IHNlcXVlbmNlIFsyXS4NCj4+IEl0IHdhcyBhcHBsaWVkIGFuZCB0aGVuIHJldmVydGVk
IGFzIGl0IGlzIG5vdCBiYWNrd2FyZCBjb21wYXRpYmxlIHdpdGgNCj4+IGRlcGxveWVkIERUQiBm
aWxlcyBbM10uDQo+Pg0KPj4gWzFdIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y0
LjIwLXJjMy9zb3VyY2UvZHJpdmVycy92aWRlby9mYmRldi9zc2QxMzA3ZmIuYyNMNTcwDQo+PiBb
Ml0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDYxNzcyOS8NCj4+IFszXSBo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNjE3NzMxLw0KPiANCj4gT2theSwg
bm93IEkgdW5kZXJzdGFuZCB0aGUgYmFja2dyb3VuZC4gV2UndmUgaGl0IHRoaXMgc29tZXdoZXJl
IGVsc2UgdG9vLg0KPiANCj4gUmF0aGVyIHRoYW4gaGF2ZSBhIGJpbmRpbmcgZGVtb25zdHJhdGlu
ZyB3aGF0IG5vdCB0byBkbywgSSdkIGxpa2UgdG8NCj4gZml4IHRoaXMgaW4gYW5vdGhlciB3YXku
IEkgYWxzbyBkb24ndCB3YW50IHRvIGxpdmUgd2l0aCB0aGlzIGZvcmV2ZXINCj4gd2hlbiB0aGVy
ZSdzIG9ubHkgMSBib2FyZCBhZmZlY3RlZCAoaW4gdHJlZSBhdCBsZWFzdCkgYW5kIHRoZXJlJ3Mg
b25seQ0KPiBhbiBBQkkgaWYgc29tZW9uZSBub3RpY2VzIChJJ20gaGFwcHkgdGhvdWdoIHRoYXQg
dGhlIG1haW50YWluZXJzDQo+IGNhdWdodCB0aGlzKS4gVGhlcmUncyAyIG90aGVyIG9wdGlvbnMu
IFRoZSAxc3QgaXMgYWRkIGEgZml4dXAgdG8gdGhlDQo+IERUIGZvciB0aGlzIHBsYXRmb3JtIHRv
IGVuc3VyZSB0aGF0IHRoZSBHUElPIGlzIGNvbmZpZ3VyZWQgYWN0aXZlIGxvdw0KPiAodGhlIFZl
cnNhdGlsZSBwbGF0Zm9ybSBjb2RlIGhhcyBhbiBleGFtcGxlIGZpeHVwKS4gV2l0aCB0aGF0LCBh
cHBseQ0KPiB3aGF0IHdhcyBvcmlnaW5hbGx5IGFwcGxpZWQgKG9yIHJldmVydCB0aGUgcmV2ZXJ0
KS4gVGhlIGZpeHVwIGNvdWxkIGJlDQo+IGFwcGxpZWQgb25seSBhZnRlciBzb21lb25lIGNvbXBs
YWlucyB0aGVpciBkaXNwbGF5IGJyb2tlLiBUaGUgMm5kDQo+IG9wdGlvbiBpcyBqdXN0IGFkZCBh
biBvZl9tYWNoaW5lX2lzX2NvbXBhdGlibGUgY2hlY2sgd2l0aGluIHRoaXMNCj4gZHJpdmVyLiBJ
biB0aGF0IGNhc2UsIHlvdSB3b3VsZG4ndCBmaXggZHRzIGZpbGUgZm9yIHRoZSBwbGF0Zm9ybQ0K
PiAodW5sZXNzIHlvdSBhbHNvIHdhbnQgdG8gbWFudWFsbHkgY2hlY2sgcmVzZXQtZ3Bpb3MpLg0K
DQpIaSBSb2IsDQoNCkkgYW0gc3RpbGwgdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgd2hhdCBleGFjdGx5
IHlvdSBtZWFudCBieSB0aGUgMXN0IGFuZA0KMm5kIG9wdGlvbi4gQm90aCBjb25jZXB0cyBhcmUg
bmV3IHRvIG1lLg0KDQpSZWdhcmRpbmcgdGhlIDFzdCBvcHRpb24sIHdoYXQgeW91IG1lYW50IGJ5
ICJ0aGlzIHBsYXRmb3JtIiBoZXJlOg0KPiBBZGQgYSBmaXh1cCB0byB0aGUgRFQgZm9yIHRoaXMg
cGxhdGZvcm0NClRoZSBvbmx5IGJvYXJkIGluIHRyZWUgdGhhdCB1c2VzIHRoZSBPTEVEIChpbXgy
OC1jZmExMDAzNikgYW5kIGl0cw0KZHRzIGZpbGU/DQoNCkkgYW0gYWxzbyBub3Qgc3VyZSB3aGVy
ZSB0byBsb29rIGZvciB0aGUgZXhhbXBsZS4gV2hlbiB5b3Ugc2F5DQpWZXJzYXRpbGUgcGxhdGZv
cm0gY29kZSBJIHRlbmQgdG8gbG9vayBpbnRvIHBsYXQtdmVyc2F0aWxlIG9yDQptYWNoLXZlcnNh
dGlsZS4gSSBjb3VsZCBub3QgZmluZCBhbnl0aGluZyBJIGNvdWxkIHVzZSBhcyBhbiBleGFtcGxl
DQppbiB0aGVyZS4gSSB0aGluayB0aGF0IGlzIG5vdCB3aGF0IHlvdSBtZWFudC4NCg0KUmVnYXJk
aW5nIHRoZSAybmQgb3B0aW9uLCB5b3Ugc3VnZ2VzdCB0byB1c2Ugb2ZfbWFjaGluZV9pc19jb21w
YXRpYmxlDQp0byBkZWNpZGUgd2hhdCByZXNldCBzZXF1ZW5jZSB0byB1c2U/IEluIGNhc2Ugb2Yg
aW14MjgtY2ZhMTAwMzYgdXNlDQp0aGUgb2xkIDAgLT4gMSwgaW4gYWxsIG90aGVyIGNhc2VzIHVz
ZSBhIG5ldyBjb3JyZWN0IHNlcXVlbmNlIDEgLT4gMD8NClRoYXQgYWxzbyBkb2VzIG5vdCBzZWVt
IHJpZ2h0Lg0KDQpJIHdpbGwgYXBwcmVjaWF0ZSBtb3JlIGRldGFpbHMgaG93IHRvIHByb2NlZWQu
IFRoYW5rIHlvdSwNCk1pY2hhbA0K
