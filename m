Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3545ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B6220869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mog6YICE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B6220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeJSR0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:26:18 -0400
Received: from mail-eopbgr680044.outbound.protection.outlook.com ([40.107.68.44]:6368
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726968AbeJSR0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRM5a1fnG3+KaJeAF57MVnD6VReAxZlEb0sIhux8VIc=;
 b=mog6YICENxxlNW7ibDAy/dqjzZw45NUj3cxRMu+mvzpaqoA5xaUjAkc3EV2n9zt7nDKPg2HMhUukTAf/sLY00zx0rIEBE27YfO65MTXHyumqYU0AFriWpUQJgeqBooj3zbBSRC6p9+P3CMbAV46PjKeeCx0SylK7BQF2w4/+jdw=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB5656.namprd02.prod.outlook.com (20.177.230.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Fri, 19 Oct 2018 09:20:59 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8d0d:7d34:1d3:52d]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8d0d:7d34:1d3:52d%4]) with mapi id 15.20.1250.028; Fri, 19 Oct 2018
 09:20:58 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH 3/3] reset: reset-zynqmp: Adding support for Xilinx zynqmp
 reset controller.
Thread-Topic: [PATCH 3/3] reset: reset-zynqmp: Adding support for Xilinx
 zynqmp reset controller.
Thread-Index: AQHUZ4fA1zA78gLWpkCWGYOZmAAP3KUmRhGAgAADgPA=
Date:   Fri, 19 Oct 2018 09:20:58 +0000
Message-ID: <BYAPR02MB47108BCDC1AF5454F2DDF328C2F90@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20181020084107.28251-1-nava.manne@xilinx.com>
         <20181020084107.28251-4-nava.manne@xilinx.com>
 <1539939793.3395.2.camel@pengutronix.de>
In-Reply-To: <1539939793.3395.2.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB5656;6:uA2kTROrlLRa4UU1pVX4U3T0OeIIX1S8HmztD+Ff0sWzgI+ibuxq+9G/a0XA/s+MxaIDng9EeuWttpXd1zKNcFqAQzN10hnVQ0uJa6OGf1fvCr6akPOX5sfH+c6JArO/rhlz3VPYaTP6evNNjWf4nuwO+NpRhAUiESADmHfqCi7WMVmSoaWqG0J28mTQjAxxb5BOSy6gjaYIIagYmDChUM8VqkmXGLOelV2qLJN31FSOQnxjg9K2cvX7UOxKuDLZJGWyuotpIXCgXwW8b/OCR6gjN5jFGzEwkvwWt3OHUK3dFRDLHjCHWl6eRf9gJkWWMLIuCZVuaHISgUKlO5As09gUluywlehFqB7rgMPqVC0B0kCWo/U/dAMFAvATK3sdLz7qlTN8UxpjnR36/jUHLSiKtL8e82ewTI3kRudAEtH65/8pL2U1EujTPWIY2zLaTbUKa5APHBHnSKbQZveZbA==;5:SklEW6CjcQVZ9uCF84OkbqAu9RqnXq+LaIfGuiMYKvD2g9CxgERZ0TXXTwol8nFeAf/LBL1xB/bmiVFY5Sbk2IhaW6FwAPzR7wLvO4SYG2IK84LnQWPRIMT8vLfpZFaRNb69EDt6LgNAxRxE05nCbxFod4RXyb0m2V1loCS6cgs=;7:157+JF8O0xTqEtVHzhrPX5NwBTHSiJD7l3+mup1N1OhJWYo4rpw82fJ0WT/8VziODUIO5ox6pAW67zQ+RsUiTjBqfXvoOHeiDqhaa7VqRpqj+ki0fxwITZ3kyza/etOrUD/5rKe2pDJc8WcaDmoW0SlLtRu1B8pRZUi0Zsh67cV6+hlqJyh/2SPaDFOMYj6d3etBHrYl8GhFUxpxNKfv97kByqzxDkcqOBwfLn0jTDIJ8vFybVxCkX83b3Wk2V1w
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 801678b0-5ece-4305-6687-08d635a42e61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB5656;
x-ms-traffictypediagnostic: BYAPR02MB5656:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB5656C7CACD0290D7E4D3D0C0C2F90@BYAPR02MB5656.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(85827821059158)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB5656;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5656;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(396003)(136003)(189003)(13464003)(199004)(51914003)(486006)(74316002)(3846002)(476003)(305945005)(33656002)(97736004)(6506007)(8676002)(81166006)(81156014)(7696005)(53546011)(6436002)(76176011)(478600001)(8936002)(102836004)(4001150100001)(7736002)(9686003)(6246003)(53936002)(229853002)(446003)(2501003)(14454004)(186003)(5250100002)(71190400001)(71200400001)(26005)(11346002)(2906002)(55016002)(68736007)(105586002)(66066001)(106356001)(99286004)(25786009)(39060400002)(2201001)(5660300001)(86362001)(256004)(6116002)(110136005)(316002)(2900100001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5656;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sX/EjhDku3wBhoMdl7ihvMqUhtcv+YCALE5Q0eL7rzuJ85I7apnY1ZIUMiAyrx2L+gZ9mDM2/C/95SxhjhxSwAmdnbKXHQv5EQZuZ8KL23eyEu9AZOP9pXtbpzpjMaDbByBY4nizkTNAnlaE/hRTppzNNAU66jgyc5y6O2uKz9sLiK114Mq26OEFJRt/XrmzT51cYaalILFl8KgNje6G7yoxqQ9juqMh7x5f1XCXN8JwcKu7MAoHyAc5zoqKthIMKUNpeNMHpEy+GxouCztKGY0gx3PrCwyyz0pQhVGdubNJ4zGBv6UHKdy/1trTUQBqKvv4+C3mceo2KS7TClGFI9IE4I1aTJID/1bfWCOQnX0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801678b0-5ece-4305-6687-08d635a42e61
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 09:20:58.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcA0KDQpUaGFua3MgZm9yIHRoZSBxdWlja3MgcmVzcG9uc2UuLi4uDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcCBaYWJlbCBbbWFpbHRvOnAu
emFiZWxAcGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxOSwgMjAxOCAy
OjMzIFBNDQo+IFRvOiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmFtQHhpbGlueC5jb20+OyByb2Jo
K2R0QGtlcm5lbC5vcmc7DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBNaWNoYWwgU2ltZWsgPG1p
Y2hhbHNAeGlsaW54LmNvbT47IFJhamFuIFZhamENCj4gPFJBSkFOVkB4aWxpbnguY29tPjsgSm9s
bHkgU2hhaCA8Sk9MTFlTQHhpbGlueC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVs
QHZnZXIua2VybmVsLm9yZzsgY2hpbm5pa2lzaG9yZTM2OUBnbWFpbC5jb20NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAzLzNdIHJlc2V0OiByZXNldC16eW5xbXA6IEFkZGluZyBzdXBwb3J0IGZvciBY
aWxpbngNCj4genlucW1wIHJlc2V0IGNvbnRyb2xsZXIuDQo+IA0KPiBIaSBOYXZhLA0KPiANCj4g
T24gU2F0LCAyMDE4LTEwLTIwIGF0IDE0OjExICswNTMwLCBOYXZhIGtpc2hvcmUgTWFubmUgd3Jv
dGU6DQo+ID4gQWRkIGEgcmVzZXQgY29udHJvbGxlciBkcml2ZXIgZm9yIFhpbGlueCBaeW5xIFVs
dHJhU2NhbGUrIE1QU29DLg0KPiA+IFRoZSB6eW5xbXAgcmVzZXQtY29udHJvbGxlciBoYXMgdGhl
IGFiaWxpdHkgdG8gcmVzZXQgbGluZXMgY29ubmVjdGVkDQo+ID4gdG8gZGlmZmVyZW50IGJsb2Nr
cyBhbmQgcGVyaXBoZXJhbCBpbiB0aGUgU29jLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmF2
YSBraXNob3JlIE1hbm5lIDxuYXZhLm1hbm5lQHhpbGlueC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hh
bmdlcyBmb3IgdjE6DQo+ID4gCQktTm9uZS4NCj4gDQo+IEkgaGFkIGNvbW1lbnRzIG9uIFJGQyB2
MyB0aGF0IGFyZSBub3QgYWRkcmVzc2VkIHlldCwgc2VlIGJlbG93Lg0KPiANCg0KU29ycnksIEkg
aGF2ZSBtaXNzZWQgeW91ciBjb21tZW50cyAuIFdpbGwgZml4IGluIHRoZSBuZXh0IHZlcnNpb24u
DQoNClJlZ2FyZHMsDQpOYXZha2lzaG9yZS4NCg==
