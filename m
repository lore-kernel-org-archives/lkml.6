Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F071ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2106D214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Moxa.onmicrosoft.com header.i=@Moxa.onmicrosoft.com header.b="Qk0t1I7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2106D214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeIQNFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:05:15 -0400
Received: from mail-pu1apc01on0088.outbound.protection.outlook.com ([104.47.126.88]:46281
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727010AbeIQNFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Moxa.onmicrosoft.com;
 s=selector1-moxa-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C2cEbeOk5mmh6bC8EVbAPFR5gxrkghPHxrf/rmCWYs=;
 b=Qk0t1I7FRcgf7fx/LZf6I4hEXR/UbTnnOSCJ/n8IIv/1vkjT1ByQ7EdNeLIOHq0SCcQ9pIeHqzDEuaQ+d0xcIybcM0SGu/UsL/g6xbnJO7u068JMYhEX0WTxwMSZqu8UiMzqvTpIypl2BUXnD6G1fpxOZYCKyNGoRMWven925I4=
Received: from TY2PR0101MB2526.apcprd01.prod.exchangelabs.com (20.177.77.204)
 by TY2PR0101MB2560.apcprd01.prod.exchangelabs.com (20.177.150.16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 07:38:58 +0000
Received: from TY2PR0101MB2526.apcprd01.prod.exchangelabs.com
 ([fe80::e8ef:5578:5339:84ee]) by
 TY2PR0101MB2526.apcprd01.prod.exchangelabs.com
 ([fe80::e8ef:5578:5339:84ee%2]) with mapi id 15.20.1101.023; Mon, 17 Sep 2018
 07:38:57 +0000
From:   =?utf-8?B?U1ogTGluICjmnpfkuIrmmbop?= <SZ.Lin@moxa.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        =?utf-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>,
        =?utf-8?B?V2VzIEh1YW5nICjpu4Pmt7XmsrMp?= <Wes.Huang@moxa.com>,
        =?utf-8?B?RmVybyBKRCBaaG91ICjlkajkv4rpgZQp?= <FeroJD.Zhou@moxa.com>
Subject: RE: [PATCH 3/3] ARM: dts: am335x: add support for Moxa UC-2102 open
 platform
Thread-Topic: [PATCH 3/3] ARM: dts: am335x: add support for Moxa UC-2102 open
 platform
Thread-Index: AQHURFRgRbUN5UFqyE6OQAn+TXr1kaT0Jttw
Date:   Mon, 17 Sep 2018 07:38:57 +0000
Message-ID: <TY2PR0101MB252677F596F874B9CA11EE34E21E0@TY2PR0101MB2526.apcprd01.prod.exchangelabs.com>
References: <20180830040929.23357-1-sz.lin@moxa.com>
 <20180830040929.23357-4-sz.lin@moxa.com>
 <5b8e8a68.1c69fb81.6eb62.cefe@mx.google.com>
In-Reply-To: <5b8e8a68.1c69fb81.6eb62.cefe@mx.google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=SZ.Lin@moxa.com; 
x-originating-ip: [122.146.92.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR0101MB2560;6:k+e/x3GMddf+ST3kLtMYeOGz26xgN3umdtBNgrdXfBZ3J/wvVnEqKdXXpYpPZQvRfhZzvTsBsSaoGsxNlEg4cxCW+EE6lQxURy43z3Pmrv2v/VibgWQHQP8Vmx1bv6aXEFC6K6x/su6Jonj1oVhz9Q+bA9ILkJbItQVVdVfz8ylJ76phWdYxtmlxXGSw7NXICZyQKJG8jJjVAxFPa9tNiZ5E9ZmGPCEqau1oDwHv30lsZbfqhX4kSSU3FBKKrTxSuslZ7XFsM7HKMPRog3m3HL//f1A/XpM23ZZtNJrYmK6MGKTBC7f2QZqPwQmgwyFgxs9uTIP67Fd3HOHM1ZAik1NEaWxm2ZgQmg7noo9IuNtRkVL2V7/wxrRaUJ14GBTc/nYs/ICRxwEP18HDsSKCtHhWz4iSQjgbUhrKqhtFnZ+uszhFAynyJXIDXjxhPXl+7xQYz503c6z12j1WbEViOA==;5:8IIlHKfIDRkj2xE6Bx7A13dnrNVzGPNWIw+3ZUz20KhldawlCZ6LYUB61tQGi8b2CqqeKDh6zRLp5+YHRg22t5K3yK0+1rG6zcZuD2oZDYID91W2yGyC9YnqOoJw0o+f3HKOmSaG/CYjJQEtKxLWAvbB8THC4boXoOiBGGlggms=;7:gyXT9QvtWaXhFomN9tGHy/WCJWuDlqVzXF6IB+a1EiXCa28hgHT0MAfmQtQNG9eUMzs84VAwsxnWFK37ISxlZVOx5s8FsXMpdoUunnmnWPWF+vDgZV9ToU1IkD0joSA5/jg8N7TILY/JkbPg6ejTl+npdUU4GHnTb6WJCMG9hS2ro5dy6uqVaWKAACpXL8WSEbDM0GXPFnKn5D82mzwNPIDKNXyFYIKulL1xecPcCbKqPkEffsmMEslr6AFMGWZJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(189003)(199004)(8936002)(4326008)(9686003)(55016002)(107886003)(6246003)(14454004)(97736004)(5660300001)(81166006)(81156014)(53936002)(6116002)(3846002)(6436002)(68736007)(106356001)(256004)(66066001)(25786009)(229853002)(33656002)(8676002)(5250100002)(105586002)(7696005)(2900100001)(2906002)(6916009)(76176011)(305945005)(99286004)(86362001)(74316002)(186003)(316002)(85182001)(478600001)(54906003)(26005)(476003)(446003)(486006)(6506007)(72206003)(7736002)(11346002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:TY2PR0101MB2560;H:TY2PR0101MB2526.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: e7d61fe7-46c4-40eb-56a8-08d61c70a065
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:TY2PR0101MB2560;
x-ms-traffictypediagnostic: TY2PR0101MB2560:
x-microsoft-antispam-prvs: <TY2PR0101MB2560355DEBB1A01A4BF6D134E21E0@TY2PR0101MB2560.apcprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:TY2PR0101MB2560;BCL:0;PCL:0;RULEID:;SRVR:TY2PR0101MB2560;
x-forefront-prvs: 0798146F16
received-spf: None (protection.outlook.com: moxa.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PbuwlAI1X99Q/pv4QK3Fn4DybUZ1gPI2/cLUY28415FPXBcwpYjQdjV559ul5JYtwXbqBg8bmvnNrTWJcUvfJrUnpIzlBxR5M8vhgiupOYKbikmtUVXdT3/QEmAavqesOxQJa6w3F6FhV2IkjhaxzD1rOg6jrpMM1FoZ2/c5bymHEF6iE1aAXA9kg/f/tAF1gtouT57nPXRrPKs0iJJJBWVfd2Dp03ueA2g1wcvz/hQOrkm2RkPTkwfdyv1ORP+YsfMQviRM9hl7bHRZZGFxFjguxyWgmrVXvtZja97N3Sgif8lUKOdVImTmPsdXrZmx8Q7pCxU3C6Kn+HN2XUhV5OpLCVXWk+D5IWfRGj9nEqU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d61fe7-46c4-40eb-56a8-08d61c70a065
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 07:38:57.0695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR0101MB2560
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCjxzbmlwPg0KIA0KPiBUaGUgMjEwMiBpcyBhIHN1cGVyc2V0IG9mIHRoZSAyMTAxPyBJ
ZiBzbywgdGhlIDIxMDIgc2hvdWxkIGNvbWUgZmlyc3QuDQo+IElmIG5vdCwgdGhpcyBzaG91bGQg
cHJvYmFibHkgYmUgMiBzZXBhcmF0ZSBlbnRyaWVzLg0KPiANCg0KTm9wZSwgdGhleSB1c2UgZGlm
ZmVyZW50IFNvQyBtb2RlbHMgYW5kIFBNSUNzLiBJJ2xsIHJlc2VuZCB0aGVtIHNlcGFyYXRlbHkg
aW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MgZm9yIGd1aWRhbmNlLg0KDQo+ID4gKyZ0cHMgew0K
PiA+ICsJdmNjMS1zdXBwbHkgPSA8JnZiYXQ+Ow0KPiA+ICsJdmNjMi1zdXBwbHkgPSA8JnZiYXQ+
Ow0KPiA+ICsJdmNjMy1zdXBwbHkgPSA8JnZiYXQ+Ow0KPiA+ICsJdmNjNC1zdXBwbHkgPSA8JnZi
YXQ+Ow0KPiA+ICsJdmNjNS1zdXBwbHkgPSA8JnZiYXQ+Ow0KPiA+ICsJdmNjNi1zdXBwbHkgPSA8
JnZiYXQ+Ow0KPiA+ICsJdmNjNy1zdXBwbHkgPSA8JnZiYXQ+Ow0KPiA+ICsJdmNjaW8tc3VwcGx5
ID0gPCZ2YmF0PjsNCj4gPiArDQo+ID4gKwlyZWd1bGF0b3JzIHsNCj4gPiArCQl2cnRjX3JlZzog
cmVndWxhdG9yQDAgew0KPiANCj4gV2l0aG91dCBhIHJlZyBwcm9wZXJ0eSwgeW91IHNob3VsZG4n
dCBoYXZlIHVuaXQgYWRkcmVzc2VzLg0KDQpJIHdvdWxkIGxpa2UgdG8gYXNrIHdoeSBzaG91bGRu
J3Qgd2Uga2VlcCB1bml0IGFkZHJlc3Mgd2l0aCAicmVndWxhdG9yLWFsd2F5cy1vbjsiIHJlZyBw
cm9wZXJ0eT8NCg0KU1oNCg0KPiANCj4gDQo+ID4gKwkJCXJlZ3VsYXRvci1hbHdheXMtb247DQo+
ID4gKwkJfTsNCj4gPiArDQo+ID4gKwkJdmlvX3JlZzogcmVndWxhdG9yQDEgew0KPiA+ICsJCQly
ZWd1bGF0b3ItYWx3YXlzLW9uOw0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCXZkZDFfcmVnOiBy
ZWd1bGF0b3JAMiB7DQo+ID4gKwkJCS8qIFZERF9NUFUgdm9sdGFnZSBsaW1pdHMgMC45NVYgLSAx
LjI2ViB3aXRoICsvLTQlIHRvbGVyYW5jZSAqLw0KPiA+ICsJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2
ZGRfbXB1IjsNCj4gPiArCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8OTEyNTAwPjsNCj4g
PiArCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTM3ODAwMD47DQo+ID4gKwkJCXJlZ3Vs
YXRvci1ib290LW9uOw0KPiA+ICsJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KPiA+ICsJCX07DQo+
ID4gKw0KPiA+ICsJCXZkZDJfcmVnOiByZWd1bGF0b3JAMyB7DQo+ID4gKwkJCS8qIFZERF9DT1JF
IHZvbHRhZ2UgbGltaXRzIDAuOTVWIC0gMS4xViB3aXRoICsvLTQlIHRvbGVyYW5jZSAqLw0KPiA+
ICsJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2ZGRfY29yZSI7DQo+ID4gKwkJCXJlZ3VsYXRvci1taW4t
bWljcm92b2x0ID0gPDkxMjUwMD47DQo+ID4gKwkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0g
PDExNTAwMDA+Ow0KPiA+ICsJCQlyZWd1bGF0b3ItYm9vdC1vbjsNCj4gPiArCQkJcmVndWxhdG9y
LWFsd2F5cy1vbjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiArCQl2ZGQzX3JlZzogcmVndWxhdG9y
QDQgew0KPiA+ICsJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KPiA+ICsJCX07DQo+ID4gKw0KPiA+
ICsJCXZkaWcxX3JlZzogcmVndWxhdG9yQDUgew0KPiA+ICsJCQlyZWd1bGF0b3ItYWx3YXlzLW9u
Ow0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCXZkaWcyX3JlZzogcmVndWxhdG9yQDYgew0KPiA+
ICsJCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KPiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCXZwbGxf
cmVnOiByZWd1bGF0b3JANyB7DQo+ID4gKwkJCXJlZ3VsYXRvci1hbHdheXMtb247DQo+ID4gKwkJ
fTsNCj4gPiArDQo+ID4gKwkJdmRhY19yZWc6IHJlZ3VsYXRvckA4IHsNCj4gPiArCQkJcmVndWxh
dG9yLWFsd2F5cy1vbjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiArCQl2YXV4MV9yZWc6IHJlZ3Vs
YXRvckA5IHsNCj4gPiArCQkJcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4gPiArCQl9Ow0KPiA+ICsN
Cj4gPiArCQl2YXV4Ml9yZWc6IHJlZ3VsYXRvckAxMCB7DQo+ID4gKwkJCXJlZ3VsYXRvci1hbHdh
eXMtb247DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4gKwkJdmF1eDMzX3JlZzogcmVndWxhdG9yQDEx
IHsNCj4gPiArCQkJcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiAr
CQl2bW1jX3JlZzogcmVndWxhdG9yQDEyIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJyZWd1bGF0
b3ItZml4ZWQiOw0KPiA+ICsJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2bW1jX3JlZyI7DQo+ID4gKwkJ
CXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiA+ICsJCQlyZWd1bGF0b3It
bWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gPiArCQkJcmVndWxhdG9yLWFsd2F5cy1vbjsN
Cj4gPiArCQl9Ow0KPiA+ICsJfTsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZtYWMgew0KPiA+ICsJ
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiArCXBpbmN0cmwtMCA9IDwmY3Bzd19kZWZh
dWx0PjsNCj4gPiArCWR1YWxfZW1hYyA9IDwxPjsNCj4gPiArCXN0YXR1cyA9ICJva2F5IjsNCj4g
PiArfTsNCj4gPiArDQo+ID4gKyZjcHN3X2VtYWMwIHsNCj4gPiArCXN0YXR1cyA9ICJva2F5IjsN
Cj4gPiArCXBoeV9pZCA9IDwmZGF2aW5jaV9tZGlvPiwgPDB4ND47DQo+ID4gKwlwaHktbW9kZSA9
ICJybWlpIjsNCj4gPiArCWR1YWxfZW1hY19yZXNfdmxhbiA9IDwxPjsNCj4gPiArfTsNCj4gPiAr
DQo+ID4gKyZjcHN3X2VtYWMxIHsNCj4gPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gPiArCXBoeV9p
ZCA9IDwmZGF2aW5jaV9tZGlvPiwgPDB4NT47DQo+ID4gKwlwaHktbW9kZSA9ICJybWlpIjsNCj4g
PiArCWR1YWxfZW1hY19yZXNfdmxhbiA9IDwyPjsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZtbWMx
IHsNCj4gPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gKwl2bW1jLXN1cHBseSA9
IDwmdm1tY3NkX2ZpeGVkPjsNCj4gPiArCWJ1cy13aWR0aCA9IDw0PjsNCj4gPiArCXBpbmN0cmwt
MCA9IDwmbW1jMF9waW5zX2RlZmF1bHQ+Ow0KPiA+ICsJY2QtZ3Bpb3MgPSA8JmdwaW8zIDE0IEdQ
SU9fQUNUSVZFX0hJR0g+Ow0KPiA+ICsJd3AtZ3Bpb3MgPSA8JmdwaW8zIDE4IEdQSU9fQUNUSVZF
X0hJR0g+Ow0KPiA+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+IC0tDQo+ID4gMi4x
OS4wLnJjMQ0KPiA+DQoNCg==
