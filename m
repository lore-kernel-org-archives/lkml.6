Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B91CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079F321902
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BRP0O1dr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfBSI5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:57:09 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:51887 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfBSI5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:57:09 -0500
X-IronPort-AV: E=Sophos;i="5.58,387,1544511600"; 
   d="scan'208";a="26515736"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Feb 2019 01:57:07 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Feb 2019 01:57:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRw8pyDKlsxu5OK7iTEY9F8mlG90KkDggI+1/SBrr5s=;
 b=BRP0O1drGL796ZVuKU1rQMGFYhWaftoENxBwC0a8S3d+topo+hPku659axKpgTH4xJ0A8Wihe/9rgptUIao5LMHURqHX6LIE9/5SW4aOwWm3WVuoVUA+Wk8hD3Qe71Neq3U/crfrwhMfkwlEbxJ1H3KqSwum3MUVZQ3vUYkR5jc=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1845.namprd11.prod.outlook.com (10.175.82.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 08:57:04 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1%8]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 08:57:04 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] pwm: atmel: add support for controllers with 32 bit
 counters
Thread-Topic: [PATCH 2/4] pwm: atmel: add support for controllers with 32 bit
 counters
Thread-Index: AQHUsYUm31frJ/4ukkWUPCYXEQw2XaXm6l4AgAAUtgA=
Date:   Tue, 19 Feb 2019 08:57:04 +0000
Message-ID: <e08cbcb2-4e37-4a2e-ea79-021a2c7a25d6@microchip.com>
References: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
 <1548073783-22640-3-git-send-email-claudiu.beznea@microchip.com>
 <20190219074246.kcdbd5nhf43yw5ax@pengutronix.de>
In-Reply-To: <20190219074246.kcdbd5nhf43yw5ax@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::13) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190219105654489
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28e1aa53-8eba-4e8c-9f1f-08d6964837d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1845;
x-ms-traffictypediagnostic: CY4PR11MB1845:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtDWTRQUjExTUIxODQ1OzIzOlpTRFp0bGJmZGRNV3NldEVJMVpCeitVMEJF?=
 =?utf-8?B?TVFDSFNsV0JsZlVHbStCNVh5MEpJQVl5QmEyaU1ieFVtRlBBS0Y1OEoyWG4y?=
 =?utf-8?B?cG1VM3k2UjNZZU8rNmo1bGYrQmYyWHdRc05pWjlwTzN5ZHNweSsydWRzVTVa?=
 =?utf-8?B?UkN0OUxTS0wxUmkwS3B6M2ZyaDdlRXZyV01UckhqOHZsc1I2Snc5dlZubDRr?=
 =?utf-8?B?YVJoQThVRldxSDNVYlowblMzemJMVnpqSUhEVTRTM2VhSW9qakNINjBLNFg5?=
 =?utf-8?B?MW1saEZYMUF6YitPSCtLcXRONDdvVmF3NHdmcVYxYzNxYnFobVp5OWlmcWxn?=
 =?utf-8?B?cjJQcHRoSFdQZWdSRTRFMzNzQ3FRTG9GczNtUE9adFd4Q29HNFRkRjJlL2V3?=
 =?utf-8?B?V1pqVFFOVEFGQ1JsRzRqZSt3RVZPTzVkU2VmZjk4VFVFcXA4NmZHS1dVWVE3?=
 =?utf-8?B?MHNLRTloajNLcFZCN2k0VWNMbnQ3c3lSdXE4UEdnSFhoUk1tOXUzSUtwUHBo?=
 =?utf-8?B?SGFOYVgvMW5KOXVBZ0hNUEhmMlFIaW9EZDVkU2J3Vk90c0I5cEFQRHpuVnB0?=
 =?utf-8?B?OEp6NFZGSS95bHloTE96NXdYVjBWdkswWlQ3bkNIb2d1dmZVZVJTR0x6M3pT?=
 =?utf-8?B?OTFKTURnNTFUOHVoZ3pRYnJwR245VDJLVUdQdXNNZ2YyL3JlSWNGNWJBdS9u?=
 =?utf-8?B?STR5RCtaL2JubUlPUldZaW04WEk5UHJIWGtNS1ZPbE12MlVSS1JWejhQUURo?=
 =?utf-8?B?aGFtdy9oNXR2K0t5U0NHRTkzd0hwOTQ0VTliUE1CRHZhNkEydmIvNEYyUTVN?=
 =?utf-8?B?TWFhNi9NaGhidHp2dGxKY0U2MVJSTkVTWUZsUTRITW1RTnZZQ1p6WUhZYWEw?=
 =?utf-8?B?KzZUWCtZYWRpVE93R0VxLzE5Z21GM3RZRk9Vd2Z0VDdXVFllYUVrN0cxeHRv?=
 =?utf-8?B?RDhwQjlYdml0U3ZDdHVOejlia1Q5blZjeEhadlg2a2ZhZ0pUWm1KUDcvNnFD?=
 =?utf-8?B?UzIxOXV4NVpyL1luaTBpRlZHSDJEMnZMeFdHQWYvbnYxQ1pmUjVGS1BoTTAx?=
 =?utf-8?B?NkpvRzdFc3ZFUm1sVzE2T2JweWJuWDRVcHM4bUYwZCtnRGIxaUJZdmhnVW5L?=
 =?utf-8?B?dlJWUTZZdCtnMFo2alVnc3BIT01zNFBnNTFSaUJ2QWFsZWF3NDJuWElCenBP?=
 =?utf-8?B?allGLzh6ZDkyK1ZJT2IyQWYySE81LzdXaEdKTG54YWU5Y08yek85WjJYQkFH?=
 =?utf-8?B?TytyTmhrSGg2SE8xK0JUWDVOb2k4ZWpjODZRMGJiVlZkVjJmR1YvNStOL2pn?=
 =?utf-8?B?MnJrRkxHVVlmd1plRmxwbDhrWUl5MWVuR282V1RWM1VKZUpIYWN5RmhOYVc3?=
 =?utf-8?B?dEpVYVlyQUJvSkdTRVd0MFdXSjIwempieXN2MzlGMDdhbzFSbWIzd2NnbzRE?=
 =?utf-8?B?VGtOd3Z1SngwQzZYeEN2SHJpNGdkaG5yNUhaVWpiQm9Pa2RBWmRBclVWaDNF?=
 =?utf-8?B?NlpGc0VGUzc0Y0RHTWpDNmRDSTZKektaeVhsTTlLUVMzNHlQK2VEUzFmOCtH?=
 =?utf-8?B?SHJONnhUOHJidW1STi9qRVZJYXFacjQxaU9mZjRrbXlYSkwyUnR4TVhYQjdF?=
 =?utf-8?B?eDhPbjh1alNjUGRCZXFzZGlrZjFxa1R0L1pNL2FZMGRBRUl4T1FtSFJjYjdq?=
 =?utf-8?B?aFJEcitmLzNjTmhwT3FNSGpqMEJkMUZzYndYQXhsakEwbjk1bjRZNEVjMEd0?=
 =?utf-8?B?MmdkNys2L3BSeE1JdTJLamdQMG9vOTcyRWdsblVhazlmK1NmNmNKWDJmNGZK?=
 =?utf-8?B?SURVTmtvRnd0WUpVNCtZQXhGTk1TenI2b3ZMeEs1SzkvZkE9PQ==?=
x-microsoft-antispam-prvs: <CY4PR11MB1845B90D9BD46A39C8161059877C0@CY4PR11MB1845.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(54094003)(68736007)(54906003)(316002)(72206003)(31686004)(478600001)(6246003)(66066001)(4326008)(14454004)(5660300002)(53546011)(386003)(76176011)(99286004)(52116002)(97736004)(102836004)(66574012)(105586002)(36756003)(106356001)(31696002)(6506007)(86362001)(186003)(26005)(6916009)(6486002)(6436002)(229853002)(53936002)(14444005)(256004)(446003)(11346002)(486006)(2616005)(476003)(7736002)(25786009)(2906002)(305945005)(6116002)(3846002)(71200400001)(6512007)(8936002)(8676002)(81166006)(81156014)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1845;H:CY4PR11MB1909.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SKQ80Zu2MdbseCTajkSkkwy05637qDSxmLsxsf3tBQtZssQlUCe2dx3KQJhmVEIMXN0vNVUwPQKbJhY0A8OJTntm4nWzPEBHqwvgcPpu+Y1HL6F8lawgyiZydk7+xVJGtmlRWuXc3EynsArv/dPyH4ny54lXE5QIOPIlT3OKGbkWM3Dw6XdY4TAFEVY/l9Dm997OIHm2ynLgfTihCTNccDUVoqSPIiJ8XDUfdzrPcp0iQ6PcjmhJ1DuP8GrJrmD4XWlfLlfSmJOgL4I6HkD0S+5H2H9WJ1pd55JS54VISFwVWhd2IPk4jWOunfGLEon6Ql8yJQ/tQzWeRSBKHR8QGexXj02rogtNZv3tSvZj2UNWRRBm1b3ai2QjlD65gD3cpBIxAjY7IQKwr2bISLLi8T/TwFhD1TSC5L4PxzV9+hA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BF9CBF41A5E0F40A8890E8641F34482@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e1aa53-8eba-4e8c-9f1f-08d6964837d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 08:57:01.1011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1845
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE5LjAyLjIwMTkgMDk6NDIsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBIZWxs
byBDbGF1ZGl1LA0KPiANCj4gT24gTW9uLCBKYW4gMjEsIDIwMTkgYXQgMTI6MzA6NTNQTSArMDAw
MCwgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEZyb206IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IE5ldyBTQU05WDYw
J3MgUFdNIGNvbnRyb2xsZXIgdXNlIDMyIGJpdHMgY291bnRlcnMgdGh1cyBpdCBjb3VsZCBnZW5l
cmF0ZQ0KPj4gc2lnbmFscyB3aXRoIGhpZ2hlciBwZXJpb2QgYW5kIGR1dHkgY3ljbGVzLiBVcGRh
dGUgdGhlIGN1cnJlbnQgZHJpdmVyDQo+PiB0byB3b3JrIHdpdGggb2xkIGNvbnRyb2xsZXIgKHRo
YXQgdXNlcyAxNiBiaXRzIGNvdW50ZXJzKSBhbmQgd2l0aCB0aGUNCj4+IG5ldyBTQU05WDYwJ3Mg
Y29udHJvbGxlci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRp
dS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvcHdtL3B3bS1hdG1l
bC5jIHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4+ICAxIGZp
bGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5jIGIvZHJpdmVycy9wd20vcHdtLWF0bWVs
LmMNCj4+IGluZGV4IDdlODZhNTI2NmViNi4uNDRmNGExYzlmNjBiIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9wd20vcHdtLWF0bWVsLmMNCj4+ICsrKyBiL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5j
DQo+PiBAQCAtNDgsMTUgKzQ4LDE1IEBADQo+PiAgI2RlZmluZSBQV01WMl9DUFJECQkweDBDDQo+
PiAgI2RlZmluZSBQV01WMl9DUFJEVVBECQkweDEwDQo+PiAgDQo+PiAtLyoNCj4+IC0gKiBNYXgg
dmFsdWUgZm9yIGR1dHkgYW5kIHBlcmlvZA0KPj4gLSAqDQo+PiAtICogQWx0aG91Z2ggdGhlIGR1
dHkgYW5kIHBlcmlvZCByZWdpc3RlciBpcyAzMiBiaXQsDQo+PiAtICogaG93ZXZlciBvbmx5IHRo
ZSBMU0IgMTYgYml0cyBhcmUgc2lnbmlmaWNhbnQuDQo+PiAtICovDQo+PiAtI2RlZmluZSBQV01f
TUFYX0RUWQkJMHhGRkZGDQo+PiAtI2RlZmluZSBQV01fTUFYX1BSRAkJMHhGRkZGDQo+PiAtI2Rl
ZmluZSBQUkRfTUFYX1BSRVMJCTEwDQo+PiArLyogTWF4IHZhbHVlcyBmb3IgcGVyaW9kIGFuZCBw
cmVzY2FsZXIgKi8NCj4+ICsNCj4+ICsvKiBPbmx5IHRoZSBMU0IgMTYgYml0cyBhcmUgc2lnbmlm
aWNhbnQuICovDQo+PiArI2RlZmluZSBQV01fTUFYVjFfUFJECQkweEZGRkYNCj4+ICsNCj4+ICsv
KiBBbGwgMzIgYml0cyBhcmUgc2lnbmlmaWNhbnQuICovDQo+PiArI2RlZmluZSBQV01fTUFYVjJf
UFJECQkweEZGRkZGRkZGDQo+IA0KPiBUaGlzIHN5bWJvbCBpcyB1bnVzZWQsIHNvIEkgd29uZGVy
IGlmIHRoZSBwYXRjaCByZWFsbHkgZG9lcyB3aGF0IHRoZQ0KPiBjb21taXQgbG9nIHByb21pc2Vz
Lg0KDQpJdCBpcyBvbmx5IG9mIFNBTTlYNjAncyBQV00uIFBsZWFzZSBjaGVjayBwYXRjaCAzLzQu
IE1heWJlIEkgc2hvdWxkIGhhdmUNCmJlZW4gaW50cm9kdWNlZCBpdCBpbiB0aGVyZS4gSWYgeW91
IGNvbnNpZGVyIGl0IGlzIGJldHRlciB0byBiZSBpbnRyb2R1Y2VkDQppbiBwYXRjaCAzLzQgcGxl
YXNlIGxldCBtZSBrbm93Lg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+IA0K
