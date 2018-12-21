Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4A8218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZGzyc+Ja";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bts3sYoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403874AbeLUXDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:03:24 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:58701 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387417AbeLUXDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1545433404; x=1576969404;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L4GaNSiAqepeWAiidtuIP/AMYmLx0NbaCw2C3NLRUis=;
  b=ZGzyc+JaaIXKO0oxYMiOwMtXH99xCXZo4N4JJh+2cnwXrjSjdn/6+ZAN
   DHf/ekKF9ZzTVEIqztOiEdLgHGijozht5Gn4UUGTuIZ1A0vCA/K7UP8xW
   15EP9cRhBD7VTmzZDmOSeukCJt+cZxDnZSlLc76rZB4DQYdbhnbjqEw8/
   2SmciohTyCyH2JZ+RriTIE/aRyRgzo7MnjJUB4BABUq6L7hQJnBoTlnBJ
   dPmjGCy3YpZuEwXojuvICNDT8YAdA5KEu90CjG8BCYMk/uP7rq7fO70NP
   VVGGWfPJQMXjZh1kwys7CjgNr3byv+P8aPMV0xrblxC3ZdN5t87DcKShX
   w==;
X-IronPort-AV: E=Sophos;i="5.56,383,1539619200"; 
   d="scan'208";a="97212977"
Received: from mail-by2nam05lp2051.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.51])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2018 07:03:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4GaNSiAqepeWAiidtuIP/AMYmLx0NbaCw2C3NLRUis=;
 b=bts3sYoEBtCC/KSHzp8LYAkq7C8Y/q2+8MccTpuq6YS8PujkCYeJOh3omurOVY7IeBOMqlQ0MOG8lF44ugYH8+HeotqiMtzARQn3phlGZYYfkBdceu7Y3uAJiPvUoZYejYkDqy91cuJiqdI1VJBPK+JbLurcFee0z2IyMADhVTA=
Received: from MWHPR04MB0401.namprd04.prod.outlook.com (10.173.48.18) by
 MWHPR04MB1086.namprd04.prod.outlook.com (10.174.250.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Fri, 21 Dec 2018 23:03:22 +0000
Received: from MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::9067:fb44:66b2:7604]) by MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::9067:fb44:66b2:7604%4]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 23:03:21 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Topic: [PATCH] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Index: AQHUmWBEawqGhX/hUk+WG09gQflaXKWJj9CAgAACgwCAAAFkgIAALeOAgAAGQICAAAggAA==
Date:   Fri, 21 Dec 2018 23:03:21 +0000
Message-ID: <ac8f991f5c3e0b5de8dea6b187e1daca198b4677.camel@wdc.com>
References: <20181221190615.19003-1-alistair.francis@wdc.com>
          <alpine.DEB.2.21.9999.1812211110260.777@viisi.sifive.com>
          <541e8b85bc2d3010741daadddc71ada52b847b8f.camel@wdc.com>
          <alpine.DEB.2.21.9999.1812211124180.777@viisi.sifive.com>
         <c51c125f40a12a3afdd8272bbbf0670673a15349.camel@wdc.com>
         <alpine.DEB.2.21.9999.1812211433290.777@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1812211433290.777@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1086;6:TSQvRCbpJd1DRhwbL2sMlpMNJhV+3lGIYxCw4/TCPzlQO4om+BpOT/qaZQeSI12TOB66bVpHu7xD89XhxwvZ29tn9teyPdCedigY2A2beXjk9Ak0U2ARlPh1HP3GOfVCVnOOk5L5xAVywqrhG0wd1OLZbPWD/W/DWzSvYMUnulb3ViHaPMoPPqgCpdl/5VNSuYiXBMu7n2jKclH5BSitRiDtPKy45OTXGLL+OkCIEuKENkU3x90hY0tBmqLEkWw5lums3D64emVn+2lCm+STOQX8jTgwzJZL72t5FCa5sqt7UKA6jwNeva7OeCdR1q1ynOPfZdj2YoOXJjbURbMMl4AkguR2a4qn5A04Vbyo7YWsiLRmjenTm1B+c2gxWCO5HdTZaiMnNsYmj2vrWkhX6dw4NMUFSlgrrMSgL2uJ+beKOMR9mSq0+qXtNszzS0W5QMp1awQ9RSt95VFZ/UrESQ==;5:lwF43SfwLCn2EsWZSX/VTz2MFF3Z/89o03UYILSw7T/7q8PRJlZY6t4udJokORLGX+88l6YhaKb/C20KLNNho7jN6i3kGzZ66Ji+m0Pjw0jGol5fSjvdDk9xgczqwiPRk/G9ZS6PVtRhZMVsA2k1GLGBQcHSM4mshTP7dlAnTt8=;7:4ND4RZIEy3a388JmJepF9S208Hh8kcn0cM0NIZQIKQR1B8WMzDKdFhthHdYQS2xyyGa4+zka8QJYhAV8gGq9Ib//OIQpCbfx4kVBUu1Ha8i9uQwEXIJkMneF1TnevqXgebOkWhyeDw4tntc0ql0eWw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0d880e5f-2fd8-4efd-e30d-08d667988132
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1086;
x-ms-traffictypediagnostic: MWHPR04MB1086:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1086D959058A589AE21E28A090B80@MWHPR04MB1086.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR04MB1086;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1086;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(376002)(366004)(396003)(199004)(189003)(6306002)(6512007)(476003)(446003)(2616005)(36756003)(4001150100001)(106356001)(11346002)(99286004)(68736007)(105586002)(97736004)(5640700003)(4326008)(102836004)(6916009)(26005)(93886005)(2351001)(186003)(54906003)(316002)(25786009)(6486002)(229853002)(7736002)(8676002)(305945005)(256004)(2906002)(72206003)(6436002)(5660300001)(966005)(66066001)(14454004)(86362001)(76176011)(6246003)(6506007)(71190400001)(71200400001)(6116002)(478600001)(2501003)(53936002)(118296001)(81156014)(486006)(8936002)(3846002)(81166006)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1086;H:MWHPR04MB0401.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: u4AtUuaHBF2spM3ueksxKNCsv0Pwnl1MC87uzgJ3aYjo/JAs61GIvIcnBbFymiqN1UKGTajdM/P5cECJ7oL4um371kJRzkINTl64/rFHn9rrxeGhHVCysq1mJI85SuGgR9ymoOlUeYyfDva0Ttn4kTk7r8wKJ5SyYnK/TCxq9yyHPrAMLTu9s7DsJBhJhJUCCLQP65lNe5eXPc6mmtvhMPJ2vEgvWiOYCT0MZsYht4Oz+8WxSO1OeyCNeuJPSTv9DfCQxCtBlFuoNRN9WasJ9drVUnVax0rQcCwrbbj/yFcTckQm38KQZWSelDHHaa0I
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <877AA9BEA49D204EA179EFED18063BFD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d880e5f-2fd8-4efd-e30d-08d667988132
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 23:03:21.8658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEyLTIxIGF0IDE0OjM0IC0wODAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiANCj4gT24gRnJpLCAyMSBEZWMgMjAxOCwgQWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4gDQo+
ID4gT24gRnJpLCAyMDE4LTEyLTIxIGF0IDExOjI3IC0wODAwLCBQYXVsIFdhbG1zbGV5IHdyb3Rl
Og0KPiA+ID4gT24gRnJpLCAyMSBEZWMgMjAxOCwgQWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4g
PiA+IA0KPiA+ID4gPiBXaGVuIHRoZSBNaWNyb1NlbWkgZHJpdmVyIGRvZXMgZXZlbnR1YWxseSBn
byB1cHN0cmVhbSB0aGlzIHdpbGwNCj4gPiA+ID4gcHJvYmFibHkgaGF2ZSB0byBiZSBkaXNjdXNz
ZWQgdGhvdWdoIGFzIGVpdGhlciB0aGUgY29uZmlnIG9yDQo+ID4gPiA+IGRldmljZQ0KPiA+ID4g
PiB0cmVlIHdpbGwgbmVlZCB0byBiZSBlZGl0ZWQgdG8gZW5zdXJlIG9ubHkgb25lIFBDSWUgZGV2
aWNlIGlzDQo+ID4gPiA+IHByZXNlbnQuDQo+ID4gPiANCj4gPiA+IFRoZSByaWdodCB3YXkgdG8g
ZG8gdGhhdCBpcyB0byBoYXZlIHR3byBzZXBhcmF0ZSBEVCBmaWxlczogb25lDQo+ID4gPiBmb3Ig
dGhlIA0KPiA+ID4gSGlGaXZlLVUgYm9hcmQgYWxvbmU7IHRoZSBvdGhlciBmb3IgdGhlIEhpRml2
ZS1VIHBsdXMgdGhlDQo+ID4gPiBleHBhbnNpb24gDQo+ID4gPiBib2FyZCBjb21iby4gIFRoZXJl
IHNob3VsZG4ndCBiZSBhbnkgcHJvYmxlbXMgd2l0aCBrZWVwaW5nIGJvdGggDQo+ID4gPiBkcml2
ZXJzIGVuYWJsZWQgaW4gdGhlIGRlZmNvbmZpZy4NCj4gPiANCj4gPiBBZ3JlZWQsIHRoZSBvbmx5
IHByb2JsZW0gaXMgdGhhdCB0aGUgZGV2aWNlIHRyZWUgY29tZXMgZnJvbSB0aGUNCj4gPiBib2Fy
ZHMNCj4gPiBmaXJtd2FyZSBhdCB0aGUgbW9tZW50Lg0KPiANCj4gVGhlIHN3aXRjaG92ZXIgaXMg
aW4gcHJvZ3Jlc3M6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi80
MWRhYzdhMS0zZjY2LTZhM2YtOGE2OC0yMDY2ODhlNWJkOWVAc2lmaXZlLmNvbS9ULyN0DQoNCkdy
ZWF0ISBJIGRpZG4ndCBrbm93IGl0IHdhcyBpbiBwcm9ncmVzcy4NCg0KQWxpc3RhaXINCg0KPiAN
Cj4gDQo+IC0gUGF1bA0KPiANCg==
