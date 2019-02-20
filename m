Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80D5C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07B72147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="zziY0zpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfBTL1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:27:30 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:24262 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfBTL1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:27:30 -0500
X-IronPort-AV: E=Sophos;i="5.58,390,1544511600"; 
   d="scan'208";a="26588978"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2019 04:27:29 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 20 Feb 2019 04:27:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoaR730PGE2hRUUO+BgMjbxk+CSEy+gPuN8FlFdBo7c=;
 b=zziY0zpH+mjgbmcq7koUCEMxk9/y/g/iusaO+hJxKCP739a/rUl+qzF2oH14FW7kExXAU3lj8xJdEoHCjuqdN8efI1DdLkmBP1Za1Iuc952qFsn283HMcbUCdD7pi0KT3+ZXD8HbgzDvjE7ZbQWA1WWkzFTPw73W2Rq6iD+gKo8=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1808.namprd11.prod.outlook.com (10.175.53.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 11:27:25 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Wed, 20 Feb 2019
 11:27:25 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <sboyd@kernel.org>
CC:     <mturquette@baylibre.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: fix masterck name
Thread-Topic: [PATCH] clk: at91: fix masterck name
Thread-Index: AQHUv7x/dAWxQXybc0i6K8XkGPakkqXWDXGAgBKRjwA=
Date:   Wed, 20 Feb 2019 11:27:25 +0000
Message-ID: <93c2e981-f32e-7d21-d094-786b36eccc70@microchip.com>
References: <20190208144059.29861-1-alexandre.belloni@bootlin.com>
 <db6b542f-add1-af4c-e3f1-ce293042f375@microchip.com>
In-Reply-To: <db6b542f-add1-af4c-e3f1-ce293042f375@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::21) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e91334c8-07b3-4600-85f4-08d697266387
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1808;
x-ms-traffictypediagnostic: MWHPR11MB1808:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxODA4OzIzOmVZVU5zV1lTU2FQUlZNdjFIK3orRVhNUkh3?=
 =?utf-8?B?cWtWSHhabFhBVFVNMHA2cW41NUVkamhHN2gyU0lqMDZ3Tlp5aEJkdlk1SUwx?=
 =?utf-8?B?WnNPMEJzM2ZIMUNuOXZGYlhveTlpdUluZVJkRVRCRFFGdkR5ZEs2bUZEQ3Vp?=
 =?utf-8?B?c0ppTVIvQWtYdTFpdG9EaCsxV0FTS0FxcEZjUitNeW9nRCtFVUpKM0NvVlov?=
 =?utf-8?B?RllCeGZKZko5Nm9KVkhuc1ZNZFEwR2RtNUo1NG9UdzVKcTlMQ3ZJU0tLcW1R?=
 =?utf-8?B?NDJXY1NRcGM0R2NNT2EzVnFFZWJiVWpxS2xYL3FhZjd5S3FXbzJ4bzRuV1FY?=
 =?utf-8?B?Ujk0T2p4VmlKWDdaNTBLd0VTdzU0anBjTXZUV3AySEJEZWRMRlVTK3hrTEtu?=
 =?utf-8?B?UlNwS3FyU1poMThQZ1VhSWtOQWZTVzZJVWIxUzZtaDBwb0hrZFgwcXlXdUhl?=
 =?utf-8?B?YXdSZ3JENFFGUFF5dkVzRVBmWXdNSGNKQVMxTVRsakdyUmp3TEl2My8zb1Vs?=
 =?utf-8?B?TXVyWWsvMWtXdmRLeTl2NmQ3em5qSDlDcC93VnJ2Z0NsRFRmVGFBcVlvZjNF?=
 =?utf-8?B?dTlxazZoUHdtTVByVUNJV2JzempjYm5PNFpIbThYQ21vdHNJOUN2d0Z0aDNR?=
 =?utf-8?B?cTFOblNMc1ZCd0RKVnN5QmxsbTVLRDBab2ZQejNvbEk3azMyRVhFSHYrTkty?=
 =?utf-8?B?eFhXdmsrTHV5OE9wL0wxMVdlalgwMXFlb1ZNRmxhaFpaOUZRb3IvaFdxK2cv?=
 =?utf-8?B?L05QZWhvWnd6RXI3N0FCNVJmUVpzNnpVT3hSS1JSNTZUb0o1Uk9OK003UDI4?=
 =?utf-8?B?aDN6WmQySm93USt4Y2JXc2RPRnJuTHRwMS9hajVSeUlSYVVvM0h2MU5IMFIz?=
 =?utf-8?B?MnBrYWtuaStxZ3EwUmZEaXl5MmIvaUh3TUpURkhFTlZnTk5SZHhnazA4U0cx?=
 =?utf-8?B?MS81ejJidkJacmU5V1VYTWZTNktKZnpSNFF2Z01LMFFvTlR0SHE3NHRhcVB6?=
 =?utf-8?B?MGIwS1pNQVRybUovTm90SDlKakdpS2hmVXFpc1FzYStmM1dxbmNTZElueFd0?=
 =?utf-8?B?YjVXdHVIY2RWUWZ4Y3NGOGR4VHo0VHArV3RkNGRVeTYvQ2l0SGI5V2sycW4r?=
 =?utf-8?B?dktjcWw1b05GTzNUR0tVMHJCMWZaV2FTWFliWHFhTnozSFhpRUloWHhvNDVC?=
 =?utf-8?B?aEF6ckZ3MWthcjg0VnZVamNFaStlaWIyV0tvS25RK1Q0WTAzYlN2Q21UUGRL?=
 =?utf-8?B?Y1RFYWtHUmtSeDJIaGduOTkrZXZnNkxjdGpKemZkeTRlOWVjRU56ZDV3S3U2?=
 =?utf-8?B?S0wwTG5LYzBTMDE1ckwvSE9vU3czSHcyUmRoL2JTaFBGTVVmNFJWU0xldW1M?=
 =?utf-8?B?bDA0ZDljRHYzSnZNZmJrSjdoVG9YZVJoR2IxV0M1NHBtTllLRUQ1Z0VlOVJH?=
 =?utf-8?B?VEVweUhmSXV2QjF1ZVZxMFNxT2JKY2hBY0YrYTkxRXRsQzkxT0h1aFp1Vml5?=
 =?utf-8?B?Z0gyTFp2MnJDb2NqTGVYV0REQ1U5aVZCM25IVlN0cXJKU2cvbnBzZFI1ZENy?=
 =?utf-8?B?REczakovd0NvWmJSZWp1UEVLdXYwcDVEQk5IT2VocGNPZEpsTCtZWEhsT2VW?=
 =?utf-8?B?bjJRbmxvMkU4Sy9sb1c1K2VBMjBIdUhJUnNNNURwSkxydVZaUk5SN09QV0Rm?=
 =?utf-8?B?VzZTOEhUUVhpSTBwMzA0eStiTHFpR0VOMkQzNjBwZUFjZjFNb1N4TmYwSWd5?=
 =?utf-8?B?YVRNdStzUmluYlZQdjVOanZRcGZGQTdTaVpFTHFjd0MzMnNpQWFVNWZNd3RM?=
 =?utf-8?Q?6jFGnGhdjL9Zd?=
x-microsoft-antispam-prvs: <MWHPR11MB180804D75948C0DCC31E1A5CE07D0@MWHPR11MB1808.namprd11.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(366004)(396003)(346002)(199004)(189003)(71200400001)(8936002)(86362001)(6512007)(54906003)(7736002)(316002)(305945005)(25786009)(99286004)(72206003)(478600001)(68736007)(53936002)(110136005)(81156014)(81166006)(8676002)(5660300002)(71190400001)(76176011)(66066001)(52116002)(6486002)(6436002)(4326008)(256004)(476003)(102836004)(229853002)(26005)(186003)(14444005)(3846002)(2906002)(6116002)(31696002)(6246003)(6506007)(446003)(386003)(486006)(36756003)(31686004)(11346002)(14454004)(105586002)(106356001)(53546011)(97736004)(2616005)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1808;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BEETu+ORMjfFaTpmEOf7vlmbms8ly/bIV2f21VquHQ7EdERCbf4Z4/9jXBFIDvuS58vhZg1Ok5SxAiqg4XHsKyFC2SwO26mGZAXxFGGRTF+23FwWFZn+cKC4SN3iAgQfpm0M7lWkZh4Kqbv+MRdCy0Gq6hY9R9fpsT6x9gSu5RDd2v2pg9Fc6qbP65bTk3EWd9WV3CF6+mmbmxoDoZsZSd4dZI7h/ADeSi1vNaMhbCbh78YLAz1tzNkyEmTyvnK8vS+9bYfpvVLapei2eEdIxigD5cvv1rdwAgbdmKySb2c+SDPpAxORi6UNQCHfYaYl5foDvbKFX2MI9bJLlzrR1HdP/9gqEIN41X5J2ejXzz8+kwirA4VkXXguhVw8D9d5PoJQSx+9r+62c1U8ykeAXB75Je+Mj40ugOPZL1CYiqk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <119F4639F6E5B543B98F047024A54316@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e91334c8-07b3-4600-85f4-08d697266387
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:27:23.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1808
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDIvMjAxOSBhdCAxNjo1MywgTmljb2xhcy5GZXJyZUBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPiBPbiAwOC8wMi8yMDE5IGF0IDE1OjQwLCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90ZToNCj4+
IFRoZSBtYXN0ZXIgY2xvY2sgaXMgYWN0dWFsbHkgbmFtZWQgbWFzdGVyY2sgZWFybGllciBpbiB0
aGUgZHJpdmVyLiBIYXZpbmcNCj4+ICJtY2siIGluIHRoZSBwYXJlbnQgbGlzdCBtZWFucyB0aGF0
IGl0IGNhbiBuZXZlciBiZSBzZWxlY3RlZC4NCj4+DQo+PiBGaXhlczogMWVhYmRjMmY5ZGQ4ICgi
Y2xrOiBhdDkxOiBhZGQgYXQ5MXNhbTl4NSBQTUNzIGRyaXZlciIpDQo+PiBGaXhlczogYTIwMzgw
NzdkZTlhICgiY2xrOiBhdDkxOiBhZGQgc2FtYTVkMiBQTUMgZHJpdmVyIikNCj4+IEZpeGVzOiAw
ODRiNjk2YmI1MDkgKCJjbGs6IGF0OTE6IGFkZCBzYW1hNWQ0IHBtYyBkcml2ZXIiKQ0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290
bGluLmNvbT4NCj4gDQo+IEFja2VkLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1p
Y3JvY2hpcC5jb20+DQoNCisNCkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2NC4yMCsN
Cg0KU3RlcGhlbiAocGluZyksDQoNClRoaXMgcGF0Y2ggdG9nZXRoZXIgd2l0aCB0aGUgb25lIHNl
bnQgdG9kYXkgIltQQVRDSF0gY2xrOiBhdDkxOiBmaXggDQphdDkxc2FtOXg1IHBlcmlwaGVyYWwg
Y2xvY2sgbnVtYmVyIiBtYWtlIGEgZ29vZCBzZXQgZm9yIDUuMC1maW5hbCBhcyANCnRoZXkgYmFz
aWNhbGx5IGFyZSByZWFsIHJlZ3Jlc3Npb25zLg0KVGhpcyBpcyB0cnVlIGV2ZW4gaWYgdGhleSBh
cHBseSBvbiA0LjIwIGFzIHdlIHdlcmUgdXNpbmcgYW4gb2xkZXIgYmlkaW5nIA0KZGVmaW5pdGlv
biB1bnRpbCA1LjAtcmMuLi4NCg0KRG8gd2hhdCB5b3UgY2FuLi4uIEFzIGl0J3MgcmVhbGx5IGxh
dGUsIEkga25vdy4uLg0KDQpCZXN0IHJlZ2FyZHMsDQogICBOaWNvbGFzDQoNCg0KPj4gLS0tDQo+
PiAgICBkcml2ZXJzL2Nsay9hdDkxL2F0OTFzYW05eDUuYyB8IDIgKy0NCj4+ICAgIGRyaXZlcnMv
Y2xrL2F0OTEvc2FtYTVkMi5jICAgIHwgNCArKy0tDQo+PiAgICBkcml2ZXJzL2Nsay9hdDkxL3Nh
bWE1ZDQuYyAgICB8IDIgKy0NCj4+ICAgIDMgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL2F0
OTFzYW05eDUuYyBiL2RyaXZlcnMvY2xrL2F0OTEvYXQ5MXNhbTl4NS5jDQo+PiBpbmRleCAyZmUy
MjVhNjk3ZGYuLmQ1NWExNTFjYjdmNSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY2xrL2F0OTEv
YXQ5MXNhbTl4NS5jDQo+PiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL2F0OTFzYW05eDUuYw0KPj4g
QEAgLTIxMCw3ICsyMTAsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgYXQ5MXNhbTl4NV9wbWNfc2V0
dXAoc3RydWN0IGRldmljZV9ub2RlICpucCwNCj4+ICAgIAlwYXJlbnRfbmFtZXNbMV0gPSAibWFp
bmNrIjsNCj4+ICAgIAlwYXJlbnRfbmFtZXNbMl0gPSAicGxsYWRpdmNrIjsNCj4+ICAgIAlwYXJl
bnRfbmFtZXNbM10gPSAidXRtaWNrIjsNCj4+IC0JcGFyZW50X25hbWVzWzRdID0gIm1jayI7DQo+
PiArCXBhcmVudF9uYW1lc1s0XSA9ICJtYXN0ZXJjayI7DQo+PiAgICAJZm9yIChpID0gMDsgaSA8
IDI7IGkrKykgew0KPj4gICAgCQljaGFyIG5hbWVbNl07DQo+PiAgICANCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDIuYyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5j
DQo+PiBpbmRleCBkNjlhZDk2ZmU5ODguLmNkMGVmNzI3NGZkYiAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5jDQo+PiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL3NhbWE1
ZDIuYw0KPj4gQEAgLTI0MCw3ICsyNDAsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgc2FtYTVkMl9w
bWNfc2V0dXAoc3RydWN0IGRldmljZV9ub2RlICpucCkNCj4+ICAgIAlwYXJlbnRfbmFtZXNbMV0g
PSAibWFpbmNrIjsNCj4+ICAgIAlwYXJlbnRfbmFtZXNbMl0gPSAicGxsYWRpdmNrIjsNCj4+ICAg
IAlwYXJlbnRfbmFtZXNbM10gPSAidXRtaWNrIjsNCj4+IC0JcGFyZW50X25hbWVzWzRdID0gIm1j
ayI7DQo+PiArCXBhcmVudF9uYW1lc1s0XSA9ICJtYXN0ZXJjayI7DQo+PiAgICAJZm9yIChpID0g
MDsgaSA8IDM7IGkrKykgew0KPj4gICAgCQljaGFyIG5hbWVbNl07DQo+PiAgICANCj4+IEBAIC0y
OTEsNyArMjkxLDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHNhbWE1ZDJfcG1jX3NldHVwKHN0cnVj
dCBkZXZpY2Vfbm9kZSAqbnApDQo+PiAgICAJcGFyZW50X25hbWVzWzFdID0gIm1haW5jayI7DQo+
PiAgICAJcGFyZW50X25hbWVzWzJdID0gInBsbGFkaXZjayI7DQo+PiAgICAJcGFyZW50X25hbWVz
WzNdID0gInV0bWljayI7DQo+PiAtCXBhcmVudF9uYW1lc1s0XSA9ICJtY2siOw0KPj4gKwlwYXJl
bnRfbmFtZXNbNF0gPSAibWFzdGVyY2siOw0KPj4gICAgCXBhcmVudF9uYW1lc1s1XSA9ICJhdWRp
b3BsbF9wbWNjayI7DQo+PiAgICAJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoc2FtYTVkMl9n
Y2spOyBpKyspIHsNCj4+ICAgIAkJaHcgPSBhdDkxX2Nsa19yZWdpc3Rlcl9nZW5lcmF0ZWQocmVn
bWFwLCAmcG1jX3Bjcl9sb2NrLA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvc2Ft
YTVkNC5jIGIvZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQ0LmMNCj4+IGluZGV4IGUzNThiZTdmNmM4
ZC4uYjY0NWE5ZDU5Y2RiIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQ0
LmMNCj4+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTVkNC5jDQo+PiBAQCAtMjA3LDcgKzIw
Nyw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzYW1hNWQ0X3BtY19zZXR1cChzdHJ1Y3QgZGV2aWNl
X25vZGUgKm5wKQ0KPj4gICAgCXBhcmVudF9uYW1lc1sxXSA9ICJtYWluY2siOw0KPj4gICAgCXBh
cmVudF9uYW1lc1syXSA9ICJwbGxhZGl2Y2siOw0KPj4gICAgCXBhcmVudF9uYW1lc1szXSA9ICJ1
dG1pY2siOw0KPj4gLQlwYXJlbnRfbmFtZXNbNF0gPSAibWNrIjsNCj4+ICsJcGFyZW50X25hbWVz
WzRdID0gIm1hc3RlcmNrIjsNCj4+ICAgIAlmb3IgKGkgPSAwOyBpIDwgMzsgaSsrKSB7DQo+PiAg
ICAJCWNoYXIgbmFtZVs2XTsNCj4+ICAgIA0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KTmljb2xhcyBG
ZXJyZQ0K
