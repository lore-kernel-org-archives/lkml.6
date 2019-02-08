Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1ECC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2681C20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GCyUdBJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfBHShe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:37:34 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8040 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfBHShe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:37:34 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5dcc570000>; Fri, 08 Feb 2019 10:37:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 10:37:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 08 Feb 2019 10:37:31 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 18:37:30 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.51) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 8 Feb 2019 18:37:31 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3527.namprd12.prod.outlook.com (20.179.94.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Fri, 8 Feb 2019 18:37:15 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 18:37:15 +0000
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
Thread-Index: AQHUv9bE0/Y/Hcdfq0yQz/32u+ruR6XWMncAgAAB09CAAAIogIAAAGjwgAABgxCAAAEIkIAAARIg
Date:   Fri, 8 Feb 2019 18:37:15 +0000
Message-ID: <BYAPR12MB3398DAC18B36F12F20765354C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549648195-3989-1-git-send-email-skomatineni@nvidia.com>
 <1549648195-3989-3-git-send-email-skomatineni@nvidia.com>
 <0c30dfe0-1174-0056-5ef6-432b75de2353@gmail.com>
 <BYAPR12MB339810D394AC0A50934DD5EAC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <3e4db3e9-8198-f1bf-f909-492bf1ff8c56@gmail.com>
 <BYAPR12MB33981B3AD88271597CC4F7F5C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB3398429D6C403347C149B643C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33986FBB8B684F2E56948FBCC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB33986FBB8B684F2E56948FBCC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3527;6:a3EbIVwLuDsnUYybtKK5g0fMOzOCcJNqWVZgrNvkZsrp5DwQSbl2UzQQFLL7aXF5tdlQcJ4OHuKhNK64bUvnpBLOcbhvyDRbvYdUg0kpBOnycQKKO5HseHSc8uDpD39bIKJ021PmOd1qAiYBNMQpx0/GrjNQX2HH6last225yC61lw0fPCE+Ph6/GZ7bYeBDwulpyTl3HTcXQdPSi3s+rlWzDUWcCEcrsoNd42xUuOR56I2X+gAJV3VdZAKUd+b0hXQjZBXZWnjoY8Lh/XWti7YMgn6gmrqSpPrQ2VEFHt7ZinhE17azcISaGJH8LS0TvzJJ5jS0ba3lRrVD4o80yq/uRkVKBM7vzjNxKf4BFtjsXzLvZO1u/oCDc4szti68hmSC24sTatG8TlGkGKAUrXu+l3g5PGr3FawJMx0L2AwwqKrvWEy0GvMC2p2+SydT5fERDS8FMUl8trwfyF+3DA==;5:nHPETNdJh3uuo+2PnmxT2fPRDbg9zvuEQI2PT9jb4VJO4TyRZzDwCtZgTQ1Nt6D48Z2qiaKrwBbAga3iTMaaZ0s5ABwnNuYRkOk1nJmmvfCZcXBo4uba82jnEwj6aKIOQDQYflfDxqdLGq61acNOosdGtU0ntIl3lYv1EOF35TVzC7Pb0u7NiqH/Blpuz3GQeP6zDqi69T+UbKZI0jIL9A==;7:MAdIy0wOMArg4COKp0f62MXVdhJOMGi2e1yOcgUrdNtZbxWs9AAIQ/yo3Di+Ax49Nw99daEr5p+aV6tUwZIH0/G1MzIt12GMryir1imqTzMbzomZo9DYdzJ+g7o2JFAsLkG8441JrLN8xQWiRzjyZw==
x-ms-office365-filtering-correlation-id: 9d4b9157-6983-4dbb-6dd2-08d68df47278
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3527;
x-ms-traffictypediagnostic: BYAPR12MB3527:
x-microsoft-antispam-prvs: <BYAPR12MB35271C77D255061D9881CB2DC2690@BYAPR12MB3527.namprd12.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(366004)(346002)(136003)(189003)(199004)(478600001)(33656002)(81156014)(3846002)(8676002)(7736002)(305945005)(14454004)(68736007)(81166006)(8936002)(6116002)(229853002)(2906002)(6636002)(74316002)(93886005)(2501003)(106356001)(105586002)(476003)(11346002)(446003)(53936002)(486006)(71200400001)(55016002)(71190400001)(25786009)(2940100002)(9686003)(6246003)(4326008)(7696005)(76176011)(66066001)(99286004)(6436002)(93156006)(86362001)(316002)(256004)(110136005)(54906003)(97736004)(6506007)(26005)(102836004)(14444005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3527;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hYDyEHzFPTo/00W1JC6CZLjdL7SY63Xtn7WSA3/WIB92+zMYnhAcP4/tUYZOqSQ/AGF+snjxWUokmrH9IuVuecDX6Vqujw8NNBmrEPcT4X+NTQy4UN/7xNIc1XmU49byR6ZOnZRC87kms6gQe2AxECJEkDd18antPGowwATHS7rU5yVdkSOgxV9+iWqefOOziy390Jn0dFKG7K7BBtScKStDQjxVelC7UK/AtbRLpKOiIroASevzkrBlvkrdXXIjiTare+4w6E0gZzJooSU9HhM6OOnQmX/mHDG6UX8+P+1CS6vYqtpUcdNLJy74M3qW8E2VbT0ATEaAuKXqIopl5MJFtBdMHN0AtoXcQDQZJcVZYXEf+rhoPhiK7Q0g6aCDb4uxLT2J5vTLZUHzgvU7NAGQGCdmxNIyJdKJOLOP460=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4b9157-6983-4dbb-6dd2-08d68df47278
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 18:37:15.0434
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
        t=1549651031; bh=e5F/ydBrZoGmtHzxNydZkkSWH4PyAuvinRhMnQTnQFM=;
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
        b=GCyUdBJ2A+6ceRLxe7Kbq14SMhmCo1i41aBC2QlDXauV2EjyqT4SZVNfdO7Vkgq44
         qZVWXYglhXLdVekuMRJtn//WIwgdDAyoDcbCvAmOVFfVPtZT2ZP/AThrBfSAqeisXO
         kU+OvN9qrRePm4yqCngG8SFvvhBu9O09RVV+A9i+laZwOg6HTEVl8lBz7ZglL34fm2
         lbdmE/99sIhEta7541PC7aYDgW1SOegfPMsSU2IdbyfVkrp9yZkgWa76uF0Hb1p5mf
         Q1gEy2Q7KlxfCqSR/GSEkVvLNdWw3xSXBBtRYVZ4Jm8LILr7wu+IeZd8XUNTYcyuad
         N0vSNaNbXLGnQ==
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
X1NpemUsIFdoZW4gd2UgY29tcHV0ZSBkbWFfYnVmX3NpemUgDQo+ID4gPiA9IG1heF93cml0ZV9s
ZW4gKyBJMkNfUEFDS0VUX0hFQURFUl9TSVpFLCBkbWFfYnVmX3NpemUgd2lsbCBiZSANCj4gPiA+
IFNaXzY0SyB3aGljaCBpcyAweDEwMDAwIGFwYmRtYSBkbWEgY291bnQgbGltaXQgc2hvdWxkIGJl
IDwgNjRLIA0KPiA+ID4gbWVhbmluZyA2NTUzNSBtYXggaXMgYWxsb3dlZA0KPiA+ID4gDQo+ID4N
Cj4gPiBCdXQgaXQncyBmb3IgdGhlIEdQQ0RNQSwgZG9lcyBpdCBoYXZlIHRoZSBzYW1lIDY0SyBs
aW1pdCBhcyBBUEIgRE1BPw0KPg0KIDY0SyBsaW1pdCBpcyBmb3IgQVBCRE1BLiBUaGlzIHBhdGNo
IGhhcyBBUEJETUEgc3VwcG9ydCBvbmx5LiBObyBHUENETUEgc3VwcG9ydCBzbyBidWYgc2l6ZSBs
aW1pdCBpcyBiYXNlZCBvbiBBUEJETUEuDQogR1BDRE1BIHN1cHBvcnRzIHVwdG8gMUdCLiANCg0K
IEkgdGhpbmsgZG1hX2J1Zl9zaXplIGlzIG9ubHkgZm9yIGJ1ZmZlciBhbGxvY2F0aW9uIHNvIHNo
b3VsZG7igJl0IGhhcm0gZm9yIGV4YWN0IDY0Sy4NCldpbGwgdGFrZSBhIGxvb2sgYXQgZG1hIGRy
aXZlci4uLg0KDQpBbGwgbXNnIHJlYWRzLCBtYXggbGVuZ3RoIGlzIDY1NTM1DQpBbGwgbXNnIHdy
aXRlcywgbWF4IGxlbmd0aCByZXF1ZXN0cyBpcyBhbHNvIGxpbWl0ZWQgdG8gNjU1MzUgZHVlIHRv
IHUxNiB0eXBlIG9mIG1zZy5sZW4gU28sIEluIGFueSBjYXNlLCB3ZSBkb27igJl0IG5lZWQgNjU1
MzYgYnl0ZXMuDQpDb25mdXNlZCwgeWVhaCB3aXRoIG1heCB3cml0ZSBxdWlyaywgbWF4IHRyYW5z
ZmVyIGNhbiBiZSA2NEsuDQoNCldpbGwgY2hhbmdlIHRvIDY0SyBpbnN0ZWFkIG9mIDY1NTM1Lg0K
