Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA67C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50482184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ccUWitPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfAYWWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 17:22:50 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17650 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAYWWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 17:22:49 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4b8c130000>; Fri, 25 Jan 2019 14:22:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 14:22:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 14:22:48 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 22:22:48 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 22:22:47 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.59) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 25 Jan 2019 22:22:47 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2821.namprd12.prod.outlook.com (20.177.229.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Fri, 25 Jan 2019 22:22:41 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 22:22:41 +0000
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
Subject: RE: [PATCH V2 3/4] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V2 3/4] i2c: tegra: Add DMA Support
Thread-Index: AQHUtCaoqz5N11EqJkeckmeQlifKWKXAYa0AgAANI4CAAAUtAIAAAiXggAARXQCAAADvQA==
Date:   Fri, 25 Jan 2019 22:22:40 +0000
Message-ID: <BYAPR12MB33987E81045953368D0113A2C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-3-git-send-email-skomatineni@nvidia.com>
 <dcc1e094-638e-5b04-7a61-bdbc24ee068f@gmail.com>
 <BYAPR12MB339829FC6F2F95F833FE45A1C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <ad177c2e-3801-ddad-b359-ac83530ee1d6@gmail.com>
 <BYAPR12MB33982ED3A9EC34819D2490F8C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <782dcecf-2991-e886-af18-d355a3ea8325@gmail.com>
In-Reply-To: <782dcecf-2991-e886-af18-d355a3ea8325@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2821;6:7dPW7OlkHch07HHkfub3keD1inkvcKxC06Xoa06Ja9RHHKgkALQhGa8HvDuecPBukBRHbI37cGAVXQ4ypiOpVB0vg9MXiapwTnxgwF6oxCCTcMEKdMP70tINHz/1PWwmsMWJwbKD6XxfXqCPcF5Gz/004TSw2Lz/PYRETKtEu+qKbVuTgQEp6Do3GwmmQt+paJogt7JBg/0Yg/OGYtOGbup/giUdE4+FHHj/pDou/1ivVPmd1dbqhepJPkbAp9V902YdgeMWNy33FBkcHkXojvmpvewZMv1jovSq11XGRsMww86ULX07df+QSbMIZbDqGBitr6EtPKxOfEyEXtnzDOQMkrFsDqtS4kvj0xKkhosXduozZHzPGRu6YMJHogkkFMRApyw6JpPQutdFziwu9+H6Jhga20PWPMNccXwGiy/+tBhyx6LDLF+n2NZToEvkhOuJUs6Ldo6XeTBBOsskFw==;5:VfOUWvisGU9BXAUKKPh2Lql1kP/AxXYqyTqb9zUPD8OpHhH9DPahnbA+tBaWWv9+ZsmzX7E0Eo+g2skUF+oRtU2lYXlNgHafPxp7EONJeQPlmQGs//W8AKeDwgqZX9Ee97+mQb0kXKlkyoqOnuP6VES1ytnErb0lUcQZMMlxgtIXSvq44qivDkLmOisij2YVCsdyEXW2xluvHTGP9oDMOA==;7:G6YYY83gk05FPDeFfLR51AeJsgdLPbiS7YqwBwHUTMRQCV/PoAJgkCOxdoxsCCspUdooF6deMMFGgXhevIhMrwKmvlVvZf4Pr1nX17BuMtEGRHYmRK7xU+LNM1eeSmKPnNYfaeyjkmViQ+bDxzySiQ==
x-ms-office365-filtering-correlation-id: 83bda832-f82e-4289-4cdb-08d683139ec5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2821;
x-ms-traffictypediagnostic: BYAPR12MB2821:
x-microsoft-antispam-prvs: <BYAPR12MB2821684AEDE0AA797E28A29CC29B0@BYAPR12MB2821.namprd12.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39860400002)(346002)(136003)(199004)(189003)(14444005)(14454004)(256004)(7696005)(93886005)(53936002)(68736007)(446003)(11346002)(6246003)(476003)(6116002)(3846002)(25786009)(39060400002)(99286004)(4326008)(8676002)(81156014)(81166006)(478600001)(6636002)(486006)(8936002)(229853002)(33656002)(316002)(7736002)(305945005)(105586002)(74316002)(71200400001)(71190400001)(2501003)(2906002)(106356001)(97736004)(102836004)(55016002)(66066001)(186003)(6506007)(9686003)(110136005)(6436002)(54906003)(86362001)(76176011)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2821;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gZ8kHYn7+q6D10U3EqOKVbEDtcVKLjiTzP+HZIaQwhgz2tOoJKhpDOg7PhUYSuys7TydkzvlDmjyw5ngFRw/V//S/YjtmZNGijPUZxTydAFs6KVm0r7OTqQ61V82sactouBITee5DXHb3FiMxrJz1o8WWsTK5nOWhtmqCRGq92I8dY1DL3TvbU0DNB0aS0ssc0YJU0daJpxbMVipnMG+566v61CXnNDM+Swj3X6D/ZSYEU1Jd/GxP1ztECOSZ0CQKP/6TWy29rH9gKTmtaLMuS4Mv/PNwaR0bFvZlTtBeaicJzVbG2aSF56JcfjqsouPusqynB8OSwpCeVMHghZD3NmMgfWOgAAdgLDrSUYNiZyK5RVvqeMeG5Tst6VWofAnIdZuUupORzHPWFMtSZLNDBufHNZy7c0iuXdhixr1ESU=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bda832-f82e-4289-4cdb-08d683139ec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 22:22:40.8780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2821
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548454931; bh=ldHIUkF0bn03l73Umqw+rirDPJxl+XUaZ2bNHR+I82I=;
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
        b=ccUWitPDPcDS/gNmioT9J+SMq9YXndbPXto419dBDeVWS3R6bP1mINaiB5iX3zlfh
         8YtAp/pPKwfk0OMGlH3BomURd+obEvJ54k2pt2u9cWpc545Fp9ccaxgJxBNUHzj9O3
         ev9Rqy8dw+cHFj5Y9H2r8Gj9y5d6C9tgd58drLcap03OVQ+F0GA/8C2FOYAKJajU2/
         GdRWjjL3y+CUK6lt2wMfSYKmnaJ0HELZEiTHeonCQcodOnklXxhJHdwMzrPLjW7cl4
         dSIngEjs1gcCvThbpMzhfrafdO2ivwLu/g42+ZmlkKXqxo8FEBzm40S7RdX2WDt2eA
         msLD0olU+5avw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPj4+Pj4gKwlpZiAoaTJjX2Rldi0+aGFzX2RtYSkgew0KPiA+Pj4+PiArCQlyZXQgPSB0
ZWdyYV9pMmNfaW5pdF9kbWFfcGFyYW0oaTJjX2RldiwgdHJ1ZSk7DQo+ID4+Pj4+ICsJCWlmIChy
ZXQgPT0gLUVQUk9CRV9ERUZFUikNCj4gPj4+Pj4gKwkJCWdvdG8gZGlzYWJsZV9kaXZfY2xrOw0K
PiA+Pj4+PiArCQlyZXQgPSB0ZWdyYV9pMmNfaW5pdF9kbWFfcGFyYW0oaTJjX2RldiwgZmFsc2Up
Ow0KPiA+Pj4+PiArCQlpZiAocmV0ID09IC1FUFJPQkVfREVGRVIpDQo+ID4+Pj4+ICsJCQlnb3Rv
IGRpc2FibGVfZGl2X2NsazsNCj4gPj4+Pg0KPiA+Pj4+IFNvIHRlZ3JhX2kyY19pbml0X2RtYV9w
YXJhbSgpIGNvdWxkIGZhaWwsIHByaW50aW5nIGEgZXJyb3IgbWVzc2FnZSwgYW5kIHByb2JlIHdp
bGwgc3VjY2VlZD8gSWYgYWxsb2NhdGlvbiBmYWlscyBkdXJpbmcgdGhlIGRyaXZlcidzIHByb2Jl
LCB0aGVuIGp1c3QgZmFpbCB0aGUgcHJvYmUuIFBsZWFzZSBnaXZlIHRoZSByYXRpb25hbGUuDQo+
ID4+Pg0KPiA+Pj4gSWYgQVBCIERNQSBwcm9iZSBkb2VzbuKAmXQgaGFwcGVuIHByaW9yIHRvIHRl
Z3JhIGkyYywgRE1BIGlzIG5vdCBhdmFpbGFibGUgYnkgdGhlIHRpbWUgdGVncmFfaW5pdF9kbWFf
cGFyYW0gdHJpZXMgdG8gcmVxdWVzdCBzbGF2ZSBjaGFubmVsIGFuZCBpbiB0aG9zZSBjYXNlcyBk
bWFfcmVxdWVzdF9zbGF2ZV9jaGFubmVsX3JlYXNvbiB3aWxsIHJldHVybiBFUFJPQkVfREVGRVIg
Zm9yIHRlZ3JhIEkyQyBwcm9iZSB0byByZXRyeQ0KPiA+Pj4NCj4gPj4+IEluIGNhc2UgaWYgRE1B
IGlzIGF2YWlsYWJsZSBidXQgRE1BIGJ1ZmZlciBhbGxvY2F0aW9uIGZhaWxzLCB0aGVuIHRlZ3Jh
X2kyY19pbml0X2RtYV9wYXJhbSByZXR1cm5zIEVOT01FTSBhbmQgcHJvYmUgYWxzbyBmYWlscyBy
ZXR1cm5pbmcgc2FtZSBFTk9NRU0NCj4gPj4NCj4gPj4gSXMgdGhhdCB3aGF0IHlvdSdyZSBnb2lu
ZyB0byBjaGFuZ2UgaW4gdGhlIG5leHQgdmVyc2lvbj8gWW91ciBjdXJyZW50IHZhcmlhbnQgb2Yg
dGhlIGNvZGUgZG9lc24ndCBmYWlsIHRoZSBwcm9iZSBvbiBFTk9NRU0gYW5kIHRoZXJlIGlzIGR1
cGxpY2F0ZWQgYXR0ZW1wdCB0byBpbnZva2UgdGVncmFfaTJjX2luaXRfZG1hX3BhcmFtKCkgZHVy
aW5nIHRoZSB0cmFuc2Zlci4NCj4gPiANCj4gPiBTb3JyeSBjb3JyZWN0aW9uIHRvIG15IHByZXZp
b3VzIHJlcGx5LiAgSWYgRE1BIGJ1ZmZlciBhbGxvY2F0aW9uIGZhaWxzLCB0ZWdyYV9pMmNfaW5p
dF9kbWFfcGFyYW0gcmV0dXJucyBFTk9NRU0gYnV0IHByb2JlIHdpbGwgc3VjY2VlZCBhcyBpMmMg
dHJhbnNhY3Rpb24gbmVlZCB0byBoYXBwZW4gZHVyaW5nICBib290IGZvciBzb21lIHBsYXRmb3Jt
IGRldmljZSBwcm9ncmFtbWluZyBmb3Igc3VjY2Vzc2Z1bCBib290IGFuZCB0aGV5IHVzZSBQSU8g
PiBtb2RlIGFzIHhmZXIgYnl0ZXMgaXMgbGVzcyBhbmQgZGVmZXJyaW5nIGkyYyBwcm9iZSBmb3Ig
RU5PTUVNIGNhdXNlcyBib290IHRvIGZhaWwgc28gZHVyaW5nIHByb2JlIEVQUk9CRV9ERUZFUiBp
cyBvbmx5IHRha2VuIGNhcmUuDQo+ID4gDQo+ID4gUmUtYXR0ZW1wdCBvZiB0ZWdyYV9pMmNfaW5p
dF9kbWFfcGFyYW0gaW4geGZlciBoYXBwZW5zIG9ubHkgaWYgbm8gc3VjY2Vzc2Z1bCBETUEgY2hh
bm5lbCBhbGxvY2F0aW9uIGhhcHBlbnMgcHJpb3IgdG8gdGhhdCAoIGR1cmluZyBwcm9iZSBpbiBj
YXNlIG9mIEVOT01FTSkuDQo+ID4gRE1BIG1vZGUgaXMgbWFpbmx5IGZvciBsYXJnZSB0cmFuc2Zl
ciwgYW5kIGkyYyB4ZmVyIHJldHVybmluZyBmYWlsdXJlIGR1ZSB0byBmYWlsaW5nIERNQSBidWZm
ZXIgYWxsb2NhdGlvbiBjYXVzZXMgYm9vdCB0byBoYW5nIGFzIHBsYXRmb3JtIGRldmljZSBwcm9n
cmFtbWluZyBuZWVkIHRvIGhhcHBlbiB3aGljaCBkb2VzbuKAmXQgbmVlZCB0byB1c2UgRE1BLg0K
PiA+IFdpbGwgZml4IHRoaXMgYW5kIHdpbGwgc2VuZCB1cGRhdGVkIHBhdGNoIHRvIHJlYXR0ZW1w
dCBETUEgcmVxdWVzdCBhbmQgYnVmZmVyIGFsbG9jYXRpb24gZHVyaW5nIERNQSBtb2RlIHRyYW5z
ZmVyIGFuZCB3aWxsIHJldHVybiBmYWlsIGZvciBETUEgbW9kZSBJMkMgdHJhbnNmZXIuLi4NCj4N
Cj4gMSkgVGhlIGNoYW5jZSB0byBnZXQgRU5PTUVNIGR1cmluZyBpcyBtaXNlcmFibGUgYW5kIGxp
a2VseSB0aGF0IHRoZXJlIGFyZSBtdWNoIGJpZ2dlciBwcm9ibGVtcyBpbiB0aGlzIGNhc2UuIEhl
bmNlIGp1c3QgZmFpbCB0aGUgcHJvYmUgaWYgdGVncmFfaTJjX2luaXRfZG1hX3BhcmFtKCkgZmFp
bHMgd2l0aCBhbnkgZXJyb3IuDQoNCkFncmVlLiANCg0KPiAyKSBXaGF0IGlzIHRoYXQgc3VwZXIt
Y3JpdGljYWwgcGxhdGZvcm0gZGV2aWNlPyBJdCBpcyBwb3NzaWJsZSB0byBjb21waWxlIHRlZ3Jh
LWkyYyBhcyBhIGtlcm5lbCBtb2R1bGUgYW5kIHNlZW1zIG5vdGhpbmcgZW5mb3JjZXMgQ09ORklH
X0kyQ19URUdSQT15Lg0KU29tZSBvZiB0aGUgaTJjIGRldmljZSAgYWNjZXNzIGhhcHBlbnMgZHVy
aW5nIGJvb3QgZm9yIHNvbWUgdGVncmEgcGxhdGZvcm1zIGxpa2UgamV0c29uIHR4MSwgdHgyLi4g
KEVnOiBJMkMgR1BJTyBleHBhbmRlcnMsIFBNSUMgYWNjZXNzLi4uKQ0KDQo+IDMpIEFmdGVyIGFw
cGx5aW5nIHRoZXNlIHBhdGNoZXMgSTJDIHRyYW5zZmVycyBhcmUgZmFpbGluZyBvbiBUZWdyYTIw
IHdpdGggInRlZ3JhLWkyYyA3MDAwYzQwMC5pMmM6IEZhaWxlZCB0byBhbGxvY2F0ZSB0aGUgRE1B
IGJ1ZmZlciIuIA0KVGhpcyBwYXRjaCBzaG91bGQgbm90IGNhdXNlIERNQSBidWZmZXIgYWxsb2Nh
dGlvbiBmYWlsdXJlIHRvIGhhcHBlbi4gQnV0IGlmIGFsbG9jYXRpb24gZmFpbHMgKGl0IGNvdWxk
buKAmXQgYWxsb2NhdGUgY29udGlndW91cyBwaHlzaWNhbCBtZW1vcnkgZm9yIHNvbWUgcmVhc29u
KSwgdGhlbiB0cmFuc2ZlcnMgd2lsbCBkZWZpbml0ZWx5IGZhaWwgd2l0aCB0aGlzIHBhdGNoLg0K
DQpXaWxsIHNlbmQgdXBkYXRlZCBwYXRjaCB3aXRoIG5vdCByZS1hdHRlbXB0IGFuZCBpbiBwcm9i
ZSB0byByZXR1cm4gb24gZXJyb3Igc28gaWYgaXQgd2lsbCBlaXRoZXIgZGVmZXIgb3IgZmFpbCBp
biBjYXNlIG9mIEVOT01FTS4NCg==
