Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48FBC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630C620818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="urM4k8HM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfBLKlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:41:37 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:2817
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728995AbfBLKlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp6HbED6X9Nd3mpZvp9gkLQhwrFCXqGZFuYfRbv08kk=;
 b=urM4k8HMSIZNY8eITnqIRvjiUDiPeETV268bYCCM/kfgYAGMv0uPo80OTvdBZlr3hXG2pbK8a2y/YxUscUc6ZwGNV7D70kBdncVKz+mw6FSTFQS6fOn8m6dPBAlSIPSF8VLPSWTI1xq7ZHMl5m6zc4z9mDfQUIxWInmGAfbZfWw=
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com (20.177.55.216) by
 VI1PR04MB2175.eurprd04.prod.outlook.com (10.166.43.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 12 Feb 2019 10:41:28 +0000
Received: from VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::b0fe:dee7:b2d3:9355]) by VI1PR04MB4558.eurprd04.prod.outlook.com
 ([fe80::b0fe:dee7:b2d3:9355%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 10:41:28 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/9] usb: roles: Find the muxes by also matching
 against the device node
Thread-Topic: [PATCH v2 6/9] usb: roles: Find the muxes by also matching
 against the device node
Thread-Index: AQHUuLVSCFz0E1ZQKUWUh+dd3nT5iqXablHwgAAOWoCAAThjEIAAOY6AgAAZGzA=
Date:   Tue, 12 Feb 2019 10:41:28 +0000
Message-ID: <VI1PR04MB45581A938E8BC3FA50960A7589650@VI1PR04MB4558.eurprd04.prod.outlook.com>
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
 <20190130160259.46919-7-heikki.krogerus@linux.intel.com>
 <VI1PR04MB4558283CA9D752D5452FA09989640@VI1PR04MB4558.eurprd04.prod.outlook.com>
 <20190211104629.GE16987@kuha.fi.intel.com>
 <VI1PR04MB4558F4F7BC10D82FC1BE71B489650@VI1PR04MB4558.eurprd04.prod.outlook.com>
 <20190212085033.GB32070@kuha.fi.intel.com>
In-Reply-To: <20190212085033.GB32070@kuha.fi.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=jun.li@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB2175;6:ytvm13Hh3Oo81WkO/wlUG5Ns3+jczxdpJTuMX0UzbIu8AXPL0XicEj5NOFZ3oxqslfQedHnbElfxYVUCfAYWhD/A/H744yieLLDDjjxzBNZc4yO+LLTE3lvrx5u3iikSRblmdz9tdlXRxMvVhoOejmBcVOAYD2fNmFapyIGXugL9lO/HzB3wIhQOIM0Z9q+8VlkDBLjHREQNzlNz4sPIsDRCzht/cAB9HyIYdm2MVOgWUIfbl8SUGage8aAnsPyTrccBCx0XZZtikJilUpwsMH6u+2gxH/0Zo6P7a0RViJo4eWHDGqxLZQk+Qtr/LPUgWqpfg5vQQl2g/OFxi71bN1HbJlCFgd5RWKaSc1KZRM0Bz0fPKGpgfJwFAa2cXZCb8dJ1gbjKwwlDIGK9cNmUvhHKN2oHpLLAjfOeMp8diI/xrWourusc5lhIaJGun/JOLo4C6H782CILQuXxYaLzNg==;5:XJpq0RjZFDVk7OuxNn6ySL4W6ZMmpgSNviIr9gDsG7lup0cQzaHAWr9XYUwn2n8zFQJpHaJJhDwQgEcJwiKjvEVrIq9WRnmwZyh3ftEzfh7eRlqUAlVKGtdkFGX4kWGIO4aBCzFKQhsvRfguZpZwTgcF+Y4ADoAC4HpOvo4CVTVDFO5zS8j8ununMoU55gXzSOGNe/YxHut0eSBfgmXLLQ==;7:Zg4DERcZpCaHRGeXvqK6rRtKI8HbKPwU0jVjbTM6cRgUs6kTlxNTFJ8W2YLkodVAsWMMArFvuUt3k0lWAKDB0MztxImlTNoMviIAVzkGWtm+jobEGiqYz9JDxY9sCdyThUyXRWxVrDfVxjCxT/ipbw==
x-ms-office365-filtering-correlation-id: 3829b1ad-4cff-4dfc-5ddf-08d690d6a4f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB2175;
x-ms-traffictypediagnostic: VI1PR04MB2175:
x-microsoft-antispam-prvs: <VI1PR04MB2175DC97969457C185C0203189650@VI1PR04MB2175.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(13464003)(189003)(199004)(26005)(316002)(97736004)(66066001)(6916009)(186003)(305945005)(74316002)(6246003)(7736002)(93886005)(68736007)(256004)(8936002)(2906002)(8676002)(81156014)(81166006)(102836004)(71200400001)(71190400001)(6436002)(53546011)(6506007)(4326008)(478600001)(25786009)(486006)(14454004)(11346002)(53936002)(86362001)(55016002)(6116002)(9686003)(476003)(106356001)(44832011)(105586002)(99286004)(54906003)(76176011)(7696005)(446003)(229853002)(3846002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2175;H:VI1PR04MB4558.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6JltYRrVdoZcOMHXvLJHcbGDGO+eHXHN9zlFWo6DU4lYRvILiAbd7W9/Ao83wFOfRdJinhv6faEYavAfYTfboFGN8lFBZ0/Ay57ROR7YwQBhRCW6Xlh04fKOKv7qDdEi/CG+k0Bu2G3ML/C6JHt/0g/G+O/XgLeTgTLDQ2222OOA82J1wS6+oticvSYksDL1BCZkufspE2MKH/UsduJKjTTgH4J78tj9HiypVBGeb5ou6Is0JXzupxQkSsEyAHL9x2rRt+xJ1O6TWO4u03Zz9bNTylBPZQSZYi1Ek4HEL1mvP/YF2BqzxbfcBYkvCaC4YOPnZ0EMhQ3CKBeLa6hNFm84TDT5JV3sWFwM3XEyaXCHZBeUCSjxufORSvoAph9yrFNAhKbzELutH2RlSkPvCtC+6jn44F8vLNieXRFBXJY=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3829b1ad-4cff-4dfc-5ddf-08d690d6a4f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 10:41:28.3104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpa2tpIEtyb2dlcnVz
IDxoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiAyMDE5xOoy1MIxMsjV
IDE2OjUxDQo+IFRvOiBKdW4gTGkgPGp1bi5saUBueHAuY29tPg0KPiBDYzogR3JlZyBLcm9haC1I
YXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IEFuZHkgU2hldmNoZW5rbw0KPiA8
YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT47IENoZW4gWXUgPGNoZW55dTU2QGh1YXdlaS5jb20+
OyBIYW5zIGRlDQo+IEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPjsgbGludXgtdXNiQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyIDYvOV0gdXNiOiByb2xlczogRmluZCB0aGUgbXV4ZXMgYnkgYWxzbyBtYXRj
aGluZyBhZ2FpbnN0IHRoZQ0KPiBkZXZpY2Ugbm9kZQ0KPiANCj4gSGksDQo+IA0KPiBPbiBUdWUs
IEZlYiAxMiwgMjAxOSBhdCAwNjowMzo0MkFNICswMDAwLCBKdW4gTGkgd3JvdGU6DQo+ID4gPiA+
IHJldHVybiBkZXZfZndub2RlKGRldi0+cGFyZW50KSA9PSBmd25vZGU7DQo+ID4gPg0KPiA+ID4g
VGhhdCdzIGFjdHVhbGx5IG5vdCB0aGUgY2FzZS4gc3RydWN0IHVzYl9yb2xlX3N3aXRjaF9kZXNj
IGhhcyBhDQo+ID4gPiBtZW1iZXIgZm9yIGZ3bm9kZSwgYW5kIHRoYXQncyB3aGF0IHdlIHVzZSB3
aXRoIHRoZSBhY3R1YWwgbXV4DQo+ID4gPiBkZXZpY2UuIENoZWNrDQo+ID4gPiB1c2Jfcm9sZV9z
d2l0Y2hfcmVnaXN0ZXIoKToNCj4gPiA+DQo+ID4gPiAgICAgICAgIC4uLg0KPiA+ID4gICAgICAg
ICBzdy0+ZGV2LmZ3bm9kZSA9IGRlc2MtPmZ3bm9kZTsNCj4gPiA+ICAgICAgICAgLi4uDQo+ID4g
Pg0KPiA+ID4gU29ycnkgZm9yIG5vdCByZWFsaXppbmcgaXQgYmVmb3JlLg0KPiA+DQo+ID4gU28g
ZGVzYy0+Zndub2RlIHNob3VsZCBiZSBpbml0aWFsaXplZCBiZWZvcmUgZG8gdXNiX3JvbGVfc3dp
dGNoX3JlZ2lzdGVyKCk/DQo+ID4gQnV0IHNlZW1zIHVzYl9yb2xlX3N3aXRjaF9kZXNjIGlzIGEg
cmVhZC1vbmx5IG9iamVjdCBzbyBjYW4ndCBiZSBzZXQgYXQgcnVudGltZS4NCj4gDQo+IEl0IGNh
bi4gRXZlbiB0aG91Z2ggdXNiX3JvbGVfc3dpdGNoX3JlZ2lzdGVyKCkgdGFrZXMgcmVhZC1vbmx5
IHBhcmFtZXRlciwgbm90aGluZydzDQo+IHByZXZlbnRpbmcgeW91IGZyb20gcGFzc2luZyBkYXRh
IGV2ZW4gZnJvbSB0aGUgc3RhY2sgKHRoZSBjb250ZW50IG9mIHRoZSBkZXNjcmlwdG9yDQo+IGlz
IGNvcGllZCBpbiBhbnkgY2FzZSkuDQo+IA0KPiBFeHBlY3RpbmcgdGhlIGRlc2NyaXB0b3IgdG8g
YmUgcmVhZC1vbmx5IGp1c3QgbWVhbnMgaXQgY2FuIGJlIHJlYWQtb25seSwgYnV0IGl0IGRvZXMN
Cj4gbm90IGhhdmUgdG8gYmUuDQoNClVuZGVyc3Rvb2QsIHRoYW5rcy4NCg0KPiBAQCAtMzIsNiAr
MzIsNyBAQCB0eXBlZGVmIGVudW0gdXNiX3JvbGUgKCp1c2Jfcm9sZV9zd2l0Y2hfZ2V0X3QpKHN0
cnVjdA0KPiBkZXZpY2UgKmRldik7DQo+ICAgKiB1c2Jfcm9sZV9zd2l0Y2hfcmVnaXN0ZXIoKSBi
ZWZvcmUgcmVnaXN0ZXJpbmcgdGhlIHN3aXRjaC4NCj4gICAqLw0KPiAgc3RydWN0IHVzYl9yb2xl
X3N3aXRjaF9kZXNjIHsNCj4gKwlzdHJ1Y3QgZndub2RlX2hhbmRsZSAqZndub2RlOw0KWW91IG1h
eSBhZGQgc29tZSBkZXNjcmlwdGlvbiBmb3IgdGhpcyBuZXcgbWVtYmVyDQovKioNCiAqIHN0cnVj
dCB1c2Jfcm9sZV9zd2l0Y2hfZGVzYyAtIFVTQiBSb2xlIFN3aXRjaCBEZXNjcmlwdG9yDQogKiBA
IGZ3bm9kZSANCg0KPiANCj4gPiB1c2JfY29udHJvbGxlcl9ub2RlIHsNCj4gPiAJLi4uDQo+ID4g
CXVzYi1yb2xlLXN3aXRjaDsNCj4gPg0KPiA+IAlwb3J0IHsNCj4gPiAJCXN3X3Byb3ZpZGVyX25v
ZGU6IGVuZHBvaW50IHsNCj4gPiAJCQlyZW1vdGUtZW5kcG9pbnQgPSA8JnN3X2NvbnN1bWVyX25v
ZGU+Ow0KPiA+IAkJfTsNCj4gPiAJfTsNCj4gPiB9Ow0KPiA+DQo+ID4gdHlwZWNfbm9kZSB7DQo+
ID4gCS4uLg0KPiA+IAlwb3J0IHsNCj4gPiAJCXN3X2NvbnN1bWVyX25vZGU6IGVuZHBvaW50IHsN
Cj4gPiAJCQlyZW1vdGUtZW5kcG9pbnQgPSA8JnN3X3Byb3ZpZGVyX25vZGU+Ow0KPiA+IAkJfTsN
Cj4gPiAJfTsNCj4gPiB9Ow0KPiANCj4gVGhhdCBsb29rcyByb3VnaGx5IGNvcnJlY3QgdG8gbWUu
DQo+IA0KPiANCj4gdGhhbmtzLA0KPiANCj4gLS0NCj4gaGVpa2tpDQo=
