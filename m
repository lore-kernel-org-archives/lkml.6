Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417D0C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE15B27333
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3NrLa8G9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE15B27333
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934744AbeF1MMA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:12:00 -0400
Received: from mail-eopbgr730042.outbound.protection.outlook.com ([40.107.73.42]:11990
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753388AbeF1ML6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htKkAr4GJKqmypw2USB0IJCk3fhPJ15T89bJCZMwE8E=;
 b=3NrLa8G9PalTCee/5TK8IDkB9TtuHOvKE8eurU9/1BKngreNjJuTCsEHb3U/lyLESfPAK57CG5RvooSHZazr5q/jr2yFjrLYx8fnDJnFoTLszmroJkmDh2FJXExZCjExhqywEgydJBeuPtDA2Dx0FMFTJ5BnRCC25Gjdgg/jUqU=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2493.namprd02.prod.outlook.com (10.168.205.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 12:11:51 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b%8]) with mapi id 15.20.0884.025; Thu, 28 Jun 2018
 12:11:51 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>
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
Subject: RE: [[LINUX PATCH v10] 2/4] memory: pl353: Add driver for arm pl353
 static memory controller
Thread-Topic: [[LINUX PATCH v10] 2/4] memory: pl353: Add driver for arm pl353
 static memory controller
Thread-Index: AQHUCSsdwhX6BzH85km0F+Edq0u1GaR1Re8AgABN/1CAAAvjYA==
Date:   Thu, 28 Jun 2018 12:11:50 +0000
Message-ID: <MWHPR02MB2623984A51810CCAB597A9B5AF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1529563351-2241-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CACRpkdZiY2vAXQSuAgjKfHKtYT_UZD-apEbpS1RT5ZGFutYQeA@mail.gmail.com>
 <MWHPR02MB2623C017D4A632F7A25FFD27AF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB2623C017D4A632F7A25FFD27AF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2493;7:kclc2XwHG2vQbSbwedzvZixzPaD+gUS6thEgeQKkH3uit0YljkdNx7Nku7wnDGzGL8pxt+9xLRqCJATU2dqstTVTJNAW6SI4sdKWml5mImmNRkkIaBNArWJl2mv8yp9RhkMmlkydEyVmhFeCkVSuo22epa2tRf+l2ZkLSqsWhEQVBz3BOFALbjzqADGhouxhyxmHY06tY1VJnq1kTf7GX8rB/jSdEmQmkH6ipHuM7TALcAFeoJq4c2UfghcMa56n
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(189003)(199004)(51914003)(13464003)(6246003)(107886003)(97736004)(316002)(7696005)(2906002)(53936002)(25786009)(2940100002)(7416002)(105586002)(4326008)(54906003)(110136005)(76176011)(305945005)(229853002)(39060400002)(106356001)(74316002)(33656002)(2900100001)(66066001)(14454004)(7736002)(6116002)(5660300001)(3846002)(81156014)(478600001)(93886005)(68736007)(5250100002)(8936002)(8676002)(102836004)(6506007)(53546011)(476003)(99286004)(81166006)(26005)(6436002)(55016002)(11346002)(486006)(446003)(86362001)(9686003)(256004)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2493;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 7fc85266-8dec-417d-62a0-08d5dcf05480
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2493;
x-ms-traffictypediagnostic: MWHPR02MB2493:
x-microsoft-antispam-prvs: <MWHPR02MB24932E0D546E60BEDB187E28AF4F0@MWHPR02MB2493.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2493;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2493;
x-forefront-prvs: 0717E25089
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hGE24BOZD0Q8a3+vcJ2KYmU25xmY5KX+aH/chMITxJwxO3oCj+Jk8GzE6qRSlndwPeKcD1voZp499jO+UUzVK8y+3pdD5SLW+nlXe2OHsbq3eccryakbnFDZmmqAiTQ0uoqCPjJQ+sN1B9tP/ZRR61zJxt0MM2Q4Ppx/yW5Lq5WKgrxHqElvHnubZBJV4W3XeWNL/WyDTldVUaWx1hn2InwubqP/JFm7PyMLlHCjTd2+H7k3wClDUNfxPJhmDccgqO3R+Se+znq5CsCMGnArqF+Ig+QZHJofvsSTy5bmZZlvO6OtZuMwxRShRATQN6rhAqn3PJqzARCOXi5QPqGaqCPRlRz1zabH3E/S7G7+BIQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc85266-8dec-417d-62a0-08d5dcf05480
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 12:11:50.8823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2493
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIHRoZSB3cm9uZyBuYW1lLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgW21haWx0bzpuYWdhc3VyZUB4aWxpbngu
Y29tXQ0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAyOCwgMjAxOCA1OjQxIFBNDQo+IFRvOiBMaW51
cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IENjOiBCb3JpcyBCcmV6aWxs
b24gPGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbT47IFJpY2hhcmQgV2VpbmJlcmdlciA8cmlj
aGFyZEBub2QuYXQ+Ow0KPiBEYXZpZCBXb29kaG91c2UgPGR3bXcyQGluZnJhZGVhZC5vcmc+OyBC
cmlhbiBOb3JyaXMNCj4gPGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbT47IE1hcmsgVmFzdXQg
PG1hcmVrLnZhc3V0QGdtYWlsLmNvbT47IEZsb3JpYW4gRmFpbmVsbGkNCj4gPGYuZmFpbmVsbGlA
Z21haWwuY29tPjsgTWFya3VzIE1heWVyIDxtbWF5ZXJAYnJvYWRjb20uY29tPjsgUm9nZXIgUXVh
ZHJvcw0KPiA8cm9nZXJxQHRpLmNvbT47IExhZGlzbGF2IE1pY2hsIDxsYWRpc0BsaW51eC1taXBz
Lm9yZz47IGFkYUB0aG9yc2lzLmNvbTsNCj4gaG9uZ2h1aS56aGFuZ0BtZWRpYXRlay5jb207IE1p
cXXDqGwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPjsgbGludXgtDQo+IG10ZEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuYWdhc3Vy
ZXNoa3VtYXJyZWxsaUBnbWFpbC5jb207DQo+IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxpbngu
Y29tPg0KPiBTdWJqZWN0OiBSRTogW1tMSU5VWCBQQVRDSCB2MTBdIDIvNF0gbWVtb3J5OiBwbDM1
MzogQWRkIGRyaXZlciBmb3IgYXJtIHBsMzUzIHN0YXRpYw0KPiBtZW1vcnkgY29udHJvbGxlcg0K
PiANCj4gSGkgTGludXgsDQpMaW51cy4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJldmlldy4NCj4g
DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBMaW51cyBXYWxsZWlq
IFttYWlsdG86bGludXMud2FsbGVpakBsaW5hcm8ub3JnXQ0KPiA+IFNlbnQ6IFRodXJzZGF5LCBK
dW5lIDI4LCAyMDE4IDEyOjE5IFBNDQo+ID4gVG86IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5h
Z2FzdXJlQHhpbGlueC5jb20+DQo+ID4gQ2M6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemls
bG9uQGJvb3RsaW4uY29tPjsgUmljaGFyZCBXZWluYmVyZ2VyDQo+ID4gPHJpY2hhcmRAbm9kLmF0
PjsgRGF2aWQgV29vZGhvdXNlIDxkd213MkBpbmZyYWRlYWQub3JnPjsgQnJpYW4gTm9ycmlzDQo+
ID4gPGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbT47IE1hcmsgVmFzdXQgPG1hcmVrLnZhc3V0
QGdtYWlsLmNvbT47DQo+ID4gRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+
OyBNYXJrdXMgTWF5ZXINCj4gPiA8bW1heWVyQGJyb2FkY29tLmNvbT47IFJvZ2VyIFF1YWRyb3Mg
PHJvZ2VycUB0aS5jb20+OyBMYWRpc2xhdiBNaWNobA0KPiA+IDxsYWRpc0BsaW51eC1taXBzLm9y
Zz47IGFkYUB0aG9yc2lzLmNvbTsgaG9uZ2h1aS56aGFuZ0BtZWRpYXRlay5jb207DQo+ID4gTWlx
dcOobCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+OyBsaW51eC0NCj4gPiBtdGRA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiBu
YWdhc3VyZXNoa3VtYXJyZWxsaUBnbWFpbC5jb207IE1pY2hhbCBTaW1layA8bWljaGFsc0B4aWxp
bnguY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbW0xJTlVYIFBBVENIIHYxMF0gMi80XSBtZW1vcnk6
IHBsMzUzOiBBZGQgZHJpdmVyIGZvciBhcm0NCj4gPiBwbDM1MyBzdGF0aWMgbWVtb3J5IGNvbnRy
b2xsZXINCj4gPg0KPiA+IE9uIFRodSwgSnVuIDIxLCAyMDE4IGF0IDg6NDMgQU0gTmFnYSBTdXJl
c2hrdW1hciBSZWxsaQ0KPiA+IDxuYWdhLnN1cmVzaGt1bWFyLnJlbGxpQHhpbGlueC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gPiBBZGQgZHJpdmVyIGZvciBhcm0gcGwzNTMgc3RhdGljIG1lbW9yeSBj
b250cm9sbGVyLiBUaGlzIGNvbnRyb2xsZXINCj4gPiA+IGlzIHVzZWQgaW4gWGlsaW54IFp5bnEg
U29DIGZvciBpbnRlcmZhY2luZyB0aGUgTkFORCBhbmQgTk9SL1NSQU0gbWVtb3J5IGRldmljZXMu
DQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0KPiA+
ID4gPG5hZ2Euc3VyZXNoa3VtYXIucmVsbGlAeGlsaW54LmNvbT4NCj4gPg0KPiA+ICguLi4pDQo+
ID4NCj4gPiA+ICtjb25maWcgUEwzNTNfU01DDQo+ID4gPiArICAgICAgIHRyaXN0YXRlICJBUk0g
UEwzNVggU3RhdGljIE1lbW9yeSBDb250cm9sbGVyKFNNQykgZHJpdmVyIg0KPiA+ID4gKyAgICAg
ICBkZWZhdWx0IHkNCj4gPiA+ICsgICAgICAgZGVwZW5kcyBvbiBBUk0NCj4gPiA+ICsgICAgICAg
ZGVwZW5kcyBvbiBBUkNIX1pZTlENCj4gPg0KPiA+IGRlcGVuZHMgb24gQVJNX0FNQkENCj4gT2su
IEkgd2lsbCBhZGQgaXQgbmV4dCB2ZXJzaW9uLg0KPiA+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4
L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+DQo+ID4gVGhpcyBpcyBhIFByaW1lQ2VsbCB3aXRoIHRo
ZSBBUk0gcHJpbWVjZWxsIElEIHJlZ2lzdGVycyBzcGVjaWZpZWQsIHNvDQo+ID4gaXQgc2hvdWxk
IG5vdCB1c2UgcGxhdGZvcm0gZGV2aWNlLg0KPiBUaGFua3MgZm9yIHBvaW50aW5nIHRoZXNlIGRy
aXZlcnMuIExldCBtZSBnbyB0aHJvdWdoIHRoZXNlLg0KPiANCj4gPg0KPiA+IFVzZSA8bGludXgv
YW1iYS9idXMuaD4NCj4gPg0KPiA+IEl0IGZ1cnRoZXIgbmVlZHMgdG8gbWF0Y2ggb24gdGhlc2Ug
bWFnaWMgdmFsdWVzIChmb3VuZCBpbg0KPiA+IDB4ZmUwIGV0YykgYW5kIHVzZSB0aGUgbmFtZSAi
YXBiX3BjbGsiIGZvciB0aGUgcGVyaXBoZXJhbA0KPiA+IChzaWxpY29uKSBjbG9jay4NCj4gPg0K
PiA+IFNlZSBleGFtcGxlcyBzdWNoIGFzOg0KPiA+IGRyaXZlcnMvbW1jL2hvc3QvbW1jaS5jDQo+
ID4gZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYw0KPiA+IGRyaXZlcnMvdmlkZW8vZmJk
ZXYvYW1iYS1jbGNkLmMNCj4gPiBkcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvKg0KPiA+IGV0
YyBmb3IgZXhhbXBsZXMuDQo+ID4NCj4gPiBBbHNvIHNlZSBhbmQgcmVmZXJlbmNlIHRoZSBzcGVj
aWFsIFByaW1lQ2VsbCBEVCBiaW5kaW5nczoNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL3ByaW1lY2VsbC50eHQNCj4gT2suIEkgd2lsbCBnbyB0aHJvdWdoIHRoZXNl
IGJpbmRpbmdzIG9uY2UuDQo+ID4NCj4gPiBZb3VycywNCj4gPiBMaW51cyBXYWxsZWlqDQo+IA0K
PiBUaGFuayBmb3IgeW91ciByZXZpZXcuDQo+IA0KPiBSZWdhcmRzLA0KPiBOYWdhIFN1cmVzaGt1
bWFyIFJlbGxpLg0K
