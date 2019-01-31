Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2E0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268F520B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IUFfspFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfAaUKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:10:08 -0500
Received: from mail-eopbgr800074.outbound.protection.outlook.com ([40.107.80.74]:25376
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbfAaUKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBR6JcxO1M11cZKoCE5P/oBB/y5cW5dcYWVE9e71Zwc=;
 b=IUFfspFuhcleUeDmIvfd6ObVl8CYc52c7Jv51A7HFLJlg1oR46H0gb2+gywJL+x0A7Vv5APdgFBr25Wd+P7xZA/PooMJdCa+CjK07zL/2FD/tFeGq3Fka+AiKdyj2YmISGfCYjylETIZo8l5alQcBtmWDMhap/HHw8S/+VxJlbY=
Received: from DM5PR12MB1707.namprd12.prod.outlook.com (10.175.89.136) by
 DM5PR12MB1275.namprd12.prod.outlook.com (10.168.237.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Thu, 31 Jan 2019 20:10:05 +0000
Received: from DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::fc2b:9e80:ca29:6c95]) by DM5PR12MB1707.namprd12.prod.outlook.com
 ([fe80::fc2b:9e80:ca29:6c95%8]) with mapi id 15.20.1558.025; Thu, 31 Jan 2019
 20:10:05 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
CC:     Mark Nutter <Mark.Nutter@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdkfd: Fix if preprocessor statement above
 kfd_fill_iolink_info_for_cpu
Thread-Topic: [PATCH] drm/amdkfd: Fix if preprocessor statement above
 kfd_fill_iolink_info_for_cpu
Thread-Index: AQHUseP46kMmybWwXk2Z+guJ3T94PaW6ZOOAgA95O4A=
Date:   Thu, 31 Jan 2019 20:10:05 +0000
Message-ID: <7a6ce2e6-620e-ca73-d21d-207c8f9248ce@amd.com>
References: <20190121223516.24340-1-natechancellor@gmail.com>
 <20190121235214.28455-1-natechancellor@gmail.com>
In-Reply-To: <20190121235214.28455-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-clientproxiedby: YTXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::49) To DM5PR12MB1707.namprd12.prod.outlook.com
 (2603:10b6:3:10f::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1275;20:9etrG4hy4AyKqgYdsNUOMnSIxMZafwDxPl9kATChK0oM9OkRzYxbcaXMinTWpJU/mG2JllYnluhTg9iXvDXCEC9Z73p5agnwXZBCR7gqrDrYnikJMMvubI/noh8AoxrATnKwFoqrsq5f304FicHh4R0csmVteidVi0mrRt/r+dYveaoWnfA6ixnwf2h4s0HWeUY4kFzopqsJ9beaFWPeBijHDrcaYfbYn2sLTsYw7cRqII08ekZ1nMIOd3hUz7ly
x-ms-office365-filtering-correlation-id: a88663ed-5e24-4223-1b44-08d687b81710
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1275;
x-ms-traffictypediagnostic: DM5PR12MB1275:
x-microsoft-antispam-prvs: <DM5PR12MB127501B24B48B2D535B4FC7C92910@DM5PR12MB1275.namprd12.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(396003)(136003)(189003)(199004)(97736004)(2906002)(72206003)(478600001)(64126003)(36756003)(3846002)(6116002)(6436002)(6512007)(39060400002)(6246003)(53936002)(6486002)(4326008)(14454004)(6636002)(229853002)(25786009)(31686004)(105586002)(106356001)(316002)(14444005)(102836004)(26005)(110136005)(54906003)(386003)(53546011)(6506007)(186003)(65826007)(256004)(68736007)(486006)(58126008)(7736002)(31696002)(11346002)(446003)(476003)(2616005)(65806001)(76176011)(66066001)(65956001)(8676002)(81156014)(71200400001)(305945005)(99286004)(8936002)(52116002)(81166006)(86362001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1275;H:DM5PR12MB1707.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iPtoMTOov6UhqrdMqIlC3io+pXvPfvXVgdoNWpyakEHE0ms6N7y3oXl886eTw8+C4NENWIeOo/1zTnbNRV6/sXas+JCbQwtUTVwwcW90CA52lQZiI5Ezt6U9ulLkR5IiUbUIFNeHCy3OXZSAiB398Z0XI58YHjj4yWWSSvkRO/rDfS0DvtRqaT68PCNppyIVfIWbuCzXoDKlvk2M+LE6Aio8eQCDBTg8cE7b4XNKFJOMm7xp6Z2/t7KDf3K+KpIYuOa4fEHkWyibH88dIeyBQk+8U4PCki7+KsKXeUBKpu+70w0UX42vmv6QffcQZrdXmj+kJkxIEfsk+qtBOIAp1/FUp6HGdvPyh79IeZPCQavDZFEIHPbVdao2PjkkvWJQ9NKLCuFhGAGNg7goZ6MkMos9YPdG5nezUXDaX7DaJHM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E57B0D49E400540983FFF899DDC3799@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88663ed-5e24-4223-1b44-08d687b81710
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 20:10:04.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91LCBOYXRoYW4uIEkgYXBwbGllZCB5b3VyIHBhdGNoIHRvIGFtZC1zdGFnaW5nLWRy
bS1uZXh0Lg0KDQpTb3JyeSBmb3IgdGhlIGxhdGUgcmVzcG9uc2UuIEknbSBjYXRjaGluZyB1cCB3
aXRoIG15IGVtYWlsIGJhY2tsb2cgYWZ0ZXIgDQphIHZhY2F0aW9uLg0KDQpSZWdhcmRzLA0KIMKg
IEZlbGl4DQoNCk9uIDIwMTktMDEtMjEgNjo1MiBwLm0uLCBOYXRoYW4gQ2hhbmNlbGxvciB3cm90
ZToNCj4gQ2xhbmcgd2FybnM6DQo+DQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Ft
ZGtmZC9rZmRfY3JhdC5jOjg2Njo1OiB3YXJuaW5nOg0KPiAnQ09ORklHX1g4Nl82NCcgaXMgbm90
IGRlZmluZWQsIGV2YWx1YXRlcyB0byAwIFstV3VuZGVmXQ0KPiAjaWYgQ09ORklHX1g4Nl82NA0K
PiAgICAgIF4NCj4gMSB3YXJuaW5nIGdlbmVyYXRlZC4NCj4NCj4gRml4ZXM6IGQxYzIzNGUyY2Qx
MCAoImRybS9hbWRrZmQ6IEFsbG93IGJ1aWxkaW5nIEtGRCBvbiBBUk02NCAodjIpIikNCj4gU2ln
bmVkLW9mZi1ieTogTmF0aGFuIENoYW5jZWxsb3IgPG5hdGVjaGFuY2VsbG9yQGdtYWlsLmNvbT4N
Cj4gLS0tDQo+DQo+IFJlc2VuZGluZyBhcyBJIGZvcmdvdCB0byBhZGQgdGhlIGxpc3RzLi4uDQo+
DQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYyB8IDIgKy0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jDQo+IGluZGV4IDVkODVmZjM0MTM4NS4uMmU3YzQ0
OTU1ZjQzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3Jh
dC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMNCj4gQEAg
LTg2Myw3ICs4NjMsNyBAQCBzdGF0aWMgaW50IGtmZF9maWxsX21lbV9pbmZvX2Zvcl9jcHUoaW50
IG51bWFfbm9kZV9pZCwgaW50ICphdmFpbF9zaXplLA0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+
ICAgDQo+IC0jaWYgQ09ORklHX1g4Nl82NA0KPiArI2lmZGVmIENPTkZJR19YODZfNjQNCj4gICBz
dGF0aWMgaW50IGtmZF9maWxsX2lvbGlua19pbmZvX2Zvcl9jcHUoaW50IG51bWFfbm9kZV9pZCwg
aW50ICphdmFpbF9zaXplLA0KPiAgIAkJCQl1aW50MzJfdCAqbnVtX2VudHJpZXMsDQo+ICAgCQkJ
CXN0cnVjdCBjcmF0X3N1YnR5cGVfaW9saW5rICpzdWJfdHlwZV9oZHIpDQo=
