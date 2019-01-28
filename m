Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA69BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ADA20855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fbM80AMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfA1S2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:28:41 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3107 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfA1S2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:28:41 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4f49bb0000>; Mon, 28 Jan 2019 10:28:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 28 Jan 2019 10:28:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 28 Jan 2019 10:28:38 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 18:28:38 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 18:28:37 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.50) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Mon, 28 Jan 2019 18:28:37 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3543.namprd12.prod.outlook.com (20.179.94.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Mon, 28 Jan 2019 18:28:36 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 18:28:36 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V3 2/3] i2c: tegra: Update transfer timeout
Thread-Topic: [PATCH V3 2/3] i2c: tegra: Update transfer timeout
Thread-Index: AQHUtStT3b8oUo3Te0iK36R9j5w2yqXB2CeAgAMogjA=
Date:   Mon, 28 Jan 2019 18:28:36 +0000
Message-ID: <BYAPR12MB3398E9D32B57B0E2FC2A6466C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
 <1548475073-12408-2-git-send-email-skomatineni@nvidia.com>
 <0cf91475-f77d-7453-deb6-3dd91b63aeb6@gmail.com>
In-Reply-To: <0cf91475-f77d-7453-deb6-3dd91b63aeb6@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3543;6:mvJjlsp/mrtZx+843bGqjObgyRhZY+ptvGYSPqB+XHCKY8/9epwO2UveREn985MFgyrfrl6tVxpYVwwtdD4QQZYKd56jJtXiAfG+P+zbA11fYCR3IdPQ2F1Mbpudy4WXykNG+BESPxONzUheLf1V5k7h00uzaeq0dIQ8X0owe/bhG4QfTp1NkpIwg6NneoZli1OK0RfAIAVQblnD9spUl8TvnUr4FbrBIgrNbGJj/v7E+FDmSB6aVcd49uh45EePYpdHSUaffxpTIneLk9vyoH77rttmMailLy+7tGeQPWWmsIlYbwImqk6pcGMVKBnFfE3eKKbt8AWA82281TMPQTb0en2ewhziJ2C8ollKVdHwgkqqY4lTESW/lKOaO1MK62BuGE4Lr0/QqKf6Criw8fbjncB5RBkAl+iVNvx/8BXYdX5B30q3Kbz4qa2ejnXwlw6CjJ/s/enT7yhcHICOYQ==;5:jIfbap/vncdrvVJdVDh5Ty2zzzTWT8z7HKRb9S5QTXt2sxuruwqzhfu6e+J02roDxJZEHaZ2lAojRUSL3IWo8aPCjrVoxN+L+MnKeQY+vaJ12ufSnVaP6nScEw2klACeyUTUr0NiMTIXalAS9DCPFNS1lisY2wP7PRvpKiDouQB+yIss80rmAuZqATpfgue3rdNUX5hEbdgx8Y4AdjZOXA==;7:ON9fGIElGemML19PD9nTKEhtoPBIrw3tjVS8oQ0D9DbUT8gVy5LE56Vclyc93+t49w1v+EqqnEDnfQc3+PUMreBPtaRqTrd+GAUN92dwOSpOGkkXRbsS8dKnIQYv01E1YResufoZxvscd6Of1J5E3A==
x-ms-office365-filtering-correlation-id: 4c41aa47-72d2-41f7-0b76-08d6854e6ab8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3543;
x-ms-traffictypediagnostic: BYAPR12MB3543:
x-microsoft-antispam-prvs: <BYAPR12MB354314DB978A4EEC376FAF7DC2960@BYAPR12MB3543.namprd12.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(68736007)(6436002)(15650500001)(97736004)(74316002)(86362001)(106356001)(2501003)(9686003)(66066001)(478600001)(11346002)(53936002)(7736002)(4326008)(39060400002)(105586002)(6246003)(55016002)(305945005)(14454004)(446003)(6116002)(2906002)(6506007)(186003)(14444005)(81166006)(486006)(229853002)(256004)(71190400001)(81156014)(33656002)(8676002)(25786009)(8936002)(26005)(102836004)(54906003)(6636002)(316002)(76176011)(476003)(110136005)(7696005)(71200400001)(3846002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3543;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ktxHkzsk7rUmX99xsXcdXtM259aatx96xyTt6OdEbGWXVOxrWJurGTUzOOMoeKNo9IcoDRCm3sjQrfKuVn31ybA1fFladXeQs7VkB1sMA7VSMt3Q+9samu+rXh5SlEOEfyuxEY5qLDiSwNy9WITGsdfS2bFK2zGz887dPTtIDdVcxA+1X5zVXQhd8EDrlpfL7oal5WRafomjg0MeCl2IMXFsGkymdFDuGUJzMwYFiKpzkA4GNygpEYZa5+Fri/KVT8Nkl0ezYUZGdJShMfK/HbelK0xYSsF9zBzsL1m4GSLkQkIOgVw9+M1BCmdAqui5b7Gc8yfGi33tJEzy8GdsDlC2MqkhoXPINMnqklJmBiYLlU298+FpYWXWbgShoRvHXKkoETSCIO7RR1aInul+RWPvPfyl4FXITotnmTs2wh8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c41aa47-72d2-41f7-0b76-08d6854e6ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 18:28:36.2482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3543
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548700091; bh=RffCxKjfztHaZwe4CAlkPi3XFIriMiW4LBqcUJRKx/c=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=fbM80AMGEfuEUh6ztA4FuqYDSINaNL1Hjt1VUkT91wtWp9dTVl8QVyQ19VrdqNHke
         UIVUzZdgYlA7Un5MAM6GbpJiZQw7W+VFqf+wl3XLrEiKe1IPXsI5LZ0dPPQI9HxxGE
         ljVmiMGnrZWw3zGpcq+SYocptCio+Sgl+1oyyrso1AkNpFJ7To05fLuoO89VU1e8K8
         FgM2MMmtrRLYissixEEhA5JmJJjBwxciV7l7P6zUSo6qJxL6IWQoBCIDJvORwG1SXw
         BQxKk24xXC9jMPSfjjj7p1Oe5aw5fn42ZWRRei0QS5m1UDyRPYCj+yILkadHT3qHz6
         z3B2stGpgKPwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPiBVcGRhdGUgSTJDIHRyYW5zZmVyIHRpbWVvdXQgYmFzZWQgb24gdHJhbnNmZXIgYnl0
ZXMgYW5kIEkyQyBidXMgcmF0ZSANCj4gPiB0byBhbGxvdyBlbm91Z2ggdGltZSBkdXJpbmcgbWF4
IHRyYW5zZmVyIHNpemUgYmFzZWQgb24gdGhlIHNwZWVkLg0KPg0KPiBDb3VsZCBpdCBiZSB0aGF0
IEkyQyBkZXZpY2UgaXMgYnVzeSBhbmQganVzdCBzbG93bHkgaGFuZGxpbmcgdGhlIHRyYW5zZmVy
IHJlcXVlc3RzPyBNYXliZSBiZXR0ZXIgdG8gbGVhdmUgdGhlIHRpbWVvdXQgYXMtaXMgYW5kIGFz
c3VtZSB0aGUgd29yc3QgY2FzZSBzY2VuYXJpbz8NCj4NClRoaXMgY2hhbmdlIGluY2x1ZGVzIG1p
biB0cmFuc2ZlciB0aW1lIG91dCBvZiAxMDBtcyBpbiBhZGRpdGlvbiB0byBjb21wdXRlZCB0aW1l
b3V0IGJhc2VkIG9uIHRyYW5zZmVyIGJ5dGVzIGFuZCBzcGVlZCB3aGljaCBjYW4gYWNjb3VudCBp
biBjYXNlcyBvZiBzbGF2ZSBkZXZpY2VzIHJ1bm5pbmcgYXQgc2xvd2VyIHNwZWVkLg0KQWxzbyBU
ZWdyYSBJMkMgTWFzdGVyIHN1cHBvcnRzIENsb2NrIHN0cmV0Y2hpbmcgYnkgdGhlIHNsYXZlLg0K
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogU293amFueWEgS29tYXRpbmVuaSA8c2tvbWF0aW5l
bmlAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgW1YzXSA6IFNhbWUgYXMgVjINCj4gPiAgW1Yy
XSA6IEFkZGVkIHRoaXMgcGF0Y2ggaW4gVjIgc2VyaWVzIHRvIGFsbG93IGVub3VnaCB0aW1lIGZv
ciBkYXRhIHRyYW5zZmVyDQo+ID4gCXRvIGhhcHBlbi4NCj4gPiAJVGhpcyBwYXRjaCBoYXMgZGVw
ZW5kZW5jeSB3aXRoIERNQSBwYXRjaCBhcyBURUdSQV9JMkNfVElNRU9VVCBkZWZpbmUNCj4gPiAJ
dGFrZXMgYXJndW1lbnQgd2l0aCB0aGlzIHBhdGNoLg0KPiA+IA0KPiA+ICBkcml2ZXJzL2kyYy9i
dXNzZXMvaTJjLXRlZ3JhLmMgfCAxOCArKysrKysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtdGVncmEuYyANCj4gPiBiL2RyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtdGVncmEuYyBpbmRleCBhZWM1MDBlZjlhOTguLjNkY2JjOTk2MGQ5ZCANCj4g
PiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMNCj4gPiBAQCAtMjMsNyArMjMsNyBA
QA0KPiA+ICAjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3Ns
YWIuaD4NCj4gPiAgDQo+ID4gLSNkZWZpbmUgVEVHUkFfSTJDX1RJTUVPVVQgKG1zZWNzX3RvX2pp
ZmZpZXMoMTAwMCkpDQo+ID4gKyNkZWZpbmUgVEVHUkFfSTJDX1RJTUVPVVQobXMpIChtc2Vjc190
b19qaWZmaWVzKG1zKSkNCj4gPiAgI2RlZmluZSBCWVRFU19QRVJfRklGT19XT1JEIDQNCj4gPiAg
DQo+ID4gICNkZWZpbmUgSTJDX0NORkcJCQkJMHgwMDANCj4gPiBAQCAtMTE2LDYgKzExNiw5IEBA
DQo+ID4gICNkZWZpbmUgSTJDX01TVF9GSUZPX1NUQVRVU19UWF9NQVNLCQkweGZmMDAwMA0KPiA+
ICAjZGVmaW5lIEkyQ19NU1RfRklGT19TVEFUVVNfVFhfU0hJRlQJCTE2DQo+ID4gIA0KPiA+ICsv
KiBQYWNrZXQgaGVhZGVyIHNpemUgaW4gYnl0ZXMgKi8NCj4gPiArI2RlZmluZSBJMkNfUEFDS0VU
X0hFQURFUl9TSVpFCQkJMTINCj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIG1zZ19lbmRfdHlwZTog
VGhlIGJ1cyBjb250cm9sIHdoaWNoIG5lZWQgdG8gYmUgc2VuZCBhdCBlbmQgb2YgdHJhbnNmZXIu
DQo+ID4gICAqIEBNU0dfRU5EX1NUT1A6IFNlbmQgc3RvcCBwdWxzZSBhdCBlbmQgb2YgdHJhbnNm
ZXIuDQo+ID4gQEAgLTY4Myw2ICs2ODYsMTcgQEAgc3RhdGljIGludCB0ZWdyYV9pMmNfeGZlcl9t
c2coc3RydWN0IHRlZ3JhX2kyY19kZXYgKmkyY19kZXYsDQo+ID4gIAl1MzIgaW50X21hc2s7DQo+
ID4gIAl1bnNpZ25lZCBsb25nIHRpbWVfbGVmdDsNCj4gPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
DQo+ID4gKwl1MTYgeGZlcl90aW1lID0gMTAwOw0KPiA+ICsJc2l6ZV90IHhmZXJfc2l6ZSA9IDA7
DQo+DQo+IE5vIG5lZWQgdG8gaW5pdGlhbGl6ZSB4ZmVyX3NpemUgdG8gMC4NCj4NCj4gPiArDQo+
ID4gKwlpZiAobXNnLT5mbGFncyAmIEkyQ19NX1JEKQ0KPiA+ICsJCXhmZXJfc2l6ZSA9IEFMSUdO
KG1zZy0+bGVuLCBCWVRFU19QRVJfRklGT19XT1JEKTsNCj4gPiArCWVsc2UNCj4gPiArCQl4ZmVy
X3NpemUgPSBBTElHTihtc2ctPmxlbiwgQllURVNfUEVSX0ZJRk9fV09SRCkgKw0KPiA+ICsJCQkg
ICAgSTJDX1BBQ0tFVF9IRUFERVJfU0laRTsNCj4gPiArDQo+ID4gKwl4ZmVyX3RpbWUgKz0gRElW
X1JPVU5EX0NMT1NFU1QoKHhmZXJfc2l6ZSAqIDkpICogMTAwMCwNCj4gPiArCQkJCQlpMmNfZGV2
LT5idXNfY2xrX3JhdGUpOz4NCj4gPiAgCXRlZ3JhX2kyY19mbHVzaF9maWZvcyhpMmNfZGV2KTsN
Cj4gPiAgDQo+ID4gQEAgLTczOSw3ICs3NTMsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX2kyY194ZmVy
X21zZyhzdHJ1Y3QgdGVncmFfaTJjX2RldiAqaTJjX2RldiwNCj4gPiAgCQlpMmNfcmVhZGwoaTJj
X2RldiwgSTJDX0lOVF9NQVNLKSk7DQo+ID4gIA0KPiA+ICAJdGltZV9sZWZ0ID0gd2FpdF9mb3Jf
Y29tcGxldGlvbl90aW1lb3V0KCZpMmNfZGV2LT5tc2dfY29tcGxldGUsDQo+ID4gLQkJCQkJCVRF
R1JBX0kyQ19USU1FT1VUKTsNCj4gPiArCQkJCQkJVEVHUkFfSTJDX1RJTUVPVVQoeGZlcl90aW1l
KSk7DQo+ID4gIAl0ZWdyYV9pMmNfbWFza19pcnEoaTJjX2RldiwgaW50X21hc2spOw0KPiA+ICAN
Cj4gPiAgCWlmICh0aW1lX2xlZnQgPT0gMCkgew0KPiA+IA0K
