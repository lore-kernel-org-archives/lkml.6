Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC20C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB962175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="dzliPKzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393210AbfBMRiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:38:12 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:25704 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390306AbfBMRiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:38:05 -0500
X-IronPort-AV: E=Sophos;i="5.58,366,1544511600"; 
   d="scan'208";a="26504863"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2019 10:37:51 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 10:37:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmimxU55TllXSOjDWoihlOkLtXWVGJUmNFDjygcYR3w=;
 b=dzliPKzAWuHwkFwWAItnSOZWXptuMNQ8/k0T34xu3luLdfq5Wu1sZI3cSYAzyuSe4zE6R/hXQM5hOTYy6+mT/baF7dPJCRrwcB+i781EYXV3TUZzDhQpzgXCahzeGmx0CNBvGaS0qCgxUIHNrVMDvuJLKEJaSbJkMI+VDMEb8GA=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1378.namprd11.prod.outlook.com (10.173.33.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 17:37:49 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 17:37:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <palmer@sifive.com>, <marek.vasut@gmail.com>
CC:     <wesley@sifive.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <paul.walmsley@sifive.com>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>
Subject: Re: [PATCH v2 2/2] spi-nor: add support for is25wp256
Thread-Topic: [PATCH v2 2/2] spi-nor: add support for is25wp256
Thread-Index: AQHUu8lZNYJ2Ubpy8EavTZ/VcmOfWqXeCw0AgAADBAA=
Date:   Wed, 13 Feb 2019 17:37:49 +0000
Message-ID: <92a75f0c-372f-df8e-f99d-264217046f55@microchip.com>
References: <20180807194059.26348-1-palmer@sifive.com>
 <20180807194059.26348-3-palmer@sifive.com>
 <ef174850-93df-6032-c742-68237c37afde@microchip.com>
In-Reply-To: <ef174850-93df-6032-c742-68237c37afde@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0068.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::12) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 071c789d-7f01-4c9b-0bdd-08d691d9f8e2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1378;
x-ms-traffictypediagnostic: BN6PR11MB1378:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCTjZQUjExTUIxMzc4OzIzOmxHUWRnNjNyQ0ZUR0dVWFpoM1pDYlo1SEFz?=
 =?utf-8?B?OHBJcXpwYVZueTNEQ2NVdDRveVdJK2phdlc1Z2tybGZzUzloTU13YUpycm9I?=
 =?utf-8?B?bUFhQzN1bXJZYjVONFdRTUVWZVQwYzdmVjI2K1A1bVRDRlFOdUdzRHBzUVVD?=
 =?utf-8?B?ZFFwbWUwb3hGeWVCMit1V1ZWalpRdXluYk1QS3NKM1hiOG55WUJ5OWVQY29H?=
 =?utf-8?B?YUIrRWQyRkRIUVRqaHAvVGpDVjZXVUh3eTRyS3hpbU5mZ2ljeE80aWNNcjJr?=
 =?utf-8?B?anVRa1g4YTdvSkZxYmdGTVkzSHJkRmp6MDdwL3NrVFZFOVp5REgxc2FIM282?=
 =?utf-8?B?TUtjQWZVQ0E2OHFMdmQyU2lFMFNrREVRK1VTcXcxVGFWWmg4SnRmU2p4MHls?=
 =?utf-8?B?dFM4c0Y1YnFlcHJjeGZScythaW1jNG1pbWpxOTVHYjlBL09ocnEzS1Z4Y0lL?=
 =?utf-8?B?UUVRR2RYSWdCRk82MnljSnRtWW1kMDk5azF4UHVDeHBZUmN3dVZJYWdpcm1w?=
 =?utf-8?B?UlFGK2E2Nkp3K1RiTlhjemxCc0FraTBOSHYxZ3dTTGF4VGVzZ3VqTFEyaStF?=
 =?utf-8?B?VGFma1hCSTlKdnVUbkphRkFTQXY1cDc5eHVBN2JDSS92OHlKZTB3SnlsNTd3?=
 =?utf-8?B?N2lZRWlsZVhtK1FOOHE1eU5aN25DZms5WjB0Vjg2ZHJCcEhtUllybTRxMERs?=
 =?utf-8?B?MzkrVHpZL2JYd1BpcjNhU2UxSmc5OXhENUZZSnJSMVJOYmRtN0l2TjdOY2Q4?=
 =?utf-8?B?YjRwN3RuUkRaZUlEYTFWQ3cybUhwMTQzbzNiQ1hiZ3o5bWplcG9UMGVLTTNk?=
 =?utf-8?B?RWsxWUllMkdBVmwxTkpxL0FEOHlEamp3cGZ6d24yTmdXYU9McmdOcldENlhO?=
 =?utf-8?B?YktqMVpDZnlWYjdXdmx1SjlFVTRYVkgveFVvR2xTeCtHYmxhSlVHdjJtNVQ5?=
 =?utf-8?B?NUJReitoR2VIRi9KWThXbWhhUU16dWlaaW91MEZEaFprQzhqRzBjY0JIemw1?=
 =?utf-8?B?OXRTNFBRRVcxNHZPS2xyYklHYVczd2Z6eHkxelkyNWpxcWd0ZytsTW1qTDhD?=
 =?utf-8?B?dy9JMGorL21TZ2JudDFNTWNodEVFQ3hxR0lra2Y4UDRhemlwTmQ4cG1Gd1Vs?=
 =?utf-8?B?c0NJNGtVNEJtR0ZQbEczV2t5eHY2MGlOSzNsN2ZyLzhrNEJPQWFnTDN5TWZ6?=
 =?utf-8?B?Z1NIa0ZlM3J0Nzc5ZGc0VG5BeUJyUy85WC9oR1Evc3gwUk1lZ04wRndpK00y?=
 =?utf-8?B?NVVNYWYxK3plamVWQkFaVlpRSmlQOXJEeWxQSGx2T1Fwci9BT1RmWk8xLzRF?=
 =?utf-8?B?azAvUEpuenhCRno1QVM2eXF3YjhPWG5sRThwYU9JS2gzT1AxcERKN1hFSEYx?=
 =?utf-8?B?MFl6aEhLeUVjK3pBeUhkckZHWDV4NWhWUm42c2JiRGc1bDBUY1hYSU54alJj?=
 =?utf-8?B?RThPcEdlSnljVlhQSTBDN21yZm5oc25scHFlcW0zK1ZtU1o3NE8raFdJQTE1?=
 =?utf-8?B?eVFWV1lrc05meTVFM3J6QUJwdFNGbW1kU0lmeWN0VXEwcU4wVTNnbGlmQS9t?=
 =?utf-8?B?NWxvYzFMSTZscnJSRUIxdlh1S3RUTVBhbmwrR0NNQ2NYRjZBWlQvN1NaRzMy?=
 =?utf-8?B?SFkyRCtHeGNzZHIrdHp4K05zbXN0UzB4UGlkRHlRZ2QzL1c1NXZJcXhxSjJv?=
 =?utf-8?B?UVRWUko5MDBmTmhVS0MyU3kwZlYxcENQdllQenV3NmNTM3NGd3g3ZGdkamVs?=
 =?utf-8?B?dTk3Z2JWcklubEpSeEJ4RzAvYmtJWFdzL2NDNTRJdERJOXZrWTFCNnk3SXAr?=
 =?utf-8?B?RS9OR0lrLzZpeTFnN2sxMnp0c1FCZ0JyVmNHRjM4b29aTEE9PQ==?=
x-microsoft-antispam-prvs: <BN6PR11MB13783DB1AB4520DBC8B43078F0660@BN6PR11MB1378.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(53546011)(7416002)(386003)(6506007)(7736002)(6486002)(229853002)(6436002)(106356001)(476003)(486006)(2616005)(305945005)(105586002)(11346002)(6116002)(446003)(3846002)(4326008)(102836004)(26005)(25786009)(31686004)(186003)(14444005)(68736007)(76176011)(52116002)(478600001)(72206003)(2906002)(6246003)(2501003)(71190400001)(8676002)(81166006)(81156014)(8936002)(86362001)(6512007)(14454004)(66066001)(97736004)(71200400001)(31696002)(36756003)(256004)(316002)(54906003)(99286004)(53936002)(110136005)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1378;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RDsogw1e1Y7OOnG8axbYngXP8JFMLzHmnk6J5yq817aA+Z1BdcIrkxDgXAgE7Tz7OfLDEwVF+DaLI4Cu46QK9jTJsgDPdy28hwU4CCTXZedy2X4lAwQdyhy9V1CIZlA/sUSzJpxQujFsSitQ9QT5pjDgkPj0mFVe7T4Rz6C7N9FesXdDOZQiUAMI0Avuc+OJse3kipIh5jvbRLrqL+lNybqk6hzsU2at8xR3JngLZQXM+HdU0OZjhSCns3fQRMSW7YpH0UWskuysDXttGqyd5Ox8XlbVfeQyPlGTu4Nfu/ylyHvhQHeel6tIB9X+vDAR3iDDDJJgO8hKMIqTPctZdhLXcq18ZtDzDyhzNy/t8iIVkzqakPXPqaZYF+iulJh5CKHtlqhbWqGxwwllMwHHINyX9iOqaToQuy9xofnOCYg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47E67AA48EDB804A9BCD83DC11602D73@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 071c789d-7f01-4c9b-0bdd-08d691d9f8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 17:37:47.2885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1378
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzEzLzIwMTkgMDc6MjcgUE0sIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4gSGksDQo+IA0KPiBUaGlzIG9uZSBsb29rcyBwcmV0dHkgZ29vZC4gWW91J2xsIGhh
dmUgdG8gc3RhcnQgdGhlIHBhdGNoJ3Mgc3ViamVjdCB3aXRoICJtdGQ6DQo+IHNwaS1ub3I6IiBp
bnN0ZWFkIG9mIGp1c3QgInNwaS1ub3IiLg0KPiANCj4gV2hlbiBpbiBkb3VidCwgcnVuIGdpdCBs
b2cgLS1vbmVsaW5lIG9uIHRoZSBmaWxlIHRoYXQgeW91IGFyZSBtb2RpZnlpbmcgYW5kIHNlZQ0K
PiBob3cgcHJldmlvdXMgcGF0Y2hlcyBhcmUgcHJlZml4aW5nIHRoZSBzdWJqZWN0Lg0KPiANCj4g
T24gMDgvMDcvMjAxOCAxMDo0MCBQTSwgUGFsbWVyIERhYmJlbHQgd3JvdGU6DQo+PiBGcm9tOiAi
V2VzbGV5IFcuIFRlcnBzdHJhIiA8d2VzbGV5QHNpZml2ZS5jb20+DQo+Pg0KPj4gVGhpcyBpcyB1
c2VkIG9mIHRoZSBIaUZpdmUgVW5sZWFzaGVkIGRldmVsb3BtZW50IGJvYXJkLCBhbmQgZm9sbG93
cyB0aGUNCj4+IHBhdHRlcm4gb2Ygc2ltaWxhciBJU1NJIGRldmljZXMgYWxyZWFkeSBsaXN0ZWQu
DQo+Pg0KPiBQbGVhc2UgYWRkIGEgY29tbWVudCBhbmQgbGV0IHVzIGtub3cgaG93IHlvdSB0ZXN0
ZWQgdGhlIGZsYXNoLCBpdCdzIGFsd2F5cw0KPiBjb21mb3J0YWJsZSB0byBzZWUgdGhhdCBuZXcg
c3VwcG9ydCB3YXMgYWN0dWFsbHkgdGVzdGVkLg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IFdlc2xl
eSBXLiBUZXJwc3RyYSA8d2VzbGV5QHNpZml2ZS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYWxt
ZXIgRGFiYmVsdCA8cGFsbWVyQHNpZml2ZS5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL210ZC9z
cGktbm9yL3NwaS1ub3IuYyB8IDIgKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIGIv
ZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+IGluZGV4IGFhYjkzNDYzYTVlNy4uZjEw
MDE3YjQ1NDNkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+PiBAQCAtMTA3Miw2ICsx
MDcyLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHNwaV9ub3JfaWRzW10gPSB7
DQo+PiAgCQkJU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQp
IH0sDQo+PiAgCXsgImlzMjV3cDEyOCIsICBJTkZPKDB4OWQ3MDE4LCAwLCA2NCAqIDEwMjQsIDI1
NiwNCj4+ICAJCQlTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVB
RCkgfSwNCj4+ICsJeyAiaXMyNXdwMjU2IiwgIElORk8oMHg5ZDcwMTksIDAsIDY0ICogMTAyNCwg
NTEyLA0KPj4gKwkgICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwg
U1BJX05PUl9RVUFEX1JFQUQpIH0sDQoNCmRvbid0IGZvcmdldCB0byBmaXggdGhlIGNoZWNrcGF0
Y2ggd2FybmluZyB3aGVuIHJlc3VibWl0dGluZzoNCiQgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1zdHJpY3QgdjItMi0yLXNwaS1ub3ItYWRkLXN1cHBvcnQtZm9yLWlzMjV3cDI1Ni5wYXRjaCAN
CkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgdXNlIHRhYnMgd2hlcmUgcG9zc2libGUNCiM0MDog
RklMRTogZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmM6MTA3NjoNCiteSSAgICAgICAgICAg
ICAgICBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCkgfSwk
DQoNCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMCBjaGVja3MsIDggbGluZXMgY2hlY2tl
ZA0KPiANCj4gWW91IG1pc3NlZCB0aGUgU1BJX05PUl80Ql9PUENPREVTIGZsYWcuIFRoZSBmbGFz
aCBoYXMgNEIgb3Bjb2RlcywgbGV0J3MgdXNlIHRoZW0uDQo+IA0KPiBDaGVlcnMsDQo+IHRhDQo+
IA0K
