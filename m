Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908AAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514002175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pR/zE1DF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfBGQJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:09:05 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:20309 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfBGQJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:09:04 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5c581c0000>; Fri, 08 Feb 2019 00:09:00 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Feb 2019 08:09:00 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 07 Feb 2019 08:09:00 -0800
Received: from DRBGMAIL103.nvidia.com (10.18.16.22) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb
 2019 16:08:58 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by DRBGMAIL103.nvidia.com
 (10.18.16.22) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb
 2019 16:08:57 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 7 Feb 2019 16:08:57 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3000.namprd12.prod.outlook.com (20.178.53.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 16:08:36 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 16:08:36 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V14 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V14 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvlB3grXi65/4z0qjAfijKk4nv6XUXYuAgAAWpyCAAAwFgIAAAVQAgAAAQYA=
Date:   Thu, 7 Feb 2019 16:08:36 +0000
Message-ID: <BYAPR12MB3398D9CA36FCFF81BBC8E7B5C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <32b0b694-f912-044e-1a50-55b9c355d0c3@gmail.com>
 <BYAPR12MB3398350797241F90AE347FB5C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
 <0a7d62c4-9dcd-08dd-4e3f-877184848daa@gmail.com>
 <20190207160630.GB17445@ulmo>
In-Reply-To: <20190207160630.GB17445@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3000;6:pFCsYRwACrGQ4v1vku1B02nyN0Fbl9f8eLsLcLHbLxjoOD87t3nCBNuIXUGPXN51LlT4jyJQmmssSIJX6nbupeitxxCUWK1NpoXSpZdhia6lo+pm5duDh8OhI9dYQbZCQWOy1u0olpT/pWUsQZhRPfu2mGWP7qAUkyJX+jbhpXvVVdxf6fKzW76JWTB6nabyMnnddfk9qD5kzCKS6fE5j4XTBnxSE6+HOrATIG2doqbytiz70GQJw3+yZoaP3d7IR+zyo/8V+Ldfx/AK83u3LzHWjaK/WZx9PME6h6klWksa5RS+QXp7o6UikbAAzFrCS0QxtAAyCt8dzlDrWn0XYI2SeoRHIHnTPZorf1Lh6AIzYo5ANDEtfWIMmhOJoKWfRarsa7JnyjP6mIvhtRHDXkoWfRzqKVvjHggdo39Hwok0S/Iu2DLVvpKXe72kdUslSsSGjm2xVc36uFp+qv5LDg==;5:knoKhW/otMxK3JQyD969OKz2MuqdBjZ8PEgNOM4Z37ihFTS+76et/1piF2sNSq6BuXqul8lXl/GbdKlxX4TvAN60Yo8hoIwGDZB71MRNcjpizGdQmIDFfFu9pHKqfaXe3qJ3KcPBLID1wQ3h4jl8VpJb+Y5alORYSGaqDpwNJiN+ekWMvBzB302IXA7vcU/9/zVfRgHzEyMsKlEW0v+pXQ==;7:YkaPitB0J/winj0axGRXLBKLtg7elT3VGZS55yAPVWV7LQSqUcaFoueBbu4JZNDYf3jbZFPZld8YEeCYXBFQ43AA57O+G0ggd0cOhvjYEuG3fJA9VunkmLH2nfl8bEucT3Q6ygwkoyNbF+i+ssid+g==
x-ms-office365-filtering-correlation-id: 9b19c855-32a4-4618-713a-08d68d16842b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3000;
x-ms-traffictypediagnostic: BYAPR12MB3000:
x-microsoft-antispam-prvs: <BYAPR12MB3000B90F811A2065FB715FC3C2680@BYAPR12MB3000.namprd12.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(43544003)(11346002)(256004)(14454004)(66066001)(14444005)(2906002)(68736007)(478600001)(7736002)(8676002)(3846002)(6116002)(305945005)(486006)(446003)(93886005)(81166006)(81156014)(8936002)(9686003)(229853002)(86362001)(74316002)(476003)(55016002)(33656002)(97736004)(71200400001)(25786009)(6436002)(76176011)(71190400001)(110136005)(186003)(316002)(54906003)(6246003)(26005)(6506007)(99286004)(106356001)(102836004)(4326008)(7696005)(53936002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3000;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R8nEpYHeaMnrihU8d9ryjIF+9Fhna7z0evBO7F4QpCsnzoosLR46/Eh0zK4KruyKDL/XC3NxfdOQm5mfKETbRKXBfwPD6IO9rG9lKgSasyQRCGdlOsnBnNduJ9LH5lIWhV6qc4MFLGu2eWrxWAD2dnOETWSXJ2ML6ioHPWqt5y4AJ5nVFIwt5281xCe0wZTfNP4BRLboxytk+V5nd2Iit+9PMcRbufaY7UoN7JHYF8pOV386kpprH+JT0QWzMLvZoJVsLTRG5drn8s2OlPTDU9Bf5nNjrc9fq37FSnHgx4fdCLWYINaV6H3UahrtyCBQFMYzycfMh5JVGx5JEGP+86UA8C5ZmbTb09XV5pSmfpaGZdANAx/rrCo0IAELG/J1LRvY3HYHZXEvksL5r2caVX5tmI1JImVv7CQcqE0MrtQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b19c855-32a4-4618-713a-08d68d16842b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 16:08:36.3688
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
        t=1549555740; bh=vpumj5Q0PB3vZCNn+oE/s/qD+bV9mUfdFSNxWbl0pcs=;
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
        b=pR/zE1DFEAHE2fsfHRDjgkpr/yVx7v8CdDNSc7l1uqDZzzxaWNFUtlhjFfQeEg7iD
         Y0VzF2BjAZRmnFMoUZeHptgDIFVQL4uLx/XWqRwF1Y4TnO9+5NeZTQBlmjrrT5gvWK
         vuM3G7U35FV47GcNvNHt1t4Ryd9KLCnkkKx90obAuQRIt9ele3WVkiBTvzpSTI+2rX
         OagcU/rMNMsfD3r2kW+PMoLX/e7MepOyk8IEd7S+FWJ4BMUOwLOgSRjyWx8f6oz46i
         7Fy83uHqOf2GHFtk8F5PItNmd9DSWeesW8Slkif60TDFTCmCPEHercX8WjC0vPY/YJ
         BcICMOJTZdhTw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gPj4gSXQgYmVjYW1lIGFwcGFyZW50IHRvIG1lIHRoYXQgdGhlcmUgaXMgYSBwcm9ibGVt
IGhlcmUuIFRoZSBzaXplIG9mIGRtYV9idWYgaXMgNDA5NiBieXRlcyBhbmQgbWF4aW11bSBtZXNz
YWdlIGxlbmd0aCBpcyA0MDk2IHRvbywgd2UgaGF2ZSBwdXNoZWQgMTIgYnl0ZXMgcGFja2V0X2hl
YWRlciB0byB0aGUgYnVmZmVyID5hbmQgbm93IHRoZXJlIGFyZSA0MDg0IGJ5dGVzIGxlZnQgZm9y
IHRoZSBtZXNzYWdlIGluIHRoZSBidWZmZXIuIEhlbmNlIHRyYW5zZmVyIG9mIDRLQiB3aWxsIGNh
dXNlIGJ1ZmZlciBvdmVyZmxvdyBhbmQgZWl0aGVyIGNyYXNoIGtlcm5lbCBvciBjb3JydXB0IG1l
bW9yeS4gT25lIHNvbHV0aW9uIGlzIHRvIGp1c3QgYWx3YXlzID5wdXNoIHBhY2tldF9oZWFkZXIg
dXNpbmcgUElPLCBvdGhlciB0byByZWR1Y2UgbWF4X3dyaXRlX2xlbiBvciBpbmNyZWFzZSBkbWFf
YnVmIHNpemUuDQo+ID4gPiANCj4gPiA+IFllcywgVGhpcyBpcyBrbm93biB0byBtZSBhbmQgSSB3
aWxsIGFkZCBzZXBhcmF0ZSBwYXRjaCBmb3IgdGhpcyB0byANCj4gPiA+IHVwZGF0ZSBxdWlya3Mg
dG8gdGFrZSBjYXJlIGZvciB0MTg2IGFuZCB0MTk0IHRvIGV4Y2x1ZGUgcGFja2V0IGhkciBsZW5n
dGhzIFRoZXJlIHdhcyBzZXBhcmF0ZSBwYXRjaCB3aGVuIHF1aXJrcyB3ZXJlIGFkZGVkIGFuZCBp
dCBnb3QgbWVyZ2VkIGFscmVhZHkgZnJvbSA1LjAtcmMxIGJ1dCBkb27igJl0IHdhbnQgdG8gc25l
YWsgdGhhdCBoZXJlLiBXaWxsIHNlbmQgc2VwYXJhdGUgcGF0Y2ggdG8gdGFrZSBjYXJlIG9mIHRo
aXMuDQo+ID4gPiBOZWVkIHRvIHVwZGF0ZSBxdWlyayB0byBleGNsdWRlIHBhY2tldCBoZWFkZXIN
Cj4gPiA+IA0KPiA+IA0KPiA+IE5vLiBUaGlzIGlzIGEgYnVnIG9mIHRoaXMgcGF0Y2gsIGl0IG11
c3QgYmUgZml4ZWQgaW4gdGhpcyBwYXRjaCBhcyB3ZWxsLiANCj4gPiANCj4NCj4NCj4gSSdtIG5v
dCBzdXJlIHdlIGFjdHVhbGx5IG5lZWQgdGhpcy4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGl0
J3MgcmVhbGx5IHRoZSBwYXlsb2FkIHNpemUgdGhhdCdzIDQgS2lCIGFuZCA2NCBLaUIsIHJlc3Bl
Y3RpdmVseS4gSSBkb24ndCB0aGluayB0aGF0IGluY2x1ZGVzIHRoZSBoZWFkZXIuDQo+DQo+IFRo
aWVycnkNCg0KQXMgcGVyIHRoZSBkZXNpZ24sIFllcyB0aGF04oCZcyBpbmNsdWRpbmcgdGhlIEhF
QURFUi4gSXRzIHRvdGFsIHRyYW5zZmVyIHBlciBwYWNrZXQgaW5jbHVkaW5nIGhlYWRlci4NCg==
