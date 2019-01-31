Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D70C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CD22085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="me+VEtqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfAaRjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:39:17 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8007 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfAaRjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:39:16 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5332990000>; Thu, 31 Jan 2019 09:38:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 31 Jan 2019 09:39:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 09:39:14 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 17:39:14 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 17:39:09 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.59) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 31 Jan 2019 17:39:09 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3350.namprd12.prod.outlook.com (20.178.55.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 17:38:51 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 17:38:51 +0000
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
Subject: RE: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuSyS8D4y2PEYbkigLw9+iOz1C6XJfImAgAADNwCAABXfQIAACAqAgAAEBwCAAAKP0A==
Date:   Thu, 31 Jan 2019 17:38:50 +0000
Message-ID: <BYAPR12MB339858E4B4E8F1336702AC8EC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
 <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
 <4663c7b9-d306-1cd4-1bdc-f7be84af0667@gmail.com>
 <8a88f8ee-24d3-00ac-f1fa-c43b576ed82c@gmail.com>
 <BYAPR12MB3398CFEE7E912513AE48DD2FC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
 <e50a353c-94c4-1a47-92a4-5f41f4f64aa7@gmail.com>
 <c2676c08-83d7-2ac9-ce34-c7c7f86d798e@gmail.com>
In-Reply-To: <c2676c08-83d7-2ac9-ce34-c7c7f86d798e@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3350;6:1o+krH6HikqUcT7Ad92unlKB1j41CVR66bJkncByr3TnvRJdl8c91Sa67yPyxmuxeceAvxvAItdEGdwgirmQimKJpM/19ieH1yAxOfBhMKKN6ed9K8MAJ+/QGblwwkxlpiURDUDBV9CI2zEthv7SmGtl8o+4xBaSzoF7dX8qJdzQQmp17wkygtq4Ow7T35Dqro98gcdC4ENaiUcVoqL3nbgLVMfU8qnXUmcLaa/Njnkhdh45Cyh3DFmiqERrhBIDuYBy+A8KbTUEigqBJgZuftRzl38SFSroFJehVatgaY/Y18Q+qirp0VPmkqlkJCEYUFm0A5XWF9Lkhb629UpRSx4HhFQaGlLbsZjfhhczWZc9aSSWUj2MAJm1zyW6cZoiMP4A7TGnrehX2Wsk/q0iWjavzmVLUEDLv7hx+4FjlgeiWbFvPqQ61Pm3a2KAv2/68BkQM4A3/ilmwTzwGeOc8w==;5:MPKb2RbZZGU9tlPNZ5284e/m96TqT9Em3x166BR7fSEKJGSJnkHcMObauTraFxwa3TYU1JPZNHQB/l/vOAYJEAimdQF3+Ankg8uznpezDcf/lSWcwQrkAc0G5JijhBCteUbe6pRTmr19RyAQ47qZfKDa+/rYhJPM89FsWNGFkZ6eZWvhVVtnW3DmEAW8eOx5b4Cjk5MkFQ3G60dchYDd7w==;7:zWgH5paycnaG50mAN76bWUvyVzYGqnnvIJMmxSPNQY8bvoiIf24ZAT+LCegtJAseu1NMx79eKkMjJbtUurlY8MaBckvW4wfbyOUb5iTR0COVXi47yQZr2acecHh8DR0yu1UdHAzugRKI+zkEYRbqFA==
x-ms-office365-filtering-correlation-id: 206d8871-4bb4-45bc-f8c5-08d687a2f697
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3350;
x-ms-traffictypediagnostic: BYAPR12MB3350:
x-microsoft-antispam-prvs: <BYAPR12MB3350928D2336B4A507985C3FC2910@BYAPR12MB3350.namprd12.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(86362001)(6506007)(2906002)(53936002)(229853002)(76176011)(106356001)(39060400002)(6246003)(33656002)(256004)(105586002)(97736004)(4326008)(26005)(25786009)(110136005)(6116002)(3846002)(71200400001)(71190400001)(102836004)(446003)(9686003)(6636002)(486006)(99286004)(305945005)(11346002)(93886005)(74316002)(81156014)(8676002)(476003)(186003)(7736002)(2501003)(316002)(8936002)(6436002)(478600001)(66066001)(81166006)(7696005)(54906003)(68736007)(14454004)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3350;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UXOcmYl+8vOaztffjIp5kz3xiIBScuvnU/LK/u8horXsltC6wHA4lN8rvHEvVhA+Zu0TMYCjSMohKMQXOENhXxGkxmhJJ3/0ooBCEVpv1FemSzkoCEp0oomqY5CltCsxXhFw6CHOIxdRqceEDu1HpySY89nDnhO5YT/ZNqw5fqfr/6U5fJwhLuB8ox1TWfHn+iHizRgzgaJ2M+ocwgevuoS/nzITzv1k7PmoUP5/1B4FGTtEy4Snh1DfaA8SZNvwyhMezlqbADn/WQQY/6WS+dxOWWMbYpYwZch5Z1tvOVoRRg8rhqGNte4iKPNOXYxIEvi4p0SFBtIrfiS94c/GmkpVTNPye+kw62/ILpvegalPxAgWH4wUghXhLuAWDumidIu+0ylxmdRnMJruRimJAsr3HcZhQ2mTMS0wHwXYSEk=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 206d8871-4bb4-45bc-f8c5-08d687a2f697
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 17:38:50.9829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3350
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548956313; bh=8RcAcCEAMLsJu1qm1Bw5Ha1oaLJq6ajbPMVnLyt8+EA=;
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
        b=me+VEtqiPgZpjBTdeO7k5BXCz6/Z9iFFYoljc80YHFk7/dCxcMcza9Nk8XC2rqUAp
         UTTNhPDA9AHKQw9687ZKQ57+Y3PmlMkKiJ3YT0ilGynS1KjjytWMSsc5g64Zv2e8Sr
         22padbAIHDg9nkrnGCKebrA4chTjEAW4MyGF6EgeyXKP6kf6cc7IjtOz607w/ip9JO
         NUKW7vyOnVOJDdamjEaQYNLXLdiUL8TWKf3TujjQ8kmyI19D0QIFr7Jq997ev+DoRO
         Cvzjp3Qup1Yr0u1nYsbscJT3RFsIthEVgPX229Mnjs3TTF/oAXOyv/rYPkumYJ6SXn
         g3rPyGPZ+1dHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4+Pg0KPj4gQlVHX09OIGxpbmUgaXMgbm90IHBhcnQgb2YgdGhpcyBjaGFuZ2UuIEl0IHdh
cyBhbHJlYWR5IHRoZXJlIGluIGV4aXN0aW5nIGRyaXZlci4NCj4+IEJhc2VkIG9uIGxvZywgSSBz
ZWUgRE1BIHRyYW5zZmVyIGlzIGRvbmUgZm9yIDIyNCBieXRlcyBmb2xsb3dlZCBieSAxIHN1Y2Nl
c3NmdWwgUElPIHRyYW5zZmVyIGFuZCB0aGVuIG9uIG5leHQgUElPIHRyYW5zZmVyIGl0IHJlY2Vp
dmVkIHBhY2tldCB4ZmVyIGNvbXBsZXRlIGludGVycnVwdCB3aXRoIGluY29tcGxldGUgdHJhbnNm
ZXIgYnl0ZXMgYW5kIHRoYXQgd2hlcmUgaXQgaGl0IEJVR19PTiBjb25kaXRpb24uDQo+Pg0KPj4N
Cj4gDQo+IFllcywgdGhhdCBCVUdfT04gaXMgY2F1c2VkIGJ5IHRoZSBETUEgdHJhbnNmZXJyaW5n
LiBFdmVyeXRoaW5nIHdvcmtzIGZpbmUgYmUgc2V0dGluZyBkbWE9ZmFsc2UgaW4gdGhlIGNvZGUs
IGhlbmNlIGl0J3MgbGlrZWx5IG5vdCBhIGJ1ZyBpbiB0aGUgY29kZSAoYXQgbGVhc3QgZm9yIG5v
dyBpdCBsb29rcyBmaW5lKSwgYnV0IGxpa2VseSB0aGF0IEhXIGlzIG5vdCBwcm9ncmFtbWVkIGNv
cnJlY3RseS4NCj4gDQoNCj4gSXQgd29ya3Mgd2l0aCB0aGlzIGNoYW5nZToNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtdGVncmEuYyBiL2RyaXZlcnMvaTJjL2J1c3Nl
cy9pMmMtdGVncmEuYyBpbmRleCBmZTViODlhYmM1NzYuLjhlMDU5ZTk0Yjk0ZSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jDQo+ICsrKyBiL2RyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtdGVncmEuYw0KPiBAQCAtMTE3MCwxMCArMTE3MCwxMSBAQCBzdGF0aWMgaW50
IHRlZ3JhX2kyY194ZmVyX21zZyhzdHJ1Y3QgdGVncmFfaTJjX2RldiAqaTJjX2RldiwNCj4gICAg
ICAgICAgICAgICAgIHRpbWVfbGVmdCwgY29tcGxldGlvbl9kb25lKCZpMmNfZGV2LT5tc2dfY29t
cGxldGUpLA0KPiAgICAgICAgICAgICAgICAgaTJjX2Rldi0+bXNnX2Vycik7DQo+DQo+ICsgICAg
ICAgdGVncmFfaTJjX2luaXQoaTJjX2RldiwgdHJ1ZSk7DQo+ICsNCj4gICAgICAgICBpZiAobGlr
ZWx5KGkyY19kZXYtPm1zZ19lcnIgPT0gSTJDX0VSUl9OT05FKSkNCj4gICAgICAgICAgICAgICAg
IHJldHVybiAwOw0KPiAgDQo+IC0gICAgICAgdGVncmFfaTJjX2luaXQoaTJjX2RldiwgdHJ1ZSk7
DQo+ICAgICAgICAgLyogc3RhcnQgcmVjb3ZlcnkgdXBvbiBhcmJpdHJhdGlvbiBsb3NzIGluIHNp
bmdsZSBtYXN0ZXIgbW9kZSAqLw0KPiAgICAgICAgIGlmIChpMmNfZGV2LT5tc2dfZXJyID09IEky
Q19FUlJfQVJCSVRSQVRJT05fTE9TVCkgew0KPiAgICAgICAgICAgICAgICAgaWYgKCFpMmNfZGV2
LT5pc19tdWx0aW1hc3Rlcl9tb2RlKQ0KPg0KPg0KPiBXaGljaCBtZWFucyB0aGF0IEhXIHN0YXRl
IGlzIGtlcHQgZGlydHkgYWZ0ZXIgRE1BIHRyYW5zZmVyLiBQbGVhc2UgY2hlY2sgZXZlcnl0aGlu
ZyBjYXJlZnVsbHkuDQoNCkZJRk8gdHJpZ2dlciBsZXZlbHMgYXJlIGRpZmYgZm9yIFBJTyBWcyBE
TUEgc28gaXQgbmVlZCB0byBiZSBtb3ZlZCB0byB4ZmVyIGZ1bmN0aW9uLiBXaWxsIGZpeCB0aGF0
Lg0K
