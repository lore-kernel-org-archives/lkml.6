Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EAEC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D857221738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hrd9Dx9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfA1WPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:15:14 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:25804 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfA1WPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:15:13 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4f7eeb0000>; Tue, 29 Jan 2019 06:15:07 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 28 Jan 2019 14:15:06 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 28 Jan 2019 14:15:06 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 22:15:05 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.55) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Mon, 28 Jan 2019 22:15:04 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3192.namprd12.prod.outlook.com (20.179.92.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Mon, 28 Jan 2019 22:15:02 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 22:15:02 +0000
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
Subject: RE: [PATCH V3 2/3] i2c: tegra: Update transfer timeout
Thread-Topic: [PATCH V3 2/3] i2c: tegra: Update transfer timeout
Thread-Index: AQHUtStT3b8oUo3Te0iK36R9j5w2yqXB2CeAgAMogjCAAED+AIAAALug
Date:   Mon, 28 Jan 2019 22:15:02 +0000
Message-ID: <BYAPR12MB339837E896774531B0D11A98C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
 <1548475073-12408-2-git-send-email-skomatineni@nvidia.com>
 <0cf91475-f77d-7453-deb6-3dd91b63aeb6@gmail.com>
 <BYAPR12MB3398E9D32B57B0E2FC2A6466C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
 <c0b36535-6767-7327-5dc5-612e6957a769@gmail.com>
In-Reply-To: <c0b36535-6767-7327-5dc5-612e6957a769@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3192;6:G78c14sNWKbeKJ+4A9M4MA3nq+5bALdS/H84JgaLwIPPxFLF3IHgk6pnJ4OyXtflG1b17T6kImOGw0B6hM7U4LBSUezh9MfrurVzDRMmX/z/KklgEH/D+sQ5j/ahqJ3E/pQFdIfy2pQtudbfqgYOBX8QuYCzI0Q5tSB6FbNhi8JEafxLkb0je5aJNjja0Ad3ZL00Ynv+agkJUxkZL/eBhb/5MEecuqKT7oLm1mh2anUAVcMF5vkP1EpwcHrBnUHUL2WY9lZDm5miWVCeCOxo+aJWr2oHToHVTrLDLRAD7WJzQO1JdFRadsinViOqWsRowQcdS5rhgtUZ4H3MDPMcEPJwRj2xLulO5loGeTdeMWCM4B/1JOa0wjdGxqAvXVIIoOS/zQo44Y9R9BXzKfFKRjgIfEY5tsl0hr+Kck8T4ccajy1HSeA+4rDApuCF8Y6bfhZYMI4P7LGQplZkxAD25w==;5:USf3jBcMI8eW+QdlodY0uAecGiHWxYiN08hpYN7wY4Z0STxJOLGG4n3T50l4+sA9/qKZEGI9RpHTWervrUvkaqxvlDbJZ4aRKk/fI0evVknhN53A/sAPUAFUGJje950UDizSVfhKzHuUQVv1F1JlyxnCJLfWsor91OQgj5DMWoU4xY0UrSpX2foW2a6UH9KIpNZBushWcE/dP0wE9p+Jeg==;7:sMOLgHSbIWPK8Ffk4xsCyVoUWvECKhiAOKI8lsz/bXREgJbulj0Ao8N3ONIoqyESNVmVnbOSPpdmur1pdDleyVTybNOpm9z8KtQ7SgPbXcrkWi/CnjZZmq73fvBjktNipJb6EKkd8axt3IA7+jU/3w==
x-ms-office365-filtering-correlation-id: a642d650-dc45-4a3e-55b0-08d6856e0c85
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3192;
x-ms-traffictypediagnostic: BYAPR12MB3192:
x-microsoft-antispam-prvs: <BYAPR12MB3192DF1D05E08EFEF4D005A6C2960@BYAPR12MB3192.namprd12.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(199004)(189003)(2501003)(53936002)(486006)(105586002)(81156014)(74316002)(14454004)(14444005)(256004)(106356001)(476003)(8936002)(25786009)(446003)(11346002)(97736004)(316002)(93886005)(110136005)(54906003)(186003)(33656002)(8676002)(81166006)(6246003)(2906002)(3846002)(6116002)(26005)(102836004)(76176011)(39060400002)(7696005)(6506007)(99286004)(71200400001)(71190400001)(6436002)(9686003)(478600001)(55016002)(86362001)(68736007)(66066001)(4326008)(7736002)(6636002)(15650500001)(229853002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3192;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /OYTVYJgeCMLTS2YDDwcFFPVG3WbppPASzW+598pJoNSxDYLDrPueB7W8TSCpUPMSCviJq7Q8Nc3QTDS+YSh3kSZRrOdzmrFqfVZOHZiNm8p9FDo7oDAQjeDD+SJRbx/fabWWBTXY4tQuI4muEKYCP2+EwWyNAskFVSLqBIhyi/i5Fe2qXVTm5MuAQoLeK8Y6W+et7OvIcoLLVNrCm6ck+TnE0uFKZrxMwnxvLfdlwnqEvsOdVyTj2S5rDmfxvfARuHEnqjl0TrIOTh3IfpQYQ+YGMQRCgGaK3BRYMGfMMQFLt9qGEg4DH0Ic1vVL3gJBuDcCBSdF8jOBrEbLCd6fb/7f2506zVtrqc6MeKnN2Lnx8lwtw3lNF+Kna6eYyfFRspSJ3UHx0g19XQOIHQqGAPAE2sVniiM5sFU8cgpY2Y=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a642d650-dc45-4a3e-55b0-08d6856e0c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 22:15:02.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3192
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548713707; bh=jqkObYKj4hwAVcZeb8G+DqW9hzMzgkQs4lltwANV4rQ=;
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
        b=hrd9Dx9fkpR3v5Q3rEN3Hd8cwHRg6vo8vZ3Q5zyOxlddZf6caAbFOhb7HqanIFm1R
         fvJ/GXaBG41eh1ZGQcnWbBGntQ5LfUPHEfebcP4v7namv9q3rxhsnnKWuIP/saQ14/
         mp9jyi+/37+Hr3wjdus9eREhXnBYVv/klxygjdI4LER3p4F9RH1JMcNoi7RMCApfkf
         coiT6muOOiQJFydjG9f1VhQ6sYPBphBSzajB2Z6DctWXj+xha7NrQGnShne/kn3S+w
         PoeETnKAqVQTKjIj1u9H6SIt8ORyt9318bUv/JA58kDk834mTkn+CgTQ+5HfvQwEDK
         fY4Bw+uxeZ9iA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPj4+IFVwZGF0ZSBJMkMgdHJhbnNmZXIgdGltZW91dCBiYXNlZCBvbiB0cmFuc2ZlciBi
eXRlcyBhbmQgSTJDIGJ1cyByYXRlIA0KPiA+Pj4gdG8gYWxsb3cgZW5vdWdoIHRpbWUgZHVyaW5n
IG1heCB0cmFuc2ZlciBzaXplIGJhc2VkIG9uIHRoZSBzcGVlZC4NCj4gPj4NCj4gPj4gQ291bGQg
aXQgYmUgdGhhdCBJMkMgZGV2aWNlIGlzIGJ1c3kgYW5kIGp1c3Qgc2xvd2x5IGhhbmRsaW5nIHRo
ZSB0cmFuc2ZlciByZXF1ZXN0cz8gTWF5YmUgYmV0dGVyIHRvIGxlYXZlIHRoZSB0aW1lb3V0IGFz
LWlzIGFuZCBhc3N1bWUgdGhlIHdvcnN0IGNhc2Ugc2NlbmFyaW8/DQo+ID4+DQo+ID4gVGhpcyBj
aGFuZ2UgaW5jbHVkZXMgbWluIHRyYW5zZmVyIHRpbWUgb3V0IG9mIDEwMG1zIGluIGFkZGl0aW9u
IHRvIGNvbXB1dGVkIHRpbWVvdXQgYmFzZWQgb24gdHJhbnNmZXIgYnl0ZXMgYW5kIHNwZWVkIHdo
aWNoIGNhbiBhY2NvdW50IGluIGNhc2VzIG9mIHNsYXZlIGRldmljZXMgcnVubmluZyBhdCBzbG93
ZXIgc3BlZWQuDQo+ID4gQWxzbyBUZWdyYSBJMkMgTWFzdGVyIHN1cHBvcnRzIENsb2NrIHN0cmV0
Y2hpbmcgYnkgdGhlIHNsYXZlLg0KPg0KPiBPa2F5LCBJIHN1cHBvc2UgaW4gcmVhbGl0eSB0aGlz
IHNob3VsZG4ndCBicmVhayBhbnl0aGluZy4NCj4NCj4gUGxlYXNlIGV4cGxhaW4gd2hhdCBiZW5l
Zml0cyB0aGlzIGNoYW5nZSBicmluZ3MuIERvZXMgaXQgZml4IG9yIGltcHJvdmUgYW55dGhpbmc/
IFRoZSBjb21taXQgbWVzc2FnZSBvbmx5IGRlc2NyaWJlcyBjaGFuZ2VzIGRvbmUgaW4gdGhlIHBh
dGNoIGFuZCBoYXMgbm8gd29yZCBvbiBqdXN0aWZpY2F0aW9uIG9mIHRob3NlIGNoYW5nZXMuIFRy
YW5zZmVyIHRpbWVvdXQgaXMgYW4gZXh0cmVtZSBjYXNlIHRoYXQgZG9lc24ndCBoYXBwZW4gb2Z0
ZW4gYW5kID4gPiB3aGVuIGl0IGhhcHBlbnMsIHVzdWFsbHkgb25seSB0aGUgZmFjdCBvZiB0aW1l
b3V0IG1hdHRlcnMuIElmIHRoZXJlIGlzIG5vIHJlYWwgdmFsdWUgaW4gc2hvcnRlbmluZyBvZiB0
aGUgdGltZW91dCwgd2h5IGJvdGhlciB0aGVuPw0KDQpPcmlnaW5hbCB0cmFuc2ZlciB0aW1lb3V0
IGluIGV4aXN0aW5nIGRyaXZlciBpcyAxU2VjIGFuZCBpbmNhc2VzIG9mIHRyYW5zZmVyIHNpemUg
bW9yZSB0aGFuIDEwS2J5dGVzIGF0IFNURCBidXMgcmF0ZSwgdGltZW91dCBpcyBub3Qgc3VmZmlj
aWVudC4NCkFsc28gVGVncmExOTQgcGxhdGZvcm0gc3VwcG9ydHMgbWF4IG9mIDY0SyBieXRlcyBv
ZiB0cmFuc2ZlciBhbmQgdG8gYWxsb3cgZnVsbCB0cmFuc2ZlciBzaXplIGF0IGxvd2VzdCBidXMg
cmF0ZSBpdCB0YWtlcyBhbG1vc3QgfjUuOCBTZWMuDQpJbiBjYXNlcyBpZiBsYXJnZSB0cmFuc2Zl
ciBhdCBsb3cgYnVzIHJhdGVzIDEgU2VjIHRpbWVvdXQgaXMgbm90IGVub3VnaCBhbmQgaW4gdGhv
c2UgY2FzZXMgdHJhbnNmZXJzIHdpbGwgdGltZW91dCBiZWZvcmUgaXQgd2FpdHMgZm9yIGNvbXBs
ZXRlIHRyYW5zZmVyIHRvIGhhcHBlbi4NCg0KU28gdGhpcyBwYXRjaCB1c2VzIHRyYW5zZmVyIHRp
bWUgYmFzZWQgb24gdHJhbnNmZXIgYnl0ZXMgYW5kIGJ1cyByYXRlLg0K
