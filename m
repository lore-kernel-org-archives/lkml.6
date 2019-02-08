Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D289FC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA152177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="e8xor/wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfBHSSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:18:07 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:14911 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfBHSSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:18:07 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5dc7dc0000>; Sat, 09 Feb 2019 02:18:04 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 10:18:02 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 08 Feb 2019 10:18:02 -0800
Received: from DRBGMAIL101.nvidia.com (10.18.16.20) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 18:18:00 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by DRBGMAIL101.nvidia.com
 (10.18.16.20) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 18:17:59 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.50) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 8 Feb 2019 18:17:59 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2712.namprd12.prod.outlook.com (20.177.124.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Fri, 8 Feb 2019 18:17:37 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 18:17:37 +0000
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
Thread-Index: AQHUv9bE0/Y/Hcdfq0yQz/32u+ruR6XWMncAgAAB09A=
Date:   Fri, 8 Feb 2019 18:17:37 +0000
Message-ID: <BYAPR12MB339810D394AC0A50934DD5EAC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549648195-3989-1-git-send-email-skomatineni@nvidia.com>
 <1549648195-3989-3-git-send-email-skomatineni@nvidia.com>
 <0c30dfe0-1174-0056-5ef6-432b75de2353@gmail.com>
In-Reply-To: <0c30dfe0-1174-0056-5ef6-432b75de2353@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2712;6:+rDtHBIy+uU1KWIWrU2nEzqsJpyBdzFOC5T3x+lthkZe3S8urN1DqY3axWsw+EiFyGjRILOYQuZc0otWtxj2ugrlVGtPbX3zWcd/CvtLjtZf/HgUtwvoSxQiNCwSlEZr5KlaFd+GkxX30neD99n+r7x+6cE0vXt0Ld5oY+iieLIgkAKQnwuvmZOFCm5w2dNA1Ny6CHWdzmqngGvLgsUvUFaeLwWb7WsU4vM1sZqb0NTJJzF9wSeAtQ1gIJ4J2BP+13kWCd6nMVaz4O9b7l2cf0m2u+z8r/PD/pagBLNkRYJQ9SXsiAVqD9IgcdpWXdGEdTvUXp7Lqu0Vys54mPVyPThR4xZbpMtBnSKjJOtmC/bJyrTF3xj42vyOqeaajNOtYxJ70prpRygvTPGCuIaaA5Hy9Xrci+BVRWRj9IQI1h+gOnHboRv2NuRIPQ/0DxEMHIyFhdXqj+khX0tqcvbScg==;5:C4ijSaU8v808L82Rq5KXPpiY8XtCjoJFSgOPtSsAWfQdODR1LW8jqWSk7haS2EJyEwGErg+RKJhGW+FU+0DvhMSSCYAk4zdYGqQ8tETbEuaXDkAdkkcICiaDGuF+drFtM7dSV4rNNp9ngr2K3/8uUFbuGRIYCdgBmNrNzLbsbd2wUCjSmcFIGsmwWt0u/1t3IRzbUAzKKpzlS4UkLnUkgg==;7:sutsGa0/z0VxbGLYAbKQmWDvZgWYOZ3g4ed88pVTQQmA5VKKJozB1d3dy7+rpwOpW8jzu7vRpFT1TXoFpTXfWo3147EO8mjTux/oL9HhU688qnFm3Ot7BUPihrkdrU/2mgk5XP18MUqELD1/Ncu6DA==
x-ms-office365-filtering-correlation-id: a7601f87-c031-46cf-0984-08d68df1b467
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2712;
x-ms-traffictypediagnostic: BYAPR12MB2712:
x-microsoft-antispam-prvs: <BYAPR12MB2712559D4B254B8527FB8B80C2690@BYAPR12MB2712.namprd12.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(396003)(346002)(189003)(199004)(53936002)(9686003)(110136005)(478600001)(316002)(14454004)(229853002)(54906003)(256004)(26005)(6436002)(186003)(14444005)(7696005)(6506007)(102836004)(446003)(11346002)(55016002)(99286004)(2906002)(6636002)(476003)(76176011)(486006)(86362001)(97736004)(2501003)(68736007)(105586002)(106356001)(4744005)(25786009)(33656002)(4326008)(6246003)(7736002)(305945005)(71200400001)(8676002)(8936002)(81156014)(74316002)(81166006)(71190400001)(3846002)(6116002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2712;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SD+Ubm2MUt22NbmI2hFskEfRyEmAYWClDUhl4Yd8b/LW6kiWNYFFMjYYT/1/bcgfWKrsLxtrhIcTG3ZfLTHOkFtbepo74rhry6RqyGCvF/b1T5bAYHV86rpg5MmcAalcYVRtVKHUB/qoawcllWArOeoSxOX3VQ7kxyxfktGJXvuA6oNqUnHb9x6ypuHR51HBXyus0EiEsZnXIuapBMpk7T5/WlEx5JnGkSlSTCVbp4iFLbmDkzZGS2n3YYAl80yIWqNJtPr+ZZIzxBcBsEy5GFR7CK1M2Vj97ixkKS++hGuB7hYDWRDIQzbdD97OLpTVo9hrLGHt5rd2cAYNxmMwDGHxD0gfVivCSLBFdxMYUcOG/kMPHWTDKgEGMrl+dlgKivzLYqOlHxCUpCsUNwc0tPBAPLCtkpV9agF/8oPoTWk=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a7601f87-c031-46cf-0984-08d68df1b467
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 18:17:37.0488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2712
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549649885; bh=HFgL/5GyaiFCCpPik3gcLDTfMWJ08WtPJwIKoJEe6lE=;
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
        b=e8xor/wxV37+dHhFH5cfR71lDIHdlRVG6Nh9uWUSuhYBgQhor1S/E0evohEej6bLQ
         HG17e3Uw4LBmDeyr7KFI4hpDWlUgCNs+ckRDgjk/lPRPDsooT+xEXepomkZvCEuRxd
         LZwi7foQO/DjTnu/d5GjTbVeKOUDQjxYbKhD/5/9DQbz7ZahnL0iSGrfF0SgVwAtPe
         AZPEUUnBlvkfcAbvVN6GrL+njibZv8zhoROKnUd4Rxzu++fHocKysrh4Z+bI77D3OD
         lKPvWb2Csqv61EAb4nOt1H0aQZABfi2TJokYYZE3ThEBnpaI2nwhrkmU51z0OoC9Yh
         ZjkeULkb6pXPg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2FkYXB0ZXJfcXVpcmtzIHRlZ3JhMTk0X2ky
Y19xdWlya3MgPSB7DQo+ID4gIAkuZmxhZ3MgPSBJMkNfQVFfTk9fWkVST19MRU4sDQo+ID4gKwku
bWF4X3dyaXRlX2xlbiA9IDY1NTM1IC0gSTJDX1BBQ0tFVF9IRUFERVJfU0laRSwNCj4NCj4gSWRl
YWxseSBpdCBzaG91bGQgYmUgU1pfNjRLIC0gSTJDX1BBQ0tFVF9IRUFERVJfU0laRSB0byBub3Qg
bWlzcyB0aGUgb25lIGJ5dGUsIG90aGVyd2lzZSBnb29kIHRvIG1lOg0KPg0KPiBSZXZpZXdlZC1i
eTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29tPg0KDQpXaXRoIFNaXzY0SyAtIEky
Q19QQUNLRVRfSEVBRFJfU2l6ZSwgV2hlbiB3ZSBjb21wdXRlIGRtYV9idWZfc2l6ZSA9IG1heF93
cml0ZV9sZW4gKyBJMkNfUEFDS0VUX0hFQURFUl9TSVpFLCBkbWFfYnVmX3NpemUgd2lsbCBiZSBT
Wl82NEsgd2hpY2ggaXMgMHgxMDAwMCBhcGJkbWEgZG1hIGNvdW50IGxpbWl0IHNob3VsZCBiZSA8
IDY0SyBtZWFuaW5nIDY1NTM1IG1heCBpcyBhbGxvd2VkDQo=
