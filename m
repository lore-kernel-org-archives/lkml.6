Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB20C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49B52175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YzIzp8KC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfBGPXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:23:31 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17943 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBGPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:23:31 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5c4d620000>; Thu, 07 Feb 2019 07:23:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Feb 2019 07:23:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 07 Feb 2019 07:23:30 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb
 2019 15:23:29 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb
 2019 15:23:29 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.50) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 7 Feb 2019 15:23:29 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2855.namprd12.prod.outlook.com (20.179.90.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 7 Feb 2019 15:23:11 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 15:23:11 +0000
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
Subject: RE: [PATCH V14 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V14 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvlB3grXi65/4z0qjAfijKk4nv6XUXYuAgAAWpyA=
Date:   Thu, 7 Feb 2019 15:23:11 +0000
Message-ID: <BYAPR12MB3398350797241F90AE347FB5C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <32b0b694-f912-044e-1a50-55b9c355d0c3@gmail.com>
In-Reply-To: <32b0b694-f912-044e-1a50-55b9c355d0c3@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2855;6:+9AYw2ehE7H071wMqq1t/p3YpL21ZzlNfKIHAg0Vu8YnI8a7+SSPK1EnalAPBujVXdHnnZ9ib3w+XJ11MHdVQ3LOAMj8Rqmg2IIEnnqdzZGJBXKeP+y9527ZGZJU6gn4sX3TNvlUnRouTRdOe2/AE8tbe8BCT+eYu9BGOwDq9/OeFKA2g3lL8Ox+SACVHPr/qW6JzKp83gCTHJWG839Esdp+mLwzn6a15Fn4UKzYv5y+tMAs3hz7ce4iLUW5guwSSkCTCr+oH9wSFxqgHzW928jMAOPaFZE6gpK+wR9kb19h0bf3SaijOouYRrpFp5AW9tTSC4kVzKizs9od8PAduObstSRro74KjTkk+4vcWwwEBmEJKCSoNKz3Y0TwFRebGxWirCDeRhxYZXYAtFbzAwvwPWGlm5tXAbQnBrfl5UeUnjxJzC/xFWvvCp9TZOvh9gzzTFJmmEDTFnzbuVjowA==;5:YInyW4eCHaroQJsjMAKgk/CQBp838fOCcOSyp+lvr4d3JkwYFtBwZqhxIkhoNxH62Iil17413hb1MwAekxzUECbyRYHzQuwaSOy+Z5t6yy4Yq3wNRO4GJzElxhB/qk7TB23RVktampwxzQDp/Pk292ud/u/rz2igjztsjAc+30hPLHWiMP35AfPHGVFEOjnVBFK42vDld7Cr5hHiIWRIeA==;7:yRYBuBUOui1ZXZ5BtEweqD60hM70KF/bLuHJOw1aMBmHz4RLeNdtZDLIXeaX6aoZh9gI9qSMuRt6nPiUU3yWn/z8Cr9EOeSNx2qa4qXQ5SZiNsF3xF9ZLdh0dhdv4okP1eFcj6NPM4d8lBusBt6Vvw==
x-ms-office365-filtering-correlation-id: 23c5f293-1fcc-4362-ff66-08d68d102bc5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2855;
x-ms-traffictypediagnostic: BYAPR12MB2855:
x-microsoft-antispam-prvs: <BYAPR12MB2855ECE9923C533C36E16982C2680@BYAPR12MB2855.namprd12.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39850400004)(376002)(136003)(43544003)(199004)(189003)(8676002)(106356001)(81156014)(105586002)(7736002)(6246003)(305945005)(14454004)(81166006)(2501003)(76176011)(6116002)(3846002)(8936002)(7696005)(6636002)(99286004)(478600001)(316002)(68736007)(25786009)(74316002)(97736004)(54906003)(110136005)(4326008)(33656002)(486006)(26005)(2906002)(14444005)(4744005)(71190400001)(71200400001)(53936002)(186003)(229853002)(6436002)(256004)(102836004)(86362001)(9686003)(55016002)(11346002)(476003)(6506007)(66066001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2855;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 10b6yLJG9ghiycfJGgxExyAmB3Gx3GKjpJli/qAZKlG3XzpFrq7znoTC3Sm27G5PKh3Nxjq/kYKFpbARqHps3BovkQpOP6YVbgXhmomgniUnpfNVignltwItlbMmTIsek047me8nFc0Y5Kbmiu8qGCcCB+ebXDhYnKqYWWEoBz4SmKknm7/8tCjPe2zva1Srf9y5Q8zMEE1tKRrKnJzbonk3ZVQ7oZnfJS7bSWkgqujT8n151ABwVtr2wkKarAXnhRykhrpkJ5W3XP2W2GD05NuP2SPiN32l0mlaiRjBs/nwM0cw+qZnSr8w6IvGK+vNYq50xLVssgetX/qGicX3KBlTllhiVPmvdeAvWhuPdduLRFUydA9PJ1ct8aJIGFE1+9z/0ggPIZPNTYHOxEKg262MCS6w0hBIyvT8nDlc+lg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c5f293-1fcc-4362-ff66-08d68d102bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 15:23:11.1162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2855
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549552994; bh=HJaurmPCb278HBDj7EpuGzN2JBCMVhxvE70+H41KNnY=;
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
        b=YzIzp8KCR+OGj34r7070+bGy/HmououKLGhsUYW76eZaM7WOCuzzA4u18RCeRQszb
         U4LhJR7+g3SSsfQj1T/26V2TS71xgbxeMhC3pMm2TngB0mWU8BzPkjoCuiRySP6LTt
         eaVmisAoTpYMgyB+Dif2OEqorlcUMDaP7ZhO3zkspdpHteTgT7vWH/iIAIpfv5jn7x
         obCousDxjkAaGvs7Ern/M5E3ajZyGJWalVrGI8pNcKnJifi2sJUd64EJ01IMInkbpS
         M0xuCAqQxerhXa+4bX4FXQblsg01UKVPeXRjCz6E25w5H3iE+y5e5KgxVBagjId/mE
         OMoh5N07jJS4A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+SXQgYmVjYW1lIGFwcGFyZW50IHRvIG1lIHRoYXQgdGhlcmUgaXMgYSBwcm9ibGVtIGhlcmUu
IFRoZSBzaXplIG9mIGRtYV9idWYgaXMgNDA5NiBieXRlcyBhbmQgbWF4aW11bSBtZXNzYWdlIGxl
bmd0aCBpcyA0MDk2IHRvbywgd2UgaGF2ZSBwdXNoZWQgMTIgYnl0ZXMgcGFja2V0X2hlYWRlciB0
byB0aGUgYnVmZmVyID5hbmQgbm93IHRoZXJlIGFyZSA0MDg0IGJ5dGVzIGxlZnQgZm9yIHRoZSBt
ZXNzYWdlIGluIHRoZSBidWZmZXIuIEhlbmNlIHRyYW5zZmVyIG9mIDRLQiB3aWxsIGNhdXNlIGJ1
ZmZlciBvdmVyZmxvdyBhbmQgZWl0aGVyIGNyYXNoIGtlcm5lbCBvciBjb3JydXB0IG1lbW9yeS4g
T25lIHNvbHV0aW9uIGlzIHRvIGp1c3QgYWx3YXlzID5wdXNoIHBhY2tldF9oZWFkZXIgdXNpbmcg
UElPLCBvdGhlciB0byByZWR1Y2UgbWF4X3dyaXRlX2xlbiBvciBpbmNyZWFzZSBkbWFfYnVmIHNp
emUuDQoNClllcywgVGhpcyBpcyBrbm93biB0byBtZSBhbmQgSSB3aWxsIGFkZCBzZXBhcmF0ZSBw
YXRjaCBmb3IgdGhpcyB0byB1cGRhdGUgcXVpcmtzIHRvIHRha2UgY2FyZSBmb3IgdDE4NiBhbmQg
dDE5NCB0byBleGNsdWRlIHBhY2tldCBoZHIgbGVuZ3Rocw0KVGhlcmUgd2FzIHNlcGFyYXRlIHBh
dGNoIHdoZW4gcXVpcmtzIHdlcmUgYWRkZWQgYW5kIGl0IGdvdCBtZXJnZWQgYWxyZWFkeSBmcm9t
IDUuMC1yYzEgYnV0IGRvbuKAmXQgd2FudCB0byBzbmVhayB0aGF0IGhlcmUuIFdpbGwgc2VuZCBz
ZXBhcmF0ZSBwYXRjaCB0byB0YWtlIGNhcmUgb2YgdGhpcy4NCk5lZWQgdG8gdXBkYXRlIHF1aXJr
IHRvIGV4Y2x1ZGUgcGFja2V0IGhlYWRlcg0KDQo=
