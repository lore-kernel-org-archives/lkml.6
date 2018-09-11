Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0026C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A98920833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zVucl6bW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A98920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeIKKWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:22:35 -0400
Received: from mail-sn1nam01on0044.outbound.protection.outlook.com ([104.47.32.44]:55245
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbeIKKWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNkprbChr5CVd0dxsW28Mkjd87t4wSa/D0xZ1OxyQOk=;
 b=zVucl6bWvGj8sG73fIQheCZLfjaLd6yC+SyfkRLkO2bojGsOGgyQoPLiRBbrou0GtpUFFYIBkn1ypIvPbnbiu/REkq89s3EfeEXKUCyr1oT3lwCfX//sdGvccVBTQJd/zbYciUgZW57nadMTUaE1Qbwkt7EDljS3sXX7gp5HXdc=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2336.namprd02.prod.outlook.com (10.168.244.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Tue, 11 Sep 2018 05:24:57 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::948a:706d:2ec5:4b6f]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::948a:706d:2ec5:4b6f%7]) with mapi id 15.20.1122.019; Tue, 11 Sep 2018
 05:24:56 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Markus Mayer <mmayer@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Roger Quadros <rogerq@ti.com>,
        "ada@thorsis.co" <ada@thorsis.co>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        =?utf-8?B?TWlxdcOobCBSYXluYWw=?= <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [LINUX PATCH v11 1/3] dt-bindings: memory: Add pl353 smc
 controller devicetree binding information
Thread-Topic: [LINUX PATCH v11 1/3] dt-bindings: memory: Add pl353 smc
 controller devicetree binding information
Thread-Index: AQHUGOn/dEqGt1LKMEin+cG/BQedJ6SMxtUAgDja03A=
Date:   Tue, 11 Sep 2018 05:24:56 +0000
Message-ID: <MWHPR02MB2623EB3C27CE14C08EC45ACDAF040@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1531294612-29526-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CACRpkdZOwgj4hCy=L6kKiQOpGNpvFXJk666pauyRv-fdHizMtg@mail.gmail.com>
In-Reply-To: <CACRpkdZOwgj4hCy=L6kKiQOpGNpvFXJk666pauyRv-fdHizMtg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2336;6:FlE/1oDGId49+Z/AKaLO3TC1ZDz4n4bcXFoCfp4HV91h+GzJ7G8gbAJm9Js89TgztHM3FMLyQcN3/ExxNRpYktP2Cl4GQIRblu1ZJiHmnVLjkr/i9JI5vfQ8m8ztPe2MrSRlBGG025pHXt0FP0QbDnBVwMexd3CoTPpjhhmGZ4WWZIG1pDEjq6ksnsJ702mCTszDrfMsO1oQSJOhP5GNyXEA0cWbk4KlZIFw6sl/Ttwadm+HpetVsNWIWeEdgZzs3iz1wKJTJ6+Fp67vrWF+7XcbXnE2Tn3Tatms/qv5kjqGgmonBT4HoCRCydFZkmi3Qhb9xyayFWv4NwzGND+HheR+tc9icIEDoyPwRydfAOGB7o/UufASkZo5UgofVowKDxGr1vX7MziyCtP7ZLvULlA9/fjHrdYPCk7bSHAqeron/cQFjHabkAJ8lHl739lexFFWjag7QleXzb7IXcB5FQ==;5:Brqz+f5d7xXLRmg8mKIY0dCNOgOTrzGdiDQWCJZApbhibnfBNFGxoUjNhAN3oyFsI/aVKxpt72zBQ17zmwcutZW0+Z5SlS0RXWXdXHwGSdWB2Uk5gE5enbNrkxKimnhpvb1mgy3AX2WFNXOixle01YdRkl5YV4WmwL0bqEm79Ig=;7:j47CDI7JRtbFQsAe2oyOcMZum6BVOOcJMzLBleCl5nKkPhSw1DZno2zVIgPimCyJvuER4FDRqbeyQkbQPr2ZFsBFt89acQ+1w2U+h4m5/BPGhCZVkF1NHxt7G8lkBZ6a8MS8I0bvh77mJ+tcyc+/kXm2lz0BRVUeSgU4h/B0hHaELgI0F0JQFo0lDFYHtI8qLkVWFhNP9Sfd+lddqlJc17xOhz868vIKSPlJBZGh/qIZVHWGAiP2NhwLpsAtzQBf
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(366004)(346002)(396003)(13464003)(189003)(199004)(6436002)(99286004)(7416002)(53546011)(7696005)(6346003)(106356001)(102836004)(8936002)(86362001)(6506007)(81156014)(446003)(11346002)(105586002)(478600001)(476003)(186003)(486006)(81166006)(26005)(76176011)(107886003)(39060400002)(316002)(74316002)(4326008)(305945005)(25786009)(6246003)(110136005)(68736007)(33656002)(66066001)(14454004)(217873002)(54906003)(7736002)(256004)(5660300001)(9686003)(2900100001)(53936002)(6116002)(3846002)(2906002)(97736004)(55016002)(8676002)(5250100002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2336;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 5101d59a-20db-4b46-0276-08d617a6e967
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2336;
x-ms-traffictypediagnostic: MWHPR02MB2336:
x-microsoft-antispam-prvs: <MWHPR02MB2336C966A888825B449EF692AF040@MWHPR02MB2336.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:MWHPR02MB2336;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2336;
x-forefront-prvs: 0792DBEAD0
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-microsoft-antispam-message-info: Cbj2Mpg8sVDp7agbptRKRBEGyjHZ/lzK3oQHnUlLUzGXpqULRoArIxttlTzonp/UWHNPNKLA3rx4c+e4GxE7Mx0ntruD8P6L2BpNoMAZwqEdPwD3e4d1cOhl585jZvuatQ8+TEdt4K864Ur13QA8SEDCa08tPc77mOx/V2VK8c298UhlGjw3NnVoCIt69dV2SFPt/SjVGvjv0xq7/wQEoirw8mew2HHQYRo5YcZF8at5M3wAdQHdK7721TbeduwkWeNEnVpxzuTnqv3RlCYR6D+U0LpaumTvEA2AA4Aod++AW1+K4Uo581andzXVLFnirZEQtFpnZBUdv7aEww36d93HJOH+pZYf+i2QuWz5c6c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5101d59a-20db-4b46-0276-08d617a6e967
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 05:24:56.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCltMSU5VWCBQQVRDSCB2MTEgMS8zXSBkdC1iaW5kaW5nczogbWVtb3J5OiBBZGQgcGwz
NTMgc21jIGNvbnRyb2xsZXIgZGV2aWNldHJlZSBiaW5kaW5nIGluZm9ybWF0aW9uDQpbTElOVVgg
UEFUQ0ggdjExIDIvM10gbWVtb3J5OiBwbDM1MzogQWRkIGRyaXZlciBmb3IgYXJtIHBsMzUzIHN0
YXRpYyBtZW1vcnkgY29udHJvbGxlcg0KDQpDYW4gc29tZWJvZHkgYXBwbHkgdGhlIGFib3ZlIHBh
dGNoZXM/DQpUaGUgYWJvdmUgcGF0Y2hlcyBhcmUgYWxyZWFkeSByZXZpZXdlZC4gDQoNClRoYW5r
cywNCk5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGludXMgV2FsbGVpaiBbbWFpbHRvOmxpbnVzLndhbGxlaWpAbGluYXJvLm9y
Z10NCj4gU2VudDogRnJpZGF5LCBKdWx5IDEzLCAyMDE4IDE6MDcgUE0NCj4gVG86IE5hZ2EgU3Vy
ZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+DQo+IENjOiBCb3JpcyBCcmV6aWxs
b24gPGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbT47IFJpY2hhcmQgV2VpbmJlcmdlciA8cmlj
aGFyZEBub2QuYXQ+Ow0KPiBEYXZpZCBXb29kaG91c2UgPGR3bXcyQGluZnJhZGVhZC5vcmc+OyBC
cmlhbiBOb3JyaXMNCj4gPGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbT47IE1hcmsgVmFzdXQg
PG1hcmVrLnZhc3V0QGdtYWlsLmNvbT47IEZsb3JpYW4gRmFpbmVsbGkNCj4gPGYuZmFpbmVsbGlA
Z21haWwuY29tPjsgTWFya3VzIE1heWVyIDxtbWF5ZXJAYnJvYWRjb20uY29tPjsgUm9nZXIgUXVh
ZHJvcw0KPiA8cm9nZXJxQHRpLmNvbT47IExhZGlzbGF2IE1pY2hsIDxsYWRpc0BsaW51eC1taXBz
Lm9yZz47IGFkYUB0aG9yc2lzLmNvOw0KPiBob25naHVpLnpoYW5nQG1lZGlhdGVrLmNvbTsgTWlx
dcOobCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+OyBsaW51eC0NCj4gbXRkQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5hZ2FzdXJl
c2hrdW1hcnJlbGxpQGdtYWlsLmNvbTsNCj4gTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbTElOVVggUEFUQ0ggdjExIDEvM10gZHQtYmluZGluZ3M6IG1l
bW9yeTogQWRkIHBsMzUzIHNtYyBjb250cm9sbGVyDQo+IGRldmljZXRyZWUgYmluZGluZyBpbmZv
cm1hdGlvbg0KPiANCj4gT24gV2VkLCBKdWwgMTEsIDIwMTggYXQgOTozNyBBTSBOYWdhIFN1cmVz
aGt1bWFyIFJlbGxpDQo+IDxuYWdhLnN1cmVzaGt1bWFyLnJlbGxpQHhpbGlueC5jb20+IHdyb3Rl
Og0KPiANCj4gPiBBZGQgcGwzNTMgc3RhdGljIG1lbW9yeSBjb250cm9sbGVyIGRldmljZXRyZWUg
YmluZGluZyBpbmZvcm1hdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hZ2EgU3VyZXNo
a3VtYXIgUmVsbGkNCj4gPiA8bmFnYS5zdXJlc2hrdW1hci5yZWxsaUB4aWxpbnguY29tPg0KPiA+
IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjExOg0KPiANCj4gUmV2aWV3ZWQtYnk6IExpbnVzIFdhbGxl
aWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4gVGhhbmtzIQ0KPiANCj4gWW91cnMsDQo+IExp
bnVzIFdhbGxlaWoNCg==
