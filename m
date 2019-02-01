Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAE8C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3282082C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pABsbM5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfBAThz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:37:55 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:42432 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfBAThz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:37:55 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c54a00e0000>; Sat, 02 Feb 2019 03:37:50 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 01 Feb 2019 11:37:50 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 01 Feb 2019 11:37:50 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 19:37:48 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 1 Feb 2019 19:37:48 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3000.namprd12.prod.outlook.com (20.178.53.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Fri, 1 Feb 2019 19:37:46 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 19:37:46 +0000
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
Subject: RE: [PATCH V9 4/5] i2c: tegra: update transfer timeout
Thread-Topic: [PATCH V9 4/5] i2c: tegra: update transfer timeout
Thread-Index: AQHUulC8HRw7tfH5UkGlgyIZznn7L6XLUIiAgAACiBA=
Date:   Fri, 1 Feb 2019 19:37:45 +0000
Message-ID: <BYAPR12MB3398D89D631E65C484DC8267C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-4-git-send-email-skomatineni@nvidia.com>
 <53b3f00f-b3a8-e1ef-b04b-1bdd5f5473ce@gmail.com>
In-Reply-To: <53b3f00f-b3a8-e1ef-b04b-1bdd5f5473ce@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3000;6:sksBoI1sRRmcAfLSFXNkGMnd+75HFeKZnwoY+6NHK101F92QCWsprArCOZgxqEr7kfxbyNCtdEjtDnV4GntCHQ3etNcvm3V3ozSSy2mJDGUrZ2R3IX10cb5slfdLuFx4bBtGltDyi6v2llZkpCoZS2j3O7vOhCrc7+hyWVczih6NEUQC15tmexJtZE8JPsL0piiwz9+pgIgVNnPx7vyYZy8zuo4jh1HXAAU4MFMwer1ZmYMDMArBVdNGZi4JMl2U5sreEnuvqORhdNgUwAVdLizfH4rUcRJxOghALxaOM0RCNCOKg09isWCcJYRWzedeioTQyAFksMxt52HzfWU2tV4b0WKWxR25cmp/5rXNPBVKo5/CiHAbqWElCYcbW0Sg8eWRXFiCXAU7tJ3ddi6LbnP+X/kJhcgzlliUQzwpYq5uHKIS8jt/mBY7XuHwC6Y/R8aAzNtx+dqq046EfGtpBA==;5:Qn1t/wLdsaN0KahSCiegu/koYNk/Z4wbK15+Z5a9EVAwEpN54mYBpFOsx8iWszMQQ1YZ0eUPfJwjxZK/YH1stps5geEQabeI/Sso61k9wvctDRU6ncWLPErlsYY/dPcIeMe3xUeUEAaIsTWol8htx/E6ltfQaju6G/0p5me353mMMpItaRQ+aqKLKqmo6o9xAMUpk+Spe99tXcZGTc0E7Q==;7:fW1TOtz1NCot4b3gZ1LzaX/cfsV1VzpRMJTMKz5aKtMO9twIA64THtgkpT8nCJNd9pHRxNxP6ONsBjLD5Vla+TYgn+INHSeQZteeHCz3ipwYjRJIHX21YYAwYmGxK5r26kNKRvb9JOUY8pYvGh0Kgw==
x-ms-office365-filtering-correlation-id: d65c92e5-cf82-4112-61f4-08d6887cbdbb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3000;
x-ms-traffictypediagnostic: BYAPR12MB3000:
x-microsoft-antispam-prvs: <BYAPR12MB300073FC54EF4B227BA2E0D9C2920@BYAPR12MB3000.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(136003)(189003)(199004)(305945005)(256004)(446003)(66066001)(74316002)(2501003)(105586002)(106356001)(81166006)(6436002)(478600001)(11346002)(229853002)(8936002)(7736002)(81156014)(68736007)(8676002)(2906002)(55016002)(14454004)(9686003)(6246003)(25786009)(39060400002)(99286004)(186003)(86362001)(54906003)(110136005)(26005)(4326008)(316002)(76176011)(6116002)(6506007)(7696005)(102836004)(476003)(6636002)(71200400001)(53936002)(3846002)(71190400001)(486006)(33656002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3000;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7AyhrgE09DGYCj4IZBbdZK+CBtbez73t+zfgrFoGnjLr4ipuGSYGa4QYglULcW36NvTZF6wYbsiMidczGp5+uQbKKMTxd/XWstUXclit2U00RC8F07/8ZKt/KEUo0DzMkCL7jPnbzUV56ZAWxTeNpJBKNqQ7/49BW3wKzaQTDrIhYg6xewh2CinBOMAIl4QX4PPxYQZU8GFDQWY7R0l407r2ykCJm0OmaQ4vB45dMzLSKatcw2VrFkJ/Iw2JAJn9DP/XaqIIDc8YXX+dnIw7bhEIUKWeMq7iexG/DcMDP4XZM0nKesFhZvEuwRXp/JeRl/uL09//NQW/Bz+s8NFzB4Pq/Wncv6y/2PDomuQgthamfOOB7qnY34lz+r0Pan/RkZsR+RZgJIUfGdMBsV55JfufRIqa9XNECkf9nQABiDc=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d65c92e5-cf82-4112-61f4-08d6887cbdbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 19:37:45.8098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3000
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549049870; bh=Y027imBl4UjhFKrHSn+Tb4CDyOYOxxaw1tLSSRaAnFg=;
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
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=pABsbM5hlvmfQaJIXqbXg3aLafjbWoQKKo6mlkOECCNAcjDAPsByclcVxl45UcXm7
         pCk3whsTPNrQ4+B5FGCrk8SPVldM7cSh8jqCOcNveQ1e+O1b3SVCEJ7sDb8fewxF01
         nvgJ4x4dMkGv6W65Llb7ZLkTmyH3RRjVJI5DhgMySQbNUbXhMsxg3n/3RvSwjFxoNZ
         +3KcREFJuKkOzEsj2rdsAwJq92lee+kzp0nErnpR5eXN7uZoWZDzQ9iySQeTZ69XY2
         bEkxToDP3ygtRExuH1kCznPu06ce/VFmdUAyK1M1n2/tHfJVK4YQt14CsU1AtwBIf2
         9tQtR+mnYNIgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gQllURVNfUEVSX0ZJRk9fV09SRCA0DQo+ID4gIA0KPiA+ICAjZGVmaW5lIEkyQ19DTkZH
CQkJCTB4MDAwDQo+ID4gQEAgLTg5Myw4ICs4OTIsOSBAQCBzdGF0aWMgaW50IHRlZ3JhX2kyY19p
c3N1ZV9idXNfY2xlYXIoc3RydWN0IHRlZ3JhX2kyY19kZXYgKmkyY19kZXYpDQo+ID4gIAkJaTJj
X3dyaXRlbChpMmNfZGV2LCByZWcsIEkyQ19CVVNfQ0xFQVJfQ05GRyk7DQo+ID4gIAkJdGVncmFf
aTJjX3VubWFza19pcnEoaTJjX2RldiwgSTJDX0lOVF9CVVNfQ0xSX0RPTkUpOw0KPiA+ICANCj4g
PiAtCQl0aW1lX2xlZnQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJmkyY19kZXYtPm1z
Z19jb21wbGV0ZSwNCj4gPiAtCQkJCQkJCVRFR1JBX0kyQ19USU1FT1VUKTsNCj4gPiArCQl0aW1l
X2xlZnQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoDQo+ID4gKwkJCQkJCSZpMmNfZGV2
LT5tc2dfY29tcGxldGUsDQo+ID4gKwkJCQkJCW1zZWNzX3RvX2ppZmZpZXMoMTAwMCkpOw0KPg0K
PiBTbyBwb3RlbnRpYWxseSB0ZWdyYV9pMmNfeGZlcl9tc2coKSBjb3VsZCB0YWtlIG1vcmUgdGhh
biAxIHNlY29uZCBhbmQgdGhlbiBmYWlsIHdpdGggLUVBR0FJTiwgY29ycmVjdD8gSW4gdGhhdCBj
YXNlIHdlIHNob3VsZCBzZXQgYWRhcHRlci50aW1lb3V0IGluIHByb2JlIHRvIGEgbGFyZ2VyIHZh
bHVlOg0KPg0KQnVzIGNsZWFyIHB1bHNlIHRocmVzaG9sZCB3ZSBhcmUgc2V0dGluZyBpcyA5IChk
ZWZhdWx0IGFzIHBlciBzcGVjKSBzbyBidXMgY2xlYXIgc2hvdWxkIGhhcHBlbiBhZnRlciBmaW5p
c2hpbmcgc2VuZGluZyBvZiA5IHB1bHNlcy4NClNvIDFzZWMgaXMgdmVyeSBsb25nIHRpbWUgZm9y
IGJ1cyB0byBnZXQgcmVsZWFzZWQgYW5kIGluIGNhc2Ugb2YgQVJCIExPU1Qgd2hvbGUgdHJhbnNm
ZXIgdG8gcmV0dXJuIEVBR0FJTiB3aWxsIGJlIG11Y2ggbGVzcyB0aGVuIDFzZWMNCg0KPiAgIGky
Y19kZXYtPmFkYXB0ZXIudGltZW91dCA9IDMgKiBIWjsNCj4NCj4NCj4gT3RoZXJ3aXNlIGxvb2tz
IGdvb2QgdG8gbWU6DQo+DQo+IFJldmlld2VkLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBn
bWFpbC5jb20+DQo=
