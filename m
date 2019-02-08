Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB100C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8353C20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pCMe612m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfBHSez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:34:55 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:44279 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfBHSey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:34:54 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5dcbcd0000>; Sat, 09 Feb 2019 02:34:53 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 10:34:50 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 08 Feb 2019 10:34:50 -0800
Received: from DRBGMAIL102.nvidia.com (10.18.16.21) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 18:34:49 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by DRBGMAIL102.nvidia.com
 (10.18.16.21) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 18:34:48 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.57) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 8 Feb 2019 18:34:47 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3527.namprd12.prod.outlook.com (20.179.94.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Fri, 8 Feb 2019 18:34:45 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 18:34:45 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "peda@axentia.se" <peda@axentia.se>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH V17 3/6] i2c: tegra: fix maximum transfer size
Thread-Topic: [PATCH V17 3/6] i2c: tegra: fix maximum transfer size
Thread-Index: AQHUv9bE0/Y/Hcdfq0yQz/32u+ruR6XWMncAgAAB09CAAAIogIAAAGjwgAABgxCAAAEIkA==
Date:   Fri, 8 Feb 2019 18:34:45 +0000
Message-ID: <BYAPR12MB33986FBB8B684F2E56948FBCC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549648195-3989-1-git-send-email-skomatineni@nvidia.com>
 <1549648195-3989-3-git-send-email-skomatineni@nvidia.com>
 <0c30dfe0-1174-0056-5ef6-432b75de2353@gmail.com>
 <BYAPR12MB339810D394AC0A50934DD5EAC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <3e4db3e9-8198-f1bf-f909-492bf1ff8c56@gmail.com>
 <BYAPR12MB33981B3AD88271597CC4F7F5C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB3398429D6C403347C149B643C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3398429D6C403347C149B643C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3527;6:MJw5zljn8jhpJ4OebHoc459VX6LkUk4E2qkGYYMVB5MCzmbXEDLTxrAanTYbP97+trTu0absIqqP8iwnm3xB5TllHp0IAV9tH25OfymsI+aotCqRBO8H9xN5GhUKef4pkkmjBwkIbUMM7YTkSa70fBsgv4RwxWcOPe9fx0+XnPerd7qEBvduHQXPF6k4OygNlYAfNz4hnzha60B4e6kLE/xPslUaIPde3aPDYdPw592Q93lt+TAawjo080TDaxQSH+QSc03YNI0VI/Cw8icgWTZrXbliDH7fjSFvjhyfZUblhJt6zD5uNLdQLBvqF+QLep9QiHGHixETwvjfqboDWUGyvKNmK14+zIWqhlQnrrVgbgABUNq96LhnoXaUka1RbyTLM7JzltkVxnlhwKjpxDSb40VLBZT0yFMcMSuZYU6uQhw8YElcOGP4H1Py++9ud+iytywRCaiFY17OTaOkBg==;5:jn8Jf6rld/27Nzb33SXJCIc3JCu0RZMlpU+ZzIeDVCWzYTsMOCuzDrMQzK4itExSvezzGyJ1Ux0yP/hEF9yDUcZFT2GPLtSauBeJTHKAn1xud3L8PX+d+kgMAVzVVlHUrSfqTHSFaEf9eocYGdZJrdsjzpwxTPPpmIYnYDqxRfzI/ygecDnuUQ1XQ7xtOR5s1XCjXVK2pObcidSp7Qnwrg==;7:C0Z6QOlzNFk5sVs9/+K0ez3AUu3jyVajRR/RlHkJX4os1xeilql0yGPaK7fvH/INpKPGT4s32OcjdqKyscd+7PF7YfNxFAJaEZQEBdugDJW0twBnaV7iCtvNGFxBgkLrY9WtEGmA11zLTe4RdmVv2g==
x-ms-office365-filtering-correlation-id: dc54115c-2ab2-4f78-6ed3-08d68df41959
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3527;
x-ms-traffictypediagnostic: BYAPR12MB3527:
x-microsoft-antispam-prvs: <BYAPR12MB35277E1655597572A83693C7C2690@BYAPR12MB3527.namprd12.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(366004)(346002)(136003)(189003)(199004)(478600001)(33656002)(81156014)(3846002)(8676002)(7736002)(305945005)(14454004)(68736007)(81166006)(8936002)(6116002)(229853002)(2906002)(6636002)(74316002)(93886005)(2501003)(106356001)(105586002)(476003)(11346002)(446003)(53936002)(486006)(71200400001)(55016002)(71190400001)(25786009)(2940100002)(9686003)(6246003)(4326008)(7696005)(76176011)(66066001)(99286004)(6436002)(93156006)(86362001)(316002)(256004)(110136005)(54906003)(97736004)(6506007)(26005)(102836004)(14444005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3527;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PZ3qbHpEojWK52C+uRqs0peli2a/rWiYf2wSke7Kyf9nOy3T5ovSmmTBS9UytW3/NW6opDoJb7GXyEzuvqS37jYwLzVp/ei4MoouSHcwQsh1+vpMTPzQgf0Nh2UpmL0RGRyqzSCyCWGifa7BXBkwUgwia3o3D+F1GAIGoDl2vtaAjVQywRv9Q8hRu7D3dX3V5ljAPUmAlerONQLSfyCKk3iHfQDUa0lJUu2oCTkTIzz7QPOg428t+xeV/rqXW2rwkA5KXZjfnrLKf9MuyPCYDLw3FkqDpAl0vlEc1K5/u/ZQhknrA4nz/R/EnnMFUILhd9RmZH71JH6FEh7TLch8FtOTJb+9KgkRODKavqAaia1iLucQ4ptvHGco9pL50My6f8OebkySw01ON9A+A+pSXKg43i8ibLcfXNnrss3r6Og=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dc54115c-2ab2-4f78-6ed3-08d68df41959
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 18:34:45.4690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3527
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549650893; bh=8WGjQDEreWL6E8zWMLdXRoMCzhyD0YNcH0CMKqiqbH0=;
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
        b=pCMe612mBriseTb9+lZBZwMsXIYQGyhpTFQbL0VGJgCbhl9q7UZCcdftd/fZ0qnCn
         UhIER9XKOb60qMuuPBrMx6kwQ5GiHswukpqaizrasEoijUSgTZfnElnWUDDzEpU00U
         gmaZdBXwYCj/yHOjhXvHCoYBYhdbzLXxungG92GIUWeZFBzV2OSU/QGduKTqGtp5fO
         wVCHFrEKPIJQxLhSlvxETnmZUH0keu4YJYXTv6dlMhaOqxxFY/T4iE6ifRNFHkrEkl
         DZ5sCjE+zESW1uFb1o5+u0mVwC5WukAnePjDjOB7VdyuAiuT+yCIEA6exvu12OQ5bA
         g3d/uMvaNzLUA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfYWRhcHRlcl9xdWlya3MgdGVncmExOTRf
aTJjX3F1aXJrcyA9IHsNCj4gPiA+Pj4gIAkuZmxhZ3MgPSBJMkNfQVFfTk9fWkVST19MRU4sDQo+
ID4gPj4+ICsJLm1heF93cml0ZV9sZW4gPSA2NTUzNSAtIEkyQ19QQUNLRVRfSEVBREVSX1NJWkUs
DQo+ID4gPj4NCj4gPiA+PiBJZGVhbGx5IGl0IHNob3VsZCBiZSBTWl82NEsgLSBJMkNfUEFDS0VU
X0hFQURFUl9TSVpFIHRvIG5vdCBtaXNzIHRoZSBvbmUgYnl0ZSwgb3RoZXJ3aXNlIGdvb2QgdG8g
bWU6DQo+ID4gPj4NCj4gPiA+PiBSZXZpZXdlZC1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhA
Z21haWwuY29tPg0KPiA+ID4gIA0KPiA+ID4gV2l0aCBTWl82NEsgLSBJMkNfUEFDS0VUX0hFQURS
X1NpemUsIFdoZW4gd2UgY29tcHV0ZSBkbWFfYnVmX3NpemUgPSBtYXhfd3JpdGVfbGVuICsgSTJD
X1BBQ0tFVF9IRUFERVJfU0laRSwgZG1hX2J1Zl9zaXplIHdpbGwgYmUgU1pfNjRLIHdoaWNoIGlz
IDB4MTAwMDAgYXBiZG1hIGRtYSBjb3VudCBsaW1pdCBzaG91bGQgYmUgPCA2NEsgbWVhbmluZyA2
NTUzNSBtYXggaXMgYWxsb3dlZA0KPiA+ID4gDQo+ID4NCj4gPiBCdXQgaXQncyBmb3IgdGhlIEdQ
Q0RNQSwgZG9lcyBpdCBoYXZlIHRoZSBzYW1lIDY0SyBsaW1pdCBhcyBBUEIgRE1BPw0KPg0KIDY0
SyBsaW1pdCBpcyBmb3IgQVBCRE1BLiBUaGlzIHBhdGNoIGhhcyBBUEJETUEgc3VwcG9ydCBvbmx5
LiBObyBHUENETUEgc3VwcG9ydCBzbyBidWYgc2l6ZSBsaW1pdCBpcyBiYXNlZCBvbiBBUEJETUEu
DQogR1BDRE1BIHN1cHBvcnRzIHVwdG8gMUdCLiANCg0KIEkgdGhpbmsgZG1hX2J1Zl9zaXplIGlz
IG9ubHkgZm9yIGJ1ZmZlciBhbGxvY2F0aW9uIHNvIHNob3VsZG7igJl0IGhhcm0gZm9yIGV4YWN0
IDY0Sy4NCldpbGwgdGFrZSBhIGxvb2sgYXQgZG1hIGRyaXZlci4uLg0KDQpBbGwgbXNnIHJlYWRz
LCBtYXggbGVuZ3RoIGlzIDY1NTM1DQpBbGwgbXNnIHdyaXRlcywgbWF4IGxlbmd0aCByZXF1ZXN0
cyBpcyBhbHNvIGxpbWl0ZWQgdG8gNjU1MzUgZHVlIHRvIHUxNiB0eXBlIG9mIG1zZy5sZW4NClNv
LCBJbiBhbnkgY2FzZSwgd2UgZG9u4oCZdCBuZWVkIDY1NTM2IGJ5dGVzLg0K
