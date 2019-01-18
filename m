Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80390C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4060320823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PRj9fFmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfARR07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:26:59 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:35451 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfARR06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:26:58 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c420b2e0000>; Sat, 19 Jan 2019 01:21:50 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 18 Jan 2019 09:21:47 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 18 Jan 2019 09:21:47 -0800
Received: from DRBGMAIL103.nvidia.com (10.18.16.22) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 18 Jan
 2019 17:21:45 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by DRBGMAIL103.nvidia.com
 (10.18.16.22) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 18 Jan
 2019 17:21:40 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.58) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 18 Jan 2019 17:21:40 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2662.namprd12.prod.outlook.com (20.176.255.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.20; Fri, 18 Jan 2019 17:21:28 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%4]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 17:21:28 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V1] i2c: tegra: increase transfer timeout
Thread-Topic: [PATCH V1] i2c: tegra: increase transfer timeout
Thread-Index: AQHUrqTT4hSqS1loT0ud6K9yozGoVKW0wL8AgACDWYA=
Date:   Fri, 18 Jan 2019 17:21:28 +0000
Message-ID: <BYAPR12MB3398536A1776FE6B3CA1AB34C29C0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1547757572-29075-1-git-send-email-skomatineni@nvidia.com>
 <c6ba237c-d271-c9d7-1c30-9901ba6bb1a0@nvidia.com>
In-Reply-To: <c6ba237c-d271-c9d7-1c30-9901ba6bb1a0@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2662;6:7COHQ7VxANoYwtc51VLOzxy/NsOx6K5Hld+JTEsq9uXixVimfAuZq+gCyPvdtuejSCgkntnGGlt3BR3JOOUh8fqUVJYhdtx6DMjTRUs6DqO74dhJ1O7M5MNH0PB76YXkbepIVzjgwqWtfru/AqjXR5g2d9yPF+8UiTouI8GAEKn/E6Pa9d29hk4MWa22lbQ3gt7LXN2uKg+hTyquh65CB1+rphJw4KN9ugVnpnM6DrxGf4l1xtsd8eqx3//zS6qiCQk70ENtz3jVf9bLDLT8I4dX2qHLspwgf+BfQreUei+E7hIcHktjYO2ZdzZ9NKTsjSs+KOiJ/RpvqkhhgbYidDUpUUehcYl6xg/PrMchjo+tNoMf62lgSYIgQrq/KkmgTw/jaD40Myp9xY8vPsMo4TqJ/cCTJrtaO69g6Z7hnkxaYqgAL6odtLE1i7/D1xMqdKmwnUKp+Hta3dT8yrgQcQ==;5:I8o95EeN6VCpkwtI9ALXE0qYEp4r2XbodHWk4MzAc+jGlZVG2OQYpTcd/9u1cK8TWE5/uMoZvB2BykU0kfYEahMaMTSaP0Dh3tXcMTjnwDgW/vB+BnV0xMjJ6qUw7LL80imdNKVTj442DYXfvruxKNCH3KYLuKAFNOzy9R3pD5+UR0lGKteqj8XxLPeiyC0hkORqJIfxqteOYM6DfZXplg==;7:v3NchW7NNMypJXhAJgNr8k73SmUrUmXU/kNpFh1weyjJtdYGlvcI9dAIl6QM/Chv7mgSGjcv1dO+gDBjpOgkXq5c9v6Js3rST1yfQwFwSVXRVLJc4EWHJSMswbxKBLgcCFWkA+MZ1ENXlPakUeBGbA==
x-ms-office365-filtering-correlation-id: 98249209-ca46-4120-76f1-08d67d6961cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2662;
x-ms-traffictypediagnostic: BYAPR12MB2662:
x-microsoft-antispam-prvs: <BYAPR12MB26627FD249DFCC031465F914C29C0@BYAPR12MB2662.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(6636002)(7736002)(74316002)(14444005)(54906003)(7696005)(9686003)(25786009)(2906002)(6506007)(256004)(102836004)(3846002)(305945005)(110136005)(186003)(76176011)(8676002)(71200400001)(71190400001)(26005)(97736004)(476003)(8936002)(6246003)(2501003)(68736007)(81156014)(4326008)(86362001)(55016002)(81166006)(6116002)(14454004)(5660300001)(33656002)(66066001)(229853002)(11346002)(6436002)(39060400002)(53936002)(106356001)(316002)(105586002)(478600001)(486006)(446003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2662;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9PzSKGeIy/RyRBCKTXRZkIv9zTFWsPjqdPBBk62+790QyrWO8YQmhVMDlNanORGdbrJaq/S9TUybusNC7G6YO3WLfVSrg15GmM+eGZGpjUaZEd5oglYKmxeI22maNeyqNgN5YrRT+VBSMSijLACzB8WA5yESa/3yhQ+ItHVuWw6uTB4zN5dsLJ/IRJ8oZ7umOeUfH3/0wydx+k8x0fCbPGZJUGHSUdJD8XxmS+iOE266asIL3nILo/NjJAcRsAJpSVRLl0VLzdAiR51WJ9jLWEgrfJ22ZwOzzw9EUm5DHt7XLZEypeYxv/jGJMXaepQQ5tor9jxM1kdVoQr8NbvzAne6uACaDhDcYFaZYQrrfNJ8Y4yF/zG/eKUIHfcNLfG29CJ6KuS5NdQ3I+awAfUgcTAVEglsft4bM4PVWSzYElg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 98249209-ca46-4120-76f1-08d67d6961cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 17:21:28.3706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2662
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547832110; bh=cqDidv4FCYv4JMdHQlHMg3ArjhxVyy2tOkjX/hrKPEc=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=PRj9fFmNx+OFAW8tMIpSGexluHKdd28tE6og5H+QmvME299Mjp2P9mZKb+RsOIgd6
         Gl/8d4/Wj6BT8Rg9mAC0ph9f91cjY9OMaeHoECgQkJ7+80b24HgRc84odLMFgL6/U7
         s1dUaIDgDw7RrOZgoZGbI5jRtcM0aoE+mn8gN38fDOmSrFX7a5mZ7S2O67eyu5Cfjs
         bawZb/ASP2MXaC0OWlYC/xYFCXBTjCYSGEC4qLo78Wov4sYm7oivR9n+daIAFtwDVE
         IJKH8hWJatU3TLESFC99uhKmkg09+KSMwx2xa/20ubenE3GgCw78t1tQY9qqmuktH+
         21OPP6LKyVEwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4+IGluY3JlYXNlIHRyYW5zZmVyIHRpbWVvdXQgdG8gMTBzIHRvIGFsbG93IGVub3VnaCB0
aW1lIGR1cmluZyBtYXggDQo+PiB0cmFuc2ZlciBzaXplLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5
OiBTb3dqYW55YSBLb21hdGluZW5pIDxza29tYXRpbmVuaUBudmlkaWEuY29tPg0KPj4gLS0tDQo+
PiAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jIHwgMiArLQ0KPj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jIA0KPj4gYi9kcml2ZXJzL2kyYy9idXNzZXMv
aTJjLXRlZ3JhLmMgaW5kZXggZTQxN2ViZjc2MjhjLi5jYTdjNTgxZmI0YzAgDQo+PiAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtdGVncmEuYw0KPj4gKysrIGIvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jDQo+PiBAQCAtMjUsNyArMjUsNyBAQA0KPj4gIA0KPj4g
ICNpbmNsdWRlIDxhc20vdW5hbGlnbmVkLmg+DQo+PiAgDQo+PiAtI2RlZmluZSBURUdSQV9JMkNf
VElNRU9VVCAobXNlY3NfdG9famlmZmllcygxMDAwKSkNCj4+ICsjZGVmaW5lIFRFR1JBX0kyQ19U
SU1FT1VUIChtc2Vjc190b19qaWZmaWVzKDEwMDAwKSkNCj4+ICAjZGVmaW5lIEJZVEVTX1BFUl9G
SUZPX1dPUkQgNA0KPj4gIA0KPj4gICNkZWZpbmUgSTJDX0NORkcJCQkJMHgwMDANCj4NCj5TaG91
bGQgdGhlIHRpbWVvdXQgYmUgc2V0IGRlcGVuZGluZyBvbiB0aGUgbWF4IHRyYW5zZmVyIHNpemU/
IDEwcyBzZWVtcyBhbiBhZ2UgaWYgdGhlIG1heCB0cmFuc2ZlciBzaXplIGlzIDRLQi4gSW4gb3Ro
ZXIgd29yZHMsIHdlIHNob3VsZCB0aGlzIG9ubHkgYmUgYXBwbGllZCBmb3IgPlQxOTQrPw0KPg0K
PkZ1cnRoZXJtb3JlLCBpbiB0ZWdyYV9pMmNfeGZlcl9tc2coKSB3ZSBrbm93IHRoZSBsZW4gb2Yg
dGhlIG1lc3NhZ2UgYW5kIHNvIG1heWJlIGl0IHdvdWxkIGJlIGJldHRlciB0byBkeW5hbWljYWxs
eSBzZXQgdGhlIHRpbWVvdXQgZGVwZW5kaW5nIG9uIGxlbmd0aD8NCj4NCj5DaGVlcnMNCj5Kb24N
Cg0KWWVzLCB0aGF04oCZcyB0aGUgaWRlYWwgd2F5IHRvIGNvbXB1dGUgdGltZW91dCBiYXNlZCBv
biBtc2cgbGVuIGFuZCBidXMgcmF0ZS4gDQpUbyBkbyB0aGlzIEkgaGFkIHRvIHVwZGF0ZSBURUdS
QV9JMkNfVElNRU9VVCBtYWNybyB0byB0YWtlIGFyZyBhbmQgdGhlcmUgYXJlIDMgZGlmZmVyZW50
IHBhdGNoZXMgZm9yIHRlZ3JhIGkyYyB1bmRlciByZXZpZXcgYW5kIGFsbCBvZiB0aG9zZSB3aWxs
IGVmZmVjdCBhcyB0aGUgcGF0Y2ggY2hhbmdlcyB1c2UgVEVHUkFfSTJDX1RJTUVPVVQuIA0KDQpT
bywgU2hvdWxkIEkgaG9sZCBvbiB0byB0aGlzIGNoYW5nZSBmb3Igbm93IHRpbGwgdGhvc2UgcGF0
Y2hlcyBhcmUgbWVyZ2VkPw0KDQpUaGFua3MNClNvd2phbnlhDQo=
