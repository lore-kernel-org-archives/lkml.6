Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B1AC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F155920881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="N08Qe6kI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfAaCYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:24:17 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13492 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaCYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:24:16 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c525c250000>; Wed, 30 Jan 2019 18:23:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 30 Jan 2019 18:24:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 30 Jan 2019 18:24:13 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 02:24:13 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 02:24:13 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.54) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 31 Jan 2019 02:24:13 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3511.namprd12.prod.outlook.com (20.179.94.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Thu, 31 Jan 2019 02:24:12 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 02:24:12 +0000
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
Subject: RE: [PATCH V7 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V7 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuLUl2B5DD2NSpkOCYYJBIhpJsKXIgAUAgAANcMCAABYegIAAAMxA
Date:   Thu, 31 Jan 2019 02:24:11 +0000
Message-ID: <BYAPR12MB3398CE89D24AC71BF7DAF43CC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
 <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
 <BYAPR12MB3398B845E97674BE93CCD7D9C2910@BYAPR12MB3398.namprd12.prod.outlook.com>
 <f3282ada-56a8-b5c7-c400-38483eab2d06@gmail.com>
In-Reply-To: <f3282ada-56a8-b5c7-c400-38483eab2d06@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3511;6:0ibw3gQstexZm3LTKOWdkO/5262Y670tV7tyxu6Q6SC8L7UDlPVr7AHgWwK5Q4zTe2aiJiHoC5/ACUTiWoz5kITLdFNPYNjKc0pE4prvOeNW9yPrwmMRtFPN5ZcJxFCcgKu+UJj8dZO6NH5Fqv0kNe+kXhiZRaf2jJzZuYM80/6DjlPhSfoL8v5aWPeR+XX7HwuiNOKtpUIC5S97Ir3sIS546FLpmNumYfbi+kYZK+LtfILK5zIQ0iivEkatj426GDthv3z5YMNjkCrC5VCIWxroQ5aWreeYBt27KGHn5hKBtHZmJoelc8NfcoLTdbEpoa7jFO2bGEVCpaY8Sd/dC1AtiP856qhyv2yHqZImyJXKv6mq6oFGZPMVqFjkdfGznpYvB3DFfyvkCvPV6CcDIACg2C9QE+qmE36Zv1/Y5E/U8CtS7JOrQY+HLxrTiGQ7YDPGmuBe2A6Cx2UANP8OlA==;5:qgcNWdtkzIAyyfjUExzfeqKxd3OiQ1/UfZdGB7lStQL6CFjwfjf8dX4WUXyIqTzX1ozzw+Lgf1KkMt9zZH1KAEcltYyFKdkG9V4xEzwvw9vYkEbtrc3zfyWwUabYNxL/n+j+4G9DERiu/og7JA1cHay8jDYs0phejf0XRMMSCfoHRCu2DZA+PygaLRYR5a+a07dhDdC8STykfRrqJyCIcw==;7:ExIohVxPuHASRIVhr54J4TMm4HzNvWlo7BCwVIjN5CZn1z4RqdgSrpGSTsS5yVZvSOSlCYSWq4v0WgZKDZmGpBxzgl02PVWnS4OPB3kUCKfMvC01WxaNOnqGK/v43RSHCQKcrN3tLFIV2ih6fxM5ZA==
x-ms-office365-filtering-correlation-id: bd75e0d2-23f3-4045-aa5f-08d687233019
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3511;
x-ms-traffictypediagnostic: BYAPR12MB3511:
x-microsoft-antispam-prvs: <BYAPR12MB3511F297B8E873B804285747C2910@BYAPR12MB3511.namprd12.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(366004)(199004)(189003)(86362001)(33656002)(71190400001)(7736002)(26005)(486006)(4326008)(81166006)(6436002)(74316002)(81156014)(99286004)(8936002)(71200400001)(93886005)(6636002)(8676002)(25786009)(39060400002)(6506007)(229853002)(6246003)(186003)(102836004)(55016002)(54906003)(7696005)(110136005)(2906002)(9686003)(2501003)(53936002)(316002)(305945005)(476003)(6116002)(11346002)(3846002)(76176011)(446003)(106356001)(966005)(97736004)(14454004)(6306002)(256004)(14444005)(66066001)(105586002)(478600001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3511;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tUQ7+sr6A5vBCPlBM6UfMcjv/pUyrQLJRJFl7C9FJRl9xjmjkikYX7M2/pUsdWjtZZydmP7sEb1hbvuTW+FJEGa3lPnzFfA9b26vd7Zbmip3tJJ+0q+FPKr6Wi78nbVkprncYTwdt/G1aFJQOwc1WgMIYqYGJ09cl2IKzVA/drt9CvxiSPnELFpjgnOKHMmEdRJAB4xLOMEDr8l+bufHsERrvJ/b/uKxKHzZT3rLsrWEoOFKIJRymWbJU/Q0nkrndoKqrEqMAmSJ8j23/ysCoCT4Afd2GYTS9vGFs8RybRGu/o+7fpyTv33lbpQeZDVtwnqvStSCzaYR4I25sVbpguVbrerydG7uAGFeEYgM67iyQV8aPeJmWKeTYZUFaIrRKN7dW3DtVNc6OTQ94+9i/0FADloH8KSCzKAVRbdiRf8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bd75e0d2-23f3-4045-aa5f-08d687233019
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 02:24:11.8516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3511
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548901413; bh=k6LnD1fpW296Og9y4wr+0O7nfZiRnVd+rp1to2/T6Nw=;
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
        b=N08Qe6kIcdL34BCfDOOKOc5JYAz2SN3MSBvMOAhdRLQJhpmBZ6jWywIcwuH+WwWjY
         Eo2GOEa2cNu3aagy74Sby3tPQZFISZvZbka5xv7A3pwZnsCEcq/3f2kHGMmZbhVltq
         OdTcJdqhBgPNZjcUIkQuf8W7tV5nXNozTzwBcxhri+6hrzziV+wBForWfEtwrIkkir
         1UjAFWHeRZyFLEVKP4gwKy6CRWko8KCwoRDd+3FclIG+oiUnxqy6kh6X4WFvozdN7q
         2GAOQOR/EQ5c25rjnHugNROOeBFCU9wXwt3EnmJkf9Pi8f8GYiqvAvyjM2vq/2SD/q
         HGslNI2apqKig==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4gIAl0aW1lX2xlZnQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJmkyY19kZXYt
Pm1zZ19jb21wbGV0ZSwNCj4gPj4+ICAJCQkJCQlURUdSQV9JMkNfVElNRU9VVCk7DQo+ID4+PiAg
CXRlZ3JhX2kyY19tYXNrX2lycShpMmNfZGV2LCBpbnRfbWFzayk7DQo+ID4+PiAgDQo+ID4+PiAg
CWlmICh0aW1lX2xlZnQgPT0gMCkgew0KPiA+Pj4gIAkJZGV2X2VycihpMmNfZGV2LT5kZXYsICJp
MmMgdHJhbnNmZXIgdGltZWQgb3V0XG4iKTsNCj4gPj4+ICsJCWlmIChkbWEpIHsNCj4gPj4+ICsJ
CQlkbWFlbmdpbmVfdGVybWluYXRlX2FsbChjaGFuKTsNCj4gPj4+ICsJCQljb21wbGV0ZSgmaTJj
X2Rldi0+ZG1hX2NvbXBsZXRlKTsNCj4gPj4+ICsJCX0NCj4gPj4NCj4gPj4gRE1BIHRyYW5zZmVy
IGhhcyBiZWVuIGNvbXBsZXRlZCBhdCB0aGlzIHBvaW50LCBoZW5jZSB0aGlzIGh1bmsgaXNuJ3Qg
bmVlZGVkLiBQbGVhc2UgcmVtb3ZlIGl0Lg0KPiA+IA0KPiA+IERNQSBjb21wbGV0ZSBhbG9uZSBk
b2VzbuKAmXQgZ3VhcmFudGVlIHRoZSB0cmFuc2Zlci4gUGFja2V0cy9BbGwgcGFja2V0cyB4ZmVy
IGludGVycnVwdCBmcm9tIEkyQyBjb25maXJtcyBjb21wbGV0ZSB0cmFuc2FjdGlvbiBhbG9uZyB3
aXRoIGRtYSBjb21wbGV0ZSBjaGVjay4NCj4gPiBTbyBzdGlsbCBuZWVkIHRvIGNoZWNrIGZvciBt
c2dfY29tcGxldGUgdGltZW91dC4gDQo+DQo+IFlvdSdyZSB3YWl0aW5nIGZvciBETUEgY29tcGxl
dGlvbiBhbmQgdGhlbiBmb3IgdGhlIEkyQyBtZXNzYWdlIGNvbXBsZXRpb24uDQo+DQo+IEhlbmNl
IHlvdXIgY29kZSBpcyBzdHJ1Y3R1cmVkIGxpa2UgdGhpczoNCj4NCj4gMS4gSXNzdWUgRE1BIHRy
YW5zZmVyDQo+IDIuIFdhaXQgZm9yIERNQSBjb21wbGV0aW9uDQo+IDMuIFdhaXQgZm9yIG1lc3Nh
Z2UgY29tcGxldGlvbg0KPg0KPiBXaHkgZG8geW91IG5lZWQgdG8gYWJvcnQgRE1BIGluIDMgaWYg
aXQgd2FzIGFscmVhZHkgY29tcGxldGVkIGluIDI/DQoNCk9rLCB0aG91Z2h0IHlvdSBhcmUgcmVm
ZXJyaW5nIHRvIG1zZyBjb21wbGV0ZSB0aW1lb3V0IGNoZWNrIGluIGRtYSBtb2RlLiBZZXMgbm8g
bmVlZCBmb3IgdGVybWluYXRpbmcgRE1BIHdoZW4gbXNnIHRpbWVvdXQuIFdpbGwgZml4IGl0Lg0K
DQo+ID4+PiBAQCAtNzQwLDYgKzkyNSwzMiBAQCBzdGF0aWMgaW50IHRlZ3JhX2kyY194ZmVyX21z
ZyhzdHJ1Y3QgdGVncmFfaTJjX2RldiAqaTJjX2RldiwNCj4gPj4+ICAJdTMyIGludF9tYXNrOw0K
PiA+Pj4gIAl1bnNpZ25lZCBsb25nIHRpbWVfbGVmdDsNCj4gPj4+ICAJdW5zaWduZWQgbG9uZyBm
bGFnczsNCj4gPj4+ICsJc2l6ZV90IHhmZXJfc2l6ZTsNCj4gPj4+ICsJdTMyICpidWZmZXIgPSAw
Ow0KPiA+Pj4gKwlpbnQgcmV0ID0gMDsNCj4gPj4+ICsJYm9vbCBkbWEgPSBmYWxzZTsNCj4gPj4+
ICsNCj4gPj4+ICsJaWYgKG1zZy0+ZmxhZ3MgJiBJMkNfTV9SRCkNCj4gPj4+ICsJCXhmZXJfc2l6
ZSA9IG1zZy0+bGVuOw0KPiA+Pj4gKwllbHNlDQo+ID4+PiArCQl4ZmVyX3NpemUgPSBtc2ctPmxl
biArIEkyQ19QQUNLRVRfSEVBREVSX1NJWkU7DQo+ID4+PiArDQo+ID4+PiArCXhmZXJfc2l6ZSA9
IEFMSUdOKHhmZXJfc2l6ZSwgQllURVNfUEVSX0ZJRk9fV09SRCk7DQo+ID4+PiArCWRtYSA9ICh4
ZmVyX3NpemUgPiBJMkNfUElPX01PREVfTUFYX0xFTik7DQo+ID4+PiArCWlmIChkbWEpIHsNCj4g
Pj4+ICsJCWlmICgobXNnLT5mbGFncyAmIEkyQ19NX1JEKSAmJiAhaTJjX2Rldi0+cnhfZG1hX2No
YW4pDQo+ID4+PiArCQkJcmV0ID0gdGVncmFfaTJjX2luaXRfZG1hX3BhcmFtKGkyY19kZXYsIHRy
dWUpOw0KPiA+Pj4gKwkJZWxzZSBpZiAoIWkyY19kZXYtPnR4X2RtYV9jaGFuKQ0KPiA+Pj4gKwkJ
CXJldCA9IHRlZ3JhX2kyY19pbml0X2RtYV9wYXJhbShpMmNfZGV2LCBmYWxzZSk7DQo+ID4+DQo+
ID4+IEluIHRoZSBjb21tZW50IHRvIFYzIEkgbWVudGlvbmVkIHRoYXQgaXQncyBub3QgYSBnb29k
IGlkZWEgdG8gcmVxdWVzdCBjaGFubmVscyBkeW5hbWljYWxseSBiZWNhdXNlIHN1c3BlbmQtcmVz
dW1lIG9yZGVyIGlzIGJhc2VkIG9uIGRldmljZXMgcmVnaXN0cmF0aW9uIG9yZGVyLCBpbiB0aGlz
IGNhc2UgQVBCIERNQSBtdXN0IGJlIHByb2JlZCBiZWZvcmUgSTJDLiBQbGVhc2UgbW92ZSBjaGFu
bmVscyBhbGxvY2F0aW9uIGludG8gdGhlIHByb2JlLg0KPiA+Pg0KPiA+PiBUaGlzIGFsc28gcmFp
c2VzIHRoZSBxdWVzdGlvbiBhYm91dCB0aGUgbmVlZCB0byByZWdpc3RlciBJMkMgZHJpdmVyIGZy
b20gdGhlIHN1YnN5cy1pbml0IGxldmVsIGJlY2F1c2UgQVBCIGRyaXZlciBpcyBnZXR0aW5nIHJl
Z2lzdGVyZWQgZnJvbSB0aGUgbW9kdWxlLWluaXQgbGV2ZWwgYW5kIGhlbmNlIEkyQyBwcm9iaW5n
IHdpbGwgYmUgZGVmZXJyZWQgdW50aWwgQVBCIERNQSBkcml2ZXIgaXMgcmVnaXN0ZXJlZC4gSXQg
bG9va3MgdG8gbWUgdGhhdCB0aGUgc3Vic3lzLWluaXQgaXMgYSByZWxpY3Qgb2YgdGhlIHBhc3Qg
YW5kIGl0IHNob3VsZCBiZSBmaW5lIHRvIG1vdmUgSTJDIGRyaXZlciByZWdpc3RyYXRpb24gaW50
byB0aGUgbW9kdWxlLWluaXQgbGV2ZWwsIG9mIGNvdXJzZSBpdCdzIG5vdCBzdHJpY3RseSBuZWNl
c3NhcnkgYW5kIGNvdWxkIGJlIGRvbmUgbGF0ZXIgb24gaWYgZGVzaXJlZC4NCj4gPj4NCj4gPj4+
ICsJCWlmIChyZXQgPCAwKSB7DQo+ID4+PiArCQkJZGV2X2RiZyhpMmNfZGV2LT5kZXYsICJTd2l0
Y2hpbmcgdG8gUElPIG1vZGVcbiIpOw0KPiA+Pj4gKwkJCWRtYSA9IGZhbHNlOw0KPiA+Pj4gKwkJ
CXJldCA9IDA7DQo+ID4+PiArCQl9DQo+ID4+PiArCX0NCj4gPj4+ICsNCj4gPj4+ICsJaTJjX2Rl
di0+aXNfY3Vycl9kbWFfeGZlciA9IGRtYTsNCj4gPj4NCj4gPj4NCj4gPiBTaW5jZSB5b3VyIHBy
ZXZpb3VzIGZlZWRiYWNrIHN1Z2dlc3QgImxldCdzIHBvc3Rwb25lIGNoYW5uZWxzIHJlcXVlc3Rp
bmcgYW5kIGRtYV9idWYgYWxsb2NhdGlvbiB1bnRpbCB0aGV5IGFyZSByZWFsbHkgbmVlZGVkIiwg
SSB0aG91Z2h0IGl0IG1ha2Ugc2Vuc2UgdG8gbm90IHJlcXVlc3QgY2hhbm5lbHMgYW5kIGFsbG9j
YXRlIHRpbGwgRE1BIGlzIG5lZWRlZC4NCj4gPiBTbyBtb3ZlZCBmcm9tIHByb2JlIHRvIHhmZXJf
bXNnIGZ1bmN0aW9uLiBCeSB0aGUgdGltZSBpdCBnZXRzIHRvIHhmZXIgbXNnIGZ1bmN0aW9uLCBk
ZXZpY2VzIHJlZ2lzdHJhdGlvbiBzaG91bGQgYmUgZG9uZSBhbHJlYWR5IGFsb25nIHdpdGggYXBi
IGRtYSBwcm9iZS4NCj4gPiANCj4gPiANCj4NCj4gWWVzLCBJIG1hZGUgdGhhdCBjb21tZW50LCBi
dXQgdGhlbiBjb3JyZWN0ZWQgbXlzZWxmLiBTZWVtcyB5b3UgbWlzc2VkIHRoZSBjb3JyZWN0aW9u
OiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS8xLzI2LzIxNw0KPg0KPiBJZiB5b3UncmUgaGF2
aW5nIHRyb3VibGVzIHdpdGggdGhlIGNvcnBvcmF0ZSBlbWFpbCwgbWF5YmUgeW91IGNvdWxkIHRy
eSB0byBzd2l0Y2ggdG8gc29tZXRoaW5nIGVsc2UgbGlrZSBnbWFpbC4NCj4NCj4gSSd2ZSB0cmll
ZCB0byBhcHBseSB0aGlzIHNlcmllcyBsb2NhbGx5LCBidXQgYWdhaW4gaXQgZmFpbHMgdG8gYXBw
bHkuIFdoYXQncyB0aGUga2VybmVsIGJhc2UgeW91J3JlIHVzaW5nPyBZb3Ugc2hvdWxkIG1ha2Ug
eW91ciBwYXRjaGVzIG9uIHRvcCBsaW51eC1uZXh0IChwcmVmZXJhYmx5KSBvciBtYWlubGluZS4N
Cg0KWWVhaCBzb21laG93IG1pc3NlZCB0aGF0LiBXaWxsIG1vdmUgaXQgYmFjayB0byBwcm9iZS4u
DQpJIGFtIHVzaW5nIDUuMC1yYzENCg0K
