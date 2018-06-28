Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A13C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720B027332
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hBoKC467"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720B027332
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934703AbeF1MKl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:10:41 -0400
Received: from mail-sn1nam02on0040.outbound.protection.outlook.com ([104.47.36.40]:45895
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753388AbeF1MKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31co/hF1XPt0A5rea7ycgS4zL42FOpPVoELmf0sEjBI=;
 b=hBoKC467IHJxFf9C7XXsYkZUqM2nAEmxdZsBLJvv0U0au3qvzKX1H8Jyz95Faf7V7DzMjbttc2v5Ki8s18ieo6Jc/TpHuAHNitSTH4GOMNsC+x+HvKzjE7mvlesVXlmqa7CucAuvgvJ3SCPF2cVPjKzIzVkOMfyVlArIgHbkPiU=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 12:10:33 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b%8]) with mapi id 15.20.0884.025; Thu, 28 Jun 2018
 12:10:30 +0000
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
Subject: RE: [[LINUX PATCH v10] 2/4] memory: pl353: Add driver for arm pl353
 static memory controller
Thread-Topic: [[LINUX PATCH v10] 2/4] memory: pl353: Add driver for arm pl353
 static memory controller
Thread-Index: AQHUCSsdwhX6BzH85km0F+Edq0u1GaR1Re8AgABN/1A=
Date:   Thu, 28 Jun 2018 12:10:30 +0000
Message-ID: <MWHPR02MB2623C017D4A632F7A25FFD27AF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1529563351-2241-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CACRpkdZiY2vAXQSuAgjKfHKtYT_UZD-apEbpS1RT5ZGFutYQeA@mail.gmail.com>
In-Reply-To: <CACRpkdZiY2vAXQSuAgjKfHKtYT_UZD-apEbpS1RT5ZGFutYQeA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2623;7:zs0fzB/H7T3yjTD7YctWvgE2u1E7uXaMhKgZULDFdSHU4k6HwfOVjX0jVW4IYxwMMZJ3M5SsxGzNb0xkjB2EtoxNtpKq6IltLziU7XUe7OyjWNxGn4qJJp6icYbeJq8SewSLoCkGidRnTLDuzaRH6FsWKYvtQSIR37W8yWCi6Afub9ynwkLzft0vcG6smnsUfmQtvwRfDoK+We1CYqR0Lb42SqB4DCDF8VHxoKDQZ7261DjDzGLSPOpXl1pNs3nB
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(13464003)(199004)(189003)(51914003)(8936002)(14454004)(478600001)(8676002)(81166006)(81156014)(54906003)(7736002)(316002)(6116002)(3846002)(305945005)(476003)(66066001)(76176011)(74316002)(486006)(99286004)(102836004)(186003)(446003)(55236004)(6506007)(11346002)(53546011)(2900100001)(7696005)(86362001)(6246003)(53936002)(2906002)(4326008)(7416002)(25786009)(39060400002)(107886003)(6436002)(26005)(229853002)(33656002)(256004)(6916009)(55016002)(9686003)(68736007)(105586002)(5660300001)(106356001)(5250100002)(97736004)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2623;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 9ccbe6d3-a02a-4e1f-7af1-08d5dcf0248b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2623;
x-ms-traffictypediagnostic: MWHPR02MB2623:
x-microsoft-antispam-prvs: <MWHPR02MB2623D243B2EF01D166A5FF36AF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2623;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2623;
x-forefront-prvs: 0717E25089
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9N317BRt5eMo108yKvGu56dYAHvCdyL2GN6Gef/sXfou651fLZuepWSECtWDZgtrdvLI7TQ4Y7gnp1TtXirigL4zVCABwyxPxx3LMBD+TxJDH1EZBd4PcuVmW7Wx0HBWX3u2rz19Hj3N6Ia3VG698FcHBCFicxxu3+IfXgtUS0WW7hVL2syZseseintakmxCgOMAeacxkY3csDVpaM1oocFHZ970qgKAnlRxxjWiMm8S4XcO6wkoeKJTGQz3Te4ykgMx8/+0JYJEosl4qb/OWlbDYcgKF+Riihi8/SheUTkZ3oOYml3oGrnYp6Ri7haIvJD+23cxY9ChT56iNH7LFzG1G+PdaWgKRMPF0G1urT0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccbe6d3-a02a-4e1f-7af1-08d5dcf0248b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 12:10:30.3983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXgsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBXYWxsZWlqIFttYWlsdG86bGludXMud2FsbGVpakBs
aW5hcm8ub3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAyOCwgMjAxOCAxMjoxOSBQTQ0KPiBU
bzogTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8bmFnYXN1cmVAeGlsaW54LmNvbT4NCj4gQ2M6IEJv
cmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPjsgUmljaGFyZCBXZWlu
YmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD47DQo+IERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFk
ZWFkLm9yZz47IEJyaWFuIE5vcnJpcw0KPiA8Y29tcHV0ZXJzZm9ycGVhY2VAZ21haWwuY29tPjsg
TWFyayBWYXN1dCA8bWFyZWsudmFzdXRAZ21haWwuY29tPjsgRmxvcmlhbiBGYWluZWxsaQ0KPiA8
Zi5mYWluZWxsaUBnbWFpbC5jb20+OyBNYXJrdXMgTWF5ZXIgPG1tYXllckBicm9hZGNvbS5jb20+
OyBSb2dlciBRdWFkcm9zDQo+IDxyb2dlcnFAdGkuY29tPjsgTGFkaXNsYXYgTWljaGwgPGxhZGlz
QGxpbnV4LW1pcHMub3JnPjsgYWRhQHRob3JzaXMuY29tOw0KPiBob25naHVpLnpoYW5nQG1lZGlh
dGVrLmNvbTsgTWlxdcOobCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+OyBsaW51
eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IG5hZ2FzdXJlc2hrdW1hcnJlbGxpQGdtYWlsLmNvbTsNCj4gTWljaGFsIFNpbWVrIDxtaWNo
YWxzQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbW0xJTlVYIFBBVENIIHYxMF0gMi80XSBt
ZW1vcnk6IHBsMzUzOiBBZGQgZHJpdmVyIGZvciBhcm0gcGwzNTMgc3RhdGljDQo+IG1lbW9yeSBj
b250cm9sbGVyDQo+IA0KPiBPbiBUaHUsIEp1biAyMSwgMjAxOCBhdCA4OjQzIEFNIE5hZ2EgU3Vy
ZXNoa3VtYXIgUmVsbGkNCj4gPG5hZ2Euc3VyZXNoa3VtYXIucmVsbGlAeGlsaW54LmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IEFkZCBkcml2ZXIgZm9yIGFybSBwbDM1MyBzdGF0aWMgbWVtb3J5IGNvbnRy
b2xsZXIuIFRoaXMgY29udHJvbGxlciBpcw0KPiA+IHVzZWQgaW4gWGlsaW54IFp5bnEgU29DIGZv
ciBpbnRlcmZhY2luZyB0aGUgTkFORCBhbmQgTk9SL1NSQU0gbWVtb3J5IGRldmljZXMuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBOYWdhIFN1cmVzaGt1bWFyIFJlbGxpDQo+ID4gPG5hZ2Euc3Vy
ZXNoa3VtYXIucmVsbGlAeGlsaW54LmNvbT4NCj4gDQo+ICguLi4pDQo+IA0KPiA+ICtjb25maWcg
UEwzNTNfU01DDQo+ID4gKyAgICAgICB0cmlzdGF0ZSAiQVJNIFBMMzVYIFN0YXRpYyBNZW1vcnkg
Q29udHJvbGxlcihTTUMpIGRyaXZlciINCj4gPiArICAgICAgIGRlZmF1bHQgeQ0KPiA+ICsgICAg
ICAgZGVwZW5kcyBvbiBBUk0NCj4gPiArICAgICAgIGRlcGVuZHMgb24gQVJDSF9aWU5RDQo+IA0K
PiBkZXBlbmRzIG9uIEFSTV9BTUJBDQpPay4gSSB3aWxsIGFkZCBpdCBuZXh0IHZlcnNpb24uDQo+
IA0KPiA+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+IA0KPiBUaGlzIGlz
IGEgUHJpbWVDZWxsIHdpdGggdGhlIEFSTSBwcmltZWNlbGwgSUQgcmVnaXN0ZXJzIHNwZWNpZmll
ZCwgc28gaXQgc2hvdWxkIG5vdCB1c2UNCj4gcGxhdGZvcm0gZGV2aWNlLg0KVGhhbmtzIGZvciBw
b2ludGluZyB0aGVzZSBkcml2ZXJzLiBMZXQgbWUgZ28gdGhyb3VnaCB0aGVzZS4NCg0KPiANCj4g
VXNlIDxsaW51eC9hbWJhL2J1cy5oPg0KPiANCj4gSXQgZnVydGhlciBuZWVkcyB0byBtYXRjaCBv
biB0aGVzZSBtYWdpYyB2YWx1ZXMgKGZvdW5kIGluDQo+IDB4ZmUwIGV0YykgYW5kIHVzZSB0aGUg
bmFtZSAiYXBiX3BjbGsiIGZvciB0aGUgcGVyaXBoZXJhbA0KPiAoc2lsaWNvbikgY2xvY2suDQo+
IA0KPiBTZWUgZXhhbXBsZXMgc3VjaCBhczoNCj4gZHJpdmVycy9tbWMvaG9zdC9tbWNpLmMNCj4g
ZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYw0KPiBkcml2ZXJzL3ZpZGVvL2ZiZGV2L2Ft
YmEtY2xjZC5jDQo+IGRyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC8qDQo+IGV0YyBmb3IgZXhh
bXBsZXMuDQo+IA0KPiBBbHNvIHNlZSBhbmQgcmVmZXJlbmNlIHRoZSBzcGVjaWFsIFByaW1lQ2Vs
bCBEVCBiaW5kaW5nczoNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9w
cmltZWNlbGwudHh0DQpPay4gSSB3aWxsIGdvIHRocm91Z2ggdGhlc2UgYmluZGluZ3Mgb25jZS4N
Cj4gDQo+IFlvdXJzLA0KPiBMaW51cyBXYWxsZWlqDQoNClRoYW5rIGZvciB5b3VyIHJldmlldy4N
Cg0KUmVnYXJkcywNCk5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkuDQo=
