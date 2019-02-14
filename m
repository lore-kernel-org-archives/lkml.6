Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D84CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E362080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="QF5Z0GNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404913AbfBNORZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:17:25 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.117]:53345 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbfBNORY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:17:24 -0500
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-central-1.aws.symcld.net id CA/94-16347-D68756C5; Thu, 14 Feb 2019 14:17:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSe0hTYRjG/c45OzuVJ45T8204oVVGly3FLif
  qD8suKwqKQqKkOtOTG2xz7ZIziMyyyBEFmaU0N0u6zRKMslwXC6NWiWk3yyDNmSkJjm507xzP
  7PLf73ue93ve9/t4KVzxmFRSvMvB2yycSU2OJAzTyTSNycVnpQSCU9iOw0GM3XWilmRL/FcI9
  nr4PMY+ajhGssdPFuNsqOoBli7X+eqcusrgKt0NT41cd+VzoVz3vi5ppWydzGjR57k2yQwBdy
  tmbVO5Oj/ZCpFPVYJGUARTi8PR8gUlaCSlYEoxuHG6XiYduhE0+98gsYpkWDh0t5MUOY4xQUt
  ReEjHmQ4E9Y2LRY5llkJZOISkmmXQN9BDlCBK4MXwsDtTajYR7n0oH4qhGQ72BPZEen1B8Kzq
  DC4aI5h0qL9TKhMZMSr4sNOPS70S4EXIi4kMDAPVV1twieOhr/tnpJ6HYFE7kvRp0PwsFGE1V
  HqaIqyCNq87witg/+sBJA4BTA+CH5e/YsOXG3q7CIlZqHYXR1gJd1tvy6QLgRh41RcmJcMKdZ
  W9kdREeFpaFdHDMrh0barICiYbBj3NcklPgrP7u4iDaGrFP4+rED4MZyZDbcN0SR4Hpe4uecX
  Qh8VAsDxE+BBxFrF6mzHX4DBzRpMmNSVFk5qappmlmTlby23T6LW8U5PNWxw2TjC1XL5day8w
  Z5tytBbeUYeE3crZQs65jHyncm+hsRSmjqd1C/ksxWh9Xk6BgbMbNtqcJt5+CyVSlBrojHzBi
  7Hxubxrs9EkLOiwDVS0Oo6u2irYtN3Kme3GXMm6h9KoxuNdHpwauNnrwRWEJc/CKxPoNWISI5
  YanJY/QcPL3oZUylgaRUVFKaKtvM1sdPzv96MECqlj6XwxJdpocfzp1y+Mggmj9MTliKM4uL+
  WshAVFF7YN/hz0rjuAO0/3zG3vf60u2KG3hqf9GV+9ZLdyycU7PjW4v/xHfN5f01by29vb0w4
  Ei7PTBmT1VrTX7l+6b6y79pN8+TN6/I3jNe+HSz7GM7ufNr0pPbAu4wiXc3FLcnn3M+9O/cmZ
  qzqH3V/0cvVDq/zWvBQ+grwmYuT5y662qQm7AYudQpus3O/AeUbAIDnAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-18.tower-239.messagelabs.com!1550153836!1270977!1
X-Originating-IP: [104.47.6.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26275 invoked from network); 14 Feb 2019 14:17:16 -0000
Received: from mail-ve1eur02lp2051.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.51)
  by server-18.tower-239.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 14 Feb 2019 14:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqCUTzAuYSvN3qlff5715Q5rU5FesxvMFo9RD0ORssM=;
 b=QF5Z0GNaE/SGon7dmSXnfrQBdkeB7dzbE8NlJfY9GFEL4V+cNIOHcoIlii1l/WF/iO7HMo/WuR7lttgty9MzqwJwbD6etLqpVXZCrWjFWV3/wliE343u7rMKFzpcqNNxY2X188A4NnSXsGAWGpkazImGY6zd9PMpF1Nft84iTYg=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.17) by
 AM5PR1001MB1154.EURPRD10.PROD.OUTLOOK.COM (10.169.155.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 14:17:14 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10f2:a1bd:4f0d:f118]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::10f2:a1bd:4f0d:f118%8]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 14:17:14 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: typec: tcpm: Export partner Source Capabilities
Thread-Topic: [PATCH] usb: typec: tcpm: Export partner Source Capabilities
Thread-Index: AQHUuRincvQr57cnO02hlC0TTWv4QKXI87UAgBMc1ciAAFraAIADAWPw
Date:   Thu, 14 Feb 2019 14:17:14 +0000
Message-ID: <AM5PR1001MB0994B54049DDCF2CE376263A80670@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190131035411.53576-1-kyletso@google.com>
 <20190131070238.GA4500@kroah.com>
 <CAGZ6i=07EOHqd3r9y1MpYn_e1nFeYGt_wp9arhMZWWeTBm-udA@mail.gmail.com>
 <20190212105421.GA23271@kroah.com>
 <c838e214-4888-c708-6a7c-a8de6ecb5282@roeck-us.net>
In-Reply-To: <c838e214-4888-c708-6a7c-a8de6ecb5282@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9c2e0db-cb15-42c3-e7e6-08d692871e5a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM5PR1001MB1154;
x-ms-traffictypediagnostic: AM5PR1001MB1154:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTVQUjEwMDFNQjExNTQ7MjM6UHJiT3Y0SzdUY1VlTTFESDllemFyVHZ5?=
 =?utf-8?B?ejE0emxxQ29DcXBkWllzeW02UjFzbnM4VmdPUy9HNE5yT0toYlMrdjNQNEs3?=
 =?utf-8?B?eWYvZjIyMk9PU21seHZVSnJsMjlFcHZCM2FLY2c0Z2NvR3pwTVd0M09ncHFm?=
 =?utf-8?B?NFFjQUViYzR2SUw3dkV4d015ZzhjRzZoRzZXMDlZRERWRFJsR2JoeGlZaGc2?=
 =?utf-8?B?d0JabnpvejRSblc4Ujl3L3RSYXVmV1kxUlE4VitWS1lhU3N0WmFZbElvbjRG?=
 =?utf-8?B?MnY0clJPTHVhd0NyYmgvMVR3SWoyUW1mZm9RSGo5c2xlNXRsODVLL2Y4Tjhq?=
 =?utf-8?B?dExkVHFRVGpsU09qVFE1VGVMS1RuZ1BUVlR4OG1QZ2ZuaXQva0tMekxveXZP?=
 =?utf-8?B?R1p5RXZiNVlXSmV5WVdWbEV0ZEtVQzRhbnV1ZzFzYjFISjlzaDJRM0ZxeENs?=
 =?utf-8?B?Q2lCVFdIL2pQY2YyWTNMWTg1N3JHS3NpNU9MY3lvTVNxT0JDWnJFVjBNUi9i?=
 =?utf-8?B?WHlCUEUwZGI2ZFNSS00vSmhpbEZ4eGpiNFJSMEQxR050NTJHeis0aW90alo1?=
 =?utf-8?B?NXdFdnRFOG1kd0FaRXUzOHJNQ280bXVCbnpxcHRxcVBYMmJrbzhMOVlSWnZV?=
 =?utf-8?B?VkNKcDAvaVdaL3o5WVJBM0RJNndVajJ2TWZKaXFaVGNxSDFtdFNBcVdMYjhu?=
 =?utf-8?B?RkZQcFRyVEZYS011Z1JYZEtySFY1aSt2NTE4VXJMcW52MTEwWElheW96RUg4?=
 =?utf-8?B?TXhmUUFFY0VrYVRPdnFKQVUycXRoaitrRVYrcmswcERyWWt1d01PM096a2hs?=
 =?utf-8?B?YzdzeHNEdzJ2c215NHFaU1ZiMUI0eEpxYVk3NTdNY01Vb1dTTXhjNGd4cmtC?=
 =?utf-8?B?MktmRFVWaURxSmpsWXd2MlhPamhaTVp0RFhqUTZUY05venA2SnM0dkhWVzdu?=
 =?utf-8?B?V1kvVzhOZHdvNzZQZDdTU29kamxjZHlPUkd4M1ZYalJPRG0wb0FHMWpCTDFZ?=
 =?utf-8?B?WUUwNk9ocDVDcDNxSndicnhIWlBIQ1IzOEVPOHpJWHF6OGs4UWhITFg5OEY4?=
 =?utf-8?B?TTh5SW0yMUFieDl3d2VDOXFrM2xJTmZWc3BKY1JTWWZRMXF3dXVCRUN1c1Rm?=
 =?utf-8?B?bWZnNmZ1cWdDdEZiWHpuVGhLVEMwM01EUG4yb3JBVjZlRm4rYWtsNVJyMzJN?=
 =?utf-8?B?amJMWUxjUE1jcldvKzBFcVpqM2ZoMFIrZ3BROUVNbW1LWTN0K2ZBRGR3ZHF2?=
 =?utf-8?B?NHhta2pQdS9mK3hrM2xvVkdNcnVLc1h0TmU0SnMyUnNuemc5aWY5aFptTnp5?=
 =?utf-8?B?L1lnK3MzbDFSZFg3Q3FkSC9JcDR2YjZpVWNDcE40QUVzSE5wUE5QZXZSSGFv?=
 =?utf-8?B?a1lOTFJOeUNPVGtpZFhmK2hxMGFSS1EvQnhlemJoRkJYOFVOYityTGx5YUcr?=
 =?utf-8?B?c3JGNUFkZFd0TGduUnQxbXFkbmpUdHZxRTNDemNYQjRDOVhPaGJHSTFtWEJk?=
 =?utf-8?B?bFRGUjFteVlRa24zdGhNaEFraWNOcHBhZnlHek5NaDIxcnM4SWZINU1WczFL?=
 =?utf-8?B?OElKb3kwLzhueERHQkVHSHp5OXZLR3RlTmpaWTVLbVZxQzJQaVV0bTRVcWJJ?=
 =?utf-8?B?T1FOMFZaZDdwU1RVN0poaXV2c2tVUE9RL3M5bnpaelZIcENHZk1kR29EenJ3?=
 =?utf-8?B?bGpIem0vWVJiS1NjZkQxVWNFUEpBbDRXVHRVWHFVallRRnVSMTJIbmNTNTRh?=
 =?utf-8?Q?8F+JzUKeV2KYcL7mAxTYV6+84ewRTje2OpplVyI=3D?=
x-microsoft-antispam-prvs: <AM5PR1001MB1154210893C934F0CBA07828A7670@AM5PR1001MB1154.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39850400004)(189003)(199004)(26005)(105586002)(6116002)(3846002)(81156014)(81166006)(8676002)(186003)(110136005)(54906003)(6506007)(53546011)(316002)(102836004)(55236004)(2906002)(93886005)(33656002)(476003)(97736004)(486006)(14444005)(256004)(446003)(66066001)(11346002)(99286004)(8936002)(76176011)(7696005)(106356001)(7736002)(53936002)(305945005)(4326008)(6306002)(6246003)(71190400001)(71200400001)(14454004)(68736007)(86362001)(74316002)(478600001)(72206003)(25786009)(966005)(229853002)(6436002)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1154;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rx5XOBBgKImc0zw2p/2oge5mLTzyrsTk47f5TaVIrxwclZBsRD0TaR+AqFmqz8jrUg/+pGxw/4qMdKdbHwxO1Mrfh5EhY3gm5IcbRozWAuMWG2+uxfbeW+nV+yPvB1qeE4W2DB1St6HyteVEtFXyGcE06Z+Wsc0sR3VS1bPsOhCA1F7TN7hEENmQVIVzCdUmKBDHwMCgzIO0VvhDrtL+6bWbJUF4PIlbNN9oWfBEPFWwqlHmP8UO6dfDga6iOqXX9whcI6hb7XlIlk0aY9WL8gBvofQ5anV7/UgrtvGTlNRvz00JZ+jkvY9Xyf0xdxN1n+PN15CRqepLSFwLaehJYv/xFLUnvppBD2WWnACXt160KN2veapybolQP+gJ8x+e4Xi7owM+8AOy8Ku1paZd//Aw/V2m2TVxIZJ0k8kRo/s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c2e0db-cb15-42c3-e7e6-08d692871e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 14:17:14.5436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIgRmVicnVhcnkgMjAxOSAxNjoyMCwgR3VlbnRlciBSb2VjayB3cm90ZToNCg0KPiBPbiAy
LzEyLzE5IDI6NTQgQU0sIEdyZWcgS0ggd3JvdGU6DQo+ID4gT24gVHVlLCBGZWIgMTIsIDIwMTkg
YXQgMDY6Mjk6MzlQTSArMDgwMCwgS3lsZSBUc28gd3JvdGU6DQo+ID4+IE9uIFRodSwgSmFuIDMx
LCAyMDE5IGF0IDM6MDIgUE0gR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+
IHdyb3RlOg0KPiA+Pg0KPiA+Pj4gT24gVGh1LCBKYW4gMzEsIDIwMTkgYXQgMTE6NTQ6MTFBTSAr
MDgwMCwgS3lsZSBUc28gd3JvdGU6DQo+ID4+Pj4gUHJvdmlkZSBhIGZ1bmN0aW9uIHRvIGdldCB0
aGUgcGFydG5lciBTb3VyY2UgQ2FwYWJpbGl0aWVzLg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9m
Zi1ieTogS3lsZSBUc28gPGt5bGV0c29AZ29vZ2xlLmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAg
IGRyaXZlcnMvdXNiL3R5cGVjL3RjcG0vdGNwbS5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPj4+PiAgIGluY2x1ZGUvbGludXgvdXNiL3RjcG0uaCAgICAgIHwgIDEgKw0KPiA+Pj4+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+ID4+Pj4NCj4gPj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvdHlwZWMvdGNwbS90Y3BtLmMNCj4gPj4+IGIvZHJpdmVycy91
c2IvdHlwZWMvdGNwbS90Y3BtLmMNCj4gPj4+PiBpbmRleCBmMWQzZTU0MjEwZGYuLjI5Y2Q4NGJh
OTk2MCAxMDA2NDQNCj4gPj4+PiAtLS0gYS9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcG0uYw0K
PiA+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL3R5cGVjL3RjcG0vdGNwbS5jDQo+ID4+Pj4gQEAgLTQ0
OTQsNiArNDQ5NCwyOSBAQCBpbnQgdGNwbV91cGRhdGVfc2lua19jYXBhYmlsaXRpZXMoc3RydWN0
DQo+ID4+PiB0Y3BtX3BvcnQgKnBvcnQsIGNvbnN0IHUzMiAqcGRvLA0KPiA+Pj4+ICAgfQ0KPiA+
Pj4+ICAgRVhQT1JUX1NZTUJPTF9HUEwodGNwbV91cGRhdGVfc2lua19jYXBhYmlsaXRpZXMpOw0K
PiA+Pj4+DQo+ID4+Pj4gKy8qDQo+ID4+Pj4gKyAqIERvbid0IGNhbGwgdGhpcyBmdW5jdGlvbiBp
biBpbnRlcnJ1cHQgY29udGV4dC4gQ2FsbGVyIG5lZWRzIHRvDQo+ID4+Pj4gK2ZyZWUNCj4gPj4+
IHRoZQ0KPiA+Pj4+ICsgKiBtZW1vcnkgaXRzZWxmLg0KPiA+Pj4+ICsgKi8NCj4gPj4+PiAraW50
IHRjcG1fZ2V0X3BhcnRuZXJfc3JjX2NhcHMoc3RydWN0IHRjcG1fcG9ydCAqcG9ydCwgdTMyDQo+
ID4+Pj4gKyoqc3JjX3Bkbykgew0KPiA+Pj4+ICsgICAgIHVuc2lnbmVkIGludCBucl9wZG87DQo+
ID4+Pj4gKw0KPiA+Pj4+ICsgICAgIGlmIChwb3J0LT5ucl9zb3VyY2VfY2FwcyA9PSAwKQ0KPiA+
Pj4+ICsgICAgICAgICAgICAgcmV0dXJuIC1FTk9EQVRBOw0KPiA+Pj4+ICsNCj4gPj4+PiArICAg
ICAqc3JjX3BkbyA9IGtjYWxsb2MocG9ydC0+bnJfc291cmNlX2NhcHMsIHNpemVvZih1MzIpLCBH
RlBfS0VSTkVMKTsNCj4gPj4+PiArICAgICBpZiAoIXNyY19wZG8pDQo+ID4+Pj4gKyAgICAgICAg
ICAgICByZXR1cm4gLUVOT01FTTsNCj4gPj4+PiArDQo+ID4+Pj4gKyAgICAgbXV0ZXhfbG9jaygm
cG9ydC0+bG9jayk7DQo+ID4+Pj4gKyAgICAgbnJfcGRvID0gdGNwbV9jb3B5X3Bkb3MoKnNyY19w
ZG8sIHBvcnQtPnNvdXJjZV9jYXBzLA0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBvcnQtPm5yX3NvdXJjZV9jYXBzKTsNCj4gPj4+PiArICAgICBtdXRleF91bmxvY2soJnBv
cnQtPmxvY2spOw0KPiA+Pj4+ICsgICAgIHJldHVybiBucl9wZG87DQo+ID4+Pj4gK30NCj4gPj4+
PiArRVhQT1JUX1NZTUJPTF9HUEwodGNwbV9nZXRfcGFydG5lcl9zcmNfY2Fwcyk7DQo+ID4+Pg0K
PiA+Pj4gV2UgZG9uJ3QgYWRkIG5ldyBmdW5jdGlvbnMgdGhhdCBubyBvbmUgdXNlcyA6KA0KPiA+
Pj4NCj4gPj4+DQo+ID4+IFRoaXMgZnVuY3Rpb24gaXMgdXNlZnVsIGlmIHRoZSBQRCBEZXZpY2Ug
UG9saWN5IE1hbmFnZXIgaXMNCj4gPj4gaW1wbGVtZW50ZWQgb3V0c2lkZSBvZiBUQ1BNLg0KPiA+
PiBJbiB0aGlzIHNpdHVhdGlvbiwgRGV2aWNlIFBvbGljeSBNYW5hZ2VyIG5lZWRzIHRvIGtub3cg
dGhlIHBhcnRuZXINCj4gPj4gY2FwYWJpbGl0aWVzIHRvIG9wdGltaXplIHRoZSBjaGFyZ2luZyBw
cm9jZXNzLg0KPiA+DQo+ID4gQW5kIHdoZXJlIGlzIHRoYXQgY29kZT8NCj4gPg0KPiANCj4gQWdy
ZWVkIC0gdGhhdCBjb2RlIHNob3VsZCBiZSBzZW50IHVwc3RyZWFtIGFzIHdlbGwgdG8gbGV0IHVz
IHNlZSB0aGUgZW50aXJlDQo+IGNvbnRleHQuDQo+IA0KPiA+PiBUYWtlIGV4aXN0aW5nIGZ1bmN0
aW9ucyBpbiBUQ1BNIGZvciBleGFtcGxlOg0KPiA+PiBGdW5jdGlvbiAidGNwbV91cGRhdGVfc2lu
a19jYXBhYmlsaXRpZXMiIGFuZA0KPiA+PiAidGNwbV91cGRhdGVfc291cmNlX2NhcGFiaWxpdGll
cyIgYXJlIGV4cG9zZWQgYXMgd2VsbC4gQW5kIG5vIG9uZQ0KPiA+PiB1c2VzIHRoZW0gbm93Lg0K
PiA+DQo+ID4gR3JlYXQsIGxldCdzIGdvIGRlbGV0ZSB0aGVtIG5vdywgd2Ugc2hvdWxkIG5vdCBo
YXZlIGFwaXMgdGhhdCBubyBvbmUNCj4gPiB1c2VzLiAgVGhpcyBpc24ndCBhIG5ldyB0aGluZy4u
Lg0KPiA+DQo+IA0KPiBJIHNlbnQgYSBwYXRjaCB0byBkbyBqdXN0IHRoYXQuIFF1aXRlIGZyYW5r
bHkgSSBkb24ndCByZWNhbCB3aHkgSSB0aG91Z2h0IHRob3NlDQo+IGZ1bmN0aW9ucyBtaWdodCBi
ZSBuZWVkZWQuDQoNCkFzIGEgbWluZCBqb2cgLSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNy8x
MS8yNy8xMjU2IDopDQo=
