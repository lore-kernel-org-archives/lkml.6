Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE43C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA92263B0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bYePz5PQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA92263B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935083AbeFZBGr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:06:47 -0400
Received: from mail-ve1eur01on0086.outbound.protection.outlook.com ([104.47.1.86]:1138
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755760AbeFZBGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joE1HHNvr+ZRJJ2BEdgQTyP4U2zdtJxckMv4hAY9vvQ=;
 b=bYePz5PQfOf0Cl6mpOih5No5ZfsWN7E1yHT0gCuyITB2N0dhpEo4bvOaDed6uz7pOYNAwQ8Er1UQ4DbDWs981iaA2eh+Fq7Z8p5MEJDu8lkNwpMLt/5bG8sgxSWtf9+1xJEKKdJ/5H3qp1gbAQqDBOeVX85dP4w/7fo4kw1fbKU=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB498.eurprd04.prod.outlook.com (10.242.114.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Tue, 26 Jun 2018 01:06:40 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%6]) with mapi id 15.20.0884.023; Tue, 26 Jun 2018
 01:06:40 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
Thread-Topic: [PATCH] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
Thread-Index: AQHUCfLfKDUUhkiOuEq/46i3GmnVi6Rw6o2AgADVSoA=
Date:   Tue, 26 Jun 2018 01:06:40 +0000
Message-ID: <AM3PR04MB13157D44DC7357CFB2F35948F5490@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1529648932-4832-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Coi-LRXG8vepnm-eSSx75LLEtsZ90WrtK6rEy76u+OBQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Coi-LRXG8vepnm-eSSx75LLEtsZ90WrtK6rEy76u+OBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB498;7:yYUkou4L59ymrSSbaQxFgxundVkfdJAb+AksO27h7su+OE2zH/pnMCe3YjVyNHlhvPuMHH55uK0sw41IqM+TgThiO4bK8gxY7k/5m/AgjzsRyr87Rsn5cRt6iOyjD+m0eOzLGtQyEzGXB1TLpv67tKeBwQFTb72ZSkz2myi6HFj/bhCz/GvCKoKumwjC3pyvam2thzSwtiprbhtTQbpVJurfq54BeROjdGkcAywJo6uB/4Dr8o/QfEubHNxHhXhY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4e7345d1-79b2-4f16-0e08-08d5db011336
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB498;
x-ms-traffictypediagnostic: AM3PR04MB498:
x-microsoft-antispam-prvs: <AM3PR04MB49834CAC97CC3A76EC56E72F5490@AM3PR04MB498.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB498;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB498;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(13464003)(6246003)(5660300001)(6916009)(7736002)(305945005)(68736007)(14454004)(2906002)(2900100001)(74316002)(6436002)(53936002)(55016002)(86362001)(14444005)(256004)(33656002)(9686003)(446003)(97736004)(11346002)(476003)(486006)(25786009)(229853002)(39060400002)(4326008)(26005)(186003)(106356001)(102836004)(99286004)(53546011)(6506007)(105586002)(54906003)(3846002)(44832011)(6116002)(316002)(1411001)(8676002)(81166006)(8936002)(81156014)(478600001)(76176011)(5250100002)(7696005)(66066001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB498;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P0wZu6oNPWURyCkgYUYaqIQ3d887bpzMoUQHvPVttj/fBWa58WamocEaEj1p+WRiX+BEjsv6/keoK/oVhhQvLEUZazdYO4BCuJqgXEworDDdSL21nTR7zDT/rJ/bhMYLN18w7WAB8D+Xf0ASVnYlYCTB7NEM2vArMJq1U3LBv/9pCaqTA4yx2j5AGV3sh1vbm+F8QuGyVyAnnx7VQUXhXcBB86Q7Mmlws/0f0m2dUAv3HWNFflm//BpzFkAbBcGHzk8LhRl7FCkhCIYyB9Oqkjj+bz91rO5jFX9MzoQf3sJLfNHXrZMJ0Oh1PFmQ/fILRI4+Jx3VwdWDWG3RMWtJBGsJLzhOr05yVSMjLqgJ7vw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7345d1-79b2-4f16-0e08-08d5db011336
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 01:06:40.5459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB498
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1A
Z21haWwuY29tXQ0KPiBTZW50OiBNb25kYXksIEp1bmUgMjUsIDIwMTggODoyMyBQTQ0KPiBUbzog
QW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBTaGF3biBHdW8gPHNoYXdu
Z3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+
OyBTYXNjaGEgSGF1ZXIgPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvDQo+IEVzdGV2YW0g
PGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+
Ow0KPiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgb3BlbiBsaXN0Ok9QRU4g
RklSTVdBUkUgQU5EDQo+IEZMQVRURU5FRCBERVZJQ0UgVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsg
bW9kZXJhdGVkIGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMNCj4gQVJNIEFSQ0hJVEVDVFVS
RSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgbGludXgta2VybmVsDQo+
IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBB
Uk06IGR0czogaW14NnNsbC1ldms6IG1ha2UgcGZ1emUxMDAgc3c0IGFsd2F5cyBvbg0KPiANCj4g
SGkgQW5zb24sDQo+IA0KPiBPbiBGcmksIEp1biAyMiwgMjAxOCBhdCAzOjI4IEFNLCBBbnNvbiBI
dWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4gT24gaS5NWDZTTEwgRVZL
IGJvYXJkLCBQRnV6ZTEwMCdzIFNXNCBpcyBzdXBwbHlpbmcgTFBERFIzLCBpdCBuZWVkcyB0bw0K
PiA+IGJlIGFsd2F5cyBvbi4gVGhpcyBwYXRjaCBmaXhlcyBMaW51eCBrZXJuZWwgYm9vdCB1cCBo
YW5nIGNhdXNlZCBieSBTVzQNCj4gPiBiZWluZyB0dXJuZWQNCj4gPiBvZmY6DQo+ID4NCj4gPiBb
ICAgIDEuNjkzNjEzXSBjZmc4MDIxMTogZmFpbGVkIHRvIGxvYWQgcmVndWxhdG9yeS5kYg0KPiA+
IFsgICAgMS43MDAwNjNdIFNXNDogZGlzYWJsaW5nDQo+ID4gWyAgICAxLjcwMzk3M10gU1dCU1Q6
IGRpc2FibGluZw0KPiANCj4gSXQgd291bGQgYmUgbmljZSB0byBtZW50aW9uIGluIHRoZSBjb21t
aXQgbG9nIHdoYXQgd2FzIHRoZSBwYXRjaCB0aGF0IGNhdXNlZA0KPiB0aGUgYnJlYWthZ2UsIGp1
c3QgbGlrZSBSb2JpbiBkaWQgZm9yIGlteDZzbC1ldmsuDQo+IA0KPiBUaGFua3MsDQogDQpEb25l
LCBhbHJlYWR5IHNlbnQgb3V0IFYyIHBhdGNoLCBwbGVhc2UgcmV2aWV3IGl0LCB0aGFua3MuDQoN
CkFuc29uLg0KDQoNCg==
