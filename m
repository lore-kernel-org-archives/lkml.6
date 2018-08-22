Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A63C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCCC214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cd8fTf37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCCC214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeHVKQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:16:50 -0400
Received: from mail-eopbgr00082.outbound.protection.outlook.com ([40.107.0.82]:61248
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbeHVKQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w976+BlkUYf2NBP1hf+W/wvlf+iz2zl5gTwjc9hv6Lk=;
 b=cd8fTf37JqTzImTouHR4dRrMRkOadvHUTjdCau96yU/jB2QJJV1GPnswR1xACdDYLlA0A9eo8gPa4go6+iMW0NNQmY2qbdLFagUgl9XuAVzU0okRrCdFeJXH6lw92IVrKyAZOSVDTNpD9PJw+lmZxY7LOMDMvF2b1ouqx6Rk3FY=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4914.eurprd04.prod.outlook.com (20.176.215.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.24; Wed, 22 Aug 2018 06:53:14 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::2545:18ff:ca37:1e60]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::2545:18ff:ca37:1e60%4]) with mapi id 15.20.1059.023; Wed, 22 Aug 2018
 06:53:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Ying Liu <victor.liu@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] clk: imx6: Mark imx_clk_mux as glitchy by default
Thread-Topic: [RFC] clk: imx6: Mark imx_clk_mux as glitchy by default
Thread-Index: AQHUOYYTdwDinWiDP0ilYt2OR3uisaTKzVgAgACJMoA=
Date:   Wed, 22 Aug 2018 06:53:14 +0000
Message-ID: <c0966648ef0a15672ddd617de87692f71a19bad4.camel@nxp.com>
References: <e56c6f0acfe7afb885d2cb67e1e069f7edd0d2d7.1534879459.git.leonard.crestez@nxp.com>
         <CAOMZO5Dr9NUXuu+LECp2QHZLRhfbymHK23yCCFW-9jB=VXNn+A@mail.gmail.com>
In-Reply-To: <CAOMZO5Dr9NUXuu+LECp2QHZLRhfbymHK23yCCFW-9jB=VXNn+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [85.204.4.237]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4914;6:/Bk2Ewl7xJJbZECT/MgZaJI7BgO0GwpgJohjEycuwtFjLFbVCCidISXPv4GAMTd8N+3Qn0tgGIMIY1jKVvbDYfJr5+cv6/mrD/wwjP3vfOpKejITkJyUJYPo7s8qB/0prGsOIxuXEZsyotE6dFkmFSWJXru+rh3axcqoAQRdi9sEDHhGyqhIOBnkHIWv81YlQpsaN3TcPsTiKYNUypiDw4OKpHNCghxwX3AeBFDyjCu1YD6+Ggv9mjd/QVgUd4zieZiKZACOGW/xzz5u9rjFWcxYPvWC/T6R21gUL9tNoW95GmiFtOMs5FOoSIZ2NHJW0TMxVsNuWFSL94l9F6n8aGbFWzUFMgydfrrcUQ6PQt3ed5x1e08AMsEvpXRa+teAhpErssEthFd3e8knb5o6LwKSQ1LETmFrvM7mLsAnSfBuv957lU4Zeq36j7iEnqWcr/rqNnvhvPQl0TC5PetC6A==;5:wWgCs7EpyRi3lrzpGrF05e/cqpL2Fk3RbLOkNNZpHLBJNVtoXC0IQP3IhDuB8mBXW7RVU61JrQlgUhGlgowtICT1lEr7IQznL3IUGBVDXzUKC3yop7HTOfZ29okL/UWk9tgM/0/VR+IxmM+We8ZUr+M4PoxPkBWmsjAZoSE/Q8s=;7:IbNsYLNhCbwbff5sq1FNaq3r3uEkARb+7jmb5Q6EitWIMUXRjwMUmEKRExFsLN/Ix489CGDEWKhLYfXIo/bR1JOAMnKBxliQ+km2gP67u6rTUhPg+QV77qBNWptyH8g/9FPOxnwtd/PZOKfp2u+M8F5LJVzeGsgRX90As/EmDPfpM9Usq/oGHxHy6OctpJJSoVH8O54eOxQPTJw9/WZnoVTFmQrDTvxNUSYNNHs/4JbAoJ6Mfe1Ju5L+G13NY2qW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 830174a1-00de-48bf-67b6-08d607fbeecf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4914;
x-ms-traffictypediagnostic: AM0PR04MB4914:
x-microsoft-antispam-prvs: <AM0PR04MB49148CA181729A08BAD7C630EE300@AM0PR04MB4914.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR04MB4914;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4914;
x-forefront-prvs: 0772E5DAD5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(43544003)(199004)(189003)(50226002)(486006)(4326008)(6506007)(102836004)(36756003)(186003)(106356001)(26005)(39060400002)(305945005)(105586002)(44832011)(53546011)(2906002)(14444005)(7416002)(8676002)(25786009)(97736004)(66066001)(256004)(6246003)(7736002)(446003)(86362001)(6436002)(478600001)(118296001)(8936002)(81166006)(476003)(110136005)(68736007)(316002)(5250100002)(2616005)(76176011)(81156014)(2501003)(99286004)(14454004)(6486002)(229853002)(5660300001)(6116002)(11346002)(53936002)(6512007)(2900100001)(3846002)(54906003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4914;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FV5Sbvxjvo254Jb+BYh/fwhZoHUkjkagXaviahcVSQojcYv5hVgGjJ1bzGPelUu6M6GVnQ/ho88LJ9dswJaZVdrmpXi678zgpszNJ2k3ldOVU6Nz5L2c6kmtHLSr+QRezqBrvAl2NhxziivjYXbpqtvVxfxQjmgn3NasNUUgXkmEpM7fPxoU6Qm7tYPv+/tebyBraT4/8VtdG0oGREhvzhsIjnsVFDjOQPevunapyfexejqWH2gV52zcphuncoT4s5gUxbI0pLP7C3skwBCMXYX0aQ00HL40D3cRPLkSLDo2fmUFU3jh6qn9Oy18msyLQ3KWRuV5CZx09jP9GVBgWJ3DOl09bIQJDAO43Hqnzrc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <40D514BCC9D8464F8905E50087FC4D41@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 830174a1-00de-48bf-67b6-08d607fbeecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2018 06:53:14.3321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4914
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA4LTIxIGF0IDE5OjQyIC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBIaSBMZW9uYXJkLA0KPiANCj4gT24gVHVlLCBBdWcgMjEsIDIwMTggYXQgNDozNCBQTSwgTGVv
bmFyZCBDcmVzdGV6DQo+IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4gd3JvdGU6DQo+IA0KPiA+
IE1vcmUgY29uY3JldGVseSBvbiA2cXAtc2RiIGJsYW5raW5nIHRoZSBkaXNwbGF5IGhhcHBlbnMg
bGlrZSB0aGlzOg0KPiA+ICAqIGlteF9sZGJfZW5jb2Rlcl9kaXNhYmxlIHN3aXRjaGVzIGlwdTFf
ZGkwX3NlbCB0byBpcHUxX2RpMF9wcmUgZnJvbSBsZGJfZGkxX3BvZGYNCj4gPiAgKiByZXBhcmVu
dGluZyB0byBpcHUxX2RpMF9wcmUgZW5hYmxlcyBpdCBhbmQgaXRzIHBhcmVudHMgdXAgdG8gcGxs
NQ0KPiA+ICAqIHBvc3NpYmx5IGdsaXRjaHkgbXV4aW5nDQo+ID4gICogaXB1X2RpX2Rpc2FibGUg
ZGlzYWJsZXMgaXB1MV9kaTAgKGFuZCBwYXJlbnRzLCB1cCB0byBwbGw1KQ0KDQo+IFdlIGhhdmUg
YWxyZWFkeSB0YWtlbiBjYXJlIG9mIGl0IGluIHRoZXNlIGNvbW1pdHM6DQo+ICAgICBjbGs6IGlt
eDY6IEZpeCBwcm9jZWR1cmUgdG8gc3dpdGNoIHRoZSBwYXJlbnQgb2YgTERCX0RJX0NMSw0KPiAg
ICAgY2xrOiBpbXg2OiBNYWtlIHRoZSBMREJfREkwIGFuZCBMREJfREkxIGNsb2NrcyByZWFkLW9u
bHkNCg0KVGhhdCdzIGZvciBsZGJfZGl7MCwxfV9zZWwsIHRoaXMgaXMgZm9yIGlwdXsxLDJ9X2Rp
ezAsMX1fc2VsLg0KDQpPbiBpbXg2cSB0aGUgbGRiX2RpezAsMX1fc2VsIG11eCBoYXMgYW4gaW1w
cm9wZXJseSBwbGFjZWQgZ2F0ZSBhbmQgYQ0Kc3BlY2lhbCBzd2l0Y2ggcHJvY2VkdXJlIG5lZWRz
IHRvIGJlIHBlcmZvcm1lZCBhdCBib290IHRpbWUuIFRoaXMNCmRlc2lnbiB3YXMgZml4ZWQgb24g
NnFwIGJ5IG1vdmluZyB0aGUgbGRiX2RpezAsMX0gZ2F0ZSBpbW1lZGlhdGVseQ0KYWZ0ZXIgdGhl
IG11eC4gTXkgdGVzdHMgYXJlIG9uIDZxcC4NCg0KRm9yIGlwdXsxLDJ9X2RpezAsMX1fc2VsIHRo
ZSBpcHV7MSwyfV9kaXswLDF9IGdhdGUgY2FuIGJlIHVzZWQgb24gYWxsDQpjaGlwcywgaXQncyBq
dXN0IHRoYXQgdGhlIGRybSBkcml2ZXIgZG9lc24ndCBkbyB0aGlzLiBBZGRpbmcgdGhlDQpDTEtf
U0VUX1JBVEVfUEFSRU5UIGZsYWcgZXhwb3NlcyB0aGUgaXNzdWUgYnkgcmV0dXJuaW5nIGVycm9y
cy4NCg0KPiBJIHRoaW5rIHdlIHNob3VsZCBhbHNvIHRha2UgY2FyZSBvZiB0aGUgb3RoZXIgZ2xp
dGNoeSBtdXhlcyBhcw0KPiB5b3UgcHJvcG9zZSBoZXJlLg0KPg0KPiBIYXZlIHlvdSBzZWVuIHN1
Y2ggZ2xpdGNoIGlzc3VlIGluIHByYWN0aWNlIHdpdGggdGhlIExEQiBjbG9ja3M/DQoNCklmIEkg
cnVuICJ3aGlsZSB0cnVlOyBkbyBydGN3YWtlIC1tIG1lbSAtcyA1OyBkb25lIiBpdCB3aWxsIGhh
bmcgaW4gfjMwDQptaW51dGVzIGJlY2F1c2UgdGhlICJzdXNwZW5kIGRldmljZXMiIHRha2VzIHRv
byBsb25nIGFuZCBSVEMgYWxhcm0NCmV4cGlyZXMuIEkgdHJhY2tlZCB0aGlzIGRvd24gdG8gdGhl
IGNsa19zZXRfcGFyZW50IGNhbGwgaW5zaWRlDQppbXhfbGRiX2VuY29kZXJfZGlzYWJsZTogc29t
ZXRpbWVzIHRoaXMgdGFrZXMgbWFueSBzZWNvbmRzLg0KDQpBcyBmYXIgYXMgSSBjYW4gdGVsbCB0
aGlzIGxpdmUgcmVwYXJlbnRpbmcgaXMgdW5zYWZlIChSTSBjbGFpbXMNCmdsaXRjaGVzIGFyZSBw
b3NzaWJsZSkgYW5kIG5vdCB1c2VmdWwgKHdlJ3JlIGRlYWN0aXZhdGluZyB0aGUgZGlzcGxheQ0K
YW55d2F5KS4gSG93ZXZlciBJJ20gbm90IHN1cmUgdGhpcyBjYW4gYmUgYmxhbWVkIG9uIGEgImds
aXRjaCIuDQoNCldoYXQgc2VlbXMgdG8gYmUgaGFwcGVuaW5nIGlzIHRoYXQgdGhpcyB0cmlnZ2Vy
cyB0aGUgZW5hYmxpbmcgb2YgcGxsNQ0KKHllcywgb24gZGlzYWJsZSkgYW5kIHRoZSB1c2xlZXAg
ZnJvbSBjbGtfcGxsdjNfd2FpdF9sb2NrIHRha2VzIGZhciB0b28NCm11Y2ggdGltZSB0byByZXR1
cm4uIFRoaXMgbWlnaHQgYmUgYW4gdW5yZWxhdGVkIHRpbWVrZWVwaW5nIGlzc3VlLCBJJ2xsDQps
b29rIGludG8gdGhpcyBmdXJ0aGVyLg0KDQpBY2NvcmRpbmcgdG8gdGhlIFJNIHRoaXMgcmVwYXJl
bnRpbmcgaXMgdW5zYWZlIGFueXdheSBzbyB3ZSBzaG91bGQNCmF2b2lkIGl0LCBwcm9iYWJseSBi
eSBkaXNhYmxpbmcgaXB1X2RpIHNvb25lci4NCg0KLS0NClJlZ2FyZHMsDQpMZW9uYXJkDQo=
