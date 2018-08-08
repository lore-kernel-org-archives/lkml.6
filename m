Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08284C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A238121A28
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="UT2AQN7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A238121A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbeHHVaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:30:05 -0400
Received: from mail-cys01nam02on0122.outbound.protection.outlook.com ([104.47.37.122]:49223
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727337AbeHHVaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrfngQiZj7GmxdraR9jpIllJF24GX5FchcICftU7MkM=;
 b=UT2AQN7ykU0ruGUjdM72ITIOgetZHfBAMEf1Td6GPBb7ZPZaDH5Q5nntEIEmqnF2uZmCOsupP79JNUUpa4eiBijCUllVp3MNSheUTt/8SZ8HmnSAre2UqC3+R/CiugqEX6JS79kOr2/rnuJ7CYOuowUsa7Zff9MV5ldabM0IEcs=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3611.namprd06.prod.outlook.com (10.167.236.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.20; Wed, 8 Aug 2018 19:08:58 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::7826:5dcc:1625:5e96]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::7826:5dcc:1625:5e96%5]) with mapi id 15.20.1017.019; Wed, 8 Aug 2018
 19:08:58 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "baolin.wang@linaro.org" <baolin.wang@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "lanqing.liu@spreadtrum.com" <lanqing.liu@spreadtrum.com>
Subject: Re: [PATCH 2/2] spi: sprd: Add SPI driver for Spreadtrum SC9860
Thread-Topic: [PATCH 2/2] spi: sprd: Add SPI driver for Spreadtrum SC9860
Thread-Index: AQHULjuRfYB0X6KwZUqouw6VboXAR6S0hpAAgACqGoCAAQligA==
Date:   Wed, 8 Aug 2018 19:08:57 +0000
Message-ID: <1533755337.2283.280.camel@impinj.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
         <99befd2badc4dffb59662fca1e11d79f18b64755.1533638405.git.baolin.wang@linaro.org>
         <1533661818.2283.264.camel@impinj.com>
         <CAMz4kuJrzaZn9560tF73a-WPNhhRj5S2ezTKr0HHpcGRXMw-Ew@mail.gmail.com>
In-Reply-To: <CAMz4kuJrzaZn9560tF73a-WPNhhRj5S2ezTKr0HHpcGRXMw-Ew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3611;6:ur/XFG7+qSrAHH2obaL2TW9xmnsDscN/WebrnzNdoXPJcK9b9deQd9EuCtQbfTi4kjyCfXRoGOb1I67Dkpme7HDCvXcnno2iQqhxjRTqofCG5CSVisr6Ob1yPhLLd/oBtBECl1oqEThX0ewElhnBr4jUbxpispGjeP4Hb6VQZfnPTEn/CIEQrOtKlViXtrwMVBfXvXUjiIZ3443rbB9/uoaO+f71Hnv4fKxTMNfmdQsYJ5sQAl3+fMLylSeDW5ZEDqmuzG+OwGExieIPvCnbxkllSp8WiCkucEZbQZFQlDkxF4qEqTsCQhmDMaRgElrmD5EVaij3AEEsyqHsNFV/joU5ZpIZsmder1q8KRla6IMpIOu2aiJIoWT+vMwR5Hybdp2l6NtJ+prtG9cMd0p2uZw+I26UQCvleaCdWXH95uPOpk6MHCqcAcvefY16C0UZNpZ0LQj/jw/C93YKOfiqWw==;5:lUFdpB/odDuzpfx7d7ImK5uazcEs5JUjHHi78N69GjmwT6apGSr/LG2Fy6WTwJCciKkkiPZaKSwpMWrDpm+H9Hm6Q7CcjspnB4ga3B2l0eMIIZS9WW7y+WFGAkVvWSz5eOLWJbMvz5TuagHR6STh82Cn35v8LezSyrc9AJgykOk=;7:dMdF2NjAx7cPZs81EEbVC6AfxhE0RwSC5B9t7o+eMi/R7CDdlrsdn6TRJqVC0O8EP7z1popuTlF07nMT8FlxYz0/KmN5ZRMXDBDZHOSESz8wEYrNxyILPI9mj+/I3mKoYJKXmDnVgoZSPC+Dmn+oU3ueY7T/Maq7Gt6pEvT/AR8gBDv+ki48JYfYHCJdCHVI+PbIgnghHC+XxG3zWvEdBMQVOr8gScyXAQVb5vpprWjBgMACE+i/gBlqjPFcvWqk
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a940533d-3b2a-415b-1fa0-08d5fd6264ab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3611;
x-ms-traffictypediagnostic: MWHPR0601MB3611:
x-microsoft-antispam-prvs: <MWHPR0601MB36111D68A80EDC2AA4C1C1A9D3260@MWHPR0601MB3611.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR0601MB3611;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3611;
x-forefront-prvs: 07584EDBCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39850400004)(189003)(199004)(6486002)(2501003)(7416002)(68736007)(8676002)(229853002)(81166006)(36756003)(446003)(3846002)(6116002)(486006)(81156014)(305945005)(7736002)(2616005)(476003)(11346002)(5660300001)(66066001)(102836004)(256004)(14444005)(26005)(97736004)(186003)(6506007)(53546011)(8936002)(99286004)(6916009)(2351001)(14454004)(105586002)(6246003)(5640700003)(76176011)(86362001)(2906002)(5250100002)(53936002)(93886005)(6436002)(6512007)(103116003)(106356001)(2900100001)(25786009)(478600001)(39060400002)(4326008)(54906003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3611;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NX9w20mYr9UDAbEIqs7lV1aiCLAz+WHM5ciYEbMQYggzHcLU+rIdluSwUTgIhViiXxQtmJJFRA1qxHjfgoli5C+lnM25mY8KivcNXfqUuSyKNNvBxe2YBVM3LNh9aDDg/OhEW+szVM5x1k934ZCb6FyJN33eA8MWyOBgqjFM/ZYVvdzKx8rqjpninHqnBXMBzMnqsWrKzjCVYve+vDRmlz66EztOhRqQzLMwmK1+cai52f0ZBMt/V2f4T7mZgkttTENHbyQM2Tx2PR55ItrElZshUkAblukX28YJY7d2cDteygk5SqMU9Zi/t8/sDnwwGpkAp8X2goUqY+qfOojZoHJtOyx+cPhAdpyt88IUcUg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <75D640BE93A38F4D9F0A7F6D1EAE2D11@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a940533d-3b2a-415b-1fa0-08d5fd6264ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2018 19:08:57.9060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3611
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA4LTA4IGF0IDExOjE5ICswODAwLCBCYW9saW4gV2FuZyB3cm90ZToNCj4g
T24gOCBBdWd1c3QgMjAxOCBhdCAwMToxMCwgVHJlbnQgUGllcGhvIDx0cGllcGhvQGltcGluai5j
b20+IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOC0wOC0wNyBhdCAxODo0MyArMDgwMCwgQmFvbGlu
IFdhbmcgd3JvdGU6DQo+ID4gPiANCj4gPiA+ICtzdGF0aWMgdTMyIHNwcmRfc3BpX3RyYW5zZmVy
X21heF90aW1lb3V0KHN0cnVjdCBzcHJkX3NwaSAqc3MsDQo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc3BpX3RyYW5zZmVyICp0KQ0KPiA+ID4gK3sN
Cj4gPiA+ICsgICAgIC8qDQo+ID4gPiArICAgICAgKiBUaGUgdGltZSBzcGVudCBvbiB0cmFuc21p
c3Npb24gb2YgdGhlIGZ1bGwgRklGTyBkYXRhIGlzIHRoZSBtYXhpbXVtDQo+ID4gPiArICAgICAg
KiBTUEkgdHJhbnNtaXNzaW9uIHRpbWUuDQo+ID4gPiArICAgICAgKi8NCj4gPiA+ICsgICAgIHUz
MiBzaXplID0gdC0+Yml0c19wZXJfd29yZCAqIFNQUkRfU1BJX0ZJRk9fU0laRTsNCj4gPiA+ICsg
ICAgIHUzMiBiaXRfdGltZV91cyA9IFNQUkRfU1BJX0haIC8gdC0+c3BlZWRfaHogKyAxOw0KDQpU
aGVyZSdzIGFub3RoZXIgZmxhdyBoZXJlIGluIHRoYXQgdGhlIHRyYW5zZmVyIHNwZWVkLCB0LT5z
cGVlZF9oeiwNCm1pZ2h0IG5vdCBiZSBleGFjdGx5IHdoYXQgaXMgdXNlZCwgZHVlIHRvIGxpbWl0
YXRpb25zIG9mIHRoZSBjbG9jaw0KZGl2aWRlci4gIEl0IHdvdWxkIGJlIGJldHRlciB0byBmaW5k
IHRoZSBhY3R1YWwgU1BJIGNsb2NrIHVzZWQsIHRoZW4NCnVzZSB0aGF0IGluIHRoZSBjYWxjdWxh
dGlvbnMuDQoNCj4gPiA+ICsgICAgIHUzMiB0b3RhbF90aW1lX3VzID0gc2l6ZSAqIGJpdF90aW1l
X3VzOw0KPiA+ID4gKyAgICAgLyoNCj4gPiA+ICsgICAgICAqIFRoZXJlIGlzIGFuIGludGVydmFs
IGJldHdlZW4gZGF0YSBhbmQgdGhlIGRhdGEgaW4gb3VyIFNQSSBoYXJkd2FyZSwNCj4gPiA+ICsg
ICAgICAqIHNvIHRoZSB0b3RhbCB0cmFuc21pc3Npb24gdGltZSBuZWVkIGFkZCB0aGUgaW50ZXJ2
YWwgdGltZS4NCj4gPiA+ICsgICAgICAqDQo+ID4gPiArICAgICAgKiBUaGUgaW50ZXZhbCBjYWxj
dWxhdGlvbiBmb3JtdWxhOg0KPiA+ID4gKyAgICAgICogaW50ZXJ2YWwgdGltZSAoc291cmNlIGNs
b2NrIGN5Y2xlcykgPSBpbnRlcnZhbCAqIDQgKyAxMC4NCj4gPiA+ICsgICAgICAqLw0KPiA+ID4g
KyAgICAgdTMyIGludGVydmFsX2N5Y2xlID0gU1BSRF9TUElfRklGT19TSVpFICogKChzcy0+aW50
ZXJ2YWwgPDwgMikgKyAxMCk7DQo+ID4gPiArICAgICB1MzIgaW50ZXJ2YWxfdGltZV91cyA9IGlu
dGVydmFsX2N5Y2xlICogU1BSRF9TUElfSFogLyBzcy0+c3JjX2NsayArIDE7DQo+ID4gDQo+ID4g
SWYgaW50ZXJ2YWwgaXMgZ3JlYXRlciB0aGFuIDMxLCB0aGlzIHdpbGwgb3ZlcmZsb3cuDQo+IA0K
PiBVc3VhbGx5IHdlIHdpbGwgbm90IHNldCBzdWNoIGEgYmlnIHZhbHVlIGZvciBpbnRlcnZhbCwg
IGJ1dCB0aGlzIGlzIGENCj4gcmlzayBsaWtlIHlvdSBzYWlkLiBTbyB3ZSB3aWxsIGNoZWNrIGFu
ZCBsaW1pdCB0aGUgaW50ZXJ2YWwgdmFsdWUgdG8NCj4gbWFrZSBzdXJlIHRoZSBmb3JtdWxhIHdp
bGwgbm90IG92ZXJmbG93Lg0KPiANCg0KQmV0dGVyIHdvdWxkIGJlIHRvIGxpbWl0IHRoZSBpbnRl
ciB3b3JkIGRlbGF5IHRvIHdoYXRldmVyIG1heGltdW0gdmFsdWUNCnlvdXIgaGFyZHdhcmUgc3Vw
cG9ydHMsIGFuZCB0aGVuIHdyaXRlIGNvZGUgdGhhdCBjYW4gY2FsY3VsYXRlIHRoYXQNCndpdGhv
dXQgZXJyb3IuDQoNCj4gPiA+ICtzdGF0aWMgdm9pZCBzcHJkX3NwaV9zZXRfc3BlZWQoc3RydWN0
IHNwcmRfc3BpICpzcywgdTMyIHNwZWVkX2h6KQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgIC8qDQo+
ID4gPiArICAgICAgKiBGcm9tIFNQSSBkYXRhc2hlZXQsIHRoZSBwcmVzY2FsZSBjYWxjdWxhdGlv
biBmb3JtdWxhOg0KPiA+ID4gKyAgICAgICogcHJlc2NhbGUgPSBTUEkgc291cmNlIGNsb2NrIC8g
KDIgKiBTUElfZnJlcSkgLSAxOw0KPiA+ID4gKyAgICAgICovDQo+ID4gPiArICAgICB1MzIgY2xr
X2RpdiA9IHNzLT5zcmNfY2xrIC8gKHNwZWVkX2h6IDw8IDEpIC0gMTsNCj4gPiANCj4gPiBZb3Ug
c2hvdWxkIHByb2JhYmx5IHJvdW5kIHVwIGhlcmUuICBUaGUgY29udmVudGlvbiBpcyB0byB1c2Ug
dGhlDQo+ID4gY2xvc2VzdCBzcGVlZCBsZXNzIHRoYW4gZXF1YWwgdG8gdGhlIHJlcXVlc3RlZCBz
cGVlZCwgYnV0IHNpbmNlIHRoaXMgaXMNCj4gPiBhIGRpdmlkZXIsIHJvdW5kaW5nIGl0IGRvd24g
d2lsbCBzZWxlY3QgdGhlIG5leHQgaGlnaGVzdCBzcGVlZC4NCj4gDQo+IFBlciB0aGUgZGF0YXNo
ZWV0LCB3ZSBkbyBub3QgbmVlZCByb3VuZCB1cC9kb3duIHRoZSBzcGVlZC4gU2luY2Ugb3VyDQo+
IGhhcmR3YXJlIGNhbiBoYW5kbGUgdGhlIGNsb2NrIGNhbGN1bGF0ZWQgYnkgdGhlIGFib3ZlIGZv
cm11bGEgaWYgdGhlDQo+IHJlcXVlc3RlZCBzcGVlZCBpcyBpbiB0aGUgbm9ybWFsIHJlZ2lvbiAo
bGVzcyB0aGFuIC0+bWF4X3NwZWVkX2h6KS4NCg0KVGhhdCBpcyBub3Qgd2hhdCBJIG1lYW4uICBM
ZXQgbWUgZXhwbGFpbiBkaWZmZXJlbnRseS4NCg0KQW4gaW50ZWdlciBkaXZpZGVyIGxpa2UgdGhp
cyBjYW4gbm90IHByb2R1Y2UgYW55IGZyZXF1ZW5jeSBleGFjdGx5LiANCkNvbnNpZGVyIGlmIHNy
Y19jbGsgaXMgMTAgTUh6LiAgQSBjbGtfZGl2IHZhbHVlIG9mIDAgcHJvZHVjZXMgYSA1IE1Ieg0K
U1BJIGNsb2NrLiAgQSBjbGtfZGl2IHZhbHVlIG9mIDEgcHJvZHVjZXMgYSAyLjUgTUh6IFNQSSBj
bG9jay4NCg0KV2hhdCBpZiB0aGUgdHJhbnNmZXIgcmVxdWVzdHMgYSBTUEkgY2xvY2sgb2YgMyBN
SHo/DQoNCllvdXIgbWF0aCBhYm92ZSB3aWxsIHByb2R1Y2UgYSBTUEkgY2xvY2sgb2YgNSBNSHos
IGZhc3RlciB0aGFuDQpyZXF1ZXN0ZWQuICBUaGlzIGlzIG5vdCB0aGUgY29udmVudGlvbiBpbiBM
aW51eCBTUEkgbWFzdGVycy4gIFlvdQ0Kc2hvdWxkIGluc3RlYWQgb2YgaGF2ZSBjaG9zZW4gYSBj
bGtfZGl2IHZhbHVlIG9mIDEgdG8gZ2V0IGEgU1BJIGNsb2NrDQpvZiAyLjUgTUh6LCB0aGUgY2xv
c2VzdCBjbG9jayBwb3NzaWJsZSB0aGF0IGlzIG5vdCBncmVhdGVyIHRoYW4gdGhlDQpyZXF1ZXN0
ZWQgdmFsdWUuDQoNClRvIGRvIHRoaXMsIHJvdW5kIHVwLg0KDQpjbGtfZGl2ID0gRElWX1JPVU5E
X1VQKHNzLT5zcmNfY2xrLCBzcGVlZF9oeiAqIDIpIC0gMTsNCg0KPiA=
