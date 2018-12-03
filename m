Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DFFC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B20206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B20206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbeLCLwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:52:47 -0500
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:28357
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbeLCLwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvZ3DwS7cALqdrKqmMLpLBtA6Ay+mEuVuktsYaSld9I=;
 b=daAU/QSJb98Y0VDMFIdFXSAzGM44v9AJtZuTtNOw2eytcCAqMwx3aNuv3HdSsh83Qb6i7VeBkfsTEp+eFs6G1B5YBhVkMYRcPTp9Vbin+GCNGU0a3MBHyokOk1iQTZar+oR9bskvJU+irPRKVUuXL8dHg1tB65gEt5SqohZ+vhI=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1234.namprd12.prod.outlook.com (10.168.227.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 11:51:59 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee%2]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:51:58 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Thomas Meyer <thomas@m3y3r.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: NULL check before some freeing functions is
 not needed.
Thread-Topic: [PATCH] drm/amdgpu: NULL check before some freeing functions is
 not needed.
Thread-Index: AQHUioQy5q3ztyPmSU+8oVc2d0vG6qVs6CAA
Date:   Mon, 3 Dec 2018 11:51:58 +0000
Message-ID: <c049c318-cbaa-dcd9-1954-54aabe0c300f@amd.com>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
 <1543760930051-1905796531-2-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1543760930051-1905796531-2-diffsplit-thomas@m3y3r.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:125b:9a00:a142:2be6:b7be:5a3a]
x-clientproxiedby: AM5PR0102CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::48) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1234;20:m7fc64Z8FORU63/TU6NzWab/g0tUFmewDuwpHf1PcZ2l6m1oHHtew+y35BFwM2G7DAWUpASww4jsILm4knMhdBz4Wuvg7fuUeghiVRumiDPZOff+dHBei0ydJ6APEx7FLSapLtyJCGwU6HtnCAfKtzkx2b1V02WR+R9OnpvkHznFLmep3pL5XXdpDi5ISCwPDTBw26/zriWt1NTCSarZ0ISBCGSpYklf68+Xnn6mfHDpxicyHsx1FZN9seEy+YW+
x-ms-office365-filtering-correlation-id: 11437e61-0e5b-4888-45a9-08d65915bab8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1234;
x-ms-traffictypediagnostic: BN6PR12MB1234:
x-microsoft-antispam-prvs: <BN6PR12MB1234C092C525012FB8938E3D83AE0@BN6PR12MB1234.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1234;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1234;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(366004)(189003)(199004)(316002)(2906002)(478600001)(8936002)(72206003)(81166006)(229853002)(110136005)(81156014)(256004)(58126008)(6436002)(65826007)(8676002)(14454004)(5660300001)(2201001)(65806001)(486006)(36756003)(6486002)(68736007)(31696002)(71190400001)(2501003)(99286004)(476003)(106356001)(53936002)(31686004)(6512007)(105586002)(6116002)(86362001)(71200400001)(25786009)(6246003)(64126003)(76176011)(386003)(186003)(46003)(102836004)(52116002)(6506007)(446003)(11346002)(2616005)(305945005)(7736002)(65956001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1234;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p65NPmQS1am39CoE4ceeThRZDzDkOtCdxDzfscLp/IgGTtHSEr3tu4z8i6PREKM8dxXhe1g1sEJWcVwO4Pm+uFdTdsi2Hm83zX2kt38ij8ZCuC3mdN4SVx6M6nkHhiJFQImVNw2BYSknQPEKXu+Zz4jfK4UBEcMLgjJ9GW84yfNLpDwEFIMTzVXdXw5kGBiauiCrOYZP9m9RxaZXTe4BRts9Mb1E881uEaVTTqMXoxtzJFFpFLKJxqVhSgTav2Myg3NW0gRIXWIPsi+9pm+RlOorU0cDHa13bzWkw7b96lfzNODsKXjq+O66qbYWh+5AB7iCu4NdRZ7oD+ycquqUB6yuhyOuy+D+LFFzdYlmNCU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <94A892FF783DE6429DCCC018DFEED71E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11437e61-0e5b-4888-45a9-08d65915bab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:51:58.8173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDIuMTIuMTggdW0gMjE6NTIgc2NocmllYiBUaG9tYXMgTWV5ZXI6DQo+IE5VTEwgY2hlY2sg
YmVmb3JlIHNvbWUgZnJlZWluZyBmdW5jdGlvbnMgaXMgbm90IG5lZWRlZC4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogVGhvbWFzIE1leWVyIDx0aG9tYXNAbTN5M3IuZGU+DQoNClJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoNCj4gLS0tDQo+DQo+
IGRpZmYgLXUgLXAgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCj4gQEAgLTgxNiw2ICs4MTYsNSBAQCBvdXQ6DQo+
ICAgdm9pZCBhbWRncHVfYWNwaV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAg
IHsNCj4gICAJdW5yZWdpc3Rlcl9hY3BpX25vdGlmaWVyKCZhZGV2LT5hY3BpX25iKTsNCj4gLQlp
ZiAoYWRldi0+YXRpZikNCj4gLQkJa2ZyZWUoYWRldi0+YXRpZik7DQo+ICsJa2ZyZWUoYWRldi0+
YXRpZik7DQo+ICAgfQ0KDQo=
