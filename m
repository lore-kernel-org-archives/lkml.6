Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD4C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5D7204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qf9TlPKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5D7204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbeF1MNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:13:37 -0400
Received: from mail-cys01nam02on0071.outbound.protection.outlook.com ([104.47.37.71]:62714
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753388AbeF1MNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+3PWqQxnM/a5rS7ZjdwKAfi73KwyvfJPykA+oRgcuo=;
 b=qf9TlPKuM9lfHPYDuqlh/ZHWE0NQ9GWQEg8X95cyfTucf6ejbn0dEDnUFV9xQVu26WAdcUQSGTh4pCYBTmQcbhxDELYmoVgpVcQ7OzFnvYnRNJp4AMmOYLkXxMdpatViZ9AU9Rers7O/ouzQsQAzYwR16ZAItx1RRwFRRAU5Xig=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3376.namprd02.prod.outlook.com (10.164.187.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Thu, 28 Jun 2018 12:13:33 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b%8]) with mapi id 15.20.0884.025; Thu, 28 Jun 2018
 12:13:31 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        =?utf-8?B?TWlxdcOobCBSYXluYWw=?= <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Thread-Topic: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver
 for arm pl353 smc nand interface
Thread-Index: AQHUCSslFhIqNZ8rp0qjyj+1AxTyIaR1VRMAgABKm0A=
Date:   Thu, 28 Jun 2018 12:13:31 +0000
Message-ID: <MWHPR02MB26232270DED605627B2CF22FAF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CACRpkdaEsEAiGpieJK1AA8HHLzZc7Tdc932rhdayg06rFU1hNA@mail.gmail.com>
In-Reply-To: <CACRpkdaEsEAiGpieJK1AA8HHLzZc7Tdc932rhdayg06rFU1hNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3376;7:vh8Lj9e8xEL129c0Na8kmfdtQnplRoIkwF7PqXAtPAHFMcx1UWAPKM2mKcgCQZo6z9QP6LIHQwrpXAvwuPHX7llsUz14rS2npunLeK0tU/OJVp8m/d9ykPE+zaXAzqTIWdCoL+DImBTcprXza3dc51aEI0lLT5mGTAHkxknStR3B2zV7grJbbNPnjinBUezkXoTvC+Wq9tQNzpUDdSnj01WgqWozmTOFUXZsRyKnHvf1c2I5wBA0wLeMhofHUOfb
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(346002)(376002)(136003)(366004)(396003)(57704003)(13464003)(199004)(189003)(6116002)(99286004)(102836004)(6346003)(39060400002)(76176011)(55236004)(26005)(97736004)(256004)(107886003)(2906002)(186003)(4326008)(25786009)(478600001)(33656002)(6506007)(345774005)(486006)(14444005)(7696005)(6916009)(476003)(53936002)(53546011)(446003)(11346002)(6246003)(86362001)(55016002)(6436002)(5250100002)(5660300001)(106356001)(9686003)(105586002)(7416002)(229853002)(2900100001)(8676002)(3846002)(8936002)(14454004)(54906003)(316002)(305945005)(81166006)(7736002)(81156014)(68736007)(66066001)(74316002)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3376;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 4b28f39e-c1a8-4dd4-bb6f-08d5dcf09093
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3376;
x-ms-traffictypediagnostic: MWHPR02MB3376:
x-microsoft-antispam-prvs: <MWHPR02MB3376B3879AD349E6A5C66DD2AF4F0@MWHPR02MB3376.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB3376;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3376;
x-forefront-prvs: 0717E25089
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-microsoft-antispam-message-info: uL13mXs/qjJWR0VKx8A9EY5hbcUwdzu9HVzqyMZcL4eHgnilkT8vwxHUOsq2RekMKsaGhGE6h94DZHZRLLDAvJFflXpXm6bcW282S6jyF2fX89GNVcWVZ5uJrcMdjj3+ZDpWPLoT9BvoFkeoXPNXKcQIR2aq1E6x5UAP1yVXv2957X55fE3AYHhy3gXa4K5P4H+ZL0W8P7b38kJGThPtWtpzPB3Ig8tRkxH+VtikPrZSQpbfanGl8XSxwguzOKqHR1ZzI8q7x56EEGR/1iXcvGf19byg6TFgLKL2DAdUTAeengtYC0mtBElVB2WsDw1k97AuHukC32E/zD9NnsNC82rHor6JdsG92Fwy6/aGah4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b28f39e-c1a8-4dd4-bb6f-08d5dcf09093
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 12:13:31.7084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMg
V2FsbGVpaiBbbWFpbHRvOmxpbnVzLndhbGxlaWpAbGluYXJvLm9yZ10NCj4gU2VudDogVGh1cnNk
YXksIEp1bmUgMjgsIDIwMTggMToxNCBQTQ0KPiBUbzogTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8
bmFnYXN1cmVAeGlsaW54LmNvbT4NCj4gQ2M6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemls
bG9uQGJvb3RsaW4uY29tPjsgUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD47DQo+
IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47IEJyaWFuIE5vcnJpcw0KPiA8
Y29tcHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tPjsgTWFyayBWYXN1dCA8bWFyZWsudmFzdXRAZ21h
aWwuY29tPjsgRmxvcmlhbiBGYWluZWxsaQ0KPiA8Zi5mYWluZWxsaUBnbWFpbC5jb20+OyBNYXJr
dXMgTWF5ZXIgPG1tYXllckBicm9hZGNvbS5jb20+OyBSb2dlciBRdWFkcm9zDQo+IDxyb2dlcnFA
dGkuY29tPjsgTGFkaXNsYXYgTWljaGwgPGxhZGlzQGxpbnV4LW1pcHMub3JnPjsgYWRhQHRob3Jz
aXMuY29tOw0KPiBob25naHVpLnpoYW5nQG1lZGlhdGVrLmNvbTsgTWlxdcOobCBSYXluYWwgPG1p
cXVlbC5yYXluYWxAYm9vdGxpbi5jb20+OyBsaW51eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5hZ2FzdXJlc2hrdW1hcnJlbGxpQGdt
YWlsLmNvbTsNCj4gTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbW0xJTlVYIFBBVENIIHYxMF0gNC80XSBtdGQ6IHJhd25hbmQ6IHBsMzUzOiBBZGQgYmFz
aWMgZHJpdmVyIGZvciBhcm0NCj4gcGwzNTMgc21jIG5hbmQgaW50ZXJmYWNlDQo+IA0KPiBPbiBU
aHUsIEp1biAyMSwgMjAxOCBhdCA4OjQzIEFNIE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkNCj4gPG5h
Z2Euc3VyZXNoa3VtYXIucmVsbGlAeGlsaW54LmNvbT4gd3JvdGU6DQo+IA0KPiBUaGFuayB5b3Ug
Zm9yIHlvdXIgcGF0Y2ghDQo+IA0KPiA+IEFkZCBkcml2ZXIgZm9yIGFybSBwbDM1MyBzdGF0aWMg
bWVtb3J5IGNvbnRyb2xsZXIgbmFuZCBpbnRlcmZhY2Ugd2l0aA0KPiA+IEhXIEVDQyBzdXBwb3J0
LiBUaGlzIGNvbnRyb2xsZXIgaXMgdXNlZCBpbiBYaWxpbnggWnlucSBTb0MgZm9yDQo+ID4gaW50
ZXJmYWNpbmcgdGhlIE5BTkQgZmxhc2ggbWVtb3J5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0KPiA+IDxuYWdhLnN1cmVzaGt1bWFyLnJlbGxpQHhpbGlu
eC5jb20+DQo+IA0KPiBUaGlzIGRyaXZlciBoYXMgdGhlIHNhbWUgcHJvYmxlbSBhcyB0aGUgb3Ro
ZXIgcGF0Y2hlczoNCj4gdXNlIHRoZSBBUk1fQU1CQSBwcmltZWNlbGwgbWFnaWMgbnVtYmVycyBk
ZXRlY3Rpb24sIGFuZCB0aGUgUHJpbWVDZWxsIGJ1cy4NCkhlcmUgdGhlIGNoaWxkIGlzIE5BTkQg
Y29udHJvbGxlciBhbmQgdGhlIHBhcmVudCBpcyBQTDM1MyBTTUMsIA0Kc28gZG8gd2UgbmVlZCB0
byB1cGRhdGUgdGhpcyBhbHNvIGFzIEFNQkEgZHJpdmVyPw0KDQpUaGFua3MsDQpOYWdhIFN1cmVz
aGt1bWFyIFJlbGxpDQoNCg0KPiANCj4gT3RoZXJ3aXNlIGl0IGxvb2tzIGdvb2QgdG8gbWUhDQo+
IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K
