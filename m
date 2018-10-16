Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22B6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E58F208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Rg3ckzsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E58F208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJPVVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:21:07 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:36071 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPVVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:21:06 -0400
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="18895723"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Oct 2018 06:30:28 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 16 Oct 2018 06:30:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmXUdeHGPsuJN/i1sh2ihnf7CYL9T3Rcrr9PWO97qfA=;
 b=Rg3ckzsBYCoZ9DOh4PwH4SnQEjwCfN2ZwCCiYsId/btyXT6FS/ZX/hx7fIkMkXCBq6uwl4V9eDMWSviC8KXQ8cqe97WzE4J4mpdL4u4JEni93gdZFiylxty4IQYtwRb5zXpiVF4EgZ5EquePRuc4sxiI4LqYGtKEpIuO6GlICQA=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0519.namprd11.prod.outlook.com (10.163.158.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Tue, 16 Oct 2018 13:30:24 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::2157:35fc:958a:34ff]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::2157:35fc:958a:34ff%6]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 13:30:24 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jonas@orbital-systems.com>, <linux-kernel@vger.kernel.org>
CC:     <sre@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] power: reset: at91-reset: enable I-cache for
 at91sam9260_reset
Thread-Topic: [PATCH] power: reset: at91-reset: enable I-cache for
 at91sam9260_reset
Thread-Index: AQHUZVRe/70fNEEmkkyQnDUBwInNrg==
Date:   Tue, 16 Oct 2018 13:30:24 +0000
Message-ID: <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com>
References: <20181007125815.8392-1-jonas@threetimestwo.org>
In-Reply-To: <20181007125815.8392-1-jonas@threetimestwo.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0055.eurprd09.prod.outlook.com
 (2603:10a6:802:28::23) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0519;6:6zlmIzJ8h0i8P9JGiEtBuVbqucxyGc8QIj+Ddi6i41JDV3WyTHVJn9SbJJZLm4092H71yuuP2I/OHnmhBt1qW4+D98l/MQGckx8kmGm5LY3PNgMYhORRH9FxQmIZd3yRP9zk15K0KoPhsVTZMKFfb/sRPTA/Qwq5+tSSjqlgbloEGBYG++5Sd9nFqWG2nbRcty8oJFD4PXmZn+LSv/6eMGtaew/yZO+fB3nm8eQqV2+Rh7dckWhKVQwuYiuojav/RJAo1t590kUJWc8Z4Qw9VoLHs4IXCZ0oFz6K7cb144NsDTylPB7QgihOaU5gyY/uT/F0NJF4nDEzZ83QnaJ/byjANBB/BCcDVEKJaWjYJ814n173qoep2lcfADG83A+/r+IlM/Jtoc6QyGo8Ga4kRRSwxycBxsrjtN8luYJQOaYzxFaQQYcYRtvf57hiXif3n3oxnHruTl6U58bByoSERA==;5:Ruz/Ws/WA1NLr1Q5pdz0u0gSEUfJtEfOLB2JwVRoxfjeDVDUO2HruPvRiRx1nhOfN81XwXqjYpKjmNE3nBeaP19mf7uM2jJSX6wjUO6oB3rVxmfsrAIY4YWRbozza5AK4fs+AvUObdEpXpfuok6A5/qHhA66zUSDhL0w0MPeXxQ=;7:wdTcJ8EA02f+RMBOFqQ+LDV6dRgyPsRPx7UAVuF6+i/XKRghRCXurt6Mz2PLDBY7XaZROgojbRw7dxDf9eU24zvjA5GatMdJRjRMNBa0jnpX+ddBXI0V0Bi/7nCtPNGmiu5lsZv4QMaVhr6bu/YaCCf1eg9r7ZbmRSCvp5Dk6FxQJKhkOHCfBQan7hOjyyr5j2EFP/2ZGhE2Eynt3X5hCBxLkRfGGzOOk/nd4Oxsfbvz7HJ+0l+AS5fkaIV+Rdfx
x-ms-office365-filtering-correlation-id: 94d86d0b-9a5f-488d-2ec5-08d6336b8697
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0519;
x-ms-traffictypediagnostic: BY2PR11MB0519:
x-microsoft-antispam-prvs: <BY2PR11MB0519DD21960C895E36513C2687FE0@BY2PR11MB0519.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:BY2PR11MB0519;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0519;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(136003)(39860400002)(346002)(189003)(199004)(31696002)(8936002)(86362001)(6512007)(81166006)(106356001)(7736002)(81156014)(6246003)(229853002)(5660300001)(72206003)(31686004)(105586002)(305945005)(6486002)(14454004)(478600001)(25786009)(110136005)(2900100001)(2906002)(68736007)(8676002)(53936002)(3846002)(6436002)(6116002)(54906003)(256004)(186003)(2616005)(476003)(11346002)(36756003)(446003)(486006)(14444005)(99286004)(53546011)(15760500003)(2501003)(26005)(386003)(6506007)(52116002)(76176011)(316002)(71190400001)(5250100002)(66066001)(71200400001)(97736004)(102836004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0519;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mAcY+IuedzMm5IFkLXkVxw5q2mvFDCoHP63K3ma+zuEaNWH+GUPx+MtamlL6Rd5p//Q7BSFUgWIqaphYKuWOy0+xc46X7fAygTTOAdBZvLfMwJNNAFmUklzuFeHh60Qq7rn8vAuEP8t/g2qt3zMu7BmLa8bG42ukg3H+arG+xHXNnlrLM670mDF2u4N3ssMKSb5Nw4+tyPEVtnsoIiIY/rPmZtz4Gn2GH7RFmsIXAafQ5non2uf83v0uK8ZAipQtGWVMfNgMXR6IQF9UhgAsDKTincMmVufqtJOyon6kf6XvSBg3CkER6fOAOTcimd9yzzsVV+zzey927RxQJah5ESJjpMFRIOhnMbd4l73ocm0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1F3A927FB1D134C99D9257FB1D90650@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d86d0b-9a5f-488d-2ec5-08d6336b8697
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 13:30:24.4267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0519
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uYXMsDQoNCk9uIDA3LjEwLjIwMTggMTU6NTcsIEpvbmFzIERhbmllbHNzb24gd3JvdGU6
DQo+IEZyb206IEpvbmFzIERhbmllbHNzb24gPGpvbmFzQG9yYml0YWwtc3lzdGVtcy5jb20+DQo+
IA0KPiBUaGlzIGZpeGVzIGEgYnVnIHdoZXJlIG91ciBlbWJlZGRlZCBzeXN0ZW0gKEFUOTFTQU05
MjYwIGJhc2VkKSB3b3VsZA0KPiBoYW5nIGF0IHJlYm9vdC4gQXQgdGhlIG1vc3Qgd2UgbWFuYWdl
ZCAxNiBib290IGxvb3BzIHdpdGhvdXQgYSBoYW5nLg0KPiANCj4gV2l0aCB0aGlzIHBhdGNoIGFw
cGxpZWQgdGhlIHByb2JsZW0gaGFzIG5vdCBiZWVuIG9ic2VydmVkIGFuZCB0aGUgYm9hcmQNCj4g
aGFzIG1hbmFnZWQgYWJvdmUgMjUwIGJvb3QgbG9vcHMuDQo+IA0KPiBUaGUgQVQ5MVNBTTkyNjAg
ZGF0YXNoZWV0IHRlbGxzIHVzIHRoYXQgd2l0aCB0aGUgaW5zdHJ1Y3Rpb24gY2FjaGUNCj4gZGlz
YWJsZWQgYWxsIGluc3RydWN0aW9ucyBhcmUgZmV0Y2hlZCBmcm9tIFNEUkFNLiBBbmQgd2UgaGF2
ZSBhbiBlcnJhdGENCj4gdGVsbGluZyB1cyB3ZSBtdXN0IHBvd2VyIGRvd24gdGhlIFNEUkFNIGJl
Zm9yZSBpc3N1aW5nIGNwdSByZXNldC4NCj4gDQo+IFRoaXMgbWVhbnMgd2UgbmVlZCB0aGUgaW5z
dHJ1Y3Rpb24gY2FjaGUgZW5hYmxlZCBpbiBhdDkxc2FtOTI2MF9yZXNldCgpDQo+IEF0IHRoZSBt
b21lbnQgaXQgaXMgYmVpbmcgZGlzYWJsZWQgaW4gY3B1X3Byb2NfZmluKCkgd2hpY2ggaXMgY2Fs
bGVkIGZyb20NCj4gYXJjaC9hcm0va2VybmVsL3JlYm9vdC5jLg0KDQpBcmUgeW91IHVzaW5nIGtl
eGVjIHJlYm9vdCBvciBpbXBsZW1lbnRlZCBoaWJlcm5hdGUgbW9kZSBvbiB0aGlzIG1hY2hpbmU/
DQpJJ20gc2VlaW5nIGNwdV9wcm9jX2ZpbigpIGlzIGNhbGxlZCBvbmx5IGluIGNhc2Ugb2Yga2V4
ZWMgcmVib290IG9yDQpzd2l0Y2hpbmcgdG8gaGliZXJuYXRlIG1vZGUuDQoNCkluIGNhc2Ugb2Yg
bm9ybWFsIHJlYm9vdCAoZS5nLiByZWJvb3QgY29tbWFuZCkgbWFjaGluZV9yZXN0YXJ0KCkgZnJv
bQ0KYXJjaC9hcm0va2VybmVsL3JlYm9vdC5jIGlzIGNhbGxlZC4gUGxlYXNlIGNvcnJlY3QgbWUg
aWYgSSdtIHdyb25nLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKb25hcyBEYW5pZWxzc29uIDxqb25hc0BvcmJpdGFsLXN5c3RlbXMuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1yZXNldC5jIHwgMTIgKysrKysrKysr
KystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1yZXNldC5jIGIvZHJp
dmVycy9wb3dlci9yZXNldC9hdDkxLXJlc2V0LmMNCj4gaW5kZXggZjQ0YTlmZmNjMmFiLi43ODk3
MmJiYTY0ZGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1yZXNldC5j
DQo+ICsrKyBiL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1yZXNldC5jDQo+IEBAIC01MCwxNCAr
NTAsMjQgQEAgc3RhdGljIHZvaWQgX19pb21lbSAqYXQ5MV9yYW1jX2Jhc2VbMl0sICphdDkxX3Jz
dGNfYmFzZTsNCj4gIHN0YXRpYyBzdHJ1Y3QgY2xrICpzY2xrOw0KPiAgDQo+ICAvKg0KPiAtKiB1
bmxlc3MgdGhlIFNEUkFNIGlzIGNsZWFubHkgc2h1dGRvd24gYmVmb3JlIHdlIGhpdCB0aGUNCj4g
KyogRXJyYXRhIDQzLjEuNy4xIFJTVEM6IFJlc2V0IGR1cmluZyBTRFJBTSBBY2Nlc3Nlcw0KPiAr
Kg0KPiArKiBVbmxlc3MgdGhlIFNEUkFNIGlzIGNsZWFubHkgc2h1dGRvd24gYmVmb3JlIHdlIGhp
dCB0aGUNCj4gICogcmVzZXQgcmVnaXN0ZXIgaXQgY2FuIGJlIGxlZnQgZHJpdmluZyB0aGUgZGF0
YSBidXMgYW5kDQo+ICAqIGtpbGxpbmcgdGhlIGNoYW5jZSBvZiBhIHN1YnNlcXVlbnQgYm9vdCBm
cm9tIE5BTkQNCj4gKyoNCj4gKyogU2luY2Ugd2UgYXJlIGRpc2FibGluZyBTRFJBTSBuZWVkIHRv
IG1ha2Ugc3VyZSB0aGF0IHRoZQ0KPiArKiBpbnN0cnVjdGlvbiBjYWNoZSBpcyBlbmFibGVkLg0K
PiAgKi8NCj4gIHN0YXRpYyBpbnQgYXQ5MXNhbTkyNjBfcmVzdGFydChzdHJ1Y3Qgbm90aWZpZXJf
YmxvY2sgKnRoaXMsIHVuc2lnbmVkIGxvbmcgbW9kZSwNCj4gIAkJCSAgICAgICB2b2lkICpjbWQp
DQo+ICB7DQo+ICAJYXNtIHZvbGF0aWxlKA0KPiArCQkvKiBFbmFibGUgSS1jYWNoZSAqLw0KPiAr
CQkibXJjCXAxNSwgMCwgcjAsIGMxLCBjMCwgMFxuXHQiDQo+ICsJCSJvcnIJcjAsIHIwLCAjNDA5
NlxuXHQiIC8qIENSX0kgKGJpdCAxMikgKi8NCj4gKwkJIm1jcglwMTUsIDAsIHIwLCBjMSwgYzAs
IDBcblx0Ig0KPiArDQo+ICAJCS8qIEFsaWduIHRvIGNhY2hlIGxpbmVzICovDQo+ICAJCSIuYmFs
aWduIDMyXG5cdCINCj4gIA0KPiANCg==
