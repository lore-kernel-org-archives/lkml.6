Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7917C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B363222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g3GmU3xC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbfBMLzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:55:01 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:46654
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbfBMLzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTZpymLax93ipnQOXUrsWmxM+y+KLH4kLeLeq9/khJY=;
 b=g3GmU3xCyTfhxwcmqjconJEZOtxCPmpfeTdua8+WY2FsfD973/Rod46t+ifoG4/jkwYeG6pWbvI2Q2S/FimdQMalXNULIeOy7DmQf8OmGu7nAZL+NVTWu5tNzSAXwyCTrxbmJV127ewQaLfNxOQkcHB4e0ho6OJAWkUZo6i1KBI=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB4076.eurprd04.prod.outlook.com (52.135.130.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 11:54:55 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5%6]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 11:54:55 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 3/3] arm64: mmu: pgd_pgtable_alloc: drop barrier
Thread-Topic: [PATCH 3/3] arm64: mmu: pgd_pgtable_alloc: drop barrier
Thread-Index: AQHUw3/CYobPCtINwEOlvcbOdnGfRqXdmCWAgAAGJyA=
Date:   Wed, 13 Feb 2019 11:54:55 +0000
Message-ID: <DB7PR04MB4490EAD2E829E17CCE81C5F188660@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190213094831.7292-1-peng.fan@nxp.com>
 <20190213094831.7292-3-peng.fan@nxp.com>
 <20190213113050.GC22119@lakrids.cambridge.arm.com>
In-Reply-To: <20190213113050.GC22119@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9de51849-eaa3-4e4f-154b-08d691aa120f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4076;
x-ms-traffictypediagnostic: DB7PR04MB4076:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjdQUjA0TUI0MDc2OzIzOkZtQXZ5WXFFcEg1Y29KaUc2bnJDRHdCa1pp?=
 =?gb2312?B?bzM1NHZKRW52YnlYaEU1RGpIb0JzK2RBS1ZvTklteEdWQVpEYjVlSWhYNHRv?=
 =?gb2312?B?YzJNTlhzZTVWelJobmpXSWZXZlVqaU1RcnFvdVlLaXhUdVRFdXl3K21mcE9S?=
 =?gb2312?B?VDBmNTM0U0xRZ2FFM3Q1RHQ1M3A3aHNibmxmWXlVcjVENnZvSm1uL01yNUI1?=
 =?gb2312?B?M2dld1ZaQy9PK3c4S0ZWWnNFSTk4cXhaUnYrZXU0Y2ZKVkgwYTVnMTJFeCtL?=
 =?gb2312?B?MWhTQzZLRFZnRHM2aENyOTlvN0hjalhrMFd1NGNjUUpJRnd6Zm9hK3V2bisy?=
 =?gb2312?B?bmFzamxvdmVJd09mek1XS1Rlb05XYThpVGtjcEJEWGdTb1QxOFNMeXEzQktz?=
 =?gb2312?B?NUZ6cHYwR2pqNklOd2lYSkZ1dnFtcDBNSmlSMWNHNkwxQkZLcis3aEFWZ1F2?=
 =?gb2312?B?MUZDaVhEZytHbWdocW9Yd0RISHA2TURuSGZQZko3Z2R3V0tGa0VpMm5ZSlBW?=
 =?gb2312?B?RXQxcnFpeThvSFBiUmRVd3NybHd1NmNiUXcrYnJDQmNzZmZySVBwazhMdDI5?=
 =?gb2312?B?SkJkREZBdmk0SEdDZ1cvU00vTXR5dXNFMU1RQWZpQ1dabmJ2Q3Vxd00rVUVQ?=
 =?gb2312?B?QWwzVTExOEsrMG4zOEUraWdzQ3NKeGhGYkhwdytxczRCeXNZc25oQWd1alJt?=
 =?gb2312?B?YnhIYTdPWHlYa3RSd3BUTS82RVJLSVNGYWtOOWdld1JZN1pST0FqaERZdzUr?=
 =?gb2312?B?Y1ZqUFI1WS9NM2xBZ2lObHlnSS92US95WW5KZnpubXBJMDlWQ3hxQklCTHBN?=
 =?gb2312?B?UmU4Q1lSdVRYcVBGR1h0UWl3R045RTQwaEZKM1dXRnJuTzgvQzNJVFRlamZx?=
 =?gb2312?B?ODVPOUR3dDU4WG5RNlloN3pia2prS3lvenN4V2ZmWHlsdjJWR3NHR1dYN3la?=
 =?gb2312?B?TkJRWGJ0dlBHWFkxeEZNWGU0dU85aWlXTnBNb3VNSmduYi9vaWppZFczUGtJ?=
 =?gb2312?B?YXJHSm1zY1hCTnVhZ011RWt2ZGp5OFgrcHpvMTMrMW9PRGhnWWRuN0J2b3Rv?=
 =?gb2312?B?UUpIVEUrL0lqN0ppRE9oQUxJZ2YwUUJpTDUwVy9Oejh6dWFuNVBPL3dSNzZo?=
 =?gb2312?B?MnRlUDRBSEhsUE1mSkFGUjZWdFVrem1oTmZJeXRJS3hLRjBSUHhiNG5sZDVm?=
 =?gb2312?B?TzdROXB2bEhuWUNRTXkzYitJRWVvcUdJWEVPQWtjSHdEbGYwbWpYcGs4MkJH?=
 =?gb2312?B?YUxvZzlDRlRCdUVtQ2NMTG90WTQzRjBpZmxkU1hYOHhRcE4ydklsN0tlcG9m?=
 =?gb2312?B?OVpBV2NaektIRWFnaEdOa2xpdlQ1ekJlZzYxS2pSdE9aamVpa2ZWYVIyTFBi?=
 =?gb2312?B?OHpWaVhzYTM4cnlXOVcvQ3ZIQnlsVmxQdjUyd2p4QVBxdlo1aVF2SlFaODY3?=
 =?gb2312?B?Ulo0aG03RFhkZTJ5M20yTERMQms1by9nd2NVOG1hQ2JabzVzR3BmTUZVbXVS?=
 =?gb2312?B?WEhmTnNJdStoNHE0ekRFN2NYSCs2S0g1L0hzbTgrRVBUNTZjOGNYeFZUSlN6?=
 =?gb2312?B?aGdYQXFJL0UvbmtneWV2RUcxLzRBVG1NTmJXajFHa3FkeXZMSnJNSUxidDRO?=
 =?gb2312?B?VTgxUXd6SEM3a0kvOE0xTzFHVXdJdXZjUFBNR0s1bmI4ZjhyODBJNWJybGxC?=
 =?gb2312?Q?ZSlNbNlW9Jwl7RT44oiZ+vyYzoAVYtJSWEbi8Oe?=
x-microsoft-antispam-prvs: <DB7PR04MB4076542340D12CA0A6EF2FFF88660@DB7PR04MB4076.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(13464003)(199004)(189003)(25786009)(106356001)(105586002)(71200400001)(33656002)(71190400001)(26005)(6436002)(53936002)(68736007)(54906003)(9686003)(55016002)(4326008)(6246003)(229853002)(316002)(7696005)(86362001)(76176011)(8676002)(53546011)(8936002)(476003)(81166006)(81156014)(478600001)(6916009)(14454004)(99286004)(256004)(186003)(97736004)(102836004)(44832011)(14444005)(2906002)(6116002)(486006)(3846002)(7416002)(66066001)(305945005)(7736002)(11346002)(74316002)(6506007)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4076;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6gguK0SGzqa4rKe1dmtykZnouzG2LPXHDH19NdhANLNS89xc4FdQAPf/h6BPzQJbi9wGM9uJYQoJMHFPPBMsPDtrxgKlO4dlhPunoHPoSe08EWqiCpgFStFLZ5Um6flxRUd7f7927+51Dnwc+136xQ+ARjU2CWH23fmmOcbr7dmYRrfwGaqCE8Goh5qoNCQ6t4lWcF8ZaJ+lKnyN93awIXM9wugVET03w26LT62ED0NpKq55hP/2iRSW9GHC1J+FDKwxe79Pgs1b8mmOztdmbv6HOtF+a/uMWzEKRfFgXadwTeYGPIIfHwIAxYXh61bJTKB7JDo5+7y2ma5335B8PBRaPTbdrAGznK16RoS2QLAvcLm1o4VF6RY8NnHF0W7lCyEhVQos/AWrq+vDWP2RE6lnazJ29IRLoXkXkadGdFY=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de51849-eaa3-4e4f-154b-08d691aa120f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 11:54:55.1829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrIFJ1
dGxhbmQgW21haWx0bzptYXJrLnJ1dGxhbmRAYXJtLmNvbV0NCj4gU2VudDogMjAxOcTqMtTCMTPI
1SAxOTozMQ0KPiBUbzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IENjOiBjYXRhbGlu
Lm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gYXJkLmJpZXNoZXV2ZWxA
bGluYXJvLm9yZzsgeWFvanVuODU1ODM2M0BnbWFpbC5jb207DQo+IGNwYW5keWFAY29kZWF1cm9y
YS5vcmc7IHJvYmluLm11cnBoeUBhcm0uY29tOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHZhbi5mcmVlbml4
QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gYXJtNjQ6IG1tdTogcGdkX3Bn
dGFibGVfYWxsb2M6IGRyb3AgYmFycmllcg0KPiANCj4gT24gV2VkLCBGZWIgMTMsIDIwMTkgYXQg
MDk6Mzc6MzhBTSArMDAwMCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4gVGhlIGJhcnJpZXJzIGFyZSBh
ZGRlZCBmb3IgZW1wdHlfemVyb19wYWdlLCBob3dldmVyIHRoZSBlbXB0eSB6ZXJvDQo+ID4gcGFn
ZSBoYXMgYmVlbiBtb3ZlZCB0byBic3MgYXJlYSBieSBjb21taXQgNTIyN2NmYTcxZjllICgiYXJt
NjQ6IG1tOg0KPiA+IHBsYWNlIGVtcHR5X3plcm9fcGFnZSBpbiBic3MiKSwNCj4gPiBhbmQgaXQg
YWxyZWF5IGFkZGVkICJkc2IgICAgIGlzaHN0IiBpbiBoZWFkLlMgdG8gbWFrZSBzdXJlDQo+ID4g
dGhlIGVtcHR5IHplcm8gcGFnZSB2aXNpYmxlIHRvIFBUVy4NCj4gDQo+IFRoZSAiemVyb2VkIHBh
Z2UiIHRoZSBjb21tZW50IHJlZmVycyB0byBpcyBub3QgZW1wdHlfemVyb19wYWdlLg0KDQpUaGFu
a3MsIEkgdW5kZXJzdGFuZCB3cm9uZy4NCg0KPiANCj4gVGhlIHBhZ2UNCj4gdGhlIGNvbW1lbnQg
cmVmZXJzIHRvIGlzIGFuIGFyYml0cmFyeSBwYWdlIHJldHVybmVkIGJ5IF9fZ2V0X2ZyZWVfcGFn
ZSgpLA0KPiB3aGljaCBoYXMgYmVlbiBmaWxsZWQgd2l0aCB6ZXJvZWQgYXQgc29tZSBwb2ludCB0
aGFua3MgdG8gUEdBTExPQ19HRlANCj4gY29udGFpbmluZyBfX0dGUF9aRVJPLg0KPiANCj4gPiBw
Z2RfcGd0YWJsZV9hbGxvYyBpcyBvbmx5IGNhbGxlZCBieSBfX2NyZWF0ZV9wZ2RfbWFwcGluZywg
YW5kIHRoZXJlDQo+ID4gYXJlIGltcGxpY2l0IGJhcnJpZXJzIGluIF9fY3JlYXRlX3BnZF9tYXBw
aW5nLCBzbyB3ZSBjb3VsZCByZW1vdmUgdGhlDQo+ID4gYmFycmllciBwZ2RfcGd0YWJsZV9hbGxv
Yw0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIGlzIHRydWUuDQo+IA0KPiBDb25zaWRlcjoNCj4g
DQo+ICAgY3JlYXRlX3BnZF9tYXBwaW5nKCkNCj4gICAtPiBfX2NyZWF0ZV9wZ2RfbWFwcGluZygp
DQo+ICAgICAgLT4gYWxsb2NfaW5pdF9wdWQoKQ0KPiAgICAgICAgIC0+IHBndGFibGVfYWxsb2Mo
KSAvLyBwZ2RfcGd0YWJsZV9hbGxvYygpDQo+IAktPiBfX3BnZF9wb3B1bGF0ZSgpDQo+IA0KPiAu
Li4gd2hlcmUgQUZBSUNUIHRoZXJlIGlzIG5vIGJhcnJpZXIgYmV0d2VlbiBwZ3RhYmxlX2FsbG9j
KCkgYW5kDQo+IF9fcGdkX3BvcHVsYXRlKCkuDQo+IA0KPiBXaGVyZSBpcyB0aGUgYmFycmllciBi
ZXR3ZWVuIHRoZSBwYWdlIHplcm9pbmcgYW5kIHRoZSB1cGRhdGUgb2YgdGhlIHBnZA0KPiBlbnRy
eT8NCg0KSSB0aG91Z2ggdGhlIGJhcnJpZXIgaW4gX19wZ2RfcG9wdWxhdGUgY291bGQgYmUgZW5v
dWdoLCBidXQgdGhpcyBpcyBub3QNCmVub3VnaCwgd2Ugc3RpbGwgbmVlZCBiYXJyaWVyIGJlZm9y
ZSB3cml0ZSBwZ2QvcHVkL3BtZC9wdGUgZW50cmllcy4NCg0KU28gZHJvcCB0aGlzIHBhdGNoLg0K
DQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBUaGFua3MsDQo+IE1hcmsuDQo+IA0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4N
Cj4gPiBOb3RlOiB0aGlzIHBhdGNoIHRlc3RlZCBvbiBxZW11LXN5c3RlbS1hYXJjaDY0LCBub3Qg
cmVhbCBoYXJkd2FyZS4NCj4gPg0KPiA+ICBhcmNoL2FybTY0L21tL21tdS5jIHwgMiAtLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L21tL21tdS5jIGIvYXJjaC9hcm02NC9tbS9tbXUuYyBpbmRleA0KPiA+IGY2MWZh
N2M4ZmQyZS4uMDRlM2Q0ZDA3MGNlIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvbW0vbW11
LmMNCj4gPiArKysgYi9hcmNoL2FybTY0L21tL21tdS5jDQo+ID4gQEAgLTM3MSw4ICszNzEsNiBA
QCBzdGF0aWMgcGh5c19hZGRyX3QgcGdkX3BndGFibGVfYWxsb2Modm9pZCkNCj4gPiAgCWlmICgh
cHRyIHx8ICFwZ3RhYmxlX3BhZ2VfY3Rvcih2aXJ0X3RvX3BhZ2UocHRyKSkpDQo+ID4gIAkJQlVH
KCk7DQo+ID4NCj4gPiAtCS8qIEVuc3VyZSB0aGUgemVyb2VkIHBhZ2UgaXMgdmlzaWJsZSB0byB0
aGUgcGFnZSB0YWJsZSB3YWxrZXIgKi8NCj4gPiAtCWRzYihpc2hzdCk7DQo+ID4gIAlyZXR1cm4g
X19wYShwdHIpOw0KPiA+ICB9DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTYuNA0KPiA+DQo=
