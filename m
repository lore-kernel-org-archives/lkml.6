Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDAFC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C70208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="lbEovu95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C70208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbeLFKfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:35:34 -0500
Received: from mail-eopbgr30092.outbound.protection.outlook.com ([40.107.3.92]:18887
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728482AbeLFKfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlWZ7/z5dGMbEHNWERKebWWOrSs0JhyAOkIy7C7D9A0=;
 b=lbEovu95FcbW/f/jjRrqgYMT0P5ct4F9gppS68XXM2KIji9mqfZ2bGjBx8NLK3qXG1cQU2JBbZWGhIiAS7uTp0RotJYzrbBaqCJbcq2inidOgZP1jjvWO8GgUEQYPNLaY6BA+jB/X/tGUz/78i4WdWnOaQulCUw43xlagHkZ6dI=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB4653.eurprd02.prod.outlook.com (20.178.12.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 10:35:30 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39%3]) with mapi id 15.20.1361.022; Thu, 6 Dec 2018
 10:35:30 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dt-bindings: i2c: use correct vendor prefix for atmel's
 at24 EEPROMs
Thread-Topic: [PATCH] dt-bindings: i2c: use correct vendor prefix for atmel's
 at24 EEPROMs
Thread-Index: AQHUjUh8sEh+YGuiLU+VL8wgfhsF36VxhDyA
Date:   Thu, 6 Dec 2018 10:35:30 +0000
Message-ID: <1007451d-fc3c-fdc6-f814-014673e7f1f4@axentia.se>
References: <20181206094550.18082-1-brgl@bgdev.pl>
In-Reply-To: <20181206094550.18082-1-brgl@bgdev.pl>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR06CA0140.eurprd06.prod.outlook.com
 (2603:10a6:7:16::27) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB4653;6:tiGTrn4NK2Nx8LQuRq+SPneDxsDMe9AA4otEzwk8c8/+mHJNT492AH3HLpGeP/Kw+p5wEHbYd7ggMdIg9WjkM2LJG0R2oD38WOemf0GPc9lmSUuH/2GbapIYUgTmg22UGZmFrmOhZesHHWAzu/MFb2gaUjPGmeU7LAvIjAkOf+8H2n54cNtrZ0LJ+UkdmRAf+gWlQbg97EkbsJucMbMDxyM4sRCW+DKb6B4Wt/LVXb/+s7wkh7BOff09h6j3+7pHiWOdSCfxAa3g51n2lUQq0FuWeepLFZ9ik1yjGXIXr3nuQPAnAxQzmBKc+gw3TJmTCNrsZ7SMPv2y+PrYoNVMJ2S+eBS7xNcXGSGRwxlJrbHgg4XPWAREWZl5DlsvpCIlXFU3T8kZdCHUtOvAmAPusR4HwJXzr6N0FvBtRnsl+OVGQBqoZkmWJtFNUtkVjYw5mJ4wLKV0/CB5u+YzeOpE5w==;5:5sKE1tfF0jkcDgCT72gmpvkUqXPgS5Bu9/gCICYX9uIL5W2KV7skXcDAZ9/Jt4FjzjNdzvwi1s5b70XbaSnC//q+hQFTQXcwdy+SCeRNByCqJqC1B7EuCanyYc/0VerzObjAAvU3y8j8yQ2gfj8aawiyPVvBBlrYR9Lkrw9CFU8=;7:0Z2GepbATF+JqCct5O6aEPLWCHHlRUWtlxD3va6l3gmfXzEGC1OvyOHaPXZM+zBk1KhwSA7SYEaOjCFf6T2QdorjR7izZmXqth/qca87+uh2yNPXF2k0W2KTXuK+TuCm0dR/IPaRR6+HKOg6TjG+RQ==
x-ms-office365-filtering-correlation-id: 103a7cfe-2668-4baa-c418-08d65b668b51
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4653;
x-ms-traffictypediagnostic: VI1PR02MB4653:
x-microsoft-antispam-prvs: <VI1PR02MB4653ECA434D2099F27662C16BCA90@VI1PR02MB4653.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB4653;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB4653;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(97736004)(14454004)(6436002)(31696002)(5660300001)(229853002)(508600001)(6486002)(4326008)(65826007)(476003)(71200400001)(68736007)(86362001)(39060400002)(25786009)(54906003)(6246003)(2616005)(8676002)(71190400001)(58126008)(99286004)(110136005)(2906002)(53936002)(31686004)(11346002)(3846002)(446003)(6512007)(6116002)(256004)(305945005)(7736002)(76176011)(106356001)(386003)(6506007)(53546011)(65956001)(65806001)(66066001)(486006)(81166006)(36756003)(81156014)(52116002)(186003)(8936002)(26005)(102836004)(105586002)(316002)(74482002)(64126003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4653;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Yn+jG3Gk6/jMGBIxQcjD1FFC4vYm6DuyciMxwQLLl4FScytbwrbC3l+TO0qNM8IE00Shw3V26rmr3m+eT4wEOUMyUwclso7jwr6zqolfQVtjkvgpBa3JQDrH5WZNc/beF6AhKW3ZYzhf/M32N9VsBz/9suczrO9pe40WknNs39K+sbsKRkY+zw0LkrVh6/QTqawQWvga0BtpTlNv0bMVfqlN1kguaZ2lcvbc3dLYmjmaI45geNtuSZiK/Diy+mULdQEFC0ax/vmrcCKtA/ks8WYbHovnFaLGDANy/pCDWV4hPWWarYnqOqdyltIe1mtmXeaBeHBfi4iot+YVrDoJca+vY6eUuDvgxhEFXUcEWJI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F27C24BDDB32A04FA22DE18D12612688@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 103a7cfe-2668-4baa-c418-08d65b668b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 10:35:30.4139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4653
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMi0wNiAxMDo0NSwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToNCj4gVGhpcyBp
cyBhIGZvbGxvdy11cCB0byBUaGllcnJ5J3MgcGF0Y2ggd2hpY2ggbWlzc2VkIGEgZmV3IG9jY3Vy
ZW5jZXMuDQo+IA0KPiBDYzogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogQmFydG9zeiBHb2xhc3pld3NraSA8YnJnbEBiZ2Rldi5wbD4N
Cg0KQWNrZWQtYnk6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQoNCldvbGZyYW0sIHlv
dSBjYW4gdGFrZSB0aGlzIG9uZSBhcyB3ZWxsLCBvZiBjb3Vyc2UuDQoNCkNoZWVycywNClBldGVy
DQoNCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1h
dDkxLnR4dCAgICAgICAgfCAyICstDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaTJjL2kyYy1tdXgtbHRjNDMwNi50eHQgfCAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1hdDkxLnR4dCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9pMmMvaTJjLWF0OTEudHh0DQo+IGluZGV4IGVmOTczYTAz
NDNjNy4uYjdjZWMxN2MzZGFmIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaTJjL2kyYy1hdDkxLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1hdDkxLnR4dA0KPiBAQCAtMzMsNyArMzMsNyBAQCBpMmMw
OiBpMmNAZmZmODQwMDAgew0KPiAgCWNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDA+Ow0KPiAgDQo+
ICAJMjRjNTEyQDUwIHsNCj4gLQkJY29tcGF0aWJsZSA9ICIyNGM1MTIiOw0KPiArCQljb21wYXRp
YmxlID0gImF0bWVsLDI0YzUxMiI7DQo+ICAJCXJlZyA9IDwweDUwPjsNCj4gIAkJcGFnZXNpemUg
PSA8MTI4PjsNCj4gIAl9DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaTJjL2kyYy1tdXgtbHRjNDMwNi50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaTJjL2kyYy1tdXgtbHRjNDMwNi50eHQNCj4gaW5kZXggYzY2MWI5MDgzZWM2
Li44YjFlNDljZGNlM2YgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pMmMvaTJjLW11eC1sdGM0MzA2LnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdXgtbHRjNDMwNi50eHQNCj4gQEAgLTU0LDcgKzU0
LDcgQEAgRXhhbXBsZToNCj4gIAkJCXJlZyA9IDwxPjsNCj4gIA0KPiAgCQkJZWVwcm9tQDUwIHsN
Cj4gLQkJCQljb21wYXRpYmxlID0gImF0LDI0YzAyIjsNCj4gKwkJCQljb21wYXRpYmxlID0gImF0
bWVsLDI0YzAyIjsNCj4gIAkJCQlyZWcgPSA8MHg1MD47DQo+ICAJCQl9Ow0KPiAgCQl9Ow0KPiAN
Cg0K
