Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2419C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8077E218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XFrimcES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfBATUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:20:21 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12405 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfBATUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:20:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c549bd60000>; Fri, 01 Feb 2019 11:19:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 Feb 2019 11:20:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 Feb 2019 11:20:19 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 19:20:18 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 19:20:18 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 1 Feb 2019 19:20:18 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2888.namprd12.prod.outlook.com (20.179.91.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Fri, 1 Feb 2019 19:20:01 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 19:20:01 +0000
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
Subject: RE: [PATCH V9 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V9 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUulC5gnNOlUi0AEWt0UGRYeTykqXLS2aAgAAETSA=
Date:   Fri, 1 Feb 2019 19:20:01 +0000
Message-ID: <BYAPR12MB33984FB81B8BB1EC8C0C4908C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
 <951cf1f5-ba3a-94ef-0399-2259effebc99@gmail.com>
In-Reply-To: <951cf1f5-ba3a-94ef-0399-2259effebc99@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2888;6:nyXSes4Ftv7LYNFUHH60JrbW3d/ZVElhcRrGsGOfNRkDTD0SbIPBO5XIuuKEy+mVpXs8ADN7aknhayhtf2NqWLuwqSgjsnOBFb0DRsgyqkkCF6o5ZX7zsFhg1tNbo242/u32LJMKWFmZHktweeTYjffiLnCXJMvmGVUET3VMGyKsVxjeJrWWvJ9aCqR9M4N1Q5XnG/3jNfEfJA3TKN9DuscsiC+UfweJy8wrOwrT5slmrOA/iQCe1crFaLElB4Ka4ZZmI/MpZTBC9oAsaPwQICIf/qpQxDu4FNPKkCSzH/5GDfJXGwgplIv7SAGRPA3hG3bgZ6vFOKhF+PxVx4yGrKLI+1fguyKSQvAtQ/UOmNj5sBmoN0ghyjPlBzpVII+EEdZDWAnmpZp16trCBSlAGAVEpirCsj2tlDZo3wXUlVe1AASosaKG8zLkCneNc/hb3cH5UAwSVCdfRdYR7yI3Qw==;5:4bzVR989wJuSf/vloeZ0LMp8JlAVOL+kWH3TaaRETQNxKmnXR/I4IVclIeHGJaUN/2B8bk1gBGm6Gz39lx0Sf9NikohGMHi+iZVUejE7hpDZlFtXqjxYa+oOT/oBSMhuwgxWD8p44XFcBhwOPolXqoDOaAViCqNcdfpMi0/CiiSeZhX3ZtWa0CANAUuOR9lsBJ3t2BUvSBdRqkNgVE3bXw==;7:Dk9veGaHW90CQyQQBIL1Z3YWZ37msNh9a6lvi8/Y2KUTJYd08hZX73YTeyqyoDFyM1GeVwX6g0cN4PYbG8YOXZ0wl4Rbqh+Cu0QagPirjU8Te/xLwj4z75KSSMsaYkOEdmuQxKJ1Gm+C9mooRMWy9Q==
x-ms-office365-filtering-correlation-id: 9160f9eb-6be5-4042-2abd-08d6887a4334
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2888;
x-ms-traffictypediagnostic: BYAPR12MB2888:
x-microsoft-antispam-prvs: <BYAPR12MB288889F6794E12AA54CA3A6BC2920@BYAPR12MB2888.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(9686003)(486006)(71190400001)(256004)(71200400001)(106356001)(97736004)(99286004)(86362001)(446003)(14454004)(39060400002)(476003)(53936002)(11346002)(33656002)(316002)(14444005)(6246003)(229853002)(55016002)(110136005)(105586002)(6436002)(54906003)(6636002)(2906002)(186003)(8936002)(74316002)(81166006)(68736007)(6506007)(76176011)(7696005)(3846002)(4744005)(81156014)(478600001)(4326008)(8676002)(102836004)(305945005)(26005)(2501003)(7736002)(25786009)(66066001)(6116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2888;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E9IeiufL2ShHDw7x+XP7jZYaeougOw5IlyuptgYHpBcQuhQDnkqP1HcctxPkFN8KjPiTPRHoAWaVZtry6EQHFXiKecQsymsi/lekLp5OfYEYmOb2gLRl0GcmESwOl6iJP3MVYSYGwUj2c4HDUSqAUvVu+FW2kO5UyScZF0jWsfBUd2JBTlUO2G4ZLBmERS/D0E/hOrDQa2Jc8unoZgjcq09shR9Bjo4s2nyLUQzEVyrYic9urquE/AYimizC8r4St5h8m8/+ctn5AqjDvM13rnyMmx6vzHzyOqUXTsps6awHF7ZxHD5/CCWX0v4PByAx35ffV33W08Y/ayRrug4IH4fFfEa/zAWjxh26q2yclv+Z2BFRgkSYMGo2GgnBSimdJ8HGipiUhEELPoJhBvfZUhphHr07tktu4H1EyVd5LCA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9160f9eb-6be5-4042-2abd-08d6887a4334
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 19:20:01.2492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2888
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549048790; bh=wHgknA82eVQxc33mz/ryAhhW3AIDkX+cALSvUBJ0ju0=;
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
        b=XFrimcESb1uk7PETOrbJ0e9yW2SCVe5eJ3OD7Ekp32AR3+pDVtf7MjD5YeDtTXoXX
         5XM7K/h97cwMHZpTABU8ks/9EZSboOx+MJFc8ZrxJ58nnG5/WHTEGbJVYQOIA4Lb9I
         3fIzC8+iQxcwtYz+BCXTiYShsAsndBPwGFAFZoni5vGi3cbyDvz2XdcT+Uetbbx/Uy
         iMjxQVyVMtKyzlPsYj7koEQLmQ96/jNeQB4W6gk/pgf6vg1CdcEPmKlrrYwbrV91+R
         xKUtsOaKpBwSMerD/Gf52MMnOCwwEtn5GSeIsJxJpUQLafgNma+MHEMgwXJySWgB6J
         p1N1B3mdI3vfQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gK3N0YXRpYyBpbnQgdGVncmFfaTJjX2luaXRfZG1hKHN0cnVjdCB0ZWdyYV9pMmNfZGV2
ICppMmNfZGV2KSB7DQo+ID4gKwlzdHJ1Y3QgZG1hX2NoYW4gKmRtYV9jaGFuOw0KPiA+ICsJdTMy
ICpkbWFfYnVmOw0KPiA+ICsJZG1hX2FkZHJfdCBkbWFfcGh5czsNCj4gPiArCWludCBlcnIgPSAw
Ow0KPiA+ICsNCj4gPiArCWlmICghSVNfRU5BQkxFRChDT05GSUdfVEVHUkEyMF9BUEJfRE1BKSkN
Cj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4NCj4gRHJpdmVyIHNoYWxsIG5vdCBmYWlsIHRvIHBy
b2JlIGlmIERNQSBkcml2ZXIgaXMgZGlzYWJsZWQsIGJ1dCB0byBjb250aW51ZSB3aXRoIHRoZSBQ
SU8tb25seSBtb2RlIGF2YWlsYWJsZS4NCj4NCj4gU2hvdWxkIGJlOg0KPg0KPglpZiAoIUlTX0VO
QUJMRUQoQ09ORklHX1RFR1JBMjBfQVBCX0RNQSkpDQo+CQlyZXR1cm4gMDsNCj4NCkV4Y2VwdCBF
UFJPQkVfREVGRVIsIGFueXRoaW5nIGVsc2UgcmV0dXJuZWQgZnJvbSB0ZWdyYV9pMmNfaW5pdF9k
bWEgKEVOT0RFVi9FTk9NRU0pIGlzIGlnbm9yZWQgaW4gaTJjX3Byb2JlDQpETUEgbW9kZSBkZWNp
c2lvbiBpcyBiYXNlZCBvbiB4ZmVyIHNpemUgYW5kIGF2YWlsYWJpbGl0eSBvZiBkbWEgY2hhbm5l
bCBvciBjYW4gYmUgY2hhbmdlZCBiYXNlZCBvbiB2YWxpZCBkbWEgYnVmIHRvIHNob3J0ZW4gdGhl
IGxpbmUuDQoNCg==
