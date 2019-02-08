Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A71FC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541A02146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pMBvuUDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfBHRxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:53:38 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:4801 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfBHRxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:53:37 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5dc21d0000>; Sat, 09 Feb 2019 01:53:33 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 09:53:31 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 08 Feb 2019 09:53:31 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 17:53:29 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 8 Feb 2019 17:53:29 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3062.namprd12.prod.outlook.com (20.178.54.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 17:53:06 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 17:53:06 +0000
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
Subject: RE: [PATCH V16 4/6] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V16 4/6] i2c: tegra: Add DMA support
Thread-Index: AQHUv829t7ouq5xahU+WuWRXTJjcy6XWHr8AgAAA/ACAAAGHIIAABIiAgAABPkCAAAJXAIAAALaAgAADy6A=
Date:   Fri, 8 Feb 2019 17:53:06 +0000
Message-ID: <BYAPR12MB33987C73B01ACDC11CFAFE6DC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549644314-1481-1-git-send-email-skomatineni@nvidia.com>
 <1549644314-1481-4-git-send-email-skomatineni@nvidia.com>
 <dd2899ab-1a5f-834c-ab97-1654845c7de2@gmail.com>
 <BYAPR12MB33980494FB2E5C439210124FC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33987BF143F5903AE5DA196AC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <4ba38a07-1953-9393-8756-ce555557017a@gmail.com>
 <BYAPR12MB33984E76B8BE19ED0CB0BE17C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
 <3ac41d68-976d-4674-9a31-708195d58eeb@gmail.com>
 <a4cfa59f-39d0-4a80-bbdd-d558d2d09dcc@gmail.com>
In-Reply-To: <a4cfa59f-39d0-4a80-bbdd-d558d2d09dcc@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3062;6:52W1x7UEh0e/yltv46vYCXQP9GtPEoDRp6e/Wnp1zar8xTSXaNq5pbNp55wmftzafFSjIsqC8ebePMvY66epjX+dgslpj0vKbf1NYoyqDSp4gD//UrrH59gTd2dmNZF81iE5CfGlQMrs6iyPPo2Vsc+b9ulw1StswgyK/VwdjncNDgM2vLP03+ps5uoqawgohz376eMwUo4BxjjnqEZtCGGjaHgS2+jI+9o6KpIMSRUbrbOKEJkpNlR/aDIvwMKn+t6IBdglQPfIPGQDvsPMMSn3LkuF1Cin16yL6p1YenQ1OgyAMDkzKMI2xrRPLQopEEKqON1ST3AisfCkaSH3JO/d6VZ2AE9a7StMg/uRBP+Tg5QokUgMeGTAmIcCIKFIn5MDlVRDxUSWp9DOMmO3KzZ8tBy4pYruvhZf97Yhv8tgspBQdw02jMXL+yqGCT3E3+USbOMFIfXuCacS6Q2bQg==;5:J8kXZ+qMIp5ezGNJwdU20nDr7fIMCPRBG/CtTr4tucjbsbsVnzYPOWeJBnJspNLDgDI759wz+L0XViHDVCdkZyXqdNOvnynwcgEO4r99hBxxdUjy2fM4kTdfYgH0xr27zAZrOlBKZ2ffkEOP/kLKgW1KqEjzrFCTx6CW+AltRiPmxFVAt8ua79AJG1IKfXv6494DrzpNd0MAHzY5Bib76w==;7:+xm5q1ntXwm74dxAzPPqvZ0/ix5ArVCljW7/W2WwyqnFhji4h5FPJeRA1sYATq4OAgE9+1OOehUlKyLep1lITg4PQ+MuvCaeeZevdjotWUexeQxdkYM+C5qX8RYpEUmJcgemmbLvfxX6gTrJffbLEg==
x-ms-office365-filtering-correlation-id: acc05a2d-23eb-4eea-a9ae-08d68dee47f8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3062;
x-ms-traffictypediagnostic: BYAPR12MB3062:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR12MB30626B3C7D7B7BE4117C9965C2690@BYAPR12MB3062.namprd12.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(7736002)(14454004)(25786009)(86362001)(305945005)(33656002)(93886005)(7696005)(186003)(8936002)(74316002)(316002)(66066001)(6636002)(966005)(478600001)(6436002)(229853002)(446003)(4326008)(8676002)(81166006)(11346002)(6506007)(2906002)(54906003)(110136005)(9686003)(6306002)(81156014)(55016002)(26005)(6246003)(106356001)(3846002)(6116002)(105586002)(102836004)(486006)(76176011)(14444005)(256004)(53936002)(99286004)(68736007)(476003)(2501003)(97736004)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3062;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8qn8SEHx89356Tn5mIE63xzKJByht7rH20/D7X7UKUfMhUNLpf63aWPIIXK74AF5Cnj5KJpzmr4+58i+6EDCvpLWT9S27UZs7d2KvWzJidpPUvnhXguolOJXqoavXNKjPUtvCmTvaxcBgS9jYL1YZvgOakMKHyqOgrsj1GUYSh2CTOuh5Zpt6sl6UbU2SMndCAiQ7quBX4xjXJCpfx0L6LIUT71MvvSNZlc/oco2lenQEsf4U1faG2xuXwDm/YRrXktr7UUDEIvK9hqRiBR6KVPepy03/UCvFDwdu7LhRiWPKMBj45U/olFYGjRcXaSDhXzkdUx6/Vun/Be/bJJAH3CnrrJ9jB1rOlM81c44/qbYyv9vF+wOqKaO59oZA2v5T5xqB/t7Xff5vFHZ8o9wwfVfDGzaX1jRcdVckKkDrC4=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: acc05a2d-23eb-4eea-a9ae-08d68dee47f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 17:53:06.6333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3062
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549648414; bh=nPHXZv9R/aQz81ES3DtWZo8HivsHFNiewdKHwJhJmrg=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-ms-exchange-purlcount:
         x-microsoft-antispam-prvs:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=pMBvuUDQZLWXCq9hqJce2ciQO166uJdiLx26ME/2DHFnR8TozHmFNSyffSgPKqfYD
         F2RuZm+hDA8AQLltDl0q6j362kW5KuaTTh11swIaoo81zHb5Q4Gf0zMLFuRwgET2kK
         kJgo2Tt3Tv7e2kN49yrCVadl4nvc1hEI5EUWsGcLX6GBrLScx0a8NJ81eTJjcTa4rk
         7HLYY3GdWoGXkLf+PxMxbDbuDibAIQRLNVOREY3qzzAjfOhVCxPYUgm5Z997uHCamO
         p1X+mClLp9cMqeRYQdBb0lEGG2fohgaP3dQXLRj+IJb17/hxLnLAkjCgmjfwDuyGAk
         bpvFPdVmCS0yA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4+DQo+ID4+Pj4+IEknbSBzdGlsbCBhbHNvIHN1Z2dlc3RpbmcgdG8gc3F1YXNoICJmaXgg
bWF4aW11bSB0cmFuc2ZlciBzaXplIiBpbnRvIHRoaXMgcGF0Y2ggYmVjYXVzZSBpdCBpcyByZWFs
bHkgcGFydCBvZiBETUEtc3VwcG9ydCBlbmFibGluZy4NCj4gPj4+Pg0KPiA+Pj4+IE1heCB0cmFu
c2ZlciBsZW5ndGggbGltaXRzIGFwcGx5IHRvIFBJTyBhbHNvIGJ1dCBmb3IgRE1BIGl0cyBtb3Jl
IG5lZWRlZCB0byBwcmV2ZW50IGNyYXNoLg0KPiA+Pj4+IFNvIGhhZCB0aGlzIGFzIHBhdGNoIGJl
Zm9yZSBETUEgYXMgaXRzIGFwcGxpY2FibGUgZm9yIGJvdGggRE1BICYgUElPLg0KPiA+Pj4NCj4g
Pj4+IE9oLCBzbyB0aGUgcGFja2V0X2hlYWRlciBzaXplIGFsc28gc2hhbGwgYmUgZXhjbHVkZWQg
Zm9yIHRoZSBQSU8gYXMgd2VsbCwgcmVhbGx5PyBJdCBsb29rZWQgdG8gbWUgdGhhdCBQSU8gZG9l
c24ndCBoYXZlIHRoYXQgcmVzdHJpY3Rpb24gYW5kIHdlIG9ubHkgbmVlZCB0byBleGNsdWRlIHRo
ZSBoZWFkZXIgc2l6ZSBmb3IgRE1BLi4NCj4gPj4+DQo+ID4+Pj4gV2UgZXhjaGFuZ2VkIG9uIHRo
aXMgeWVzdGVyZGF5LCBzbyB0aG91Z2h0IHRoZSByZWFzb24geW91IHdhbnQgdG8gc3F1YXNoIHNl
cGFyYXRlIHBhdGNoIGFuZCBpbmNsdWRlIGluIHRoaXMgaXMgZHVlIHRvIG1heCBtc2cgbGVuIGxp
bWl0IGFuZCB3aGVuIG1vdmVkIGludG8gaHcgZmVhdHVyZS4NCj4gPj4+DQo+ID4+PiBJZiBQSU8g
bGltaXRzIGFyZSBpbmNvcnJlY3QsIHRoZW4gaXQncyBhYnNvbHV0ZWx5IGZpbmUgdG8gZG8gaXQg
aW4gdGhlIHNlcGFyYXRlIHBhdGNoLiBJIHByb2JhYmx5IGp1c3QgbWlzdW5kZXJzdG9vZCB5b3Vy
IHBvaW50Lg0KPiA+Pj4NCj4gPj4+PiBTb3JyeSBzaG91bGQgaGF2ZSB2ZXJpZmllZCBiZWZvcmUg
c2VuZGluZy4gUGxlYXNlIGNvbmZpcm0gaWYgSSBsZWF2ZSBtYXggdHJhbnNmZXIgYXMgc2VwYXJh
dGUgcGF0Y2ggb3IgYWRkIHRvIHRoaXMgRE1BIHN1cHBvcnQuIFdpbGwgdXBkYXRlIGFsb25nIHdp
dGggZG1hIGJ1ZiBzaXplIGZpeC4NCj4gPj4+Pg0KPiA+Pj4+IEJ1dCBtYXggdHJhbnNmZXIgbGlt
aXQgYXBwbGllZCB0byBQSU8gYWxzbyBhbmQgdGhhdOKAmXMgd2h5IGFkZGVkIGl0IGJlZm9yZSBE
TUEgcGF0Y2ggdG8gc2hvdyBpdHMgZGVwZW5kZW5jeQ0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gQW5k
IHRoZW4geW91IG5lZWQgdG8gZXhwbGljaXRseSB0ZWxsIGluIHRoZSBjb21taXQgbWVzc2FnZSB0
aGF0IFBJTyBsaW1pdHMgYXJlIGluY29ycmVjdC4NCj4gPj4gQ29tbWl0IG1lc3NhZ2Ugc2F5cyBU
ZWdyYSBJMkMgbWF4IGxpbWl0IHBlciBwYWNrZXRzIHRyYW5zZmVyIG1lYW5pbmcgdGhhdOKAmXMg
aW50ZXJmYWNlIHRyYW5zZmVyIGxpbWl0IHNvIGFwcGxpZXMgdG8gYm90aCBQSU8gJiBETUEuDQo+
ID4+IFdpbGwgYWRkIGV4cGxpY2l0bHkgaW5kaWNhdGluZyBhcHBsaWNhYmxlIGZvciBib3RoIFBJ
TyAmIERNQSB0byBiZSBtb3JlIGNsZWFyDQo+ID4gDQo+ID4gVGhhbmsgeW91Lg0KPiA+IA0KPiA+
Pj4NCj4gPj4+IEl0IGFsc28gcHJvYmFibHkgd29ydGggdG8gYWRkIGEgc3RhYmxlLXRhZyB0byB0
aGUgY29tbWl0IG1lc3NhZ2UgdG8gcmVxdWVzdCBiYWNrcG9ydGluZyBvZiB0aGUgbGltaXRzLWZp
eGluZyBwYXRjaCB0byB0aGUgc3RhYmxlIGtlcm5lbHM6DQo+ID4+Pg0KPiA+Pj4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4+DQo+ID4+IFNvcnJ5IEkgYW0gbmV3IHRvIHVwc3RyZWFt
IHN1Ym1pc3Npb25zLiBCeSBhZGRpbmcgc3RhYmxlLXRhZyB0byBjb21taXQgbWVzc2FnZSwgZG8g
eW91IG1lYW4gZXhwbGljaXRseSBtZW50aW9uaW5nIHRoaXMgcGF0Y2ggYXBwbGljYWJsZSB0byBv
bGQga2VybmVsIGFuZCBhZGRpbmcgaW4gcGF0Y2ggQ0Mgc3RhYmxlQHZnZXIua2VybmVsLm9yZz8N
Cj4gPj4NCj4gPiANCj4gPiBZb3UganVzdCBuZWVkIHRvIGFkZCAiQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmciIHRvIHRoZSBjb21taXQgbWVzc2FnZSwgbGlrZSB5b3UgZGlkIGZvciB0aGUgIlJl
dmlld2VkLWJ5OiIuIERvbid0IGFkZCAic3RhYmxlQHZnZXIua2VybmVsLm9yZyIgdG8gdGhlIGVt
YWlsIHJlY2lwaWVudHMuIFNlZSBmb3IgZXhhbXBsZSBbMF0uIA0KPiA+IA0KPiA+IFswXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTAwMTk5MS8NCj4gPiANCj4NCj4g
QW5kIHllcywgaXQgd2lsbCBtZWFuIHRoYXQgcGF0Y2ggaXMgYXBwbGljYWJsZSBmb3Igb2xkZXIg
a2VybmVscy4NCg0KVGhhbmtzIERtaXRyeS4gQWRkZWQgQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCkFsc28gaGFzIHRvIHVzZSA2NTUzNSBpbnN0ZWFkIG9mIDY0SyBiZWNhdXNlIHdoZW4gYnVm
IHNpemUgaXMgY29tcHV0ZWQgdXNpbmcgbWF4X3dyaXRlX2xlbiB3aXRoIGFkZGl0aW9uIG9mIHBh
Y2tldCBoZWFkZXIgaXQgd2lsbCBiZSBleGFjdCA2NEsgYnV0IG1heCBtc2cgbGVuIGlzIDY1NTM1
DQpTbyAxIGJ5dGUgbGVzcyA2NEsgc2hvdWxkIGJlIE9LDQoNClNvd2phbnlhIA0K
