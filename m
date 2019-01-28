Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092BEC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BFE2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sSRlz/Vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfA1WcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:32:03 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14352 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfA1WcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:32:02 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4f82b60000>; Mon, 28 Jan 2019 14:31:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 28 Jan 2019 14:32:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 28 Jan 2019 14:32:00 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 22:31:57 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.58) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Mon, 28 Jan 2019 22:31:57 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3384.namprd12.prod.outlook.com (20.178.55.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Mon, 28 Jan 2019 22:31:54 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 22:31:54 +0000
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
Thread-Index: AQHUtStT3b8oUo3Te0iK36R9j5w2yqXB2CeAgAMogjCAAED+AIAAALuggAAEfYCAAABVIA==
Date:   Mon, 28 Jan 2019 22:31:54 +0000
Message-ID: <BYAPR12MB33987472C6645951C0F1968BC2960@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
 <1548475073-12408-2-git-send-email-skomatineni@nvidia.com>
 <0cf91475-f77d-7453-deb6-3dd91b63aeb6@gmail.com>
 <BYAPR12MB3398E9D32B57B0E2FC2A6466C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
 <c0b36535-6767-7327-5dc5-612e6957a769@gmail.com>
 <BYAPR12MB339837E896774531B0D11A98C2960@BYAPR12MB3398.namprd12.prod.outlook.com>
 <2f3cab66-7424-1b33-976f-826877623726@gmail.com>
In-Reply-To: <2f3cab66-7424-1b33-976f-826877623726@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3384;6:JJJurupvUWaiH5Uh49z0E7VTuc9JjBmq7n3n/cMj21vQExXjaFiLINfkKXevpL/2F7uniRevjJzX640v0PojhRZTvLJgv53qoX1HWMXJDU7G8p/q1AwteFcgoP1sf9B2StkfkRxTQ9uEonyiyxo2TAWQnjSKXZF3MnVnDTaJYsx+1/tO5XcwKvQm2yoKPPqAkAFLHvQqW02uaRKMhBn8TtRjAhktie+BHQvgqCDTyHPV0tdzqtOh6UfHfGl6mJ7swftJQ7bR/aYwJuOhMN1gkMoH/K05/wsoAKwl4dl12wLaf5+LM0mR2JV+l4uoyPb85KhtXYEb/xDs0xf7wY9MXZER8sfYM+57uWWrz8d0an91kVOgW4Aak5WSeA7eygI9TZyL9eIZgeaP1yUgqfYrftFUP5B5CyMr8yBBxg8zynuERqgfqcDWnqAkb7YwVpsUeon5uTUDEK9Uu74pYh+pEw==;5:XinddulKiBzofFirTduiVYBwyqOF2dWM4x5+mSXSgOIbUBveS+OwieS/DHjg5RUCiJYeb7rf0oPtc5lxUyx9tzS+1fkKNnIfmSUnei3au+BFDklZysjkBiqMpCXC/raXhR+Yv2DugI1vJOybt7cs70ObV7OM7whWmM8YcX8ED0wRS0RbiB+RmhhMupv+RfBOAhHM+4uuXowfiza2lS3uxg==;7:PiKenWg0mBs/idCR4F3nVAnCq0hLlRE2TuV0jL/1MuCx8NwXrfQW8mk58TcfjR5I84eqJWHjy8YAvrGew0oJ8mCYFOSXbzinezkIcUM7kSUEk6tDiZdnUYmtXXAELDdQD+3ttAtNsPwMeZu71pTvLA==
x-ms-office365-filtering-correlation-id: 4ee40aff-70e7-493f-b71e-08d685706805
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3384;
x-ms-traffictypediagnostic: BYAPR12MB3384:
x-microsoft-antispam-prvs: <BYAPR12MB33841749461748485FFFFE53C2960@BYAPR12MB3384.namprd12.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(189003)(199004)(6246003)(186003)(26005)(53936002)(54906003)(110136005)(6636002)(76176011)(14454004)(316002)(7696005)(39060400002)(74316002)(68736007)(105586002)(102836004)(6506007)(66066001)(486006)(33656002)(106356001)(478600001)(9686003)(6436002)(229853002)(2906002)(99286004)(4326008)(8676002)(55016002)(93886005)(305945005)(71200400001)(71190400001)(25786009)(14444005)(6116002)(3846002)(8936002)(476003)(86362001)(81156014)(2501003)(15650500001)(11346002)(446003)(81166006)(256004)(7736002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3384;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zF36jetooibe9Vnf0j2mqmzC2QK+o401XvefWdY0hSmLWHH823Si/ev/F6rnMFGKpxuvKEPeTw+2GRRZlcYz6vW2E6LlU1q7Fqxh2y+jForfoqTDWFswd0C9XlD/iwSKGegqJbGM/3j8wpwciwgGZHa0WyDMkA0xKOMWDbvYO79FB16p0PbmHr50sN3ZoeCcD1WsVJ3Rk3GwRA6tlcb05KgKCbXbKdBh5hIy8RCHEhWXDT4emfHeEOAxBQnOBCxHAcoyyhILI7VxQ2MWd8ueKExHs3gzmW30Lz86AEcBSDUpaAq+ppfHesiIKyUHH8kWY1nIozOY2Iwh+CSviAm+OgR+VCAajMZtnKaYC4sp0RwAv+qel3u8Exg/O0Ee0oDBLQlW7CSSjFThh8IDxWqWRv3WzRhwMtjqdVCQmKvWxhg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee40aff-70e7-493f-b71e-08d685706805
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 22:31:54.5769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3384
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548714681; bh=bB7uRx2bJE95fEaI096bRmnjrQjyyURXWl1n4HYY2H4=;
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
        b=sSRlz/Vb4M9buKXVsjdksFRFQF0867UMNVE0yDqm96BUSGzfpPYhxIc/vwtOjuaLl
         2myuVJ7IVk3UukPxs+xQtILjpuix5SG+YqkNaifacYdBqOz1pCL1cJquuaoWcDpIXj
         IH+AsdnaRTlmP9wm2URBDz4yxasCaRTHN9x/H0hg89Z5J0KGW7bXkMBZjEe3gMBDsq
         t4JZeRzYG9hiugmDKIvttamXe6pmC7NhgTkgpWvrPtCjFGLAjJ6o8qi/vMnjJhmIZW
         xyEy8qP29XfznIfpYb/XEnowxmMqo/g+C0Q5xW8hRqCxW5hwXxXh4MD+0PKJWbU7xl
         vhRsu6/RUYBYg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPj4+Pj4gVXBkYXRlIEkyQyB0cmFuc2ZlciB0aW1lb3V0IGJhc2VkIG9uIHRyYW5zZmVy
IGJ5dGVzIGFuZCBJMkMgYnVzIA0KPiA+Pj4+PiByYXRlIHRvIGFsbG93IGVub3VnaCB0aW1lIGR1
cmluZyBtYXggdHJhbnNmZXIgc2l6ZSBiYXNlZCBvbiB0aGUgc3BlZWQuDQo+ID4+Pj4NCj4gPj4+
PiBDb3VsZCBpdCBiZSB0aGF0IEkyQyBkZXZpY2UgaXMgYnVzeSBhbmQganVzdCBzbG93bHkgaGFu
ZGxpbmcgdGhlIHRyYW5zZmVyIHJlcXVlc3RzPyBNYXliZSBiZXR0ZXIgdG8gbGVhdmUgdGhlIHRp
bWVvdXQgYXMtaXMgYW5kIGFzc3VtZSB0aGUgd29yc3QgY2FzZSBzY2VuYXJpbz8NCj4gPj4+Pg0K
PiA+Pj4gVGhpcyBjaGFuZ2UgaW5jbHVkZXMgbWluIHRyYW5zZmVyIHRpbWUgb3V0IG9mIDEwMG1z
IGluIGFkZGl0aW9uIHRvIGNvbXB1dGVkIHRpbWVvdXQgYmFzZWQgb24gdHJhbnNmZXIgYnl0ZXMg
YW5kIHNwZWVkIHdoaWNoIGNhbiBhY2NvdW50IGluIGNhc2VzIG9mIHNsYXZlIGRldmljZXMgcnVu
bmluZyBhdCBzbG93ZXIgc3BlZWQuDQo+ID4+PiBBbHNvIFRlZ3JhIEkyQyBNYXN0ZXIgc3VwcG9y
dHMgQ2xvY2sgc3RyZXRjaGluZyBieSB0aGUgc2xhdmUuDQo+ID4+DQo+ID4+IE9rYXksIEkgc3Vw
cG9zZSBpbiByZWFsaXR5IHRoaXMgc2hvdWxkbid0IGJyZWFrIGFueXRoaW5nLg0KPiA+Pg0KPiA+
PiBQbGVhc2UgZXhwbGFpbiB3aGF0IGJlbmVmaXRzIHRoaXMgY2hhbmdlIGJyaW5ncy4gRG9lcyBp
dCBmaXggb3IgaW1wcm92ZSBhbnl0aGluZz8gVGhlIGNvbW1pdCBtZXNzYWdlIG9ubHkgZGVzY3Jp
YmVzIGNoYW5nZXMgZG9uZSBpbiB0aGUgcGF0Y2ggYW5kIGhhcyBubyB3b3JkIG9uIGp1c3RpZmlj
YXRpb24gb2YgdGhvc2UgY2hhbmdlcy4gVHJhbnNmZXIgdGltZW91dCBpcyBhbiBleHRyZW1lIGNh
c2UgdGhhdCBkb2Vzbid0IGhhcHBlbiBvZnRlbiBhbmQgd2hlbiBpdCBoYXBwZW5zLCB1c3VhbGx5
IG9ubHkgdGhlIGZhY3Qgb2YgdGltZW91dCBtYXR0ZXJzLiBJZiB0aGVyZSBpcyBubyByZWFsIHZh
bHVlIGluIHNob3J0ZW5pbmcgb2YgdGhlIHRpbWVvdXQsIHdoeSBib3RoZXIgdGhlbj8NCj4gPiAN
Cj4gPiBPcmlnaW5hbCB0cmFuc2ZlciB0aW1lb3V0IGluIGV4aXN0aW5nIGRyaXZlciBpcyAxU2Vj
IGFuZCBpbmNhc2VzIG9mIHRyYW5zZmVyIHNpemUgbW9yZSB0aGFuIDEwS2J5dGVzIGF0IFNURCBi
dXMgcmF0ZSwgdGltZW91dCBpcyBub3Qgc3VmZmljaWVudC4NCj4gPiBBbHNvIFRlZ3JhMTk0IHBs
YXRmb3JtIHN1cHBvcnRzIG1heCBvZiA2NEsgYnl0ZXMgb2YgdHJhbnNmZXIgYW5kIHRvIGFsbG93
IGZ1bGwgdHJhbnNmZXIgc2l6ZSBhdCBsb3dlc3QgYnVzIHJhdGUgaXQgdGFrZXMgYWxtb3N0IH41
LjggU2VjLg0KPiA+IEluIGNhc2VzIGlmIGxhcmdlIHRyYW5zZmVyIGF0IGxvdyBidXMgcmF0ZXMg
MSBTZWMgdGltZW91dCBpcyBub3QgZW5vdWdoIGFuZCBpbiB0aG9zZSBjYXNlcyB0cmFuc2ZlcnMg
d2lsbCB0aW1lb3V0IGJlZm9yZSBpdCB3YWl0cyBmb3IgY29tcGxldGUgdHJhbnNmZXIgdG8gaGFw
cGVuLg0KPiA+IA0KPiA+IFNvIHRoaXMgcGF0Y2ggdXNlcyB0cmFuc2ZlciB0aW1lIGJhc2VkIG9u
IHRyYW5zZmVyIGJ5dGVzIGFuZCBidXMgcmF0ZS4NCj4gPiANCj4NCj4gUGxlYXNlIGFkZCB0aGF0
IHRvIHRoZSBjb21taXQgbWVzc2FnZS4NCj4NCj4gQW5kIHRoZW4gc2VlbXMgeW91IGFsc28gbmVl
ZCB0byBzZXQgSTJDIGFkYXB0ZXIgdGltZW91dCB0byBhIHNvbWUgbGFyZ2VyIHZhbHVlLiBDdXJy
ZW50bHkgVGVncmEncyBJMkMgZG9lc24ndCBleHBsaWNpdGx5IHNwZWNpZnkgdGhlICJhZGFwdGVy
LnRpbWVvdXQiIGFuZCBJMkMgY29yZSBzZXRzIGl0IHRvIDEgc2Vjb25kIGlmIGl0IGlzIDAuDQoN
ClRoYW5rcyBEbWl0cnkuIFdpbGwgZG8gb24gbmV4dCB1cGRhdGUgb2YgdGhpcyBwYXRjaC4uLg0K
DQo=
