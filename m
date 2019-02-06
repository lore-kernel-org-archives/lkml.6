Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD44C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF911217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TfJ9vlNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfBFO3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:29:23 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:25600 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfBFO3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:29:22 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5aef3d0001>; Wed, 06 Feb 2019 22:29:17 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 06:29:17 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 06 Feb 2019 06:29:17 -0800
Received: from DRBGMAIL102.nvidia.com (10.18.16.21) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 14:29:16 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by DRBGMAIL102.nvidia.com
 (10.18.16.21) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 14:29:15 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.59) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 14:29:15 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3286.namprd12.prod.outlook.com (20.179.93.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 14:29:12 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 14:29:12 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvaSihB2vPasFV02HZ/JY13Td7aXSqkqAgAAUt4CAAAEfAIAAAXOAgAAAhsCAAAYqgIAAADAAgAACQDCAAAL7gIAAA0OAgAAA7+CAAAJMgIAAAK1A
Date:   Wed, 6 Feb 2019 14:29:12 +0000
Message-ID: <BYAPR12MB33988A49F8831BD8CAB575E5C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <20190206130909.GJ21676@ulmo> <20190206131310.GK21676@ulmo>
 <d16dd60a-bfb4-75e8-3d19-97b565c815b0@gmail.com>
 <BYAPR12MB33983A0E93B17808DECFD0F2C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <6edef92d-66a7-0f70-e59e-7381b82516eb@gmail.com>
 <BYAPR12MB339826EB972C5DB7957E8A82C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33989329D0E0C0049F1DEA6EC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190206140141.GO21676@ulmo>
 <9b4bfee0-f3f2-bae7-5010-97a86bb5e03f@gmail.com>
 <BYAPR12MB3398D7685B5A7462161F9578C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <649cdfb4-214e-bf01-348d-f950628ecf9b@gmail.com>
In-Reply-To: <649cdfb4-214e-bf01-348d-f950628ecf9b@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3286;6:DLTtCOO+zyb58sVaJVGefQfFvK00W8uxPAwh+fxxtchLt4ih78tAJlIRPBpxC1kjLa4GA+05nfBqtL364zTAh5WxI/CV5BR62Nhj9NNl6GVyeS4YFrV/3Oe0HhdZjhpS62Uer2+Sp0nD+8WRwpSebF2yLFI1jxzVDwUqJzbjQc4K9lA/e5o8AjfP61eibw5uDojqm1IjrGFAAb7AAhTfWTfqi/sk2QQ558hkPSyXvVz7zWecVdkgMWJegDevN3+D75PPMLKdBNOOEHOotj8S7fZ0SIzEn+rvrd5Ede5JhkrI23+we2SKjgu7ISPnRNQjNi+vMWuQIdsW7ZEwaTCwLjKfUWA3MtwfxwIIP0w400m27Uj7oTpCGI5exE5a0SsGqEskLuChyVKub31zSDkXc7URAI/I5lIgofIHEq92j7Hp1JDnEaf8Nfv3fyYze3Hem1rxrM4UBLXjmwBNaPpISA==;5:u6OBfQN2BIMqNF4Vm19hqkMVO9sJlm1c44tmfG7r8EEPpiI/fOpQpRcdY4XW0mOskqzVWiBCZmQh7teqgcPlQk+HQ5pa6+tqrnBc4Dfi1qEO7IyX3Nusmjp+Ub6C+/DQuOFE2xpKGXZWshbM3I4T3gRpbNrta5aFptWfzO90m5Z5jWvRqPEVifBTtjNPdqF319Ux/A+rZntOKiwsUCyRZQ==;7:Iz5twI4dbhs3nKUo2jeyj1ES1pS3uAJZeJIwJMZbosA1tRHmp4cvexwHnePiPzJskQSdK4v7sfgRYNJg39/w6AFbnlCtm1fN3KEpKbQGCdXLvvOH/wpy0h1NeQwbZzxZ3JpnlTgTnRoU4va3ujTsgA==
x-ms-office365-filtering-correlation-id: afd1aea7-04d1-4e30-3265-08d68c3f7700
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3286;
x-ms-traffictypediagnostic: BYAPR12MB3286:
x-microsoft-antispam-prvs: <BYAPR12MB32863D8103191773BBD35980C26F0@BYAPR12MB3286.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(81166006)(81156014)(8936002)(106356001)(74316002)(25786009)(7696005)(76176011)(9686003)(54906003)(71190400001)(476003)(2906002)(86362001)(71200400001)(53376002)(102836004)(99286004)(6246003)(4326008)(55016002)(6506007)(14454004)(105586002)(966005)(6306002)(446003)(11346002)(68736007)(33656002)(6436002)(110136005)(316002)(256004)(478600001)(305945005)(3846002)(26005)(6116002)(14444005)(97736004)(486006)(53936002)(66066001)(186003)(93886005)(8676002)(229853002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3286;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6UFpuokzsgtHkzaClUEq8de16Kp8YkHRSvcAzsAD0TW5mi5EB6la9ek7As3eRZW9u/j2mm8ue1RIsLjEf2NXqKghYOkoIf1ih6w8EKu64S/alevEQDn0BD6ZjLXYooxWF3VRCFbXjnRioQv3jqxqaI+Ud5Navua4zapS+EsJI+9cCt9+72dS2SoeOG6XR7JO/+dpanOOe2pJ7X/rV5W95mqWfAaF9t1tTUSGI222hHf7KQs3yfmtR7VrbNprTesECzEbNnUemlUsN2v9VW/9lkdlg2z9Up1MYmtjhEakaOnSp1b/oSTR/88Ae3VOJoRubkZQwFYAMyNjh/OHV676KETcGFXSzrhwgBa0aHSnMlQyA9szecPVVVtWCp1mZLEm/jOBxpFE3cUnA5fsKKx5uhglCzuKZU/Rf+NLvNmpGTU=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: afd1aea7-04d1-4e30-3265-08d68c3f7700
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 14:29:12.5733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3286
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549463357; bh=4QWIh6S5I3pxd/AQM4L7RSIQuog9O4I+L1sTnW7u5es=;
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
        b=TfJ9vlNdI09ezc4oWUMmm1sbgAVJ2wxsZihDrNuxdCEtVohdzZ+pIDEFjQkSR4oFM
         kAZMoUfgER028zAqrS77aIveOgCYsEApVaor6JZ8H0exidAcDUYuiSXKDYiNxc2pEf
         h8PsaqjKNu59n+y2BIKpXrf/WHa+K1wiH9F8WTsLf+WGS73xCRdVOtGo3SifhLpYfi
         WfHx6P0M6OfmSE+Ci8PpJSi7957ygYksAiLHdHlDUGXQadrSnbMbP/WJMemnaeV/z9
         qfSd1wzY5aK6vU/kJ8otYYWrFio5JI9T12PSAb39je4/5kjJpb4rBLhXMoK32OoAH0
         6eq9XRuKxn/CQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4+Pj4gWWVzIHBsZWFzZSBwb3N0IGZ1bGwgbG9nIG9mIFBJTyBvbmx5IGFuZCBETUEgb25s
eSBBbHNvLCBpbiBhYm92ZSANCj4gPj4+PiBsb2csIGxvdHMgb2YgRE1BIHRyYW5zZmVyIHdlbnQg
dGhydSBmaW5lIGV4Y2VwdCB0aGlzIG9uZSB0cmFuc2ZlciANCj4gPj4+PiB3aGVyZSBETUEgdGlt
ZWQgb3V0Lg0KPiA+Pj4+IERNQSBjb21wbGV0aW9uIGRvZXNudCBoYXBwZW4gb24gRE1BIHN1Ym1p
dCBkdXJpbmcgdGhpcyBwYXJ0aWN1bGFyIA0KPiA+Pj4+IHRyYW5zYWN0aW9uIHRpbWVmcmFtZSBm
b3Igc29tZSByZWFzb24uDQo+ID4+Pg0KPiA+Pj4gRG1pdHJ5LCBjYW4geW91IHByb3ZpZGUgc29t
ZSBiYWNrZ3JvdW5kIGluZm9ybWF0aW9uIG9uIHRoZSBzZXR1cCANCj4gPj4+IHRoYXQgeW91J3Jl
IHVzaW5nPyBJIHZhZ3VlbHkgcmVtZW1iZXIgc29tZXRoaW5nIGFib3V0IGkyY0A3MDAwZDAwMCAN
Cj4gPj4+IGJlaW5nIHNwZWNpYWwgb24gb2xkZXIgVGVncmEgZGV2aWNlcy4gUGVyaGFwcyB0aGVy
ZSdzIHNvbWV0aGluZyANCj4gPj4+IGFkZGl0aW9uYWwgdGhhdCB3ZSBuZWVkIHRvIHRha2UgaW50
byBhY2NvdW50Pw0KPiA+Pj4NCj4gPj4+IEFoYSEgTG9vayBhdCB0ZWdyYV9pMmNfcmVnX2FkZHIo
KSB3aGljaCBzcGVjaWFsLWNhc2VzIEkyQ19UWF9GSUZPIG9uIA0KPiA+Pj4gdGhlIERWQyB2YXJp
YW50IG9mIHRoZSBjb250cm9sbGVyLCB3aGljaCBpcyBleGFjdGx5IHRoZSBvbmUgdGhhdCB5b3Ug
DQo+ID4+PiBhcmUgc2VlaW5nIHRoZSB0aW1lb3V0cyBvbiBhbmQgaXQncyBleGFjdGx5IHRoZSBy
ZWdpc3RlciB0aGF0IHdlIHVzZSANCj4gPj4+IGFzIGRlc3RpbmF0aW9uIGZvciB0aGUgRE1BIHRy
YW5zZmVyLg0KPiA+Pj4NCj4gPj4+IEkgdGhpbmsgd2UgbmVlZCB0byBkbyBzb21ldGhpbmcgbGlr
ZSB0aGlzOg0KPiA+Pj4NCj4gPj4+IAlzbHZfY29uZmlnLmRzdF9hZGRyID0gaTJjX2Rldi0+YmFz
ZV9waHlzICsgDQo+ID4+PiB0ZWdyYV9pMmNfcmVnX2FkZHIoaTJjX2RldiwgSTJDX1RYX0ZJRk8p
Ow0KPiA+Pj4NCj4gPj4+IHRvIG1ha2Ugc3VyZSB3ZSBwYXNzIHRoZSByaWdodCBGSUZPIHJlZ2lz
dGVyIGFkZHJlc3MgdG8gRE1BLg0KPiA+Pg0KPiA+PiBJJ20gcnVubmluZyBpdCBvbiBUMjAgYXQg
dGhlIG1vbWVudC4gSSBkb24ndCBrbm93IGFib3V0IHRoZSBEVkMgcXVpcmtzLCBidXQgc291bmRz
IHBsYXVzaWJsZS4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBvdGhlciBpbmZv
Lg0KPiA+Pg0KPiA+PiBIZXJlIHRoZSBmdWxsIGxvZ3M6DQo+ID4+DQo+ID4+IFBJTy1vbmx5OiBo
dHRwOi8vZHBhc3RlLmNvbS8yTVgzRUFOLnR4dA0KPiA+PiBETUEtb25seTogaHR0cDovL2RwYXN0
ZS5jb20vM1ZYWlNTTS50eHQNCj4gPj4NCj4gPj4gTm90ZSB0aGUgIkZhaWxlZCB0byByZWFkIFQ0
NCBhbmQgVDUgKC0xMTApIiBlcnJvciB0aGF0IGhhcHBlbnMgaW4gRE1BLW9ubHkuIEFuZCBpdCBo
YXBwZW5zIG9uIGkyY0A3MDAwYzAwMCwgRFZDIGlzIGkyY0A3MDAwZDAwMC4NCj4gPiANCj4gPiBZ
ZXMgdGhpcyBpcyBkdWUgdG8gc2FtZSBpc3N1ZSB0aGVpcnJ5IG1lbnRpb25lZC4NCj4gPiBQcmlv
ciB0byB0cmFuc2ZlciB0aW1lb3V0IGZvciB0b3VjaCwgdHBzNjU4NnggcmVndWxhdG9yIHByb2Jl
IGZhaWxlZCBkdWUgdG8gaTJjIHRpbWVvdXQgd2hpY2ggdXNlcyBEVkMgKDcwMDBEMDAwKSBhbmQg
c2luY2UgRE1BIG1vZGUgaXMgZW5mb3JjZWQgYWxsIERWQy9QV1IgSTJDIHRyYW5zYWN0aW9ucyBh
bHNvIGdvIHRocnUgRE1BIGFuZCBGSUZPIHJlZ2lzdGVyIGZvciBEVkMgb2Zmc2V0IGlzIG5vdCBh
Y2NvdW50ZWQgd2hlbiBjb25maWd1cmUgdG8gZG1hIHNsYXZlLg0KPiA+IFdpbGwgZml4IGFuZCBz
ZW5kIHNvIHlvdSBjYW4gc2VlIGZvciByZXBybyB3aXRoIHVwZGF0ZWQgcGF0Y2guLg0KPiA+IA0K
PiA+IA0KPiA+IFsgICAgMC45MjUxNTVdIHRlZ3JhLWkyYyA3MDAwZDAwMC5pMmM6IHN0YXJ0aW5n
IERNQSBmb3IgbGVuZ3RoOiAxNg0KPiA+IFsgICAgMC45MjUxNjVdIHRlZ3JhLWkyYyA3MDAwZDAw
MC5pMmM6IHVubWFza2VkIGlycTogMGMNCj4gPiBbICAgIDEuMDI4OTYxXSB0ZWdyYS1pMmMgNzAw
MGQwMDAuaTJjOiBpMmMgdHJhbnNmZXIgdGltZWQgb3V0DQo+ID4gWyAgICAxLjAyODk2OF0gdGVn
cmEtaTJjIDcwMDBjMDAwLmkyYzogRE1BIHRyYW5zZmVyIHRpbWVvdXQNCj4gPiBbICAgIDEuMDI4
OTk1XSB0cHM2NTg2eCAzLTAwMzQ6IENoaXAgSUQgcmVhZCBmYWlsZWQ6IC0xMTANCj4gPiBbICAg
IDEuMDI5MDI5XSB0cHM2NTg2eDogcHJvYmUgb2YgMy0wMDM0IGZhaWxlZCB3aXRoIGVycm9yIC01
DQo+ID4gWyAgICAxLjAyOTA0NV0gYXRtZWxfbXh0X3RzIDAtMDA0YzogX19teHRfcmVhZF9yZWc6
IGkyYyB0cmFuc2ZlciBmYWlsZWQgKC0xMTApDQo+ID4gWyAgICAxLjAyOTA1MV0gYXRtZWxfbXh0
X3RzIDAtMDA0YzogRmFpbGVkIHRvIHJlYWQgVDQ0IGFuZCBUNSAoLTExMCkNCj4gPiANCj4gDQo+
IEkgdGhpbmsgdHBzNjU4NnggYW5kIGF0bWVsLXRvdWNoIHNob3VsZCBiZSBpbmRlcGVuZGVudCBp
c3N1ZXMsIGJ1dCB3aWxsIHNlZS4gVGhhbmtzIQ0KV2hhdHMgeW91ciBwbGF0Zm9ybSBzZXR1cD8g
SXMgYXRtZWwgdG91Y2ggcG93ZXIgT04gZGVmYXVsdCBvciBpdHMgcHJvZ3JhbW1lZCBkdXJpbmcg
Ym9vdCBieSBTVyB3aGNpaCBuZWVkIHRvIHVzZSBEVkM/DQo=
