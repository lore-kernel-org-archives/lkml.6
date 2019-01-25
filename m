Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA2AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7648C218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aV/pvNlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfAYVMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:12:01 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7945 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYVMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:12:01 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4b7b9d0001>; Fri, 25 Jan 2019 13:11:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 13:11:58 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 25 Jan 2019 13:11:58 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 21:11:58 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 21:11:57 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.52) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 25 Jan 2019 21:11:58 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3429.namprd12.prod.outlook.com (20.178.196.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Fri, 25 Jan 2019 21:11:55 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 21:11:55 +0000
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
Thread-Index: AQHUtCaoqz5N11EqJkeckmeQlifKWKXAYa0AgAANI4CAAAUtAIAAAiXg
Date:   Fri, 25 Jan 2019 21:11:54 +0000
Message-ID: <BYAPR12MB33982ED3A9EC34819D2490F8C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-3-git-send-email-skomatineni@nvidia.com>
 <dcc1e094-638e-5b04-7a61-bdbc24ee068f@gmail.com>
 <BYAPR12MB339829FC6F2F95F833FE45A1C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <ad177c2e-3801-ddad-b359-ac83530ee1d6@gmail.com>
In-Reply-To: <ad177c2e-3801-ddad-b359-ac83530ee1d6@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3429;6:WEXOlMlAgQf9W9K/ACOGTU2tPi6oMvP/2/aN7ipspq9evN2pcPlbvfZ4cMlQC/UHE311o9CmgWdpJrSAoiouTR0NZvhVajE+5UHypdJgYvE0mqVn32u6MY9dRs10oUir/OC0hJxN9hHZ9DWUF4/y1d3BgxpXcWyUhEs8MyohTDFHINs5wMLP2geUn5IJL+X/0pcTq0zeLW6O9qVzLPHEZXIJteOPpeCcAwYj6ibrJJKAyVSw/ZzxL+BanJxdbF1xRvFHCajX6+cch/L8/0RZroaIejWyPrjIt/Ju96aJh3kKGtdyAayhSvGVy74PfG9JoiQbvXgvx5VGyNVi+ZlJXqhSn5osBF4uwcqMkSvMaMUu8mafbfclbaEf6E8UOyL5EDxatqOrm1awwYW+2jimGq5EPAttjn0B3Q/dMAjaA8u3KEnaLwU+tYed//M/naKLn0JunjeHVMqz88dSevmiHw==;5:Gr82GkpkQ17gyUCgT0srWbd5NX6MkG7EZI5IJ+7NSYfa5bqKvJuVwwLyMqNuaVC9rs7MVy4+uVi1os2qofkCYzsj1q51EEmM5GvXzk673xVoLq3obxJi9cI9Ut3FBQ0omqt+aS0tcxBf7bkaoMy/dozDNNoSOMNTsbXbVdimXP+yIjrmPkWS1yhpPWtyfFRbh3dgvIav22HWtFe1jZqM6A==;7:XVaZJY9tP1fhkpzppyL21cHO/CO63gCUGUrRMt+wyu1p4G0HCfBzAYkEqJAEL0h2SIub1cSGmNtYcMeLBTKca/znkNIK6gP9HgnUMHKNm9y6gBeikuBzrLmOtLNGdKoFodlqwn9tobnEtP7gdzVFRw==
x-ms-office365-filtering-correlation-id: 24d2b9a4-525d-41a5-ea36-08d68309bbf4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3429;
x-ms-traffictypediagnostic: BYAPR12MB3429:
x-microsoft-antispam-prvs: <BYAPR12MB3429AD4FFB53AAC4A2C2C253C29B0@BYAPR12MB3429.namprd12.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(39860400002)(396003)(189003)(199004)(81166006)(81156014)(186003)(39060400002)(8936002)(478600001)(6116002)(66066001)(4326008)(25786009)(26005)(8676002)(6246003)(33656002)(74316002)(446003)(229853002)(256004)(14444005)(71200400001)(71190400001)(53936002)(6636002)(9686003)(11346002)(55016002)(476003)(3846002)(68736007)(6436002)(7736002)(305945005)(99286004)(105586002)(106356001)(54906003)(110136005)(14454004)(6506007)(86362001)(2906002)(76176011)(97736004)(93886005)(7696005)(102836004)(2501003)(486006)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3429;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: egVbakzs8tUM6Qzx39NRtUaiXYXf3QlRDgAeRjPys0LEJz9RGoq9bb6iRP60ePoIUhVr+fjxH7WSYOXZUaB7e9hkRk/ik6pAYgQTw945weftEJxW/E+0Y04XMpKkI0IiCjX0jEaWPuEnmbhD+wwXqeuBsRYoHSdv3Ku7pUXwJFtj3qWUrNWsw0YPI9aqS2sJhOKWsXJRyh/SRErzeSHO/XrmvoH6sz+s7Pc1u1bzcIGgmuMwhwJ/fuoYODn2451uYkb5ONM20H5avFeubMLkHUMpLj3ihqzkL4D256EjFeEfHU1rAA4GG/hv5N2p8gvZ2ZtXCq41XJ6hqQYk2CQ3xqvQIJ/ESExQcTuzY+CN1kJ5fl35RceDa1ZIJc3iBeDVR/vSxRFdH9oUssaGCYi6Q3MKH6UAEjF/p+5OCPmRrWI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d2b9a4-525d-41a5-ea36-08d68309bbf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 21:11:54.8776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3429
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548450718; bh=c5L97r+II8vVQlSK5zkxrSLgDJulOLC1OjYKLtT7JWs=;
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
        b=aV/pvNljX9zBszd77xcmd9Yb/pxZ9JHFE/jHrE3CokcCTYfJ/cytRIqXssbRFEpfU
         5OetP2B4JI0cGsfREjbACaeZ4um76o6azaHmfoHraoCRZ50V2YKSxdFr8IpubCSSVo
         MWEgj5K+yCqMIL4XQre7iQW2ZmBzgHV64h1SqZNEh5zUfi3CrZseS/P/mZHycebL6m
         hQpnHBZoiAihPhYI5yyKNiCuA3gffbpCKHmhHEtJmP1beYU5dWUrDA4tLIYjHauzbl
         xjcpC7dek256HygUDrPVtaUYl6X/eGXYHUCMuDPbHnV5fRX451LXJJ5wU833Znkyrj
         g8v0Ml2yplWuQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPj4+ICsJaWYgKGkyY19kZXYtPmhhc19kbWEpIHsNCj4gPj4+ICsJCXJldCA9IHRlZ3Jh
X2kyY19pbml0X2RtYV9wYXJhbShpMmNfZGV2LCB0cnVlKTsNCj4gPj4+ICsJCWlmIChyZXQgPT0g
LUVQUk9CRV9ERUZFUikNCj4gPj4+ICsJCQlnb3RvIGRpc2FibGVfZGl2X2NsazsNCj4gPj4+ICsJ
CXJldCA9IHRlZ3JhX2kyY19pbml0X2RtYV9wYXJhbShpMmNfZGV2LCBmYWxzZSk7DQo+ID4+PiAr
CQlpZiAocmV0ID09IC1FUFJPQkVfREVGRVIpDQo+ID4+PiArCQkJZ290byBkaXNhYmxlX2Rpdl9j
bGs7DQo+ID4+DQo+ID4+IFNvIHRlZ3JhX2kyY19pbml0X2RtYV9wYXJhbSgpIGNvdWxkIGZhaWws
IHByaW50aW5nIGEgZXJyb3IgbWVzc2FnZSwgYW5kIHByb2JlIHdpbGwgc3VjY2VlZD8gSWYgYWxs
b2NhdGlvbiBmYWlscyBkdXJpbmcgdGhlIGRyaXZlcidzIHByb2JlLCB0aGVuIGp1c3QgZmFpbCB0
aGUgcHJvYmUuIFBsZWFzZSBnaXZlIHRoZSByYXRpb25hbGUuDQo+ID4gDQo+ID4gSWYgQVBCIERN
QSBwcm9iZSBkb2VzbuKAmXQgaGFwcGVuIHByaW9yIHRvIHRlZ3JhIGkyYywgRE1BIGlzIG5vdCBh
dmFpbGFibGUgYnkgdGhlIHRpbWUgdGVncmFfaW5pdF9kbWFfcGFyYW0gdHJpZXMgdG8gcmVxdWVz
dCBzbGF2ZSBjaGFubmVsIGFuZCBpbiB0aG9zZSBjYXNlcyBkbWFfcmVxdWVzdF9zbGF2ZV9jaGFu
bmVsX3JlYXNvbiB3aWxsIHJldHVybiBFUFJPQkVfREVGRVIgZm9yIHRlZ3JhIEkyQyBwcm9iZSB0
byByZXRyeQ0KPiA+IA0KPiA+IEluIGNhc2UgaWYgRE1BIGlzIGF2YWlsYWJsZSBidXQgRE1BIGJ1
ZmZlciBhbGxvY2F0aW9uIGZhaWxzLCB0aGVuIHRlZ3JhX2kyY19pbml0X2RtYV9wYXJhbSByZXR1
cm5zIEVOT01FTSBhbmQgcHJvYmUgYWxzbyBmYWlscyByZXR1cm5pbmcgc2FtZSBFTk9NRU0NCj4N
Cj4gSXMgdGhhdCB3aGF0IHlvdSdyZSBnb2luZyB0byBjaGFuZ2UgaW4gdGhlIG5leHQgdmVyc2lv
bj8gWW91ciBjdXJyZW50IHZhcmlhbnQgb2YgdGhlIGNvZGUgZG9lc24ndCBmYWlsIHRoZSBwcm9i
ZSBvbiBFTk9NRU0gYW5kIHRoZXJlIGlzIGR1cGxpY2F0ZWQgYXR0ZW1wdCB0byBpbnZva2UgdGVn
cmFfaTJjX2luaXRfZG1hX3BhcmFtKCkgZHVyaW5nIHRoZSB0cmFuc2Zlci4NCg0KU29ycnkgY29y
cmVjdGlvbiB0byBteSBwcmV2aW91cyByZXBseS4gIElmIERNQSBidWZmZXIgYWxsb2NhdGlvbiBm
YWlscywgdGVncmFfaTJjX2luaXRfZG1hX3BhcmFtIHJldHVybnMgRU5PTUVNIGJ1dCBwcm9iZSB3
aWxsIHN1Y2NlZWQgYXMgaTJjIHRyYW5zYWN0aW9uIG5lZWQgdG8gaGFwcGVuIGR1cmluZyAgYm9v
dCBmb3Igc29tZSBwbGF0Zm9ybSBkZXZpY2UgcHJvZ3JhbW1pbmcgZm9yIHN1Y2Nlc3NmdWwgYm9v
dCBhbmQgdGhleSB1c2UgUElPIG1vZGUgYXMgeGZlciBieXRlcyBpcyBsZXNzIGFuZCBkZWZlcnJp
bmcgaTJjIHByb2JlIGZvciBFTk9NRU0gY2F1c2VzIGJvb3QgdG8gZmFpbCBzbyBkdXJpbmcgcHJv
YmUgRVBST0JFX0RFRkVSIGlzIG9ubHkgdGFrZW4gY2FyZS4NCg0KUmUtYXR0ZW1wdCBvZiB0ZWdy
YV9pMmNfaW5pdF9kbWFfcGFyYW0gaW4geGZlciBoYXBwZW5zIG9ubHkgaWYgbm8gc3VjY2Vzc2Z1
bCBETUEgY2hhbm5lbCBhbGxvY2F0aW9uIGhhcHBlbnMgcHJpb3IgdG8gdGhhdCAoIGR1cmluZyBw
cm9iZSBpbiBjYXNlIG9mIEVOT01FTSkuDQpETUEgbW9kZSBpcyBtYWlubHkgZm9yIGxhcmdlIHRy
YW5zZmVyLCBhbmQgaTJjIHhmZXIgcmV0dXJuaW5nIGZhaWx1cmUgZHVlIHRvIGZhaWxpbmcgRE1B
IGJ1ZmZlciBhbGxvY2F0aW9uIGNhdXNlcyBib290IHRvIGhhbmcgYXMgcGxhdGZvcm0gZGV2aWNl
IHByb2dyYW1taW5nIG5lZWQgdG8gaGFwcGVuIHdoaWNoIGRvZXNu4oCZdCBuZWVkIHRvIHVzZSBE
TUEuDQpXaWxsIGZpeCB0aGlzIGFuZCB3aWxsIHNlbmQgdXBkYXRlZCBwYXRjaCB0byByZWF0dGVt
cHQgRE1BIHJlcXVlc3QgYW5kIGJ1ZmZlciBhbGxvY2F0aW9uIGR1cmluZyBETUEgbW9kZSB0cmFu
c2ZlciBhbmQgd2lsbCByZXR1cm4gZmFpbCBmb3IgRE1BIG1vZGUgSTJDIHRyYW5zZmVyLi4uDQoN
ClRoYW5rcw0KU293amFueWENCg==
