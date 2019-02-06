Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB5CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A24C20811
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="c+ygRRPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfBFQjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:39:00 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1357 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbfBFQi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:38:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5b0da50000>; Wed, 06 Feb 2019 08:39:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 08:38:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Feb 2019 08:38:57 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 16:38:57 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.51) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 16:38:57 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3493.namprd12.prod.outlook.com (20.178.196.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 6 Feb 2019 16:38:55 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 16:38:55 +0000
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
Subject: RE: [PATCH V13 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V13 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvirrRqFd+/7ajEuXA8RvSaEC+KXS3a4AgAAAyeCAAAx6QIAABMwAgAAG+YCAAAEXoA==
Date:   Wed, 6 Feb 2019 16:38:55 +0000
Message-ID: <BYAPR12MB33980C126166D851B91AB187C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549464441-1836-1-git-send-email-skomatineni@nvidia.com>
 <1549464441-1836-3-git-send-email-skomatineni@nvidia.com>
 <4ecd3894-a1cb-20dd-8675-26e6e84254e7@gmail.com>
 <BYAPR12MB3398A6C76EC731D259FC3EA4C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33988DCC1F4997AAF2112447C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <9c6524ec-b40b-5b0f-eb70-f9ce2c426fd9@gmail.com>
 <8eccb125-b771-fe10-492f-41dcda00c3b0@gmail.com>
In-Reply-To: <8eccb125-b771-fe10-492f-41dcda00c3b0@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3493;6:nByahEyJ9vBKIwU7JiksD/fBWOF1b9Wiwlo7Uw6atPCDCwpIoKlLISOElwKq2XMEHng7wTw2r4xuiZHgJoKWngaHgeWNXR+C+lHS5gkJ6zRqbBkG9il+9Fq1XaCo7O4MBpqI7nWMhRe3JYn/gbnkf6KjevGYU4KAnwwkmADUe27lQZzwa3weC4MgCCkuCad2EvfMsZ7ucbVdA1tzUqcLqAXDt8gjvPh0JFVWrCZ0Zicw5akOhJEYu9pevnXsr7YIFMxAbWeNfUOPuUX+bhpUG0LQi3c0UEEpGS0zrasqJ6iyE9oB1ESLBqabBdtdmN/gi9Gx+SBD+Eui/s91bAqyo+roB9DEJnJLPgGNQYJB0gZKWa9T0owKSQpyGgYDDMODMYIYydGz2BHd/8CqYf3k8P5POHIktvhsOd7DsyQUwT//Ve7ZxWe667IoC/kdkdpR+HN4toRfHXb9z5PueyOFrA==;5:nKOTLrFeYLSG3xg2alLvJtgqut5YG8dJdxcvx4SEgzakCJX4i1y+wmlkI4MBRG/ENwICCIZgtkJ/wgQUzkuuuMDEjRDBa/HO3rD3XJzvRhS8k86EB7I4rsV7s6/L8NiBGmLKg48Tw6DE/vTcYbmV3zw2lgErMN//tdqUEKL/6jH5QBCuZ8ImDoHlJelwViHrBhgOrAaBo5oKAwhfB75yqw==;7:HBet9QvupqPkR6uBX6neMH0T5UHEETpIBwjkxrBZ/BvOo3Ui/rwnBw48WvsnFMvf8udYL2IQhFi0snvyO4hA96YeQujWj3EUAJfO4gb5NnElYU2qxWaBMlMrFIxYgSa0yhjibQQ2nJqlHPfIpAlO6A==
x-ms-office365-filtering-correlation-id: 875f4998-29af-41a5-6463-08d68c51962c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3493;
x-ms-traffictypediagnostic: BYAPR12MB3493:
x-microsoft-antispam-prvs: <BYAPR12MB349380256BDAC67AAB2FB7A1C26F0@BYAPR12MB3493.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(186003)(106356001)(102836004)(6116002)(26005)(3846002)(2906002)(33656002)(93886005)(105586002)(8676002)(6506007)(476003)(8936002)(7736002)(305945005)(74316002)(86362001)(81156014)(4326008)(81166006)(11346002)(97736004)(25786009)(446003)(486006)(53376002)(6246003)(6436002)(66066001)(478600001)(55016002)(6306002)(9686003)(966005)(14454004)(68736007)(229853002)(71190400001)(71200400001)(6636002)(54906003)(110136005)(2501003)(53936002)(316002)(7696005)(256004)(99286004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3493;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BR+M8rifrW//CcC0pL36tEkSdfc4AfWs+wL3+KavYWH1noDVGri6MSkR+ocm/yPSBONmK7Rwz774Xn3NPVQ7Dp0UsEfknUK/adpbP6tA8NVEyLZR3PskkcOp//O35ADlJ40Y9Z2+i9VQrexvXEbBNjoJYbfn1t24ohC6jO79gBJMiGIH1N82iOfoYnzNBfS0lOt6XC4iX4p25EgKhNDsYi/1q7EY+PetFwrk9YTp84nydAl+ki8cFQ23OUVzvhEekaWeZ1Kg0HSSCITG4pAuIbGr8pIzo691+yYaHpKeLk976GjgI4dq8lLpDlvDmhimQIqd+3CL6HFMrxkgrUfu5+SiWPMrOpNQvEpWsGV3ouaTkOS5/ZguN++tCJYOloSlOnPF5Wsps4DOGUa34dHMu9490QiV6+ae0b5k9mXjBGI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 875f4998-29af-41a5-6463-08d68c51962c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 16:38:55.6983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3493
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549471141; bh=r5Piyz3WNwlD9EzIKBbmgr8tPWdMEKRM7gRx9moBz0Y=;
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
        b=c+ygRRPAZMv+QhPD89ZKQ9fXATGm9px898g7ICDoPYOyq0H70/53h9y6YR2pc48Sl
         fc/gN5Kjjtr3fWXrJLALtqAPlYeseTB10jeHdcN4/LFoeIsQnoX0HuEepv2Sf81Yho
         NS/LAsFvJdBOBgJbakR7jymma+ygktQp/8RC1YSQhPtzt7TZitHkSPOHUAYe1XWeBK
         i1oY+xiT21gcuZJETc6ShX7r2gnii4GxbjGL4EHHyDiUujjX0kuOv90oWEQQHodziy
         15KOlfIdgrTMnrhX+jPqtSDbPrWquDaWy9cWOEYbXEO3EQhAuMw6rAdkNHt51hvyFC
         DW5mZRDeaeMRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiBMb29raW5nIGludG8gdGltZXN0YW1wcyBhbmQgdHJhbnNhY3Rpb25zLCBETUEgdGltZW91
dHMgYWZ0ZXIgc3RhcnQgb2YgRE1BIGZvciBJMkMxIHRvIHRvdWNoIGR1cmluZyB0aGlzIHRyYW5z
YWN0aW9uLg0KPiA+PiBXaGlsZSBpdCBpcyB3YWl0aW5nIGZvciBJMkMxIERNQSB0cmFuc2Zlciwg
bG90cyBvZiBEVkMgdHJhbnNhY3Rpb25zIA0KPiA+PiBoYXBwZW5lZCB0aHJ1IERNQSB3aGljaCBh
cmUgc3VjY2Vzc2Z1bA0KPiA+Pg0KPiA+PiBXaGF0IGlzIHRoZSBJMkMxIHNwZWVkPw0KPiA+IA0K
PiA+IDQwMEtIeg0KPiA+IA0KPiA+PiBBbHNvIGluY2FzZSBpZiBkZXZpY2UgaXMgcnVubmluZyBz
bG93IGZvciBzb21lIHJlYXNvbiwgcHJvYmFibHkgdGltZW91dCB3YXMgbm90IGVub3VnaCBhcyB0
aGlzIHBhdGNoIHNlcmllcyBjaGFuZ2VzIHRpbWVvdXQgd2l0aCBiYXNlIDEwMG1TICsgbXNnIHRy
YW5zZmVyIHRpbWUgYmFzZWQgb24gdHJhbnNmZXIgc2l6ZS4NCj4gPj4gQ2FuIHlvdSBnaXZlIHF1
aWNrIHRyeSB3aXRoIGluY3JlYXNlZCB0aW1lb3V0IGluY2FzZSBpZiBkZXZpY2UgaXMgcnVubmlu
ZyBzbG93Pw0KPiA+Pg0KPiA+IA0KPiA+IFRyaWVkIHRvIGluY3JlYXNlIHRoZSB0aW1lb3V0IHRv
IDEgc2Vjb25kLCBkb2Vzbid0IGhlbHAuDQo+ID4gDQo+ID4gV2hhdCBoZWxwZWQgYWdhaW4gaXMg
dGhlIEkyQyBIVyByZXNldHRpbmcgYWZ0ZXIgZWFjaCB0cmFuc2Zlci4gTGlrZWx5IHRoYXQgbWVh
bnMgdGhhdCBIVyBpc24ndCBwcm9ncmFtbWVkIGNvcnJlY3RseSwgcGxlYXNlIGNhcmVmdWxseSBj
aGVjayBldmVyeSBiaXQuDQo+ID4gDQo+ID4gRE1BLW9ubHkgKyBJMkMgSFcgcmVzZXQ6IGh0dHA6
Ly9kcGFzdGUuY29tLzI2QVFYRk0udHh0DQo+DQo+IFNlZW1zIEkgZm91bmQgd2hhdCdzIHRoZSBw
cm9ibGVtLiBIZXJlIGlzIHRoZSBmaXgsIHBsZWFzZSBpbmNsdWRlIGl0IHRvIHYxNCBpZiBpdCBp
cyBjb3JyZWN0Lg0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdy
YS5jIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jIGluZGV4IGE5MzkxYzM2NDZiNi4u
NWFkNTRkYTcwMzA0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3Jh
LmMNCj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jDQo+IEBAIC05MTIsNyAr
OTEyLDcgQEAgc3RhdGljIGlycXJldHVybl90IHRlZ3JhX2kyY19pc3IoaW50IGlycSwgdm9pZCAq
ZGV2X2lkKSAgc3RhdGljIHZvaWQgdGVncmFfaTJjX2NvbmZpZ19maWZvX3RyaWcoc3RydWN0IHRl
Z3JhX2kyY19kZXYgKmkyY19kZXYsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpemVfdCBsZW4pICB7DQo+IC0gICAgICAgdTMyIHZhbCwgcmVnOw0KPiArICAgICAg
IHUzMiB2YWwgPSAwLCByZWc7DQo+ICAgICAgICAgdTggZG1hX2J1cnN0ID0gMDsNCj4gICAgICAg
ICBzdHJ1Y3QgZG1hX3NsYXZlX2NvbmZpZyBzbHZfY29uZmlnID0gezB9Ow0KPiAgICAgICAgIHN0
cnVjdCBkbWFfY2hhbiAqY2hhbjsNCj4gQEAgLTkyMiw3ICs5MjIsNiBAQCBzdGF0aWMgdm9pZCB0
ZWdyYV9pMmNfY29uZmlnX2ZpZm9fdHJpZyhzdHJ1Y3QgdGVncmFfaTJjX2RldiAqaTJjX2RldiwN
Cj4gICAgICAgICAgICAgICAgIHJlZyA9IEkyQ19NU1RfRklGT19DT05UUk9MOw0KPiAgICAgICAg
IGVsc2UNCj4gICAgICAgICAgICAgICAgIHJlZyA9IEkyQ19GSUZPX0NPTlRST0w7DQo+IC0gICAg
ICAgdmFsID0gaTJjX3JlYWRsKGkyY19kZXYsIHJlZyk7DQogPg0KID4gICAgICAgIGlmIChpMmNf
ZGV2LT5pc19jdXJyX2RtYV94ZmVyKSB7DQogPiAgICAgICAgICAgICAgICBpZiAobGVuICYgMHhG
KQ0KDQpUaGFua3MgZG1pdHJ5LiBHb29kIGNhdGNoLiBEaWRuJ3QgY2F1Z2h0IHRvIG15IGV5ZXMu
IFllcyBGSUZPX0NPTlRST0wgaXMgc2V0IGJhc2VkIG9uIHJlYWQgdmFsdWUgd2l0aG91dCBtYXNr
aW5nIGFuZCBvcmluZyBjYXVzaW5nIGJhY2stYmFjayBETUEgdHJhbnNmZXJzIHJlc3VsdGluZyBp
biBpbmNvcnJlY3QgdHJpZyBsZXZlbHMNCldlIGNhbiBkaXJlY3RseSBzZXQgdHJpZyBsZXZlbHMu
DQpXaWxsIGZpeCBpdC4NCg==
