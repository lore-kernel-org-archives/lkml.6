Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0534FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4606218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2LtPUQMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404826AbfBOJXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:23:55 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:45148 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfBOJXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:23:54 -0500
X-IronPort-AV: E=Sophos;i="5.58,372,1544511600"; 
   d="scan'208";a="24720509"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Feb 2019 02:23:53 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 15 Feb 2019 02:23:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpxdEN3YGgGKcHG1o/1d5zs/GytzLqaE7VmPgIsVr6g=;
 b=2LtPUQMRuJS1NW1jwwykkFTE01JHmbzXE+cMvrMna052AgA34abwakMcTAyVwu5amzcBCuPV+wvnPoy21QsiakZcnidGuRdfgw/GCf9RsFXfFkkyIbn6GghiKqbtzersRjFAxZrRwnxz4HC9t5rd+2wPCjGu+BhaRSKabIStHFo=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1982.namprd11.prod.outlook.com (10.175.54.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 09:23:48 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 09:23:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <fabrice.gasnier@st.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.torgue@st.com>, <tduszyns@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 3/3] pwm: core: add consumer device link
Thread-Topic: [PATCH v3 3/3] pwm: core: add consumer device link
Thread-Index: AQHUw4p14FSdsXXDYkmaFhQjivZ9oqXgmScA
Date:   Fri, 15 Feb 2019 09:23:48 +0000
Message-ID: <f6fecafc-3946-9680-c58b-a20aa46e8e71@microchip.com>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
 <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0308.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::32) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190215112332340
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ec0e93f-a1d7-40fe-e334-08d693274a01
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1982;
x-ms-traffictypediagnostic: MWHPR11MB1982:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxOTgyOzIzOjhoRW4rVlVhMWN4ZTdSV3R1WEtFS29yNU1O?=
 =?utf-8?B?ZWl6TmVlaXRremdiMlhwbUVGalBWTHlxK2ZPMDdueVJiazk0VUdIdmlLdVRW?=
 =?utf-8?B?L2ppYWRPNkxFelNGeWQzeUVqY1IyTkF1V1ZlZGJIM05QMkFRbDZ2TjRiQkpn?=
 =?utf-8?B?VWNtTlk0NEtJYTVubVZXL0dGRWZyTlk5VjBiVDY4dnZTb2x4aU9JQWN6Smw1?=
 =?utf-8?B?Z0ZMTEp5Mkd5K2xhcnlKV0tPMjZqem9CaFNzTTRVK0U4Rk92VWI3ZzJqNjBT?=
 =?utf-8?B?UXFaN3BZUktXd1FGVzl4VjdFTkZRRUJGaDh6enBrcWlaVFVKRlg2UVZsNHA5?=
 =?utf-8?B?aXJWZG1vSDFkYkp4Z0JnNkg4WXYreU15K0gzUWFnbVcxUmowbUdrTGtoUGps?=
 =?utf-8?B?T2VjS285NXBrSzlQaWdzSnQ4UGZ4SE1PWkpHb0dybmJMUUpvUm9TZTNlYmUr?=
 =?utf-8?B?SjM2SnNIRjdxZlZlVVpSL1ZVMlMvTmJ3anZsdW1jb3RoQzJuenNhOVRxK3Bz?=
 =?utf-8?B?ZGxML1dDaWxDSXpJb0F1TmFFQ2dEY0VHMXRQQmxOcytUb1BsMnpDNElqSXlU?=
 =?utf-8?B?MDZGQTd5anFrbmV5Yk4wdU1zdFJlY3JZYjBCdmZYbThmditJZEQyVFRqbjJl?=
 =?utf-8?B?Ukc4SXM4SXlmYk9XU0FRTnd1M2hxTFNOSkE2bTVBclpibDVQcllTN1lxLzNF?=
 =?utf-8?B?Z1VhdCs5WWhqYjhZN3hvbUZtV21JTytGS0dBbVdxTlR0UkVOMUtteEJrWmVr?=
 =?utf-8?B?MzVDT2VWM2RCcmRNaWNOYVUrSWlaWG1BOEJmdStoL0JNUlVock4vSkNMdmlI?=
 =?utf-8?B?WGhXdzJXUXdXMDhTNm9pVjdJTmw1SC9haWVxek1DZWJzL3lEYzRkL3R2clJI?=
 =?utf-8?B?NkF4QmhoYkw3dzJnOUI5ME9SZkZ0aHJnclhZZHBMamNweGpjWUpOVUZiOHRH?=
 =?utf-8?B?TFRmdkZGUktGVWVlaGc4ZFUyTEY1OGRFSE9RdWZNMXhpZkwzU0FpOTVZZHZk?=
 =?utf-8?B?N1FSMFAyRUNRemVJQXkwZGw0WiszTkkzRFdwK2pmWVZMVDYydkJCZWZ5NGhU?=
 =?utf-8?B?cDNDSXFhbVg5aWJVenlKOGt6YUZDeFZoWjRTMmFrVG5JeEpBWGI4WFFOc3k5?=
 =?utf-8?B?YmdWdWh1bEN5a2p2Q3A1d09oOWNUbUh3WmY5YVh2VWZ0WE1kdXFrcE54WDht?=
 =?utf-8?B?c3FoUFpiTUJFNlhTMXZFRzMyRjUwMC9leWowOWNMbktKenFwQVFOek5XS1Ny?=
 =?utf-8?B?M29KSzVDcTdPbnhTVWdsL1VySVBYVnlEcU45Ujl2UFhDTU54cjNKSVE3SXNS?=
 =?utf-8?B?T1VuQjN4dDM5ODRJYjF1RTlUVlpBTnp6cDhUeVh1eUpTSmNBMkxrSW1UUm1m?=
 =?utf-8?B?NklCUUlZd3AxNXZqUzBRd3pYNWFUS0oyR3JLWDJ6Snd1bEhJVVRzM1hXaXgr?=
 =?utf-8?B?RDN6dHpWQWpCaDdvelhHQWdvUGoxUVFGTHNoRHJTNWNGRkhOdVZKYjhCbjJw?=
 =?utf-8?B?WTZNWVhpaHo4UmhDTmJMQkwya3V1YzFvTUIxM05zT3Rad1BieW9HRFhqRVNC?=
 =?utf-8?B?TUgxb2pYVGlacVg5WVQwOXhwZDF5ZHl0SFFVTXQ0bjhGSGhvZWtaZVlYdmgw?=
 =?utf-8?B?Q0RTWXYyZGFING52NUIwV09Fd1hGNG1TNEtlQWRoUjhTVjgwMVIwR3NjVERG?=
 =?utf-8?B?c2NoUXhqRWFZU29VWHdwWGZRaGE1NFNPS0hsR2FDWXJGS25PUHNsTW9qeW5P?=
 =?utf-8?B?WTRzUHFBRElrcTVWendFeVp4ZkswaEZ0NWs1bDF5azBETlVreU5pbHZ2bWtX?=
 =?utf-8?B?SlVSbjZCMWxFdW1yUjNiUEdoNmFHblNTbFNQQ0VwWGVNZ1E9PQ==?=
x-microsoft-antispam-prvs: <MWHPR11MB1982183F735B6992C6C6F7D087600@MWHPR11MB1982.namprd11.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(366004)(199004)(189003)(31686004)(76176011)(7416002)(106356001)(52116002)(2616005)(8676002)(105586002)(81166006)(81156014)(53546011)(476003)(31696002)(4326008)(386003)(6506007)(110136005)(54906003)(86362001)(486006)(25786009)(99286004)(6512007)(53936002)(66066001)(72206003)(7736002)(305945005)(966005)(14454004)(14444005)(256004)(26005)(6486002)(229853002)(11346002)(102836004)(478600001)(6306002)(446003)(6436002)(316002)(186003)(71190400001)(3846002)(6116002)(71200400001)(2906002)(2501003)(97736004)(8936002)(36756003)(68736007)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1982;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2TwKLEpYhHyGctN83cualIkpA/i3CTHsCSZoP8VXaoW/bKYUrWRCZizkEVsV0c9TPe9lp9HHtIrajwu26U1wylKkGvlSAytoSt6Iuvvye23pQu5d+ZvId8yins0oZSwa/5zFIa8QfAID/c+VSmCFC//e7MVc+uHav8am9KsXzvYdk4QTPIsV61zjflNvQT62bOH4JA/7zYbRRZ6q6oxcLvEhzhlYRFqBiBJ0Lcla7UnlnBqSKTdvtMwwM1xWCF22F2BqmJb9SIOJJipsCblCAbY1qD7S+rBfQmTf1ksaYsW4IcvenL0TJgbUO47Chl4+w5JWTH1xoF3AmloLiL37MqKHSoUx1q1294te41e1prEZtw2FY2L9t+q1JYUK699/TwSrCripNZguIq10Wjozqi0strDI6/LXGbohi4l/2Lc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3486EE3314710E4B81615517F5452058@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec0e93f-a1d7-40fe-e334-08d693274a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 09:23:43.6340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1982
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEzLjAyLjIwMTkgMTI6NTAsIEZhYnJpY2UgR2FzbmllciB3cm90ZToNCj4gQWRkIGEg
ZGV2aWNlIGxpbmsgYmV0d2VlbiB0aGUgUFdNIGNvbnN1bWVyIGFuZCB0aGUgUFdNIHByb3ZpZGVy
LiBUaGlzDQo+IGVuZm9yY2VzIHRoZSBQV00gdXNlciB0byBnZXQgc3VzcGVuZGVkIGJlZm9yZSB0
aGUgUFdNIHByb3ZpZGVyLiBJdA0KPiBhbGxvd3MgcHJvcGVyIHN5bmNocm9uaXphdGlvbiBvZiBz
dXNwZW5kL3Jlc3VtZSBzZXF1ZW5jZXM6IHRoZSBQV00gdXNlcg0KPiBpcyByZXNwb25zaWJsZSBm
b3IgcHJvcGVybHkgc3RvcHBpbmcgUFdNLCBiZWZvcmUgdGhlIHByb3ZpZGVyIGdldHMNCj4gc3Vz
cGVuZGVkOiBzZWUgWzFdLiBBZGQgdGhlIGRldmljZSBsaW5rIGluOg0KPiAtIG9mX3B3bV9nZXQo
KQ0KPiAtIHB3bV9nZXQoKQ0KPiAtIGRldm1fIHZhcmlhbnRzDQo+IGFzIGl0IHJlcXVpcmVzIGEg
cmVmZXJlbmNlIHRvIHRoZSBkZXZpY2UgZm9yIHRoZSBQV00gY29uc3VtZXIuDQo+IA0KPiBbMV0g
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvMi81Lzc3MA0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBU
aGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBGYWJyaWNlIEdhc25pZXIgPGZhYnJpY2UuZ2FzbmllckBzdC5jb20+DQo+IC0tLQ0KPiBDaGFu
Z2VzIGluIHYzOg0KPiAtIGFkZCBzdHJ1Y3QgZGV2aWNlIHRvIG9mX2dldF9wd20oKSBhcmd1bWVu
dHMgdG8gaGFuZGxlIGRldmljZSBsaW5rIGZyb20NCj4gICB0aGVyZS4NCj4gLS0tDQo+ICBkcml2
ZXJzL3B3bS9jb3JlLmMgIHwgMTQgKysrKysrKysrKystLS0NCj4gIGluY2x1ZGUvbGludXgvcHdt
LmggfCAgNiArKysrLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9jb3JlLmMgYi9kcml2
ZXJzL3B3bS9jb3JlLmMNCj4gaW5kZXggMTU4MWY2YS4uOGNiNWQ0YmMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvcHdtL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9jb3JlLmMNCj4gQEAgLTYz
OCw2ICs2MzgsNyBAQCBzdGF0aWMgc3RydWN0IHB3bV9jaGlwICpvZl9ub2RlX3RvX3B3bWNoaXAo
c3RydWN0IGRldmljZV9ub2RlICpucCkNCj4gIA0KPiAgLyoqDQo+ICAgKiBvZl9wd21fZ2V0KCkg
LSByZXF1ZXN0IGEgUFdNIHZpYSB0aGUgUFdNIGZyYW1ld29yaw0KPiArICogQGRldjogZGV2aWNl
IGZvciBQV00gY29uc3VtZXINCj4gICAqIEBucDogZGV2aWNlIG5vZGUgdG8gZ2V0IHRoZSBQV00g
ZnJvbQ0KPiAgICogQGNvbl9pZDogY29uc3VtZXIgbmFtZQ0KPiAgICoNCj4gQEAgLTY1NSw3ICs2
NTYsOCBAQCBzdGF0aWMgc3RydWN0IHB3bV9jaGlwICpvZl9ub2RlX3RvX3B3bWNoaXAoc3RydWN0
IGRldmljZV9ub2RlICpucCkNCj4gICAqIFJldHVybnM6IEEgcG9pbnRlciB0byB0aGUgcmVxdWVz
dGVkIFBXTSBkZXZpY2Ugb3IgYW4gRVJSX1BUUigpLWVuY29kZWQNCj4gICAqIGVycm9yIGNvZGUg
b24gZmFpbHVyZS4NCj4gICAqLw0KPiAtc3RydWN0IHB3bV9kZXZpY2UgKm9mX3B3bV9nZXQoc3Ry
dWN0IGRldmljZV9ub2RlICpucCwgY29uc3QgY2hhciAqY29uX2lkKQ0KPiArc3RydWN0IHB3bV9k
ZXZpY2UgKm9mX3B3bV9nZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5wLA0KPiArCQkJICAgICAgY29uc3QgY2hhciAqY29uX2lkKQ0KPiAgew0KPiAgCXN0cnVjdCBw
d21fZGV2aWNlICpwd20gPSBOVUxMOw0KPiAgCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgYXJnczsN
Cj4gQEAgLTY4OSw2ICs2OTEsOSBAQCBzdHJ1Y3QgcHdtX2RldmljZSAqb2ZfcHdtX2dldChzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5wLCBjb25zdCBjaGFyICpjb25faWQpDQo+ICAJaWYgKElTX0VSUihw
d20pKQ0KPiAgCQlnb3RvIHB1dDsNCj4gIA0KPiArCWlmICghZGV2aWNlX2xpbmtfYWRkKGRldiwg
cHdtLT5jaGlwLT5kZXYsIERMX0ZMQUdfQVVUT1JFTU9WRV9DT05TVU1FUikpDQo+ICsJCXByX2Rl
YnVnKCIlcygpOiBkZXZpY2UgbGluayBub3QgYWRkZWRcbiIsIF9fZnVuY19fKTsNCj4gKw0KDQpK
dXN0IGFza2luZy4uLiB3aWxsIHRoaXMgbWVjaGFuaXNtIGFsc28gYmUgd29ya2luZyBmb3IgUFdN
cyByZXF1ZXN0ZWQgdmlhDQpzeXNmcz8gQXQgYSBmaXJzdCBsb29rIGl0IHNlZW1zIG5vdC4NCg0K
VGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiAgCS8qDQo+ICAJICogSWYgYSBjb25zdW1l
ciBuYW1lIHdhcyBub3QgZ2l2ZW4sIHRyeSB0byBsb29rIGl0IHVwIGZyb20gdGhlDQo+ICAJICog
InB3bS1uYW1lcyIgcHJvcGVydHkgaWYgaXQgZXhpc3RzLiBPdGhlcndpc2UgdXNlIHRoZSBuYW1l
IG9mDQo+IEBAIC03NzEsNyArNzc2LDcgQEAgc3RydWN0IHB3bV9kZXZpY2UgKnB3bV9nZXQoc3Ry
dWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpjb25faWQpDQo+ICANCj4gIAkvKiBsb29rIHVw
IHZpYSBEVCBmaXJzdCAqLw0KPiAgCWlmIChJU19FTkFCTEVEKENPTkZJR19PRikgJiYgZGV2ICYm
IGRldi0+b2Zfbm9kZSkNCj4gLQkJcmV0dXJuIG9mX3B3bV9nZXQoZGV2LT5vZl9ub2RlLCBjb25f
aWQpOw0KPiArCQlyZXR1cm4gb2ZfcHdtX2dldChkZXYsIGRldi0+b2Zfbm9kZSwgY29uX2lkKTsN
Cj4gIA0KPiAgCS8qDQo+ICAJICogV2UgbG9vayB1cCB0aGUgcHJvdmlkZXIgaW4gdGhlIHN0YXRp
YyB0YWJsZSB0eXBpY2FsbHkgcHJvdmlkZWQgYnkNCj4gQEAgLTg1MSw2ICs4NTYsOSBAQCBzdHJ1
Y3QgcHdtX2RldmljZSAqcHdtX2dldChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKmNv
bl9pZCkNCj4gIAlwd20tPmFyZ3MucGVyaW9kID0gY2hvc2VuLT5wZXJpb2Q7DQo+ICAJcHdtLT5h
cmdzLnBvbGFyaXR5ID0gY2hvc2VuLT5wb2xhcml0eTsNCj4gIA0KPiArCWlmICghZGV2aWNlX2xp
bmtfYWRkKGRldiwgcHdtLT5jaGlwLT5kZXYsIERMX0ZMQUdfQVVUT1JFTU9WRV9DT05TVU1FUikp
DQo+ICsJCXByX2RlYnVnKCIlcygpOiBkZXZpY2UgbGluayBub3QgYWRkZWRcbiIsIF9fZnVuY19f
KTsNCj4gKw0KPiAgCXJldHVybiBwd207DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTChwd21f
Z2V0KTsNCj4gQEAgLTkzOSw3ICs5NDcsNyBAQCBzdHJ1Y3QgcHdtX2RldmljZSAqZGV2bV9vZl9w
d21fZ2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9ub2RlICpucCwNCj4gIAlp
ZiAoIXB0cikNCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+ICANCj4gLQlwd20gPSBv
Zl9wd21fZ2V0KG5wLCBjb25faWQpOw0KPiArCXB3bSA9IG9mX3B3bV9nZXQoZGV2LCBucCwgY29u
X2lkKTsNCj4gIAlpZiAoIUlTX0VSUihwd20pKSB7DQo+ICAJCSpwdHIgPSBwd207DQo+ICAJCWRl
dnJlc19hZGQoZGV2LCBwdHIpOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wd20uaCBi
L2luY2x1ZGUvbGludXgvcHdtLmgNCj4gaW5kZXggZDUxOTliNS4uODk1ZTA3NCAxMDA2NDQNCj4g
LS0tIGEvaW5jbHVkZS9saW51eC9wd20uaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3B3bS5oDQo+
IEBAIC00MDYsNyArNDA2LDggQEAgc3RydWN0IHB3bV9kZXZpY2UgKm9mX3B3bV94bGF0ZV93aXRo
X2ZsYWdzKHN0cnVjdCBwd21fY2hpcCAqcGMsDQo+ICAJCWNvbnN0IHN0cnVjdCBvZl9waGFuZGxl
X2FyZ3MgKmFyZ3MpOw0KPiAgDQo+ICBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtX2dldChzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKmNvbl9pZCk7DQo+IC1zdHJ1Y3QgcHdtX2RldmljZSAq
b2ZfcHdtX2dldChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCBjb25zdCBjaGFyICpjb25faWQpOw0K
PiArc3RydWN0IHB3bV9kZXZpY2UgKm9mX3B3bV9nZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5wLA0KPiArCQkJICAgICAgY29uc3QgY2hhciAqY29uX2lkKTsNCj4g
IHZvaWQgcHdtX3B1dChzdHJ1Y3QgcHdtX2RldmljZSAqcHdtKTsNCj4gIA0KPiAgc3RydWN0IHB3
bV9kZXZpY2UgKmRldm1fcHdtX2dldChzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKmNv
bl9pZCk7DQo+IEBAIC00OTQsNyArNDk1LDggQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgcHdtX2Rl
dmljZSAqcHdtX2dldChzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAJcmV0dXJuIEVSUl9QVFIoLUVO
T0RFVik7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyBpbmxpbmUgc3RydWN0IHB3bV9kZXZpY2UgKm9m
X3B3bV9nZXQoc3RydWN0IGRldmljZV9ub2RlICpucCwNCj4gK3N0YXRpYyBpbmxpbmUgc3RydWN0
IHB3bV9kZXZpY2UgKm9mX3B3bV9nZXQoc3RydWN0IGRldmljZSAqZGV2LA0KPiArCQkJCQkgICAg
c3RydWN0IGRldmljZV9ub2RlICpucCwNCj4gIAkJCQkJICAgIGNvbnN0IGNoYXIgKmNvbl9pZCkN
Cj4gIHsNCj4gIAlyZXR1cm4gRVJSX1BUUigtRU5PREVWKTsNCj4gDQo=
