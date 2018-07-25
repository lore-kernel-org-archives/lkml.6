Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA06C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF76820844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="lBWB2DyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF76820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeGYJvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:51:54 -0400
Received: from mail-eopbgr50110.outbound.protection.outlook.com ([40.107.5.110]:20446
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728516AbeGYJvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ASc/WrLzAPhaLO2d475UJg5j+DjsGCYirbsugsL7z0=;
 b=lBWB2DyEc2rQVxQV9BmaO8n4V69tMY3l9t9WK9VQcyvDiZ0c3mGNmgqfq7kABMnPgIlEPRgS/K5vtXj4j9pG87z4c4+Apz5bLHFc234FMHknR1BvUrqufmtL2nzKsgDZhVVsMlhDZ8XSWpHjXPaAHvhYEN4neX+Ha7nol40LKsk=
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com (10.168.74.23) by
 DB6PR0501MB2341.eurprd05.prod.outlook.com (10.168.56.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Wed, 25 Jul 2018 08:40:58 +0000
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::24a6:f7a1:3235:a6b9]) by DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::24a6:f7a1:3235:a6b9%9]) with mapi id 15.20.0973.022; Wed, 25 Jul 2018
 08:40:58 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "digetx@gmail.com" <digetx@gmail.com>
CC:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 01/28] ARM: tegra: apalis_t30: enable broken-hpi on emmc
Thread-Topic: [PATCH 01/28] ARM: tegra: apalis_t30: enable broken-hpi on emmc
Thread-Index: AQHUIdwHffQ5dkRq20eMTdGpauMmpqSeaoIAgAAGhQCAAAfoAIABKcEA
Date:   Wed, 25 Jul 2018 08:40:58 +0000
Message-ID: <1532508056.6124.36.camel@toradex.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
         <1992775.WBgY65Ajyy@dimapc> <1532442416.6124.28.camel@toradex.com>
         <3879609.rmqHIZXFHx@dimapc>
In-Reply-To: <3879609.rmqHIZXFHx@dimapc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0501MB2341;6:y0VTgHMnEri5Htfx5swVLn0BjjxwSBGcuCR3pjx3nnJTUzD4zToaVrwQa9cO1EzVJRrj5chs9KI/M4Ax8RvGksPMVIBJCF+BCFzga7QNC/fg/YtJcxw1FguMGcgvjPEFODGSRGVD4vTOPEejc6Zo2evNsDQ7alzzLKHT9q02TAjzJfW3UDeP0xumQyx3XWdF1d2L+fhFkk2lqKgwN5Ny58PTF9fV6C6EpzvK1kSuNISaPTtcoBkbRtSeVxEkGkyx/gQFRaJiF+ZgAckMDze2xyyS/7HSoTWhEflLuEQE7PC9IiEb2leySwR6i/bKxTptcXPhVsvYIDrNJretM5s5ry8ZOzgcVf+YgWJ7TYHtXW/TKqTJn6KSAyd/sZyhmni0goQjPkHGBlaKQYoB+6xnotxSXJ0v/7B8NDfYMf3eNYSrED3M2aUB8v8nU4RftuP9vFeJv7cML7wz5mvFM9Wd1A==;5:c/RkaHBN3cSv68cJieBI7vLOd/+QRtAJLORVmkpRaH7W+5KExrc4eIYdn7vfNNVUJsRLfABViPvd6fA/JMyUs4H8olDliXEDdFhoGmf6ZZg/suz1XHbqV6+Lwu52xlq7q46RZxeb4SczaDOAw9HQR5uQsrCzvUj5cwA2u9ELs2Q=;7:JQ5ZtQ2cMo7EQAWJ/XV0XOCwbRwYrdMVSZ4cax1bCBqP/beTTtaIK1t2+j1MxXOI9vd0renzuvMm3cKBdeRKpliQNrWqkH/D2AdFZv7VSbgOHCyiy+gzjg6qIF92Q/GuqZEsBYAQ1hbrH+D85Ai/3kUIgxB6RpIE7Gc9FwvMDcMdCYWuTVm6SFPnEl2+UYtauN72VYkaJQV+w5PDEwZWjK7brNkpCnwnEOUOsYff/ZHdMxbVeAD4EA2caSXz8Xe/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7ecf3ec3-f9da-467c-68f1-08d5f20a57f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2341;
x-ms-traffictypediagnostic: DB6PR0501MB2341:
x-microsoft-antispam-prvs: <DB6PR0501MB2341CE4E80FD9B73FB83351FFB540@DB6PR0501MB2341.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0501MB2341;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2341;
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39840400004)(366004)(396003)(189003)(199004)(51914003)(7736002)(6246003)(186003)(6486002)(5250100002)(1411001)(53936002)(2501003)(229853002)(102836004)(8676002)(81156014)(1730700003)(66066001)(305945005)(81166006)(6506007)(2900100001)(99286004)(486006)(316002)(6916009)(446003)(86362001)(76176011)(6116002)(3846002)(2616005)(26005)(1361003)(256004)(14444005)(11346002)(5660300001)(476003)(54906003)(103116003)(6306002)(106356001)(105586002)(2906002)(966005)(4326008)(97736004)(36756003)(5640700003)(6512007)(25786009)(14454004)(93886005)(6436002)(478600001)(8936002)(2351001)(44832011)(68736007)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0501MB2341;H:DB6PR0501MB2583.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uNf+4Qo09+Qq/8+9MEiZe/DkeNUfv7t0KWarir0/fwUeWILKJ6PJZjQ83lDMdYWee74k83GumQzFuGcpRsdy5zLkVRjAFVcOEvRiqafIIRkKyBBzsL2udOWFmu9ejEd1WpTePoIxyRfB8qMFfzg+tN7YG/VfFU4hsM7YIg+qbhskWiP52z4JEbrs+1kIW5+iI0ajCRiET6V23ALVV3d+sZSQuvuEMmqBr5BBPYjVE8xcIzaRxgZf4Yk2hHA3ZJXNnsA0gO+ymiVSMOujWpym73TtO5NIBjFj3ukFrf4Z7BlucJb4la6iksUz4BHWEv9Ju3HIxEn0HsvgA5bT+an9P3CxfhUmvc//F+btXPX96rs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F26D79B050A77542BC31EC57EEA0129A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecf3ec3-f9da-467c-68f1-08d5f20a57f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 08:40:58.1373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2341
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTI0IGF0IDE3OjU1ICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
DQo+IE9uIFR1ZXNkYXksIDI0IEp1bHkgMjAxOCAxNzoyNjo1OCBNU0sgTWFyY2VsIFppc3dpbGVy
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOC0wNy0yNCBhdCAxNzowMyArMDMwMCwgRG1pdHJ5IE9z
aXBlbmtvIHdyb3RlOg0KPiA+IA0KPiA+ID4gT24gU3VuZGF5LCAyMiBKdWx5IDIwMTggMTk6NDk6
MDkgTVNLIE1hcmNlbCBaaXN3aWxlciB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBGcm9tOiBNYXJj
ZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gPiA+ID4gDQo+ID4g
PiA+IEF2b2lkIGVNTUMgaXNzdWVzIGJ5IHNwZWNpZnlpbmcgYnJva2VuLWhwaS4NCj4gPiA+ID4g
DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVy
QHRvcmFkZXguY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gLS0tDQo+ID4gPiANCj4gPiA+IA0KPiA+
ID4gSXMgaXQgYSBzcGVjaWZpYyBlTU1DIGNhcmQgbW9kZWwgdGhhdCBoYXMgYnJva2VuIEhQSSBv
ciBpdCBpcyBhDQo+ID4gPiBob3N0IA0KPiA+ID4gY29udHJvbGxlciBidWc/DQo+ID4gDQo+ID4g
DQo+ID4gVGhhdCBpcyBhIHZlcnkgZ29vZCBxdWVzdGlvbi4gU28gZmFyIHdlIG9ubHkgaGF2ZSBj
b25maXJtYXRpb24gdGhhdA0KPiA+IGF0DQo+ID4gbGVhc3Qgc29tZSBlTU1DcyBmcm9tIEh5bml4
IHJlc3AuIFNLSHluaXggZGVmaW5pdGVseSBkbyBoYXZlIGJhZA0KPiA+IGZpcm13YXJlLiBJIGFs
c28gZm91bmQgb3V0IHRoYXQgQVNVUyByZXNwLiBHb29nbGUgZGlkIGRpc2FibGUgSFBJDQo+ID4g
b24NCj4gPiB0aGVpciBOZXh1cyA3IHRhYmxldC4gVGhlcmVmb3JlLCB3ZSBhbHNvIGRpc2FibGVk
IEhQSSBxdWl0ZSBhIHdoaWxlDQo+ID4gYWdvDQo+ID4gaW4gb3VyIGRvd25zdHJlYW0gQlNQcyB3
aGljaCB3ZSBzdWNjZXNzZnVsbHkgdmFsaWRhdGVkICYgdmVyaWZpZWQNCj4gPiBkb2luZw0KPiA+
IHBvd2VyIGN1dHMgYW5kIHJ1bm5pbmcgc3RyZXNzIHRlc3RzIGluIG91ciB0ZW1wZXJhdHVyZSBj
aGFtYmVycy4gSQ0KPiA+IGd1ZXNzIHdlIHdvdWxkIGhhdmUgdG8gcnVuIG1vcmUgZXh0ZW5zaXZl
IHRlc3RzIHdpdGggbWFpbmxpbmUgd2l0aA0KPiA+IGFuZA0KPiA+IHdpdGhvdXQgdGhpcyBzZXR0
aW5nIHRvIGJlIGFibGUgdG8gcmVhbGx5IGFuc3dlciB5b3VyIHF1ZXN0aW9uLiBGb3INCj4gPiBu
b3cNCj4gPiBJIGp1c3Qgc3VjY2Vzc2Z1bGx5IHJ1biBhIGZldyBBcGFsaXMgVDMwIGFuZCBDb2xp
YnJpIFQzMCBtb2R1bGVzDQo+ID4gd2l0aA0KPiA+IHRoaXMgc2V0dGluZyBvdmVyIHRoZSB3ZWVr
ZW5kIGRvaW5nIGJvdGggaGRwYXJtIC10IGFzIHdlbGwgYXMgZGRpbmcNCj4gPiBzb21lIHVyYW5k
b20gZmlsZXMgdG8gdGhlIGVNTUMgaW4gYSBsb29wIHdpdGhvdXQgc2VlaW5nIGFueSBpc3N1ZXMu
DQo+IA0KPiBUaGUgYnJva2VuLWhwaSBxdWlyayB3YXMgYWRkZWQgZm9yIHRoZSBIeW5peCBjYXJk
cyBzcGVjaWZpY2FsbHkgaW4NCj4gWzBdLiBNYXliZSANCj4geW91IHNob3VsZCBqdXN0IGV4dGVu
ZCB0aGUgbW1jX2V4dF9jc2RfZml4dXBzIGxpc3QgaW4gWzFdIHdpdGgNCj4gYW5vdGhlciBPRU0g
SUQ/DQo+IA0KPiBbMF0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85MTY4NDU1
Lw0KPiBbMV0gZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaA0KDQpBaCwgaW50ZXJlc3RpbmcsIHNv
bWVob3cgSSBtaXNzZWQgaG93IHRoYXQgd29ya3MuIExldCBtZSBnaXZlIHRoYXQgYQ0KdHJ5IGFu
ZCBpZiBpdCBkb2VzIHdvcmsgSSBtYXkgbWFrZSB1c2Ugb2YgdGhpcyBpbiBhIHYyLg0KDQpUaGFu
a3MgZm9yIHRoZSB0aXAsIERtaXRyeS4=
