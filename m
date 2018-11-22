Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BA3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C56520685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="nS8SF6bG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C56520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437432AbeKWBDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:03:03 -0500
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:48928
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388795AbeKWBDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ayCV8bdRz1MNiIHDKQTO8KdxBk23cKV6sjTEs5lG9c=;
 b=nS8SF6bGm5mnkxoHwAB0d4AK9GTf9PK4KTzkXhF/PVFYSyunECYkWzOSuLK5Z7hWYAlGkMgMCRKVKPBN9DiXaZl8X7wDKx0al3+oaF7QQCSeNv6IBvKqiLwH53s3MBY0sKmUKvPhy5HbDGVAJxOM4Rm3IFkt16wiSv8d2zA6tQ8=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4460.eurprd04.prod.outlook.com (52.135.138.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Thu, 22 Nov 2018 14:23:22 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74%2]) with mapi id 15.20.1339.027; Thu, 22 Nov 2018
 14:23:22 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Thread-Index: AQHUYgmcdqbPphssxk6nsYPZEg3OjqUb10cA///wZACAGrOXAIANuquAgABCkICAABjxgIABl/8AgABCR4CAAUAfAIAAKkKAgAeB8YCAAKxBAIABJpqAgABXHYCAAN3NAIAGghGAgAA9mYCAAvpNAA==
Date:   Thu, 22 Nov 2018 14:23:22 +0000
Message-ID: <7c1dedaf-9a00-5dc2-e0dc-f94b637380bb@ysoft.com>
References: <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de> <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de> <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116095124.GA28631@ulmo>
 <6e81d63b-61a1-36fe-0c24-3ff27438cbc0@ysoft.com>
 <20181120165457.x7svxgzaae5at32x@pengutronix.de>
In-Reply-To: <20181120165457.x7svxgzaae5at32x@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0057.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::34) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4460;6:lzBNVoWDQWW8oTkeWIPo/BzJyW+D9XCb6vFwHM/J4h65h3MrpUNcuR11FU7fn3HOmUOZr1VBcM/xU/lWGPI9cjtDW3LVR8w2xI3zvXgrAR+mrU2BqMnptkL/HD7py42DyFSRxam3TbojIj+4o/kQM3xVnlkti/DQmZp0yCBqGprRamCt7tfR38vQH1HwnaQTiD09kf5jv5AM7tsQWE7zSyL0X5Zchxa0dCWwE/+7V3Ak+AEG/7QNvDk87TMEmWqtBeykgprEODzibu+sRPBHzG1sttWJag0QUozpaO9p3jmvLSErvfis7hPxQcREYVYoweD9HKUF/913GtwzfH9pAP4SNkMVt8bz4dpQQ5PY6IXo1In2QxtAzIHAqAHr7c3J1HMSFAxwFpTyZf77/og1MdONn84FLemcGU5iw4oD2CKBCvp+TdI5ZV+Xuy4NPDS2JLtBMzbSP1nPQ+wXNfDmZA==;5:ep/mRvOo/hJ2EAd+nrNGjADugu+5rK5z5i+M8hBCvL+BwEc5CyXpM5otoNm62NPUi+e5r+YrTix9twTl9zHc/CSplH9zaiyKWCYTOvD+E2Qtkb8zsYHtN1+PPoTgLlL2s4kPFW6jUOnwt6z6AsvKtKsuR43lWfLFKLYJmr3WDUc=;7:o08U9BYddQJTiT+3W5SWvGQr9ap/n2cEbHMF2kV9HyFDwe0oCVr8DmY7Ou+vY8OKVDT00YLr4HkAXo9wy3DkLTZJOBSCegNF59kFGk2SwKVxxGyAW0yr5fdvEvhE94Q9NcY+F77gORVasntoZ8VmfA==
x-ms-office365-filtering-correlation-id: 197a146c-5fb1-42b9-6963-08d650860e81
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4460;
x-ms-traffictypediagnostic: DB7PR04MB4460:
x-microsoft-antispam-prvs: <DB7PR04MB4460DE570953C6ACD14AB14A9EDB0@DB7PR04MB4460.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4460;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4460;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(136003)(366004)(376002)(346002)(189003)(199004)(229853002)(39060400002)(71200400001)(93886005)(66066001)(81156014)(6486002)(97736004)(66574009)(6512007)(106356001)(105586002)(478600001)(8936002)(72206003)(6436002)(6246003)(81166006)(14454004)(68736007)(31686004)(53936002)(71190400001)(5660300001)(446003)(11346002)(2616005)(476003)(2906002)(486006)(52116002)(85182001)(31696002)(99286004)(7736002)(86362001)(6916009)(305945005)(256004)(3846002)(7416002)(54906003)(2900100001)(36756003)(26005)(186003)(6116002)(4326008)(25786009)(386003)(6506007)(76176011)(102836004)(53546011)(316002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4460;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: s1ODZFUIn40PEqR00nMfHBQ30gWK+KpPFgyit6rnVFggwOS4RKa5LqUXqBJKMzuwYVZUzcI/NMxl+ZuAcWDrc+pSa1faVHOdNIa1qa3YCJZeUVYchmAzTeaW02TE3rNcfshcRVp8nZi2AzxC0UQmISnvN/Ivs5XbP9L3/V2pJaSygHjNfcKgDQmQHsyu3HYTXGeJv8pjciJNgGgLs2pf/+L46jWoxyM25PG4ChIqjHkNppB9HZsEr4Pw67R+SaIBLXjKn1NlaWUuW5985ZLF6FPcLYbdswGeFrxJIfrCIOCuYWZGLZGdQhEs6A/yWwSVb6GfEtku/44YZh/JJBzUpTR8vHx9noy3UZSwhF50K1s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C39776F290355408DE6D906C2A018ED@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 197a146c-5fb1-42b9-6963-08d650860e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 14:23:22.0424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWhvaiBVd2UsDQoNCk9uIDIwLjExLjIwMTggMTc6NTQsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3Rl
Og0KPiBPbiBUdWUsIE5vdiAyMCwgMjAxOCBhdCAwMToxNDozM1BNICswMDAwLCBWb2vDocSNIE1p
Y2hhbCB3cm90ZToNCj4+IE9uIDE2LjExLjIwMTggMTA6NTEsIFRoaWVycnkgUmVkaW5nIHdyb3Rl
Og0KPj4+IE9uIFRodSwgTm92IDE1LCAyMDE4IGF0IDA5OjM3OjMzUE0gKzAxMDAsIFV3ZSBLbGVp
bmUtS8O2bmlnIHdyb3RlOg0KPj4+PiBPbiBUaHUsIE5vdiAxNSwgMjAxOCBhdCAwNDoyNTo0NVBN
ICswMTAwLCBUaGllcnJ5IFJlZGluZyB3cm90ZToNCj4+PiBNeSBpbXByZXNzaW9uIHdhcyB0aGF0
IGhlIHdhcyB0cnlpbmcgdG8gZmluZCBjb25jZW5zdXMuIEJ1dCB0aGUgd2F5IEkNCj4+PiByZWFk
IGl0IGhlIHdhcyBzdGlsbCBhcmd1aW5nIHRoYXQgdGhlIHBpbmN0cmwgc29sdXRpb24gd2FzIHN0
aWxsIHRoZQ0KPj4+IG1vc3QgY29tcGxldGUsIGFuZCB3b3VsZCB0aGVyZWZvcmUgc3RpbGwgcHJl
ZmVyIGl0Lg0KPj4NCj4+IEl0IGlzIGxpa2UgeW91IHNhaWQgVGhpZXJyeS4gSSBhbSBvbmx5IHRy
eWluZyB0byByZW1haW4gb3BlbiB0byB0ZXN0DQo+PiBVd2UncyBpZGVhcy4gQWZ0ZXIgd2hhdCBJ
IGhhdmUgdGVzdGVkIHNvIGZhciBJIHN0aWxsIHByZWZlciBhIGlteC1zcGVjaWZpYw0KPj4gcGlu
Y3RybCBzb2x1dGlvbi4NCj4gDQo+IElzIHRoYXQgYmVjYXVzZSB5b3UgY29uc2lkZXIgaXQgcmln
aHQgdG8gYmUgaW14LXNwZWNpZmljIG9yIGJlY2F1c2UNCj4gdGhhdCdzIHdoYXQgeW91IGFscmVh
ZHkgaGF2ZT8gSXMgdGhlcmUgYSBmbGF3IGluIG15IGV4cGxhbmF0aW9uIHRoYXQNCj4gdGhlIHBy
b2JsZW0gaXNuJ3QgaW14LXNwZWNpZmljIHBlciBzZSBhbmQgc28gdGhlIHNvbHV0aW9uIHNob3Vs
ZG4ndCBiZQ0KPiB0aGF0IGVpdGhlcj8NCg0KSSBjb25zaWRlciBpdCByaWdodCB0byBiZSBpbXgt
c3BlY2lmaWMgYmVjYXVzZSBvZiB0aGUgY3VycmVudCBzdGF0ZSBvZg0KYXdhcmVuZXNzIGFuZCBp
bnRlcmVzdCBpbiB0aGlzIHByb2JsZW0gZnJvbSBvdGhlciBTb0MncyBjb21tdW5pdGllcy4NCkkg
c3BlbnQgcXVpdGUgc29tZSB0aW1lIGxvb2tpbmcgZm9yIGEgc29sdXRpb24gYW5kIG15IGltcHJl
c3Npb24gaXMgdGhhdA0Kb25seSBpbXggdXNlcnMgcGVyY2VpdmUgdGhpcyBwcm9ibGVtIGFuZCBh
cmUgdGhlIG9ubHkgb25lIHRoYXQgYWxyZWFkeQ0KZGlkIHNvbWUgYXR0ZW1wdHMgdG8gc29sdmUg
aXQuDQoNCkkgdGhpbmsgdGhpcyBpcyBpbiBsaW5lIHdpdGggd2hhdCBUaGllcnJ5IHNhaWQgLSBp
ZiBvdGhlciB1c2VycyBoYXZlDQp0aGUgc2FtZSBwcm9ibGVtLCB0aGV5IHNob3VsZCBzcGVhay11
cC4gSW4gbXkgZXllcyBhcyBoZSBpcyB0aGUgcHdtDQpzdWJzeXN0ZW0gbWFpbnRhaW5lciBoZSBr
bm93cyB0aGUgYmVzdCBpZiBvdGhlcnMgaGF2ZSB0aGUgc2FtZSBwcm9ibGVtDQpvciBub3QuIE15
IHVuZGVyc3RhbmRpbmcgb2YgaGlzIGFyZ3VtZW50cyBpcyBzdWNoIHRoYXQgdGhleSBkbyBub3Qu
DQoNCkkgdW5kZXJzdGFuZCB0aGF0IGhhdmluZyBhIG1vcmUgZ2VuZXJpYyBzb2x1dGlvbiBtYXkg
YmUgYmV0dGVyLiBJIGFtIG5vdA0KcmVhbGx5IHN1cmUgaWYgaXQgaXMgdmFsaWQgaW4gdGhpcyBj
YXNlLg0KDQo+IElzIHRoZSBwcm9ibGVtIHdpdGggdGhlICJ0ZXN0cyBzbyBmYXIiIHRoYXQgaXQg
ZG9lc24ndCB3b3JrIHlldCwgb3IgaXMNCj4gdGhlcmUgc29tZXRoaW5nIGNvbmNlcHR1YWxseSB3
cm9uZyBpbiB5b3VyIGV5ZXM/DQoNCkl0IGRvZXMgbm90IHdvcmsgeWV0LiBBbmQgaXQgd291bGQg
bm90IHNvbHZlIGFsbCB0aGUgY2FzZXMuIE5hbWVseSB0aGUNCnN5c2ZzIHVzZS1jYXNlLiBBbmQg
VGhpZXJyeSBjb25maXJtZWQgc3lzZnMgaXMgYSBzdXBwb3J0ZWQgaW50ZXJmYWNlLg0KDQpJIGRv
IG5vdCBkYXJlIHRvIHNwZWN1bGF0ZSB3aGV0aGVyIHlvdXIgaWRlYSBpcyBjb25jZXB0dWFsbHkg
d3Jvbmcgb3INCm5vdC4gSSBvbmx5IGNhbiBzYXkgdGhhdCBwdXR0aW5nIHRoZSBwaW5jdHJsIG9m
IHRoZSBQV00gcGluIGludG8gdGhlDQpQV00gY29uc3VtZXIgc2VlbXMgdmVyeSB1bm5hdHVyYWwg
dG8gbWUuIEkgaGF2ZSBub3Qgc2VlbiBhbnkgZXhhbXBsZQ0Kb2Ygc3VjaCB1c2FnZSB5ZXQuIFRo
YXQgZG9lcyBub3QgbWVhbiBpdCBpcyB3cm9uZyBvZiBjb3Vyc2UuDQoNCk9uIHRoZSBvdGhlciBo
YW5kLCB5b3Ugc2FpZCB0aGF0IHdlIGFyZSBpbnZlbnRpbmcgbmV3IHBpbmN0cmwgbmFtZXMuDQpC
dXQgSSBzZWUgcXVpdGUgYSBsb3Qgb2YgdXNhZ2VzIG9mIG5vbi1bImluaXQiLCAiZGVmYXVsdCIs
ICJzbGVlcCJdDQpwaW5jdHJsIG5hbWVzIGluIHRoZSBEVFMgZmlsZXMuIE1vc3Qgb2YgdGhlbSBh
cmUgYWN0dWFsbHkgaW14IHVzZXJzLg0KDQpTdGlsbCwgdGhlIG1haW4gcHJvYmxlbSBpcyBpdCBp
cyBub3QgcG9zc2libGUgdG8gdHVybi1vZmYgdGhlIGJhY2tsaWdodA0Kb3IgY29vbGluZyBmYW4g
b3Igd2hvZXZlciBpcyB0aGUgUFdNIGNvbnN1bWVyIGlmIGludmVydGVkIFBXTSBpcyB1c2VkLg0K
Tm90IHRoYXQgaXQgaXMgbm90IHBvc3NpYmxlIHRvIGtlZXAgaXQgdHVybmVkLW9mZiB1bnRpbCBp
dCBpcyB0dXJuZWQtb24NCmJ5IHRoZSB1c2VyLiBTbyBmb3IgbWUsIGFueSBzb2x1dGlvbiB0aGF0
IGF0IGxlYXN0IGFsbG93cyB0aGF0IGlzIGJldHRlcg0KdGhhbiB0aGUgY3VycmVudCBzdGF0ZS4g
VGhlIHBpbmN0cmwgc29sdXRpb24ganVzdCBzb2x2ZXMgYWxsIGF0IG9uY2UuDQoNCkkgZnVsbHkg
YWdyZWUgdGhlIHBpbmN0cmwgc29sdXRpb24gaGFzIGRyYXdiYWNrcy4gSXQgbmVlZHMgdG8gYmUg
d2VsbA0KZG9jdW1lbnRlZCBhbmQgRFQgYXV0aG9ycyBuZWVkIHRvIGtub3cgaG93IHRvIHVzZSBp
dCBhbmQgaW4gd2hhdCBjYXNlcy4NCg0KQmVzdCByZWdhcmRzLA0KTWljaGFsDQoNCg==
