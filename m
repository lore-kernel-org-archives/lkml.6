Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43937C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054A720821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W/7XnRns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfBFNSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:18:05 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:24791 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730720AbfBFNSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:18:04 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5ade8b0000>; Wed, 06 Feb 2019 21:18:03 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 05:18:01 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 06 Feb 2019 05:18:01 -0800
Received: from DRBGMAIL101.nvidia.com (10.18.16.20) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 13:18:00 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by DRBGMAIL101.nvidia.com
 (10.18.16.20) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 13:17:59 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.57) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 13:17:59 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2901.namprd12.prod.outlook.com (20.179.91.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 6 Feb 2019 13:17:41 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 13:17:41 +0000
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
Subject: RE: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvaSihB2vPasFV02HZ/JY13Td7aXSqkqAgAAR9ACAAADL4IAAARIAgAAANpA=
Date:   Wed, 6 Feb 2019 13:17:41 +0000
Message-ID: <BYAPR12MB33986680570EB919369000F3C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <c4f67e39-df72-cc56-216b-8e6014891b52@gmail.com>
 <BYAPR12MB3398E50ED1C6909D6BCB0DDFC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <304c1916-e836-fa95-5cec-887fef8f3eb2@gmail.com>
In-Reply-To: <304c1916-e836-fa95-5cec-887fef8f3eb2@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2901;6:NhXpnoiLbs81GnpsV2/gR2E5v4situSn7koGULK19aoQBAwvtGSoxRwPktNSeo8BlzelH4RfQwCq23qpw+Xu23kzDHS79ew4O3Dhh4+9S3KhcS4xRdtFjoLaaiRb8nE5AZMHlzEfsUKRlV5++olCz6DduGDYmyUv2btXZ9S5miWxVYgUqac+Cz4/x/grMJZ8N+ZuTJ3tm+Htsc2Vos6sPI1IM+GtQdH4VpqmMSMJbnuijfWySoCA2cLOAcjyQdSpDvwhwwK4aI1Sl0Y3bco41z5nhV4tZuBxnfImHfsmx0FRSMEbPCYXg1enMBEYhE28h2s0fVW1DlnrPlAo+ENI91En8HLLgmSQwbyAQcXUSCqFyTqs5HbauF0FD9i9D4iAi4z2z51QEBOr3tI51+iBkwsXesnAadtPsuV2vuyRX8lnzBKU6MMyKrb/y7cCRikCQtG57dV0eaV8mcnKO4N2qA==;5:j6E2pK1xKfjmY63YeuJTMBV1dBMjQjOVePmlBWoy1y3hNNmYaHA9i22Y+U7ae8kw74hUZrYNTQzAbBD4iS+uk6sRBcLa2+P3ItonUkMRIEk3/ifG5RVFDcczREEdGusRhZClCO8gTWamB/gosVlOTp4rSRB48ke/Nw5019Y6Hit3DB1HzSHMx1PkitCs1WrUS0Xo1Kx6Norpl9CXLtBQWQ==;7:QDKoyft1SJ5wG7FEnijQNSvAwuUFIfLLLhZ8GtevzdQ9txTNo6F8QxaTx1w3yVFR+RKJ5u9d2nmdXu0dhO/zU0n1MJ0TujaypkZt4XPAZoFNoW+ldwQ88+asbonlfViZbYTOAdQ39qWcJuEw2Wr6Fg==
x-ms-office365-filtering-correlation-id: 786967cf-3447-473e-6360-08d68c357960
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2901;
x-ms-traffictypediagnostic: BYAPR12MB2901:
x-microsoft-antispam-prvs: <BYAPR12MB2901E044D4CB61E1223EEC0AC26F0@BYAPR12MB2901.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(86362001)(74316002)(97736004)(486006)(71200400001)(25786009)(71190400001)(66066001)(53936002)(6636002)(102836004)(6506007)(76176011)(68736007)(4326008)(9686003)(186003)(26005)(476003)(33656002)(6246003)(11346002)(446003)(6116002)(3846002)(93886005)(316002)(54906003)(55016002)(7696005)(6436002)(8936002)(14444005)(81156014)(81166006)(2906002)(256004)(8676002)(2501003)(305945005)(106356001)(7736002)(14454004)(229853002)(478600001)(99286004)(105586002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2901;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4nLT1eiJ4jQDGds+Z+JKElJJ89mf0T3kRFYkgfxkk2M8HNf1PZtwQcRWvND3F+Z3nn2bjE4C/G9inEJTxD6U7d0pGbdrcZj3+ykJdx8gYVfjiXgLj5RBHljcdYTefKa05DBh3kqvi4wgpWY2tocOb6/p64gB+vnqD8MLH4ZOO1XguJxnSUXtb9hgrrqZIvK/TGssjvehjNRlfITe19YXQ7jnwXioaBpOlmvh2KItlFJhHe2YOqO6Ini375YGJNrW3ppP6nVWIr+vT0KgM4llL1Z20HKS2xK8EVwCdCi7NPUJ/ecpol+U/GVjt9jDNm1DeGUfSgcrg3tOcjRJ5cOE+NGijFJF0C80Rktp0XSzsRWWgLNW8ZTS1tA8PkHDBCRZKvR6PZKkcFj5ZXBnKGfjK/ovoroTq265C35aDj1dhzI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 786967cf-3447-473e-6360-08d68c357960
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 13:17:41.5127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2901
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549459083; bh=+Tjs1CwDsSQeFzrKpZKXGUBJlatz7jT7HcGYuLVEotc=;
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
        b=W/7XnRnsSoF5PKg8uLCVv7ugeLRW6rTfZIM6x4M3XPVRGJqG6M2cA/vV8UGbmrL/f
         LjIv0fROFp4bQD85VlJTOjqKjIMrTs+zqGsaCSy73UH7Fiqr33MjMcsTcbB7PDP1pU
         juZUibcDycP7YpDyw2lo9o+QZNNAw1730w1nU//oWbhKtdXXZ9ynVnqXUP7/a3FJ4Z
         snmhXJv/Z7qms6ivKyN3Z74wp2LAPcHSTW4V+veQVeyVgBCCyGLTO+SiVew0yj+eE1
         WewD9Br6GvvWZHSprh3403v5RrH624mldVShIWXRjZVMPFwIFMq5bM9LYej83U81wJ
         zkv8/AT7rQbbw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPj4gQlRXLCBJJ20gc2VlaW5nICJhdG1lbF9teHRfdHMgMC0wMDRjOiBXYXJuaW5nOiBJ
bmZvIENSQyBlcnJvciAtIGRldmljZT0weEY0MzZEQyBmaWxlPTB4MDAwMDAwIiB3aGl0aG91dCBt
YWtpbmcgYW55IG1vZGlmaWNhdGlvbnMgdG8gdGhlIG9yaWdpbmFsIHBhdGNoIGFzIHdlbGwgYW5k
IGl0IHNoYWxsIG5vdCBoYXBwZW4sIGhlbmNlIHRoZXJlIGlzIGJ1ZyBzb21ld2hlcmUuIFByb2Jh
Ymx5IEZJRk8gdHJpZ2dlcnMgYXJlIHN0aWxsIG5vdCBzZXQgdXAgY29ycmVjdGx5Li4uID8NCj4g
Pj4NCj4gPj4NCj4gPiBJbiBzbmlwcGV0IHlvdSBzZW50LCBJIHNlZSB5b3UgYXJlIGZvcmNpbmcg
ZG1hX2J1cnN0IHRvIDEgYWx3YXlzIHdoaWNoIGlzIHdoYXQgc2V0IGZvciBmaWZvIHRyaWdnZXIg
bGV2ZWxzIGFzIHdlbGwgYW5kIGFsc28geW91IGFyZSBmb3JjaW5nIGRtYSBhbGwgdGhlIHRpbWUu
DQo+ID4gU28gYWx3YXlzIGl0IHdpbGwgYmUgMSB3b3JkIGRtYSBidXJzdCBhbmQgMSB3b3JkIHRy
aWdnZXIgbGV2ZWwgYW5kIHRoYXQgc2hvdWxkIG5vdCBiZSBhbiBpc3N1ZS4NCj4gPiANCj4NCj4g
SSByZXZlcnRlZCB0aGF0IHNuaXBwZXQsIHRoaXMgbG9nIGlzIGNvbGxlY3RlZCB3aXRoIHRoZSB5
b3VycyBvcmlnaW5hbCBwYXRjaC4NCj4NCkZyb20gYXRtZWwgZHJpdmVyLCBsb29rcyBsaWtlIHRo
aXMgd2FybmluZyBpcyBmcm9tIG1heHRfdXBkYXRlX2NmZyBhbmQgZHVlIHRvIENSQyBtaXNtYXRj
aCBhbmQgYWJvdmUgdmFsdWVzIHNob3dzIHJlYWQgZGF0YSBDUkMgaXMgMFhmNDM2ZGMgd2hpY2gg
aXMgY29tcGFyZWQgYWdhaW5zdCBpbmZvX2NyYyBvZiBhbGwgMCdzIA0KSW5mb19jcmMgaXMgYmFz
ZWQgb24gcmF3IGNvbmZpZyBmaWxlIGFuZCBzb21laG93IGl0cyBhbGwgMCdzLiB0aGlzIGlzIG5v
dCBiYXNlZCBvbiBkYXRhIHJlYWQgdGhydSBpMmMuIA0KZGF0YS0+aW5mb19jcmMgY29tcHV0ZWQg
b24gZGF0YSByZWFkIGlzIDBYZjQzNmRjDQoNClRoaXMgd2FybmluZyBpcyBub3QgcmVsYXRlZCB0
byBJMkMgdHJhbnNmZXINCg==
