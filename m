Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD614ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B08C206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DE+a4RkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B08C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeGQRGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:06:14 -0400
Received: from mail-sn1nam02on0066.outbound.protection.outlook.com ([104.47.36.66]:3563
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729641AbeGQRGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4mhu5I26UOpf+53z1X6/628ShpT98Lm2WSfr54kiAY=;
 b=DE+a4RkF80dMIaORdQ6AoJyKxaqOToh81q98z4R/92GrBGwwjhjwfqazUojWjGcoljYXyTxhFHP1SH+lwRvTQNP98MlHRk6OxFgjaryGCsGW2EZzAUtpHjXOP5rlg9oqhpMVZNIdipw5TqoArIutkmM28RspfMEqd9Di0bYeS+8=
Received: from CY1PR02MB2091.namprd02.prod.outlook.com (10.166.190.27) by
 CY1PR02MB1213.namprd02.prod.outlook.com (10.163.16.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Tue, 17 Jul 2018 16:32:42 +0000
Received: from CY1PR02MB2091.namprd02.prod.outlook.com
 ([fe80::4919:8491:1e24:d74f]) by CY1PR02MB2091.namprd02.prod.outlook.com
 ([fe80::4919:8491:1e24:d74f%5]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 16:32:36 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: RE: [PATCH] clk: clk-fixed-factor: Use new macro
 CLK_OF_DECLARE_DRIVER
Thread-Topic: [PATCH] clk: clk-fixed-factor: Use new macro
 CLK_OF_DECLARE_DRIVER
Thread-Index: AQHTtuf/CFgaaA2KSEWVdsmwI1dm/aPIOgOAgAAMc1CACWfIAIABDRAggEtTqACALvxzAIAC8YtwgDdBdoCADSlE0A==
Date:   Tue, 17 Jul 2018 16:32:36 +0000
Message-ID: <CY1PR02MB20915AA8CDBAF17050769628B75C0@CY1PR02MB2091.namprd02.prod.outlook.com>
References: <1520518500-5500-1-git-send-email-rajanv@xilinx.com>
 <152061989141.26240.15533446439693285034@swboyd.mtv.corp.google.com>
 <SN4PR0201MB3502AC253C8B1C9E57A83B7FB7DE0@SN4PR0201MB3502.namprd02.prod.outlook.com>
 <152113963269.111154.10395846178696174140@swboyd.mtv.corp.google.com>
 <SN4PR0201MB35029B265E608A24130BFEE2B7D70@SN4PR0201MB3502.namprd02.prod.outlook.com>
 <CY1PR02MB20914DBB65A193DED2BEED92B7870@CY1PR02MB2091.namprd02.prod.outlook.com>
 <152792163637.225090.8916381060805852261@swboyd.mtv.corp.google.com>
 <CY1PR02MB2091426610FC0037BB9EF61BB7670@CY1PR02MB2091.namprd02.prod.outlook.com>
 <153112117357.143105.12822043691712705626@swboyd.mtv.corp.google.com>
In-Reply-To: <153112117357.143105.12822043691712705626@swboyd.mtv.corp.google.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com; 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1213;7:jXzjkvkU8u2Sf6UIxIUnyeXuCRStFTJbUybWUqph6h++k7aYRjppEw4wdtwZA4yClkJFyJ9L5bl7Pe/Sogl8FzrGocWKJ9ApFadl3rY8X15sAypeBltx5YVzCJEyfn8Q31XgUXhLylAPGg674hgODR1nMj1FRERKfnBpV8g6O4fwh/J1ycJtuJ+WEPBJAHANm4By8RAa7AdHTO/bW7W/gDNoFvwUOS8MbgoAbLAPy05uNo8n77w5/EWpdk373KOe
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(39860400002)(376002)(13464003)(189003)(199004)(256004)(14444005)(7736002)(2900100001)(86362001)(26005)(25786009)(6506007)(102836004)(478600001)(99286004)(54906003)(305945005)(68736007)(72206003)(53546011)(3846002)(6116002)(93886005)(5250100002)(4326008)(5660300001)(74316002)(97736004)(106356001)(33656002)(7696005)(81156014)(186003)(446003)(2906002)(8676002)(81166006)(6246003)(9686003)(476003)(66066001)(486006)(966005)(55016002)(6436002)(76176011)(11346002)(316002)(8936002)(14454004)(229853002)(53936002)(6916009)(105586002)(6306002)(45080400002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1213;H:CY1PR02MB2091.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 45e091b4-b0d6-4c8e-63e0-08d5ec02e7f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1213;
x-ms-traffictypediagnostic: CY1PR02MB1213:
x-microsoft-antispam-prvs: <CY1PR02MB121342B71E22C957CD22D926B75C0@CY1PR02MB1213.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1213;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1213;
x-forefront-prvs: 073631BD3D
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rrsAHeeTtrjJ4QLWEk83eMCW1g7EEvJ7MOW/OpUoac05zk2w+HZIOBfA2bfKhwoodijxDjvNuJJuCb3+HkCylojjgwaD8rtjdXECQhH272h4X23BkcGyc/Ks33fsevEgSK9sShwytgtqXL6COD2iHv0fmSX7Vbfh3QpC9jQuHgia02h49CfFd/0rFIW0aSodOT3532UXyAdj6KO5ogzUyZMpHgeSJq+y1NK2OH8dRBGE0PpaYd1likvog1CS4HgI7H+GfnSueD1Kpsl3AcleasNj0P78i7u7k9Gz0QDfPf+JtpdMZXo55eXI3jlXdwFyIGwpHBEgaZWGbXlvrjo4kCQ7j69x/NeBsbj6jK6tPoE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e091b4-b0d6-4c8e-63e0-08d5ec02e7f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 16:32:36.8164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJuZWwub3JnXQ0KPiBTZW50OiAwOSBKdWx5IDIwMTgg
MTI6NTYgUE0NCj4gVG86IFJhamFuIFZhamEgPFJBSkFOVkB4aWxpbnguY29tPg0KPiBDYzogbGlu
dXgtY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSm9s
bHkgU2hhaA0KPiA8Sk9MTFlTQHhpbGlueC5jb20+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGls
aW54LmNvbT47DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tDQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0hdIGNsazogY2xrLWZpeGVkLWZhY3RvcjogVXNlIG5ldyBtYWNybw0KPiBDTEtfT0ZfREVDTEFS
RV9EUklWRVINCj4gDQo+IEVYVEVSTkFMIEVNQUlMDQo+IA0KPiBRdW90aW5nIFJhamFuIFZhamEg
KDIwMTgtMDYtMDMgMjA6NDE6MjcpDQo+ID4gPiA+ID4gPiA+IE9uIHRoZSBvdGhlciBoYW5kLCBl
dmVuIGlmIHJlZ2lzdHJhdGlvbiBmYWlsZWQsIHRoYXQgbm9kZSB3aWxsIGJlDQo+ID4gPiA+ID4g
PiA+IG1hcmtlZCBhcyBPRl9QT1BVTEFURUQsIHNvIHByb2JlIG9mIGNsay1maXhlZC1mYWN0b3Iu
YyB3aWxsIGFsc28NCj4gbm90DQo+ID4gPiA+ID4gPiA+IGJlIGNhbGxlZCBhbmQgdGhhdCBEVCBm
aXhlZC1mYWN0b3IgY2xvY2sgd291bGQgbmV2ZXIgYmUgcmVnaXN0ZXJlZC4NCj4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gU2FtZSB0aGluZyBpcyBkaXNjdXNzZWQgYXQgIGh0dHBzOi8vbGtt
bC5vcmcvbGttbC8yMDE3LzYvNS82ODEgLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE9rLiBJ
IGJlbGlldmUgdGhlIGFuc3dlciBpcyB0byBmaXggdGhlIERUIHRvIGRlc2NyaWJlIHRoZSBwYXJl
bnQgY2hhaW4NCj4gPiA+ID4gPiA+IHByb3Blcmx5IHdpdGggY2xvY2stb3V0cHV0LW5hbWVzLiBP
dGhlcndpc2UsIHdlIGhhdmUgbm8gZ29vZCB3YXkNCj4gb2YNCj4gPiA+ID4gPiA+IGZpZ3VyaW5n
IG91dCB3aGF0IHRoZSBuYW1lIHNob3VsZCBiZS4NCj4gPiA+ID4gPiBbUmFqYW5dIGNsb2NrIERU
IGJpbmRpbmcgZG9jIHNheXMgdGhhdCBjbG9jay1vdXRwdXQtbmFtZXMgcHJvcGVydHkNCj4gPiA+
ID4gPiBpcyBvcHRpb25hbCBhbmQgc29tZXRpbWVzIG5vdCByZWNvbW1lbmRlZC4NCj4gPiA+ID4g
PiBJIHRoaW5rIHRoaXMgcGF0Y2ggZml4ZXMgdGhlIGlzc3VlIHdlIGhhdmUgd2hpY2ggbWFuZGF0
ZXMgdG8gYWRkIGNsb2NrLQ0KPiA+ID4gb3V0cHV0LQ0KPiA+ID4gPiA+IG5hbWVzDQo+ID4gPiA+
ID4gcHJvcGVydHkgKGZvciB0aGlzIHBhcnRpY3VsYXIgY2FzZSkuIEFsc28sIElJVUMgcGxhdGZv
cm0gZHJpdmVyIHByb2JlIGluIGNsay0NCj4gPiA+IGZpeGVkLQ0KPiA+ID4gPiA+IGZhY3Rvci5j
DQo+ID4gPiA+ID4gd2lsbCBuZXZlciBiZSBjYWxsZWQgdW5sZXNzIHdlIHVzZSBDTEtfT0ZfREVD
TEFSRV9EUklWRVIuDQo+ID4gPiA+ID4gSSBjb21wbGV0ZWx5IGFncmVlIHRoYXQgcHJvcGVyIHNv
bHV0aW9uIHdvdWxkIGJlIHRvIHN0b3AgdXNpbmcgc3RyaW5ncyB0bw0KPiA+ID4gPiA+IGRlc2Ny
aWJlIGNsb2NrIHRvcG9sb2d5Lg0KPiA+ID4gPiBbUmFqYW5dIEFueSBjb21tZW50cyBvbiB0aGlz
Pw0KPiA+ID4gPiBVbmxlc3Mgd2UgaGF2ZSBwcm9wZXIgc29sdXRpb24gcmVhZHksIHdlIG5lZWQg
dG8gaGF2ZSBzb21lIG1lY2hhbmlzbQ0KPiB0bw0KPiA+ID4gaGFuZGxlIHRoaXMgc2NlbmFyaW8u
DQo+ID4gPiA+IGNsb2NrLW91dHB1dC1uYW1lcyBpcyBvcHRpb25hbCBhbmQgd2l0aG91dCB0aGlz
LCBpdCBtYW5kYXRlcyB0byB1c2UgY2xvY2stDQo+ID4gPiBvdXRwdXQtbmFtZXMuDQo+ID4gPiA+
DQo+ID4gPg0KPiA+ID4gSSBjb3VsZG4ndCByZWFkIHlvdXIgb3V0bG9vayBzZW50IGVtYWlsIGFu
ZCBJIHdhcyB0b28gYnVzeSB0byBnbw0KPiA+ID4gdHJhbnNsYXRlIGl0LiBTb21lIGJ1ZyBpbiBt
eSBNVUEgaXQgc2VlbXMuDQo+ID4gPg0KPiA+ID4gQ2FuIHlvdSBhZGQgdGhlIG91dHB1dC1uYW1l
cyBwcm9wZXJ0eT8gSW4gdGhpcyBjYXNlIGl0J3MgcHJhY3RpY2FsbHkNCj4gPiA+IG1hbmRhdG9y
eSwgc28gaWYgeW91IGNhbid0IGRvIGl0IEknZCBsaWtlIHRvIGhlYXIgd2h5IG5vdC4NCj4gPiBb
UmFqYW5dIEluIG91ciBjYXNlLCB3ZSBhcmUgZmlybXdhcmUgbWFpbnRhaW5zIGNsb2NrIGRhdGFi
YXNlIGFuZCBkcml2ZXINCj4gcXVlcnkgY2xvY2tzDQo+ID4gZnJvbSBmaXJtd2FyZSBhbmQgcmVn
aXN0ZXJzIGNsb2NrIGJhc2VkIG9uIGluZm9ybWF0aW9uIHJlY2VpdmVkIGZyb20NCj4gZmlybXdh
cmUuIFNvDQo+ID4gb3V0cHV0IGNsb2NrIG5hbWVzIGFyZSBub3QgZml4ZWQuDQo+ID4gaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDQzOTg5My8gLSBkdC1iaW5kaW5nczogY2xv
Y2s6IEFkZA0KPiBiaW5kaW5ncyBmb3IgWnlucU1QIGNsb2NrIGRyaXZlcg0KPiA+IGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA0Mzk4OTEvIC0gZHJpdmVyczogY2xrOiBBZGQg
WnlucU1QDQo+IGNsb2NrIGRyaXZlcg0KPiANCj4gb3V0cHV0LW5hbWVzIGFyZSBmaXhlZCBieSB0
aGUgdGltZSBmaXJtd2FyZSBpcyBtYWRlLiBJcyB0aGUgRFQgYWxzbw0KPiBmaXhlZCBieSB0aGUg
dGltZSBmaXJtd2FyZSBpcyBtYWRlPyBXaHkgY2FuJ3QgdGhlIERUIGJlIG1hZGUgdG8gbWF0Y2gN
Cj4gd2hhdCB0aGUgZmlybXdhcmUgaXMgZGVzY3JpYmluZyBieSBoYXZpbmcgdGhlIGZpcm13YXJl
IHVwZGF0ZSB0aGUgRFQgdG8NCj4gZGVzY3JpYmUgaXQncyBvdXRwdXQgbmFtZXM/DQpbUmFqYW5d
IFRoZSBpZGVhIGlzIHRvIGhhdmUgYSBnZW5lcmljIGRyaXZlciB3aGljaCBxdWVyaWVzIGNsb2Nr
IGZvciB0aGUgdmFyaWFudCBmcm9tDQpGaXJtd2FyZS4gU28gaWYgc29tZSBjbG9jayBjaGFuZ2Vz
LCBkcml2ZXIgcmVtYWlucyBzYW1lLg0KPiANCj4gQW5kIHdoYXQgaXMgdGhpcyBmaXhlZCBmYWN0
b3IgY2xrIGluIERUIGZvcj8NCj4gDQo+IEknbSBiZWdpbm5pbmcgdG8gdGhpbmsgdGhhdCBtYXli
ZSB3ZSBzaG91bGQgbWFrZSB0aGUgZml4ZWQgZmFjdG9yIHNldHVwDQo+IGEgbGl0dGxlIHdvcnNl
IGJ5IGhhdmluZyBpdCB1bm1hcmsgaXRzZWxmIGFzIE9GX1BPUFVMQVRFRCBpZiBpdCBmaW5kcw0K
PiB0aGF0IHRoZSBEVCBub2RlIGhhcyBhIGNsb2NrcyBwcm9wZXJ0eSB0aGF0IGl0IGNhbid0IGZp
bmQgYSBuYW1lIGZvci4NCj4gSG9wZWZ1bGx5IHdlIGNhbiBnZXQgYnkgd2l0aCBpdCByZWdpc3Rl
cmluZyBsYXRlciBvbiBiZWNhdXNlIGl0IGlzbid0DQo+IGNyaXRpY2FsIGZvciB0aGUgc3lzdGVt
IHRvIGJvb3RzdHJhcCBpbnRlcnJ1cHRzIGFuZCB0aW1lcnMuDQpbUmFqYW5dIEkgaGF2ZSBzdWJt
aXR0ZWQgc2VwYXJhdGUgY2hhbmdlIGZvciB0aGlzIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcGF0Y2gvMTA1MjkzODcvLiANCg0KPiANCj4gSSB0YWtlIGl0IHlvdSB1bmRlcnN0YW5kIHRo
YXQgY2hhbmdpbmcgdGhlIGNvZGUgdG8gYmUNCj4gQ0xLX09GX0RFQ0xBUkVfRFJJVkVSIHdpbGwg
YmUgYWN0aXZlbHkgYmFkIGFuZCBjYXVzZSB0aGUgY2xrIHRvIGJlDQo+IHJlZ2lzdGVyZWQgcG90
ZW50aWFsbHkgdHdpY2Ugc28gd2UgcmVhbGx5IG5lZWQgdG8gZml4IHRoZSByZWFsIGlzc3VlDQo+
IHdoaWNoIGlzIHRoYXQgdGhlIHBhcmVudCBuYW1lIGNhbid0IGJlIGZpZ3VyZWQgb3V0IHVudGls
IGxhdGVyIG9uLCBzbw0KPiB0aGUgQ0xLX09GX0RFQ0xBUkUgcGF0aCBuZWVkcyB0byBmYWlsIHdo
ZW4gaXQgY2FuJ3QgZmluZCB0aGUgcGFyZW50IGl0DQo+IG5lZWRzIGFuZCB0aGVuIG1hbnVhbGx5
IG1hcmsgaXRzZWxmIGFzIG5vdCBwb3B1bGF0ZWQgaW4gdGhhdCBjYXNlIHNvDQo+IHRoYXQgaXQg
cHJvYmVzIGxhdGVyIG9uIHdpdGggdGhlIHBsYXRmb3JtIGRldmljZSBkcml2ZXIuIFVubWFya2lu
ZyB0aGUNCj4gbm9kZSBjYW4gYWN0dWFsbHkgYmUgdXNlZCB0byBmbGFnIGEgZmFpbHVyZSBpbiB0
aGUgaW5pdCBmdW5jdGlvbiBzbyB0aGF0DQo+IHdlIGRvbid0IGtlZXAgdHJ5aW5nIHRvIGRvIHRo
aW5ncyB3aXRoIHRoZSBub2RlIHVudGlsIGRyaXZlciB0aW1lIHRvby4NCltSYWphbl0gSSB1bmRl
cnN0b29kIHRoYXQgbWFraW5nIGl0IENMS19PRl9ERUNMQVJFX0RSSVZFUiB3aWxsIHRyeSB0byBy
ZWdpc3RlciBjbG9jayB0d2ljZS4gDQoNCg==
