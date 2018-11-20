Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E69C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E1020685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="aVbBKX//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E1020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeKTXno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:43:44 -0500
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:6144
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbeKTXno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RklrsvXkcfOmszf3V7asp2EbzI/J4vk7DmI9VPWn+ho=;
 b=aVbBKX//MP5dgrRqoPoMCt+QXQYMG8BpnA9SEumLLXuVApW/p5FFsFgVsZF3sUMPQTpKc4BxLYiamLbg1fSTIqO4R+UPAEG4C38DIuBq9/LAgNgWR9OCB4qhJt+M9y8ghB0vWhnspXeQK1VspOPIJqNYxGnnI8gx6v0z8QOldA0=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4730.eurprd04.prod.outlook.com (20.176.233.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 13:14:33 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74%2]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 13:14:33 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>
Subject: =?utf-8?B?UmU6IFtSQ0bCoFBBVENILHYyLDIvMl0gcHdtOiBpbXg6IENvbmZpZ3VyZSBv?=
 =?utf-8?Q?utput_to_GPIO_in_disabled_state?=
Thread-Topic: =?utf-8?B?W1JDRsKgUEFUQ0gsdjIsMi8yXSBwd206IGlteDogQ29uZmlndXJlIG91dHB1?=
 =?utf-8?Q?t_to_GPIO_in_disabled_state?=
Thread-Index: AQHUYgmcdqbPphssxk6nsYPZEg3OjqUb10cA///wZACAGrOXAIANuquAgABCkICAABjxgIABl/8AgABCR4CAAUAfAIAAKkKAgAeB8YCAAKxBAIABJpqAgABXHYCAAN3NAIAGghGA
Date:   Tue, 20 Nov 2018 13:14:33 +0000
Message-ID: <6e81d63b-61a1-36fe-0c24-3ff27438cbc0@ysoft.com>
References: <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
 <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de> <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de> <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116095124.GA28631@ulmo>
In-Reply-To: <20181116095124.GA28631@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0102CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::23) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4730;6:NQXiPt5RImyGKLR8xfQN9XCyKYQcfmgqusufYovbZeCQUUC2y0gSgSLevGSq7ka7FXppNqxuooKgxX4+Api1Ww2Y+KYAQOy0JGfu7SYRKhzd2pFbn2eCMNaXFx2FXgnMs9yWSBYwjJM5Evrq2Cw9LRItown6HCzvNTIOshAZWb3Sl0cTvvGPGNSapDAMCydJG1gkouTOhfwSYMJEVx89kvqBktGbcG1qQXLjBsdr2+rrsNavFmC4KGBK4LJ7eS43Yio2lNRprfft+BLg0p2FRxQk0PQOL75HelfNkl7rlBnbv90lyDix5cKwJN5PWvMroy9/4UJ3Bcs8KL0Wzd5Jbug+FgIgVByuu0k/EY0ipYGSsAVEDqprEA3k7JKxPRdPRXh+P0eayj675av2c6vWfp4hSOwgmgjiSa76+feP6p9zv+10sEJgzszH+u/uGXsAFgV+HGZKbrtnKY6AGz4Krw==;5:aWxRJnaxaOKzOnA/ZWZT/n/4edlbaUnCYYVvkTM+BlDv8NabVISgjJgdEOY+Dpno5NC0+ipomnsOv9338KxoluSpurOwbLbjd1T5OvIx/ZRqXRx/085YG+fWN9FLDCTG3rHFB8wwKCHi4WzBUs4ev7S3pHh04AZ2NuEAuE5rK7A=;7:s2KVM2bP3OavhnIFXnMJYj0ux6DmiBIrYJ5Cfk3FJuMoQ84wZpJz/w15lTaHIsmyhNohk3Jg/eoK+Kcb/T/yXAENDYNS/tHQjCIAGEI7skWIfTaYcAeC3DzVgGctS1BLm3hvd6LMMwocUDtiQl8c/g==
x-ms-office365-filtering-correlation-id: 10a9334f-c28e-4390-208a-08d64eea1cc6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4730;
x-ms-traffictypediagnostic: DB7PR04MB4730:
x-microsoft-antispam-prvs: <DB7PR04MB47308C07DD14CFDC77B4C0D39ED90@DB7PR04MB4730.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4730;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4730;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(39850400004)(396003)(189003)(61684003)(199004)(72206003)(386003)(7416002)(6506007)(52116002)(76176011)(102836004)(99286004)(2906002)(14454004)(31686004)(97736004)(85182001)(5660300001)(105586002)(53546011)(106356001)(6436002)(25786009)(6246003)(7736002)(305945005)(478600001)(2900100001)(6512007)(11346002)(36756003)(39060400002)(53936002)(86362001)(81156014)(4326008)(256004)(6116002)(93886005)(3846002)(229853002)(486006)(31696002)(110136005)(54906003)(81166006)(66066001)(8936002)(68736007)(66574009)(71190400001)(71200400001)(6486002)(2616005)(476003)(186003)(446003)(26005)(316002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4730;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xSYbEjqG2Oi2vwxLT6SeNMxH4gfZpeJQvuBBY4bDUJWY/L6dg9gCXOJX8JSjQx8ucfQwxkcump12Q9aC/phCv/Uc2p9Yhfwsdcb58p0g9hiMe2R/33IwdMtpMs58DQAmR3dm5hWFjC8t87IOrWimwSEfSsmiuSJDbjNXasQmatKQP6gSwymnDVTao9x3Tzy0M1NgWGRT30MYqtVa+HwA84aQCaraG5OsMCyyvYjD0/2k29fTHZm434e17obs+METN7eCSyJup+d43UfktwcAUe49EJrodE9ulTkZDXYWukdQpG2iKpsW+DlzXmh2J5Hzit4/ODxiYxYajtx1ORCq5S21ZXhvP8tD8xrc3+MvU+o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <285866F6156CF546AA539A63334774A3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a9334f-c28e-4390-208a-08d64eea1cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 13:14:33.4064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4730
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpzb3JyeSBmb3IgdGhlIGRlbGF5LCBJIHdhcyBvdXQgb2Ygb2ZmaWNlIGxhc3Qgd2Vlay4N
Ck15IGNvbW1lbnRzIGJlbG93IGFyZSBqdXN0IHRvIGNsYXJpZnkgbXkgYXR0aXR1ZGUgdG8gdGhl
IHRvcGljIGFzIG15DQpuYW1lIHdhcyBtZW50aW9uZWQgZmV3IHRpbWVzIHdoaWxlIEkgd2FzIG9m
ZmxpbmUuDQoNCk9uIDE2LjExLjIwMTggMTA6NTEsIFRoaWVycnkgUmVkaW5nIHdyb3RlOg0KPiBP
biBUaHUsIE5vdiAxNSwgMjAxOCBhdCAwOTozNzozM1BNICswMTAwLCBVd2UgS2xlaW5lLUvDtm5p
ZyB3cm90ZToNCj4+IE9uIFRodSwgTm92IDE1LCAyMDE4IGF0IDA0OjI1OjQ1UE0gKzAxMDAsIFRo
aWVycnkgUmVkaW5nIHdyb3RlOg0KPj4+IE9uIFdlZCwgTm92IDE0LCAyMDE4IGF0IDEwOjUxOjIw
UE0gKzAxMDAsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPj4+PiBPbiBXZWQsIE5vdiAxNCwg
MjAxOCBhdCAxMjozNDo0OVBNICswMTAwLCBUaGllcnJ5IFJlZGluZyB3cm90ZToNCg0KPj4gTWF5
YmUgaXQgd2FzIGEgYmFkIGlkZWEgdG8gYnJvYWRlbiB0aGUgZGlzY3Vzc2lvbiB0byB0YWxrIGFi
b3V0IGdwaW9zDQo+PiBhbmQgZXRoZXJuZXQgc3R1ZmYgaGVyZS4gSSdkIHN0aWxsIGNvbnNpZGVy
IGl0IGEgdmFsaWQgY29uc3RydWN0IHRvIHB1dA0KPj4gdGhlIHB3bSBwaW4gaW50byB0aGUgYmFj
a2xpZ2h0J3MgcGluY3RybCB1bmxlc3MgTGludXggVy4gZGlzYWdyZWVzLg0KPiANCj4gQnV0IHdo
eT8gVGhlIGJhY2tsaWdodCBkb2Vzbid0IGNhcmUgYWJvdXQgdGhlIHNwZWNpZmljIHBpbm11eGlu
ZyBvZiB0aGUNCj4gUFdNIHBpbi4gQWxsIGl0IGNhcmVzIGFib3V0IGlzIHRoZSBQV00gc2lnbmFs
LiBUaGF0J3MgdGhlIGxldmVsIG9mDQo+IGFic3RyYWN0aW9uIHRoYXQgdGhlIFBXTSBjb25zdW1l
ciBleHBlY3RzLCBhbnl0aGluZyBsb3dlciBsZXZlbCBiZWxvbmdzDQo+IGluIHRoZSBQV00gZHJp
dmVyLg0KDQpJIGFsc28gZG8gbm90IGxpa2UgdGhlIGlkZWEgb2YgcHV0dGluZyB0aGUgcGlubXV4
aW5nIG9mIHRoZSBQV00gcGluIGludG8NCnRoZSBQV00gY29uc3VtZXIuIFRoYXQgaXMgd2h5IGl0
IG5ldmVyIGNhbWUgdG8gbXkgbWluZCB0byBkbyBpdCB3aGVuDQpJIHRlc3RlZCB3aGF0IFV3ZSB3
YXMgc3VnZ2VzdGluZy4NCg0KPj4+PiBPdGhlciB0aGFuIHRoYXQgbXkgYXBwcm9hY2ggbG9va3Mg
bW9yZSBlbGVnYW50IHRvIG1lICh3aGljaCBvYnZpb3VzbHkgaXMNCj4+Pj4gc3ViamVjdGl2ZSku
IEl0IHdvcmtzIGluIGFsbCBjYXNlcyBhcGFydCBmcm9tIHN5c2ZzICh3aGljaCBpcyBzcGVjaWFs
DQo+Pj4+IGJlY2F1c2UgaXQncyBub3QgaW50ZWdyYXRlZCBpbnRvIHRoZSBkZXZpY2UgbW9kZWwp
IGFuZCB0aGVyZSBpcyBubyBuZWVkDQo+Pj4+IHRvIHRlYWNoIHRoZSBwd20gZnJhbWV3b3JrIGFi
b3V0IHBpbm11eGluZyBhbmQgaW52ZW50IG5ldyBwaW5jdHJsIG1vZGVzDQo+Pj4+IGZvciBpdC4N
Cj4+Pg0KPj4+IEVsZWdhbmNlIGlzIHVzZWxlc3MgaWYgd2hhdCB5b3UgaGF2ZSBkb2Vzbid0IHdv
cmsgY29uc2lzdGVudGx5IGFuZA0KPj4+IHJlbGlhYmx5Lg0KPj4+DQo+Pj4gSSBkb24ndCB1bmRl
cnN0YW5kIHlvdXIgcmVzaXN0YW5jZSB0byB0aGUgcGluY3RybCB3b3JrLiBJdCdzIG5vdCByb2Nr
ZXQNCj4+PiBzY2llbmNlLiBNaWNoYWwgYWxyZWFkeSBwb3N0ZWQgcGF0Y2hlcyBzaG93aW5nIGhv
dyBpdCBjYW4gYmUgZG9uZSBhbmQNCj4+PiB0aGV5J3JlIG5vdCB2ZXJ5IGNvbXBsaWNhdGVkLiBB
bHNvIHdlJ3JlIG5vdCBkb2luZyBhbnl0aGluZyBvdXQgb2YgdGhlDQo+Pj4gb3JkaW5hcnkgaGVy
ZS4gVGhpcyBpcyBleGFjdGx5IHRoZSBwdXJwb3NlIG9mIHRoZSBwaW5jdHJsIGZyYW1ld29yaywg
c28NCj4+PiBsZXQncyB1c2UgdGhlIGJlc3QgdG9vbCBhdCBoYW5kLg0KPj4NCj4+IEluIG15IGxh
c3QgZXhjaGFuZ2Ugd2l0aCBNaWNoYWwgSSBoYWQgdGhlIGltcHJlc3Npb24gdGhhdCBoZSBsaWtl
ZA0KPj4gbXkgYXBwcm9hY2gsIHRvby4NCj4gDQo+IE15IGltcHJlc3Npb24gd2FzIHRoYXQgaGUg
d2FzIHRyeWluZyB0byBmaW5kIGNvbmNlbnN1cy4gQnV0IHRoZSB3YXkgSQ0KPiByZWFkIGl0IGhl
IHdhcyBzdGlsbCBhcmd1aW5nIHRoYXQgdGhlIHBpbmN0cmwgc29sdXRpb24gd2FzIHN0aWxsIHRo
ZQ0KPiBtb3N0IGNvbXBsZXRlLCBhbmQgd291bGQgdGhlcmVmb3JlIHN0aWxsIHByZWZlciBpdC4N
Cg0KSXQgaXMgbGlrZSB5b3Ugc2FpZCBUaGllcnJ5LiBJIGFtIG9ubHkgdHJ5aW5nIHRvIHJlbWFp
biBvcGVuIHRvIHRlc3QNClV3ZSdzIGlkZWFzLiBBZnRlciB3aGF0IEkgaGF2ZSB0ZXN0ZWQgc28g
ZmFyIEkgc3RpbGwgcHJlZmVyIGEgaW14LXNwZWNpZmljDQpwaW5jdHJsIHNvbHV0aW9uLg0KDQpN
aWNoYWwNCg==
