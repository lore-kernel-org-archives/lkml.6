Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84275C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E89222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sthZanLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbfBMLtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:49:24 -0500
Received: from mail-eopbgr20045.outbound.protection.outlook.com ([40.107.2.45]:6976
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732034AbfBMLtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTzNq7wBAWHngC+C9UD74/ocftJ3cou5O/pfLloUEZw=;
 b=sthZanLOnb+chZMwyG2PbazAsKMWMxjE7u6wByUDwSec5fSQG+OIX2xgRP+12RnnzNo/XJphLvwnQebbkfE8eKK1S2MMVl7mZW+lPzO1aD4fTaM63rUW8Sv8VMKEKukFW2Tk1+S5hH4+rHww1ZTFEob0Mt9Talue/bQb0Fo6L6A=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB5259.eurprd04.prod.outlook.com (20.176.236.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 13 Feb 2019 11:49:18 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5%6]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 11:49:18 +0000
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
Subject: RE: [PATCH 1/3] arm64: mmu: update paging_init comments
Thread-Topic: [PATCH 1/3] arm64: mmu: update paging_init comments
Thread-Index: AQHUw3+594hgBkL8LUmsAWmiVRUwoqXdlMAAgAAIQ/A=
Date:   Wed, 13 Feb 2019 11:49:18 +0000
Message-ID: <DB7PR04MB4490DDB031B96F5146DC3E4B88660@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190213094831.7292-1-peng.fan@nxp.com>
 <20190213111841.GA22119@lakrids.cambridge.arm.com>
In-Reply-To: <20190213111841.GA22119@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57c00f7c-a4e0-4daf-a496-08d691a94939
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5259;
x-ms-traffictypediagnostic: DB7PR04MB5259:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjdQUjA0TUI1MjU5OzIzOis2OWJGQ2doNjRSRC9STkM3K3dXVHpQUkZv?=
 =?gb2312?B?N09hWUlnK09oMUx0SkNIeEh0YlJsdFIvOWJueUVRZW1Uc3RYUVRZaWNTRGhR?=
 =?gb2312?B?Z3dBZ2tzamFKM1Qwc0NZYVQ4MzlNckdNbzR0NU9xcnZzQkJSc09iUloreXFy?=
 =?gb2312?B?Qmt2TE4rL3lRakxoV0FXYlpSanVrb1lPdEg5OVF0V2cwYXZaQmZNdU1XSWtu?=
 =?gb2312?B?cklxdFZIcW9BNW5RbTZwcWEwSis0VmZJeXRFVGJIN2ZXQU9aTFRiSjVUYkNX?=
 =?gb2312?B?a2d2SVp2SFUzcWNKM05ubTJWcG54cm1CSkNJUFlTOE5CdThHTi9qVDE3K0Qx?=
 =?gb2312?B?dXYvQzRsU2psL0VNMmJJL0FyVnA5TnhYZG1ZbHJWMDE4d2xMWnZpS2EyYkUy?=
 =?gb2312?B?UVhMYVVneGRPZUV0R3MvUDJ3NmhpNUhMT09KM2taaXVCK2NDSWg4d1BpZExI?=
 =?gb2312?B?Z2tTMndLWlFFZ3h0TzgvblV1S2w3cUpkNWc5TGJPKzhhb0ZrOU9MY2wxRGtJ?=
 =?gb2312?B?cFJBMEs5UTZ1Y2lLSmVPZ1czcW5XNzFJMi9HZjI3eUNvY3gxcWJ1VW1iV0Vs?=
 =?gb2312?B?YUFxM1lwQmQ1eXdFaEJ6bFRJMjRkdWRTMlpQcmFETmQ0VllaSUQvbjdTVWYr?=
 =?gb2312?B?VXM0WWMxVnIxbTBWVjJ6YUIyb1ZMaElKcXg0ZDhTMkJMQTI3S1pKL2FHZ3Nu?=
 =?gb2312?B?MVpzZndrQVJKeUhqNCsxTVBuaWZNcUNiWnN4N2pDbzhsQlFZaDFGRUNIQ3pK?=
 =?gb2312?B?QzgzcklnMWd0dWNrd2I0ejlkSWxmNWlWZExETEF4V25xODZsRjJ5b0o4YnNi?=
 =?gb2312?B?Sk42dUZXdlRlUWRpVmpqZndxb0NEOTVMOWtGOERkQmtmRWo2b0htMytpRjVF?=
 =?gb2312?B?N1c1MmZEOS8zMEdBbHRualQ5cWFhWnlCTnA4d2JTaXJiKzBjbTMrTlc1Vlox?=
 =?gb2312?B?V2Zoa1NLOFVDem12SlNjdU9XZW5lc2VqRnJyZU5pR2Vxd1Q3WCtYRDhrZThl?=
 =?gb2312?B?VmdvdFN5TlB1WjUwUnBya01FR0kxMXd2WTFkVks0dU9OakxlZTZFVjNEeHJW?=
 =?gb2312?B?WmFtQmxCVXRsanA2d05FT2o1YUxsR2p2ZmRROWdnY29xWkVuVWIwTTN4S0p5?=
 =?gb2312?B?S0J1Sm1GWGZjYis5cHNJM253NzNrb0w5MHZCYkhnUGdDUzhYVmVWSGhXMklR?=
 =?gb2312?B?QWgrS0pCNmNpWWRmYmdQenA3L1BsVGpUaGZia0crd1pCZkpMSkcveXhmTUJE?=
 =?gb2312?B?RFU4WDdPbFFKMWYyVTlqRE5mS1RtSE44c0hJZ0Zwb3FLVUM5VURQQ1ZBcHps?=
 =?gb2312?B?TzdRWEp3ZVYzSVZ1bzJnUlYwU1RybWhhUUVmeDNyYnIxNEUrZzJucm9Fdmh2?=
 =?gb2312?B?cU5pd2RCeVlYK1pLYm5EYkw0Q1FCOEFuUFhSelJTZjJpVDNBeXZuNElGL29k?=
 =?gb2312?B?cXFOaURoTzVDK2pvZUJRNHhlemZENzJPMXR2Y2FFbVhqNEVZVTBOMjJZK0dp?=
 =?gb2312?B?cG00QmFTMit0VGUwNXdlQnU3QnlLSW5SRU9jR0N6VlY4VGVkR0FiZHhoKzZv?=
 =?gb2312?B?ZE5ZOVcvSmw5dDVPRWMzcnNMeUJaVU90L282WDNudlNhaXJoc2xsUFpkL0dh?=
 =?gb2312?B?TDh2eXlsdjBQc0R1OWdyTGQ4bi9yUHVIdkxJRVI3UUtYd2F3c0dIeVlQdlZU?=
 =?gb2312?B?d0FkWHAwM1Jwbk4xUjlXYk1pZjJ2RUc4SkFoU2NXK290U3NaVzREbmhSVnE1?=
 =?gb2312?Q?IcQl84bKXfLLy4IfUoGSbUQTDcttvSQ3+euH4=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB5259447506ECFE428D9C397388660@DB7PR04MB5259.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(39860400002)(396003)(51444003)(189003)(199004)(13464003)(6916009)(25786009)(486006)(256004)(316002)(76176011)(86362001)(7416002)(54906003)(446003)(102836004)(15650500001)(11346002)(14454004)(7696005)(186003)(53546011)(6506007)(105586002)(6436002)(229853002)(476003)(4326008)(71200400001)(106356001)(71190400001)(81156014)(81166006)(99286004)(6116002)(66066001)(8676002)(68736007)(44832011)(55016002)(9686003)(478600001)(26005)(53936002)(14444005)(305945005)(74316002)(7736002)(97736004)(2906002)(6246003)(8936002)(33656002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5259;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N+woFBjMXE+XprtsNnpEkVi5zG41AK/2tOYt6lV1IKWcFudMtXfsbeGq1gm7hqQbhL4ZatJC5T44Da0qvQM/AWqvmFj7b/TK1/+Su5oYrDVgpm+Hrhkt38s334zJ9Gl7Rss2zH7X9eJGVH/aqjUkPW7jvDFbrYlbYVyCxignnJgg6WLpJTaBiB+TUaiAQAh4twROcBb5zXblGVU3TDqpmdmrLhuKGuEbhW8b1Qs8xhykeATCbpchgwKT9Wd5LVJXWp1JWNShIvHXyLgGdBdPhsev6KkOznnSU7yNXFY7ai4OI8/9zQ8CTJr5p3YANme6QHTH59UahUfYJh8bBn5Bh1gy/jk96mbyp3fiTd8o25ZYrHdDCxfo9jE1l9hpzAaUjbUSadE3BVQY198saS0lwqlW8wskVSzaOdTSc8osQLs=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c00f7c-a4e0-4daf-a496-08d691a94939
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 11:49:18.1637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrIFJ1
dGxhbmQgW21haWx0bzptYXJrLnJ1dGxhbmRAYXJtLmNvbV0NCj4gU2VudDogMjAxOcTqMtTCMTPI
1SAxOToxOQ0KPiBUbzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IENjOiBjYXRhbGlu
Lm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gYXJkLmJpZXNoZXV2ZWxA
bGluYXJvLm9yZzsgeWFvanVuODU1ODM2M0BnbWFpbC5jb207DQo+IGNwYW5keWFAY29kZWF1cm9y
YS5vcmc7IHJvYmluLm11cnBoeUBhcm0uY29tOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHZhbi5mcmVlbml4
QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gYXJtNjQ6IG1tdTogdXBkYXRl
IHBhZ2luZ19pbml0IGNvbW1lbnRzDQo+IA0KPiBPbiBXZWQsIEZlYiAxMywgMjAxOSBhdCAwOToz
NzoyNEFNICswMDAwLCBQZW5nIEZhbiB3cm90ZToNCj4gPiBUaGUgY29tbWVudHMgaGFzIG5vdCBi
ZWVuIGNoYW5nZWQgc2luY2UgdGhlIGZ1bmN0aW9uIGludHJvZHVjZWQsIGJ1dA0KPiA+IHRoZSBm
dW5jdGlvbiBoYXMgYmVlbiBjaGFuZ2VkIGRyYW1hdGljYWxseSwgc28gdXBkYXRlIHRoZSBjb21t
ZW50cyB0bw0KPiA+IHJlZmxlY3QgdGhlIGNvZGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9tbS9t
bXUuYyB8IDQgKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvbW0vbW11LmMgYi9h
cmNoL2FybTY0L21tL21tdS5jIGluZGV4DQo+ID4gZDZiNmYxYjE2OWJiLi4wNjUyMDJkYTNhZDIg
MTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9tbS9tbXUuYw0KPiA+ICsrKyBiL2FyY2gvYXJt
NjQvbW0vbW11LmMNCj4gPiBAQCAtNjU1LDggKzY1NSw4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBt
YXBfa2VybmVsKHBnZF90ICpwZ2RwKSAgfQ0KPiA+DQo+ID4gIC8qDQo+ID4gLSAqIHBhZ2luZ19p
bml0KCkgc2V0cyB1cCB0aGUgcGFnZSB0YWJsZXMsIGluaXRpYWxpc2VzIHRoZSB6b25lIG1lbW9y
eQ0KPiA+IC0gKiBtYXBzIGFuZCBzZXRzIHVwIHRoZSB6ZXJvIHBhZ2UuDQo+ID4gKyAqIHBhZ2lu
Z19pbml0KCkgc2V0cyB1cCB0aGUgcGFnZSB0YWJsZXMsIHN3aXRjaCB0dGJyMSBmcm9tDQo+ID4g
KyBpbml0X3BnX2Rpcg0KPiA+ICsgKiB0byBzd2FwcGVyX3BnX2RpciwgZnJlZSBpbml0X3BnX2Rp
ciBtZW1ibG9jayBhbmQgcGVybWl0IG1lbWJsb2NrDQo+IHJlc2l6aW5nLg0KPiA+ICAgKi8NCj4g
DQo+IEkgdGhpbmsgdGhhdCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gcmVtb3ZlIHRoZSBjb21tZW50
IGVudGlyZWx5LiBUaGlzIGRvZXNuJ3QNCj4gZXhwbGFpbiB0aGUgaW50ZW50LCBvciByYXRpb25h
bGUsIGFuZCBhbGwgdGhpcyBpbmZvcm1hdGlvbiBpcyBvYnZpb3VzIGZyb20gYQ0KPiBzdHJhaWdo
dC1saW5lIHJlYWRpbmcgb2YgdGhlIGNvZGUuDQo+IA0KPiBJZiB5b3UgcmVtb3ZlIHRoZSBjb21t
ZW50IGluc3RlYWQ6DQo+IA0KPiBBY2tlZC1ieTogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRA
YXJtLmNvbT4NCg0KSSdsbCByZW1vdmUgdGhlIGNvbW1lbnQgd2l0aCB5b3UgYS1iIGFkZGVkLg0K
DQpUaGFua3MsDQpQZW5nLg0KPiANCj4gTWFyay4NCj4gDQo+ID4gIHZvaWQgX19pbml0IHBhZ2lu
Z19pbml0KHZvaWQpDQo+ID4gIHsNCj4gPiAtLQ0KPiA+IDIuMTYuNA0KPiA+DQo=
