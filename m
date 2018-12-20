Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2724C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832C22176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="sRZm58xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbeLTLjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:39:20 -0500
Received: from mail-eopbgr50069.outbound.protection.outlook.com ([40.107.5.69]:14336
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729659AbeLTLjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzFTGx9iFDcCXpJcO0VLuXvMhWudduU/ZX1q5UuJbcM=;
 b=sRZm58xzJeXm6K2PTMnc9CnZ0Nwqd6ys1VQzorXas6QlFSjx2F6kthIawZiWGias5IRmYHI59NaaTzbhRCercHwzEDG8ITeWJwaEHn6oM5KPQqyxjBvlQvWkuAopRJlo12rSbiBQ3CkswdHtwTfeweS5gkP5IwOxzFU93cWLCAM=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5018.eurprd04.prod.outlook.com (20.176.234.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 11:39:12 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%3]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 11:39:12 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSCA0LzRdIEFSTTogbXhzOiBjZmExMDAzNjogRml4dXAgT0xF?=
 =?utf-8?B?RMKgZGlzcGxheSByZXNldCBwb2xhcml0eQ==?=
Thread-Topic: =?utf-8?B?W1BBVENIIDQvNF0gQVJNOiBteHM6IGNmYTEwMDM2OiBGaXh1cCBPTEVEwqBk?=
 =?utf-8?Q?isplay_reset_polarity?=
Thread-Index: AQHUi+KKthGpJEQVZU6UA2M3No4/WKWGaR2AgAEwXAA=
Date:   Thu, 20 Dec 2018 11:39:12 +0000
Message-ID: <7819e740-6f20-23b5-0836-2ca08d3fb386@ysoft.com>
References: <1543935806-94880-1-git-send-email-michal.vokac@ysoft.com>
 <1543935806-94880-5-git-send-email-michal.vokac@ysoft.com>
 <20181219172949.GA7680@bogus>
In-Reply-To: <20181219172949.GA7680@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0202CA0010.eurprd02.prod.outlook.com
 (2603:10a6:203:69::20) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5018;6:P/AuGyecCVH7qNDdEGjzgvjxMYecJ6/jPDH7Y+hejmrPtIXnBtTvceDdzhQuD0tPON5OM6X7v9VLk6o02fMRQtPxH/VRsq2NpJebC/c6qHk0UeO9G6+RWXUhRrduPGwfiEUGkG0w+mwbxfwHCUVQ34MKwjqnfp0qPY067ik4LMFbVeUdKq9dS0SKx39M7yy9LGRHOnKFNQrNRBftNLoVAnZ9UuqRYpXLPeaEz64wP4QmkHnl6T6gNvzDyaYn06zp3RopkEoha8ZqlYZGN/4jWguo2F7RgHo212R5QUcstOPdd3bintrvRrBwGfV9CmMgPKsC2m66o2eqa2Iwp2Q5z0TL4zM8gKiASIUjY2e6Ve8G8P1amXVmHei+CUYYw6PUJuukUSHGvDh0fKUm4iPMHHOTjN6M7qVsmTeTp+8YnPN6BviV6RmCQa4ITzGVuF6cEzQJ38rSUtCZnfAMUBtZUQ==;5:l3oIH6Ys0dPDGS/h1m+gLGfVACeSF1qMjHZMM+I6Q5pgc/qscoxGEmLI1zqDmhRWafA3kAKNSS2tB6oGtaGF3OMYoCHc9NttCCWsCL1MwK4m+g/Kxckq/FMV+XMg/mMlvU43m+5KDZ1eWrW7tDWbAe7tzKLA2JWU+p7WFxKp3lY=;7:hL+Wsm2gyBXvxy7Ekc425kYQQCgT7JpzjbrOK74TOcKGWXuuZ8YTvoiMaCRAx8OJbVGjTO4MW08bOlDa/eerbDRVlVWKVFN0AmzU7K0Il6lTy744mlGiJgk+yfKIghPg1JmKFkaZzty8yJfY4PFaEA==
x-ms-office365-filtering-correlation-id: 5ae17c23-f0cc-46d3-2563-08d6666fc373
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5018;
x-ms-traffictypediagnostic: DB7PR04MB5018:
x-microsoft-antispam-prvs: <DB7PR04MB5018F856947C2CAE7AE05F479EBF0@DB7PR04MB5018.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5018;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5018;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39850400004)(136003)(346002)(189003)(199004)(71190400001)(71200400001)(31686004)(53936002)(2906002)(345774005)(25786009)(6512007)(478600001)(14444005)(6436002)(68736007)(14454004)(229853002)(256004)(76176011)(6486002)(52116002)(31696002)(106356001)(86362001)(72206003)(105586002)(6916009)(26005)(186003)(486006)(446003)(386003)(6506007)(53546011)(476003)(11346002)(2616005)(66066001)(305945005)(54906003)(7736002)(316002)(85182001)(81156014)(36756003)(3846002)(6116002)(81166006)(5660300001)(99286004)(102836004)(4326008)(6246003)(8936002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5018;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CifTqiXa85/Z8d1UpziuuRUWNwfS8wV+Grhj3dzKHI3wh+8p0Cgah+Ya6GxX9KjP9Ug8FibGAsl96YaZO/IFyIxKez0363ZuHi9GKeY61loRDy0AnNoL9DpLZ6FozygUrpLflBRBwT4yew5SD+ZnHDdL7pkLJzRlMdu2h+OznL4DIe5ZHrL+miPvqzmi6btjwlmWReqPgVHAptTZKGL34IZtLqQMhoNWrod+hYRqQjlwUbdbWtslg6K7jZDV5uxCcIS1Xg0xnHmAMtPlY5j72g9j16eNzB2oVR2O7c9GC6u61Gg+ui0U3u4JaFKPIf8b
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <20B313C6FB340C4AB38C5E15DC302D43@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae17c23-f0cc-46d3-2563-08d6666fc373
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 11:39:12.8942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMTIuMjAxOCAxODoyOSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFR1ZSwgRGVjIDA0
LCAyMDE4IGF0IDAzOjAzOjQwUE0gKzAwMDAsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0KPj4gVGhl
cmUgd2FzIGEgYnVnIGluIHJlc2V0IHNpZ25hbCBnZW5lcmF0aW9uIGluIHNzZDEzMDdmYiBPTEVE
IGRyaXZlci4NCj4+IFRoZSBkaXNwbGF5IG5lZWRzIGFuIGFjdGl2ZS1sb3cgcmVzZXQgc2lnbmFs
IGJ1dCB0aGUgZHJpdmVyIHByb2R1Y2VkDQo+PiB0aGUgY29ycmVjdCBzZXF1ZW5jZSBvbmx5IGlm
IHRoZSBHUElPIHVzZWQgZm9yIHJlc2V0IHdhcyBzcGVjaWZpZWQgYXMNCj4+IEdQSU9fQUNUSVZF
X0hJR0guDQo+Pg0KPj4gTm93IGFzIHRoZSBPTEVEIGRyaXZlciBpcyBmaXhlZCBpdCBpcyBhbHNv
IG5lY2Vzc2FycnkgdG8gaW1wbGVtZW50DQo+PiBhIGZpeHVwIGZvciBhbGwgY3VycmVudCB1c2Vy
cyBvZiB0aGUgb2xkIERUIEFCSS4gVGhlcmUgaXMgb25seSBvbmUNCj4+IGluLXRyZWUgdXNlciBh
bmQgdGhhdCBpcyB0aGUgQ3J5c3RhbGZvbnR6IENGQS0xMDAzNiBib2FyZC4gSW4gY2FzZQ0KPj4g
dGhpcyBib2FyZCBpcyBib290aW5nIGFuZCBHUElPX0FDVElWRV9ISUdIIGlzIHVzZWQgZm9yIHJl
c2V0IHdlDQo+PiBvdmVycmlkZSBpdCB0byBHUElPX0FDVElWRV9MT1cuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogTWljaGFsIFZva8OhxI0gPG1pY2hhbC52b2thY0B5c29mdC5jb20+DQo+PiAtLS0N
Cj4+ICAgYXJjaC9hcm0vbWFjaC1teHMvbWFjaC1teHMuYyB8IDQ1ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNl
cnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbXhzL21hY2gtbXhz
LmMgYi9hcmNoL2FybS9tYWNoLW14cy9tYWNoLW14cy5jDQo+PiBpbmRleCAxYzYwNjJkLi4yM2My
NjBjIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1teHMvbWFjaC1teHMuYw0KPj4gKysr
IGIvYXJjaC9hcm0vbWFjaC1teHMvbWFjaC1teHMuYw0KPj4gQEAgLTIxLDYgKzIxLDcgQEANCj4+
ICAgI2luY2x1ZGUgPGxpbnV4L3JlYm9vdC5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvbWljcmVs
X3BoeS5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPj4gKyNpbmNsdWRl
IDxsaW51eC9vZl9ncGlvLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0K
Pj4gICAjaW5jbHVkZSA8bGludXgvcGh5Lmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9waW5jdHJs
L2NvbnN1bWVyLmg+DQo+PiBAQCAtMjY4LDkgKzI2OSw1MyBAQCBzdGF0aWMgdm9pZCBfX2luaXQg
YXB4NGRldmtpdF9pbml0KHZvaWQpDQo+PiAgIAkJCQkJICAgYXB4NGRldmtpdF9waHlfZml4dXAp
Ow0KPj4gICB9DQo+PiAgIA0KPj4gKyNkZWZpbmUgT0xFRF9SRVNFVF9HUElPX0xFTgkzDQo+PiAr
I2RlZmluZSBPTEVEX1JFU0VUX0dQSU9fU0laRQkoT0xFRF9SRVNFVF9HUElPX0xFTiAqIHNpemVv
Zih1MzIpKQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIF9faW5pdCBjcnlzdGFsZm9udHpfb2xlZF9y
ZXNldF9maXh1cCh2b2lkKQ0KPj4gK3sNCj4+ICsJc3RydWN0IHByb3BlcnR5ICpuZXdncGlvOw0K
Pj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPj4gKwl1MzIgKmdwaW9zcGVjOw0KPj4gKwlp
bnQgaSwgcmV0Ow0KPj4gKw0KPj4gKwlucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEws
IE5VTEwsICJzb2xvbW9uLHNzZDEzMDZmYi1pMmMiKTsNCj4+ICsJaWYgKCFucCkNCj4+ICsJCXJl
dHVybjsNCj4+ICsNCj4+ICsJbmV3Z3BpbyA9IGt6YWxsb2Moc2l6ZW9mKCpuZXdncGlvKSArIE9M
RURfUkVTRVRfR1BJT19TSVpFLCBHRlBfS0VSTkVMKTsNCj4+ICsJaWYgKCFuZXdncGlvKQ0KPj4g
KwkJcmV0dXJuOw0KPj4gKw0KPj4gKwluZXdncGlvLT52YWx1ZSA9IG5ld2dwaW8gKyAxOw0KPj4g
KwluZXdncGlvLT5sZW5ndGggPSBPTEVEX1JFU0VUX0dQSU9fU0laRTsNCj4+ICsJbmV3Z3Bpby0+
bmFtZSA9IGtzdHJkdXAoInJlc2V0LWdwaW9zIiwgR0ZQX0tFUk5FTCk7DQo+PiArCWlmICghbmV3
Z3Bpby0+bmFtZSkgew0KPj4gKwkJa2ZyZWUobmV3Z3Bpbyk7DQo+PiArCQlyZXR1cm47DQo+PiAr
CX0NCj4+ICsNCj4+ICsJZ3Bpb3NwZWMgPSBuZXdncGlvLT52YWx1ZTsNCj4+ICsJZm9yIChpID0g
MDsgaSA8IE9MRURfUkVTRVRfR1BJT19MRU47IGkrKykgew0KPj4gKwkJcmV0ID0gb2ZfcHJvcGVy
dHlfcmVhZF91MzJfaW5kZXgobnAsICJyZXNldC1ncGlvcyIsIGksDQo+PiArCQkJCQkJICZncGlv
c3BlY1tpXSk7DQo+IA0KPiBEb24ndCB3ZSBoYXZlIGEgaGVscGVyIHRvIHJlYWQgdGhlIHdob2xl
IGFycmF5Pw0KDQpIaSBSb2IsDQp5ZXAsIEkgd2lsbCBmaXggdGhpcy4NClRoYW5rIHlvdSBmb3Ig
eW91ciByZXZpZXcgYW5kIGZvciBwb2ludGluZyBtZSB0byB0aGUgcmlnaHQgc29sdXRpb24uDQoN
Ck1pY2hhbA0KDQo+IA0KPiBPdGhlcndpc2UsIGZvciB0aGUgc2VyaWVzOg0KPiANCj4gUmV2aWV3
ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IA0KPj4gKwkJaWYgKHJldCkg
ew0KPj4gKwkJCWtmcmVlKG5ld2dwaW8pOw0KPj4gKwkJCXJldHVybjsNCj4+ICsJCX0NCj4+ICsJ
fQ0KPj4gKw0KPj4gKwlpZiAoIShncGlvc3BlY1syXSAmIE9GX0dQSU9fQUNUSVZFX0xPVykpIHsN
Cj4+ICsJCWdwaW9zcGVjWzJdIHw9IE9GX0dQSU9fQUNUSVZFX0xPVzsNCj4+ICsJCWNwdV90b19i
ZTMyX2FycmF5KGdwaW9zcGVjLCBncGlvc3BlYywgT0xFRF9SRVNFVF9HUElPX0xFTik7DQo+PiAr
CQlvZl91cGRhdGVfcHJvcGVydHkobnAsIG5ld2dwaW8pOw0KPj4gKwl9DQo+PiArfQ0KPj4gKw0K
Pj4gICBzdGF0aWMgdm9pZCBfX2luaXQgY3J5c3RhbGZvbnR6X2luaXQodm9pZCkNCj4+ICAgew0K
Pj4gICAJdXBkYXRlX2ZlY19tYWNfcHJvcChPVUlfQ1JZU1RBTEZPTlRaKTsNCj4+ICsJY3J5c3Rh
bGZvbnR6X29sZWRfcmVzZXRfZml4dXAoKTsNCj4+ICAgfQ0KPj4gICANCj4+ICAgc3RhdGljIHZv
aWQgX19pbml0IGR1Y2tiaWxsX2luaXQodm9pZCkNCj4+IC0tIA0KPj4gMi4xLjQNCj4+DQoNCg==
