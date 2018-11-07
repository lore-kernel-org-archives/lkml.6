Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0935DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0A42086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="kj5Qxbfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0A42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbeKGXCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:02:39 -0500
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:29988
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbeKGXCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8yRfvSQxZ80XkJUY+f+aGltkOkTL3rJ6GwsqiEfavM=;
 b=kj5Qxbfp0OvHVmVESYLG60dxUoSNLSEKpbHldXgdcKzv82p/vgimwWvSX3wmggxyQ6fXL+Wq10K7WzOD57ubscfv/od+UMU8yOuJzbHcXe2YnP0W4Dx6JCHgsVK78QmboMoUc8p/4dR3bRkrd6qURYYiyWUNyATAXcp3cJemzRU=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4665.eurprd04.prod.outlook.com (52.135.139.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 13:32:10 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421%3]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 13:32:10 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: =?utf-8?B?UmU6IFtSQ0bCoFBBVENILHYyLDIvMl0gcHdtOiBpbXg6IENvbmZpZ3VyZSBv?=
 =?utf-8?Q?utput_to_GPIO_in_disabled_state?=
Thread-Topic: =?utf-8?B?W1JDRsKgUEFUQ0gsdjIsMi8yXSBwd206IGlteDogQ29uZmlndXJlIG91dHB1?=
 =?utf-8?Q?t_to_GPIO_in_disabled_state?=
Thread-Index: AQHUYgmcdqbPphssxk6nsYPZEg3OjqUb10cA///wZACAGrOXAIANuquAgABCkIA=
Date:   Wed, 7 Nov 2018 13:32:10 +0000
Message-ID: <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
 <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
In-Reply-To: <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0050.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::27) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4665;6:d0XbN01JcHuN+0dRdgosO+fkfiV+O84PD+vVEOv3KKFia7IL1P1rZAnkYhya25g9sYPQVYPyKJr3Bpup4BGVb1DBT1mx0NihFtyIm2kxpUpGdGmxnr2WnJn4Yx6uKLzlNBz5d/8R1D6mD240pNhW6SFd4dQTn+824CAXl36ECnK9xrA9wY4ByoZdzCxlUF+KJuJxaWFJmxkEoVuVzuX4tVHIxLTrHfU/Y1jJHTweHEfGhAdLcLTiGCTTwTZrlsMYjfcuoxzL+xG0uoSdDMb+Pz1ZPdHH9NcipwD3bEtPWxHNAveZgZBfLJ7KQrXtWF54vGYIFmrs0Rg9ei9T6owskgVXep+Mk8LKg0fEv6oOmQK++9nvChwEdi0AMiTP8cHdoRGudL97TwmVoYcuuenFgjjtqJbgFVAI6UjAwDD13fSlYirrsqtH0k681TPtG+PCgK/+wApnTjLwkJt3rYwAIg==;5:kIC3pNHYvsti8qxW8lDZLQE2aT9mnT808OWnZVCcsh9NqEkc3LiroOYo949BfdY8ePPqokiYmprx/79uS/cxQIRPGqI5J8Sc1EcwEY1WQhhAzpTqS7GTEkzEP04QjkWxqIlcoeXFskmlvL4iTybf9Qk700LrsGQcTfGUL0nYj/8=;7:c+WS6Q/kaso9InlSjKy7gTrHpCvmCCTUwzIAMHfnl2O7uKWJSUTEkZccwHJ2LIle907f5xE7V6UD7iV2C2j066bIfX94gjj68ceJ/obVUJKk8XH9CP9V3u9tLyXUpb8tnXfPEZT2zDHo9n2/jr6gyg==
x-ms-office365-filtering-correlation-id: 997920ac-4f1d-4b52-553e-08d644b56baa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4665;
x-ms-traffictypediagnostic: DB7PR04MB4665:
x-microsoft-antispam-prvs: <DB7PR04MB46651B2C1E8533E3D5211AB49EC40@DB7PR04MB4665.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4665;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4665;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39850400004)(136003)(189003)(52314003)(199004)(76176011)(6116002)(93886005)(86362001)(3846002)(229853002)(66066001)(85182001)(54906003)(71190400001)(71200400001)(2906002)(39060400002)(31686004)(8936002)(97736004)(81166006)(52116002)(14454004)(81156014)(316002)(102836004)(5660300001)(26005)(31696002)(53546011)(72206003)(6506007)(386003)(99286004)(66574009)(68736007)(6436002)(14444005)(6486002)(256004)(345774005)(6916009)(25786009)(478600001)(6512007)(53936002)(6246003)(2900100001)(7736002)(305945005)(4326008)(105586002)(486006)(2616005)(11346002)(446003)(476003)(106356001)(36756003)(186003)(7416002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4665;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3iS6Oh+UwS3sliYRiAmQ3lrpRzn+M9srW4FPy16jgb48eK+xVlS22/12ok/cUZq3AD4OhscaPIVioPtD7FzB+cq38LsY6LBwauUmiPjGsv0d6aZeYzBvKifW0y53XrP1Oo+DLPH/Ljy99oWU6mk1LOJMRyQ5BWDO9ESX45r9D+1KlaO5DM0HX6yvk61DQik1d7pGl4jSS9zvsFszBwIbc/gaRimMvzPRAN/AgNQ2nF32YMi51ypD3VHc1Ap4YnDyv9baRQF+4I1e9qxZEsgVjTxEzWimcofoE/GyoKZx6E8t8h0MuIucd7rPTT73QWoTbZe4mG3eZZTnzdL0nnyJPE2wQHTcdn6TVR2kEV0U+x8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <600809C2ADC88C46B242E0F79BBFC84E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997920ac-4f1d-4b52-553e-08d644b56baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 13:32:10.7999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4665
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVXdlLA0KDQpPbiA3LjExLjIwMTggMTA6MzMsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0K
PiBIZWxsbyBNaWNoYWwsDQo+IA0KPiBqdXN0IHRvIHN0YXRlIGl0IG1vcmUgZXhwbGljaXRseSwg
SSB0aGluayB0aGUgZm9sbG93aW5nIHBhdGNoIChub3QgZXZlbg0KPiBjb21waWxlIHRlc3RlZCkg
aXMgbXVjaCBwcmVmZXJhYmxlIG92ZXIgeW91ciBhcHByb2FjaDoNCg0KSW50ZXJlc3RpbmcgaWRl
YS4gSSBqdXN0IHdvbmRlciB3aHkgbm9ib2R5IGVsc2UgZGlkIG5vdCBjb21lIHVwIHdpdGggc3Vj
aA0KYSBzaW1wbGUgc29sdXRpb24gYmVmb3JlLg0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3
bS9wd20taW14LmMgYi9kcml2ZXJzL3B3bS9wd20taW14LmMNCj4gaW5kZXggMWQ1MjQyYzljZGUw
Li5hZjg4NjQ0YjVlZmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcHdtL3B3bS1pbXguYw0KPiAr
KysgYi9kcml2ZXJzL3B3bS9wd20taW14LmMNCj4gQEAgLTIxNiw3ICsyMTYsMTQgQEAgc3RhdGlj
IGludCBpbXhfcHdtX2FwcGx5X3YyKHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9k
ZXZpY2UgKnB3bSwNCj4gICAJCQljciB8PSBNWDNfUFdNQ1JfUE9VVEM7DQo+ICAgDQo+ICAgCQl3
cml0ZWwoY3IsIGlteC0+bW1pb19iYXNlICsgTVgzX1BXTUNSKTsNCj4gLQl9IGVsc2UgaWYgKGNz
dGF0ZS5lbmFibGVkKSB7DQo+ICsJfSBlbHNlIGlmIChjc3RhdGUuZW5hYmxlZCAmJiBzdGF0ZS0+
cG9sYXJpdHkgPT0gUFdNX1BPTEFSSVRZX05PUk1BTCkgew0KPiArCQkvKg0KPiArCQkgKiBXaGVu
IGRpc2FibGVkIGluIGhhcmR3YXJlIHRoZSBvdXRwdXQgcGluIGdvZXMgdG8gMA0KPiArCQkgKiBp
bmRlcGVuZGFudCBvZiB0aGUgcG9sYXJpdHkgc2V0dGluZy4gVGhlIGV4cGVjdGF0aW9uIG9mIHNv
bWUNCj4gKwkJICogcGVvcGxlIGhvd2V2ZXIgaXMgdGhhdCBhZnRlciBkaXNhYmxpbmcgdGhlIHBp
biBnb2VzIHRvIHRoZQ0KPiArCQkgKiBpbmFjdGl2ZSBsZXZlbCB3aGljaCBpc24ndCBnaXZlbiBm
b3IgYW4gaW52ZXJzZWQgcHdtLCBzbw0KPiArCQkgKiBvbmx5IGRpc2FibGUgZm9yIG5vcm1hbCBw
b2xhcml0eS4NCj4gKwkJICovDQo+ICAgCQl3cml0ZWwoMCwgaW14LT5tbWlvX2Jhc2UgKyBNWDNf
UFdNQ1IpOw0KPiAgIA0KPiAgIAkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteC0+Y2xrX3Blcik7
DQoNCkkgdGVzdGVkIHlvdXIgcGF0Y2guIEl0IGRvZXMgbm90IHdvcmsgYXMgeW91IGV4cGVjdGVk
Lg0KDQpJbiB2NC4yMC1yYzEgdGhlIHB3bS1iYWNrbGlnaHQgZHJpdmVyIGhhcyBiZWVuIGNvbnZl
cnRlZCB0byBhdG9taWMgQVBJLg0KU28gdGhlIHB3bV9hcHBseV92MiBmdW5jdGlvbiBpcyBjYWxs
ZWQgb25seSBvbmNlIHRvIHNldCBuZXcgcGVyaW9kL2R1dHkNCmFuZCBzdGF0ZS4gV2l0aCB5b3Vy
IHBhdGNoIHRoYXQgbWVhbnMgdGhhdCAiZWNobyAwID4gYnJpZ2h0bmVzcyIgaGFzIG5vDQp2aXNp
YmxlIGVmZmVjdC4gSXQgbGVhdmVzIHRoZSBQV00gY2hpcCBlbmFibGVkIHdpdGggcGVyaW9kL2R1
dHkgc2V0IHRvDQpob3dldmVyIGl0IHdhcy4gQnV0IHRoZSBjb3JlIHRoaW5rcyBpdCB3YXMgcmVj
b25maWd1cmVkOg0KDQojIGNhdCAvc3lzL2NsYXNzL2JhY2tsaWdodC9iYWNraWdodC9icmlnaHRu
ZXNzDQowDQoNCiMgY2F0IC9zeXMva2VybmVsL2RlYnVnL3B3bQ0KcGxhdGZvcm0vMjA4MDAwMC5w
d20sIDEgUFdNIGRldmljZQ0KICBwd20tMCAgIChiYWNrbGlnaHQgICAgICAgICAgICk6IHJlcXVl
c3RlZCBwZXJpb2Q6IDUwMDAwMCBucyBkdXR5OiAwIG5zIHBvbGFyaXR5OiBpbnZlcnNlDQoNCj4g
SSB0aGluayBpdCBzb2x2ZXMgbW9zdCBpZiBub3QgYWxsIHByb2JsZW1zIHlvdSB3YW50IHRvIGFk
ZHJlc3Mgd2l0aCB0aGUNCj4gcGluY3RybCBzdHVmZi4NCg0KVW5mb3J0dW5hdGVseSBub3QuIEkg
YWxzbyB0ZXN0ZWQgeW91ciBwYXRjaCBvbiB2NC4xOS4gSXQgd29ya3MgYXMgeW91DQpwcm9iYWJs
eSBpbnRlbmRlZCAtIGl0IGlzIHBvc3NpYmxlIHRvIGRpc2FibGUgYmFja2xpZ2h0IHdpdGhvdXQg
dGhlIFBXTQ0KY2hpcCBiZWluZyBkaXNhYmxlZC4gQnV0IGl0IGRvZXMgbm90IHNvbHZlIHRoZSB0
aW1lIGZyYW1lIGJldHdlZW4NCmlteF9wd21fcHJvYmUoKSBhbmQgaW14X3B3bV9hcHBseV92Migp
Lg0KDQpJbiBwcm9iZSB5b3UgZG8gbm90IGhhdmUgYW55IHVzZXJzIHlldC4gU28geW91IGRvIG5v
dCBrbm93IHRoZSByZXF1ZXN0ZWQNCm91dHB1dCBwb2xhcml0eS4gV2l0aCAiZGVmYXVsdCIgcGlu
Y3RybCB0aGUgUFdNIG91dHB1dCB3b3VsZCBiZSBtdXhlZCB0bw0KdGhlIHNlbGVjdGVkIHBpbiBh
bmQgc2luY2UgdGhlIFBXTSBjaGlwIGlzIG1vc3QgcHJvYmFibHkgZGlzYWJsZWQNCih1bmxlc3Mg
eW91IGVuYWJsZWQgaXQgaW4gYm9vdGxvYWRlcikgeW91IHdvdWxkIGdldCBsb3cgbGV2ZWwgb24g
dGhlIHBpbi4NClRoYXQgbWVhbnMgeW91ciBiYWNrbGlnaHQgaXMgZnVsbHkgZW5hYmxlZCB1bnRp
bCB0aGUgZmlyc3QgY2FsbCB0bw0KaW14X3B3bV9hcHBseV92MigpLiBPbiBteSBzeXN0ZW0gdGhp
cyBpcyAyIHNlY29uZHMuDQoNCkl0IG1pZ2h0IG5vdCBiZSBhIGJpZyBpc3N1ZSBmb3IgYmFja2xp
Z2h0IGJ1dCBmb3IgbW90b3IgY29udHJvbCBpdCBpcw0Kbm90IHRoZSByaWdodCB0aGluZyB0byBk
by4NCg0KVGhlIG90aGVyIHRoaW5nIGlzIEkgd291bGQgcHJlZmVyIHRvIG1ha2UgdGhlIGNoYW5n
ZSBvcHRpb25hbC4gV2l0aCB5b3VyDQphcHByb2FjaCB5b3UgYXJlIGNoYW5naW5nIHRoZSBiZWhh
dmlvciBmb3IgYWxsIGN1cnJlbnQgdXNlcnMgb2YgaW52ZXJ0ZWQNClBXTS4gSSBkbyBub3QgdGhp
bmsgYWxsIGlteDYgdXNlcnMgYXJlIGF3YXJlIG9mIHRoZSBwcm9ibGVtIHNvIHRoZXkgbWlnaHQN
Cm5vdCBiZSBPSyB3aXRoIHRoZSBzdWRkZW4gY2hhbmdlIGluIHRoZSBiZWhhdmlvci4NCg0KSSBh
Z3JlZSBpdCB3b3VsZCBiZSBuaWNlIGlmIHN1Y2ggYSBzaW1wbGUgY2hhbmdlIGFzIHlvdSBwcm9w
b3NlZCB3b3VsZA0Kc29sdmUgdGhlIHByb2JsZW0uIFN0aWxsLCBJIGRvIG5vdCBzZWUgYW55IG90
aGVyIHNvbHV0aW9uIHRoYW4gcGluY3RybA0KdG8gZGVhbCB3aXRoIGFsbCB0aGUgcHJvYmxlbXMg
SSB3b3VsZCBsaWtlIHRvIGFkZHJlc3MuDQoNCkFueXdheSwgdGhhbmsgeW91IGZvciB0aGUgaWRl
YSENCg0KQWxsIHRoZSBiZXN0LA0KTWljaGFsDQo=
