Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D42C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5803820B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Nrke7WqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfBFNb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:31:26 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:65397 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfBFNb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:31:26 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5ae1a90000>; Wed, 06 Feb 2019 21:31:21 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 05:31:20 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 06 Feb 2019 05:31:20 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 13:31:19 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.58) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 13:31:19 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2982.namprd12.prod.outlook.com (20.178.53.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 13:30:57 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 13:30:57 +0000
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
Subject: RE: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvaSihB2vPasFV02HZ/JY13Td7aXSqkqAgAAR9ACAAADL4IAAARIAgAAANpCAAASogIAAAKAggAABTDA=
Date:   Wed, 6 Feb 2019 13:30:57 +0000
Message-ID: <BYAPR12MB3398501ACBC54906F677C661C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <c4f67e39-df72-cc56-216b-8e6014891b52@gmail.com>
 <BYAPR12MB3398E50ED1C6909D6BCB0DDFC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <304c1916-e836-fa95-5cec-887fef8f3eb2@gmail.com>
 <BYAPR12MB33986680570EB919369000F3C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <82f38909-94f1-7984-2b0f-df6231aee58f@gmail.com>
 <BYAPR12MB3398B4A862E4BFA5344AE461C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3398B4A862E4BFA5344AE461C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2982;6:cQfD0cFbQOxSXZN/b9u0dvjh1eyExpwIOEG4GkimedJUy49rW5g3DB/ALhSHBOLX/qQitINpIU/+ACVBzSVeAak/VRIHhuYANuAn2f4tRutteiM1bnJna1RMqMyMz2DBZknutklUyN6lqO6Pc1LNQn0Qp33ZEuR2eqhhC3r+ubVUyUmaUIl/X7VisXiSrRrM7YOEyAz44FFJy/uLRK8AAU366mWzYXzxJ8k6mzfYrFZQ6eLjumrDfuo2YeKcpz7cFvO90rP/xT2Q/zCATkeHbRNU+ALJ8thK6FIUHBDEZzhrski5sSiG5AkUjRfpmA/vIiTKuX3ktJjJbzN6CqoOvS9eIe0+8qithnRiNYAfGoPG+zxQf98veDJKK7CeaEIpJnicmHbtRnGI4Cbs+X9Up53QpqCA6NExAPX+VYQPLRYOigicTXBat4AEPcdO3yfJEQpnlJDIpAcTpK70z8RRIQ==;5:3BO2jznq/ro5rh5ZRRSorUEWrYXQ/3TYyrq63D0+AtlqvyUHLgvNqxQu7RX1d7vzHLihK1zN0yT1EzDni8BC23Zd/24YAfhAVpFoEUgXI1OiIP6ftzm3kNQMhohWsB4a5Ubj2bBebftf8vdgG250/5CV1BV+g1yMZQGqFQjkNHGceybNP4ki/hyIF3o6C6XckojhOX+rFjvaKjKb0w9PeA==;7:O+lUWPwKOkyMDLKfuMzTnCLpeJfCaU26W44LbG5StRdSyeTy5ZytHpvDzaacyFKQYmG2aJE7gWZn2PrY9OWFZyzVSUMrsZmyRLMrRzLGDvqYdIUeXLBDL587g9ADBLzCnaiNZkMPB1ZoGVcWikqfhg==
x-ms-office365-filtering-correlation-id: 8ca148b9-cede-49b1-6afe-08d68c3753f5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2982;
x-ms-traffictypediagnostic: BYAPR12MB2982:
x-microsoft-antispam-prvs: <BYAPR12MB298295306524FA483C556224C26F0@BYAPR12MB2982.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(136003)(189003)(199004)(229853002)(93156006)(2501003)(6436002)(478600001)(68736007)(106356001)(316002)(105586002)(53936002)(71190400001)(71200400001)(54906003)(86362001)(110136005)(6116002)(3846002)(6246003)(476003)(256004)(14444005)(6636002)(99286004)(486006)(4326008)(446003)(66066001)(33656002)(2906002)(8936002)(25786009)(11346002)(76176011)(7696005)(81156014)(81166006)(8676002)(93886005)(6506007)(14454004)(102836004)(305945005)(74316002)(9686003)(186003)(97736004)(55016002)(26005)(2940100002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2982;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /JjdTsu84TvRoJ6tvbX05zfrZJDRA743FlLVcgfXfryR2bxjbdmmJRhb7mq0Qnn28fFa2M23X4SAJqS74SrmvICiaxbigNZyltFT/H3/FttaWKgxn1FzZ7Nu2ql8Hwjf53NGZGu/6fo0m216g5ileaaNl9EMClc+dn86IjbILpa0Zy3taBxsDjJ+UZJ0zoGLMzrV2hIIYV7AaX+1j/2ljMJL/pqAifVsCyiGBD+TdU/JugY8RvL5attMWO2ftsXzU1/9xvlwW0Tif04J+Yjf32IVhOX1BFySXpen3Yv7jUGNWfjjHItj4xSvFa8OKIlPVRASh60bW0i1+6jkOUHAjYMUWnXYrcx3QfFuf+Se9HLk2FV4fWk87SL4lC/paBA3Rv8h1fWzytd4l9mCNQ2xvXBWmL126JSaROCbkfs3qbg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca148b9-cede-49b1-6afe-08d68c3753f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 13:30:57.7335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2982
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549459881; bh=UzjEfsKt01S9gpShIJtXCECPU54+gXFmOTFXh5SPQpk=;
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
        b=Nrke7WqAIN4dg81+IG/BwO6OYq6AaejDULAn62hJgXuxLYf/BplLp9YNPQVhBuT9a
         VDRXFZTVjf87CNSinEv3WnwUeWdJy6jaam7GtG66s+oXxWic+UdLQl0MMYAX4qIsb6
         x9ODtjwpN+Pf/oJS/XOrLwoZEjn8jen/3WixVzATmXU5Gvb1rGD2bKwmqTwA9pRwic
         zvOYZzzgS0m/WpTFWd8p9OSUbyM9qQIK17Aa5cMe722fe47BYrRCulTOrb4Hwa/JVy
         NB6B8Ch/OBWThVqeHevUiHeUMGKgMUzwdd27y5Cxafx7vME8yTO7iHQpHtEmqNjhPs
         ls8SvOVB4rCPA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPiANCj4gPj4+PiBCVFcsIEknbSBzZWVpbmcgImF0bWVsX214dF90cyAwLTAwNGM6IFdh
cm5pbmc6IEluZm8gQ1JDIGVycm9yIC0gZGV2aWNlPTB4RjQzNkRDIGZpbGU9MHgwMDAwMDAiIHdo
aXRob3V0IG1ha2luZyBhbnkgbW9kaWZpY2F0aW9ucyB0byB0aGUgb3JpZ2luYWwgcGF0Y2ggYXMg
d2VsbCBhbmQgaXQgc2hhbGwgbm90IGhhcHBlbiwgaGVuY2UgdGhlcmUgaXMgYnVnIHNvbWV3aGVy
ZS4gUHJvYmFibHkgRklGTyB0cmlnZ2VycyBhcmUgc3RpbGwgbm90IHNldCB1cCBjb3JyZWN0bHku
Li4gPw0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+IEluIHNuaXBwZXQgeW91IHNlbnQsIEkgc2VlIHlv
dSBhcmUgZm9yY2luZyBkbWFfYnVyc3QgdG8gMSBhbHdheXMgd2hpY2ggaXMgd2hhdCBzZXQgZm9y
IGZpZm8gdHJpZ2dlciBsZXZlbHMgYXMgd2VsbCBhbmQgYWxzbyB5b3UgYXJlIGZvcmNpbmcgZG1h
IGFsbCB0aGUgdGltZS4NCj4gPj4+IFNvIGFsd2F5cyBpdCB3aWxsIGJlIDEgd29yZCBkbWEgYnVy
c3QgYW5kIDEgd29yZCB0cmlnZ2VyIGxldmVsIGFuZCB0aGF0IHNob3VsZCBub3QgYmUgYW4gaXNz
dWUuDQo+ID4+Pg0KPiA+Pg0KPiA+PiBJIHJldmVydGVkIHRoYXQgc25pcHBldCwgdGhpcyBsb2cg
aXMgY29sbGVjdGVkIHdpdGggdGhlIHlvdXJzIG9yaWdpbmFsIHBhdGNoLg0KPiA+Pg0KPiA+IEZy
b20gYXRtZWwgZHJpdmVyLCBsb29rcyBsaWtlIHRoaXMgd2FybmluZyBpcyBmcm9tIG1heHRfdXBk
YXRlX2NmZyANCj4gPiBhbmQgZHVlIHRvIENSQyBtaXNtYXRjaCBhbmQgYWJvdmUgdmFsdWVzIHNo
b3dzIHJlYWQgZGF0YSBDUkMgaXMgMFhmNDM2ZGMgd2hpY2ggaXMgY29tcGFyZWQgYWdhaW5zdCBp
bmZvX2NyYyBvZiBhbGwgMCdzIEluZm9fY3JjIGlzIGJhc2VkIG9uIHJhdyBjb25maWcgZmlsZSBh
bmQgc29tZWhvdyBpdHMgYWxsIDAncy4gdGhpcyBpcyBub3QgYmFzZWQgb24gZGF0YSByZWFkIHRo
cnUgaTJjLg0KPiA+IGRhdGEtPmluZm9fY3JjIGNvbXB1dGVkIG9uIGRhdGEgcmVhZCBpcyAwWGY0
MzZkYw0KPiA+IA0KPiA+IFRoaXMgd2FybmluZyBpcyBub3QgcmVsYXRlZCB0byBJMkMgdHJhbnNm
ZXINCj4gPiANCj4NCj4gSXQgZG9lc24ndCBoYXBwZW4gd2l0aCB0aGUgSTJDIFBJTyBtb2RlLiBT
ZWVtcyBpdCBtZWFucyB0aGF0IHRoZSBJMkMgcmVhZHMgb3V0IHRoZSAweEY0MzZEQyB2YWx1ZSBp
bnN0ZWFkIG9mIDB4MDAwMDAwLi4gaWYgSSdtIG5vdCBtaXNzaW5nIGFueXRoaW5nLg0KPg0KTG9n
IHRoYXQgeW91IHNoYXJlZCB0aGlzIHdhcm5pbmcsIGRvZXNu4oCZdCBzaG93IGFueSBpMmMgZmFp
bHVyZXMgd2l0aCBhdG1lbCBhbmQgQ1JDIGJhc2VkIG9uIGkyYyByZWFkICBkYXRhIGlzIDBYZjQz
NmRjLg0KRHVyaW5nIHRoaXMgbG9nLCB0aGVyZSBhcmUgbm90IERNQSB0aW1lb3V0cyBhc3NvY2lh
dGVkIGR1cmluZyB0aGlzIHdhcm5pbmcgdGltZWZyYW1lLiBTbyBpMmMgcmVhZCBkYXRhIGlzIHRo
cnUgRE1BIHdoaWNoIGlzIG5vbi16ZXJvLg0KDQpEbyB5b3Ugc2VlIERNQSB0aW1lb3V0cyBhc3Nv
Y2lhdGVkIHdpdGggdGhpcyB3YXJuaW5nPyBJIG1lYW50IGFueSBETUEgb3IgSTJDIHRpbWVvdXQg
ZHVyaW5nIHRoYXQgdGltZSBmcmFtZSBvZiB3YXJuaW5nPw0K
