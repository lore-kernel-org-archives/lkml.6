Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F684C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A842173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fNN+MIRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfBGSCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:02:33 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6926 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGSCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:02:33 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5c72a60000>; Thu, 07 Feb 2019 10:02:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 07 Feb 2019 10:02:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 07 Feb 2019 10:02:30 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb
 2019 18:02:30 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb
 2019 18:02:30 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.50) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 7 Feb 2019 18:02:30 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3125.namprd12.prod.outlook.com (20.178.54.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 7 Feb 2019 18:02:27 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 18:02:27 +0000
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
Subject: RE: [PATCH V14 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V14 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvlB3grXi65/4z0qjAfijKk4nv6XUXYuAgAAWpyCAAAwFgIAAAVQAgAAAQYCAAALgAIAAHL/Q
Date:   Thu, 7 Feb 2019 18:02:27 +0000
Message-ID: <BYAPR12MB33983F916E6DE23228B4EBD0C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <32b0b694-f912-044e-1a50-55b9c355d0c3@gmail.com>
 <BYAPR12MB3398350797241F90AE347FB5C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
 <0a7d62c4-9dcd-08dd-4e3f-877184848daa@gmail.com>
 <20190207160630.GB17445@ulmo>
 <BYAPR12MB3398D9CA36FCFF81BBC8E7B5C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
 <0b7963a4-ee9c-7296-1478-38235af7cd40@gmail.com>
In-Reply-To: <0b7963a4-ee9c-7296-1478-38235af7cd40@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3125;6:Th9zBfF3BvMdHio0HDAKfmJ7yZyT/+YQ1rm4l1OjBUIOiFTZuUTnLn6u3CIKr7312VPyR84ppu0w6fzyvq7p1UVH26A8gyAw5sOUvENO2EdA9N0xLrL9vkJBLx6bnV2yCfs/3KQdy5IOzhzA/OPWCa7Uy/38KnIF1Q/ZVigz3j+Jb1vZ8ntlgFwvmeUP/4CHHZp3Q8pYEvnyd0O0Jgfon7zbyRriMz4yLb0GtQ5yGIp9dapkUwVosXn5xwsRzlixnJxtoOylZiH4rRkUBjYCxJ7pFlioAQ3jq1vDeTM3z5JFhmD8kQFzQYhZ6ae2npWDt+1cJ9KUgAWnDfRmKWfhfyJJr0QGDzCUOL5PazFg1rUtn7JrDikkVvlIW6qIw5bYz3f+DIlrBCTqSmiiBmINn4zPytKKFKg8j6jf8PdMR+JHsZGsCs/YYPlqn7RPeFpERG+yWanc881GcKxuGw8GWw==;5:fMluJAHyUr8I09NFsuHhnjmzsHbO27HxeeLOWtwaNuKNGw7ZSdVf3lHJsLteMlLwYdhY52WQixBOM1cSOqSLOoUIpULaMyNzfkjN6KWYXsKGc2fFhA1mdFHYo0nioQp0sQwpFmfB2Wf4wyttr/+oWnFz9+F6TUp3/rWZojdvQlvFH+tddtfCBZVHTyN+FFNG/exRt3WfxlnGla0Dm0P3jQ==;7:IBh+6T9oSlLYJ7rs3Gw8KvDGSBitS9DEcfQbYVPUdexAMY9oZBVoCFvhwfAiXN7MZLv7yAfZDt0yNShDAigRjc/uZzzWRVDD2SaMW80wsKjR8Pp9j+GIQy8PXIYimJLfypjU7SpwLNQnVp/CRk1D1Q==
x-ms-office365-filtering-correlation-id: c2abc695-8e5e-4321-e8a7-08d68d266bdb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3125;
x-ms-traffictypediagnostic: BYAPR12MB3125:
x-microsoft-antispam-prvs: <BYAPR12MB31252FEB73F9B3C62B4E1A78C2680@BYAPR12MB3125.namprd12.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39860400002)(189003)(43544003)(199004)(76176011)(4326008)(33656002)(7696005)(186003)(97736004)(305945005)(74316002)(446003)(11346002)(99286004)(486006)(476003)(105586002)(25786009)(2906002)(26005)(256004)(14444005)(54906003)(6506007)(68736007)(102836004)(14454004)(316002)(81156014)(110136005)(93886005)(71200400001)(71190400001)(6246003)(53936002)(478600001)(8936002)(8676002)(81166006)(229853002)(7736002)(6436002)(6116002)(3846002)(86362001)(9686003)(55016002)(66066001)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3125;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f7KKUR1CTFEd8Av+6/lWkIG1EiYcWyLP8NPrlgWYk0ZAafliDrAcZtgcXfus7UftISPhjZ2gp/eepPDGxmbfiCsXilTOnCm+W/i39a02qD2LnYVKVBqmXR8q1av5XjA5Jbal0+pSB4yUTfeWBnx4TeQ1gtHs47e0qiWInAIxl0uOg5OFWoDPdabmH6k1t80zadNqdoTPnLL+I/vHJAI/M0WWCMaJiAyhNtsTpZpmycvVFif5rOyD/dSMpD++mZChHls34M6icd7dWHzUFRDB1fCq/zGyyVIwX3l3FEroYO8tTPFv4lEKpy94j1GtVcLb7jlnDmZXTsKeyU32R9h34oFsFPgLPEBbJ2DNK5+EOOC4JwUFqtxhHstNbSiGnqB4dgipUWnF7pvYQ9PfFhKf3Z3BZHBxc287sLaRezQJ/AI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c2abc695-8e5e-4321-e8a7-08d68d266bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 18:02:27.5950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3125
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549562534; bh=mZqrNwmgDYUfpiKarIZ89fpToRd1z+FgJmiXxRoYFTQ=;
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
        b=fNN+MIRdVa1QoclNvlHIzn++uZdncQeLP7K/wUX3HG6bm1NFuxIjgsJ8iK8WmHhPz
         zZ9Sqt9FvGN4ExB3eLtKixcrBZDEhq795dx+nsOnQzGpBJOsm55jf4i1lR12ormZI3
         GXqPm7T5ZqabSaPYigruzlVcysctZLWpSUfnf2CkC3y4biUt1irqdcYIHpVbk1L+KU
         fpWOYLREj8chEYGXi4N0ptgGGsR8XNmDYE39LEwnEJMvV9aVQjA/T9WNBV+pT7WkX/
         nAyOZekpZPIV9PvyNEMeocNQNcFZVZGgOZARxzFHV6Ade1pfHcTNQLenvxQZsut2oP
         9eaCkSwQe5nVA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4+Pj4+IEl0IGJlY2FtZSBhcHBhcmVudCB0byBtZSB0aGF0IHRoZXJlIGlzIGEgcHJvYmxl
bSBoZXJlLiBUaGUgc2l6ZSBvZiBkbWFfYnVmIGlzIDQwOTYgYnl0ZXMgYW5kIG1heGltdW0gbWVz
c2FnZSBsZW5ndGggaXMgNDA5NiB0b28sIHdlIGhhdmUgcHVzaGVkIDEyIGJ5dGVzIHBhY2tldF9o
ZWFkZXIgdG8gdGhlIGJ1ZmZlciA+YW5kIG5vdyB0aGVyZSBhcmUgNDA4NCBieXRlcyBsZWZ0IGZv
ciB0aGUgbWVzc2FnZSBpbiB0aGUgYnVmZmVyLiBIZW5jZSB0cmFuc2ZlciBvZiA0S0Igd2lsbCBj
YXVzZSBidWZmZXIgb3ZlcmZsb3cgYW5kIGVpdGhlciBjcmFzaCBrZXJuZWwgb3IgY29ycnVwdCBt
ZW1vcnkuIE9uZSBzb2x1dGlvbiBpcyB0byBqdXN0IGFsd2F5cyA+cHVzaCBwYWNrZXRfaGVhZGVy
IHVzaW5nIFBJTywgb3RoZXIgdG8gcmVkdWNlIG1heF93cml0ZV9sZW4gb3IgaW5jcmVhc2UgZG1h
X2J1ZiBzaXplLg0KPiA+Pj4+DQo+ID4+Pj4gWWVzLCBUaGlzIGlzIGtub3duIHRvIG1lIGFuZCBJ
IHdpbGwgYWRkIHNlcGFyYXRlIHBhdGNoIGZvciB0aGlzIHRvIA0KPiA+Pj4+IHVwZGF0ZSBxdWly
a3MgdG8gdGFrZSBjYXJlIGZvciB0MTg2IGFuZCB0MTk0IHRvIGV4Y2x1ZGUgcGFja2V0IGhkciBs
ZW5ndGhzIFRoZXJlIHdhcyBzZXBhcmF0ZSBwYXRjaCB3aGVuIHF1aXJrcyB3ZXJlIGFkZGVkIGFu
ZCBpdCBnb3QgbWVyZ2VkIGFscmVhZHkgZnJvbSA1LjAtcmMxIGJ1dCBkb27igJl0IHdhbnQgdG8g
c25lYWsgdGhhdCBoZXJlLiBXaWxsIHNlbmQgc2VwYXJhdGUgcGF0Y2ggdG8gdGFrZSBjYXJlIG9m
IHRoaXMuDQo+ID4+Pj4gTmVlZCB0byB1cGRhdGUgcXVpcmsgdG8gZXhjbHVkZSBwYWNrZXQgaGVh
ZGVyDQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBOby4gVGhpcyBpcyBhIGJ1ZyBvZiB0aGlzIHBhdGNo
LCBpdCBtdXN0IGJlIGZpeGVkIGluIHRoaXMgcGF0Y2ggYXMgd2VsbC4gDQo+ID4+Pg0KPiA+Pg0K
PiA+Pg0KPiA+PiBJJ20gbm90IHN1cmUgd2UgYWN0dWFsbHkgbmVlZCB0aGlzLiBNeSB1bmRlcnN0
YW5kaW5nIGlzIHRoYXQgaXQncyByZWFsbHkgdGhlIHBheWxvYWQgc2l6ZSB0aGF0J3MgNCBLaUIg
YW5kIDY0IEtpQiwgcmVzcGVjdGl2ZWx5LiBJIGRvbid0IHRoaW5rIHRoYXQgaW5jbHVkZXMgdGhl
IGhlYWRlci4NCj4gPj4NCj4gPj4gVGhpZXJyeQ0KPiA+IA0KPiA+IEFzIHBlciB0aGUgZGVzaWdu
LCBZZXMgdGhhdOKAmXMgaW5jbHVkaW5nIHRoZSBIRUFERVIuIEl0cyB0b3RhbCB0cmFuc2ZlciBw
ZXIgcGFja2V0IGluY2x1ZGluZyBoZWFkZXIuDQo+ID4gDQo+DQo+IE15IHVuZGVyc3RhbmRpbmcg
dGhhdCBJMkMncyBtYXggcmVhZC93cml0ZSBzaXplcyBxdWlya3MgYXJlIHRoZSBwYXlsb2FkIGxp
bWl0cywgYW5kIHNvIGV4Y2x1ZGluZyB0aGUgaGVhZGVyIHNpemUuIEhlbmNlIEknbSBub3Qgc3Vy
ZSB3aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIHNheSwgVGhpZXJyeS4NCj4NCj4gU293amFueWEsIGFs
c28uLiBpdCBzaG91bGQgYmUgZmluZSBpZiB5b3UnbGwgaW5jbHVkZSB0aGUgc2VwYXJhdGUgcGF0
Y2ggaW50byB0aGlzIHNlcmllcywgcGxhY2luZyBpdCBiZWZvcmUgdGhpcyBETUEtcGF0Y2guIEkg
anVzdCByZWFkIHlvdXIgbWVzc2FnZSBhcyAicGF0Y2ggc2VwYXJhdGVseSBmcm9tIHRoaXMgc2Vy
aWVzIi4NCg0KT0ssIFdpbGwgYWRkIHRoYXQgcHJpb3IgdG8gRE1BIHBhdGNoLiBWMTUgd2lsbCBp
bmNsdWRlIG1heCB0cmFuc2ZlciBsaW1pdCB1cGRhdGUsIGRtYSByZXNvdXJjZSByZWxlYXNlcyBv
biBwcm9iZSBmYWl1cmVzLCBhbmQgb3RoZXIgbWlub3IgZXJyb3JzIGluIFYxNCBmZWVkYmFjay4N
CldpbGwgd2FpdCBmb3IgYW55IG1vcmUgZmVlZGJhY2tzIGJlZm9yZSByZWxlYXNpbmcgVjE1Li4u
DQo=
