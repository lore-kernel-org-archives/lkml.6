Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E9BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB572087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="JwgqIp1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfB0M0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:26:14 -0500
Received: from mail-eopbgr690076.outbound.protection.outlook.com ([40.107.69.76]:29183
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbfB0M0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg8O0MUinWGM5Yo+WbhK6+VpBQ5qkmU3btHL0087GNs=;
 b=JwgqIp1/gB1Hiuwk/UHiHrh1pVJ5nWl/RkjQTZRhPzenUpG87q5mASKjiOkW89pAnloQW3vnx+SAd426ylCFga0g7+t9OL9plj01z1VUXRvnAlpBoQ/5OZvagYsaUnwKq+vmEfxaRwjpDuOG9dbWBO7uykpCcOHWv6utFifTfYM=
Received: from BL0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:2d::17)
 by DM6PR03MB3756.namprd03.prod.outlook.com (2603:10b6:5:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.16; Wed, 27 Feb
 2019 12:26:10 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BL0PR03CA0004.outlook.office365.com
 (2603:10b6:208:2d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Wed, 27 Feb 2019 12:26:09 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Wed, 27 Feb 2019 12:26:09 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x1RCQ8ew009648
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 27 Feb 2019 04:26:08 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Wed, 27 Feb 2019 07:26:07 -0500
From:   "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "bhole_prashant_q7@lab.ntt.co.jp" <bhole_prashant_q7@lab.ntt.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] lib/scatterlist: introduce sg_nents_for_dma() helper
Thread-Topic: [PATCH] lib/scatterlist: introduce sg_nents_for_dma() helper
Thread-Index: AQHUznmR5TuwCY0+1U2y4bcOxmYc/aXzuTmAgAAAMICAACytgA==
Date:   Wed, 27 Feb 2019 12:26:07 +0000
Message-ID: <26f1c0d1a7d98a6a41301d58e53bd9abc1d2f5c9.camel@analog.com>
References: <20190227085050.30000-1-alexandru.ardelean@analog.com>
         <CAHp75VfsLJq1ei5U-jkgFc-zj-T6KCdTy8+Je+GnjB=KN4BS5w@mail.gmail.com>
         <CAHp75VdgwM_ybfymh28iqxu2qOfzZo79VOF+XE+brj70Aji6YQ@mail.gmail.com>
In-Reply-To: <CAHp75VdgwM_ybfymh28iqxu2qOfzZo79VOF+XE+brj70Aji6YQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E5419B480DB364C91FF0E7D77CFE0EE@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(189003)(199004)(4326008)(478600001)(966005)(72206003)(36756003)(6246003)(50466002)(47776003)(106002)(14454004)(6306002)(126002)(2501003)(476003)(2616005)(316002)(86362001)(486006)(446003)(110136005)(6116002)(3846002)(54906003)(11346002)(426003)(336012)(436003)(229853002)(106466001)(26005)(2906002)(246002)(8676002)(5660300002)(356004)(102836004)(118296001)(8936002)(186003)(7636002)(53546011)(2486003)(23676004)(305945005)(7696005)(7736002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3756;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1b9c109-6328-48f7-4359-08d69caec107
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:DM6PR03MB3756;
X-MS-TrafficTypeDiagnostic: DM6PR03MB3756:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Exchange-Diagnostics: 1;DM6PR03MB3756;20:K7O5VlgJZ6zTBhb4lwzJOGjfiSaCwVjIED5Y80mvMGnN8aMHONkmjfc96ppmnhNe3cjGFrjNLvC+JpAdLgZfeqSMS8TdcmtcBbwvb5kfZ/J/k+YsYTzNf8mQzRNTO1GTzthPXYYAkdKszLdavB7iWylzzgV36fE7Cnb1JAmi+Ku/UhsoxmMPdwfn9y+6S5zIgr4ZT62V7DAs8BxM8N6jznk8hoI/KowUi0DiKjV5U4/0NAz+QLb3kSTlUbKQcLZGK7rdn2FoHcSRZQePH9ZWEqBs+oXBf3D3jt/eZ/9XcPL4Og7Kyl6CUPGZr9kXed4UW370avcV4wMHUnGyonO85WMympLxreDonEdERGGDoRk0Z/2jSFFGnz13Yv3kFT81NNRD9COTFY6zgfWWUD7c9/gItR5QX5NievNsxob4aTItfLfQoknPbRBxSUjaKl5U6/KES5vjCBvo9fV+Vq9BlbXLKRLA6FrNNUHpeNexBoCO7+7Zedkqqs6vifpJ9rVr
X-Microsoft-Antispam-PRVS: <DM6PR03MB3756269EA7CDB156901D2EFE95740@DM6PR03MB3756.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0961DF5286
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAzTUIzNzU2OzIzOlExTDlqbGltWmdkczFTeFEzTnNNS01yUlNq?=
 =?utf-8?B?ZmJzTS9OYmV0Zi9CNEtpOERpNzlaNjN0d0VEZnZyR1hFTEwwV1dRUGRiU3lN?=
 =?utf-8?B?V1M1cTJ1OW0zaEtaMS9wNjFEU3VQcGZ5T1dKYTZNQlMzNUE2elZKV2Ivb1Nh?=
 =?utf-8?B?L2VTYk1ZZjJGdzRUWFljRDg5VS94UlZhcERQSUJCUkRBTnNYOUlWMEt6U2d1?=
 =?utf-8?B?MXkxQ3VUOS9LclFXL05hdC9KMnBOVG5xdm5kZXR2dXFnNWpZL0hZV2VKMTJx?=
 =?utf-8?B?cmlYNm5LUkluejFCLzIzZ1Z5TUdPNEdMc0lOcmNsRWNQYTdKckgreUZhRkFY?=
 =?utf-8?B?K1pRcVpmSndFUElZRW9oYVRoa2RkamxwWG9nUS9JdU4zNUl2Wlg3RVp6aTIy?=
 =?utf-8?B?bmZDeHJRRUZNM21rMC9ReEJPVHpxaWIxemxTZVlaVmxRUEs4b0hjRDdMMm9u?=
 =?utf-8?B?SnNEdWVIQXR5M011U1FnYjhOZ1BaVzRhR0V6V0Q1Vi9TZDRKYzRheFpyZkUx?=
 =?utf-8?B?RWdUeW92RHc5VGNXTXZPTk5TQ0NLVitlMGZSVm4ra1VOVFZDODV3djhHeVo4?=
 =?utf-8?B?UzZoVE56elQzZmdlVjNIYk5kNk4vaWR4U21mL2N4a2g1Z0YyM1ZBRWJrTHhI?=
 =?utf-8?B?Z0IveUVEQ0o1WWVxckNCNU16cENCb09Id29TOFlYQW9FNGVmZTlKZmR0aFF2?=
 =?utf-8?B?cDkwemJIWHR4UEsvRVFzaGtJRGVZV1hLbWdhKytucTZ1ck1RRjQyckVLdXc3?=
 =?utf-8?B?WTNKWjgzbVI2SEFSdHI5dGl3TTJXdkt5aWoyeW50dXBTTlVHanptV3JBSitG?=
 =?utf-8?B?dFQxY3FxQ1ZJOEw4dlRTaGRTMlhQalpsTXVHRlF6eDhqVDZNRkp1dWFxMHVU?=
 =?utf-8?B?UHdQcHNHdHp1bEZJM293L21nbUN4bVVaOTBsRldGbnB4MzR0YzRtRWhzWmpt?=
 =?utf-8?B?VE1LZHQ0VktvMUV0Um9VYjlUZ2RXY3FYQXlmYysxLzY2Sm5wNGpqREwzQk9k?=
 =?utf-8?B?eWRSR3NUdVJ4NncxSzl3dHVCTUFKSSt1S0Vrek5GNU5nRnk1eTlwQlZXYkhu?=
 =?utf-8?B?MVI2bEdMOTNjekRxZ3hWVkxFL3JPdzFtMEtzNEQySVp0QWRjQlNhU3RCZ0FE?=
 =?utf-8?B?cjh1a2NiU0hacnRuTmlnWHU5VlBvMHlvYXVSYUhGbmo4ZVFQODh1Ry9LL2ZY?=
 =?utf-8?B?R2FMV0VUeVZDc1RwVjRaRU1CeEFDMmVpYlhGc21CbGpGTFpVMVY2WlZjN2pX?=
 =?utf-8?B?ZU5YbC8wTk9iY0NZa2E5VnpVT2ZXWUhoV2Y4UVdlQVF1Z3BLWFdCdVZNRFVz?=
 =?utf-8?B?SWlKM3B5L01WTmw3MDBXV05CaG02YkpPcWl5QmlkVkxRUDg4Y284RWlYSGRE?=
 =?utf-8?B?NUd5cU5EOUhWTkdzNFl2YXJwREM1UVF3NThuZTF1MVdPMXpncG1IQ2VIejFV?=
 =?utf-8?B?RUcwNlJUSjZkRlVqdHBMM0x6WGNlNkM1TUtzYW9QOHNFb1U1MDRRekw0b2li?=
 =?utf-8?B?OTgzWkp3dy8vbzNzUXFOUGp2enVidUo4Qm51RTRac2tSMVJURU9YSTQrazVx?=
 =?utf-8?Q?vsDyoz6Rr955j4GfnFDW09CeJ2y7vcTusFLWc31UVWP0=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Y4utjd0bJpd6xoRz5s4UzipbXHYztBfSPoAYZ+q+4wvRyi2l9b9+aGJrHAhpNdTWxV3izDGHpig6R3KEIMneIVCt3aBHjKqwMwwhhY+VIUg3y8ZH2iKZOQzOlfwLfp+K+MGfE/9p8dQVknMdNKEBzlAGFf1eMPNL16upJH0VuDowWSmjKwIJTNPeBU9R0RdKHnxk1ktE2zNSzM9PncdfAcaKA8DDTvFxvDQT8l5fEKj9WqbDNs0lmE5W2DOS9t2Dyz43/WJxfz9LvnvChpZZDpLakMHfS8s+9ruSez7Aq+BRm7Zsiw6eLoQvutz5Ol6zcxGyQXgn745cNlY3M9waLOeqa2DgxuXuhbXdyE2xneU65UadHNZ/dCzK6RK7fcmE4NwAIs+iyfzXHClSbP/EqvtNxqPhknx1SJJujBRBNuo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2019 12:26:09.1936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b9c109-6328-48f7-4359-08d69caec107
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAyLTI3IGF0IDExOjQ2ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiArQ2MgVmlub2QNCj4gDQo+IE9uIFdlZCwgRmViIDI3
LCAyMDE5IGF0IDExOjQ1IEFNIEFuZHkgU2hldmNoZW5rbw0KPiA8YW5keS5zaGV2Y2hlbmtvQGdt
YWlsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gV2VkLCBGZWIgMjcsIDIwMTkgYXQgMTA6NTEg
QU0gQWxleGFuZHJ1IEFyZGVsZWFuDQo+ID4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29t
PiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZj
aGVua29AZ21haWwuY29tPg0KPiA+ID4gDQo+ID4gPiBTb21ldGltZXMgdGhlIHVzZXIgbmVlZHMg
dG8gc3BsaXQgZWFjaCBlbnRyeSBvbiB0aGUgbWFwcGVkIHNjYXR0ZXINCj4gPiA+IGxpc3QNCj4g
PiA+IGR1ZSB0byBETUEgbGVuZ3RoIGNvbnN0cmFpbnMuIFRoaXMgaGVscGVyIHJldHVybnMgYSBu
dW1iZXIgb2YNCj4gPiA+IGVudGl0aWVzDQo+ID4gPiBhc3N1bWluZyB0aGF0IGVhY2ggb2YgdGhl
bSBpcyBub3QgYmlnZ2VyIHRoYW4gc3VwcGxpZWQgbWF4aW11bQ0KPiA+ID4gbGVuZ3RoLg0KPiA+
ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5r
b0BnbWFpbC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFs
ZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0KPiA+IA0KPiA+IEhtbS4uLiBVc3VhbGx5IHdl
IGRvbid0IGFjY2VwdCBnZW5lcmljIEFQSSB3aXRob3V0IHVzZXJzLg0KPiA+IERvIHlvdSBoYXZl
IGFueSB1c2UgY2FzZSBpbiBtaW5kPw0KDQpZZXA6IHRoaXMgb25lOg0KaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wYXRjaC8xMDgxNDUyNy8NCg0KQnV0LCBJIGNhbiByZXdvcmsgdGhpcyBw
YXRjaCB0byB3b3JrIHdpdGhvdXQgdGhlIGhlbHBlci4NCg0KPiA+IA0KPiA+ID4gUGF0Y2ggd2Fz
IHNlbnQgaW4gMjAxNiBpbml0aWFsbHkgdG8gdGhlIERNQSBlbmdpbmUgc3ViLXN5c3RlbS4NCj4g
PiA+IExpbms6DQo+ID4gPiAgIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvOTM4
OTgyMS8NCj4gPiA+IFRoaXMgd2FzIHBhcnQgb2YgYSBsYXJnZXIgc2VyaWVzOg0KPiA+ID4gICAN
Cj4gPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1kbWFlbmdp
bmUvbGlzdC8/cT1zZ19uZW50c19mb3JfZG1hJmFyY2hpdmU9Ym90aCZzZXJpZXM9JnN1Ym1pdHRl
cj0mZGVsZWdhdGU9JnN0YXRlPSoNCj4gPiA+IA0KPiA+ID4gSSdtIG5vdCBzdXJlIGlmIHRoaXMg
aXMgc3VwcG9zZWQgdG8gZ28gaW50byBETUFFbmdpbmUgb3INCj4gPiA+IGxpYi9zY2F0dGVybGlz
dC4NCj4gPiA+IEl0IGRvZXNuJ3QgbG9vayBsaWtlIGxpYi9zY2F0dGVybGlzdCBpcyBtYW5hZ2Vk
IGJ5IERNQUVuZ2luZSwgc28gKGJ5DQo+ID4gPiB1c2luZw0KPiA+ID4gdGhlIGBnZXRfbWFpbnRh
aW5lcnMucGxgIHNjcmlwdCkgSSdtIHNlbmRpbmcgdGhpcyBwYXRjaCB0byB0aGlzIGdyb3VwDQo+
ID4gPiBvZg0KPiA+ID4gcGFydGllcy4NCj4gPiANCj4gPiBUaGUgcHJvYmxlbSB0aGUgcGF0Y2gg
dHJpZWQgdG8gc29sdmUgaXMgbXVjaCBkZWVwZXIgYW5kIGNvcnJlY3QNCj4gPiBzb2x1dGlvbiBz
aG91bGQgYmUgbW9yZSBnZW5lcmljLCBpLmUuDQo+ID4gZWFjaCBjaGFubmVsIHNob3VsZCBwcm92
aWRlIGEgc2V0IG9mIHBhcmFtZXRlcnMsIHN1Y2ggYXMgRE1BIHNlZ21lbnQNCj4gPiBzaXplLCB0
byB0aGUgdXNlcnMgKHZpYSBETUEgZW5naW5lIEFQSSkgYW5kIHVzZXJzIHNob3VsZCBwcmVwYXJl
IHRoZQ0KPiA+IFNHIGxpc3QgYWNjb3JkaW5nIHRvIHRoZSBsaW1pdHMgb2YgdGhlIGNoYW5uZWwu
DQo+ID4gSW4gdGhhdCBjYXNlIHdlIGRvbid0IG5lZWQgdG8gcmUtc3BsaXQvcmUtYWxsb2NhdGUg
Z2l2ZW4gU0cgbGlzdCBhdA0KPiA+IGFsbCwgd2hpY2ggd291bGQgc2ltcGxpZnkgRE1BIHNsYXZl
IGRyaXZlcnMgYW5kIHRoZWlyIHVzZXJzLg0KPiA+IA0KDQpJIGRvbid0IHRoaW5rIEkgbWFuYWdl
ZCB0byBmb2xsb3cgW29yIGZpbmRdIHRoZSBmdWxsIGxlbmd0aCBvZiB0aGF0DQpkaXNjdXNzaW9u
LiBPciwgdGhlIGNvbmNsdXNpb24gd2Fzbid0IHRoYXQgb2J2aW91cyB0byBtZSwgZnJvbSB3aGF0
IEkNCmZvdW5kLg0KSSBhc3N1bWVkIHRoaXMgbWF5IGhhdmUgYmVlbiBkcm9wcGVkL2ZvcmdvdHRl
bi4NCg0KSW4gYW55IGNhc2UsIEkgYW0gZmluZSB3aXRoIGp1c3QgcmV3b3JraW5nLg0KDQo+ID4g
V2UgZGlzY3Vzc2VkIHRoaXMgdG9waWMgYmFjayBpbiAyMDE2IHdpdGggVmlub2Qgb24gTFBDLCBi
dXQgc2VlbXMgaXQncw0KPiA+IG5vdCBjcml0aWNhbCB0byBzb2x2ZS4gTXkgY2FzZSBpcyB0byBp
bXByb3ZlIERNQSBwZXJmb3JtYW5jZSBmb3IgODI1MA0KPiA+IFVBUlQuDQo+ID4gDQo+ID4gLS0N
Cj4gPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gPiBBbmR5IFNoZXZjaGVua28NCj4gDQo+IA0KPiAN
Cj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0K
