Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52A9C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3418024099
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NSdnJl39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3418024099
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbeF2EP3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 00:15:29 -0400
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:11940
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752987AbeF2EP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 00:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtu8TH5e55mL51d8MTv2yYes1ZnnZRToJyVT95BPUco=;
 b=NSdnJl39F2HwL16ceSJCUwO+ZBfDF7tF14/RkniAsD4N7oTsscai7bJCHVt2l7fLYiF2qRw5iJFE+Od0AgUmh59eGEeHycZp84wfZlO9moeu6aouAiSaZ4C5Q114uRXM2Rk3kKVWiC33xOfESxzx9YioNgAEaqilimrICvvPZn4=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2573.namprd02.prod.outlook.com (10.168.205.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Fri, 29 Jun 2018 04:15:26 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b%8]) with mapi id 15.20.0884.025; Fri, 29 Jun 2018
 04:15:24 +0000
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
Thread-Index: AQHUCSslFhIqNZ8rp0qjyj+1AxTyIaR1VRMAgABKm0CAAGVwgIAApGBg
Date:   Fri, 29 Jun 2018 04:15:24 +0000
Message-ID: <MWHPR02MB26239876530B0F5C95289A56AF4E0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CACRpkdaEsEAiGpieJK1AA8HHLzZc7Tdc932rhdayg06rFU1hNA@mail.gmail.com>
 <MWHPR02MB26232270DED605627B2CF22FAF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <CACRpkdZb6NMHtai1DBa+7m2ieZJZiAB7d1vSuP376rHQKpOf+A@mail.gmail.com>
In-Reply-To: <CACRpkdZb6NMHtai1DBa+7m2ieZJZiAB7d1vSuP376rHQKpOf+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2573;7:bgDszgjYGaOso1mKkEUWUnFepub8mPuw1JfRXL6t0zEId6RgY5TiLyUO0expak5GBPNgSBG1GbyVhpkXCVi+kDV4i0UhmZ5mleq7JiNQPimn6q9ERIrtcxkTXYBTciJuaikzEs5Ewy63aYySm5A4UE6+JOthCbSXDGjVF9DSpe3/yaAlNLNOEjgWs6yOl1QXstZuXpS76KJrtZ2NSa1A+JV1eyNj+jAeqacKf2UMWkGbIka+yB/ZqHHG3cdbTysm
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39860400002)(376002)(396003)(189003)(199004)(13464003)(53936002)(68736007)(6116002)(6916009)(5660300001)(3846002)(6246003)(26005)(7736002)(33656002)(305945005)(8936002)(8676002)(81156014)(97736004)(25786009)(14454004)(186003)(256004)(14444005)(478600001)(81166006)(39060400002)(107886003)(7416002)(2906002)(106356001)(74316002)(4326008)(55016002)(53546011)(316002)(66066001)(486006)(11346002)(7696005)(6436002)(476003)(99286004)(105586002)(9686003)(54906003)(229853002)(76176011)(446003)(93886005)(102836004)(6506007)(2900100001)(55236004)(5250100002)(86362001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2573;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 60c6288b-8eb2-4653-d255-08d5dd76f008
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2573;
x-ms-traffictypediagnostic: MWHPR02MB2573:
x-microsoft-antispam-prvs: <MWHPR02MB25732599943A6514A20F5B4CAF4E0@MWHPR02MB2573.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2573;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2573;
x-forefront-prvs: 0718908305
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KGDlPSUyG9MkVe2yFfFCBJUVd3tFBu4pq1Sm+9/Vehvl8xWszCMzXjsm21TuLKYXNbvxElvxup5suE+UxtUKqN47az75fqSRS892lJG/iXhu2yIETSXsn9Puuq8BMeSR4dD/ycfVlFjkT+JZCfEPUnqLy3IOHwjJ860QZSmmFWfcAMhpGmKs7CAMfBtJyq8R49kZ8xTzseeiXvjGRr8D795hAy3cSDb5pt8876qmkDF9J7sqHDh3naqa5Wu+O6ywNyIIzRZ9zt5zIO2VW5O8bplfDn5j6jfSEk3KIJwbpKqlr2Ufk6Ttg2RYvfxAL6g6S4ayUVk6s1b3H4ogsqGBPOyEKLD3rtm3J8kAbJa0LCI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c6288b-8eb2-4653-d255-08d5dd76f008
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 04:15:24.4741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMg
V2FsbGVpaiBbbWFpbHRvOmxpbnVzLndhbGxlaWpAbGluYXJvLm9yZ10NCj4gU2VudDogVGh1cnNk
YXksIEp1bmUgMjgsIDIwMTggMTE6NDQgUE0NCj4gVG86IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkg
PG5hZ2FzdXJlQHhpbGlueC5jb20+DQo+IENjOiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXpp
bGxvbkBib290bGluLmNvbT47IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+Ow0K
PiBEYXZpZCBXb29kaG91c2UgPGR3bXcyQGluZnJhZGVhZC5vcmc+OyBCcmlhbiBOb3JyaXMNCj4g
PGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbT47IE1hcmsgVmFzdXQgPG1hcmVrLnZhc3V0QGdt
YWlsLmNvbT47IEZsb3JpYW4gRmFpbmVsbGkNCj4gPGYuZmFpbmVsbGlAZ21haWwuY29tPjsgTWFy
a3VzIE1heWVyIDxtbWF5ZXJAYnJvYWRjb20uY29tPjsgUm9nZXIgUXVhZHJvcw0KPiA8cm9nZXJx
QHRpLmNvbT47IExhZGlzbGF2IE1pY2hsIDxsYWRpc0BsaW51eC1taXBzLm9yZz47IGFkYUB0aG9y
c2lzLmNvbTsNCj4gaG9uZ2h1aS56aGFuZ0BtZWRpYXRlay5jb207IE1pcXXDqGwgUmF5bmFsIDxt
aXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPjsgbGludXgtDQo+IG10ZEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuYWdhc3VyZXNoa3VtYXJyZWxsaUBn
bWFpbC5jb207DQo+IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPg0KPiBTdWJqZWN0
OiBSZTogW1tMSU5VWCBQQVRDSCB2MTBdIDQvNF0gbXRkOiByYXduYW5kOiBwbDM1MzogQWRkIGJh
c2ljIGRyaXZlciBmb3IgYXJtDQo+IHBsMzUzIHNtYyBuYW5kIGludGVyZmFjZQ0KPiANCj4gT24g
VGh1LCBKdW4gMjgsIDIwMTggYXQgMjoxMyBQTSBOYWdhIFN1cmVzaGt1bWFyIFJlbGxpIDxuYWdh
c3VyZUB4aWxpbnguY29tPiB3cm90ZToNCj4gDQo+IA0KPiA+ID4gVGhpcyBkcml2ZXIgaGFzIHRo
ZSBzYW1lIHByb2JsZW0gYXMgdGhlIG90aGVyIHBhdGNoZXM6DQo+ID4gPiB1c2UgdGhlIEFSTV9B
TUJBIHByaW1lY2VsbCBtYWdpYyBudW1iZXJzIGRldGVjdGlvbiwgYW5kIHRoZSBQcmltZUNlbGwg
YnVzLg0KPiA+DQo+ID4gSGVyZSB0aGUgY2hpbGQgaXMgTkFORCBjb250cm9sbGVyIGFuZCB0aGUg
cGFyZW50IGlzIFBMMzUzIFNNQywgc28gZG8NCj4gPiB3ZSBuZWVkIHRvIHVwZGF0ZSB0aGlzIGFs
c28gYXMgQU1CQSBkcml2ZXI/DQo+IA0KPiBObywgc29ycnkuIFRoZSBwYXJlbnQgaXMgc3Bhd25p
bmcgYW5vdGhlciBkZXZpY2UgYW5kIHlvdSBzaG91bGQgaW5kZWVkIHVzZSBhIHBsYXRmb3JtIGRl
dmljZQ0KPiBmb3IgdGhhdC4NCj4gDQpPaywgeW91IG1lYW4gcGxhdGZvcm0gZHJpdmVyIG1vZGVs
IGlzIHN1ZmZpY2llbnQgZm9yIGJvdGggcGwzNTMtc21jLmMgYW5kIHBsMzUzX25hbmQuYyBkcml2
ZXJzPw0KT3IgQU1CQSBtb2RlbCBpcyBmb3IgcGwzNTMtc21jIGFuZCBwbGF0Zm9ybSBkcml2ZXIg
bW9kZWwgaXMgZm9yIHBsMzUzLW5hbmQ/DQoNClRoYW5rcywNCk5hZ2EgU3VyZXNoa3VtYXIgUmVs
bGkuDQoNCj4gRm9yZ2V0IHRoaXMgY29tbWVudC4NCj4gDQo+IFlvdXJzLA0KPiBMaW51cyBXYWxs
ZWlqDQo=
