Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348D6C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D619220856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="sRV34d/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D619220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbeGXPdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:33:47 -0400
Received: from mail-eopbgr30096.outbound.protection.outlook.com ([40.107.3.96]:45074
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388460AbeGXPdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdRc+SmCthAGZ0BfR6Lwj5JhrnFRHPg3+xMt0NzolVc=;
 b=sRV34d/bZxTlO97pM4WgcTb5jzC9MeGRkSTcRrFs0O/IPScvhhDf42ahx5T3RLiX1W+yn/qM6qX9Cpjwp+ma6Pipf3eUr7RiDUsju/9k59V9ywSuP+ypq0vjygGhb9NMXWKkIQJAl3BVwmN0Z1PHycM00YeoAIstkNpvzmIR94s=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2494.eurprd05.prod.outlook.com (10.168.136.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Tue, 24 Jul 2018 14:26:59 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 14:26:59 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "digetx@gmail.com" <digetx@gmail.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 01/28] ARM: tegra: apalis_t30: enable broken-hpi on emmc
Thread-Topic: [PATCH 01/28] ARM: tegra: apalis_t30: enable broken-hpi on emmc
Thread-Index: AQHUIdwHffQ5dkRq20eMTdGpauMmpqSeaoIAgAAGhQA=
Date:   Tue, 24 Jul 2018 14:26:58 +0000
Message-ID: <1532442416.6124.28.camel@toradex.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
         <20180722164936.20581-2-marcel@ziswiler.com> <1992775.WBgY65Ajyy@dimapc>
In-Reply-To: <1992775.WBgY65Ajyy@dimapc>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2494;6:ffuFu4IbceCSPLNO91kS4+MWyys+FB68/ct1JOfZUatYFe9Ah62vDvEQS0akDkr0XdX/YyqQyFxty9aabpOezm0gDNjAG3Yea9R5r2ae76uL1T4qp5kbqO6Ob+lCHNwMhEy5S1PvKIpVFNUbEJf7bAMoYDuPnMnbj6y6AoGW9x9aVucUOZ79lFrMpuvvxrTj2+aTt7aORkuuiWTlWiEUSh5s+e8E5enqKCP4G2/gqm49kExz4dtakssu5jznXQwcbq4VfNLPk2kzL4BjW9oH2hqg2zvB0f8VxU8muGEin7xPQCRTfGjfPSCk+RflXueJYXbl4nvBE/rptYjmjmtU+YF8asTWCUYLdFiNH/SO9VrOT611JXvumUubdIKzknpFclfjwaTB/g7GzAQhvg/J8lgV75rh3SDYQiSlFdzlsyq8z2iCp+iQP5gr/w+jr8PKdU8w60Kspqleo2t5F0A5jA==;5:nAFnmwsQMiaaI6oB5+8P+Mwg1nyAX3pdRbxGUjB7fBPdQfz+MyWxbu75zKLCdifnwxIiVxflfGRXcJOLJZBYuqkTyiyuPv0P0mgOtn7ABNtHIyMbvslD0LrHSTK119MHQYXYVs3DWuDQOnKcYYrC8DzEaiwg4kywsqqzU2Zuusw=;7:Q/Elv7uj+3WaR2oqsSr2x4Hcor/oCNXN1BUzFTtDqhc0/iGB0bigm4+TCxL+wCFFzaf6nW404LISKIMKYFSglK8T1OD0zIIzwG5psLW16wUsmGLWvBNk8+dqxfTW5kuj2CoLvYc/4zMOhKFGnQtCYCmuf89T5i+HyRfz+KRx6EEEeeK1Y7Qhc4y9MCiizxVjDYjGEwrkv0BQ/mU+34KB3oR9FO57AcZrDhAB+YYCV0TgoR1YMEQIxs6MOLaghaY7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e519a1c2-3926-4f3c-3d83-08d5f17183f4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2494;
x-ms-traffictypediagnostic: VI1PR0501MB2494:
x-microsoft-antispam-prvs: <VI1PR0501MB24946556E9773B58F0EEF510FB550@VI1PR0501MB2494.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2494;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2494;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(7736002)(103116003)(76176011)(102836004)(6916009)(486006)(446003)(2616005)(476003)(11346002)(6506007)(44832011)(26005)(36756003)(186003)(305945005)(5640700003)(8936002)(54906003)(99286004)(68736007)(6436002)(316002)(229853002)(6486002)(1361003)(6512007)(1411001)(81166006)(81156014)(8676002)(2906002)(1730700003)(2900100001)(5250100002)(5660300001)(3846002)(6116002)(53936002)(2501003)(25786009)(6246003)(39060400002)(2351001)(97736004)(106356001)(105586002)(14454004)(478600001)(66066001)(86362001)(256004)(14444005)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2494;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 64aHTZaTceu/Z4ioQUIEXBECd8iZQ/SLVzuB8XD8PhB0oZ3mNAYbzqovl6SkaFGw55bNXMLyUZdwaEk6tx8RODs3r1VYBp4VzBzp64WZhyhifjrZYzyCWQV8ix8OCluJqmjAIjisy1BqxvxY6OWmBv2ZBZT9h3D+8CldnaGUKVIm9AIQ6mZ0ps56udta+pTldqWxBlOtmEFReuoowjw7UJK6PW0kpZgpUrDoD9rBy0jftqMtr/W7Gun5tpIwISCrjygC+zpLOOimltOTJNKSmeQSJXfv4M9moDgf+tTmmvjTlhD3nB+LMtFPCv1epb0xIcWJrTK7wT5BwMVXulUNICryzaq0rFoO85MXDT4BauE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BBD8A1BD91E8D439C0DA234949EB48E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e519a1c2-3926-4f3c-3d83-08d5f17183f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 14:26:58.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTI0IGF0IDE3OjAzICswMzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6
DQo+IE9uIFN1bmRheSwgMjIgSnVseSAyMDE4IDE5OjQ5OjA5IE1TSyBNYXJjZWwgWmlzd2lsZXIg
d3JvdGU6DQo+ID4gRnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRl
eC5jb20+DQo+ID4gDQo+ID4gQXZvaWQgZU1NQyBpc3N1ZXMgYnkgc3BlY2lmeWluZyBicm9rZW4t
aHBpLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnpp
c3dpbGVyQHRvcmFkZXguY29tPg0KPiA+IA0KPiA+IC0tLQ0KPiANCj4gSXMgaXQgYSBzcGVjaWZp
YyBlTU1DIGNhcmQgbW9kZWwgdGhhdCBoYXMgYnJva2VuIEhQSSBvciBpdCBpcyBhIGhvc3QgDQo+
IGNvbnRyb2xsZXIgYnVnPw0KDQpUaGF0IGlzIGEgdmVyeSBnb29kIHF1ZXN0aW9uLiBTbyBmYXIg
d2Ugb25seSBoYXZlIGNvbmZpcm1hdGlvbiB0aGF0IGF0DQpsZWFzdCBzb21lIGVNTUNzIGZyb20g
SHluaXggcmVzcC4gU0tIeW5peCBkZWZpbml0ZWx5IGRvIGhhdmUgYmFkDQpmaXJtd2FyZS4gSSBh
bHNvIGZvdW5kIG91dCB0aGF0IEFTVVMgcmVzcC4gR29vZ2xlIGRpZCBkaXNhYmxlIEhQSSBvbg0K
dGhlaXIgTmV4dXMgNyB0YWJsZXQuIFRoZXJlZm9yZSwgd2UgYWxzbyBkaXNhYmxlZCBIUEkgcXVp
dGUgYSB3aGlsZSBhZ28NCmluIG91ciBkb3duc3RyZWFtIEJTUHMgd2hpY2ggd2Ugc3VjY2Vzc2Z1
bGx5IHZhbGlkYXRlZCAmIHZlcmlmaWVkIGRvaW5nDQpwb3dlciBjdXRzIGFuZCBydW5uaW5nIHN0
cmVzcyB0ZXN0cyBpbiBvdXIgdGVtcGVyYXR1cmUgY2hhbWJlcnMuIEkNCmd1ZXNzIHdlIHdvdWxk
IGhhdmUgdG8gcnVuIG1vcmUgZXh0ZW5zaXZlIHRlc3RzIHdpdGggbWFpbmxpbmUgd2l0aCBhbmQN
CndpdGhvdXQgdGhpcyBzZXR0aW5nIHRvIGJlIGFibGUgdG8gcmVhbGx5IGFuc3dlciB5b3VyIHF1
ZXN0aW9uLiBGb3Igbm93DQpJIGp1c3Qgc3VjY2Vzc2Z1bGx5IHJ1biBhIGZldyBBcGFsaXMgVDMw
IGFuZCBDb2xpYnJpIFQzMCBtb2R1bGVzIHdpdGgNCnRoaXMgc2V0dGluZyBvdmVyIHRoZSB3ZWVr
ZW5kIGRvaW5nIGJvdGggaGRwYXJtIC10IGFzIHdlbGwgYXMgZGRpbmcNCnNvbWUgdXJhbmRvbSBm
aWxlcyB0byB0aGUgZU1NQyBpbiBhIGxvb3Agd2l0aG91dCBzZWVpbmcgYW55IGlzc3Vlcy4=
