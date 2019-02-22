Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D935DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBD220818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="dzq0b+HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfBVJKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:10:19 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:11488 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfBVJKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:10:18 -0500
X-IronPort-AV: E=Sophos;i="5.58,398,1544511600"; 
   d="scan'208";a="27112403"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Feb 2019 02:10:17 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 22 Feb 2019 02:10:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os5mp/0ab3upkt2m+D/gQ9N1AHa/w25S1m+kCE8fd5s=;
 b=dzq0b+HO5gDuRS1DaXMv9njl3kR/SjdCBJSSLFlilOY45W8y/4yYcAqnHwrDotC4llTpciZADzrDMnyBWqLBs4uQKbf34HtXUET0Nx+eVKLp++/Nt8c7ChwShrigW4dFatICvmQ+VU5mUJrOtwaHrae/tbIAhRdv16semm09ILA=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB0061.namprd11.prod.outlook.com (10.164.204.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Fri, 22 Feb 2019 09:10:15 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.016; Fri, 22 Feb 2019
 09:10:15 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] pwm: atmel: add support for controllers with 32
 bit counters
Thread-Topic: [PATCH v2 2/4] pwm: atmel: add support for controllers with 32
 bit counters
Thread-Index: AQHUyDsg4pV/PQZmmkCr3+x+PakMUaXqu2MAgADQ84A=
Date:   Fri, 22 Feb 2019 09:10:15 +0000
Message-ID: <ae3b5435-721b-4992-34eb-b2d530d298cf@microchip.com>
References: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
 <1550570914-26391-3-git-send-email-claudiu.beznea@microchip.com>
 <20190221204214.krpobz2ezneynht5@pengutronix.de>
In-Reply-To: <20190221204214.krpobz2ezneynht5@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::34) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190222111005180
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39c8c320-291f-4aad-2229-08d698a58e72
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB0061;
x-ms-traffictypediagnostic: MWHPR11MB0061:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIwMDYxOzIzOmdSdWsrQzFBYTdONlgwQm85SU5DMXg2MnE2?=
 =?utf-8?B?YXJDVnR5QlNEdklxU0ZCWUdkSnUrMDMvMk5LTjZML2l4b3dRcWlzUFA1aUlJ?=
 =?utf-8?B?NzZMQk8wKzZraUFFbiswVVhtd3lpa1NoVFlrN1dzUExQLysrU1pVZ1krR3di?=
 =?utf-8?B?RGNXVFN3ZC9jTlJKMVRCVmVsMFVQSmdWYURRMHpvR0NaRmFiL0Q5QWQ4ZVN4?=
 =?utf-8?B?VTUraE9zeVhvVXc2SXRwRUhyb2N3MWdHcmZXSkYyZVQ0VGdvbEJMdkNMMWZB?=
 =?utf-8?B?Q3JXMlJqZU1RbTBaV2c1Q0lQRTNGc0pFaUxZZkRza0hXZkpUb2RXSFVuZVlP?=
 =?utf-8?B?aFVXdm82MnNzNHVxaTBJRGpIOVBPVURZS2xsS2pzWHlIL05qb01FVEN5Ukll?=
 =?utf-8?B?aEZFQ0doMmRFYWhkSW1UVW9QZngxRVlaTXF0U2M1UWJEU2c2Nm5YbmJBZ0ov?=
 =?utf-8?B?WFdMcUVQN2x1U2tRalNsRlN1QzJPN3JoMXBnb0Y1anhQaWxwZ0ErWTRWTWpU?=
 =?utf-8?B?QmVMUy80Tk1ReTRXTDcySllISHhvUHdOdUhTbmdGL1FueVk3NVpDTy9peGln?=
 =?utf-8?B?bzh6TG5QcmF3SzA3K1VZcnl5ZkFva0tMbkpaWEdyV1RPVzVVSTBPVjZiMS9J?=
 =?utf-8?B?VEJKOU01UERVb0VxMk53MWhxNk5lcXZGMHE3VWtocE13cGJpTTNsVWxTb3cx?=
 =?utf-8?B?MVdDQ0pUNC9kaUlkbFVkM3JkbUFRNTA3WkpSS1M0V21WTHE0TElpbHZvcUtJ?=
 =?utf-8?B?T2dsWU9QUURFRzdoaWhHTnk5cktmQ0hOTjNhdmE3YlZlMEhHY1E2cDZMQ3pa?=
 =?utf-8?B?Ym1Ebm5PZzZvYVR5aTFaTXd0UThkLzBxNVNaZ01MYjd6MVM5NXl4dzN4cVNv?=
 =?utf-8?B?Q1pqQzNuVGJwaVZlVVU1TW9CNkpMKytyK3VUTzk1ekNsSTI3OEUvSWprOTIr?=
 =?utf-8?B?UWI2UlhVU0F2UDRSOGMrVlYxUUpjb3BUMWhrdjFQQ25aK01JWTZHdDhXemxJ?=
 =?utf-8?B?NDYrelRUd0xNQUp0K1VtcHFDOGs3aUs0b3J4UmphclJCejhlSTY1QWZXb3Rr?=
 =?utf-8?B?aGcxMFV5UWEyRm5XZ3A3bWRnSUhxYlhNV2NkdDA0Y3RPRG1MRWtkZUJQSnpa?=
 =?utf-8?B?TDFLUTVsMUdPK29SbitjeUN3UkJ6MVNwUzlub096czY3U1E5WXVETU9DK0JF?=
 =?utf-8?B?RitHQjFBUzRDTFBXaXJJTUVHM0IrUFhDcFNQcE52aW5rcDdSMWRCSUIreFc1?=
 =?utf-8?B?NlJOQ1djVHVRVVJHWlE4UENmMkhXRzZpcmJRc2RuY0NZV0s3RVVsRWZJR1FT?=
 =?utf-8?B?Rm1lZ2pxVWpZbDBsR2NRSjJDZ0tRWUQxMkpQd2JDck1vSFczYXFYZjlmc09a?=
 =?utf-8?B?SHBWams1UUFQK0YxWUJJd24zL2dsUnVQUWVkNlludVhzdjVKOFhBVEhNeHJU?=
 =?utf-8?B?M0I1V3BqcGlqZHkxUlhXMTcvM3IwZjFxemxBVUo4S3hPRmhvb1NqZndVMDhz?=
 =?utf-8?B?bVd5MWxNQldRUUxFTStDVE8rcC80UGlwdTg2RUhMd29WOVNKMEpDQVpITVFF?=
 =?utf-8?B?Ti9QZ3NxakZqSVZkV252a3ZQQVBlYnVyQlM1VG1OanNYSDVHRUE1d3EzWHc3?=
 =?utf-8?B?KzJvUGZiSkx1cGh3eUhLMGRYYlh3ZHJ1Z1VkUVRHN3FzeWpuWXFTbi9iRzRX?=
 =?utf-8?B?bU15SUxNOFFnK29BNGVBTkJ4K1BkTG1xU1A2V244eHNrQzIxUzYvU1R1YVZD?=
 =?utf-8?B?VVFBT3ZLemhRRDBlRXZXbklHcklhbWRNa2FXcmd0a05BWk02T3dDN01LOC9n?=
 =?utf-8?Q?n0554knuC9O2x?=
x-microsoft-antispam-prvs: <MWHPR11MB00614736DD85CBAEC12710E1877F0@MWHPR11MB0061.namprd11.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(229853002)(476003)(2616005)(446003)(97736004)(6506007)(81156014)(8676002)(386003)(53546011)(5660300002)(102836004)(81166006)(54906003)(99286004)(11346002)(6246003)(26005)(31696002)(66066001)(4326008)(86362001)(8936002)(66574012)(186003)(6436002)(6486002)(25786009)(2906002)(53936002)(14444005)(7736002)(72206003)(486006)(256004)(3846002)(36756003)(76176011)(105586002)(31686004)(71190400001)(106356001)(6512007)(316002)(6916009)(52116002)(6116002)(68736007)(14454004)(478600001)(305945005)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB0061;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BWBWR9034S5qSw2thvfbeoHZml0t9GTMooS/tgMEJS/q+7uVNcmXpiMJwAPf2hz4L9ubqBw0lnCQBl8BLLjjgZ+WdFqhqJjsGsmAKM0aUIvUxLkDl5H8s/6Q/HROXgXDk754G0DoJpROKv+XU9c9a8bRFpYcoLMHyECafx+rUEM7H4shtO8+LFoAeznVxYrBBEUNRO9b042DiRAV3h8k5QA8WYxysRRPVwmyVVZjJLxZTCmaEHncSXgTiTnzDXke31St/FPFOadqOJKFbSn2SMz/lqTPd0lH/J3H6g1P59/I5vG/wwbPUQ4MtPAo/0x2+GXKPJxOxb8D4scl7ztaAG3m/GtwuPTNiFR3+vaT+Sf//kit2NfzaSpmIyN3LjHHmd9ud1qY6ksR4+fv8metpEIwKWoYgDXjJHLHrP0qUqI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5163EA08293EE449A2457ABB6C4FC362@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c8c320-291f-4aad-2229-08d698a58e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 09:10:11.4858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0061
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIxLjAyLjIwMTkgMjI6NDIsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBIZWxs
bywNCj4gDQo+IE9uIFR1ZSwgRmViIDE5LCAyMDE5IGF0IDEwOjA4OjU3QU0gKzAwMDAsIENsYXVk
aXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBOZXcgU0FNOVg2MCdzIFBXTSBj
b250cm9sbGVyIHVzZSAzMiBiaXRzIGNvdW50ZXJzIHRodXMgaXQgY291bGQgZ2VuZXJhdGUNCj4+
IHNpZ25hbHMgd2l0aCBoaWdoZXIgcGVyaW9kIGFuZCBkdXR5IGN5Y2xlcyB0aGFuIHRoZSBvbGQg
b25lcy4gUHJlcGFyZSB0aGUNCj4+IGN1cnJlbnQgZHJpdmVyIHRvIGJlIGFibGUgdG8gd29yayB3
aXRoIG9sZCBjb250cm9sbGVycyAodGhhdCB1c2VzIDE2IGJpdHMNCj4+IGNvdW50ZXJzKSBhbmQg
d2l0aCB0aGUgbmV3IFNBTTlYNjAncyBjb250cm9sbGVyLCBieSBwcm92aWRpbmcgY291bnRlcnMN
Cj4+IGluZm9ybWF0aW9uIGJhc2VkIG9uIGNvbXBhdGlibGUuDQo+IA0KPiBJJ2Qgd3JpdGU6DQo+
IA0KPiAJVGhlIFBXTSBjb250cm9sbGVyIG9mIHRoZSBuZXcgU0FNOVg2MCBTb0MgdXNlcyAzMiBi
aXQgd2lkZQ0KPiAJY291bnRlcnMgY29tcGFyZWQgdG8gMTYgYml0IHdpZGUgY291bnRlcnMgaW4g
dGhlIGVhcmxpZXIgY2hpcHMuDQo+IAlUbyBzdXBwb3J0IHRoaXMgYWRkIGEgbmV3IHN0cnVjdHVy
ZSB0byB0aGUgY29tcGF0aWJsZXMnIGRhdGENCj4gCXRoYXQgZGVzY3JpYmUgdGhlIGNvdW50ZXIg
d2lkdGggYW5kIHByZWNpc2lvbiBhbmQgbWFrZSB1c2Ugb2YNCj4gCXRoZW0gaW5zdGVhZCBvZiB0
aGUgaGFyZCBjb2RlZCB2YWx1ZXMuDQo+IA0KPiBPdGhlciB0aGFuIHRoYXQgdGhlIGNvbW1pdCBs
b29rcyBmaW5lLg0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xh
dWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvcHdtL3B3bS1h
dG1lbC5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPj4gIDEgZmls
ZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwu
Yw0KPj4gaW5kZXggN2U4NmE1MjY2ZWI2Li42NDdkMDYzNTYyZGIgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL3B3bS9wd20tYXRtZWwuYw0KPj4gKysrIGIvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMN
Cj4+IEBAIC00OCwxNSArNDgsMTEgQEANCj4+ICAjZGVmaW5lIFBXTVYyX0NQUkQJCTB4MEMNCj4+
ICAjZGVmaW5lIFBXTVYyX0NQUkRVUEQJCTB4MTANCj4+ICANCj4+IC0vKg0KPj4gLSAqIE1heCB2
YWx1ZSBmb3IgZHV0eSBhbmQgcGVyaW9kDQo+PiAtICoNCj4+IC0gKiBBbHRob3VnaCB0aGUgZHV0
eSBhbmQgcGVyaW9kIHJlZ2lzdGVyIGlzIDMyIGJpdCwNCj4+IC0gKiBob3dldmVyIG9ubHkgdGhl
IExTQiAxNiBiaXRzIGFyZSBzaWduaWZpY2FudC4NCj4+IC0gKi8NCj4+IC0jZGVmaW5lIFBXTV9N
QVhfRFRZCQkweEZGRkYNCj4+IC0jZGVmaW5lIFBXTV9NQVhfUFJECQkweEZGRkYNCj4+IC0jZGVm
aW5lIFBSRF9NQVhfUFJFUwkJMTANCj4+ICsvKiBNYXggdmFsdWVzIGZvciBwZXJpb2QgYW5kIHBy
ZXNjYWxlciAqLw0KPj4gKw0KPj4gKy8qIE9ubHkgdGhlIExTQiAxNiBiaXRzIGFyZSBzaWduaWZp
Y2FudC4gKi8NCj4+ICsjZGVmaW5lIFBXTV9NQVhWMV9QUkQJCTB4RkZGRg0KPj4gKyNkZWZpbmUg
UFJEX01BWFYxX1BSRVMJCTEwDQo+PiAgDQo+PiAgc3RydWN0IGF0bWVsX3B3bV9yZWdpc3RlcnMg
ew0KPj4gIAl1OCBwZXJpb2Q7DQo+PiBAQCAtNjUsOCArNjEsMTQgQEAgc3RydWN0IGF0bWVsX3B3
bV9yZWdpc3RlcnMgew0KPj4gIAl1OCBkdXR5X3VwZDsNCj4+ICB9Ow0KPj4gIA0KPj4gK3N0cnVj
dCBhdG1lbF9wd21fY29uZmlnIHsNCj4+ICsJdTMyIG1heF9wZXJpb2Q7DQo+PiArCXUzMiBtYXhf
cHJlczsNCj4+ICt9Ow0KPj4gKw0KPj4gIHN0cnVjdCBhdG1lbF9wd21fZGF0YSB7DQo+PiAgCXN0
cnVjdCBhdG1lbF9wd21fcmVnaXN0ZXJzIHJlZ3M7DQo+PiArCXN0cnVjdCBhdG1lbF9wd21fY29u
ZmlnIGNmZzsNCj4+ICB9Ow0KPj4gIA0KPj4gIHN0cnVjdCBhdG1lbF9wd21fY2hpcCB7DQo+PiBA
QCAtMTI1LDEwICsxMjcsMTAgQEAgc3RhdGljIGludCBhdG1lbF9wd21fY2FsY3VsYXRlX2NwcmRf
YW5kX3ByZXMoc3RydWN0IHB3bV9jaGlwICpjaGlwLA0KPj4gIAljeWNsZXMgKj0gY2xrX2dldF9y
YXRlKGF0bWVsX3B3bS0+Y2xrKTsNCj4+ICAJZG9fZGl2KGN5Y2xlcywgTlNFQ19QRVJfU0VDKTsN
Cj4+ICANCj4+IC0JZm9yICgqcHJlcyA9IDA7IGN5Y2xlcyA+IFBXTV9NQVhfUFJEOyBjeWNsZXMg
Pj49IDEpDQo+PiArCWZvciAoKnByZXMgPSAwOyBjeWNsZXMgPiBhdG1lbF9wd20tPmRhdGEtPmNm
Zy5tYXhfcGVyaW9kOyBjeWNsZXMgPj49IDEpDQo+PiAgCQkoKnByZXMpKys7DQo+IA0KPiBPcnRo
b2dvbmFsIHRvIHRoaXMgcGF0Y2gsIHRoaXMgY291bGQgYmUgY2FsY3VsYXRlZCB3aXRob3V0IGEg
bG9vcC4NCj4gU29tZXRoaW5nIGxpa2UNCj4gDQo+IAlwcmVzID0gcm91bmR1cF9wb3dfb2ZfdHdv
KGN5Y2xlcyk7DQo+IAlpZiAocHJlcyA+IGJpdHdpZHRoX29mX2NvdW50ZXJfcmVnaXN0ZXIpDQo+
IAkJcHJlcyAtPSBiaXR3aWR0aF9vZl9jb3VudGVyX3JlZ2lzdGVyOw0KPiAJZWxzZQ0KPiAJCXBy
ZXMgPSAwDQo+IA0KPiAod2hlcmUgYml0d2lkdGhfb2ZfY291bnRlcl9yZWdpc3RlciBpcyAxNiBm
b3IgdGhlIG9sZGVyIFBXTXMgYW5kIDMyIGZvcg0KPiB0aGUgbmV3IG9uZSkuIE1heWJlIGl0IHdv
dWxkIG1ha2UgbW9yZSBzZW5zZSB0byBwdXQgMTYgaW50byB0aGUNCj4gc3RydWN0dXJlIGRlc2Ny
aWJpbmcgdGhlIFBXTSB0aGVuIGluc3RlYWQgb2YgMHhmZmZmICh3aGljaCBpcyBlYXNpbHkNCj4g
Y2FsY3VsYXRlZCBmcm9tIDE2KT8gSWYgcGlja2luZyB0aGlzIHVwLCB5b3UgbWlnaHQgaGF2ZSB0
byBwYXkNCj4gYXR0ZW50aW9uIHRvIHBpY2sgZnVuY3Rpb25zIHRoYXQgc3VwcG9ydCBsb25nIGxv
bmcgYXJndW1lbnRzLg0KPiByb3VuZHVwX3Bvd19vZl90d28oKSBkb2Vzbid0IGFzIG9mIG5vdy4N
Cg0KSSB3aWxsIHRha2UgaXQgaW50byBhY2NvdW50IGZvciBmdXR1cmUgcGF0Y2hlcy4NCg0KVGhh
bmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiANCj4gQmVzdCByZWdhcmRzDQo+IFV3ZQ0KPiAN
Cg==
