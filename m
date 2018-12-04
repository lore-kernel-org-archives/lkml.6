Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AC4C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1382081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="PjGZSobU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1382081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeLDByt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:54:49 -0500
Received: from mail-eopbgr1400112.outbound.protection.outlook.com ([40.107.140.112]:33184
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbeLDBys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R7JWbGlZlQYo6tYC8WlKVUMubWbPvhU/9mtraxO4tI=;
 b=PjGZSobUVHaRxblD+dPzXE8jkLXsJ68rjQFSrCWycnf9PUsG28iboYnjlZW9HsMRc+IDIf/GSi+oJK+v/nwXvN1+75YEwsjH/T9D+WKayaV+GrnIWpSjJC9PsZunPEtIu2h07gO8BiTDYmgYRy1NDoYkdLH1WgLOF7U3ALqNWHs=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYASPR01MB0011.jpnprd01.prod.outlook.com (20.178.137.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 01:54:43 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 01:54:43 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     "jiada_wang@mentor.com" <jiada_wang@mentor.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-next v2 6/6] ASoC: rsnd: add avb clocks
Thread-Topic: [PATCH linux-next v2 6/6] ASoC: rsnd: add avb clocks
Thread-Index: AQHUi3RTAIWPM4c4I0q7pds6+gkqEQ==
Date:   Tue, 4 Dec 2018 01:54:43 +0000
Message-ID: <87mupm2hgd.wl-kuninori.morimoto.gx@renesas.com>
References: <20181203112427.18324-1-jiada_wang@mentor.com>
In-Reply-To: <20181203112427.18324-1-jiada_wang@mentor.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0104.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::20) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYASPR01MB0011;20:nZGAY24OrYq4iLHKO/tWUYcnvj36xKHFQCOO0zAsD6XBLpPfubf4vXnS7YT6K/icuPPoMDrG6Z3zlQu4YS7lU2f2gOgBV/X7fiyivjbk0cNCuzuv6H1aIGzgeFZRhNPLZI044amd2t0G9LY7pA6ifnb41NNFZNGKbC2kO0kAtH4=
x-ms-office365-filtering-correlation-id: 1b56dcdb-1fc0-4ed0-1520-08d6598b7600
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYASPR01MB0011;
x-ms-traffictypediagnostic: TYASPR01MB0011:
x-microsoft-antispam-prvs: <TYASPR01MB001114A84A72DDEBB7853597D4AF0@TYASPR01MB0011.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TYASPR01MB0011;BCL:0;PCL:0;RULEID:;SRVR:TYASPR01MB0011;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(346002)(376002)(136003)(189003)(199004)(5640700003)(229853002)(478600001)(102836004)(6506007)(6916009)(386003)(6512007)(105586002)(2351001)(53936002)(14454004)(6246003)(71190400001)(2906002)(71200400001)(575784001)(6436002)(6116002)(3846002)(99286004)(52116002)(26005)(186003)(4326008)(86362001)(76176011)(6486002)(25786009)(14444005)(66066001)(256004)(486006)(11346002)(2616005)(476003)(5660300001)(446003)(305945005)(7736002)(8936002)(68736007)(81156014)(54906003)(106356001)(8676002)(81166006)(316002)(2501003)(36756003)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:TYASPR01MB0011;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lClL/HytVGsR4AYhqtWpeJ5DXqi3c8FeyvVgiOm50cUCKEagWRLEI2tCmk/utFF0N3gUerd2NRIj2IjGJNdvPGJxi9pPYgGjVCB+dttKw96GD7Pwq5RNams3Y2cWgpfqfBWW1vHzAww/TXJih8PUygGl0725QYfQ9JAnDAkh7Pogq7ijhGtS4VRfaha0jrloVHsnpaDUlSYTZ7eQA1SOomcWyccj1UOs4OsslNAsaS+j+kHzPU/DgP1Q4shV98G1Oe86dfxHgC5mA1RgAnLY3V8WlX9H4Z/n3CeCbCpEpB7tATjGnuo6eoMxDqUujM2dhTfi0A6vwPOdaC/JcMuu9gTjnt0SW/7tMwf08frdwS4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <056E9E466B1CAA49B17C11C6C9C631A6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b56dcdb-1fc0-4ed0-1520-08d6598b7600
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 01:54:43.7239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYASPR01MB0011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpISSBKaWFkYQ0KDQo+IFRoZXJlIGFyZSBBVkIgQ291bnRlciBDbG9ja3MgaW4gQURHLCBlYWNo
IGNsb2NrIGhhcyAxMmJpdHMgaW50ZWdyYWwNCj4gYW5kIDggYml0cyBmcmFjdGlvbmFsIGRpdmlk
ZXJzIHdoaWNoIG9wZXJhdGVzIHdpdGggUzBEMc+VIGNsb2NrLg0KPiANCj4gVGhpcyBwYXRjaCBy
ZWdpc3RlcnMgOCBBVkIgQ291bnRlciBDbG9ja3Mgd2hlbiBjbG9jay1jZWxscyBvZg0KPiByY2Fy
X3NvdW5kIG5vZGUgaXMgMiwNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppYWRhIFdhbmcgPGppYWRh
X3dhbmdAbWVudG9yLmNvbT4NCj4gLS0tDQo+ICBzb3VuZC9zb2Mvc2gvcmNhci9hZGcuYyAgfCAz
MDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICBzb3VuZC9zb2Mv
c2gvcmNhci9nZW4uYyAgfCAgIDkgKysNCj4gIHNvdW5kL3NvYy9zaC9yY2FyL3JzbmQuaCB8ICAg
OSArKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAzMTUgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMo
LSkNCg0KUGxlYXNlIHVwZGF0ZSBEVCBiaW5kaW5nIHR4dCwgdG9vDQoNCkJlc3QgcmVnYXJkcw0K
LS0tDQpLdW5pbm9yaSBNb3JpbW90bw0K
