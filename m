Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78454C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDD221473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="p4BSZusn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfA3BpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:45:09 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:15781 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfA3BpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:45:08 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c51019e0000>; Wed, 30 Jan 2019 09:45:02 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 17:45:02 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 29 Jan 2019 17:45:02 -0800
Received: from DRBGMAIL102.nvidia.com (10.18.16.21) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 01:45:00 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by DRBGMAIL102.nvidia.com
 (10.18.16.21) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 01:44:59 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.51) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 30 Jan 2019 01:44:59 +0000
Received: from SN6PR12MB2640.namprd12.prod.outlook.com (52.135.103.17) by
 SN6PR12MB2799.namprd12.prod.outlook.com (52.135.107.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.23; Wed, 30 Jan 2019 01:44:57 +0000
Received: from SN6PR12MB2640.namprd12.prod.outlook.com
 ([fe80::e53d:71b1:ce2:664f]) by SN6PR12MB2640.namprd12.prod.outlook.com
 ([fe80::e53d:71b1:ce2:664f%2]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 01:44:57 +0000
From:   Mark Zhang <markz@nvidia.com>
To:     Billy Laws <blaws05@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>
Subject: =?utf-8?B?562U5aSNOiBbMi8yXSBtZmQ6IG1heDc3NjIwOiBBZGQgbG93IGJhdHRlcnkg?=
 =?utf-8?Q?monitor_support?=
Thread-Topic: [2/2] mfd: max77620: Add low battery monitor support
Thread-Index: AQHUtlBQvVPaj4gjcUW/hMnAJ3b8JqXF0ciAgAAMOICAABh9AIAAS2cAgADL1uA=
Date:   Wed, 30 Jan 2019 01:44:56 +0000
Message-ID: <SN6PR12MB2640E0E48D5C5A428D580F34C7900@SN6PR12MB2640.namprd12.prod.outlook.com>
References: <3587c682-e1db-5140-fd8e-13c46d882dd3@gmail.com>
 <bd942195-4f1c-1a39-283f-610354308f45@nvidia.com>
 <CAFUUQHM88kVh0ov1G30Sz9WQKJRY4p78hBMporL1xU=aY_tNCA@mail.gmail.com>
 <e1ebcd02-2d25-a6b7-081b-578878be15b4@nvidia.com>
 <CAFUUQHN=mge+RFWssYJDc9PiVGo5XtcZLwjek-xNbxmFX0tPUA@mail.gmail.com>
In-Reply-To: <CAFUUQHN=mge+RFWssYJDc9PiVGo5XtcZLwjek-xNbxmFX0tPUA@mail.gmail.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markz@nvidia.com; 
x-originating-ip: [203.18.50.4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2799;6:UdGorLFMv0VuhUY/6kpgOSj/RzITAobJlrT9IqQhzEIunDlfQGB0hwpkgv2uxERZ+Bi/xW5FyTFKMJVyhweMpFe6RnFONhRAc1SRZihcWQtgXYB+KI0SS+kZDT7r4ID3OtfDAqCPDYTAxbzJgQKHS+e40vwggjBeBnUs5zkq2mBYZCsGz4cFMcHwn5r22FIbvsnrZooHlWVLJ9qqzJXKmpbZNtbvQruHpOUujOOShgk2PgZ/QcihLwxV3CXL0/BRGj8OwbhHPCM32kk22S6+yg665c/NNxWE+gJxRRsK22/WIRbsrak3kpfiAtHa4AegjH+eVOI/jmcE2pVLYNYkJpuzEDBmaS0/dQyaLAPyAczvhWq/OdP1LF+PXfP+nmHCHeQp10HP2s6viNO7bssUQWXQO9glmm++pfTT2WBJoaT1bTQEqtVKnfHOz7dEZU3uzj1p4Ct5MOeDffB0sP3XiQ==;5:S6ASvwvZWK5P+Iwv7MZ9Xzcwa+JjQHVJvHrbdnLLV8QoSBrW9EYM1/JG57z42oGdCf7ZzGhHiHXjRcRXxlOmQbwcBZdrCxKBsm94CJfmSIrWFY+IiFoQgdpvuQPL/SDuYF/Y6jv4xaLRXlha9jZhl7TWlWwJfQf76wrGTen946O3q1tZsYWFa8Rbv8BIfKwVyag7WJqzJY0Evck0B6N0JQ==;7:GTjOfA3gegTDXm4f3YrIBuSIEoDzxiauHEbLxNFRgS7JFRQcr7FAGs9RKtXexlyJ6uX7s3WhZZxQ/gFeBuAIYnWNBP/tIgiB+Cw7XZpTiOk4oFpM3Q8o7BRT/VCWYkEYF/640EczxcAAM1+tf8t21A==
x-ms-office365-filtering-correlation-id: 77200492-749c-42f0-c2a7-08d686548a17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2799;
x-ms-traffictypediagnostic: SN6PR12MB2799:
x-microsoft-antispam-prvs: <SN6PR12MB27999426C183F7101DF477A4C7900@SN6PR12MB2799.namprd12.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(39860400002)(376002)(189003)(199004)(478600001)(71190400001)(71200400001)(6506007)(316002)(76176011)(53546011)(7696005)(81166006)(2906002)(8936002)(6436002)(66066001)(305945005)(81156014)(55016002)(68736007)(97736004)(102836004)(9686003)(74316002)(6306002)(4326008)(105586002)(224303003)(14444005)(256004)(54906003)(966005)(107886003)(99286004)(6116002)(39060400002)(93886005)(6916009)(26005)(186003)(7736002)(14454004)(86362001)(106356001)(486006)(11346002)(53936002)(476003)(446003)(1411001)(25786009)(3846002)(33656002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2799;H:SN6PR12MB2640.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WNDaQDU6x6DspvLrNlZ5b36Ht2A6ZdcCmMmrhebmlp1Zi/Usv1R6aWm3sVyO42gO7PKRXPEMmiqt96gkoro5df0IsHBpDitPgVkfwA6DrvMdoVBjJZl2Wb6DN9ofS0w7TqDafZnIqi2mR0dqOu/00UmjPPKboKztHSZudBn0AJOY1DQl1Z8w3aLU0gUuzsLjwWPn2ATGqiAIr3ecjNAir7WDNLHN5aF/Tc51rI43t2FqYvXuIjgHH382CBm9XOKG5Pb9EsX5bZhwvrSx5NzFdg2YqGOaG9a0rCxsfYeSrVKSVaudiG3KZgFprirox8p/6mC3l5Sbe5tPJYkpJHUEfuRLmGdpxSx26znJ4uB+xX2LU5HVyvWmauMKCzFEkfqsoBxIiirTd0AAuaZkWiHyctnyVStvGgQngHG1E9AXk+I=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 77200492-749c-42f0-c2a7-08d686548a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 01:44:56.9520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2799
X-OriginatorOrg: Nvidia.com
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548812702; bh=KsRMETeAQP1vgpIyiNgVweKXbRWt/F6Y/wXINvChxhA=;
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
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=p4BSZusnzXOWCQb7qBb2pWEBqNN+DyF7UZAJquSCvsxxOnv1/J0ytvzziYDtLG2Na
         VKMqew672PDgA25bqgi/Le+3txeXHVWQl7C27LsdF0L+W5ZQ2twFQPIULRwnl6Q+fP
         j11t78zJFzeIgC/mIWH97qT6NOhllZuXPfXV1aHqyf5wD1yFvvlQG5+5VgSQb1XuQ7
         NjdUfgu47bt+IEX9fDJJKSnfNZJFiHjzN4ZheCdvOOXtz90nYeo84byEsSeReGUtMn
         Ka9Iqds3Ra6tQ/I7st8E7aQD7/ybKeSl/JwSniRuRvXUNk4waKUbmSi5NPGHI1ECxV
         N6kkFIIA3/bpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T2ggSSBrbm93IHRoYXQgaXNzdWUgYW5kIGl0IHNob3VsZCBiZSBmaXhlZCBieToNCmh0dHBzOi8v
bWFyYy5pbmZvLz9sPWxpbnV4LWtlcm5lbCZtPTE1NDc0NTg0MDUxMzE0MSZ3PTMNClRoZSByb290
IGNhdXNlIGlzIHRoYXQgbWF4Nzc2MjAgZG9lc24ndCBoYXZlIGEgZGVkaWNhdGVkIGdwaW8gaW50
ZXJydXB0IG1hc2sgcmVnaXN0ZXIsDQpzbyB0aGUgIm1hc2tfYmFzZSIgb2YgbWF4Nzc2MjAgZ3Bp
byBkcml2ZXIgaXMgMCwgdGhhdCdzIHdoeSByZWdtYXBfYWRkX2lycV9jaGlwIHdyaXRlcyAweEZG
DQp0byBvZmZzZXQgemVyby4NCg0KTWFyaw0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hk
u7bkuro6IEJpbGx5IExhd3MgPGJsYXdzMDVAZ21haWwuY29tPiANCuWPkemAgeaXtumXtDogVHVl
c2RheSwgSmFudWFyeSAyOSwgMjAxOSA5OjM0IFBNDQrmlLbku7bkuro6IE1hcmsgWmhhbmcgPG1h
cmt6QG52aWRpYS5jb20+DQrmioTpgIE6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC10ZWdyYUB2Z2VyLmtlcm5lbC5v
cmc7IExheG1hbiBEZXdhbmdhbiA8bGRld2FuZ2FuQG52aWRpYS5jb20+OyBWZW5rYXQgUmVkZHkg
VGFsbGEgPHZyZWRkeXRhbGxhQG52aWRpYS5jb20+DQrkuLvpopg6IFJlOiBbMi8yXSBtZmQ6IG1h
eDc3NjIwOiBBZGQgbG93IGJhdHRlcnkgbW9uaXRvciBzdXBwb3J0DQoNCkl0IGRvZXMsIHNlZSB0
aGlzIGFydGljbGUNCmh0dHBzOi8vYmxvZy5xdWVuZGkubW9lLzIwMTgvMDcvMDMvZW4tZGVidWdn
aW5nLW5pbnRlbmRvLXN3aXRjaC1saW51eC1wb3dlci1tYW5hZ2VtZW50LWJhdHRlcnktZGVzeW5j
LWVkaXRpb24vDQoNCg0KT24gVHVlLCBKYW4gMjksIDIwMTkgYXQgOTowMyBBTSBNYXJrIFpoYW5n
IDxtYXJrekBudmlkaWEuY29tPiB3cm90ZToNCj4NCj4gT24gMS8yOS8yMDE5IDM6MzYgUE0sIEJp
bGx5IExhd3Mgd3JvdGU6DQo+ID4gU3VyZSwgdGhhdCdzIGZpbmUgd2l0aCBtZSwgd2lsbCBzZW5k
IHRoZW4gdGhpcyBnZXRzIGFjY2VwdGVkLiBUd28gDQo+ID4gb3RoZXIgdGhpbmdzOiB5b3Ugc2hv
dWxkIHByb2JhYmx5IHNldCB0aGUgcmVnIHRvIDAgaWYgdGhlIHByb3BlcnR5IA0KPiA+IGlzbid0
IHNwZWNpZmllZCBhcyByZWdtYXBfYWRkX2lycWNoaXAgc2V0cyBpdCB0byAweGZmIChiYXNpY2Fs
bHkgYWxsIA0KPiA+IGVuYWJsZWQgb24gaGlnaGVzdCBsaW1pdCksIGFuZCB5b3UgaGF2ZW4ndCB1
cGRhdGVkIHRoZSBkdC1iaW5kaW5ncy4NCj4NCj4gQmlsbHksIHYyIGlzIG91dCwgZHQtYmluZGlu
Z3MgcGF0Y2hlcyBhcmUgYWRkZWQuDQo+IEJ1dCBhZnRlciBhIHNlY29uZCB0aG91Z2h0LCBJIGRv
bid0IHRoaW5rIHJlZ21hcF9hZGRfaXJxY2hpcCBtaWdodCBzZXQgDQo+IHJlZ2lzdGVycyB0byAw
eGZmLiBJIG1lYW4sIGZvciAyIHJlZ2lzdGVycyB3aGljaCB0aGlzIHBhdGNoIHNldCANCj4gdG91
Y2hlcywgdGhleSdyZSBub3QgSVJRIHJlZ2lzdGVycyhtYXNrL3N0YXR1cy8uLi4pLCBzbyANCj4g
cmVnbWFwX2FkZF9pcnFjaGlwIHNob3VsZCBub3QgdG91Y2ggdGhlbSBzbyBJIGRpZG4ndCBtYWtl
IGNoYW5nZXMgdG8gZHJpdmVyIGNvZGVzIGluIHYyLg0KPg0KPiBNYXJrDQo+DQo+ID4NCj4gPiBP
biBUdWUsIEphbiAyOSwgMjAxOSBhdCA2OjUyIEFNIE1hcmsgWmhhbmcgPG1hcmt6QG52aWRpYS5j
b20+IHdyb3RlOg0KPiA+Pg0KPiA+PiBPbiAxLzI3LzIwMTkgMTA6NTQgUE0sIEJpbGx5IExhd3Mg
d3JvdGU6DQo+ID4+PiAgPlRoaXMgcGF0Y2ggYWRkcyBQTUlDIGNvbmZpZ3VyYXRpb25zIGZvciBs
b3ctYmF0dGVyeSAgPm1vbml0b3JpbmcgDQo+ID4+PiBieSBoYW5kbGluZyBtYXg3NzYyMCByZWdp
c3RlciBDTkZHR0xCTDEuDQo+ID4+PiAgPg0KPiA+Pj4gSXQgbWlnaHQgYmUgYW4gaWRlYSB0byBh
ZGQgbGJoeXN0IGNvbmZpZ3VyYXRpb24gaGVyZSBhbmQgc3VwcG9ydCANCj4gPj4+IHVzaW5nIGN1
c3RvbSBsYmRhYyB2YWx1ZXMgdG8gc3BlY2lmeSBhIGRpZmZlcmVudCBjdXRvZmYgcG9pbnQuDQo+
ID4+DQo+ID4+IFllYWggdGhpcyBwYXRjaCBkb2Vzbid0IGhhdmUgc3VwcG9ydCB0byBwcm9ncmFt
IExCSFlTVCAmIExCREFDIA0KPiA+PiBiZWNhdXNlIGFjY29yZGluZyB0byBvdXIgZXhwZXJpZW5j
ZXMsIHdlIGRvbid0IGhhdmUgcmVxdWlyZW1lbnQgdG8gDQo+ID4+IG1vZGlmeSB0aGVtIHdoZW4g
bG93IGJhdHRlcnkgbW9uaXRvciBzdXBwb3J0IGFkZGVkLg0KPiA+Pg0KPiA+PiBJIHRoaW5rIHdl
IGNhbiBjcmVhdGUgYSBuZXcgcGF0Y2ggdG8gc3VwcG9ydCB0aGVzZSAyIGZpZWxkcyBpbiB0aGUg
DQo+ID4+IGZ1dHVyZSB3aGVuIHdlIHJlYWxseSBuZWVkIHRoZW0uIE9yIHlvdSBjYW4gY3JlYXRl
IGEgcGF0Y2ggaWYgeW91IA0KPiA+PiBoYXZlIHJlcXVpcmVtZW50IGZvciB0aGVtLCBpcyB0aGlz
IE9LIHRvIHlvdSBCaWxseT8NCj4gPj4NCj4gPj4gTWFyaw0KPiA+Pg0KPiA+Pj4NCj4gPj4+IFNl
ZTogaHR0cHM6Ly9kYXRhc2hlZXRzcGRmLmNvbS9wZGYtZmlsZS85MjQyMzAvTWF4aW0vTUFYODY5
OEMvMSAgDQo+ID4+PiBwZyA0Ng0KPiA+Pj4gID5TaWduZWQtb2ZmLWJ5OiBMYXhtYW4gRGV3YW5n
YW4gPGxkZXdhbmdhbkBudmlkaWEuY29tPg0KPiA+Pj4gID5TaWduZWQtb2ZmLWJ5OiBWZW5rYXQg
UmVkZHkgVGFsbGEgPHZyZWRkeXRhbGxhQG52aWRpYS5jb20+DQo+ID4+PiAgPlNpZ25lZC1vZmYt
Ynk6IE1hcmsgWmhhbmcgPG1hcmt6QG52aWRpYS5jb20+DQo+ID4+PiAgPi0tLQ0KPiA+Pj4gID4g
ZHJpdmVycy9tZmQvbWF4Nzc2MjAuYyB8IDU3IA0KPiA+Pj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystDQo+ID4+PiAgPiAxIGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKSAgPiAgPmRpZmYgLS1naXQgDQo+ID4+PiBhL2RyaXZlcnMv
bWZkL21heDc3NjIwLmMgYi9kcml2ZXJzL21mZC9tYXg3NzYyMC5jICA+aW5kZXggDQo+ID4+PiBm
NTgxNDMxMDMxODUuLjllNTBkMTQ1YWZkOCAxMDA2NDQNCj4gPj4+ICA+LS0tIGEvZHJpdmVycy9t
ZmQvbWF4Nzc2MjAuYw0KPiA+Pj4gID4rKysgYi9kcml2ZXJzL21mZC9tYXg3NzYyMC5jDQo+ID4+
PiAgPkBAIC00NzQsNiArNDc0LDU3IEBAIHN0YXRpYyBpbnQNCj4gPj4+IG1heDc3NjIwX2luaXRf
YmFja3VwX2JhdHRlcnlfY2hhcmdpbmcoc3RydWN0IG1heDc3NjIwX2NoaXAgKmNoaXApICANCj4g
Pj4+ID4gIHJldHVybiByZXQ7ICA+IH0gID4gID4rc3RhdGljIGludCANCj4gPj4+IG1heDc3NjIw
X2luaXRfbG93X2JhdHRlcnlfbW9uaXRvcihzdHJ1Y3QgbWF4Nzc2MjBfY2hpcCAqY2hpcCkgID4r
eyAgDQo+ID4+PiA+KyBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBjaGlwLT5kZXY7ICA+KyBzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5wOyAgPisgDQo+ID4+PiBib29sIHB2YWw7ICA+KyB1OCBtYXNrID0gMDsg
ID4rIHU4IHZhbCA9IDA7ICA+KyBpbnQgcmV0OyAgPisgID4rIA0KPiA+Pj4gbnAgPSBvZl9nZXRf
Y2hpbGRfYnlfbmFtZShkZXYtPm9mX25vZGUsICJsb3ctYmF0dGVyeS1tb25pdG9yIik7ICANCj4g
Pj4+ID4rIGlmICghbnApIHsgID4rIGRldl9pbmZvKGRldiwgIkxvdyBiYXR0ZXJ5IG1vbml0b3Jp
bmcgc3VwcG9ydCANCj4gPj4+IGRpc2FibGVkXG4iKTsgID4rIHJldHVybiAwOyAgPisgfSAgPisg
ID4rIHB2YWwgPSANCj4gPj4+IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgIm1heGltLGxvdy1i
YXR0ZXJ5LWRhYy1lbmFibGUiKTsgID4rIGlmIA0KPiA+Pj4gKHB2YWwpIHsgID4rIG1hc2sgfD0g
TUFYNzc2MjBfQ05GR0dMQkwxX0xCREFDX0VOOyAgPisgdmFsIHw9IA0KPiA+Pj4gTUFYNzc2MjBf
Q05GR0dMQkwxX0xCREFDX0VOOyAgPisgfSAgPisgID4rIHB2YWwgPSANCj4gPj4+IG9mX3Byb3Bl
cnR5X3JlYWRfYm9vbChucCwgIm1heGltLGxvdy1iYXR0ZXJ5LWRhYy1kaXNhYmxlIik7ICA+KyBp
ZiANCj4gPj4+IChwdmFsKSAgPisgbWFzayB8PSBNQVg3NzYyMF9DTkZHR0xCTDFfTEJEQUNfRU47
ICA+KyAgPisgcHZhbCA9IA0KPiA+Pj4gb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAibWF4aW0s
bG93LWJhdHRlcnktc2h1dGRvd24tZW5hYmxlIik7DQo+ID4+PiAgPisgaWYgKHB2YWwpIHsNCj4g
Pj4+ICA+KyBtYXNrIHw9IE1BWDc3NjIwX0NORkdHTEJMMV9NUFBMRDsgID4rIHZhbCB8PSANCj4g
Pj4+IE1BWDc3NjIwX0NORkdHTEJMMV9NUFBMRDsgID4rIH0gID4rICA+KyBwdmFsID0gDQo+ID4+
PiBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJtYXhpbSxsb3ctYmF0dGVyeS1zaHV0ZG93bi1k
aXNhYmxlIik7DQo+ID4+PiAgPisgaWYgKHB2YWwpDQo+ID4+PiAgPisgbWFzayB8PSBNQVg3NzYy
MF9DTkZHR0xCTDFfTVBQTEQ7ICA+KyAgPisgcHZhbCA9IA0KPiA+Pj4gb2ZfcHJvcGVydHlfcmVh
ZF9ib29sKG5wLCAibWF4aW0sbG93LWJhdHRlcnktcmVzZXQtZW5hYmxlIik7DQo+ID4+PiAgPisg
aWYgKHB2YWwpIHsNCj4gPj4+ICA+KyBtYXNrIHw9IE1BWDc3NjIwX0NORkdHTEJMMV9MQlJTVEVO
OyAgPisgdmFsIHw9IA0KPiA+Pj4gTUFYNzc2MjBfQ05GR0dMQkwxX0xCUlNURU47ICA+KyB9ICA+
KyAgPisgcHZhbCA9IA0KPiA+Pj4gb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAibWF4aW0sbG93
LWJhdHRlcnktcmVzZXQtZGlzYWJsZSIpOw0KPiA+Pj4gID4rIGlmIChwdmFsKQ0KPiA+Pj4gID4r
IG1hc2sgfD0gTUFYNzc2MjBfQ05GR0dMQkwxX0xCUlNURU47ICA+KyAgPisgcmV0ID0gDQo+ID4+
PiByZWdtYXBfdXBkYXRlX2JpdHMoY2hpcC0+cm1hcCwgTUFYNzc2MjBfUkVHX0NORkdHTEJMMSwg
bWFzaywgdmFsKTsgIA0KPiA+Pj4gPisgaWYgKHJldCA8IDApICA+KyBkZXZfZXJyKGRldiwgIlJl
ZyBDTkZHR0xCTDEgdXBkYXRlIGZhaWxlZDogDQo+ID4+PiAlZFxuIiwgcmV0KTsgID4rIHJldHVy
biByZXQ7ICA+K30gID4rICA+IHN0YXRpYyBpbnQgDQo+ID4+PiBtYXg3NzYyMF9yZWFkX2VzX3Zl
cnNpb24oc3RydWN0IG1heDc3NjIwX2NoaXAgKmNoaXApICA+IHsgID4gIA0KPiA+Pj4gdW5zaWdu
ZWQgaW50IHZhbDsgID5AQCAtNTYzLDcgKzYxNCwxMSBAQCBzdGF0aWMgaW50IA0KPiA+Pj4gbWF4
Nzc2MjBfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwgID4gIGlmIChyZXQgPCAwKSAg
PiAgDQo+ID4+PiByZXR1cm4gcmV0OyAgPg0KPiA+Pj4gID4tIHJldCA9ICBkZXZtX21mZF9hZGRf
ZGV2aWNlcyhjaGlwLT5kZXYsIFBMQVRGT1JNX0RFVklEX05PTkUsICANCj4gPj4+ID4rIHJldCA9
IG1heDc3NjIwX2luaXRfbG93X2JhdHRlcnlfbW9uaXRvcihjaGlwKTsNCj4gPj4+ICA+KyBpZiAo
cmV0IDwgMCkNCj4gPj4+ICA+KyByZXR1cm4gcmV0Ow0KPiA+Pj4gID4rDQo+ID4+PiAgPisgcmV0
ID0gZGV2bV9tZmRfYWRkX2RldmljZXMoY2hpcC0+ZGV2LCBQTEFURk9STV9ERVZJRF9OT05FLA0K
PiA+Pj4gID4gICAgICBtZmRfY2VsbHMsIG5fbWZkX2NlbGxzLCBOVUxMLCAwLA0KPiA+Pj4gID4g
ICAgICByZWdtYXBfaXJxX2dldF9kb21haW4oY2hpcC0+dG9wX2lycV9kYXRhKSk7DQo+ID4+PiAg
PiAgaWYgKHJldCA8IDApIHsNCj4gPj4+DQo=
