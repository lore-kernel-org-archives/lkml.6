Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BFBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A4620868
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XoDgY184"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A4620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeH1Qvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:51:52 -0400
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:56352
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726998AbeH1Qvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfwFtCDuy8kglHXI29cmML+hKVy7dyYMl5R/tMxaQl0=;
 b=XoDgY184/YHOnec2MzhmoAP1rC1ctT7QskwLEubhrC/zgTj09/vqoaqHnMaqclKyIMh06NRaryvGqmeFmJuudQPJoSB5MqMDnbMTnJlaWL4OsuvvZNYAlbSzQuiLnO1S8QH7vt6iHxJdQA7awnczWhYCjpUAUtpm7u/X944ZoqY=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4339.eurprd04.prod.outlook.com (52.134.126.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 13:00:02 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::e154:f5ba:1202:89c8]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::e154:f5ba:1202:89c8%2]) with mapi id 15.20.1080.015; Tue, 28 Aug 2018
 13:00:02 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RESEND] PCI: imx: Initial imx7d pm support
Thread-Topic: [RESEND] PCI: imx: Initial imx7d pm support
Thread-Index: AQHUPfkkle8GAhjxL06ov1WHU/m7v6TU8gsAgAAwDYA=
Date:   Tue, 28 Aug 2018 13:00:02 +0000
Message-ID: <efcb160f08bb53620ba0570e55dbb9190275aeb0.camel@nxp.com>
References: <d577303de61fb060aa428898f5df1d0bc9be89b8.1535369231.git.leonard.crestez@nxp.com>
         <20180828100758.GA27217@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180828100758.GA27217@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4339;6:OB+gbQ8NAaICJ8a2SopxnR2npdS5Iq22W7K68jkqaNANGfxqfS6Ux+MMJFhoD/gvoEAxWmZKPCH0mDcMlcIVSE4mk8ObEaK2Oob9+mqDjEvBe/2x9wXhHzytbsP/WesipKUO5VML+I7m/lHzrjPQeRdZZeHgxh6GZWKlmdtYCkL3+P8e3oO3/Rk9uv2/vPvKWbg+UKurHUzdBTI/wGtmZBxHOXEa1aaZ8hYn+mM2znIp/ZuHFvRSnjosSuVEjcMOXeLUP5YnP38biQLjh9V6G3RYAoViCxlkxl+NKTIdMryuMEE3TMVY3Pd3PjhipL07GhLjm2ZRbb3Lv2H8FomDaYDW5rmdiL3oG7j92tXgfzTUpoR4L0uz6m8i/4UBfcxvSrUaX86/YBl7tHaGuJq1HYCy3Ow96m9KN7bIYF2A8M/oZzqtkAgYJTGit0Q7f4rJFjJpE952sL+zqhPfdqDWtQ==;5:PJNRfBxGAQ9a+PJOCH2sh9wnykkEDrPhQ/ZqBLAODGl+lddVCfs6tg4TRjE/0YgIzbQVJRRddo40ZuryFBlgHJJK1bDeeiuSNtvapGh0yW9guONta4cxBP/zMXULMdbKA84MO7rwfBnipgHAUB4R1BvWEqLmXMso2nVXoyKOSAs=;7:gJ4lt2oGVZOiLzyPRWSefE6wxq5EpDf4aA26xc9l1KUOOU4CSWwpmSh+gvIHEz6ncbXbtugDCKsI7rthhesTBQ7iHk9iVgoRT4Z6vBLH7yRsIRO5zYXKIU7q8okv+5rSz27rdhKaNFremI7hSwSd1flN8DEAYmvVI3vl0E2hKdJCsJLuHBQRjXTUZICO/RcpySuFuBNhwmpQ2EFSeKKk+T8eH3FxAcwH93nA9j19z3g/YevhsmOiu5kChh5e//da
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: de9d367a-483d-4653-d364-08d60ce62b32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4339;
x-ms-traffictypediagnostic: AM0PR04MB4339:
x-microsoft-antispam-prvs: <AM0PR04MB4339842E92542B8441AA1A66EE0A0@AM0PR04MB4339.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR04MB4339;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4339;
x-forefront-prvs: 077884B8B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(186003)(8676002)(81156014)(81166006)(76176011)(486006)(68736007)(476003)(102836004)(256004)(14444005)(53936002)(39060400002)(6246003)(54906003)(6486002)(7736002)(4326008)(105586002)(5660300001)(2906002)(25786009)(6506007)(5250100002)(3846002)(7416002)(305945005)(316002)(478600001)(6916009)(106356001)(2351001)(66066001)(5640700003)(6116002)(2501003)(14454004)(26005)(446003)(97736004)(8936002)(2616005)(36756003)(229853002)(50226002)(44832011)(2900100001)(6436002)(6512007)(118296001)(86362001)(11346002)(99286004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4339;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r28R5bXsrn2a4FbaRYSMh90QQsdzYrqpfmG/u8PQ79YiU0iyFmmHLj6zLJ0dwxH3CSnSilHRH6oAyklcWirCodhyTb27t6v5fcK/0IszrieSa/PlERh7msUWAjhABze/tFw+xIpdIA8L0eLhM7qsvKFnEcq3VG5sGKzpeP7pWwu9yF5AXFXdoGJXxCfyj/1uZRvaSXi/vJjKLwjp7sivk9lT2hcv+8OSIF5ZltJsNo6oGkfmDxHgTnV9KrjmHXrIu5b8oxAjMygCaLi+7JseZeeUN3yXPHLWFBqzSPHjMWqqqAc5ZDNxDuXK3Y4JhwUV/CwAzzH7sb/ngSvkWhfPtR7fjbuTHgz/s2Va5c5r4Yk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9776837139F4DC4BB43E20ACA5D05E91@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9d367a-483d-4653-d364-08d60ce62b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 13:00:02.5172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA4LTI4IGF0IDExOjA3ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gTW9uLCBBdWcgMjcsIDIwMTggYXQgMDI6Mjg6MzdQTSArMDMwMCwgTGVvbmFyZCBD
cmVzdGV6IHdyb3RlOg0KPiA+IE9uIGlteDdkIHRoZSBwY2llLXBoeSBwb3dlciBkb21haW4gaXMg
dHVybmVkIG9mZiBpbiBzdXNwZW5kIGFuZCB0aGlzIGNhbg0KPiA+IG1ha2UgdGhlIHN5c3RlbSBo
YW5nIGFmdGVyIHJlc3VtZSB3aGVuIGF0dGVtcHRpbmcgYW55IHJlYWQgZnJvbSBQQ0kuDQo+ID4g
DQo+ID4gRml4IHRoaXMgYnkgYWRkaW5nIG1pbmltYWwgc3VzcGVuZC9yZXN1bWUgY29kZSBmcm9t
IHRoZSBueHAgaW50ZXJuYWwNCj4gPiB0cmVlLiBUaGlzIHdpbGwgcHJlcGFyZSBmb3IgcG93ZXJp
bmcgZG93biBvbiBzdXNwZW5kIGFuZCByZXNldCB0aGUgYmxvY2sNCj4gPiBvbiByZXN1bWUuDQo+
ID4gDQo+ID4gQ29kZSBpcyBvbmx5IGZvciBpbXg3ZCBidXQgYSB2ZXJ5IHNpbWlsYXIgc2VxdWVu
Y2UgY2FuIGJlIHVzZWQgZm9yDQo+ID4gb3RoZXIgc29jcy4NCj4gPiANCj4gPiBUaGUgb3JpZ2lu
YWwgYXV0aG9yIGlzIG1vc3RseSBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+LCB0
aGlzDQo+ID4gcGF0Y2ggYWRqdXN0cyB0aGUgY29kZSB0byB0aGUgdXBzdHJlYW0gaW14N2QgaW1w
bGVtZW50aW9uIHVzaW5nIHJlc2V0DQo+ID4gY29udHJvbHMgYW5kIHBvd2VyIGRvbWFpbnMuDQo+
IA0KPiBJIHdpbGwgYWRkIGEgU3VnZ2VzdGVkLWJ5OiByZXBsYWNpbmcgdGhpcyBwYXJhZ3JhcGgs
IGl0IGlzIGFsd2F5cyBiZXR0ZXINCj4gdG8gYWRkIHByb3BlciB0YWdzIHJhdGhlciB0aGFuIGNy
ZWRpdCBoaWRkZW4gaW4gY29tbWl0IGxvZ3MgbWVzc2FnZXMuDQoNCklzbid0ICJPcmlnaW5hbGx5
LWJ5OiIgYSBiZXR0ZXIgdGFnIGZvciB0aGlzPw0KDQo+ID4gU29tZSBkZXBlbmRlbmNpZXMgaW4g
dGhpcyBhcmVhIGFyZSBjb21wbGljYXRlZCBidXQgYXMgZmFyIGFzIEkga25vdw0KPiA+IGluY2x1
ZGluZyB0aGlzIHBhdGNoIHdpdGhvdXQgb3RoZXJzIHNob3VsZCBub3QgYnJlYWsgYW55dGhpbmcg
dGhhdCB3YXMNCj4gPiBub3QgYWxyZWFkeSBicm9rZW4uIFNpbmNlIHRoaXMgaXMgYSBwYXRjaCBm
b3Igc29tZXRoaW5nIHRoYXQgaGFzIG5ldmVyDQo+ID4gd29ya2VkIGJlZm9yZSBpdCBzaG91bGQg
YmUgdHJlYXRlZCBhcyBhIGZlYXR1cmUgbm90IGEgYnVnZml4Lg0KPiANCj4gT2ssIHNvIEkgY29u
c2lkZXIgdGhpcyB2NC4yMCBtYXRlcmlhbCwgcGxlYXNlIHNob3V0IGlmIGl0IGhhcyB0byBiZQ0K
PiBzZW50IGFzIGEgZml4LCBJIGRvIG5vdCB0aGluayBzbyBnaXZlbiB3aGF0IHdlIGRpc2N1c3Nl
ZCBhYm92ZS4NCg0KVGhhbmtzIQ==
