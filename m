Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E3EC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A47B21872
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rP2YurRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbeLRNgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:36:25 -0500
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:29664
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbeLRNgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Bpb/5p5LK0RA2pWKLjBcf6/F6zUWBRHPUFVPMradIc=;
 b=rP2YurRPwFCCAg4LcPp6c1QhkMNOPPGzWNu7V5xgPCFB96g+1d8b5SDrYITa5leUklUZ1JoMcwY2ukRTMirbj4cJ/q1WIx700GlxcDFDQhvflQYQMay4cAEetb905L2uUwVKnjDCG4d7MG4pDVCImDZrw3LvAGq0UJLN3QHdedw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3692.eurprd04.prod.outlook.com (52.134.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Tue, 18 Dec 2018 13:35:41 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.023; Tue, 18 Dec 2018
 13:35:41 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>
CC:     Fabio Estevam <festevam@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
Thread-Topic: [PATCH] clk: imx: add CLK_GET_RATE_NOCACHE flag for i.MX8M
 composite clock
Thread-Index: AQHUln02eAG5Z54Wc0mB2eSSS/znh6WESrGAgAAEigCAADDtEQ==
Date:   Tue, 18 Dec 2018 13:35:41 +0000
Message-ID: <7E78DD25-BA90-4EBA-81B9-755CD89BD0BF@nxp.com>
References: <1545101396-16335-1-git-send-email-Anson.Huang@nxp.com>
         <CAOMZO5BX6PWBp_FmTsMkZJEsKpf+=N6Zyn8P_+ziis-fKR37Ng@mail.gmail.com>,<1545129634.5874.20.camel@pengutronix.de>
In-Reply-To: <1545129634.5874.20.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.23.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3692;6:fO8wFWJwSvZUAbBzg/WV0yASnmoDvwgTD0JFnWtKI2HRx/L/0G+ZPOZ2te7UPl7EVPyh/Ukw5NPPASMC7qTaOR9D/kJwq/DQ1RoXntWOPfrs4u0JOBLN8J0/8uzsCCLFde2Sq26uLg4dPw8ADEeluMsq+6kgVlYoAxD0jjb6iGOQcThmf3p01a6Lx2XuT1BBLfk9ckq32m39bioAg0FZ/sjt5sy3YnvCc/GT6VWREGt/z2/oF0X86eXAVWwvPEtdUryNDZ5zPdpNJgcTSwgaoHCEUf/B7ckpWYf2CIG8JyIP+K7sB/J0vrrS4Rb3lSbX0/kWa/37W+hsQFfgWy30Epgt0bTXPczJihgvrZ8c9UjkaBTAMekKxuUtSYtrHrJkrLFR4a56tfiE0P+G11V8AP/nqERS8w7/TdffSJ1jKJCLWPXRLc2L8Qfl3L3RHn9t15oxc2uT+vK0ZTZXXPvrtQ==;5:0WQhu2Akhr+OcaZEr6tuYXEZAE7mefoFgLVdTY8nZlNntqH2lB+tIlDP/dJLVJYKrUPkhZNWgU2p5Oy1J7ArADvFi1YcVpGphH8qWG5Avv+DANDobtwbW5xj9ndM49ZLS6GgOrrqXBApu53YSBabSrNeX+1NhJ6qaIgfXUo/FZo=;7:pjfvN2DigYyNTxqYdq/OZWJzMakZC9xm5+ss0UhjI8EcTSRPVgyc8HOy09SI1Nb0mCxacFCiaIXQSBJ7I7qGbtodoUWYDKAVaY1XgcMOMLpBguSn8OTQtWo6aN7N4Lc3WYlSjdkhlvWp6NqVRsm0NQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1e342ffa-6c4e-4ea6-43a3-08d664edb45a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3692;
x-ms-traffictypediagnostic: DB3PR0402MB3692:
x-microsoft-antispam-prvs: <DB3PR0402MB36928F76A8B7B432486F3CDDF5BD0@DB3PR0402MB3692.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3692;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3692;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(316002)(39060400002)(54906003)(6486002)(4326008)(25786009)(68736007)(99286004)(6436002)(305945005)(81166006)(229853002)(14454004)(5660300001)(8676002)(81156014)(6916009)(8936002)(33656002)(478600001)(36756003)(6246003)(7416002)(53936002)(7736002)(86362001)(76176011)(6506007)(2906002)(53546011)(83716004)(102836004)(71200400001)(6512007)(6116002)(71190400001)(3846002)(256004)(14444005)(66066001)(186003)(11346002)(446003)(2616005)(476003)(486006)(106356001)(97736004)(44832011)(105586002)(82746002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3692;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OwIAwYWXtHEbPeybfCXbu7ZVIDBZZbi0V73KpysWKm67G2h5NcQvwOMpAtRLDK8ourZ/dulqzyTNOn2SXqGCxOh7Hgm2gplutjfDhoCPRzr+Ip/NMwDmJvvxPil/dGomtcoGkW7/r4E08vrWfhbpB02Dqyb0C7bo5yuImprh08tBwGY/P7QWoUQZO57yOhQh9Zk1ZcJdVqfsAe0NNfmayt3IqCI0sB+asKVdIIpOdOR4BeAwKcNuSKxPW28VFSOYfZ7jYhes6Flu3CGEmPKczC6WScB2c7uJLD12NcFS3jSINpv/6YiPemWCdMjbESyD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e342ffa-6c4e-4ea6-43a3-08d664edb45a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 13:35:41.3563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEx1Y2FzDQoNCkZyb20gQW5zb24ncyBpUGhvbmUgNg0KDQoNCj4g5ZyoIDIwMTjlubQxMuac
iDE45pel77yMMTg6NDDvvIxMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4g5YaZ
6YGT77yaDQo+IA0KPiBBbSBEaWVuc3RhZywgZGVuIDE4LjEyLjIwMTgsIDA4OjI0IC0wMjAwIHNj
aHJpZWIgRmFiaW8gRXN0ZXZhbToNCj4+IEhpIEFuc29uLA0KPj4gDQo+PiBPbiBUdWUsIERlYyAx
OCwgMjAxOCBhdCAxMjo1NiBBTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4+
IHdyb3RlOg0KPj4+IA0KPj4+IE9uIGkuTVg4TSwgc29tZSBvZiB0aGUgYnVzIGNsb2NrcycgcmF0
ZSBjb3VsZCBiZSBjaGFuZ2VkIGluIFRGLUEsDQo+PiANCj4+IERvIHlvdSBtZWFuIEFURiAoQVJN
IFRydXN0ZWQgRmlybXdhcmUpIGluc3RlYWQ/DQo+IA0KPiBURi1BIGlzIHRoZSBuYW1lIG9mIHRo
ZSBkYXkgZm9yIHdoYXQgd2FzIGZvcm1lcmx5IGtub3duIGFzIEFURi4uLg0KPiANCj4gSG93ZXZl
ciBJIGRvbid0IHRoaW5rIHRoYXQgaXQncyBjb3JyZWN0IHRvIGp1c3QgZG9uJ3QgY2FjaGUgdGhl
IGNsb2NrDQo+IHNldHRpbmdzLiBOb3JtYWxseSB0aGUgc2VjdXJlIHdvcmxkIGZpcm13YXJlIHNo
b3VsZCBub3QgY2hhbmdlIGFueQ0KPiBjbG9jayBzZXR0aW5ncyBhdCBydW50aW1lLCBvciBpdCB3
b3VsZCBydW4gaW50byBhbGwga2luZHMgb2YgY29uZmxpY3RzDQo+IHdpdGggdGhlIGNsb2NrIGRy
aXZlci4gU28gdGhlcmUgYXJlIHByb2JhYmx5IHNvbWUgd2VsbCBrbm93biBwb2ludHMgaW4NCj4g
dGltZSBsaWtlIGEgc3VzcGVuZCBvciByZXN1bWUgZXZlbnQgd2hlbiB0aGUgZmlybXdhcmUgbWln
aHQgY2hhbmdlDQo+IGNsb2NrIHNldHRpbmdzLCBzbyB3ZSBjb3VsZCBpbnN0ZWFkIHVzZSB0aG9z
ZSB0byB0cmlnZ2VyIGFuIGV4cGxpY2l0DQo+IGludmFsaWRhdGUgb2YgdGhlIGNsb2NrIGNhY2hl
cyB3aXRoIG11Y2ggbG93ZXIgb3ZlcmhlYWQuDQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KDQpU
aGVyZSBpcyBidXMtZnJlcSBmZWF0dXJlIG9uIGlteDhtIHdoaWNoIGlzIHRvIHNjYWxlIGRkciBj
bG9jaywgdGhpcyBpcyBkb25lIGluIEFSTSBUcnVzdGVkIEZpcm13YXJlLCBmb3Igc29tZSBzZXRw
b2ludHMsIHRoZSBERFIgUExMIGNsb2NrIHJhdGUgbXVzdCBiZSBjaGFuZ2VkIGRpcmVjdGx5IGlu
IFRGLUEsIGJ1dCBpdHMgY2hpbGQgY2xvY2sgbGlrZSBkcmFtIGNvcmUgaXMgdW5hd2FyZSBpbiBM
aW51eCBrZXJuZWwsIHNvIHRoZSBjbG9jayByYXRlIHdpbGwgbWlzbWF0Y2ggd2l0aCBoYXJkd2Fy
ZSwgc2luY2UgZGRyIHJlbGF0ZWQgY2xvY2tzIHdpbGwgTk9UIHVzZWQgYnkgYW55IG1vZHVsZSBp
biBMaW51eCBrZXJuZWwsIHNvIGl0IHdpbGwgTk9UIGludHJvZHVjZSBhbnkgY29uZmxpY3QuDQoN
ClJlZ2FyZGluZyBhYm91dCB0aGUgb3ZlciBoZWFkLCB5ZXMsIHRoZSBjaGFuZ2UgaW4gY29tbW9u
IGNvbXBvc2l0ZSBjbG9jayByZWdpc3RlciBoYXMgdG9vIG1hbnkgb3ZlciBoZWFkIGZvciBvdGhl
ciBjbG9ja3MsIHdoYXQgaWYgSSBPTkxZIGhhdmUgZHJhbSBjb3JlIGNsb2NrIHRvIHBhc3MgdGhl
IENMS19HRVRfUkFURV9OT0NBQ0hFIGZsYWcgdG8gcmVnaXN0ZXIgdGhlIGNvbXBvc2l0ZSBjbG9j
az8NCg0KQW5zb24u
