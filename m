Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03BFC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FCC20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n2G0kIi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FCC20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbeGZMQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:16:54 -0400
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:15328
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729031AbeGZMQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTm5xR4GpB5fhg2XM3tMmM9QXzssWgHdqT217TNJRkc=;
 b=n2G0kIi3Ogb2xjOmNDj3LoireGg78cEoGdbKjgKD2HAIqWlbpyGZY3BzJULn27bWCTu5YDgI+qX5lX7Mhvd6qvX14PLkrwysjy83I8jv6i0QgCrb2ISbHSjYEwl95PLttJ+jbc4zvPSMI+3a/H+TvwQ8RS0hB2VhYRJKd+YFgjo=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5299.eurprd04.prod.outlook.com (20.177.42.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 11:00:27 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::6c5e:bec5:949d:4cc1]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::6c5e:bec5:949d:4cc1%2]) with mapi id 15.20.0973.022; Thu, 26 Jul 2018
 11:00:27 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be equal
 to 0
Thread-Topic: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be
 equal to 0
Thread-Index: AQHUJK1m6vAx3xRmv0idxy22l34kDKShQFmAgAAU83A=
Date:   Thu, 26 Jul 2018 11:00:27 +0000
Message-ID: <AM0PR04MB421178C5283BDCCF11F5E2AF802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-2-o.rempel@pengutronix.de>
 <CABb+yY2+WwxHBtQfU3TJTErpfzfkNH8iwwYyXbmWAQy8UsqLRQ@mail.gmail.com>
In-Reply-To: <CABb+yY2+WwxHBtQfU3TJTErpfzfkNH8iwwYyXbmWAQy8UsqLRQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5299;6:MUsjbTFrAu4m4X1QtfHUwycOo5+fPlTUecOegOMCON5zBtbrdLSNcocroDaNnX0mNzbEeSr/ah+I2rO1/dB7DcZeJJ6356ZFO1Sam5g6oD455dGqDWS/Q9A2nrprfDDteKzYSomBKdm0fsXOpjhMjz1xVjqNMsUVUYdziWuBAPquBW6bn9nP1VXtBuc07nvtuwtGoV7Xn16VYauYIoRXJdC1quqYjoQGCu5jfyRU6Cywu6i2+rWtkNlJbNDvHj6OZoXE/qVPAz1Li5efoTcAOE/cFVBNgmrreSqVdGVpcva2SEpPlBonGl8vW51HoYYfHyY3mBMhWCypeYRs1a231OVmcFv0sQQTJl6wTmSgv0k7EN4NV2oe3C6OD3w5ItIWt+/BngwURnZdCxxO/4A0MJLTMkmLAH82rfcagqv4CRTszVQEuU9VwcpT++5QRV9QXGKYgZimTjisS1fcYCjk2w==;5:fPqCv7j2BkfDtcYosm6IsMZY3pzmNAUoqKUFHFCdSPNa59r8hElJaIfvIRlquXIj2jaAWK3MXCxo7NqpWwSGEdJN7rldumV7yhrmqfgBccLeKkfk9V+hrF027k0aDKKbrE7QbwJb6HUSCzKyD80rEm9ebbfTBhc2Xw6A7fodyMA=;7:9KZBGZHfwybrcV9ylXA6nzgAJoXhL7t3Nb7cp16zWXVQD8L78JPnh9GSwAoIiQSH0Edxbd02cI37rzYicYanfIqCpHCW/DmEv1TT4cdGI1AnHRNM8k8D5cqzld0sVL4z3aj35SPQjg73q9NW37uvRH+glbCN94GPxLyNBxeYXygcamSqDu5obEpWulbcpmrqcRzOp0GEZCmJoSU25tkqtxBOaOhCNPjJgTr3mMLjhPgH+bOEZ0t/q/4Y7pz62yqO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: eb0ee290-2a12-44fd-4f33-08d5f2e6fee2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5299;
x-ms-traffictypediagnostic: AM0PR04MB5299:
x-microsoft-antispam-prvs: <AM0PR04MB5299E3E671644129608232B5802B0@AM0PR04MB5299.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5299;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5299;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39850400004)(376002)(396003)(136003)(189003)(13464003)(199004)(8936002)(86362001)(7696005)(316002)(81166006)(81156014)(76176011)(8676002)(486006)(55016002)(39060400002)(6246003)(54906003)(110136005)(9686003)(102836004)(478600001)(15650500001)(99286004)(476003)(5250100002)(106356001)(11346002)(26005)(7736002)(53546011)(105586002)(4326008)(33656002)(446003)(25786009)(6506007)(5660300001)(6436002)(186003)(2900100001)(6116002)(14454004)(7416002)(3846002)(74316002)(97736004)(229853002)(2906002)(53936002)(66066001)(256004)(68736007)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5299;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 69wyNDrGUxeErWPgvxJmlfaFMVbmJI4j+xsnUklk8lXXW9B0Cq+wTzzn6bPQKJkk/8dX18dqqscnSX+An7d3BQf0kikwK7kbeLmjiSwd40wsielvLo2FavkiX8eWdtnJigeaDctpWABVN64SkBr1H/iZwNWI2ga56OZw4zTfufq9wNzYLdYzec1pcrlu5iQEiM53MxH6OhiZGszYWXb6QQwKlYZd83f5QygQvhZezGq+2WhZHwJRNz2N5XxIzhMVEdWbUh/8gXy7gd6KmeFs9HH0IMFGH3eBysmsP8009B7m5QfJQPUFcMzPTpJ3lEBxi6oXf6povPXhNTTfGfuws+1CqSwCQDnql+jShBbn+gA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0ee290-2a12-44fd-4f33-08d5f2e6fee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 11:00:27.4656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5299
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNzaSBCcmFyIFttYWlsdG86
amFzc2lzaW5naGJyYXJAZ21haWwuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAyNiwgMjAx
OCA1OjQyIFBNDQo+IFRvOiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+
DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBGYWJpbyBFc3RldmFtDQo+
IDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
PjsgTWFyaw0KPiBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IEEucy4gRG9uZyA8YWlz
aGVuZy5kb25nQG54cC5jb20+Ow0KPiBWbGFkaW1pciBaYXBvbHNraXkgPHZsYWRpbWlyX3phcG9s
c2tpeUBtZW50b3IuY29tPjsgU3VkZWVwIEhvbGxhDQo+IDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47
IERldmljZXRyZWUgTGlzdCA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBMaW51eCBL
ZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgLCBTYXNj
aGEgSGF1ZXINCj4gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47ICwgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnLCBsaW51eC0NCj4gbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9y
Zywgc3J2X2hldXBzdHJlYW0gPGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY3IDEvNl0gZHQtYmluZGluZ3M6IG1haWxib3g6IGFsbG93IG1ib3gtY2VsbHMgdG8gYmUN
Cj4gZXF1YWwgdG8gMA0KPiANCj4gT24gVGh1LCBKdWwgMjYsIDIwMTggYXQgMTI6MjMgUE0sIE9s
ZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCj4gd3JvdGU6DQo+ID4gRnJv
bTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gPg0KPiA+IE1haWxib3gg
ZGV2aWNlcyBtYXkgaGF2ZSBvbmx5IG9uZSBjaGFubmVsIHdoaWNoIG1lYW5zIHRoZSBtYm94LWNl
bGxzDQo+ID4gYXQgbGVhc3QgMSBkb2VzIG5vdCBtYWtlIHNlbnNlIGZvciB0aGlzIHR5cGUgZGV2
aWNlcy4gTGV0J3MgcmVtb3ZlDQo+ID4gdGhhdCBsaW1pdGF0aW9uIHRvIGFsbG93IHRoZSBtYm94
LWNlbGxzIHRvIGJlIGVxdWFsIHRvIDAuDQo+ID4NCj4gT0sNCj4gDQo+IEJ1dCBwbGVhc2UgcmVh
bGlzZSB0aGF0IHlvdSdsbCBoYXZlIHRvIHdyaXRlIG1vcmUgY29kZSAtLSBpbXBsZW1lbnQgeW91
ciBvd24NCj4gb2ZfeGxhdGUoKSBjYWxsYmFjay4NCj4gTW9zdCBkZXZlbG9wZXJzIHdvdWxkIHBy
ZWZlciB0byBjYWxsIHRoZSBvbmx5IGNoYW5uZWwgYXMgY2hhbm5lbCBudW1iZXIgMCwNCj4gYW5k
IHVzZSB0aGUgY29tbW9uIG9mX3hsYXRlIGltcGxlbWVudGF0aW9uLg0KPiANCg0KWWVzLCB0aGF0
J3MgdHJ1ZSBiZWNhdXNlIHRoZSBjb21tb24gb2ZfeGxhdGUgYXNzdW1pbmcgdGhlIG1ib3gtY2Vs
bHMgaXMgMS4NCkFuZCB0aGVyZSdzIGFscmVhZHkgc3VjaCB1c2VyczoNCmFyY2gvYXJtL2Jvb3Qv
ZHRzL2JjbTI4M3guZHRzaQ0KDQpNb3JlIGNvbW1lbnRzIHdpbGwgYmUgb24geW91ciByZXBseSBv
ZiBwYXRjaC0zLg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0KPiAtamFzc2kNCg==
