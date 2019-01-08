Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B80AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7262087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="R38RR/Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfAHKz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:55:29 -0500
Received: from mail-eopbgr770040.outbound.protection.outlook.com ([40.107.77.40]:49120
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfAHKz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM8E0u5VtpiTQUW9Y/jLl7Em9BRBz+2OXEqovAmk+o8=;
 b=R38RR/JfUOeXUAPqNsuB9ZRN/Z4MjEefd7ciON7QHzdzbh/2U33Qt+TdZfkR/74Xaf0p6ccx8cpS2NsIYMqD5xUnfN9hEnCSLJHjj2sp8mC8mRvd06uDa4C5MOP1OKFp2dxu82V+33U1kHBJVwGpxFNvzP7vX5hDiinQjKBxC24=
Received: from BYAPR05MB5592.namprd05.prod.outlook.com (20.177.186.153) by
 BYAPR05MB3925.namprd05.prod.outlook.com (52.135.195.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.2; Tue, 8 Jan 2019 10:55:17 +0000
Received: from BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::4a1:2561:2487:5919]) by BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::4a1:2561:2487:5919%4]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 10:55:17 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 2/4] drm/vmwgfx: remove CONFIG_INTEL_IOMMU ifdefs
Thread-Topic: [PATCH 2/4] drm/vmwgfx: remove CONFIG_INTEL_IOMMU ifdefs
Thread-Index: AQHUpMzbNXAv44HEJkWekrP09zgtYaWlN6oA
Date:   Tue, 8 Jan 2019 10:55:16 +0000
Message-ID: <91c7f07e5a8e7ad98e259c430934d92a58a558b6.camel@vmware.com>
References: <20190105080108.14837-1-hch@lst.de>
         <20190105080108.14837-3-hch@lst.de>
In-Reply-To: <20190105080108.14837-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB3925;20:+NlY3v2yU5MykROu/3ZQwQyelwQwQ33NR/i8mxUGcMDDkEJI1CAj0Hi7/0CGJQd5Uukyon/Kgg9D9ra5UoVVFcP6pykweFasVOboMfzd8ElVGCO78DZgQNHECjwq6Kk0KN81Edjt5wqyaWH+4aB9Q1PG6zdkKIVV7Uhjh2WNCh0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 574b755e-d47e-4dba-1c27-08d67557c65f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB3925;
x-ms-traffictypediagnostic: BYAPR05MB3925:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB39254D2711EF2839661E3ABEA18A0@BYAPR05MB3925.namprd05.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(189003)(199004)(6512007)(118296001)(2906002)(53936002)(305945005)(6246003)(4326008)(25786009)(81156014)(1730700003)(8936002)(7736002)(8676002)(81166006)(97736004)(2501003)(54906003)(5660300001)(316002)(68736007)(478600001)(14454004)(486006)(11346002)(446003)(2616005)(476003)(256004)(6506007)(76176011)(99286004)(26005)(186003)(102836004)(229853002)(6486002)(36756003)(6916009)(71190400001)(71200400001)(106356001)(105586002)(6436002)(2351001)(3846002)(86362001)(66066001)(5640700003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3925;H:BYAPR05MB5592.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LBXD9hmwEa7E3Q4F60a5UwQuFEgz45jh3YVmmzCudL3/O8h2KiR3xCq701zafkv5w2vUPZAyV5tpnsdVkTvH4pVzNp/XbEK5mCGLrV7nJ7DXybtw0BdgUEOQ0VmlplHZIZJCmc5aX6nz1wHusmdR5xs3BpH40N3slUuwI3nsePZ0+lWvNf9gCB3yP4TvpKpVUXxloBueRu+zmWzs5PPS8so7JIuGIhr02/gH1N/n0QKLUHv1+RD/96EQKcZTX4gn1TE5VpBEbT/0HHAGy0kTVJgCrz03X92y6c/d60PHo5GUVjSepM1s0CBKm255fAYH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E57E7F98A7364A49A8EFB3DF1A760E2A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574b755e-d47e-4dba-1c27-08d67557c65f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 10:55:16.8228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCg0KT24gU2F0LCAyMDE5LTAxLTA1IGF0IDA5OjAxICswMTAwLCBDaHJpc3RvcGggSGVs
bHdpZyB3cm90ZToNCi4uLg0KDQo+IGludGVsX2lvbW11X2VuYWJsZWQgaXMgZGVmaW5lZCBhcyBh
bHdheXMgZmFsc2UgZm9yDQo+ICFDT05GSUdfSU5URUxfSU9NTVUsDQo+IHNvIHJlbW92ZSB0aGUg
aWZkZWZzIGFyb3VuZCBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPg0KPiAtLS0NCj4gDQo+IC0jaWYgIWRlZmluZWQoQ09ORklHX1NXSU9UTEIp
ICYmICFkZWZpbmVkKENPTkZJR19JTlRFTF9JT01NVSkNCj4gLQkvKg0KPiAtCSAqIE5vIGNvaGVy
ZW50IHBhZ2UgcG9vbA0KPiAtCSAqLw0KPiAtCWlmIChkZXZfcHJpdi0+bWFwX21vZGUgPT0gdm13
X2RtYV9hbGxvY19jb2hlcmVudCkNCj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+IC0jZW5kaWYNCj4g
DQoNCkFjdHVhbGx5IHRoaXMgaHVuayBpcyBpbmNvcnJlY3QsIGl0IHRyaWVzIHRvIGRldGVybWlu
ZSB3aGV0aGVyIHRoZSBUVE0NCnN1YnN5c3RlbSBtYWludGFpbnMgYSBjb2hlcmVudCBwYWdlIHBv
b2wgb3Igbm90LiBJZiBub3QsIHdlIGNhbid0IHVzZQ0Kdm13X2RtYV9hbGxvY19jb2hlcmVudC4N
Cg0KL1Rob21hcw0KDQo=
