Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C41DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239ED20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iorMljie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239ED20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbeLFIbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:31:18 -0500
Received: from mail-eopbgr780058.outbound.protection.outlook.com ([40.107.78.58]:41823
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLFIbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i/EcekIYLfrWdaQRvKZFpledXJXB6EoMBuWBVXYB/U=;
 b=iorMljieZWVxklDEqAeZ2a/4VPwIGf48YlZjs6g+Eu2dGzRwoDERkUawysxyIQfcxgRdrv63kfE02qxXcUV6nMrUGoKMwn07i3gOI/ON7PjgziK0+cpYirDGvcC36Gxz1GbiS4vYzByzFY7gto4boXQTDA7lcdFswCtMF8IOGHo=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2381.namprd02.prod.outlook.com (10.168.244.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 08:31:13 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::95ca:9c47:8102:97b1]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::95ca:9c47:8102:97b1%4]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 08:31:12 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "d-gerlach@ti.com" <d-gerlach@ti.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [LINUX PATCH v12 1/2] dt-bindings: memory: Add pl353 smc
 controller devicetree binding information
Thread-Topic: [LINUX PATCH v12 1/2] dt-bindings: memory: Add pl353 smc
 controller devicetree binding information
Thread-Index: AQHUh+Mk0l4ZgmQZwkOMKb6zNYxYCqVwQccAgAEqUQA=
Date:   Thu, 6 Dec 2018 08:31:12 +0000
Message-ID: <MWHPR02MB262306C87940C7DB6D799611AFA90@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1543496257-5396-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <52d598c9-8e72-c30b-edc8-bb16e29b425a@xilinx.com>
In-Reply-To: <52d598c9-8e72-c30b-edc8-bb16e29b425a@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2381;6:POUkTnTEjhQXiRjfyWNmoNcOtH75+Efi2uaCGbjsYQQrhFpoUla+te6DOQinKi8mbqnodGONfOdsJaM5ho6+V3N3oua8Hy0PxogX0EQ9EucmUHarW6rK71Yyye3whRgUbjdLiHeN75K793ZtQA3sgrG19Q6hSKGZ3yH0We1B7qXk5w2O0qdgbi9hWBVhVInSy4paPMN4/W4KqSkxyGPGH3uwTi6/BxcZlgpDwt7B7kIO/R7cI6GuKhneEGXTKVNTu8DqH5chZyeSmDkOaDhR7xpVKbwFV2KN/ZjfuJOX0VJeT7DPgH21bR3ejRgW455Pcbj3NQUXjWLThJhOVBmFN7+EwGi0ZKDYIfdUurdhHtyvc7NjfP2VqBGISvesvMYB+SG5prPUViSW2mMsTPpMHTOoGkNdIKEf6tQo2hJAZ4q/m1pNoEt+Zt0CIsKW2sdhlF07Dskm91e91Y3cT36lWA==;5:UcesNxMaMeiWWL+hmopJphA0PHe9Z60T4VIU4GzmfQlDLCTzHFLFH7UJUFd0vGzRs6q6p9yu+J+wHxb+WRsVVrAS/TVWxOHcSkAMtaiDjB261U+uLmKcpl7o1NkOI+dO3SiauNO0QOawqSo9VmsyePWmvPoeLWxOG4oOKFO70Rg=;7:t0Wu5u91MqsehU26XdseYs8ChJ5DJy8KadNUPS0ffMBdYniA064T2awwPIznQ5p0A3vFS9RPPFdty0YR4xvquz5n6JEirZREjILRejABA4oIFKruDaAuGaPGHkt0MP4AzdOaYuU34PdKZzA6jU3E1g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(13464003)(54534003)(2501003)(446003)(11346002)(217873002)(99286004)(14454004)(5660300001)(486006)(2906002)(476003)(76176011)(8936002)(33656002)(7696005)(186003)(229853002)(305945005)(53936002)(256004)(102836004)(6246003)(6306002)(9686003)(71190400001)(71200400001)(8676002)(74316002)(53546011)(6116002)(3846002)(110136005)(316002)(4326008)(54906003)(66066001)(6436002)(7736002)(39060400002)(68736007)(81156014)(26005)(106356001)(478600001)(55016002)(105586002)(97736004)(2201001)(966005)(6506007)(25786009)(81166006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2381;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: effa2d8f-371f-41b5-09b4-08d65b552e4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2381;
x-ms-traffictypediagnostic: MWHPR02MB2381:
x-microsoft-antispam-prvs: <MWHPR02MB23819ADA9C7D91A70248B008AFA90@MWHPR02MB2381.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2381;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2381;
x-forefront-prvs: 087894CD3C
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: leMM2Mb30hxrBBVrZkcvOVST0lQ+Wgggwdy84f71fdp6BU9oo0RZ2gqkQJy855VkKmJDLlKBTbR7yyfwVFn9G0JQf0IjaZdOBTES+ZTBw5TpTLJqcx3WI3uHo7igi3Y2GM48NzA5WqvDppxGU0m6p2vnx7AU/Fyy3tZhmrvrYeNYhXdq/g+5a2j7qWcHEaXzAWI2WEpBrlcf9C80KRRgKD1ak3uzC3YJ/KxiLI5oTrLaw/PDhFcNSxGdZxFejXRYOLSB7w8WQDMClUA0LsC+5rnz3idMnoVmQ1u4H/rBRpK8cS83RrMdxxmA7x49B5JVw2vdcoDmMB9L82ELpqpGeC/93g2mhUq+A6FlwYms8BM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effa2d8f-371f-41b5-09b4-08d65b552e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 08:31:12.5516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pY2hh
bCBTaW1layBbbWFpbHRvOm1pY2hhbC5zaW1la0B4aWxpbnguY29tXQ0KPiBTZW50OiBXZWRuZXNk
YXksIERlY2VtYmVyIDUsIDIwMTggODoxMyBQTQ0KPiBUbzogTmFnYSBTdXJlc2hrdW1hciBSZWxs
aSA8bmFnYXN1cmVAeGlsaW54LmNvbT47IG1tYXllckBicm9hZGNvbS5jb207DQo+IGYuZmFpbmVs
bGlAZ21haWwuY29tOyBsYWRpc0BsaW51eC1taXBzLm9yZzsgdHJlZGluZ0BudmlkaWEuY29tOyBk
aWdldHhAZ21haWwuY29tOyBkLQ0KPiBnZXJsYWNoQHRpLmNvbQ0KPiBDYzogbGludXMud2FsbGVp
akBsaW5hcm8ub3JnOyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbTElOVVggUEFUQ0ggdjEy
IDEvMl0gZHQtYmluZGluZ3M6IG1lbW9yeTogQWRkIHBsMzUzIHNtYyBjb250cm9sbGVyDQo+IGRl
dmljZXRyZWUgYmluZGluZyBpbmZvcm1hdGlvbg0KPiANCj4gT24gMjkuIDExLiAxOCAxMzo1Nywg
TmFnYSBTdXJlc2hrdW1hciBSZWxsaSB3cm90ZToNCj4gPiBBZGQgcGwzNTMgc3RhdGljIG1lbW9y
eSBjb250cm9sbGVyIGRldmljZXRyZWUgYmluZGluZyBpbmZvcm1hdGlvbi4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkNCj4gPiA8bmFnYS5zdXJlc2hrdW1h
ci5yZWxsaUB4aWxpbnguY29tPg0KPiA+IFJldmlld2VkLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9tZW1vcnkt
Y29udHJvbGxlcnMvcGwzNTMtc21jLnR4dCAgICAgIHwgNDcNCj4gKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5
LWNvbnRyb2xsZXJzL3BsMzUzLXNtYy50eHQNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvcGwzNTMt
c21jLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1j
b250cm9sbGVycy9wbDM1My1zbWMudHh0DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBp
bmRleCAwMDAwMDAwLi5kNTY2MTVmDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvcGwzNTMtc21j
LnQNCj4gPiArKysgeHQNCj4gPiBAQCAtMCwwICsxLDQ3IEBADQo+ID4gK0RldmljZSB0cmVlIGJp
bmRpbmdzIGZvciBBUk0gUEwzNTMgc3RhdGljIG1lbW9yeSBjb250cm9sbGVyDQo+ID4gKw0KPiA+
ICtQTDM1MyBzdGF0aWMgbWVtb3J5IGNvbnRyb2xsZXIgc3VwcG9ydHMgdHdvIGtpbmRzIG9mIG1l
bW9yeQ0KPiA+ICtpbnRlcmZhY2VzLmkuZSBOQU5EIGFuZCBTUkFNL05PUiBpbnRlcmZhY2VzLg0K
PiA+ICtUaGUgYWN0dWFsIGRldmljZXMgYXJlIGluc3RhbnRpYXRlZCBmcm9tIHRoZSBjaGlsZCBu
b2RlcyBvZiBwbDM1MyBzbWMgbm9kZS4NCj4gPiArDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6
DQo+ID4gKy0gY29tcGF0aWJsZQkJOiBTaG91bGQgYmUgImFybSxwbDM1My1zbWMtcjJwMSIsICJh
cm0scHJpbWVjZWxsIi4NCj4gPiArLSByZWcJCQk6IENvbnRyb2xsZXIgcmVnaXN0ZXJzIG1hcCBh
bmQgbGVuZ3RoLg0KPiA+ICstIGNsb2NrLW5hbWVzCQk6IExpc3Qgb2YgaW5wdXQgY2xvY2sgbmFt
ZXMgLSAibWVtY2xrIiwgImFwYl9wY2xrIg0KPiA+ICsJCQkgIChTZWUgY2xvY2sgYmluZGluZ3Mg
Zm9yIGRldGFpbHMpLg0KPiA+ICstIGNsb2NrcwkJOiBDbG9jayBwaGFuZGxlcyAoc2VlIGNsb2Nr
IGJpbmRpbmdzIGZvciBkZXRhaWxzKS4NCj4gPiArLSBhZGRyZXNzLWNlbGxzCQk6IE11c3QgYmUg
Mi4NCj4gPiArLSBzaXplLWNlbGxzCQk6IE11c3QgYmUgMS4NCj4gPiArDQo+ID4gK0NoaWxkIG5v
ZGVzOg0KPiA+ICsgRm9yIE5BTkQgdGhlICJhcm0scGwzNTMtbmFuZC1yMnAxIiBhbmQgZm9yIE5P
UiB0aGUgImNmaS1mbGFzaCINCj4gPiArZHJpdmVycyBhcmUgc3VwcG9ydGVkIGFzIGNoaWxkIG5v
ZGVzLg0KPiA+ICsNCj4gPiArZm9yIE5BTkQgcGFydGl0aW9uIGluZm9ybWF0aW9uIHBsZWFzZSBy
ZWZlciB0aGUgYmVsb3cgZmlsZQ0KPiA+ICtEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbXRkL3BhcnRpdGlvbi50eHQNCj4gPiArDQo+ID4gK0V4YW1wbGU6DQo+ID4gKwlzbWNjOiBt
ZW1vcnktY29udHJvbGxlckBlMDAwZTAwMA0KPiA+ICsJCQljb21wYXRpYmxlID0gImFybSxwbDM1
My1zbWMtcjJwMSIsICJhcm0scHJpbWVjZWxsIjsNCj4gPiArCQkJY2xvY2stbmFtZXMgPSAibWVt
Y2xrIiwgImFwYl9wY2xrIjsNCj4gPiArCQkJY2xvY2tzID0gPCZjbGtjIDExPiwgPCZjbGtjIDQ0
PjsNCj4gPiArCQkJcmVnID0gPDB4ZTAwMGUwMDAgMHgxMDAwPjsNCj4gPiArCQkJI2FkZHJlc3Mt
Y2VsbHMgPSA8Mj47DQo+ID4gKwkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICsJCQlyYW5nZXMg
PSA8MHgwIDB4MCAweGUxMDAwMDAwIDB4MTAwMDAwMCAvL05hbmQgQ1MgUmVnaW9uDQo+ID4gKwkJ
CQkgIDB4MSAweDAgMHhlMjAwMDAwMCAweDIwMDAwMDAgLy9TUkFNL05PUiBDUw0KPiBSZWdpb24N
Cj4gPiArCQkJCSAgMHgyIDB4MCAweGU0MDAwMDAwIDB4MjAwMDAwMD47IC8vU1JBTS9OT1IgQ1MN
Cj4gUmVnaW9uDQo+ID4gKwkJCW5hbmRfMDogZmxhc2hAZTEwMDAwMDAgew0KPiA+ICsJCQkJY29t
cGF0aWJsZSA9ICJhcm0scGwzNTMtbmFuZC1yMnAxIg0KPiA+ICsJCQkJcmVnID0gPDAgMCAweDEw
MDAwMDA+Ow0KPiA+ICsJCQkJKC4uLikNCj4gPiArCQkJfTsNCj4gPiArCQkJbm9yMDogZmxhc2hA
ZTIwMDAwMDAgew0KPiA+ICsJCQkJY29tcGF0aWJsZSA9ICJjZmktZmxhc2giOw0KPiA+ICsJCQkJ
cmVnID0gPDEgMCAweDIwMDAwMDA+Ow0KPiA+ICsJCQl9Ow0KPiA+ICsJCQlub3IxOiBmbGFzaEBl
NDAwMDAwMCB7DQo+ID4gKwkJCQljb21wYXRpYmxlID0gImNmaS1mbGFzaCI7DQo+ID4gKwkJCQly
ZWcgPSA8MiAwIDB4MjAwMDAwMD47DQo+ID4gKwkJCX07DQo+ID4gKwl9Ow0KPiA+DQo+IA0KPiB2
MTEgd2FzIHNlbnQgbG9uZyB0aW1lIGFnbyBhbmQgYWxzbyByZXZpZXdlZCBieSBMaW51cyBoZXJl
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC85NjE2MDMvDQo+IA0K
PiBJIGNhbid0IHNlZSBjaGFuZ2Vsb2cgd2hpY2ggeW91IGhhdmUgaW4gdjExLiBBbmQgYWxzbyBy
ZWNvcmRlZCBjaGFuZ2VzIGlmIGFueS4NCk9rLCB3aWxsIGFkZCBjaGFuZ2Vsb2cgYW5kIHdpbGwg
c2VuZCBuZXcgcGF0Y2guDQoNClRoYW5rcywNCk5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkNCj4gVGhl
biB0aGlzIGRyaXZlciB3aWxsIGdvIHRocm91Z2ggYXJtLXNvYyB0cmVlIHZpYSBtZS4NCj4gDQo+
IFRoYW5rcywNCj4gTWljaGFsDQoNCg==
