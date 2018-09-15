Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A75ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64A920881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RrorNOL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64A920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIPCJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:09:55 -0400
Received: from mail-co1nam03on0129.outbound.protection.outlook.com ([104.47.40.129]:52535
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727640AbeIPCJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPsbdgNkdQVDaql5k9gic0Pe9H4uwzRh+vwTi2H2L6Q=;
 b=RrorNOL1hDGSMTzyO4brH4hQLWUyif7Z44xjD67wiHNLsu6SmwqcqFBmtiMQvOiA5TAtfQ56oirCmsogjt9EUTaA6plcoN1O4NCkCx3m4E9QDmacKXf+dWbzmTCqjSsj8GMxGn3QHYH40mVmXU+d6EJRGU+rtvtX9uuPqgSArgo=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB1083.namprd21.prod.outlook.com (52.132.149.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Sat, 15 Sep 2018 20:47:43 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::8dea:f5e5:67f7:c879]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::8dea:f5e5:67f7:c879%5]) with mapi id 15.20.1164.014; Sat, 15 Sep 2018
 20:47:40 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 4/5] x86/hyper-v: rename ipi_arg_{ex,non_ex} structures
Thread-Topic: [PATCH v5 4/5] x86/hyper-v: rename ipi_arg_{ex,non_ex}
 structures
Thread-Index: AQHUPiXmAJm8ifkeDUKTXcnz2EZE7qTwJtaAgAHFANA=
Date:   Sat, 15 Sep 2018 20:47:40 +0000
Message-ID: <MW2PR2101MB111318FF8346405629B76EB7A0180@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180827164858.12496-1-vkuznets@redhat.com>
 <20180827164858.12496-5-vkuznets@redhat.com>
 <d49b69c6-0d2c-5438-b8a0-ef87bae02b0c@redhat.com>
In-Reply-To: <d49b69c6-0d2c-5438-b8a0-ef87bae02b0c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:c0c7:1173:7cb7:b426]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;6:HIquoPM4R72hKlzGAZwwzCBey8z28Ec+OLzgngHMoYhJkOG7HDVGMWQLKsEHNAb8H8xcINSsPIMfkFX9PqKimzyPw0LYDzGVYPrUy2Zwi+fx8MRhIErn7Qjf8R1Z5WJEbkj61SHLDYZ6tOiQeepvtB6HsDopIHv3RRzTL14g5oTgrYRTaLR1YFriQuBW9vOTdEFPIgrYJihDIIYIvatIFhNKqAum/AGIFUrPy6kuIfh4OSYSeFFxIRFVKvA8a/STvfOqGQqu+n3SUbRk8pEzhHTO1pWNarQpfM0JD9YnGq+TQZ+ETzKlT6ZIRJmv1w869pYbHnkn+XDuHTjJWIAViXConLWFzFr8Of01sQ2U0u/grNAUHYzAc1473a9APmCqasr9bYAiyg3wyKkPPEDpvRSfL6/2uqNtAMMfzuWUH3Y7Ca1ZxgO5jdMzW2xNzRqGTG/D6KxzXCPil42G9rlDUw==;5:iKJ2OMGEnbYSzqJ7hHVFO+fInbwE7KT6ByawxPlA8I9CfZGVZe7xPdaBtscyPAcIa0Ejamav+4vTjGNjY23x3K36peZ2MKol5eCzvzkyEghNraRkoKuK9N4XMPqA42Br7FvbWKcgBh3U282JKdu4fHPbrqFZ9/soxHbYtiX/2nE=;7:O0pgW1MYPskIPuXJFzuuXtilBM0hmCYP/4w2fgieMs/Ogv6eCi0byvT5D1dBtrxPI+khy38wcjv5kNb0imyu8hJzLRbMi+YkTlfGirwLTZLhUHhP7eie2+ep4Wkn9uCnR7vuUHrxPzQHpPt8Ye5mlW2VhAzGeRkS9UbgmMJLzsbsKzsmuACupXluEpqkM/LNlI/3vb90VPmYYSq/nFNN9R6xDoo1SH0YUR7AasLMvmZUnTeGV6nmV2lkXAG9+VQF
x-ms-office365-filtering-correlation-id: 4087fe30-3633-4ad5-0899-08d61b4c7a9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB108345A6C49A3164A0461B0FA0180@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(130873036417446)(194151415913766)(105169848403564);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(376002)(136003)(39860400002)(189003)(199004)(13464003)(25786009)(575784001)(2501003)(86362001)(86612001)(46003)(6246003)(99286004)(68736007)(256004)(6436002)(53546011)(2900100001)(5250100002)(446003)(10290500003)(76176011)(4326008)(478600001)(8990500004)(7696005)(39060400002)(14454004)(6116002)(81166006)(8676002)(9686003)(74316002)(305945005)(53936002)(102836004)(7736002)(5660300001)(11346002)(55016002)(486006)(476003)(229853002)(54906003)(10090500001)(316002)(6506007)(2906002)(8936002)(81156014)(110136005)(97736004)(186003)(22452003)(106356001)(33656002)(105586002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ei0rlsXG9cCREpaQSZhgFqlSt/RJMPnO/JzigZkwIcMQI9hbY1E742NkvItzxOAeeX/ujjkdmgVS2a2wZ6OHBKdMkYnW6OYR5aaUGY4LV07iOGeURRYfq6SqWWXJJT4Ds8adIU/8frJ7kIAZ7aaXPXDIeVaxsFt86jH0T3kY7JwXSa+HqolN93lFuv5/XnPM0Llb15KbmEi9AYAv6OoY8sQDmFGEjNOz/ExaGrpJABWWqqsA1/t3uFpTpPULcZgSZqrKIbfJmRH4w5lk/EvxxA0QlQwyCOZs+1qcFpaGnZftJhSifPUb7tcJCDmZH/DkKg0voaEczC3zkJVrjgv0EUOe1sXP85c76Yen9Ytfa+Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4087fe30-3633-4ad5-0899-08d61b4c7a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 20:47:40.6418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSA8
cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMTQsIDIwMTgg
MTA6MzcgQU0NCj4gVG86IHZrdXpuZXRzIDx2a3V6bmV0c0ByZWRoYXQuY29tPjsga3ZtQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJlZGhhdC5jb20+OyBS
b21hbiBLYWdhbg0KPiA8cmthZ2FuQHZpcnR1b3p6by5jb20+OyBLWSBTcmluaXZhc2FuIDxreXNA
bWljcm9zb2Z0LmNvbT47IEhhaXlhbmcNCj4gWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+
OyBTdGVwaGVuIEhlbW1pbmdlcg0KPiA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT47IE1pY2hhZWwg
S2VsbGV5IChFT1NHKQ0KPiA8TWljaGFlbC5ILktlbGxleUBtaWNyb3NvZnQuY29tPjsgTW9oYW1t
ZWQgR2FtYWwNCj4gPG1tb3JzeUByZWRoYXQuY29tPjsgQ2F0aHkgQXZlcnkgPGNhdmVyeUByZWRo
YXQuY29tPjsgV2FucGVuZyBMaQ0KPiA8d2FucGVuZy5saUBob3RtYWlsLmNvbT47IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA0LzVdIHg4Ni9o
eXBlci12OiByZW5hbWUgaXBpX2FyZ197ZXgsbm9uX2V4fQ0KPiBzdHJ1Y3R1cmVzDQo+IA0KPiBP
biAyNy8wOC8yMDE4IDE4OjQ4LCBWaXRhbHkgS3V6bmV0c292IHdyb3RlOg0KPiA+IFRoZXNlIHN0
cnVjdHVyZXMgYXJlIGdvaW5nIHRvIGJlIHVzZWQgZnJvbSBLVk0gY29kZSBzbyBsZXQncyBtYWtl
DQo+ID4gdGhlaXIgbmFtZXMgcmVmbGVjdCB0aGVpciBIeXBlci1WIG9yaWdpbi4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFZpdGFseSBLdXpuZXRzb3YgPHZrdXpuZXRzQHJlZGhhdC5jb20+DQo+
ID4gUmV2aWV3ZWQtYnk6IFJvbWFuIEthZ2FuIDxya2FnYW5AdmlydHVvenpvLmNvbT4NCj4gDQo+
IEtZLCBjYW4geW91IGFjayB0aGlzIHBhdGNoPw0KDQpBY2tlZC1ieTogSy4gWS4gU3Jpbml2YXNh
biA8a3lzQG1pY3Jvc29mdC5jb20+DQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IFBhb2xvDQo+IA0K
PiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9oeXBlcnYvaHZfYXBpYy5jICAgICAgICAgIHwgIDggKysr
Ky0tLS0NCj4gPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vaHlwZXJ2LXRsZnMuaCB8IDE2ICsrKysr
KysrKy0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMSBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9oeXBlcnYvaHZfYXBp
Yy5jIGIvYXJjaC94ODYvaHlwZXJ2L2h2X2FwaWMuYw0KPiA+IGluZGV4IDViMGY2MTM0MjhjMi4u
MmM0M2UzMDU1OTQ4IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2h5cGVydi9odl9hcGljLmMN
Cj4gPiArKysgYi9hcmNoL3g4Ni9oeXBlcnYvaHZfYXBpYy5jDQo+ID4gQEAgLTk1LDggKzk1LDgg
QEAgc3RhdGljIHZvaWQgaHZfYXBpY19lb2lfd3JpdGUodTMyIHJlZywgdTMyIHZhbCkNCj4gPiAg
ICovDQo+ID4gIHN0YXRpYyBib29sIF9fc2VuZF9pcGlfbWFza19leChjb25zdCBzdHJ1Y3QgY3B1
bWFzayAqbWFzaywgaW50IHZlY3RvcikNCj4gPiAgew0KPiA+IC0Jc3RydWN0IGlwaV9hcmdfZXgg
Kiphcmc7DQo+ID4gLQlzdHJ1Y3QgaXBpX2FyZ19leCAqaXBpX2FyZzsNCj4gPiArCXN0cnVjdCBo
dl9zZW5kX2lwaV9leCAqKmFyZzsNCj4gPiArCXN0cnVjdCBodl9zZW5kX2lwaV9leCAqaXBpX2Fy
ZzsNCj4gPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gIAlpbnQgbnJfYmFuayA9IDA7DQo+
ID4gIAlpbnQgcmV0ID0gMTsNCj4gPiBAQCAtMTA1LDcgKzEwNSw3IEBAIHN0YXRpYyBib29sIF9f
c2VuZF9pcGlfbWFza19leChjb25zdCBzdHJ1Y3QNCj4gY3B1bWFzayAqbWFzaywgaW50IHZlY3Rv
cikNCj4gPiAgCQlyZXR1cm4gZmFsc2U7DQo+ID4NCj4gPiAgCWxvY2FsX2lycV9zYXZlKGZsYWdz
KTsNCj4gPiAtCWFyZyA9IChzdHJ1Y3QgaXBpX2FyZ19leCAqKil0aGlzX2NwdV9wdHIoaHlwZXJ2
X3BjcHVfaW5wdXRfYXJnKTsNCj4gPiArCWFyZyA9IChzdHJ1Y3QgaHZfc2VuZF9pcGlfZXgNCj4g
KiopdGhpc19jcHVfcHRyKGh5cGVydl9wY3B1X2lucHV0X2FyZyk7DQo+ID4NCj4gPiAgCWlwaV9h
cmcgPSAqYXJnOw0KPiA+ICAJaWYgKHVubGlrZWx5KCFpcGlfYXJnKSkNCj4gPiBAQCAtMTM1LDcg
KzEzNSw3IEBAIHN0YXRpYyBib29sIF9fc2VuZF9pcGlfbWFza19leChjb25zdCBzdHJ1Y3QNCj4g
Y3B1bWFzayAqbWFzaywgaW50IHZlY3RvcikNCj4gPiAgc3RhdGljIGJvb2wgX19zZW5kX2lwaV9t
YXNrKGNvbnN0IHN0cnVjdCBjcHVtYXNrICptYXNrLCBpbnQgdmVjdG9yKQ0KPiA+ICB7DQo+ID4g
IAlpbnQgY3VyX2NwdSwgdmNwdTsNCj4gPiAtCXN0cnVjdCBpcGlfYXJnX25vbl9leCBpcGlfYXJn
Ow0KPiA+ICsJc3RydWN0IGh2X3NlbmRfaXBpIGlwaV9hcmc7DQo+ID4gIAlpbnQgcmV0ID0gMTsN
Cj4gPg0KPiA+ICAJdHJhY2VfaHlwZXJ2X3NlbmRfaXBpX21hc2sobWFzaywgdmVjdG9yKTsNCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vaHlwZXJ2LXRsZnMuaA0KPiBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZzLmgNCj4gPiBpbmRleCBlOTc3YjZiM2E1Mzgu
LjAwZTAxZDIxNWY3NCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9oeXBl
cnYtdGxmcy5oDQo+ID4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vaHlwZXJ2LXRsZnMuaA0K
PiA+IEBAIC03MjYsMTkgKzcyNiwyMSBAQCBzdHJ1Y3QgaHZfZW5saWdodGVuZWRfdm1jcyB7DQo+
ID4gICNkZWZpbmUgSFZfU1RJTUVSX0FVVE9FTkFCTEUJCSgxVUxMIDw8IDMpDQo+ID4gICNkZWZp
bmUgSFZfU1RJTUVSX1NJTlQoY29uZmlnKQkJKF9fdTgpKCgoY29uZmlnKSA+PiAxNikgJg0KPiAw
eDBGKQ0KPiA+DQo+ID4gLXN0cnVjdCBpcGlfYXJnX25vbl9leCB7DQo+ID4gLQl1MzIgdmVjdG9y
Ow0KPiA+IC0JdTMyIHJlc2VydmVkOw0KPiA+IC0JdTY0IGNwdV9tYXNrOw0KPiA+IC19Ow0KPiA+
IC0NCj4gPiAgc3RydWN0IGh2X3Zwc2V0IHsNCj4gPiAgCXU2NCBmb3JtYXQ7DQo+ID4gIAl1NjQg
dmFsaWRfYmFua19tYXNrOw0KPiA+ICAJdTY0IGJhbmtfY29udGVudHNbXTsNCj4gPiAgfTsNCj4g
Pg0KPiA+IC1zdHJ1Y3QgaXBpX2FyZ19leCB7DQo+ID4gKy8qIEh2Q2FsbFNlbmRTeW50aGV0aWND
bHVzdGVySXBpIGh5cGVyY2FsbCAqLw0KPiA+ICtzdHJ1Y3QgaHZfc2VuZF9pcGkgew0KPiA+ICsJ
dTMyIHZlY3RvcjsNCj4gPiArCXUzMiByZXNlcnZlZDsNCj4gPiArCXU2NCBjcHVfbWFzazsNCj4g
PiArfTsNCj4gPiArDQo+ID4gKy8qIEh2Q2FsbFNlbmRTeW50aGV0aWNDbHVzdGVySXBpRXggaHlw
ZXJjYWxsICovDQo+ID4gK3N0cnVjdCBodl9zZW5kX2lwaV9leCB7DQo+ID4gIAl1MzIgdmVjdG9y
Ow0KPiA+ICAJdTMyIHJlc2VydmVkOw0KPiA+ICAJc3RydWN0IGh2X3Zwc2V0IHZwX3NldDsNCj4g
Pg0KDQo=
