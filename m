Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769E0C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC83218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bgVSOOcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbfA3NQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:16:57 -0500
Received: from mail-eopbgr10082.outbound.protection.outlook.com ([40.107.1.82]:18256
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfA3NQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31JQaLP9b7/MS+Kn040XLSQ3CxLLZI5+w75skuqd0u4=;
 b=bgVSOOcrxL7JKmZsaH0LazsLnsNV7yduV7pAs7vbot7i6OBAmctNNytWF6aSs1DRrJSx71CBJPfWrz+YkXTMQ/dO1iLFM1TaDONq4b5JhonyV/PTiUuzZA9+Mpo2eYhrkPdgofh6Lmb3z904HdbFZoqn4M46ZKmPvh2thPjuZLo=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB4767.eurprd04.prod.outlook.com (20.177.48.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Wed, 30 Jan 2019 13:16:52 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::92d:bf44:9c1d:b907%6]) with mapi id 15.20.1558.025; Wed, 30 Jan 2019
 13:16:52 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "olof@lixom.net" <olof@lixom.net>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/3] kbuild: Add wilddt function instead of listing dtbs
Thread-Topic: [PATCH 0/3] kbuild: Add wilddt function instead of listing dtbs
Thread-Index: AQHUpr+U4MlukrPd1USdyY3EAbizy6W+r0YAgAk/UgA=
Date:   Wed, 30 Jan 2019 13:16:52 +0000
Message-ID: <b6317087abfa81b37b0ac800b192f8e32786ce9a.camel@nxp.com>
References: <cover.1546888138.git.leonard.crestez@nxp.com>
         <VI1PR04MB553355D6D5EBC2604E1AD256EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
         <CAK7LNAQ+eNhkfNsjGEdAg+j2ButQ8R6NyZ10SckCGSP5MZ4jtg@mail.gmail.com>
In-Reply-To: <CAK7LNAQ+eNhkfNsjGEdAg+j2ButQ8R6NyZ10SckCGSP5MZ4jtg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4767;6:5BRBpU+mz2fe0kS5kqASRhQNib/atCL14FJG5y2tLsGqi10m+vMe+B5ltHeOd8yD8U+fs80IGLj/oJGkgBfQH0Hkb6cQyLfdhsNUeWAN8+np7SE78Y69YPhrBxauBCMCPGU9HEwgC5SnQkwru3+lxYFvf8qhZ6BtFi0x9VYUQqpx+cQ8ciRpYw8f9QKJr/XKv/TgCwi2JLKEHC2ldpSfgxi/cuNGp6Qu9qllRWu4RofK8AMeBE1NVeOjyWTvX2U8WuHcLMjhMgMRQK9HDq7ftY5y8srSpJh9XpctpZI8i8UE4BuGBS9efUJKwRA5g9RDiA1gp4K9krWJgyLcj71HHZcivv6b9J1o1p+22sENPVPpVYg9ZvAmvpSNqZJTa7oaPigZ7uZo6a/7cpFu4loVB06YO9I0e1pBsMIeegyWVOKUFYz/dCDLzGxSom+ui0i/fspo1E059YnM5sntH3Ro7Q==;5:fbYbGZ/1z18O9Pl/ptSLv0MUHM1w9QdLfhBBk20la84QBCHxS4No+V5BxCIUfKXgzm3/CmI4vBks3H6FRDxm4qLwVp83pqvLP6sUJZINTg73Osgs/xWRrIdD9U/aHM0h8TH03BpwXleKdARkGC9gr1LkAMK7NsuhtXUoILotKDi3KIDhxLMlOgTrA8vzZl+ItqSRTl0jHav5UwcRv6tEeA==;7:Hi97oKiMyPQLWLZuajZr7dpVL5f2WNK3oxVfFX1hp2nJ8C6Lep4Nnws5U2cHGCAZHiarozp0qCBLpub0xRrW3VYHD/KrC3oo/PKotkXo0rn5KmOqvSYZrHIfwHlbbbT7Ceu39cxA7wMKGRvravabIA==
x-ms-office365-filtering-correlation-id: 6c04fe3c-9eda-48c5-dbb7-08d686b5334f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4767;
x-ms-traffictypediagnostic: VI1PR04MB4767:
x-microsoft-antispam-prvs: <VI1PR04MB47676406073D1633AC5DF958EE900@VI1PR04MB4767.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(189003)(199004)(44832011)(36756003)(26005)(186003)(118296001)(102836004)(6116002)(3846002)(6486002)(6436002)(81166006)(99286004)(2501003)(486006)(476003)(68736007)(11346002)(2616005)(25786009)(66066001)(446003)(76176011)(8676002)(81156014)(106356001)(8936002)(256004)(2906002)(7736002)(6506007)(53546011)(86362001)(105586002)(50226002)(53936002)(6512007)(7416002)(316002)(71200400001)(97736004)(4326008)(478600001)(71190400001)(229853002)(54906003)(6246003)(14454004)(110136005)(305945005)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4767;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dcmoXCePgTZubQl4uM4H/lrAcT/nn4CwyEwfAYJ9DTBp4iwMQ8VWSZQ7biCrSSEEHk5zn1RwCTZXyMg2RY6TjnkRWnusBvUraGpPx60oFw2Wl5Gs32zwhD/pkoAFROaKSGzKLZ0dzHsPFAHZAI98dgW8Sq5pfdgzaBBVYDUx5eiTe3H/wWhoyHLFTtH7XEV/6+ZLDZPvaZJZWnXotJwtZLOXVMLGBjWzvMuNoONjZQWuvnvajggFxXJYPiiL7YLuvw/iiLJfoGXGMvZUT5tqEDXykISaFlEv4vm11l5beyklwtPWMYBxrljCsUu9czpO0XmoKBv6qx1WW4dCRqhQGsiEunRj0moYihXb/fPh5TF5H9YtZjy6JpiWnkPnQ4Q94fqIqNnt2lN9c5CPsIFjmZp/e5OXntRAa5bn5iA1AO4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EF3BD6963F2A741B9D919888AC0468B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c04fe3c-9eda-48c5-dbb7-08d686b5334f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 13:16:52.4966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTAxLTI1IGF0IDAxOjAzICswOTAwLCBNYXNhaGlybyBZYW1hZGEgd3JvdGU6
DQo+IE9uIFR1ZSwgSmFuIDIyLCAyMDE5IGF0IDE6MTcgQU0gTGVvbmFyZCBDcmVzdGV6IDxsZW9u
YXJkLmNyZXN0ZXpAbnhwLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gMS83LzIwMTkgOTozMSBQ
TSwgTGVvbmFyZCBDcmVzdGV6IHdyb3RlOg0KPiA+ID4gVGhlIGR0cyBtYWtlZmlsZXMgZ28gdGhy
b3VnaCBhIGxvdCBvZiBwb2ludGxlc3MgY2h1cm4gd2hlbiBib2FyZHMgYXJlDQo+ID4gPiBhZGRl
ZC4gTWFueSBTT0NzIChzdWNoIGFzIGlteCkgaGF2ZSB2ZXJ5IHNpbXBsZSBuYW1pbmcgY29udmVu
dGlvbnMgZm9yDQo+ID4gPiBhbGwgYm9hcmRzIHVzaW5nIGEgY2VydGFpbiBjaGlwIGFuZCBib2Fy
ZCBsaXN0aW5ncyBjYW4gYmUgZWFzaWx5DQo+ID4gPiBjb2xsYXBzZWQgdXNpbmcgd2lsZGNhcmRz
Lg0KPiA+ID4gDQo+ID4gPiBBZGQgYSAid2lsZGR0IiBmdW5jdGlvbiBhbmQgdXNlIGl0IGZvciBp
bXg2LzcvOCBhbmQgbGF5ZXJzY2FwZS4gVGhpcyBjYW4NCj4gPiA+IGJlIGFwcGxpZWQgdG8gbWFu
eSBvdGhlciBzb2MgZmFtaWxpZXMgbGF0ZXIuDQo+ID4gDQo+ID4gQW55IGZlZWRiYWNrPyBUaGlz
IHNob3VsZCBiZSByZXZpZXdlZCBieSBrYnVpbGQgYW5kIGFybS1zb2MNCj4gDQo+IFBlcnNvbmFs
bHksIEkgcHJlZmVyIGV4cGxpY2l0IGxpc3RpbmcNCj4gYmVjYXVzZSBJIGNhbiBicm93c2UgdGhl
IE1ha2VmaWxlIHRvIGdldCBhIHF1aWNrIGlkZWENCj4gb2Ygd2hpY2ggYm9hcmRzIGFyZSBjb21w
aWxlZC4NCg0KT3IgeW91IGNhbiBqdXN0IGxzIHNvYy0qLmR0cz8NCg0KPiBJIGxpa2UgdGhpcyB0
byBiZSBjb25zaXN0ZW50Lg0KPiAtIEV4cGxvaXQgd2lsZGNhcmQgZm9yIGFsbCBwbGF0Zm9ybXMN
Cj4gLSBEbyBub3QgZG8gdGhpcyBhdCBhbGwNCj4gDQo+IEJ1dCwgSSBhbSBwZXNzaW1pc3RpYyBh
Ym91dCB0aGUgZm9ybWVyDQo+IHdoZW4gSSBsb29rIGF0IEFUOTEgcGxhdGZvcm0uDQoNCkkgY2Fu
IHRyeSB0byByZXNlbmQgaW4gYSBmb3JtIHRoYXQgdXNlcyBhIHdpbGRjYXJkIGZvciBtb3N0IHBs
YXRmb3Jtcw0KYnV0IHNraXBzIHRob3NlIHdpdGggdmVyeSBmZXcgU09DcyBvciBjb25mdXNpbmcg
Y29udmVudGlvbnMgKGxpa2UNCmF0OTEpLg0KDQotLQ0KUmVnYXJkcywNCkxlb25hcmQNCg==
