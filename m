Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F47C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7D22145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="kNS/NQXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7D22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeK3Veb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:34:31 -0500
Received: from mail-eopbgr1400094.outbound.protection.outlook.com ([40.107.140.94]:38461
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbeK3Veb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv92inYlHJlJgUSMUMd1Lt37IyACMp+jSuDmObb3vog=;
 b=kNS/NQXNNfD1jsl/GbVVuYfmNm6AYfrheoFvRT6CnUAHVdEEelO98Z/guTTspi8+EiSN/oQ1GHucExc126E2JdYRnvZK09OPA+b3gJ5BI2L6Dlety5CHZqoTA7kSdy+Lk5cntfShMO7lAb8Oe8kHU12m7ethqtelo/ZHrC5gxWA=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.162.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Fri, 30 Nov 2018 10:25:37 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.050; Fri, 30 Nov 2018
 10:25:37 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8] clk: Add (devm_)clk_get_optional() functions
Thread-Topic: [PATCH v8] clk: Add (devm_)clk_get_optional() functions
Thread-Index: AQHUgNtosi7IqypTfU2C9ie/xa1taqVoFvOAgAARhXA=
Date:   Fri, 30 Nov 2018 10:25:37 +0000
Message-ID: <TY1PR01MB1769161656941346A08F9F8AF5D30@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181120141445.21378-1-phil.edworthy@renesas.com>
 <154356894146.88331.4169293505438588293@swboyd.mtv.corp.google.com>
In-Reply-To: <154356894146.88331.4169293505438588293@swboyd.mtv.corp.google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1562;20:q/etJ3qjlM8meQGaaoYJg3vErCKE9MWu95cOIC9RoIxThwFusrmsmd9jUkztQTdf+iNRVbA1NGS6WSJcbJg3Naidg5SYURGfga/BS5m9r0SmOl6YH6p+bAC4Fy9krRiUbUfHgaDLSy2dE+gumZqBFZG9K83YLGNCd21AGPLO57U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 016f51c5-2d93-4c59-9cc4-08d656ae2bca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1562;
x-ms-traffictypediagnostic: TY1PR01MB1562:
x-microsoft-antispam-prvs: <TY1PR01MB15626ABC3ED4834A789C7B03F5D30@TY1PR01MB1562.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1562;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1562;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(199004)(189003)(478600001)(256004)(9686003)(55016002)(6246003)(14454004)(25786009)(53936002)(8936002)(8676002)(33656002)(81156014)(81166006)(5660300001)(4326008)(316002)(54906003)(6436002)(6116002)(110136005)(3846002)(99286004)(44832011)(66066001)(7696005)(86362001)(575784001)(229853002)(26005)(102836004)(53546011)(446003)(71200400001)(6506007)(186003)(476003)(486006)(71190400001)(11346002)(76176011)(7736002)(4001150100001)(97736004)(2906002)(305945005)(74316002)(106356001)(68736007)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1562;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hFSbmzA8gSZQwdpJs1sEYDGzPZywFbq8fw/TvP2Nr/C6cMMvCc1rqIFlp222vJUA0s1VNgUMDROQutpyS9V0y0cs8kRs4ckRSbH56yd2NpF799djOANK+gplymdiXsvkE9sXvCVLoxfQwMbNpM2RT2tH4A7p3Lv+mYf6vk6gBcsowmXjJIbxDGyjMnAwTOysPpSl1NT62hiE2l8Ha7LYoDuGh+ojkvWmAr4L0TbfmjA+P2YVBT+f02eRnVhAveGsB6tXCXfVLMZgx3KzFd66884N7AkAdh4w1vK5eVcE3NP3QPNSLuvue/V7ZrxtAYQVIlLK8P4OsINLxocqoJKwYA/iw1DKBKBbOTWvM7ChZoc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016f51c5-2d93-4c59-9cc4-08d656ae2bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 10:25:37.8000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1562
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KT24gMzAgTm92ZW1iZXIgMjAxOCAwOTowOSBTdGVwaGVuIEJveWQgd3Jv
dGU6DQo+IFF1b3RpbmcgUGhpbCBFZHdvcnRoeSAoMjAxOC0xMS0yMCAwNjoxNDo0NSkNCj4gPiBU
aGlzIGFkZHMgY2xrX2dldF9vcHRpb25hbCgpIGFuZCBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoKSBm
dW5jdGlvbnMgdG8NCj4gPiBnZXQgb3B0aW9uYWwgY2xvY2tzLg0KPiA+IFRoZXkgYmVoYXZlIHRo
ZSBzYW1lIGFzIChkZXZtXyljbGtfZ2V0IGV4Y2VwdCB3aGVyZSB0aGVyZSBpcyBubyBjbG9jaw0K
PiA+IHByb2R1Y2VyLiBJbiB0aGlzIGNhc2UsIGluc3RlYWQgb2YgcmV0dXJuaW5nIC1FTk9FTlQs
IHRoZSBmdW5jdGlvbg0KPiA+IHJldHVybnMgTlVMTC4gVGhpcyBtYWtlcyBlcnJvciBjaGVja2lu
ZyBzaW1wbGVyIGFuZCBhbGxvd3MNCj4gPiBjbGtfcHJlcGFyZV9lbmFibGUsIGV0YyB0byBiZSBj
YWxsZWQgb24gdGhlIHJldHVybmVkIHJlZmVyZW5jZSB3aXRob3V0DQo+ID4gYWRkaXRpb25hbCBj
aGVja3MuDQo+IA0KPiBPay4gSSBndWVzcyB0aGF0IHdvcmtzIGJ5IHZpcnR1ZSBvZiBob3cgLUVO
T0VOVCBpcyByZXR1cm5lZCBieSB2YXJpb3VzDQo+IGZ1bmN0aW9ucyB0aGF0IGFyZSBjYWxsZWQg
ZGVlcGVyIGluIHRoZSBjbGtfZ2V0KCkgcGF0aD8gSSdtIGNhdXRpb3VzbHkNCj4gb3B0aW1pc3Rp
Yy4gU28gY2F1dGlvdXMsIHdlIHNob3VsZCBwcm9iYWJseSBhZGQgYSBjb21tZW50IHRvIHRoZXNl
IG9wdGlvbmFsDQo+IGZ1bmN0aW9ucyB0aGF0IGluZGljYXRlIHRoZXkgcmVseSBvbiB0aGUgZnVu
Y3Rpb25zIHRoZXkgY2FsbCB0byByZXR1cm4gLUVOT0VOVA0KPiB1bmRlciB0aGUgdmFyaW91cyBj
b25kaXRpb25zIHRoYXQgbWFrZSBhIGNsayBvcHRpb25hbC4NClllcywgaXQgZG9lcyBpbmRlZWQg
cmVseSBvbiBob3cgY2xrX2dldCgpIGlzIGltcGxlbWVudGVkLg0KU3BlY2lmaWNhbGx5LCB0aGF0
IGlmIF9fb2ZfY2xrX2dldF9ieV9uYW1lKCkgcmV0dXJucyAtRUlOVkFMLCB0aGUgZXJyb3IgaXMN
CnN1cGVyc2VkZWQgYnkgY2xrX2dldF9zeXMoKSByZXR1cm5pbmcgLUVOT0VOVC4NCkFzIHlvdSBz
YXksIGEgY29tbWVudCBtYXkgaGVscCBoZXJlLg0KDQoNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2Nsay5oIGIvaW5jbHVkZS9saW51eC9jbGsuaCBpbmRleA0KPiA+IGE3Nzcz
YjVjMGI5Zi4uM2VhM2M3OGY2MmRkIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvY2xr
LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Nsay5oDQo+ID4gQEAgLTM4Myw2ICszODMsMTcg
QEAgaW50IF9fbXVzdF9jaGVjayBkZXZtX2Nsa19idWxrX2dldF9hbGwoc3RydWN0DQo+IGRldmlj
ZSAqZGV2LA0KPiA+ICAgKi8NCj4gPiAgc3RydWN0IGNsayAqZGV2bV9jbGtfZ2V0KHN0cnVjdCBk
ZXZpY2UgKmRldiwgY29uc3QgY2hhciAqaWQpOw0KPiA+DQo+ID4gKy8qKg0KPiA+ICsgKiBkZXZt
X2Nsa19nZXRfb3B0aW9uYWwgLSBsb29rdXAgYW5kIG9idGFpbiBhIG1hbmFnZWQgcmVmZXJlbmNl
IHRvIGFuDQo+IG9wdGlvbmFsDQo+ID4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2sg
cHJvZHVjZXIuDQo+ID4gKyAqIEBkZXY6IGRldmljZSBmb3IgY2xvY2sgImNvbnN1bWVyIg0KPiA+
ICsgKiBAaWQ6IGNsb2NrIGNvbnN1bWVyIElEDQo+ID4gKyAqDQo+ID4gKyAqIEJlaGF2ZXMgdGhl
IHNhbWUgYXMgZGV2bV9jbGtfZ2V0IGV4Y2VwdCB3aGVyZSB0aGVyZSBpcyBubyBjbG9jaw0KPiA+
ICtwcm9kdWNlci4gSW4NCj4gDQo+IFBsZWFzZSBhZGQgKCkgYXJvdW5kIGRldm1fY2xrX2dldCgp
IHNvIHdlIGtub3cgaXQncyBhIGZ1bmN0aW9uLg0KV2lsbCBkby4NCg0KDQo+ID4gKyAqIHRoaXMg
Y2FzZSwgaW5zdGVhZCBvZiByZXR1cm5pbmcgLUVOT0VOVCwgdGhlIGZ1bmN0aW9uIHJldHVybnMg
TlVMTC4NCj4gPiArICovDQo+ID4gK3N0cnVjdCBjbGsgKmRldm1fY2xrX2dldF9vcHRpb25hbChz
dHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXINCj4gPiArKmlkKTsNCj4gPiArDQo+ID4gIC8q
Kg0KPiA+ICAgKiBkZXZtX2dldF9jbGtfZnJvbV9jaGlsZCAtIGxvb2t1cCBhbmQgb2J0YWluIGEg
bWFuYWdlZCByZWZlcmVuY2UgdG8gYQ0KPiA+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAg
Y2xvY2sgcHJvZHVjZXIgZnJvbSBjaGlsZCBub2RlLg0KPiA+IEBAIC03MTgsNiArNzI5LDEyIEBA
IHN0YXRpYyBpbmxpbmUgc3RydWN0IGNsayAqZGV2bV9jbGtfZ2V0KHN0cnVjdCBkZXZpY2UNCj4g
KmRldiwgY29uc3QgY2hhciAqaWQpDQo+ID4gICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiAgfQ0K
PiA+DQo+ID4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IGNsayAqZGV2bV9jbGtfZ2V0X29wdGlvbmFs
KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICppZCkgew0KPiA+ICsgICAgICAgcmV0dXJuIE5V
TEw7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbmxpbmUgaW50IF9fbXVzdF9jaGVjayBk
ZXZtX2Nsa19idWxrX2dldChzdHJ1Y3QgZGV2aWNlICpkZXYsIGludA0KPiBudW1fY2xrcywNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGNsa19idWxrX2RhdGENCj4gPiAqY2xrcykgIHsgQEAgLTg2Miw2ICs4NzksMTYgQEAgc3RhdGlj
IGlubGluZSB2b2lkDQo+ID4gY2xrX2J1bGtfZGlzYWJsZV91bnByZXBhcmUoaW50IG51bV9jbGtz
LA0KPiA+ICAgICAgICAgY2xrX2J1bGtfdW5wcmVwYXJlKG51bV9jbGtzLCBjbGtzKTsgIH0NCj4g
Pg0KPiA+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBjbGsgKmNsa19nZXRfb3B0aW9uYWwoc3RydWN0
IGRldmljZSAqZGV2LCBjb25zdA0KPiA+ICtjaGFyICppZCkNCj4gDQo+IEFueSBrZXJuZWwgZG9j
IGZvciB0aGlzIGZ1bmN0aW9uPw0KSSB0b29rIG15IGN1ZSBmcm9tIHRoZSBzdXJyb3VuZGluZyBm
dW5jdGlvbnMsIGxldCBtZSBrbm93IGlmIEkgaGF2ZSB0byBhZGQgaXQuDQoNClRoYW5rcw0KUGhp
bA0KDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBjbGsgKmNsayA9IGNsa19nZXQoZGV2LCBp
ZCk7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKGNsayA9PSBFUlJfUFRSKC1FTk9FTlQpKQ0KPiA+
ICsgICAgICAgICAgICAgICBjbGsgPSBOVUxMOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiBj
bGs7DQo+ID4gK30NCj4gPiArDQo=
