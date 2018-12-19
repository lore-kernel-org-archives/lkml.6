Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F969C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27D1218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="P12RVb+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbeLSJ6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:58:17 -0500
Received: from mail-eopbgr80129.outbound.protection.outlook.com ([40.107.8.129]:59664
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727963AbeLSJ6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+3eqW29fH+Y9PeWpNFn8Fh1fkpK+tyzScaqQmqLo58=;
 b=P12RVb+zUZ7Q/PxN4hXhExyL1LqJCo+PJ1IcCClkZwX+9fo6yLAGnnoygIfECo8le648McIv2inuqj5LiHAVvySc3HmiCLVRRg4Cw85yYSGqbyyQ2l6elc3VDlesrk48ntW38Ih6dLkir1o1gTLouuuZX2+AtVrHark8vF4vcGc=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB4992.eurprd02.prod.outlook.com (20.178.14.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 09:57:32 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8%5]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 09:57:32 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: display: bridge: lvds-transmitter: add
 pwdn-gpios
Thread-Topic: [PATCH 2/3] dt-bindings: display: bridge: lvds-transmitter: add
 pwdn-gpios
Thread-Index: AQHUlygfLqQfa5yGMUGP6qbZiqP5EqWFx74AgAAMcoA=
Date:   Wed, 19 Dec 2018 09:57:32 +0000
Message-ID: <7c2f1268-43a3-1dc2-bb2d-6da9d74a5a43@axentia.se>
References: <20181218231850.3572-1-peda@axentia.se>
 <CGME20181218231950epcas3p4d5bc243137aa464b0424365dfde9d238@epcas3p4.samsung.com>
 <20181218231850.3572-3-peda@axentia.se>
 <f0686eeb-14af-6525-6c55-9cc8bdc5730e@samsung.com>
In-Reply-To: <f0686eeb-14af-6525-6c55-9cc8bdc5730e@samsung.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0501CA0035.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::45) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB4992;6:6/+cRWawKHK2eMFAAYdyDc0KXrdWWL8IJ7FpIVQmOVaXZFgmpNfrqXlDRm5kBvGo8y5dEOlJ1xEy5kCNCf6KBR4oNH1IOJC8xa2ZRG/yRke6/WdLXCqzMXg4B6GmqMVVeBJv82snpNDwBM1zifiHHFEjPPxvvL0uAjF1CepaLUOOM4bgS2Z2JIjbLY8xVKipBUsE4imnqKRWutq0GeGAq0sTeLPSAbPviiJz9sLKdm7xmUGkszpgASXiXmBiQCf8DUZZnQhulAGuNG6CoZATiz2LpAgVXqnL/xeYG/SDHVuhMV9tnHNw+UQ9ySitW6zkUaW9+NtIl1ySCqmZse3r2pprwhCnSyBp5O28MQaDQkfwPvuOMP3eIyRTnJArXhdGejWlWDvY5Oyvsd2djGh/fWzN5oNw5EqkRPkTYy3ZA0koXfFSiPpfplXLTe+owtN8ByMbweYEPTHoFv84oa/kgw==;5:c4/vUiCSG5sT5c8Mj2HjQErEjXM0iHQwI21ie0NViZKK/3Up0yq6dB/tFe0d5xj8zpfrMYPUP4ATzYh9w8Bcucl8XFMHdHX4tktMDJx6yIGG2Qg6krxPYj0IlcDmWu545ARB73TM3xaHPAJQNFrheF+7+YZz5B5e+Qfm9bW3+iQ=;7:hIJSuP+LFkihO2nuBec8TATq5blhD0MJTL9OsfgWHFN7i+ztMWUqcrzUe0pP2ITb3v0PHLUxU+pdLL2vaA5Fsj5OOXGLPFVgyug7J3ZovMa/pS+hX+c/ZIgNSngGQVMb7xAdDNAkoTu7XBx3rhcClQ==
x-ms-office365-filtering-correlation-id: 4f0a6f1b-9452-498e-bf91-08d6659864b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4992;
x-ms-traffictypediagnostic: VI1PR02MB4992:
x-microsoft-antispam-prvs: <VI1PR02MB49920E6EDE2CEEAA8E817679BCBE0@VI1PR02MB4992.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB4992;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB4992;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(39830400003)(376002)(396003)(189003)(199004)(71190400001)(256004)(106356001)(476003)(26005)(4326008)(508600001)(6246003)(305945005)(2616005)(105586002)(6436002)(446003)(486006)(14454004)(86362001)(93886005)(6486002)(11346002)(58126008)(68736007)(36756003)(31696002)(6512007)(316002)(76176011)(8936002)(6116002)(74482002)(7736002)(110136005)(229853002)(102836004)(97736004)(54906003)(31686004)(8676002)(66066001)(65956001)(2906002)(64126003)(53936002)(2501003)(65826007)(3846002)(65806001)(4001150100001)(186003)(5660300001)(25786009)(52116002)(53546011)(81156014)(99286004)(81166006)(386003)(6506007)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4992;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DCtmmd5iKuUUR91I+nPlbIk+itmidDvQbDJKgCWVCE/oGRWjDlJAGcfTgfiUEAdibsV/L0K6bKtcAm/z1fkqYFbxyd0ZU6bU++/Z7TRh4UEi4j4PRBd8zqkiMJPwPXK48bLiAJiEo3DTqdZ6X9WLMXKWX1H3FNpS6GJdv61WER1bO4V67Hny0JQn3Aap5s85+QEfbgsPIX/7Mw32tHnFGUxuhq86U9GU8qqHzUQjflO4ooaYCrBy5lzZ8OAMZ9aMC3Kl3ELxeFYmhqth3sJShmwkfiXz7kZQgszLAB+iuxqebWLzWRnVOc4tfeqBBp0V
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3CF27CBDAB3534BA175C21212034A13@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0a6f1b-9452-498e-bf91-08d6659864b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 09:57:32.1997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4992
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMi0xOSAxMDoxMiwgQW5kcnplaiBIYWpkYSB3cm90ZToNCj4gT24gMTkuMTIuMjAx
OCAwMDoxOSwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+PiBBZGQgb3B0aW9uYWwgcHJvcGVydHkgdG8g
c3BlY2lmeSBhIHBvd2VyLWRvd24gR1BJTy4NCj4+IFRoZSBwd2RuLWdwaW9zIG5hbWUgaXMgYWxy
ZWFkeSBpbiB1c2UgYnkgdGhlIHRoaW5lLHRoYzYzbHZkbTgzZA0KPj4gYmluZGluZywgc28gZ28g
d2l0aCB0aGF0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50
aWEuc2U+DQo+PiAtLS0NCj4+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9icmlkZ2UvbHZkcy10cmFuc21pdHRlci50eHQgfCAzICsrKw0KPj4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2x2ZHMtdHJhbnNtaXR0ZXIudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2x2ZHMtdHJh
bnNtaXR0ZXIudHh0DQo+PiBpbmRleCBmOWU3ZGQ2NjZmNTguLjQ3OTQxZDM5ZjkyZiAxMDA2NDQN
Cj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2JyaWRn
ZS9sdmRzLXRyYW5zbWl0dGVyLnR4dA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2x2ZHMtdHJhbnNtaXR0ZXIudHh0DQo+PiBAQCAtMzEs
NiArMzEsOSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPj4gICAgZGV2aWNlLXNwZWNpZmljIHZl
cnNpb24gY29ycmVzcG9uZGluZyB0byB0aGUgZGV2aWNlIGZpcnN0DQo+PiAgICBmb2xsb3dlZCBi
eSB0aGUgZ2VuZXJpYyB2ZXJzaW9uLg0KPj4gIA0KPj4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+
PiArLSBwd2RuLWdwaW9zOiBQb3dlci1kb3duIGNvbnRyb2wgR1BJTw0KPj4gKw0KPiANCj4gDQo+
IFNpbmNlIG5hbWluZyBpcyBub3QgZW5mb3JjZWQgYnkgYW55IGRhdGFzaGVldCBJIHdvdWxkIHBy
b3Bvc2Ugc29tZXRoaW5nDQo+IG1vcmUgcG9wdWxhciB3aXRoIGxlc3MgdHdpc3RlZCBsb2dpYy4g
TWF5YmU6DQo+IA0KPiAtIGVuYWJsZS1ncGlvczogLi4uIChhY3RpdmUgaGlnaCkuDQoNClRoYXQg
d2FzIG15IG9yaWdpbmFsIHRob3VnaHQgdG9vLCBidXQgdGhlIGRyaXZlciBpbXBsZW1lbnRpbmcg
dGhlDQpsdmRzLWVuY29kZXIgYmluZGluZ3MgYWxzbyBoYW5kbGVzIHRoZSBtZW50aW9uZWQgdGhp
bmUsdGhjNjNsdmRtODNkDQpsdmRzIGVuY29kZXIsIGFuZCB0aGF0IGJpbmRpbmcgaGFzIHRoZSAi
cHdkbiIgbmFtaW5nLiBTbywgZm9yIGRyaXZlcg0KaW1wbGVtZW50YXRpb24gc2ltcGxpY2l0eSBJ
IHdlbnQgd2l0aCB3aGF0IHdhcyBhbHJlYWR5IHRoZXJlLCB0aHVzDQphbGxvd2luZyBhZGRpbmcg
c3VwcG9ydCBmb3IgYm90aCBiaW5kaW5ncyB3aXRoIG9uZSBpbXBsZW1lbnRhdGlvbg0KKGluIHBh
dGNoIDMvMykuDQoNCkFkZGluZyBjb2RlIGp1c3QgdG8gaGFuZGxlIG11bHRpcGxlIG5hbWVzIGZv
ciB0aGUgc2FtZSB0aGluZyBkb2VzDQpub3Qgc291bmRzIHRvbyBhcHBlYWxpbmcuDQoNCkNoZWVy
cywNClBldGVyDQo=
