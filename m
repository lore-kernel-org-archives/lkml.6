Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A2CC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EF020672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HDsnH7J3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EF020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbeLFJdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:33:46 -0500
Received: from mail-eopbgr690086.outbound.protection.outlook.com ([40.107.69.86]:62743
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLFJdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYdPqsdgOMtuafk8KrQrcb2LegAgiVy4xe8vjtIPcsY=;
 b=HDsnH7J3sr0t0oZGaazXcwfxng+LKoowIX357BjwZtTIVNk1y+qElBaOtBTb0Ph7a1J6Rx3S5pV4fVfop5H0U4ewcFQKu/yfl1JpibvwQX/8sinu0UvWLuEhMrqJ3l+ARE1+YXD1l+lls6a1ascUPYt3jUSUMUjxtK8rvYxrG4k=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1636.namprd12.prod.outlook.com (10.172.19.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 09:33:40 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee%2]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 09:33:40 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/ttm: Use pr_debug for all output from
 ttm_bo_evict
Thread-Topic: [PATCH 2/2] drm/ttm: Use pr_debug for all output from
 ttm_bo_evict
Thread-Index: AQHUjLt3lttjoMs2ckWtaOAAhWugUKVxAY8AgABryoCAAAazAA==
Date:   Thu, 6 Dec 2018 09:33:40 +0000
Message-ID: <d0990059-24bb-3f21-8b9d-85761f0be409@amd.com>
References: <20181205165621.5805-1-michel@daenzer.net>
 <20181205165621.5805-2-michel@daenzer.net>
 <b0b57acb-7152-ab1a-855a-3de8c77fa425@amd.com>
 <3198051c-c09d-5bf9-e177-3a90b10b4149@daenzer.net>
In-Reply-To: <3198051c-c09d-5bf9-e177-3a90b10b4149@daenzer.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:125b:9a00:a142:2be6:b7be:5a3a]
x-clientproxiedby: AM5PR0201CA0008.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::18) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1636;20:9HxaEX6h872JB1hTI9gn+XKSIq0JZQBCu4AxYdjgB5MfWkWb/d/sGzjKBSzplVEJsQCHxrItAcEOIDBRCCDSs1feuPPXDiuw4MpDmSkjs5j1udXXvq3P8NQmEylhdlpPnF5o5AnM1HZ2El6pg/gTXQ0RPv5REra9ngAO6uoFpl11eNmDw1tKWt0r3M3BkSPd3AuG6Rg+TmdhAxqECAlfYyULzGNRwjS5T6G1c4clNgAvX+t2xlU0zRqf4j3riFq8
x-ms-office365-filtering-correlation-id: 61bdcdad-4364-435a-8469-08d65b5de7a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1636;
x-ms-traffictypediagnostic: BN6PR12MB1636:
x-microsoft-antispam-prvs: <BN6PR12MB1636E03B4B2342C8B237F1C883A90@BN6PR12MB1636.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1636;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1636;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(396003)(346002)(199004)(189003)(65806001)(53546011)(102836004)(65956001)(6506007)(386003)(71200400001)(71190400001)(6436002)(2906002)(54906003)(58126008)(110136005)(53936002)(14454004)(65826007)(14444005)(256004)(8676002)(7736002)(86362001)(305945005)(31696002)(81166006)(81156014)(478600001)(64126003)(25786009)(66574009)(5660300001)(8936002)(2616005)(105586002)(97736004)(486006)(4326008)(46003)(99286004)(6486002)(72206003)(106356001)(6246003)(476003)(68736007)(31686004)(316002)(186003)(11346002)(93886005)(52116002)(76176011)(229853002)(446003)(6512007)(36756003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1636;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q4S+4m8F7EWZ19o8W9FqOZMSjQZ/cuCtBEYoEXK+ovgnU0soVZE0Y47QeYBaNB4g/z7DfjG0hUcnbNTUHTj3PhcatkADr2fuO2Jhsr7u0DoQRsb7sawkyIvfZ7lkQfbBheVCyP8qgSsGGGIP4TrKjNB3CF+Tpqc/wUr9IrSvvgmYT+lemh8t9sfq74HxETYmnFasj/GjCAttXkJ//OHvxN7PsZ3b6vwo8nRWc97TC1LtVpmNiLPKhbMpXO3RO05ftL3nZLesd9FzRgSzoUc6FKmE9839y3GquifRe8vtEzxFMymuvuZYk+VyJEw5V++7MbpoFTC4oM/vB84IIvkALaJmGc10vRqIh1TkpfijllQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4253209A8EE08A43A69DE6A134D9455C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bdcdad-4364-435a-8469-08d65b5de7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 09:33:40.5829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDYuMTIuMTggdW0gMTA6MDkgc2NocmllYiBNaWNoZWwgRMOkbnplcjoNCj4gT24gMjAxOC0x
Mi0wNiAzOjQzIGEubS4sIFpoYW5nLCBKZXJyeShKdW53ZWkpIHdyb3RlOg0KPj4gT24gMTIvNi8x
OCAxMjo1NiBBTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6DQo+Pj4gRnJvbTogTWljaGVsIETDpG56
ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+DQo+Pj4NCj4+PiBBbGwgdGhlIG91dHB1dCBpcyBy
ZWxhdGVkLCBzbyBpdCBzaG91bGQgYWxsIGJlIHByaW50ZWQgdGhlIHNhbWUgd2F5Lg0KPj4+IFNv
bWUgb2YgaXQgd2FzIHVzaW5nIHByX2RlYnVnLCBidXQgc29tZSBvZiBpdCBhcHBlYXJlZCBpbiBk
bWVzZyBieQ0KPj4+IGRlZmF1bHQuIFRoZSBjYWxsZXIgc2hvdWxkIGhhbmRsZSBmYWlsdXJlLCBz
byB0aGVyZSdzIG5vIG5lZWQgdG8gc3BhbQ0KPj4+IGRtZXNnIHdpdGggcG90ZW50aWFsbHkgcXVp
dGUgYSBsb3Qgb2Ygb3V0cHV0IGJ5IGRlZmF1bHQuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBN
aWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4NCj4+IFNvdW5kcyByZWFzb25h
YmxlLCBidXQgcGVyc29uYWxseSBwcmVmZXIgdG8gc2hvdyBlcnJvciB3aGVuIHNvbWUNCj4+IHZp
dGFsIGluY2lkZW50IGhhcHBlbnMsIGUuZy4gbm8gbWVtb3J5IG9uIGV2aWN0aW9uLg0KPiBUaGUg
YW1kZ3B1IGRyaXZlciBzdGlsbCBwcmludHMgdGhlc2UgaW4gdGhhdCBjYXNlOg0KPg0KPiAgIFtk
cm06YW1kZ3B1X2NzX2lvY3RsIFthbWRncHVdXSAqRVJST1IqIGFtZGdwdV9jc19saXN0X3ZhbGlk
YXRlKHZhbGlkYXRlZCkgZmFpbGVkLg0KPiAgIFtkcm06YW1kZ3B1X2NzX2lvY3RsIFthbWRncHVd
XSAqRVJST1IqIE5vdCBlbm91Z2ggbWVtb3J5IGZvciBjb21tYW5kIHN1Ym1pc3Npb24hDQo+DQo+
IFRoYXQncyBwbGVudHkgYXMgZmFyIGFzIEknbSBjb25jZXJuZWQuIDopDQoNClllYWgsIGJ1dCBp
biB0aGlzIGNhc2UgSSB3b3VsZCByYXRoZXIgbWFrZSB0aGUgYW1kZ3B1IG1lc3NhZ2VzIGRlYnVn
IA0KbGV2ZWwgYW5kIGxlYXZlIHRoZSBUVE0gbWVhc3NhZ2VzIG9uIGVycm9yIGxldmVsLg0KDQpD
aHJpc3RpYW4uDQo=
