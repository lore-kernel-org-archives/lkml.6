Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A74C282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C1E21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UexB+Ezu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfA3EPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:15:50 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:23678 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbfA3EPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 23:15:49 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5124f00000>; Wed, 30 Jan 2019 12:15:45 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 20:15:44 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 29 Jan 2019 20:15:44 -0800
Received: from DRBGMAIL104.nvidia.com (10.18.16.23) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 04:15:41 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by DRBGMAIL104.nvidia.com
 (10.18.16.23) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 04:15:40 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 30 Jan 2019 04:15:40 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2965.namprd12.prod.outlook.com (20.178.52.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Wed, 30 Jan 2019 04:15:34 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 04:15:34 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V5 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V5 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuCjcFQq4Ugnr9EajTUu9v/+Er6XHCbsAgAACEcCAABenIA==
Date:   Wed, 30 Jan 2019 04:15:33 +0000
Message-ID: <BYAPR12MB339812A2E876B76E95828EA1C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548803771-13424-1-git-send-email-skomatineni@nvidia.com>
        <1548803771-13424-3-git-send-email-skomatineni@nvidia.com>
 <20190130044214.65991195@dimatab>
 <BYAPR12MB339850895826781B4E6AF028C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB339850895826781B4E6AF028C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2965;6:WS8FNh6m57ntjHYQ1h+gOH2L2L6+Jw6F+EcmG0Yj8b6Brfzk13cfqmOSzaGEZZBJWxHn/V0o3XumKIv6UPhUK5GEFNxomsrGLpwEdRaGotkB7J2aHDH518e2shcd1kQDJZyk4T++dwraT9iTwFxjoZRgG/AzgjJjnhiLoh/kPcv6IcLJOdUkirlLiD2V4hi1bVZmkEiglLX5dTvpnyGUA+dzBDWfIO/aQjL0Z7zhweEIxamuQZgeFVU6HkthfB1ZzZigcflcRUg5er8NZWtTb6Y88+gdG9QYYQNnNebxsZvMRpNQRpmVfjH2orbSQSAQRRXvYl3lnbY3Li04jh6IzCFH2/dfnNEbt/0NmCaonQR/gOqNqT51uDVYnMo0sywMKOpeSgQyXVYYWI1s5JGshKKeQVajuoNdNAj/JHfig665ehOoyYwIhIuK2yGYcychcUHQ+HeEGew2yBCBLVKkKw==;5:ekjK/0SZJ/MXnLiF4zLmOwsvpJzmar4zKvBiBzoG4T8DXSQxOFw0oZAB2jt8afChCtBTBB0Kg9iyg3sd9kOuP6ADzSrpYmJtcFw7i6iG1J3nZdcKbvZhPpxrf4ERHfzlp6YZz0oelB9burwFQdir+CZazQpkyj60ivMC8lBL1KFuKoT8SSfXgVd6U5H9y5NY60Jx86Zf/sNviknKMsOrYQ==;7:UP9jfzU94zYhnx7akP1ccJ1Yq86yLaiPK3jCGo012x+PadiNuTEdkb5GHFuy+idSFPMPtXonrIz+dzlp/J5CssazaLQC3vUvMNduapWs0PreN/v7tiyJ3hLghHL7Y6p/mn0iOVboA3hn9lzq/0Hveg==
x-ms-office365-filtering-correlation-id: ed1f96cc-d2c3-4973-b924-08d686699487
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2965;
x-ms-traffictypediagnostic: BYAPR12MB2965:
x-microsoft-antispam-prvs: <BYAPR12MB29655846B04A5E69C075B86DC2900@BYAPR12MB2965.namprd12.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(25584004)(189003)(199004)(106356001)(68736007)(76176011)(105586002)(93886005)(1411001)(11346002)(186003)(9686003)(446003)(33656002)(476003)(6116002)(3846002)(55016002)(6306002)(486006)(74316002)(97736004)(102836004)(14444005)(256004)(26005)(6506007)(7696005)(81156014)(478600001)(81166006)(53936002)(8676002)(14454004)(8936002)(25786009)(2906002)(54906003)(966005)(39060400002)(4326008)(66066001)(316002)(229853002)(6246003)(6436002)(305945005)(99286004)(86362001)(93156006)(7736002)(6916009)(71200400001)(2940100002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2965;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X42UUK4Al1dI9tNe8koRuji0Npt9t99Mi6uDv6JFtnScvq0pTkH4jsB9vUJdIwYfGK5Dw6kLA2ooIxohcFnaQcDd13CHvvChpGiMMQlm65SPaYICrp7gApdRQptHB9bQHbjSm5ihn4Y+I5TiCutmsoJ+OUbuYxT9K6X0lpIwbquYqLT6jxZFtBkRpirCAUEoyobPq+GPwqNdhrQ0bouB6FHZWnbWXNiwOPnQ3SBACnppKhTEldi/xtW+bqrBWTdwbzZTPtA8Lpwg/Vt/u+Mmb2GQAW1d9Vb3OWSdoUq/pH6hzlhGHTYiiWqjBvNN66Pd3u8dEKvdYpwnAPvLSqLm0HetilWETZHWVuY4NbT61a1Y/7bpqXtt4bWAtoD4oLtyOG20E7uiCz3MQXfEkbQwZw+I289RsL1Yp8QipLtcB1k=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1f96cc-d2c3-4973-b924-08d686699487
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 04:15:33.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2965
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548821746; bh=S6xqkjRnrNMJ/kVE4sdzAnuiRtydEfGPGp+p1xmT4zo=;
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
        b=UexB+EzuwKhcjA0/J8AfVu6DvuBxwYEan0bhjNoWYaSMPBSUmWgV1sOqYTmYJ/9+w
         6HJHAf6x2n8AesQe+CVUFCHACdZuo33OxNGwMPUWAPrmC3D2MNoJd97WgevmDVs3Fy
         NgPFJK9W3InEuBjIcqZpVaXsyb3l3l6yWUfsjmUMcVEb5dm4wEAYJNgY0bqzcCKF7C
         /+ZJdy0hHkl5d0KVndQKuAv1lAtTbIdrUYf5yD7sk881yO+IpeiJaZOhx8FRpO8p0e
         7+Dw8JeJ89NxjfaQ8I1hzkkaV9ZqFIcEKp4r8s0NS0w/sA9OIb4Y30RNe3NPJTrRZL
         jmDMSs0cyUT7w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IENvdWxkIHlvdSBwbGVhc2UgdGVsbCB3aGV0aGVyIHlvdSBtaXNzZWQgbXkgY29tbWVudHMg
dG8gVjMgWzBdIG9yIGNob3NlIHRvIGlnbm9yZSB0aGVtPyBJZiB0aGUgZm9ybWVyLCB0aGVuIEkn
ZCB3YW50IHRvIGdldCBhbnN3ZXJzIHRvIHRob3NlIHF1ZXN0aW9ucyBhbmQgY29tbWVudHMuIEkn
bGwgc3RvcCBoZXJlIGZvciBub3cuDQo+ID4gDQo+ID4gWzBdIGh0dHBzOi8vcGF0Y2h3b3JrLm96
bGFicy5vcmcvcGF0Y2gvMTAzMTM3OS8NCj4NCj4gU29tZWhvdyBtaXNzZWQgdGhvc2UgZnJvbSBt
dWx0aXBsZSBjb21tZW50cy4gV2lsbCBnbyB0aHJ1IGFuZCByZXNwb25kIGJhY2suDQoNClY2IGlu
Y2x1ZGVzIGZlZWRiYWNrIGNoYW5nZXMuIFdhbnQgdG8gY2xhcmlmeSBvbiBmZXcgZmVlZGJhY2sg
cG9pbnRzDQoNCi0gQUxJR04gaXMgdXNlZCBmb3IgNCBieXRlIGJvdW5kYXJ5IHRvIHVzZSB3aXRo
IERNQSBidXQgZXh0cmEgYnl0ZXMgZG9lc27igJl0IGdldCB0cmFuc2ZlcnJlZCBvdmVyIEkyQyBh
cyBJMkMgY29udHJvbGxlciB0cmFuc2ZlciBieXRlcyBiYXNlZCBvbiBzaXplIHNwZWNpZmllZCBp
biB0aGUgcGFja2V0IGhlYWRlci4NCiAgRE1BIGxlbmd0aCBhbmQgbWVtb3J5IGFkZHJlc3MgbmVl
ZCB0byBiZSA0IGJ5dGUgYm91bmRhcnkuDQoNCi0gUlggY2hhbm5lbCByZWxlYXNpbmcgd2hlbiBU
WCBpbml0IGZhaWxzPw0KICBGb3IgSTJDIGJvdGggVFggYW5kIFJYIGRvZXNu4oCZdCBoYXBwZW4g
aW4gc2FtZSB0cmFuc2FjdGlvbiBhbmQgbm8gZGVwZW5kZW5jeS4gU28gaWYgY2hhbm5lbCByZXF1
ZXN0ICYgYnVmZmVyIGFsbG9jYXRpb24gZmFpbHMgb3RoZXIgY2hhbm5lbCBpZiBzdWNjZXNzZnVs
bHkgY3JlYXRlZCBjYW4gc3RpbGwgYmUgdXNlZCBmb3IgdHJhbnNmZXIuDQoNCi0gZG1hX2J1cnN0
IDwgOCBuZWdhdGl2ZWx5IGFmZmVjdHMgdHJhbnNmZXIgZWZmaWNpZW5jeT8gUGVyZm9ybWFuY2Ug
c3RhdHMgZm9yIERNQSBWcyBQSU8gbW9kZS4NClRlc3RlZCB3aXRoIDI1NiBieXRlcyBvZiB0cmFu
c2ZlciBhbmQgRE1BIFZzIFBJTyBtb2RlIHRyYW5zZmVyIHJhdGUgaXMgYWxtb3N0IHNhbWUuDQpC
dXQgdGhlIG1haW4gcmVhc29uIGZvciBhZGRpbmcgRE1BIG1vZGUgaXMgdG8gYWRkcmVzcyBjb3Vw
bGUgb2YgY2FzZXMgbWVudGlvbmVkIGVhcmxpZXIgYW5kIG5vdCBtYWlubHkgZnJvbSB0aGUgdHJh
bnNmZXIgcGVyZm9ybWFuY2UgcGVyc3BlY3RpdmUuIA0KDQoNCg==
