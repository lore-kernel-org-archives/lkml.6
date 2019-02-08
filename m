Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E76C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C0A20823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pcOv5hLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfBHS26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:28:58 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:32686 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfBHS26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:28:58 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5dca650000>; Sat, 09 Feb 2019 02:28:53 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 10:28:53 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 08 Feb 2019 10:28:53 -0800
Received: from DRBGMAIL101.nvidia.com (10.18.16.20) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 18:28:51 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by DRBGMAIL101.nvidia.com
 (10.18.16.20) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 18:28:50 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.50) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 8 Feb 2019 18:28:50 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3445.namprd12.prod.outlook.com (20.178.196.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 18:28:47 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 18:28:47 +0000
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
Thread-Index: AQHUv9bE0/Y/Hcdfq0yQz/32u+ruR6XWMncAgAAB09CAAAIogIAAAGjwgAABgxA=
Date:   Fri, 8 Feb 2019 18:28:47 +0000
Message-ID: <BYAPR12MB3398429D6C403347C149B643C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549648195-3989-1-git-send-email-skomatineni@nvidia.com>
 <1549648195-3989-3-git-send-email-skomatineni@nvidia.com>
 <0c30dfe0-1174-0056-5ef6-432b75de2353@gmail.com>
 <BYAPR12MB339810D394AC0A50934DD5EAC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <3e4db3e9-8198-f1bf-f909-492bf1ff8c56@gmail.com>
 <BYAPR12MB33981B3AD88271597CC4F7F5C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB33981B3AD88271597CC4F7F5C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3445;6:gU9hXjCfNs9BqyqZFkCHerRbJ/wl9jk4VmrzYg0waJVQURzBSueNSyNsJFZqw90ebOrzAEX41Gz3i52yk2pDS6CAI6KS6/8H3nYd/yRogOjqmA1yXWYE+JTN6jCbREQi3xJDRD1/H53H5VkM/Pad07Ur5cKAt4WvpHW6GEiJjCyjFpuuaAEcTrrGE2jfmEAtyYYGH5XkWNZPsl3gabdZYjrrlVfyr7XXwlFBXLLayhUrugZDFSW3eX3FhkeCq1gsoxz3U50uf+LVgUncSweVmQ8Mp8Y4Q+Q61RNTLEqDTZhwzyF481UzsDpHY8J0oSoLbkwaorw3oJ/EB/q0IOuImguhxJM42L/mU9jHV9ohpNhX+g83HPOj20s+5wNSUO2Bu5GwbWWUSclhzvYhrRtQjxtfJXWExAPNUu+c12YzFCP3vW04boqtRXw7LQGH3Ri3KLTF2spb5sLPgtNARCLVKg==;5:7B56XmCBZbFOob7TZR7wpa0ZxQ8f106U9hQ455M7juAW1oUOEvzdKZJnLltAYUyPeteMIM8nJ4xOeEEkqYF6LOm6yUNJPzgtQOOKVOWT99G8atW1chei8183YQ0gqEJJ0F9Xa4xRuGuPFiG8/X3JvQawn1xnmKR0eQTi5hwOjU+pZa8PFWNtH1bf6MsD1g4SJ1BpXZ7y7/rGs0Dx9msQOA==;7:aCL66OmNXxn2iNloYwnCkVY9foNjNPW9T+AqQpdamt3bwduphA/H8eT9iYx/eDxkonSprdHUHaqWDaUUMVInbnUF3mhhOQcRJHODn95nVHEpdITX7uF7dVZVGG7rYFtInkhVi8Uo3GmF7lL6MY0wfg==
x-ms-office365-filtering-correlation-id: 5676c489-1551-41ad-2562-08d68df343cf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3445;
x-ms-traffictypediagnostic: BYAPR12MB3445:
x-microsoft-antispam-prvs: <BYAPR12MB344553AB4070E4103721B085C2690@BYAPR12MB3445.namprd12.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39860400002)(396003)(376002)(199004)(189003)(229853002)(4326008)(186003)(99286004)(6246003)(2940100002)(54906003)(8936002)(2501003)(86362001)(6436002)(74316002)(4744005)(68736007)(6636002)(305945005)(81156014)(93886005)(14454004)(7696005)(8676002)(25786009)(55016002)(478600001)(53936002)(7736002)(9686003)(102836004)(81166006)(316002)(33656002)(26005)(71190400001)(3846002)(71200400001)(6116002)(476003)(2906002)(76176011)(11346002)(6506007)(66066001)(486006)(110136005)(14444005)(93156006)(106356001)(97736004)(105586002)(446003)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3445;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EttTqpz2h/Qc5r8AkXgxVRC8KEEmb6GG+SlrQu6a+kBXk9gp3tAaij9y+ZPRBECzUqlrvWOoEqpsK+NsMCAwmkQEWesqdVYqRRGHqA5PG2SBJzkMGbyfxncIc2C6XhU0BaH9E4Yn7/q35v/moJSmMSG2pwvmNw+vDAmiUUU0p8In7HFz7EAJeM8hAyD2Lf9o0O1wnC6Ks/33iou3GOxZ4KNDSk3JnJ6nz7OQZ1X6wuP1MNA3bYFYL22/XBO+UCMApLazo3HHJpLR2rqOsy/QfzZgjYjjlQfE2/bCbQpvYqhNFbo3v+m3ryEHa0O4grrNUjnHSsoro2Oojb2iszBOsFtuFhcxDdFEdCfOv3nIoHeFMKxK4qRkPO1Lrz7vYbZNMQM5Z+iIirzAPj2SKoNbJQzWvaR4mTWTHXz2eHAYb/Y=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5676c489-1551-41ad-2562-08d68df343cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 18:28:47.2361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3445
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549650533; bh=Sritx7eKplZM6GW77jlbCGq3x6wWkeotcOvdmkUCIbk=;
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
        b=pcOv5hLFHjTofCgnQOhN39r1Lqw3sBrqNOBjSoVq64FC4wUd1jPMcmszmNZKN/e84
         k3EVTqDcvcrrY5vae6kCQuIx1bxY8aUV508cfeLr+6k89quW3jCa63iiIR4Nr1u5XD
         Bb5hZG+dKqOdvajYCXjJc4zc3WY08vlBouoN+goetcIKHV3XkalUlj7b5XAofnc1ZW
         czL+xrJibiV5MbPhlMzynXDLxfsH784PDF91dU14iqk5BVvzTY6FUELPcwNyfbXimO
         onEUb45+GvLz5z5FfAbP4Lqv7d/8WLYE7hUaPG5sJaZI8ytabeyQyH9mk6ayjeZV8B
         CP4yuLziE3FNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2FkYXB0ZXJfcXVpcmtzIHRlZ3JhMTk0X2ky
Y19xdWlya3MgPSB7DQo+ID4+PiAgCS5mbGFncyA9IEkyQ19BUV9OT19aRVJPX0xFTiwNCj4gPj4+
ICsJLm1heF93cml0ZV9sZW4gPSA2NTUzNSAtIEkyQ19QQUNLRVRfSEVBREVSX1NJWkUsDQo+ID4+
DQo+ID4+IElkZWFsbHkgaXQgc2hvdWxkIGJlIFNaXzY0SyAtIEkyQ19QQUNLRVRfSEVBREVSX1NJ
WkUgdG8gbm90IG1pc3MgdGhlIG9uZSBieXRlLCBvdGhlcndpc2UgZ29vZCB0byBtZToNCj4gPj4N
Cj4gPj4gUmV2aWV3ZWQtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4NCj4g
PiAgDQo+ID4gV2l0aCBTWl82NEsgLSBJMkNfUEFDS0VUX0hFQURSX1NpemUsIFdoZW4gd2UgY29t
cHV0ZSBkbWFfYnVmX3NpemUgPSBtYXhfd3JpdGVfbGVuICsgSTJDX1BBQ0tFVF9IRUFERVJfU0la
RSwgZG1hX2J1Zl9zaXplIHdpbGwgYmUgU1pfNjRLIHdoaWNoIGlzIDB4MTAwMDAgYXBiZG1hIGRt
YSBjb3VudCBsaW1pdCBzaG91bGQgYmUgPCA2NEsgbWVhbmluZyA2NTUzNSBtYXggaXMgYWxsb3dl
ZA0KPiA+IA0KPg0KPiBCdXQgaXQncyBmb3IgdGhlIEdQQ0RNQSwgZG9lcyBpdCBoYXZlIHRoZSBz
YW1lIDY0SyBsaW1pdCBhcyBBUEIgRE1BPw0KDQo2NEsgbGltaXQgaXMgZm9yIEFQQkRNQS4gVGhp
cyBwYXRjaCBoYXMgQVBCRE1BIHN1cHBvcnQgb25seS4gTm8gR1BDRE1BIHN1cHBvcnQgc28gYnVm
IHNpemUgbGltaXQgaXMgYmFzZWQgb24gQVBCRE1BLg0KR1BDRE1BIHN1cHBvcnRzIHVwdG8gMUdC
LiANCg0KSSB0aGluayBkbWFfYnVmX3NpemUgaXMgb25seSBmb3IgYnVmZmVyIGFsbG9jYXRpb24g
c28gc2hvdWxkbuKAmXQgaGFybSBmb3IgZXhhY3QgNjRLLg0KV2lsbCB0YWtlIGEgbG9vayBhdCBk
bWEgZHJpdmVyLi4uDQo=
