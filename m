Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC476C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D82320866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ruup+im2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D82320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJPM0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:26:06 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:46880
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbeJPM0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcKQGUySbEKLZpORvsXrVJDciromDEHPVRIueuD+V6o=;
 b=Ruup+im2UEFtEnC3XQnPzpYQOyl05xPurroryZc+CfldE7fM2t1ce2LFS1JU0DCXTbUNakpZ2zXf82n4KhwS/qsmtQxTS6SX8pzHLEeMmigNA+8rkGG6+2s02/Cr0XZNr2AA1EK7LtbFVvIPdQkNGBHfeE+DOI9eK2dgTt0NWP4=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3847.eurprd04.prod.outlook.com (52.133.29.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.25; Tue, 16 Oct 2018 04:37:31 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::205a:1f3c:c5f9:3abe]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::205a:1f3c:c5f9:3abe%3]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 04:37:31 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
Thread-Topic: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
Thread-Index: AQHULtJmBbQCL7E8lECcVaukjbrAoqS1i6SAgAAAVtCAB1yugIAcTbiAgABtsgCAAKaTAIAEBEiQgDcH54CAAA4SYIAHBm0AgAQKbLCAAHmzgIAAw/vw
Date:   Tue, 16 Oct 2018 04:37:31 +0000
Message-ID: <AM6PR0402MB39112C0451B6E241AEBAC0D7F5FE0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB44813C7A3E0AF4F3BCFFCF0088390@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
 <a6489bda-703f-207c-0b24-60f4044fe89f@linaro.org>
 <153573827629.93865.6200966443862432044@swboyd.mtv.corp.google.com>
 <AM6PR0402MB391120110A289BA5FB6B9F0DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <153898445180.119890.15025812558797341532@swboyd.mtv.corp.google.com>
 <DB3PR0402MB391664354775DF42E90E67C9F5E60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <153937368201.5275.2313781259297807972@swboyd.mtv.corp.google.com>
 <DB3PR0402MB39169A3BA844F7833B62FF55F5FD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <153962195779.5275.17500455384946496344@swboyd.mtv.corp.google.com>
In-Reply-To: <153962195779.5275.17500455384946496344@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3847;6:YPHTDHhq+RR+n3FgWP0hE07zV/9UjE6xY3ts+G6FAWCM4/H8HMZsG1DyoaQW8sPGN74gDnY8s/rcL5DMaKj6dfLtVknpEr4xvcpEyi9rdqT8RL0enJWdlF5xJgldkF630slLIvrr60BLwEbspKV4nSLzQzJBIbSXg8aNgPeMpgQoIR32Nepb1f6s2N7BbwRtx1XQESY25ioRBdiTxkdm+qcrucU+EQ/+avpgiyKVF6egvhRNtMnCexcq4LAevuM3I/vlwlKPR8VTQ8Td7L7mZBvSXco1o3ZChGPCk2Z9yqE4jZ2Gu/96iYTyUoKUdJASfWUsZ84721/fhxgGpgvD2/pap7mKR3oY/GlZAW/PsqEy3GPO/Wl8cf0z05g5/yAMeegasKzfgdOk3Ex7vAYOSEwQJ4jxI3227KzxI7mxHlZh6tdseI9kLkK3Qzrn/1iGeHcqG7liet4FYWd1qOIM9A==;5:qFe15deuWusT0gybpZSyTzXNbEC7KaNksec1JH1PRnT5Fb/h8PSZBziPC8K5aCIT22yINkr5L8yDpC8CXB7cj8ZyERic9LMFNpZ7QlpGXNsbWyi2OwruBliNV58UJDX04ZrMxQn5iH/vTxfX2+ypdEvSpY0mCAnnsHA6gqvBPlY=;7:sJfxiZEsdQSbSlDM2QXHH2lHfAvQ+WdMuUY0Zy8apfdlCQrtlB1in8DrfoKcRPq36fFXBByQ8mJ1qjXKogoSN8rjibGSz68TJC14kiHN/wKuxVtakOYgADBHo6J0c5o6jzHR8Ah56lxZpIJYyr7BfBTVlWY7RYpTzWllDiNqfgbdbiadw3J/KWH0zjIzctzQJ6OXEwMNFXwuqTE/zDKrPj9bZbDLeq5lnxz3C2KxMB/FjKP65QOcHxmwRByR6mLp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c3be34f9-f3bc-48d3-c292-08d633211610
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3847;
x-ms-traffictypediagnostic: AM6PR0402MB3847:
x-microsoft-antispam-prvs: <AM6PR0402MB3847D158264F41303F4C0F94F5FE0@AM6PR0402MB3847.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(788757137089)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR0402MB3847;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3847;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(39860400002)(396003)(346002)(366004)(376002)(13464003)(52314003)(199004)(189003)(76176011)(256004)(7416002)(66066001)(4001150100001)(110136005)(6436002)(486006)(2900100001)(476003)(2501003)(11346002)(446003)(9686003)(8676002)(7736002)(53936002)(55016002)(6246003)(93886005)(71190400001)(44832011)(71200400001)(81166006)(186003)(8936002)(5660300001)(81156014)(26005)(316002)(102836004)(99286004)(305945005)(478600001)(2906002)(74316002)(4326008)(25786009)(6506007)(33656002)(5250100002)(7696005)(106356001)(86362001)(53546011)(68736007)(14454004)(229853002)(2201001)(105586002)(3846002)(97736004)(6116002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3847;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZoEGYMKdQy+pQh2rYdvmRQlqRrCyy95QXU1wyHvMCCWKRPIK+HezKVFZLxRjn49Y5BPJ7inLjBYA/t16kaCEMjGWRIrm9eYSZ0GJR+ErGUGmVyzguNtMbg02glnaMoBFdkED07t2IE+c0dqtqI7ewj15HGHPKvkhpSh7nFDcOn6CWAprSuS3aI0QzcBKkiqWR2geoscKj5VRBZrOsdPuyWMuzFYiIoj8JXie1+isbOkBEAWYH2x5BCeDOQmc6f4in5NSwyLgfpPTTpLGu+h978Hf279AhratwzIQPjo3MNil1jR4tRJOVmveeN1qdmHoOqcxAMQKhSyX3AVMfxV1OQppVE9VkZKSouqXqakgkBQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3be34f9-f3bc-48d3-c292-08d633211610
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 04:37:31.5807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KQW5zb24gSHVhbmcNCkJlc3QgUmVnYXJkcyENCg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9y
Zz4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxNiwgMjAxOCAxMjo0NiBBTQ0KPiBUbzoga2Vy
bmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBz
aGF3bmd1b0BrZXJuZWwub3JnOw0KPiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47
IEZhYmlvIEVzdGV2YW0NCj4gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47IEplcm9tZSBGb3Jpc3Np
ZXIgPGplcm9tZS5mb3Jpc3NpZXJAbGluYXJvLm9yZz47DQo+IFBlbmcgRmFuIDxwZW5nLmZhbkBu
eHAuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gQ2M6IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMi8yXSBjbGs6IGlt
eDogaW14N2Q6IHJlbW92ZSBjbGtzX2luaXRfb24gYXJyYXkNCj4gDQo+IFF1b3RpbmcgQW5zb24g
SHVhbmcgKDIwMTgtMTAtMTUgMDI6MzM6MzUpDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gV2h5IGNhbid0IHdlIGFkZCBjbGtzIHRvIHRoZSBvcC10ZWUgbm9kZSBpbiBEVCdzIC9m
aXJtd2FyZSBjb250YWluZXI/DQo+ID4gPiA+ID4gVGhlbiBhbnkgY2xrcyBpbiB0aGVyZSBjYW4g
YmUgdHVybmVkIG9uIGZvcmV2ZXIgYW5kIGxlZnQgZW5hYmxlZA0KPiA+ID4gPiA+IGJ5IHRoZSBs
aW51eCBkcml2ZXI/DQo+ID4gPiA+DQo+ID4gPiA+IEkgZGlkIE5PVCBydW4gb3AtdGVlIHdpdGgg
TGludXgtbmV4dCBrZXJuZWwgYmVmb3JlLCBjYW4geW91IGFkdmlzZSBtb3JlPw0KPiA+ID4NCj4g
PiA+IE5laXRoZXIgaGF2ZSBJLCBzbyBJIGNhbid0IGFkdmlzZSBtb3JlLg0KPiA+ID4NCj4gPiA+
ID4gQW5kIEkgdGhpbmsgaWYgb3AtdGVlIGhhcyBzdWNoIHJlcXVpcmVtZW50LCBjYW4gd2UgaGF2
ZSBhbm90aGVyDQo+ID4gPiA+IHBhdGNoIHRvIGNvdmVyIGl0Pw0KPiA+ID4NCj4gPiA+IFllcy4N
Cj4gPiA+DQo+ID4gPg0KPiA+ID4gPiBJIGJlbGlldmUgYWxsIG90aGVyIGkuTVggcGxhdGZvcm1z
IGFsc28gaGF2ZSBzYW1lIHJlcXVpcmVtZW50cyBpZg0KPiA+ID4gPiBjb25zaWRlcmluZyBvcC10
ZWUgc3VwcG9ydCwgc28gSSB0aGluayBpdCBzaG91bGQgYmUgYW5vdGhlciB0b3BpYywNCj4gPiA+
ID4gd2hhdCBkbyB5b3UNCj4gPiA+IHRoaW5rPw0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEknbSBn
b2luZyB0byBkcm9wIHRoZXNlIHBhdGNoZXMgZnJvbSBteSByZXZpZXcgcXVldWUuIFBsZWFzZSBy
ZXNlbmQNCj4gPiA+IHRoZW0gYW5kIHBsZWFzZSBpbmNsdWRlIHRoZSBvcC10ZWUgcGF0Y2hlcyB0
b28uDQo+ID4NCj4gPg0KPiA+IEkgZG8gTk9UIGtub3cgaG93IHRvIGluY2x1ZGUgdGhlIG9wLXRl
ZSBwYXRjaCB0byBtZWV0IHNwZWNpYWwNCj4gPiByZXF1aXJlbWVudCwgc2hvdWxkIHRoZSBvcC10
ZWUgcmVsYXRlZCBwYXRjaCBiZSBhZGRlZCBsYXRlciB3aGVuIHNvbWVvbmUNCj4gYWN0dWFsbHkg
YWRkIHRoZSBvcC10ZWUgc3VwcG9ydCBmb3IgaS5NWDc/DQo+ID4gSXQgc2hvdWxkIE5PVCBibG9j
ayB0aGlzIHBhdGNoIHNldCwgZG8geW91IHRoaW5rIHdlIGNhbiBhZGQgdGhpcyBwYXRjaCBzZXQN
Cj4gZmlyc3Q/DQo+ID4NCj4gDQo+IFBsZWFzZSByZXNlbmQgdGhlIHR3byBwYXRjaGVzLiBJbiB0
aGUgY29tbWl0IHRleHQgZm9yIHRoZSBzZWNvbmQgcGF0Y2gsDQo+IGRlc2NyaWJlIHRoZSBwbGFu
IHRvIHJlbW92ZSBDTEtfSVNfQ1JJVElDQUwgZnJvbSB0aGVzZSBjbGtzIGJ5IGFkZGluZyBhbg0K
PiBPUC1URUUgZGV2aWNlL2RyaXZlciB0byB0aGUga2VybmVsIHRvIGtlZXAgdGhlc2UgY2xrcyBl
bmFibGVkLiBNeQ0KPiB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlcmUgaXNuJ3QgYW4gT1AtVEVF
IGRyaXZlciByaWdodCBub3csIGJ1dCB0aGVzZSBjbGtzIGFyZQ0KPiB1c2VkIGJ5IHRoZSBmaXJt
d2FyZSBhbmQgY2FuJ3QgYmUgdHVybmVkIG9mZiBpbiBMaW51eC4gSWYgaW4gdGhlIGZ1dHVyZSB3
ZSB3YW50DQo+IHRvIGJlIGFibGUgdG8gdHVybiB0aGVtIG9uIGFuZCBvZmYsIHdlJ2xsIG5lZWQg
dG8gYWRkIHRoZW0gdG8gYW4gT1AtVEVFIGRldmljZQ0KPiBub2RlIGFuZCBoYXZlIHRoYXQgZHJp
dmVyIG1hbmFnZSB0aGUgY2xrcy4NCj4gDQo+IEhvdyB0aGF0IHdpbGwgd29yayB3aGVuIGEgc3lz
dGVtIGRvZXNuJ3QgZW5hYmxlIHRoZSBPUC1URUUgZHJpdmVyIEknbSBub3QNCj4gc3VyZS4gV2Ug
bWF5IG5lZWQgdG8gZGV2ZWxvcCBzb21lIHN5c3RlbSB3aGVyZWJ5IGNsa3MgbGlrZSB0aGlzIGFy
ZSBoYW5kZWQNCj4gZnJvbSB0aGUgY2xrIGNvbnRyb2xsZXIgdG8gdGhlIGNvbnN1bWVyIGRyaXZl
ciB3aGVuIGl0J3MgZW5hYmxlZCBmb3IgZnVydGhlcg0KPiBwb3dlciBtYW5hZ21lbnQsIGJ1dCBp
ZiB0aGV5J3JlIG5ldmVyIGhhbmRlZCBvZmYsIHRoZXkncmUga2VwdCBvbiBmb3JldmVyIGxpa2UN
Cj4gaXMgZG9uZSBoZXJlLiBBbnl3YXksIHBsZWFzZSByZXNlbmQgd2l0aCBhIG5vdGUgYWJvdXQg
d2h5IHRoZXNlIGFyZSBtYXJrZWQNCj4gQ0xLX0lTX0NSSVRJQ0FMLg0KIA0KSSB0aGluayB0aGVy
ZSBpcyBzb21lIG1pc3VuZGVyc3RhbmRpbmcgaGVyZSwgdGhpcyBwYXRjaCBzZXRzIHRob3NlIGNy
aXRpY2FsIGNsb2Nrcw0Kd2l0aCBDTEtfSVNfQ1JJVElDQUwgZmxhZyB0byBsZXQgY2xvY2sgZHJp
dmVyIGtlZXAgdGhlbSBhbHdheXMgT04sIGFzIHRoZXkgYXJlDQpjcml0aWNhbCBjbG9ja3MgYW5k
IHN5c3RlbSAoTGludXgga2VybmVsLCBOT1QgaW5jbHVkZSBvcC10ZWUpIGNhbiBOT1QgcnVuIG5v
cm1hbGx5DQppZiBhbnlvbmUgb2YgdGhlbSBpcyBPRkYuDQoNClRoZSBxdWVzdGlvbiBhYm91dCBv
cC10ZWUgaXMsIHRoZXJlIG1pZ2h0IGJlIHNvbWUgc3BlY2lhbCBjbG9ja3MgbmVlZGVkIGJ5IG9w
LXRlZSwNCmZvciBleGFtcGxlLCBjdXJyZW50bHkgY2xrIEEsIEIgYW5kIEMgYXJlIGtlcHQgYWx3
YXlzIE9OIGZvciBMaW51eCBrZXJuZWwgdG8gcnVuIG5vcm1hbGx5LA0KYnV0IHdoZW4gb3AtdGVl
IGlzIGV4ZWN1dGluZywgaXQgbWlnaHQgbmVlZCBjbGsgRCB0byBiZSBPTiwgc28gSSB0aGluayB0
aGUgY2xrIEQgaXMgbmVlZGVkDQpPTkxZIGZvciBvcC10ZWUsIG9wLXRlZSBzaG91bGQgaGF2ZSBh
IGRyaXZlciBvciBmaXJtd2FyZSB0byBydW50aW1lIE9OL09GRiBjbGsgRCBhcyBuZWVkZWQuDQpT
aW5jZSBJIGRvIE5PVCBrbm93IHdoYXQgY2xvY2tzIG9wLXRlZSBuZWVkcywgc28gSSB3aWxsIGxl
YXZlIHRoZW0gdG8gYmUgYWRkZWQgYnkgb3AtdGVlDQpvd25lciwgd2hvZXZlciBlbmFibGVzIG9w
LXRlZSwgaGUgc2hvdWxkIGNvbnNpZGVyIHdoZXJlIHRvIG1hbmFnZSBpdHMgc3BlY2lhbCBjbG9j
a3MsDQplaXRoZXIgaW4gY2xrIGRyaXZlciBvciBvcC10ZWUgZHJpdmVyL2Zpcm13YXJlLg0KDQpT
byBkbyB3ZSBzdGlsbCBuZWVkIHRvIG1lbnRpb24gdGhlIG9wLXRlZSByZWxhdGVkIGluZm8gaW4g
Y29tbWl0IHRleHQ/IEFjdHVhbGx5LCB0aGlzIHBhdGNoDQppcyBqdXN0IHRvIHJlcGxhY2UgdGhv
c2UgYWx3YXlzLU9OIGNsb2NrcyBpbiBjbGtzX2luaXRfb24gYXJyYXkgd2l0aCBDTEtfSVNfQ1JJ
VElDQUwgZmxhZy4NClRoZW4gbm8gbmVlZCB0byBleHBsaWNpdGx5IGVuYWJsZSBjbG9ja3MgaW4g
Y2xrc19pbml0X29uIGFycmF5IGFuZCBqdXN0IHJlbHkgb24gY29tbW9uIGNsaw0KZnJhbWV3b3Jr
IHdoaWNoIHdpbGwgZW5hYmxlIGFsbCBjbG9ja3Mgd2l0aCBDTEtfSVNfQ1JJVElDQUwgZmxhZyBz
ZXQsIGl0IHdpbGwgYWxpZ24gd2l0aCBhbGwNCm90aGVyIGkuTVggU29DcyBjbGsgZHJpdmVyLg0K
DQpBbnNvbi4NCg0K
