Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A797C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4585D20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="aPGVlJTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4585D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeLLME7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:04:59 -0500
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:2323
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727287AbeLLME6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wXFovUS1p2uTBd8L8BiurrkdfOcHKEqDH7zGcvBK2s=;
 b=aPGVlJTPuWZS+vs2P8uUAhTLmTxvuWoo02M1NxhGAHyJoZ7TiN5uY9OaKQdi7MTxSRh5Ht+WlRNkNphHR9OwEVXApFfHNw3E6cobiBXuUFkwJ2Z1N88JM76QSJsrr0D8OMuHYU3lUMCZEp5LKeOhB4x7gcORMqy59667uJmnuFg=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4121.eurprd04.prod.outlook.com (52.135.130.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 12:04:50 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 12:04:50 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [RFC PATCH v4 1/2] dt-bindings: pwm: imx: Allow switching PWM output
 between PWM and GPIO
Thread-Topic: [RFC PATCH v4 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Thread-Index: AQHUkhLi3MZ2+5IH1USqgPsrvECLRw==
Date:   Wed, 12 Dec 2018 12:04:50 +0000
Message-ID: <1544616263-82642-2-git-send-email-michal.vokac@ysoft.com>
References: <1544616263-82642-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1544616263-82642-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0022.eurprd07.prod.outlook.com
 (2603:10a6:203:51::32) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4121;6:ESJVVojK1LVY9BCsJ+A4nMPkRyJr564BM8v5i7dqUJeqaj6iDJH4x9VnzFRvXXYEBoktrvuzyVylticWPJvc4snMQxDWuUCMhyk1TSuxNbTFgLgSmg6Hvfe3AeoyfF/4JdNPEqUGFIYEAaZf3Vl7FqpwGYUV5n6p4LLYGcxIbkyZ/ZLTVMWv2o0A0rVrxAOxvD7Ho8PN971i0/NQgtkHdJ/gJhZInLPg6fUk+gSmsvIutLhbijUmPrPvvHcvhoIv4ba2vKYmXdMLXZ1xxy5fVWxb8cMpeUfKichU4VWsilH42hSgd2ApRiCLn3DJr24GCg05h4XdHHjGBPA1YB70ETWR7oSGIWNkjb0Sdc5WYVMJxeL5lNdacCmS6zn42WHt2HIvdgk73OtL8D/KX2lkyN8jxCWKRtCI5c5Mz+AH5oZKselJz18V419J3FebqIUDQyJVLhfv7cDeYf+N6MA4Rg==;5:qORcXRFLN+bI2sVjBPWHDLKDKq8kYd6IkE6YdcScVed7yHHM9bKMsKoGDj7m2pHtFDD6h9gy9GtQtweuar0eFisR7jiRzD0G6xNv6rY8snrU01kKIRiEog2Tufq9eRe8ANpaGhZItaeCYbv08VGf+DW3inH/fZZeuis4JmsLvBs=;7:yrqlvYyUQDd4G1Wji1Dz40CHts6tZf3/MDIj+1Mf90ZoopUMS5aE1OesnFjfmQPgyWwaFpnbFb1f7ygJv+O8v0g8q9HE3GlMbKa6fsCCHQZNlD3DAyCy9KN4R6lYHUCGPBjUK/SFCPPVHhrU2W1mtg==
x-ms-office365-filtering-correlation-id: 0c7f3202-4d3b-4875-577f-08d6602a0493
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4121;
x-ms-traffictypediagnostic: DB7PR04MB4121:
x-microsoft-antispam-prvs: <DB7PR04MB4121F57ED614037C051555999EA70@DB7PR04MB4121.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4121;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4121;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39850400004)(396003)(366004)(189003)(199004)(66066001)(105586002)(6436002)(71190400001)(14454004)(106356001)(71200400001)(7736002)(72206003)(4326008)(7416002)(97736004)(25786009)(305945005)(86362001)(5660300001)(575784001)(478600001)(8676002)(6512007)(39060400002)(53936002)(107886003)(14444005)(256004)(68736007)(11346002)(486006)(446003)(3846002)(6506007)(102836004)(386003)(2906002)(26005)(476003)(316002)(2616005)(85182001)(186003)(52116002)(110136005)(99286004)(6116002)(81166006)(76176011)(36756003)(81156014)(54906003)(6486002)(217873002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4121;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FOgYmwtErX31oHVxLFaIuV76YGTRDJHwUelrhwUOI80PdyUALnqw9eUDpwmW9456Bx0QfxlS2iYewX6YCZ6t8qVFLX0XcS2J9Q79un4sCs7FofKsMb6nSIOrSClX1Jm67n84UDmyLpSdve673NoFHLa2q+4Y3XFUuTPH8jXiaHVnkfhhgH4Q+hwKd1lKeMu6eAbwzMhKPLbwQe7xl5cPRfZevrckQNARsAeux3Y5yQqSBBeFbZCSn4Rp/uLnrV+RaaSRLVPqenvK0ltP/zC5RT7qu6vtOp2W+FQ5AMjSqBPpRzo+0gvDOHJ7AczZhlHw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE571C825964984F84B91FCC85D03376@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7f3202-4d3b-4875-577f-08d6602a0493
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 12:04:50.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T3V0cHV0IG9mIHRoZSBQV00gYmxvY2sgb24gaS5NWCBTb0NzIGlzIGFsd2F5cyBsb3cgd2hlbiB0
aGUgYmxvY2sgaXMNCmRpc2FibGVkLiBUaGlzIGNhbiBjYXVzZSBpc3N1ZXMgd2hlbiBpbnZlcnRl
ZCBQV00gcG9sYXJpdHkgaXMgbmVlZGVkLg0KV2l0aCBpbnZlcnRlZCBwb2xhcml0eSBhIGR1dHkg
Y3ljbGUgPSAwJSBjb3JyZXNwb25kcyB0byBoaWdoIGxldmVsIG9uDQp0aGUgb3V0cHV0LiBOb3cs
IHdoZW4gUFdNIGlzIGRpc2FibGVkIGl0cyBvdXRwdXQgaW5zdGFudGx5IGdvZXMgbG93DQp3aGlj
aCBjb3JyZXNwb25kcyB0byBkdXR5IGN5Y2xlID0gMTAwJS4NCg0KVG8gZ2V0IGEgdHJ1bHkgaW52
ZXJ0ZWQgUFdNIG91dHB1dCB0d28gcGluY3RybCBzdGF0ZXMgb2YgdGhlIFBXTSBwaW4NCmNhbiBi
ZSB1c2VkLiBDb25maWd1cmUgdGhlIHBpbiB0byBHUElPIGZ1bmN0aW9uIHdoZW4gUFdNIGlzIGRp
c2FibGVkDQphbmQgc3dpdGNoIGJhY2sgdG8gUFdNIGZ1bmN0aW9uIHdoZW5ldmVyIG5vbi16ZXJv
IGR1dHkgY3ljbGUgaXMgbmVlZGVkLg0KDQpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhA
a2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IE1pY2hhbCBWb2vDocSNIDxtaWNoYWwudm9rYWNA
eXNvZnQuY29tPg0KLS0tDQpDaGFuZ2VzIGluIHY0Og0KIC0gQWRkIFItYnkgZnJvbSBSb2IuDQoN
CkNoYW5nZXMgaW4gdjM6DQogLSBTbGlnaHRseSBkaWZmZXJlbnQgZGVzY3JpcHRpb24gb2YgdGhl
IHBpbmN0cmwgYW5kIHB3bS1ncGlvLg0KDQpDaGFuZ2VzIGluIHYyOg0KIC0gRG8gbm90IHVzZSB0
aGUgImRlZmF1bHQiIHBpbmN0cmwgc3RhdGUgZm9yIEdQSU8uDQogLSBVc2UgdHdvIG5ldyAicHdt
IiBhbmQgImdwaW8iIHBpbmN0cmwgc3RhdGVzLg0KIC0gQWRkIGEgbmV3IHB3bS1ncGlvcyBzaWdu
YWwuDQoNCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC1wd20udHh0
IHwgNDkgKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNDkgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3B3bS9pbXgtcHdtLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20v
aW14LXB3bS50eHQNCmluZGV4IGM2MWJkZjguLjJhNTU1YjYgMTAwNjQ0DQotLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC1wd20udHh0DQorKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2lteC1wd20udHh0DQpAQCAtMTQsNiArMTQs
MTYgQEAgU2VlIHRoZSBjbG9jayBjb25zdW1lciBiaW5kaW5nLA0KIAlEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvY2xvY2svY2xvY2stYmluZGluZ3MudHh0DQogLSBpbnRlcnJ1cHRz
OiBUaGUgaW50ZXJydXB0IGZvciB0aGUgcHdtIGNvbnRyb2xsZXINCiANCitPcHRpb25hbCBwcm9w
ZXJ0aWVzOg0KKy0gcGluY3RybDogRm9yIGkuTVgyNyBhbmQgbmV3ZXIgU29Dcy4gVXNlICJwd20i
IGFuZCAiZ3BpbyIgc3BlY2lmaWMgcGluY3RybHMNCisgIGluc3RlYWQgb2YgdGhlICJkZWZhdWx0
IiB0byBjb25maWd1cmUgdGhlIFBXTSBwaW4gdG8gR1BJTyBhbmQgUFdNIGZ1bmN0aW9uLg0KKyAg
SXQgYWxsb3dzIGNvbnRyb2wgb3ZlciB0aGUgcGluIG91dHB1dCBsZXZlbCB3aGVuIHRoZSBQV00g
YmxvY2sgaXMgZGlzYWJsZWQuDQorICBUaGlzIGlzIHVzZWZ1bCBpZiB5b3UgdXNlIHRoZSBQV00g
Zm9yIHNpbmdsZSBwdXJwb3NlIGFuZCB5b3UgbmVlZCBpbnZlcnRlZA0KKyAgcG9sYXJpdHkgb2Yg
dGhlIFBXTSBzaWduYWwuIFNlZSAiSW52ZXJ0ZWQgUFdNIG91dHB1dCIgc2VjdGlvbiBiZWxsb3cu
DQorLSBwd20tZ3Bpb3M6IFNwZWNpZnkgdGhlIEdQSU8gcGluIHRoYXQgd2lsbCBhY3QgYXMgdGhl
IFBXTSBvdXRwdXQuIFRoaXMgc2hvdWxkDQorICBiZSB0aGUgc2FtZSBwaW4gYXMgaXMgdXNlZCBm
b3Igbm9ybWFsIFBXTSBvdXRwdXQuIFNlZSAiSW52ZXJ0ZWQgUFdNIG91dHB1dCINCisgIHNlY3Rp
b24gYmVsbG93Lg0KKw0KIEV4YW1wbGU6DQogDQogcHdtMTogcHdtQDUzZmI0MDAwIHsNCkBAIC0y
NSwzICszNSw0MiBAQCBwd20xOiBwd21ANTNmYjQwMDAgew0KIAljbG9jay1uYW1lcyA9ICJpcGci
LCAicGVyIjsNCiAJaW50ZXJydXB0cyA9IDw2MT47DQogfTsNCisNCitJbnZlcnRlZCBQV00gb3V0
cHV0DQorLS0tLS0tLS0tLS0tLS0tLS0tLQ0KKw0KK1RoZSBpLk1YwqBTb0MgaGFzIHN1Y2ggbGlt
aXRhdGlvbiB0aGF0IHdoZW5ldmVyIGEgcGluIGlzIGNvbmZpZ3VyZWQgYXMgYSBQV00NCitvdXRw
dXQsIHRoZSBvdXRwdXQgbGV2ZWwgb24gdGhlIHBpbiBpcyBhbHdheXMgbG93IHdoZW4gdGhlIFBX
TSBibG9jayBpcw0KK2Rpc2FibGVkLiBUaGUgbG93IG91dHB1dCBsZXZlbCBpcyBhY3RpdmVseSBk
cml2ZW4gYnkgdGhlIG91dHB1dCBzdGFnZSBvZiB0aGUNCitQV00gYmxvY2sgYW5kIGl0IGRvZXMg
bm90IG1hdHRlciB3aGF0IHBvbGFyaXR5IGEgUFdNIGNsaWVudCAoZS5nLiBiYWNrbGlnaHQpDQor
cmVxdWVzdGVkLg0KKw0KK1RvIGdhaW4gY29udHJvbCBvZiB0aGUgb3V0cHV0IGxldmVsIGluIFBX
TSBkaXNhYmxlZCBzdGF0ZSB0d28gcGluY3RybCBzdGF0ZXMNCitjYW4gYmUgdXNlZC4gQSAicHdt
IiBzdGF0ZSBhbmQgYSAiZ3BpbyIgc3RhdGUuIEluIHRoZSBwd20gc3RhdGUgdGhlIHBpbiBpcw0K
K2NvbmZpZ3VyZWQgYXMgYSBub3JtYWwgUFdNIG91dHB1dC4gSW4gdGhlIGdwaW8gc3RhdGUgdGhl
IHBpbiBpcyBjb25maWd1cmVkIGFzDQorYSBHUElPIGlucHV0LiBJbiB0aGUgZ3BpbyBzdGF0ZSB0
aGUgb3V0cHV0IGxldmVsIGlzIGNvbnRyb2xsZWQgYnkgdGhlIHB1bGwtdXANCitzZXR0aW5nLiBU
aGlzIHNldHVwIGFzc3VyZXMgdGhhdCB0aGUgUFdNIG91dHB1dCBpcyBhdCB0aGUgcmVxdWlyZWQg
bGV2ZWwgdGhhdA0KK2NvcnJlc3BvbmRzIHRvIGR1dHkgY3ljbGUgPSAwIHdoZW4gUFdNIGlzIGRp
c2FibGVkLg0KKw0KK0V4YW1wbGU6DQorDQorJnB3bTEgew0KKwlwaW5jdHJsLW5hbWVzID0gInB3
bSIsICJncGlvIjsNCisJcGluY3RybC0wID0gPCZwaW5jdHJsX2JhY2tsaWdodF9wd20+Ow0KKwlw
aW5jdHJsLTEgPSA8JnBpbmN0cmxfYmFja2xpZ2h0X2dwaW8+Ow0KKwlwd20tZ3Bpb3MgPSA8Jmdw
aW8xIDkgR1BJT19BQ1RJVkVfTE9XPg0KK30NCisNCitwaW5jdHJsX2JhY2tsaWdodF9ncGlvOiBw
d20xZ3JwLWdwaW8gew0KKwlmc2wscGlucyA9IDwNCisJCS8qIEdQSU8gd2l0aCAxMDBrT2htIHB1
bGwtdXAgKi8NCisJCU1YNlFETF9QQURfR1BJT185X19HUElPMV9JTzA5CTB4YjAwMA0KKwk+Ow0K
K307DQorDQorcGluY3RybF9iYWNrbGlnaHRfcHdtOiBwd20xZ3JwLXB3bSB7DQorCWZzbCxwaW5z
ID0gPA0KKwkJLyogUFdNIG91dHB1dCAqLw0KKwkJTVg2UURMX1BBRF9HUElPXzlfX1BXTTFfT1VU
CTB4OA0KKwk+Ow0KK307DQotLSANCjIuMS40DQoNCg==
