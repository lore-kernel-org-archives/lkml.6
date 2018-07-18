Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E113ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16E02075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="bPIGlv8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16E02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbeGROee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:34:34 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:25129 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730831AbeGROee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:34:34 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 18 Jul 2018 22:56:29 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 26B0D71ABC;
        Wed, 18 Jul 2018 22:56:29 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,370,1526310000"; 
   d="scan'208";a="287222880"
Received: from mail-ty1jpn01lp0179.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.179])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2018 22:56:28 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT4Lx3vXT41EKPnC4JbtC868qiEm9+mJlnJ/t5MWRrs=;
 b=bPIGlv8AASIE5NDw1QK44Q3J0NkOROfkeFxdKevJ6mK8iKZiPRFylMOHSVzEbYd7GaXjjbOZa2DyZHUgQMc4WnGts5Si9cj+Y6pt6+F/lPSoIjy/DL1fAc+XxvOAALYZgkZl50VBhnmIcfZg6kre+CI3vMIdQn2exbuYrdB33no=
Received: from OSBPR01MB1766.jpnprd01.prod.outlook.com (52.134.227.145) by
 OSBPR01MB1605.jpnprd01.prod.outlook.com (52.134.226.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 13:56:26 +0000
Received: from OSBPR01MB1766.jpnprd01.prod.outlook.com
 ([fe80::71c6:7b27:cbfd:d898]) by OSBPR01MB1766.jpnprd01.prod.outlook.com
 ([fe80::71c6:7b27:cbfd:d898%2]) with mapi id 15.20.0952.021; Wed, 18 Jul 2018
 13:56:26 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] clk: Add functions to get optional clocks
Thread-Topic: [PATCH] clk: Add functions to get optional clocks
Thread-Index: AQHUHpbsRjZTxwyvBkOBkCNbvUsciKSU8fsAgAAEt4CAAAmi4A==
Date:   Wed, 18 Jul 2018 13:56:26 +0000
Message-ID: <OSBPR01MB1766E6AFE37986B2E2B5E35DF5530@OSBPR01MB1766.jpnprd01.prod.outlook.com>
References: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com>
 <20180718130228.GG17271@n2100.armlinux.org.uk>
 <CAMuHMdUjzVBXn-goAwbTBULfo=HrJEY6eBae4w7Z6qA-gScUUw@mail.gmail.com>
In-Reply-To: <CAMuHMdUjzVBXn-goAwbTBULfo=HrJEY6eBae4w7Z6qA-gScUUw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1605;7:eyRiZwyGf59/oQHqXkTQH0Ed+FTfncdgM5hoDBtCwAhvxbJXYS4yn/PYI72gFOZXT4YRGnBOYhgCA9lCXxTnNydhlQDhN5B0BOOkqedPWOJBqZhPXXg4rWr7HhOUnlxhyn+V1oQfN3TXizONI3lRRh8gCfn54u7fVPu14f1jsqpFj7jOtO9M7cZnDPnV6gB7c+Y02xtA1EmJuRnOBOTRGZsiNr4eo/3k0I7NJP+gRtPAuUmIBjydRhZfosPgF1ve;20:a8PMBSTUKVXQGaA/vcaKTaGNsMuySntuUvi3laefvtDhnxihw0Ch0yCjfwFZNOgoczGA+CapoLo/fG00hrjZE3bP67kejp5N0nc2Ze5XAzP/awKUO4keNQNDPDc+476C0NE22xKBdKXL9Xfj26bVDjGXaeeXYc41CFy9TMj7se4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5fa9325c-54f1-467e-0d85-08d5ecb6414b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1605;
x-ms-traffictypediagnostic: OSBPR01MB1605:
x-microsoft-antispam-prvs: <OSBPR01MB1605F3F3C426428B746035E9F5530@OSBPR01MB1605.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:OSBPR01MB1605;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1605;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(39860400002)(136003)(199004)(189003)(81156014)(81166006)(229853002)(8676002)(110136005)(106356001)(68736007)(6116002)(9686003)(105586002)(8936002)(3846002)(55016002)(316002)(54906003)(86362001)(6436002)(256004)(74316002)(305945005)(7736002)(2906002)(478600001)(66066001)(53546011)(4326008)(14454004)(6246003)(97736004)(11346002)(102836004)(5660300001)(6506007)(446003)(186003)(7696005)(5250100002)(486006)(99286004)(76176011)(25786009)(44832011)(33656002)(53936002)(26005)(2900100001)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1605;H:OSBPR01MB1766.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0tgcFyQJ53uumlBO7GuWCuILcBvVnjBIKUMsyAYE6NMRudlAd7i0qZ+ECBW5jAjIh4IxzMO2jtgePEV9dEUIFbOXbMnh/hlxTfz1CDmpuWXwuzNgPhF1H8P2zMZT1ybNH6iBXyXfxMv78JsZQ/4nA5+MGpoEdMXzqQuxZ3koYMUE0uj45lLvhYuRAlpyQgovxxrgKKz/IVmOgfI5oo+fTd2QFtq8vPcwIJxzNbk1ijxvlj08TGcsC48cVTQC+7Sj24LEXLKH2xjl+3UuHkmljrYAdC4phDdi+eE40nOsyFoaOsSzOXCnMqnNporGGllgYK5XPisTIAlqQYlIZFZFfw2/z28URfJMsTZZ7Q5tQQY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa9325c-54f1-467e-0d85-08d5ecb6414b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 13:56:26.4282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUnVzc2VsbCwNCg0KT24gMTggSnVseSAyMDE4IDE0OjE5LCBHZWVydCBVeXR0ZXJob2V2ZW4g
d3JvdGU6DQo+IE9uIFdlZCwgSnVsIDE4LCAyMDE4IGF0IDM6MDIgUE0gUnVzc2VsbCBLaW5nIC0g
QVJNIExpbnV4ICB3cm90ZToNCj4gPiBPbiBXZWQsIEp1bCAxOCwgMjAxOCBhdCAwMTo1NzozOFBN
ICswMTAwLCBQaGlsIEVkd29ydGh5IHdyb3RlOg0KPiA+ID4gQmVoYXZlcyB0aGUgc2FtZSBhcyAo
ZGV2bV8pY2xrX2dldCBleGNlcHQgd2hlcmUgdGhlcmUgaXMgbm8gY2xvY2sNCj4gPiA+IHByb2R1
Y2VyLiBJbiB0aGlzIGNhc2UsIGluc3RlYWQgb2YgcmV0dXJuaW5nIC1FTk9FTlQsIHRoZSBmdW5j
dGlvbg0KPiA+ID4gcmV0dXJucyBOVUxMLiBUaGlzIG1ha2VzIGVycm9yIGNoZWNraW5nIHNpbXBs
ZXIgYW5kIGFsbG93cw0KPiA+ID4gY2xrX3ByZXBhcmVfZW5hYmxlLCBldGMgdG8gYmUgY2FsbGVk
IG9uIHRoZSByZXR1cm5lZCByZWZlcmVuY2UNCj4gPiA+IHdpdGhvdXQgYWRkaXRpb25hbCBjaGVj
a3MuDQo+ID4NCj4gPiBIb3cgZG9lcyB0aGlzIHdvcmsgd2l0aCBub24tRFQgc3lzdGVtcywgd2hl
cmUgbG9va2luZyBhIGNsb2NrIHVwIHdoaWNoDQo+ID4gaXNuJ3QgeWV0IHJlZ2lzdGVyZWQgd2l0
aCBjbGtkZXYgcmV0dXJucyAtRU5PRU5UID8NCj4gPg0KPiA+IChjbGtkZXYgZG9lc24ndCBrbm93
IHdoZW4gYWxsIGNsb2NrcyBhcmUgcmVnaXN0ZXJlZCB3aXRoIGl0LikNCj4gDQo+IEdvb2QgcXVl
c3Rpb24uDQo+IA0KPiBJIGd1ZXNzIGFsbCBkcml2ZXJzIHRyeWluZyB0byBoYW5kbGUgb3B0aW9u
YWwgY2xvY2tzIHRoaXMgd2F5IGFyZSBhbHJlYWR5IGJyb2tlbg0KPiBvbiBub24tRFQgc3lzdGVt
cyB3aGVyZSBjbG9ja3MgbWF5IGJlIHJlZ2lzdGVyZWQgbGF0ZS4uLg0KDQpTbyBob3cgZG8gbm9u
LURUIHN5c3RlbXMgdGhhdCBsb29rIGEgY2xvY2sgdXAgd2hpY2ggaXNuJ3QgeWV0DQpyZWdpc3Rl
cmVkIHdpdGggY2xrZGV2LCBkZXRlcm1pbmUgdGhhdCBhbiBvcHRpb25hbCBjbG9jayBpcyB0aGVy
ZQ0Kb3Igbm90Pw0KDQpUaGFua3MNClBoaWwNCg==
