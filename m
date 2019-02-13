Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A42CC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E72222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=uievolution.onmicrosoft.com header.i=@uievolution.onmicrosoft.com header.b="JwXURChu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404210AbfBMWTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:19:21 -0500
Received: from mail-eopbgr680058.outbound.protection.outlook.com ([40.107.68.58]:6752
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404107AbfBMWTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uievolution.onmicrosoft.com; s=selector1-xevo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OSTC6PdqNbS5r7PyO3ZP5lnsR7fuHl4+PEWG094NNQ=;
 b=JwXURChuUk4wSqHLWqttDNA34A2PqCsM9JWMTkpBNXirWKbMLXiwsLLfk81VOCrLGyI2peYe6uSSJvrbMNadJCxv/0pNU13gj+wcLgnsm/o/baOCNxFjDA7JVbzXgQRkP9D1l+1RMPJHrM3Jhxynb/3jwrvRTvxkonj/JeVbLKE=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (10.173.214.17) by
 DM5PR18MB2294.namprd18.prod.outlook.com (52.132.208.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 22:19:16 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::fc42:c9bc:d8ed:7379]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::fc42:c9bc:d8ed:7379%8]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 22:19:16 +0000
From:   Martin Kelly <mkelly@xevo.com>
To:     Mathieu Othacehe <m.othacehe@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: trigger: Print an error if there is no available irq
Thread-Topic: [PATCH] iio: trigger: Print an error if there is no available
 irq
Thread-Index: AQHUw56N/7i7NpUdzUiUX7Vj1VqC5qXeTQsA
Date:   Wed, 13 Feb 2019 22:19:16 +0000
Message-ID: <cd3cf791-e035-d06c-ea1b-4415a93ea7a2@xevo.com>
References: <20190213131752.646-1-m.othacehe@gmail.com>
In-Reply-To: <20190213131752.646-1-m.othacehe@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:301:3b::32) To DM5PR18MB1452.namprd18.prod.outlook.com
 (2603:10b6:3:bc::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mkelly@xevo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [71.212.3.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd1f75bf-2c95-4479-915c-08d692014a89
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB2294;
x-ms-traffictypediagnostic: DM5PR18MB2294:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtETTVQUjE4TUIyMjk0OzIzOjJKeUNoZnBRSjBQZHRWVm9JK3hNNWdkMlQ0?=
 =?utf-8?B?L0daS0JTTHZZQ1ovd2QxOUVhbngrVjZKSmpyRVE4VE8vUnNwTnFpRmYrUERT?=
 =?utf-8?B?SzV3TjhZVXlCeitpRXEzbndCQUtVTHlOVHFUaU5jMlBrTk5vZG44ZEgwT2or?=
 =?utf-8?B?YzFMV0pjL2M3bnpNZ01nL3dUSmZleW1nT3RJY1kxMVNtQ05ZY2x3aGxSZEdR?=
 =?utf-8?B?RG5JanZYK2pQRzJZU0lBbitPOWFpVmFtdjF0N1ZqWG5tdlpZVytBdG9iU2xs?=
 =?utf-8?B?b1BhbWVpaGNHbTg0WEV0NlhVeXNyOXlSUGRzVjQ0cEE1c1UxeU9SeE4xRnBG?=
 =?utf-8?B?K2hlMzA4c3RMMVZCckFia3pVRGNndjhIZjYzM0wrWkhETUsyZ1lodkdZSGl5?=
 =?utf-8?B?eWxvbjlGaFduSzMwSit0M2RCM250aisyV3dhOEhaZjRZaWZLVThWem1jN1p4?=
 =?utf-8?B?bUt1UDZSTWkxdjNpZjRvNDBEWWEvdmhlN2E2VHdKc2IrN3VnNWtFUXBpTStV?=
 =?utf-8?B?a3FrQTAyY2gwOHlKdms1Umw5RUV6MDVWbGlRT05pWUxzMlhDVTBvZkFkUVF2?=
 =?utf-8?B?SkFBS3padHdFemdWYmVzVzhCSXVlOE4yRE9QRHFPWVRjbkNPZ0ZpRnFNRXI1?=
 =?utf-8?B?eWZ0QXpjUzFGMFc4QThxZW9nWTBJVFpnWU53SlBPQjJIdmlyWXFON2FWa0lX?=
 =?utf-8?B?ajJOZEdLcjltNTJYMXJ4UERJa01HQmlWT1VSd1hXaVZSQTlmb081Y2hFcmNS?=
 =?utf-8?B?cjN2WE5jL2dZcWUwVTUxUUVpMFEzTW1OazdUSHVQVTdCMGllMytTM3BGNVBv?=
 =?utf-8?B?cEsvdHJWdEtqcy9xTVo2WVBEa3NrdXh5NEZITjU0cUZ4SlJ3RU5iWkFuMFlW?=
 =?utf-8?B?eGtSd2NmakMyL3hoazFkbzdNUGg4TXFkeWxtZmtrcVRvbkV3ZGlNbnRlUEdP?=
 =?utf-8?B?UFRyN3ZrTU1rd0Q3N3RMUy81OFJnRE1xdURwQWdVR3lMNlZGNnM5cjc2OFBw?=
 =?utf-8?B?VzlMNGUva3NIdDRPZmg3b0tNVHpEcHJkQUlLc0pNbkRabmpuT3huQ1VmK3hB?=
 =?utf-8?B?MFZlZlV1SmU3REZqTE1XNHZKbGIrZmQxVEhBYzNHSnRNVDh0SnlST0dDRWZi?=
 =?utf-8?B?MzFQNEZCczdZTTl0eng5UG9pck9mbUp1OTNTbnZsNmU4ODlwMVNRa3pYUng2?=
 =?utf-8?B?eDVFbEJObndPbWRoazM1OU9jR1ZJL1d3NWdyZTh2eWhwVVpvaW9YM21FVzhn?=
 =?utf-8?B?dDQ3S21VNFlNVDBMeWVLMzhuNmNydmhMcnY5Y1BEQnY4dnhxeEtZbTEvMGxN?=
 =?utf-8?B?Z1pWU1dpN2dMTzRrUlQ4SWo5MXd5bXlTQjR4aVlvbGZVcXZIZ1o1SE5rajN6?=
 =?utf-8?B?a2tkOE93RzdRdTBoRXN1NU9oWE1MSGg4dEJ0aDRWMVJwbGZYSzNENXRaUCtF?=
 =?utf-8?B?SGRVQ3pkaldKUWVIdWlLT0RBRjhrbkx1RlVOd0RXNFRQUjRDM1dlUHdsN2pF?=
 =?utf-8?B?RFFBUDFsVVZUczMzUmIxQm9SbUlmeTAzN1d2S3JMT3ZVcjFMa1VwT0tidmNP?=
 =?utf-8?B?TGRscGtoRUozQ2gvcWNsYmhZS3NNL1A2UUZ5YUhqS2F6OHprM3YyQTBuNkNB?=
 =?utf-8?B?QW5ka2NXaE9CUnVqZkh2MVBweUxOWkFyTVJCZjhnMVExQlZnb2I4OEZvS2tH?=
 =?utf-8?B?TGxHYUxFWVoxRjZzZFNxTS95bzZJWWo3VDFrOStmQnpiNFJRZGNXS2k0TUlK?=
 =?utf-8?Q?chc0c3c12sYvycYm1JvJiQgp0RfAdOWyyPBoo=3D?=
x-microsoft-antispam-prvs: <DM5PR18MB2294CF3C1A3246244F993783AB660@DM5PR18MB2294.namprd18.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39840400004)(346002)(366004)(199004)(189003)(3846002)(31696002)(68736007)(102836004)(486006)(478600001)(8936002)(2616005)(2201001)(6436002)(76176011)(229853002)(446003)(11346002)(476003)(26005)(6486002)(6116002)(71200400001)(52116002)(71190400001)(54906003)(316002)(110136005)(6512007)(386003)(53546011)(6506007)(99286004)(186003)(86362001)(105586002)(36756003)(6246003)(14444005)(31686004)(2501003)(81166006)(66066001)(4326008)(5024004)(256004)(106356001)(97736004)(53936002)(7736002)(305945005)(8676002)(14454004)(81156014)(2906002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB2294;H:DM5PR18MB1452.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xevo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1vcOjK/j9IsbgnfbwNRwVAOlDkJoXyI+Ber5T9E4iDn2aHnACA4G1jEFKRtr+aRAB5jbcZQNjk81R6/u/pjmAM4CxYsNXHH1KmznkCpMemx8tp6siHvRfHI1TJGpAiXfE2oqyaIh9QudxI5u5nzksOdo0e4F9QNXkqqA5ougdWZ+w/58SshPEwVDglNnFfwmn0uTTS05sqJ1tjD694ikEUXbV5gcw4llXvnQStBiXanleeCaafe50B8XUxA4VeSRkPvIX/Ax7hDvuhHsFxZqFVWMcEp0qQyVGyBLWBdSX9n1zoEtsDyCT8+uGb22kY/Xozmdv15mmtzQEvyG6vUo08F53LiwD8UwR52OXXnKbA7NhW1rNURYDpx9pOQYP+Z3Zv1NUr5RVhTBFA2zS/zHV7LFYILrjpR9P3Vs4Y0Bd0U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <471B520F2A20AF47B4A96CD9AE07F576@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xevo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1f75bf-2c95-4479-915c-08d692014a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 22:19:15.4499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: e0a7ca1f-2458-4cd6-a7c7-d733c07495ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xMy8xOSA1OjE3IEFNLCBNYXRoaWV1IE90aGFjZWhlIHdyb3RlOg0KPiBJZiB0aGVyZSBh
cmUgbW9yZSB0cmlnZ2VyIGNvbnN1bWVycyB0aGFuDQo+IENPTkZJR19JSU9fQ09OU1VNRVJTX1BF
Ul9UUklHR0VSLCBpaW9fdHJpZ2dlcl9hdHRhY2hfcG9sbF9mdW5jIHdpbGwNCj4gc2lsZW50bHkg
ZmFpbC4gQWRkIGFuIGVycm9yIG1lc3NhZ2UgdG8gaW5mb3JtIHRoZSB1c2VyIHRoYXQNCj4gQ09O
RklHX0lJT19DT05TVU1FUlNfUEVSX1RSSUdHRVIgbGltaXQgbWlnaHQgYmUgZXhjZWVkZWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IE90aGFjZWhlIDxtLm90aGFjZWhlQGdtYWlsLmNv
bT4NCj4gLS0tDQo+ICAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLXRyaWdnZXIuYyB8IDYgKysr
KystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby10cmlnZ2VyLmMgYi9k
cml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tdHJpZ2dlci5jDQo+IGluZGV4IGNlNjY2OTljN2ZjYy4u
ODAxOTg2YzIxNDY3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tdHJp
Z2dlci5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby10cmlnZ2VyLmMNCj4gQEAg
LTI1NCw4ICsyNTQsMTIgQEAgc3RhdGljIGludCBpaW9fdHJpZ2dlcl9hdHRhY2hfcG9sbF9mdW5j
KHN0cnVjdCBpaW9fdHJpZ2dlciAqdHJpZywNCj4gICANCj4gICAJLyogR2V0IGlycSBudW1iZXIg
Ki8NCj4gICAJcGYtPmlycSA9IGlpb190cmlnZ2VyX2dldF9pcnEodHJpZyk7DQo+IC0JaWYgKHBm
LT5pcnEgPCAwKQ0KPiArCWlmIChwZi0+aXJxIDwgMCkgew0KPiArCQlwcl9lcnIoIkNvdWxkIG5v
dCBmaW5kIGFuIGF2YWlsYWJsZSBpcnEgZm9yIHRyaWdnZXIgJXMsICINCj4gKwkJCSJDT05GSUdf
SUlPX0NPTlNVTUVSU19QRVJfVFJJR0dFUiBsaW1pdCAiDQo+ICsJCQkibWlnaHQgYmUgZXhjZWVk
ZWRcbiIsIHRyaWctPm5hbWUpOw0KPiAgIAkJZ290byBvdXRfcHV0X21vZHVsZTsNCj4gKwl9DQo+
ICAgDQo+ICAgCS8qIFJlcXVlc3QgaXJxICovDQo+ICAgCXJldCA9IHJlcXVlc3RfdGhyZWFkZWRf
aXJxKHBmLT5pcnEsIHBmLT5oLCBwZi0+dGhyZWFkLA0KPiANCg0KVGhpcyBzZWVtcyB1c2VmdWwh
IEkgdGhpbmsgaXQgd291bGQgYmUgZ29vZCB0byBwcmludCB0aGUgdmFsdWUgb2YgDQpDT05GSUdf
SUlPX0NPTlNVTUVSU19QRVJfVFJJR0dFUiB0b28uIEFsc28sIGl0IGFwcGVhcnMgdGhpcyBpcyAN
CnRyaWdnZXJpbmcgYSBjaGVja3BhdGNoIHdhcm5pbmc6DQoNCldBUk5JTkc6IHF1b3RlZCBzdHJp
bmcgc3BsaXQgYWNyb3NzIGxpbmVzDQo=
