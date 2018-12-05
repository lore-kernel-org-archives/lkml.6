Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39490C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EDF20834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hnwck0yS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EDF20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeLEBO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:14:56 -0500
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:31968
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725979AbeLEBO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad/Nh4sGlCMYJ8f/cN0cMcg4DcXE7WUX7sFOXPRW23E=;
 b=Hnwck0yS4T+Kw0jPQD54O02nObFut5/eg+cr70LLckADOjDU4g5Au0xinnmL5MwZVgRuVG89ZDVtjgAwT0w8aglzulaf3iW9WnWljGXXScof7myvh40treVGus0YFPfg6iK033bY+lagUJ39gDm5ddWKpbeXlZRS+k4V1kY+yhs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3785.eurprd04.prod.outlook.com (52.134.71.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 01:14:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 01:14:51 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx6qdl-sabresd: add egalax touch screen
 support on i2c2 bus
Thread-Topic: [PATCH] ARM: dts: imx6qdl-sabresd: add egalax touch screen
 support on i2c2 bus
Thread-Index: AQHUi67sJwvwp2WEqEW/kmuV/wO8IaVuXjqAgAD6JlA=
Date:   Wed, 5 Dec 2018 01:14:51 +0000
Message-ID: <DB3PR0402MB3916CF664E069CB81550B5F0F5A80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543913303-6216-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5D_GTWvLUjJaPSmhPqgjadJh_4pTZqHKz92=1ZAeYkstg@mail.gmail.com>
In-Reply-To: <CAOMZO5D_GTWvLUjJaPSmhPqgjadJh_4pTZqHKz92=1ZAeYkstg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3785;6:WTk4U3BoYSbusJQyHMjgjKu0De1UtoKRw604lLMK8diLGXSOkG3Lx110ydaJbWLUh8yclN44D/+ZtQV1ZDyodmqbTvzrbDU6k/J0N2MWaZhoUNmJ/z1xbAWlwBiW3fJA8pfYh13SoJR0b57C5dHOCB53xAOG1ywldXGcDOqPDZ95TpMNnKDc45Mb/DD9Mz2AfXSHwkYzLuj5OwftD/9fYvjcP/Jf1DzeElRbjiwSzM0KIydZVurpI4trITRG1blZcBjaktJRV7su2KQYqL0J+EkUkCW28HWa4yogKCimHng2RfGDFmhAe0Ttr2t4J9X29lE2GOWzg3ATStS9WArLHadz/BNe5ohaeEh4J4imdppR6orj5RshZ74BcdGd21H4CN9K0LlARzEkVE2EzKjnGdU0A1nclo7SLMPx7rij9HnAFoHnlYN615pmAc9o3eglmWBNijBAFWIh3X5iQLhM7A==;5:omcgXOXgQguJKLxedTYdXFMgFV0iXUJmKIBVmypJ0ANf8pqXEVTlWiDk4v9UU95nkfRWtElG1yUx9bc//NQo05RDj2iwvfvWI6/ufZkg6C95ZX5z4k5a5z+NI3shrmzmwCgi/85k4VrIgFNTx2vJdcsJYIwm5EOJ1SjiuybF0L0=;7:v8drgnoVTVxnurqDfPoyfmbOebXGDo6NzO6/yqI5ewHz3GTTE5tzXQd/mkTwDdrISZu6QNSy6kwRDQ+bx/vtlj1TwHFtCawHbv8At2cg9YKBlVNtHMkwnnHJBHE59idhMAERYnhuI0yoEv7FS4wmEg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ccb5705c-58ef-45d6-93fe-08d65a4f0eed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3785;
x-ms-traffictypediagnostic: DB3PR0402MB3785:
x-microsoft-antispam-prvs: <DB3PR0402MB37851FF8BF62B94C22EDC6F7F5A80@DB3PR0402MB3785.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501517)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3785;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3785;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(39860400002)(396003)(13464003)(189003)(199004)(5660300001)(105586002)(186003)(486006)(33656002)(66066001)(106356001)(99286004)(53936002)(53546011)(6506007)(6916009)(54906003)(55016002)(26005)(1411001)(76176011)(68736007)(7736002)(305945005)(7696005)(9686003)(97736004)(3846002)(6116002)(229853002)(86362001)(102836004)(6246003)(39060400002)(316002)(478600001)(71200400001)(71190400001)(256004)(2906002)(44832011)(6436002)(446003)(11346002)(476003)(81166006)(81156014)(8676002)(4326008)(74316002)(25786009)(8936002)(14454004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3785;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xbfkEc2EJ4+64QwizkiAMbkfZU8B/C1UtFtLLrvHbSLc+aGvQsDQoa+wWnelFL6Mohf2nDmy72VcIzCqBu0Qn3NaLFvXR7vNacpySGC6AMaMwK6dFdvKwy6vehf9jCZVmS0cMBiGt/lmoWHhv9thE/3j6oZcHxmFfbKC4vrIQhuQ+0nySPplkGzbiN5YXrdiNjj0Bkl4FMNMucafY4v/P0Tq1x6Ff45Ie5CnUooChoYTliYMlyeEdP66aK5orbpSEYaIIMwf4d9fa0X4fLpCp+0Fg0rRtW0i0hJRr79n+t+PBhN19xt5ju60PEhBuSeJE79B0/fAc7qlrgebWUkpVmawN2p/TFfx5dsvUPjm0hU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb5705c-58ef-45d6-93fe-08d65a4f0eed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 01:14:51.7860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdtYWlsLmNvbV0N
Cj4gU2VudDogMjAxOOW5tDEy5pyINOaXpSAxODoxOQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29u
Lmh1YW5nQG54cC5jb20+DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBT
YXNjaGEgSGF1ZXINCj4gPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBTYXNjaGEgSGF1ZXIgPGtl
cm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvDQo+IEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1Abnhw
LmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Ow0KPiBNYXJrIFJ1dGxhbmQg
PG1hcmsucnV0bGFuZEBhcm0uY29tPjsgbW9kZXJhdGVkIGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVgN
Cj4gLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnPjsgb3Blbg0KPiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRCBERVZJQ0Ug
VFJFRSBCSU5ESU5HUw0KPiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1rZXJu
ZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBUk06IGR0czogaW14NnFkbC1z
YWJyZXNkOiBhZGQgZWdhbGF4IHRvdWNoIHNjcmVlbg0KPiBzdXBwb3J0IG9uIGkyYzIgYnVzDQo+
IA0KPiBIaSBBbnNvbiwNCj4gDQo+IE9uIFR1ZSwgRGVjIDQsIDIwMTggYXQgNjo1NCBBTSBBbnNv
biBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBBZGQgZWdh
bGF4IHRvdWNoIHNjcmVlbiBzdXBwb3J0IG9uIGkyYzIgYnVzLg0KPiANCj4gUGxlYXNlIGltcHJv
dmUgdGhlIGNvbW1pdCBsb2cgc2F5aW5nIHRoYXQgdGhpcyBuZXdseSBpbnRyb2R1Y2VkIHRvdWNo
c2NyZWVuDQo+IGNvbnRyb2xsZXIgaXMgY29ubmVjdGVkIHRvIExWRFMwIGFuZCB0aGUgZXhpc3Rp
bmcgb25lIG9uDQo+IEkyQzMgaXMgY29ubmVjdGVkIHRvIExWRFMxLg0KPiANCj4gVGhhbmtzDQoN
ClRoYW5rcyBGYWJpbywgZG9uZSBpbiBWMiBwYXRjaC4NCg0KQW5zb24uDQoNCg0K
