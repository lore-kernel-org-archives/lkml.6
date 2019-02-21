Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21264C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C012086D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PqWGu423"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBUDb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 22:31:26 -0500
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:2179
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbfBUDbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 22:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVcT52lzqZ5XKlj4+LcKIlwEIIJs/4sc+p0D/sVz6ZM=;
 b=PqWGu423M++mo6tRi6mzEJLNHHFMHtAlFDgGU/FjKxpCff8grLMUq205sH7fqjTeOOPlwW7n7Hl96jZJqtfNH2hmUjn2UQ0sD8fQroqBu2mxL5R89MXbXEvxnouTE5F350xQeffi09NuNQChd5JC0Tv8e/X+JYUefTpb9HD0WXE=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB3056.eurprd04.prod.outlook.com (10.170.228.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 03:29:41 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2%3]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 03:29:41 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: RE: [PATCH v3] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
Thread-Topic: [PATCH v3] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
Thread-Index: AQHUxUqvA6eOAzVWPUW+Xl7987JiyqXk4fzAgABcX4CABELMwA==
Date:   Thu, 21 Feb 2019 03:29:41 +0000
Message-ID: <VI1PR04MB53278AE9AB6C14DA2AB96F6A8B7E0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190215162225.19284-1-paul.kocialkowski@bootlin.com>
         <VI1PR04MB53274C03CD18C3D3ADB767408B630@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <c80ee02db4a22d15a24281384ae561462593684f.camel@bootlin.com>
In-Reply-To: <c80ee02db4a22d15a24281384ae561462593684f.camel@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7eabb189-0bfb-4c87-876d-08d697acd0c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3056;
x-ms-traffictypediagnostic: VI1PR04MB3056:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUIzMDU2OzIzOjVNZDBpZUc5dE5adGF5M21maEZyN2pnSSs0?=
 =?utf-8?B?NGs5eTJYd3pwRDdPMlJ0cGgyS2xHcGIvczdPMWd4cTVUVEJZbU9sb085VHhs?=
 =?utf-8?B?VitpVWFmaktvL3pVSDBBbm84SU5UL1paY0JjS0tqa0dObVJaWiswajZVZmZQ?=
 =?utf-8?B?WWZZUDZCc0ExeUZpNCtwNDVHeHhqcktsRmlsdDhYOVJCQVFVaHAyREJNYVA2?=
 =?utf-8?B?WXpoQ3p1eFF2TFo5Z0tFOGl6U1VXSzFTYUR4VDIwejRLTk1WdWdhaEpZbXV6?=
 =?utf-8?B?cWNjUXh0VkU4Z2N4L0FIWCtkbU9oUmw3N3NxRi9VTzdrYW1lbGlUTlJHUnZi?=
 =?utf-8?B?eVErZ3B2NGVML2xYMlF1czc4cGhBUVRUcVRmUHRETXNIWnJFUUtmNUMyam9O?=
 =?utf-8?B?U0ZtNmZXeFFOUG10TmtURHFLZHZjR1JUOFJxbi92RWcvTUF5NkJhNTd3Unor?=
 =?utf-8?B?MjROQzlyQk8rRUJNUmNnZlBIMWpIUEtkL2xaeHV3RzhnV1hJVFd2MkxwMnow?=
 =?utf-8?B?RXoxQ0NMd2JSMFdZU1FiTE10M3hrUmE0enU1em1adnVNbVJHd2F5cWIwdlJJ?=
 =?utf-8?B?bWd2Sjl3UGpycWtPVVh0NGVlcjY3eHEvQmZqcm80dWZlU0NValRROWZnbjJa?=
 =?utf-8?B?emRqcFE4TVJ1THcyellQdHExY1NzS1p1TVFtQTY0VDBEV0hKYysxcEFGWjQw?=
 =?utf-8?B?N1Q4QmFTRU1KQnNsNUlJdVEwdXpYL2xnajVZZEJDdHRVZnJzanhZVVhYSjFy?=
 =?utf-8?B?SEcrRk9Vd1huUzJXUkpYVHpWQzEvUStSOUZQUGk2ZTUxenp2bFlGd2FqT3Q5?=
 =?utf-8?B?d2R5Sm50RE5jVjZkNGpRdzJpVUpYUEh2MGZONHJsSWdaM1BXVU5jcnhtUnA1?=
 =?utf-8?B?YnQyRVNXRS9aNWJveVhUcDBwRU1XYWJoYTlCZkt1Y3NuV2hjK1dES0R4cVc5?=
 =?utf-8?B?Z1M4c0JGZTE3YU1LRjlneThTNXd6SWxUYkc2dVVrVWJKSTI3djFnazZFM3ZX?=
 =?utf-8?B?U0RkNVYvR1FWVitRTWlrbW9sL2xhaGttbThRVDU3TkM5SzdrdG50dUYwN1JC?=
 =?utf-8?B?V1B6WkNKeEhPUU9RWG1sb1JwMVJqdHpGMXhvMm02RXh5blpqalozSUlic0FG?=
 =?utf-8?B?SGV2eWEyY0FDUWVvNHBzS29OUFBCcXJMUmdCUk5lWW5HbnNld3I4OFg3cytV?=
 =?utf-8?B?cjRack5hN0QxNzIyYnRaamxmZE9id2RTKzBlY3h3Z1ZzNm1aRWpURjRLaFFK?=
 =?utf-8?B?YzFQY0VXVTZBR2d0U3Y4OTJJVzUxRVJIQ2FFRklKZXBaWHVhS2FWNVQzZS9U?=
 =?utf-8?B?RkZSaXpwZW9uWERzZit4clB4NXBDZm9ubzN1Y2gya2N6bks3ZHZ3bStobTl2?=
 =?utf-8?B?MGJQU08vSjl0NUk2d1loUjB5aS9Zc0tMWU1iRVNxMlF4UTNDZk96UUtLVVgw?=
 =?utf-8?B?YlNrcXI2YXdKU3hRNFZZQTRweEtFU3p5b2Y0VnZXN1cralVNdW1qMVgzdzRO?=
 =?utf-8?B?cWk0a3RKbEVEa1orejJ3VjErVjU1M0FNRmVTZGxuTkFwYWRXQ0FhZm5wbTlp?=
 =?utf-8?B?czk0SmFvWitCbHl2dkhVb0Y4OEdyNHZPSFlVZElJTUh6bTNqRW90c2hTSWNk?=
 =?utf-8?B?WlVraHM2NG1sZU5Zc0lzdDJ0M25KQmNmd08yOXBVaUlRRDhJTnVQWFpXOVZL?=
 =?utf-8?B?N09vK2o4NXJDZW5QUjFMZlA3L2NrQnA3WnY2eldSdUVhc2J6bStHQWlJMUlD?=
 =?utf-8?B?MlBUci9LSHU3OWVucFBGUE9pYklpRVFSQjFBUUZyNWN6eUFCMmVuSTAyZ1hq?=
 =?utf-8?Q?xQJY6Yb52eopd?=
x-microsoft-antispam-prvs: <VI1PR04MB3056A136A5EA9E576CB0A7908B7E0@VI1PR04MB3056.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(33656002)(6436002)(966005)(45080400002)(4326008)(14454004)(81166006)(305945005)(81156014)(8936002)(25786009)(74316002)(7736002)(478600001)(229853002)(3846002)(86362001)(53936002)(2201001)(6116002)(105586002)(8676002)(9686003)(71200400001)(71190400001)(55016002)(6306002)(97736004)(316002)(54906003)(7696005)(76176011)(99286004)(110136005)(6246003)(446003)(66066001)(5660300002)(2906002)(102836004)(26005)(106356001)(486006)(44832011)(2501003)(256004)(14444005)(68736007)(6506007)(186003)(476003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3056;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kvw44eGaHpqL7M72tkVQbgdM8P8faqympQUo4JTSfluzEh2YYOTqYxw6uiVFHyX2JhzU6n8JrJdwO7oe2Lx8J9CBixeRwl63leZSnYfBIX54n5/+RltMjN9I22OjQ+kNS2PqrrFzfo1qJytU+He6Jl0lVKTsEGvbhSw4i50aldl0O38ZSXwfvewn+ckBC4mSsLH21MERVJBDyWUvuEG2NBmBfB3K+KtLGxnn30a6UCPle+TnwU/oSa1N7STvyxlhRdl8qSGAE1Zm3IihiWo4tKzvNKQeSnvtk/XVZZVikmn//tQq3u2ZG/eiH7SPEcbaFh8gHlhMD4n+risL9zH3iYOUozz0hq70Uf5cYNo0mH+o0wBQyj8acoMOd7ZhRSbT3WX8FlbZQ7J+V2cLhy6mFpqUP264d/5OtrFzeq2C4qk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eabb189-0bfb-4c87-876d-08d697acd0c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 03:29:41.1161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiANCj4gT24gTW9uLCAyMDE5LTAyLTE4IGF0IDAzOjA0ICswMDAwLCBQZXRlciBDaGVuIHdy
b3RlOg0KPiA+ID4gQWNjb3JkaW5nIHRvIHRoZSBjaGlwaWRlYSBkcml2ZXIgYmluZGluZ3MsIHRo
ZSBVU0IgUEhZIGlzIHNwZWNpZmllZCB2aWEgdGhlDQo+ICJwaHlzIg0KPiA+ID4gcGhhbmRsZSBu
b2RlLiBIb3dldmVyLCB0aGlzIG9ubHkgdGFrZXMgZWZmZWN0IGZvciBVU0IgUEhZcyB0aGF0IHVz
ZQ0KPiA+ID4gdGhlIGNvbW1vbiBQSFkgZnJhbWV3b3JrLiBGb3IgbGVnYWN5IFVTQiBQSFlzLCBh
IHNpbXBsZSBsb29rdXAgYmFzZWQNCj4gPiA+IG9uIHRoZSBVU0IgUEhZIHR5cGUgaXMgZG9uZSBp
bnN0ZWFkLg0KPiA+ID4NCj4gPiA+IFRoaXMgZG9lcyBub3QgcGxheSBvdXQgd2VsbCB3aGVuIG1v
cmUgdGhhbiBvbmUgVVNCIFBIWSBpcw0KPiA+ID4gcmVnaXN0ZXJlZCwgc2luY2UgdGhlIGZpcnN0
IHJlZ2lzdGVyZWQgUEhZIG1hdGNoaW5nIHRoZSB0eXBlIHdpbGwNCj4gPiA+IGFsd2F5cyBiZSBy
ZXR1cm5lZCByZWdhcmRsZXNzIG9mIHdoYXQgdGhlIGRyaXZlciB3YXMgYm91bmQgdG8uDQo+ID4g
Pg0KPiA+ID4gRml4IHRoaXMgYnkgbG9va2luZyB1cCB0aGUgUEhZIGJhc2VkIG9uIHRoZSAicGh5
cyIgcGhhbmRsZSBub2RlLg0KPiA+ID4gQWx0aG91Z2ggZ2VuZXJpYyBQSFlzIGFyZSByYXRoZXIg
bWF0Y2hlZCBieSB0aGVpciAicGh5cy1uYW1lIiBhbmQgbm90IHRoZQ0KPiAicGh5cyINCj4gPiA+
IHBoYW5kbGUgZGlyZWN0bHksIHRoZXJlIGlzIG5vIGhlbHBlciBmb3Igc2ltaWxhciBsb29rdXAg
b24gbGVnYWN5DQo+ID4gPiBQSFlzIGFuZCBpdCdzIHByb2JhYmx5IG5vdCB3b3J0aCB0aGUgZWZm
b3J0IHRvIGFkZCBpdC4NCj4gPiA+DQo+ID4gPiBXaGVuIG5vIGxlZ2FjeSBVU0IgUEhZIGlzIGZv
dW5kIGJ5IHBoYW5kbGUsIGZhbGxiYWNrIHRvIGdyYWJiaW5nIGFueQ0KPiA+ID4gcmVnaXN0ZXJl
ZA0KPiA+ID4gVVNCMiBQSFkuIFRoaXMgZW5zdXJlcyBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGlm
IHNvbWUgdXNlcnMgd2VyZQ0KPiA+ID4gYWN0dWFsbHkgcmVseWluZyBvbiB0aGlzIG1lY2hhbmlz
bS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQYXVsIEtvY2lhbGtvd3NraSA8cGF1bC5r
b2NpYWxrb3dza2lAYm9vdGxpbi5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IENoYW5nZXMgc2luY2Ug
djI6DQo+ID4gPiAqIEZpeGVkIHR5cG9zIGluIGNvbW1pdCBtZXNzYWdlLg0KPiA+ID4NCj4gPiA+
IENoYW5nZXMgc2luY2UgdjE6DQo+ID4gPiAqIE9ubHkgY29uc2lkZXIgbGVnYWN5IFVTQiBQSFkg
ZXJyb3IgZm9yIGZhbGxiYWNrIGFzIHN1Z2dlc3RlZDsNCj4gPiA+ICogQ2hlY2tlZCBhZ2FpbnN0
IEVQUk9CRV9ERUZFUiBiZWZvcmUgZW50ZXJpbmcgZmFsbGJhY2suDQo+ID4gPg0KPiA+ID4gIGRy
aXZlcnMvdXNiL2NoaXBpZGVhL2NvcmUuYyB8IDkgKysrKysrKystDQo+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9jaGlwaWRlYS9jb3JlLmMNCj4gPiA+IGIvZHJpdmVycy91c2Iv
Y2hpcGlkZWEvY29yZS5jIGluZGV4IDdiZmNiYjIzYzJhNC4uMDE2ZTQwMDRmZTlkDQo+ID4gPiAx
MDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2NoaXBpZGVhL2NvcmUuYw0KPiA+ID4gKysr
IGIvZHJpdmVycy91c2IvY2hpcGlkZWEvY29yZS5jDQo+ID4gPiBAQCAtOTU0LDggKzk1NCwxNSBA
QCBzdGF0aWMgaW50IGNpX2hkcmNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gPiA+ICAJfSBlbHNlIGlmIChjaS0+cGxhdGRhdGEtPnVzYl9waHkpIHsNCj4gPiA+ICAJCWNp
LT51c2JfcGh5ID0gY2ktPnBsYXRkYXRhLT51c2JfcGh5Ow0KPiA+ID4gIAl9IGVsc2Ugew0KPiA+
ID4gKwkJY2ktPnVzYl9waHkgPSBkZXZtX3VzYl9nZXRfcGh5X2J5X3BoYW5kbGUoZGV2LT5wYXJl
bnQsICJwaHlzIiwNCj4gPiA+ICsJCQkJCQkJICAwKTsNCj4gPiA+ICAJCWNpLT5waHkgPSBkZXZt
X3BoeV9nZXQoZGV2LT5wYXJlbnQsICJ1c2ItcGh5Iik7DQo+ID4gPiAtCQljaS0+dXNiX3BoeSA9
IGRldm1fdXNiX2dldF9waHkoZGV2LT5wYXJlbnQsDQo+ID4gPiBVU0JfUEhZX1RZUEVfVVNCMik7
DQo+ID4gPiArDQo+ID4gPiArCQkvKiBGYWxsYmFjayB0byBncmFiYmluZyBhbnkgcmVnaXN0ZXJl
ZCBVU0IyIFBIWSAqLw0KPiA+ID4gKwkJaWYgKElTX0VSUihjaS0+dXNiX3BoeSkgJiYNCj4gPiA+
ICsJCSAgICBQVFJfRVJSKGNpLT51c2JfcGh5KSAhPSAtRVBST0JFX0RFRkVSKQ0KPiA+ID4gKwkJ
CWNpLT51c2JfcGh5ID0gZGV2bV91c2JfZ2V0X3BoeShkZXYtPnBhcmVudCwNCj4gPiA+ICsJCQkJ
CQkgICAgICAgVVNCX1BIWV9UWVBFX1VTQjIpOw0KPiA+ID4NCj4gPg0KPiA+IEkgdGhpbmsgeW91
IG1heSBuZWVkIHRvIGRvIGFib3ZlIGlmIGNpLT5waHkgaXMgZXJyb3IsIGFuZCBub3QgdGhlIGVy
cm9yIGlzIC0NCj4gRVBST0JFX0RFRkVSLg0KPiANCj4gQXMgVGhvbWFzIHBvaW50ZWQgb3V0IGR1
cmluZyB0aGUgcmV2aWV3IG9mIHYxLCB0aGUgaW5pdGlhbCBmbG93IGlzIHRvIHRyeSBhbmQgZ2V0
IGJvdGgNCj4gY2ktPnVzYl9waHkgYW5kIGNpLT5waHkgYW5kIGxldCB0aGUgY29kZSB1c2UgY2kt
PnBoeSBpbiBwcmlvcml0eSBsYXRlci4NCj4gDQoNCklmIHRoZXJlIGlzIGEgZ2VuZXJpYyBQSFkg
bm9kZSB1bmRlciBVU0IgY29udHJvbGxlciwgYW5kIHRoZXJlIGlzIGEgVVNCIFBIWQ0KYXQgb3Ro
ZXIgc2lkZXMsIGJvdGggY2ktPnBoeSBhbmQgY2ktPnVzYl9waHkgYXJlIHZhbGlkLCBJIG9yaWdp
bmFsIHRob3VnaHQgaXQgaXMNCnRoZSBwcm9ibGVtIHlvdSBtZXQuDQoNClNpbmNlIHlvdSBhcmUg
dHJ5aW5nIHRvIGZpeCB0aGUgbGVnYWN5IFVTQiBQSFkgZ3JhYiBpc3N1ZSwgSSBob3BlIHlvdSBj
b3VsZCBjb25zaWRlcg0KdGhlIGdlbmVyaWMgUEhZIGFzIHdlbGwuDQoNClBldGVyDQogDQoNCj4g
VGhpcyBjaGFuZ2UgYXR0ZW1wdHMgdG8ga2VlcCB0aGlzIGZsb3cgaW50YWN0LiBUaGUgRVBST0JF
X0RFRkVSIGNoZWNrIGlzIGluDQo+IGNhc2UgdGhlIGluaXRpYWwgY2ktPnVzYl9waHkgaXMgdmFs
aWQgYnV0IGRlZmVycmVkOiB3ZSBkb24ndCB3YW50IHRvIG92ZXJ3cml0ZSBpdCBieQ0KPiBjYWxs
aW5nIGRldm1fdXNiX2dldF9waHkgd2hpY2ggbWlnaHQgcmV0dXJuIGFuIGFjdHVhbCBlcnJvciBh
bmQgcmVzdWx0IGluIGxvc2luZw0KPiB0aGUgRVBST0JFX0RFRkVSIGluZm9ybWF0aW9uLg0KPiAN
Cj4gRG9lcyB0aGF0IG1ha2Ugc2Vuc2UgdG8geW91Pw0KPiANCj4gQ2hlZXJzLA0KPiANCj4gUGF1
bA0KPiANCj4gPiBQZXRlcg0KPiA+DQo+ID4gPiAgCQkvKiBpZiBib3RoIGdlbmVyaWMgUEhZIGFu
ZCBVU0IgUEhZIGxheWVycyBhcmVuJ3QgZW5hYmxlZCAqLw0KPiA+ID4gIAkJaWYgKFBUUl9FUlIo
Y2ktPnBoeSkgPT0gLUVOT1NZUyAmJg0KPiA+ID4gLS0NCj4gPiA+IDIuMjAuMQ0KPiAtLQ0KPiBQ
YXVsIEtvY2lhbGtvd3NraSwgQm9vdGxpbg0KPiBFbWJlZGRlZCBMaW51eCBhbmQga2VybmVsIGVu
Z2luZWVyaW5nDQo+IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZib290bGluLmNvbQ0KPiAmYW1wO2RhdGE9MDIlN0MwMSU3
Q3BldGVyLmNoZW4lNDBueHAuY29tJTdDYWRjYTY1MzU3ZGFhNGZlNjc4ZGMwOGQNCj4gNjk1N2I5
YzQ5JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjg2MDc1
NTQNCj4gNjY4MDU4MDUmYW1wO3NkYXRhPWMlMkZkTHFVaEZ4ZTF5ejdscnFVb1haQ3ZJTmlxMXJk
S0ptTUF1YUg2RnIxayUzDQo+IEQmYW1wO3Jlc2VydmVkPTANCg0K
