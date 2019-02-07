Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B35EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E063C21919
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Qb/+N113"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfBGS4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:56:23 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:45840 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfBGS4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:56:22 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5c7f550002>; Fri, 08 Feb 2019 02:56:22 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Feb 2019 10:56:19 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 07 Feb 2019 10:56:19 -0800
Received: from DRBGMAIL101.nvidia.com (10.18.16.20) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb
 2019 18:56:18 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by DRBGMAIL101.nvidia.com
 (10.18.16.20) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb
 2019 18:56:17 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 7 Feb 2019 18:56:17 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3445.namprd12.prod.outlook.com (20.178.196.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 7 Feb 2019 18:56:14 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 18:56:14 +0000
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
Thread-Index: AQHUvlB3grXi65/4z0qjAfijKk4nv6XUr0UAgAAAKPA=
Date:   Thu, 7 Feb 2019 18:56:14 +0000
Message-ID: <BYAPR12MB33980D6751904EBEFC38BBAAC2680@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <e09062b7-9c74-6aee-477a-72fb72bbd5d3@gmail.com>
In-Reply-To: <e09062b7-9c74-6aee-477a-72fb72bbd5d3@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3445;6:TuUbVJAAoO+vg1sAkstm91U0aDsmmEo/PuQJ6+iZovFWUqZVzoK7b6xFw4Sm6RHbeFLVbnXnSSueBigU0tS1A3s7Q5OhlIDhFX5yiOp/XK1677daAJw+Aq4LRMGAgaHimNPz7d1t2kMPkvtStdTaAOPLuJWCTDPUOaE0GcX90FiJ8nKB8Qs2dkuAJ9+k+e/4NuD/Ge9r8hSRyJtKmIEeOpt6Vq+7xv4sFnKny9vDDlO4S9lF6Ly/kI7as6ooiseJscp/cWeQiLasD8wJRQ+wcBH16YijZ6EdmcKE86m4eAIUyYjIKcBSNBKwGNK2+1EPjRJwDNmGcBLB5V8gDXmjrrQlkzxnPI80Dv8P5SEBl7q7kUL596YgzT1wC+mYOovLS191FkI0Wh/hl9TIXNXJJSZRKRvRvFIRGnsF7ftI3ZI0/ApnirtWOuJbADIPYYe6U8lNgqYwrLNnlS4SkNFJCQ==;5:N2jePJ8/F5t9F3RcFLcqnAeMKCipID7VpaDxEW6gYTg0M6Y40QTfF43tagmQhGF9YXnTjTds94s9qrfgibOoHntQOz/voM9AHUwqk+GYUJC/hCVKVaFbRRV3jkS53zqjhEidzxY3mH81d3Bxm+hHBdmZhK23m9Tockl4CNnAcvJ6E1J89pU6vkE0tXM2uOIpGlRpTqqzFVunEuZZ5y1+WQ==;7:H3J5RI03E9k0tx1Rsd9QMHPwCD3QVjSiBn0INuoSftH51X0Ta2I0zxZ93Bvh/39h6kHm5LkGt0o8AQD1WoRMHcCEtUHTUesVLnphrpONY1QArMUGc+2gc75uvJvE9ehvCWMtGAFcQYI/B/u3Jx221A==
x-ms-office365-filtering-correlation-id: ebd332a0-29f7-408e-3f56-08d68d2def45
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3445;
x-ms-traffictypediagnostic: BYAPR12MB3445:
x-microsoft-antispam-prvs: <BYAPR12MB34455CE85BBF1A8C01E8CD83C2680@BYAPR12MB3445.namprd12.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(366004)(199004)(189003)(256004)(99286004)(66066001)(2501003)(26005)(186003)(97736004)(105586002)(76176011)(7696005)(110136005)(9686003)(81156014)(8936002)(8676002)(7736002)(102836004)(6506007)(4326008)(14454004)(6246003)(54906003)(229853002)(81166006)(6636002)(6436002)(305945005)(55016002)(316002)(74316002)(86362001)(25786009)(478600001)(33656002)(53936002)(476003)(3846002)(6116002)(106356001)(446003)(486006)(11346002)(68736007)(2906002)(4744005)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3445;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EkQiWHGmcIhg9fDcBkp4MyTMFf3rkH64wqhxbPDErPgsxvS+5+23a9LhSe49RaPBVImDMKPgQGDqIC5L7GgJTbx7yHSEHRcPg3U1W3RkkPLw80hZt5W19zdoew5RENZy9wa7XOQE5xirdJ8Q37EVLGrcQuYR+812AONeqeAN81I5nRYEvGw63trhA5hqOxbuhzg6ZvHrojL1YOgxYR9C0GP+IkaluDnM3LplPABvrasgFItMZTHeWbPYSAhhuPQXCKU2xAwHEk/anpOC2jVi49HVSY4eHe/Jd2K5j7ocUrCt5s7WHUS5cZgsfObTOyIiIfnQ80nyK+nuewv7pxbjTJnsQVc/4HSDTO+YsREIEW7b9xdNviusdgG94iJQdrWe49VlEOpJw5klYxBUhxAzXfiSpLsXUtNgbNfBzo5UOAE=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd332a0-29f7-408e-3f56-08d68d2def45
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 18:56:14.5280
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
        t=1549565782; bh=JCoiwADe39obiqGvFYSE8mTBfVPktrJFYk+yL+rn0oY=;
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
        b=Qb/+N1130EwliS6O52G5nv224O6N306T0FEQizdFa9Z8ngRnC/QSWxVK/Inci4m1J
         jzLfQErzaHXYNN6udqR4wpPtZIEOsjlo2V+3c/je7ocDnPf4j3YpqC1pde+IrIOkYT
         /OpsOayZtxM6k6R8XCEU+5fvbiIOem+4MLxSeED8R5y6TSV+9F8ISEEHM9biX+uS7w
         vNxvOmDznWR1L8A9DZakWHrZKnXfxMRPXXUXA2JHiERrtXfS1juwDxOTZAK9clgjiN
         moJxPErlXpcEe6j6uUSxX1o/icE6idU1vdyyZwV3smq77gNsq15enfdetg+SOQpp0T
         3evwdKkXwBsgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMjEw
X2kyY19odyA9IHsgQEAgDQo+ID4gLTk4MCw2ICsxMzAyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCB0ZWdyYV9pMmNfaHdfZmVhdHVyZSB0ZWdyYTIxMF9pMmNfaHcgPSB7DQo+ID4gIAkuaGFzX21z
dF9maWZvID0gZmFsc2UsDQo+ID4gIAkucXVpcmtzID0gJnRlZ3JhX2kyY19xdWlya3MsDQo+ID4g
IAkuc3VwcG9ydHNfYnVzX2NsZWFyID0gdHJ1ZSwNCj4gPiArCS5oYXNfYXBiX2RtYSA9IHRydWUs
DQo+ID4gIH07DQo+DQo+IFQxODYgaXMgbWlzc2VkIGhlcmUuDQoNCkN1cnJlbnRseSB0MTg2IGh3
IGZlYXR1cmUgaXMgbm90IHByZXNlbnQgaW4gZXhpc3RpbmcgbGludXggbmV4dCBhbmQgZGV2aWNl
IHRyZWVzIHVzZSBib3RoIHQxODYgYW5kIHQxMTQgY29tcGF0aWJsZXMsIHNvIHQxMTQgaXMgYmVp
bmcgYXBwbGllcy4NCkJ1dCBkbWFzIGFyZSBub3QgdXNlZCBmb3IgdDE4NiB5ZXQuDQoNClQxODYg
aHcgZmVhdHVyZSBpcyBhZGRlZCBmb3IgZmlyc3QgdGltZSBhcyBwYXJ0IG9mIGludGVyZmFjZSB0
aW1pbmcgYW5kIGl0cyBpbiBwYXRjaCBuZXh0IHRvIHRoaXMgcGF0Y2ggaW4gc2FtZSBzZXJpZXMu
DQpUaGlzIGlzIHRoZSBzYW1lIGZyb20gYmVnaW5uaW5nIG9mIGFsbCB0aGVzZSBzZXJpZXMuDQoN
Cj4NCj4gPiAgDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVncmFfaTJjX2h3X2ZlYXR1cmUg
dGVncmExOTRfaTJjX2h3ID0geyBAQCANCj4gPiAtOTk1LDYgKzEzMTgsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMTk0X2kyY19odyA9IHsNCj4gPiAg
CS5oYXNfbXN0X2ZpZm8gPSB0cnVlLA0KPiA+ICAJLnF1aXJrcyA9ICZ0ZWdyYTE5NF9pMmNfcXVp
cmtzLA0KPiA+ICAJLnN1cHBvcnRzX2J1c19jbGVhciA9IHRydWUsDQo+ID4gKwkuaGFzX2FwYl9k
bWEgPSBmYWxzZSwNCj4gPiAgfTsNCg0K
