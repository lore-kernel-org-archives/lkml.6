Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2611E2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="XN8I9nO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfBTLSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:18:44 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:23843 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfBTLSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:18:43 -0500
X-IronPort-AV: E=Sophos;i="5.58,390,1544511600"; 
   d="scan'208";a="26588681"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2019 04:18:42 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 20 Feb 2019 04:18:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byvkFcre1KJiKRQ85NLojpGnoJaKGM3lbXgSPnbP1UA=;
 b=XN8I9nO+wRBPcgAzqDeaAf7idLMyYmZ0TFDQYC6vS22BhMXTv3dYOjdXDQ1Cj5+xI443cHHbl7uOKq1OgCyVnNJKSFBxW+RekGYHlUW6DaUs4P2mgk7sbnCFWZPfwn5EMIeRt5DsbL2ZI8/7rByt7hTXfrqOV5+f9oWoCNB+Exo=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1791.namprd11.prod.outlook.com (10.175.53.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 11:18:40 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Wed, 20 Feb 2019
 11:18:40 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <sboyd@kernel.org>
CC:     <mturquette@baylibre.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Thread-Topic: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Thread-Index: AQHUyQ4DTxM0lGKi0EWSxBvx5w6KNw==
Date:   Wed, 20 Feb 2019 11:18:40 +0000
Message-ID: <23696765-c2c7-0df8-1bfd-2dfd96f65e9d@microchip.com>
References: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::23) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a62901f-6c66-4dfa-8c43-08d697252a82
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1791;
x-ms-traffictypediagnostic: MWHPR11MB1791:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxNzkxOzIzOko0cFNNQkV6Z3hpSFpEbHZEbmowTEQ2c3p4?=
 =?utf-8?B?YkNrZENhSTJqNkVPYXllRTlVbXNtM1hkT0JOUVhXcjFTMFpkYTFhbmR3RFI1?=
 =?utf-8?B?MEsxeFFVR2RmY29ZV3h2ZUcwL1MvNnhOQ2lvMThhajk2aEhuNk1xZFM4MUZI?=
 =?utf-8?B?ZkxUY0VPcXZWL2RsN0JpMmcyblMvVEt2bnRwUkQ5OHZ1NlVzcEliMmtOS1d3?=
 =?utf-8?B?MktEQ1U4NHg5a1lTbE5ndmxTZXBsU29uSDd2UllWU2NVWUcxbWR5WWRtNkJW?=
 =?utf-8?B?WEh0MGRHWXJySW94MC9wQ3BXTlQ4aW5Nd0w4YWhSSGVCaTlCUWRqTDljcElX?=
 =?utf-8?B?YS9QdVJzNlJvNS9nNjd0TWliTVU2ak5WcEErN3FBblFXNVdJZFNLYm5mSytG?=
 =?utf-8?B?Q1JuYncxelBLZlhlcVFHQ0huazZxTkdXQ2VlbVpQYWZaUXArbC82dHBqa1lF?=
 =?utf-8?B?Qm1qL1g1YTNPV0t4Rmhia0tXRXBvNGZ1MWRyRGJrZGp4Z2dKd0s0anpGeFpo?=
 =?utf-8?B?d0RRTXF3bGZFUkt1aWlPcGc1LzAzRnlBdWlNSTNQZnNXTmVGWCtFT0FoNTRU?=
 =?utf-8?B?TnJDOWZRbHJ6TkZZbTVlN0dlNGNyWmVXdVhLUlJOcFdFVXZpUlZ4YXl1aTRm?=
 =?utf-8?B?QWpZNkhnUEkxTlFuVCtDOG9kbEVXcG5WQ3JTMUdtNmFiN1AyTnkxZWNyV1RP?=
 =?utf-8?B?VVl4blk5a0Y2OUF6M1JBRTFrNlBPc241M2pYOXJUeDd4SldmUG9wa2dEUmRJ?=
 =?utf-8?B?YjR5Z2ZuVzVXOExXekdhVnhpQkEzWWlsZjh3UHQ1UG9malROVXNCSVgxUEJ6?=
 =?utf-8?B?MjRJN2NqN256MzJ4ckx1V2V4VHNEQTRWOVIvQUY0aFZPYzMxMWsyRDlUMGpF?=
 =?utf-8?B?cW5LcnBPVjJoVUdnMk1mWXRreUo3NzR0SWdDNWhzTlRIMjlJRHZpZnRSUFFa?=
 =?utf-8?B?K3YwQU1SZWlLQkRVRkdXK1oxU1NvaFV6TWJHN3c5SFZ2YmNwVTVldnpmbXYx?=
 =?utf-8?B?NGRrQ0x5d3BGN01oYjd4a1RIc1BXdTVEVUVwYnBCNmxBRmg5amo2NEdpS0sr?=
 =?utf-8?B?dGdkL08vNlZqcGJ5a0w4MDh4MzlzYjcraUJmNWp5WUhKdEEzSVJJdFYweCtS?=
 =?utf-8?B?ZVpqRS9qcWhLS2ZiZE84VXl6bkthdmQwc3U4eVBZd29aNUJYSXBLT3hoRTA0?=
 =?utf-8?B?ak9TdGNDR3ZiVzc0THlJNmhyOEFzbzFDVWFmbFNNb0hhT1c1V0xFWnc0NWRo?=
 =?utf-8?B?ME93b2RNbUtzVVROekk2TnRPdmdnMlAwUDhqQ0FnL0ROMStUbzQ1VFNsS1pz?=
 =?utf-8?B?ajIzMmN3Q3BVWVlCMzVFS2o3Q0dVWXRvOERSREZGSWcyNXpYTGVPTktWOVpT?=
 =?utf-8?B?MTBlVVRUR1BrVUZQcUVEWE5BbzMwM0wrK0lSVWEwOFNEVktxdTgvTUZEbEND?=
 =?utf-8?B?S0lhY0Vza2NDNndJaGxwT0JZdEZJYk5rWFpOZVhUajBvMTJSN2lmR3NQM0Ra?=
 =?utf-8?B?QS84ZmNCVXNlUDRjbnF1eERRT0ZOS0hYcHhnVVRjUmczN05QUnM5Z01DdFMr?=
 =?utf-8?B?RVE3K0wzYjZoUGI2V2Q1MzVIaTg5eTA0MWVYTnUyVmtGb1dwaUdvU1gzSnJX?=
 =?utf-8?B?TkNJaFRTaFp5TDlrSVY2QURESUlkeWFwWVpRbG1GNTdXaHorNEloMlpmMzNP?=
 =?utf-8?B?MlFaZUJSZldpdEpTUG5xZEhpaERLbFZKajFKNUs4V2sxd2pnWDZrWFdIS2dU?=
 =?utf-8?B?cm5aakgyZ25VZUFMRm5SUT09?=
x-microsoft-antispam-prvs: <MWHPR11MB1791F8A2BBF85FC644A09C51E07D0@MWHPR11MB1791.namprd11.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(68736007)(54906003)(305945005)(4326008)(486006)(7736002)(229853002)(478600001)(72206003)(71200400001)(71190400001)(110136005)(2616005)(5660300002)(316002)(25786009)(6486002)(14454004)(476003)(446003)(66066001)(11346002)(6116002)(105586002)(3846002)(6506007)(8676002)(106356001)(6436002)(102836004)(81156014)(8936002)(386003)(53546011)(31686004)(26005)(256004)(52116002)(36756003)(76176011)(6512007)(186003)(86362001)(31696002)(97736004)(99286004)(53936002)(6246003)(2906002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1791;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qNQSH0SV4+Xd/wxC3ixOQbqEuPDIn35XhAQ63XmJzCbzIYFzTFuzHZvytR/xPa8Ad5mDCR43HGH7zNLDEu9uKzSdEJz84plNYMfWUArNugmnZ9woWT0C+30KRxx/LNiX32vooMgxltSqYDstJi0KgAg++OPjSidECqZ6r0N+SbE1ay+tzMdmUoN7vJ9UMcxGwkKflCkAOOBPjPtonnEfXR/oGun0EA3YcJRlL4wxLTMmJsxXUXTvj0CguWXHFG/IvuPKbu0upmWWxDW37vVfxyNvMpTQuasaNAapPQnmU+f6ofcvw9wCfAPb1PE/4RJXIK/Bvr/DcgKmASn4DY+2AcDV8oSKzdUfpw7adztWqfqiVqoTxjLCgvtpMXqoScaBv6cWP8dXXrdWbRbU09D84WqsqEGFVjJZd2k+qxGZi1Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFF07D1261CF2D439D477F49CC1ADBD1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a62901f-6c66-4dfa-8c43-08d697252a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:18:38.5922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1791
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDIvMjAxOSBhdCAxNzo1MSwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IG5jaygp
IGxvb2tzIGF0IHRoZSBsYXN0IGlkIGluIGFuIGFycmF5IGFuZCB1bmZvcnR1bmF0ZWx5LA0KPiBh
dDkxc2FtOXgzNV9wZXJpcGhjayBoYXMgYSBzZW50aW5lbCwgaGVuY2UgdGhlIGlkIGlzIDAgYW5k
IHRoZSBjYWxjdWxhdGVkDQo+IG51bWJlciBvZiBwZXJpcGhlcmFsIGNsb2NrcyBpcyAxIGluc3Rl
YWQgb2YgYSBtYXhpbXVtIG9mIDMxLg0KPiANCj4gRml4ZXM6IDFlYWJkYzJmOWRkOCAoImNsazog
YXQ5MTogYWRkIGF0OTFzYW05eDUgUE1DcyBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQoNCkFja2VkLWJ5
OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQpDYzogPHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmc+ICMgdjQuMjArDQoNCkl0IHdvdWxkIGJlIG5pY2UgdG8gcXVldWUg
aXQgYXMgYSBmaXggdGhlIHNvb25lc3QsIGFzIGl0IGltcGFjdHMgNS4wIGJ1dCANCm5vdCA0LjIw
IGR1ZSB0byBhIHN3aXRjaCBmcm9tIG9uZSBEVCBiaW5kaW5nIHRvIGFub3RoZXIgKHJlYWQ6IGEg
cmVhbCANCnJlZ3Jlc3Npb24pLi4uIEJ1dCBJIGtub3cgaXQncyBhIGJpdCBsYXRlIGluIHRoZSBj
eWNsZS4uLg0KDQpSZWdhcmRzLA0KICAgTmljb2xhcw0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvY2xr
L2F0OTEvYXQ5MXNhbTl4NS5jIHwgMyArLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvYXQ5
MS9hdDkxc2FtOXg1LmMgYi9kcml2ZXJzL2Nsay9hdDkxL2F0OTFzYW05eDUuYw0KPiBpbmRleCAy
ZmUyMjVhNjk3ZGYuLmQzN2U3ZWQ5ZWI5MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5
MS9hdDkxc2FtOXg1LmMNCj4gKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9hdDkxc2FtOXg1LmMNCj4g
QEAgLTE0NCw4ICsxNDQsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgYXQ5MXNhbTl4NV9wbWNfc2V0
dXAoc3RydWN0IGRldmljZV9ub2RlICpucCwNCj4gICAJCXJldHVybjsNCj4gICANCj4gICAJYXQ5
MXNhbTl4NV9wbWMgPSBwbWNfZGF0YV9hbGxvY2F0ZShQTUNfTUFJTiArIDEsDQo+IC0JCQkJCSAg
IG5jayhhdDkxc2FtOXg1X3N5c3RlbWNrKSwNCj4gLQkJCQkJICAgbmNrKGF0OTFzYW05eDM1X3Bl
cmlwaGNrKSwgMCk7DQo+ICsJCQkJCSAgIG5jayhhdDkxc2FtOXg1X3N5c3RlbWNrKSwgMzEsIDAp
Ow0KPiAgIAlpZiAoIWF0OTFzYW05eDVfcG1jKQ0KPiAgIAkJcmV0dXJuOw0KPiAgIA0KPiANCg0K
DQotLSANCk5pY29sYXMgRmVycmUNCg==
