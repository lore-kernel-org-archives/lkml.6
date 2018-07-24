Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6989C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E782064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="OyqXw0EM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E782064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388644AbeGXPvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:51:55 -0400
Received: from mail-eopbgr00138.outbound.protection.outlook.com ([40.107.0.138]:9624
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388516AbeGXPvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOa1qf49cpUGInxnW4lhgJM4Sqn12+WKHwFybI5JJWY=;
 b=OyqXw0EMy8kfX4OcrzQjJUD7qanyuiVnX6HNjMGwW9gmJOY+yiIUshYhCuMAD0HJIASIi63dafIAD6LdSGXpbz6GUhST1At9sX/OprI4cTaiJYsc+9CGab9sZ9yANI/LFWBFuEn/kgbLadmCOp2Hh3I5+j5W7HYoN+v6IcpaLB0=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2509.eurprd05.prod.outlook.com (10.168.136.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Tue, 24 Jul 2018 14:45:01 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 14:45:01 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "digetx@gmail.com" <digetx@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 00/15] ARM: dts: tegra: apalis-tk1: major revamp
Thread-Topic: [PATCH 00/15] ARM: dts: tegra: apalis-tk1: major revamp
Thread-Index: AQHUIzsmvhNTA8KQdkOtPSRemoHbvqSeTBYAgAAFmoCAABmwgIAABDIAgAADwoA=
Date:   Tue, 24 Jul 2018 14:45:01 +0000
Message-ID: <1532443499.6124.31.camel@toradex.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
         <2532956.xKQ6NZiSWF@dimapc> <1532441791.6124.20.camel@toradex.com>
         <2076484.gx54F3eiOq@dimapc>
In-Reply-To: <2076484.gx54F3eiOq@dimapc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2509;6:dVGr0uBZC2F7O3Bo4DWY7ujVFnXKt7KzaWBdgCrXsG5Eg7PInbS1Vio6UoTxK7dLju2z2GECv+QcNlrCFlQvTJ/fy+xhQCqDsze1EXbu7wJyEeUN0RWwTRXNsZeCwQdyI0ndAnLn1OAQ681WWN30NprRr7tgZz0lje0McmvgrqHV4ypZ+diMwjQaVShwuyLWtXic7hTZEga3a4/2Rtkf2idT9L3TnSuCD13YLeEgaXOhlJqwyg4xDPjo9MLKr/39PlR73PjTdZkWl+FLJprc99+5ad1ZAPhJWvOAKgMgInYhnoYL9WSljw5tebFIHOM9EjPXKh9zuNQ5lN3BWVTa99B0TG6ulw4XfCCwleWDfDFdkWwBvCHwr5K7OufOiVH7vSI2LjvpTRozONKNcD3wnSrL/GBlaywYq6VzaHo8ZfiJI41Za5VK9TxUmSpUa6aYZr1x59yv45U8495AoB5cIA==;5:GOr6aTgY87obev9bbgVefCrb3A6EQHqzOauMvVYbqJ1eaDgKMry8xIYuTynmlJKDh5Rl64PQWTOQ5qFudpozko36553cMfOmDe1/RYohOTJt5JOSlr13LzsJywiZDpzn92f69HvR27TjUqzXg65heSVzn685WHllLwd6dp/nK50=;7:DiD+akV5MXA4ey0pmiX9Lb8Xn5GrURjgYXPVtgzoNHgmLa673kp1f58s9oLW59TE3p5ANfY9JybfVgwGteQk6n2cex3tHSGMt4kSaE6hhj83+epqxeu8pvV+9RFYu3TjC6UW1aNZOhTc7rHJBJAMSrYvTiXHBRlrnXNRAtNXSTpUsuyVM/snqjdnabWR9uP7teTwxiMXNFFUOvZQKEUyF3NBijVHtdvycx3ExB7N5zuRIXJkReQb1Eif7suAY/4U
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 626149a0-d794-4e95-b6f8-08d5f1740929
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2509;
x-ms-traffictypediagnostic: VI1PR0501MB2509:
x-microsoft-antispam-prvs: <VI1PR0501MB2509DFCBC0D9F299C99A64D6FB550@VI1PR0501MB2509.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(49795762698082)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2509;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2509;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(136003)(366004)(39840400004)(376002)(396003)(52314003)(189003)(199004)(26005)(476003)(2616005)(2501003)(81156014)(5640700003)(6512007)(478600001)(76176011)(45080400002)(6506007)(14454004)(186003)(102836004)(6436002)(8676002)(105586002)(486006)(36756003)(1411001)(97736004)(6246003)(25786009)(11346002)(256004)(2900100001)(14444005)(2906002)(446003)(6916009)(229853002)(6486002)(5660300001)(2351001)(53936002)(39060400002)(66066001)(4326008)(305945005)(316002)(93886005)(7736002)(1361003)(106356001)(6116002)(54906003)(81166006)(3846002)(68736007)(1730700003)(8936002)(103116003)(86362001)(5250100002)(99286004)(44832011)(487294005)(491534004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2509;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rCPg/UHq40CkM3stm4Wr4nYQPkgWBZyFalE2FbQ02UzY0fWY2G4RkhDFCIcOk0foY1WSgDKfiU/lfmtt/Pdgf8u+9pqWZlqIoEBXBOMpU7xgVODeXzx9Y3Sr38M6aD1U6NNRwUWTuGvRJc/SxV1ZLCTaQUJUJEUvIho5AgrOHxf4+TXTYllwIXXxRSIcXNYqqWVs1wCvRFTblF4SI22RucKiSfYxboGqXoV1rIIxaSB+GWVkwLp9Bn+1aGR8I5xopIlAqBSLlHCIPe7pws6I2Zuufn49M8ZS5VXh+kfo6ayOp1k7rEJcwwYHMXctwD+FsQHPyCRTiIM/stSVolD8yDwqxIsTOGASYJ2ll48VZ0E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA222C87A9DB254DBE90FAC48CA42C3C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626149a0-d794-4e95-b6f8-08d5f1740929
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 14:45:01.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTI0IGF0IDE3OjMxICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
DQo+IE9uIFR1ZXNkYXksIDI0IEp1bHkgMjAxOCAxNzoxNjozMyBNU0sgTWFyY2VsIFppc3dpbGVy
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOC0wNy0yNCBhdCAxNTo0NCArMDMwMCwgRG1pdHJ5IE9z
aXBlbmtvIHdyb3RlOg0KPiA+IA0KPiA+ID4gT24gVHVlc2RheSwgMjQgSnVseSAyMDE4IDE1OjI0
OjM0IE1TSyBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gU29ycnksIEkg
bWVhbnQgdG8gd3JpdGUgIm1pbm9yIHJldmFtcCIgaW4gdGhlIHN1YmplY3QgbGluZSBoZXJlDQo+
ID4gPiA+IGFzDQo+ID4gPiA+IEFwYWxpcyBUSzEgd2FzIGFscmVhZHkgaW4gcXVpdGUgZ29vZCBh
IHNoYXBlIGJ1dCB0aGlzIGFyZSBzdGlsbA0KPiA+ID4gPiBzb21lDQo+ID4gPiA+IHdvcnRoeSBp
bXByb3ZlbWVudHMgKDstcCkuDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBUdWUsIDIwMTgtMDctMjQg
YXQgMTI6NDIgKzAyMDAsIE1hcmNlbCBaaXN3aWxlciB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiAN
Cj4gPiA+IA0KPiA+ID4gTWFyY2VsLA0KPiA+ID4gDQo+ID4gPiBBbGwgeW91ciBlbWFpbHMgdGhh
dCBhcmUgc2VudCBmcm9tICJ0b3JhZGV4LmNvbSIgYXJlIHRyZWF0ZWQgYXMNCj4gPiA+IHNwYW0N
Cj4gPiA+IGJ5IEdtYWlsIA0KPiA+ID4gYmVjYXVzZSAiVGhpcyBtZXNzYWdlIGhhcyBhIGZyb20g
YWRkcmVzcyBpbiB0b3JhZGV4LmNvbSBidXQgaGFzDQo+ID4gPiBmYWlsZWQgDQo+ID4gPiB0b3Jh
ZGV4LmNvbSdzIHJlcXVpcmVkIHRlc3RzIGZvciBhdXRoZW50aWNhdGlvbi4iLCBpcyB0aGVyZQ0K
PiA+ID4gYW55dGhpbmcNCj4gPiA+IHlvdSBjb3VsZCANCj4gPiA+IGRvIHRvIGZpeCB0aGF0Pw0K
PiA+IA0KPiA+IA0KPiA+IEhpIERtaXRyeQ0KPiA+IA0KPiA+IEhtLCB1bmZvcnR1bmF0ZWx5LCBU
b3JhZGV4IHdhcyBhbiBNJCBvbmx5IHNob3Agd2hlbiBJIGpvaW5lZCBtb3JlDQo+ID4gdGhlbg0K
PiA+IDcgeWVhcnMgYWdvIGFuZCBzbyBmYXIgSSB3YXMgdW5hYmxlIHRvIGNvbnZpbmNlIG91ciBJ
VCB0byBzd2l0Y2ggdG8NCj4gPiBzb21lIGdyb3duIHVwIGVtYWlsIHN5c3RlbS4gVGhlcmVmb3Jl
LCBJIGFtIHN0dWNrIHdpdGggRXhjaGFuZ2UsDQo+ID4gT2ZmaWNlDQo+ID4gMzY1IG9yIHdoYXRl
dmVyIE0kIG5vd2FkYXlzIHNlZW0gdG8gY2FsbCBpdC4gQW55d2F5LCBJIHJlYWxseQ0KPiA+IHRo
b3VnaHQNCj4gPiBzZW5kaW5nIGZyb20gQW5kcm9pZCBvciBFdm9sdXRpb24gdmlhIHRoZWlyIHJl
c3AuIEV4Y2hhbmdlDQo+ID4gY29ubmVjdG9ycw0KPiA+IHdvdWxkIHByb3Blcmx5IGRvIFNQRiwg
REtJTSBhbmQgZXZlbiBETUFSQy4gSSBqdXN0IGNvbmZpcm1lZCB0aGlzDQo+ID4gd2hlbg0KPiA+
IHNlbmRpbmcgc29tZXRoaW5nIHRvIG15IGdtYWlsIGFkZHJlc3MgYW5kIGRvaW5nICJTaG93IG9y
aWdpbmFsIi4NCj4gPiANCj4gPiBTaW5jZSBMaW51cyBoaW1zZWxmIHBvaW50ZWQgb3V0IGFueSBv
ZiBteSBwYXRjaGVzIGVuZGluZyB1cCBpbiBoaXMNCj4gPiBzcGFtDQo+ID4gZm9sZGVyIEkgZG8g
c2VuZCB0aGVtIHZpYSBteSBwcml2YXRlIGVtYWlsIHdoaWNoIHdoaWxlIG5vdCBoYXZpbmcNCj4g
PiBhbnkNCj4gPiBhZHZhbmNlZCBzZWN1cml0eSBjb25maWd1cmVkIHNob3VsZCBzdGlsbCBiZSB2
YWxpZC4gTW92aW5nIGl0IHRvIGENCj4gPiBmdWxseSBzZWN1cmUgY29uZmlndXJhdGlvbiBpbmNs
dWRpbmcgRE5TU0VDIGFuZCBzdHVmZiBpcyBzdGlsbA0KPiA+IHBlbmRpbmcNCj4gPiBvbiBteSBz
aWRlLg0KPiA+IA0KPiA+IENhbiB5b3UgcGxlYXNlIHRlbGwgbWUgd2hpY2ggZXhhY3QgZW1haWwg
aXQgaXMgdGhhdCB5b3UgZ290IHRoaXMNCj4gPiByZXBvcnRlZCBvbiBzbyBJIG1heSBmdXJ0aGVy
IGludmVzdGlnYXRlIHdoYXQgaXMgZ29pbmcgb24/DQo+IA0KPiBUaGlzIGVtYWlsIGZyb20geW91
IGxvb2tzIG9rYXkuIFVuZm9ydHVuYXRlbHkgYWxsIG9mIHlvdXIgcHJldmlvdXMNCj4gZW1haWxz
IGZyb20gDQo+ICJ0b3JhZGV4LmNvbSIgd2VyZSBnZXR0aW5nIGludG8gdGhlIHNwYW0gZm9sZGVy
Lg0KDQpZb3Ugc3VyZSB0aGV5IHdlcmUgZnJvbSAidG9yYWRleC5jb20iPyBUaGUgcGF0Y2hlcyBz
aG91bGQgaGF2ZSBiZWVuDQpjb21pbmcgZnJvbSAiemlzd2lsZXIuY29tIiByZXNwLiAicGVyZm9y
YS5uZXQiLg==
