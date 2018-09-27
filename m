Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1701C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93849215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Htb4rV05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93849215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeI0Rf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:35:56 -0400
Received: from mail-eopbgr700089.outbound.protection.outlook.com ([40.107.70.89]:20290
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727163AbeI0Rf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+93qaZ5dJ2Epbu4+H5F1unnu/muwL53w7xVHC75sV4=;
 b=Htb4rV05dKm20p/J20Eo+JVmiJsjdZ/Fyn70jF5GJCXCR4Rq/QVGXZiTCaipLDsFrXehwejDj6xkEB2QfOJQehzsdlVLlrM1ZVo9EuMxETTZN60Is6lOLDCQTluau7vTsPAi3xY4/3SzBgRhg9/6vqjoN8wzOkWYnbxFFSWrDSQ=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3232.namprd02.prod.outlook.com (10.164.133.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Thu, 27 Sep 2018 10:57:36 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::f0c9:d512:1636:4e40]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::f0c9:d512:1636:4e40%4]) with mapi id 15.20.1164.024; Thu, 27 Sep 2018
 10:57:35 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
Subject: RE: [LINUX PATCH v11 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Topic: [LINUX PATCH v11 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Index: AQHUVMo9ALqqhBoxFkyUoaLnh1YbXqUCjTaAgAFprIA=
Date:   Thu, 27 Sep 2018 10:57:35 +0000
Message-ID: <MWHPR02MB2623FE755E8F0C61A754F74DAF140@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1537878031-22253-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CABGGiszo3BO9LrSPT7tRey9g6jMZkB_0oXJA7ebsk-toud0EGw@mail.gmail.com>
In-Reply-To: <CABGGiszo3BO9LrSPT7tRey9g6jMZkB_0oXJA7ebsk-toud0EGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3232;6:RpfK4t5s12KjTYk0Xub/DmeRxJVO/7bs7fgGe6jn5bGXqUurCq5seOFyBK8GLWjUFBWD9k9rcl4e74Ui/3jgn+XIZs2WxgEUdzByTkjABvGuXFru/VCtFegNRxOiSBiQGu08jUomM1FU6YhbKr9WfLq2scpDjR5dKciQmbNBvMj+3YOyIn4NYgfy4o1+sDhWWvEEgQZqFOVQgd1eZx/SFM6plM+TRwYiu4WhL3s8RKHlZ+4eLDjio2F4DeoDZPmsmQBYq6e8LQEt3zEVQu3PIQj0q6oCP7s24XtM77Em71qgpk7TB+sEx+n3tLUjsF/0VvhQgZssYIVg3NNpkv2zTveNsqrRkgNxBCQxWoM2O9gdeRqh4F8/GiXMhSDQFSMTP+3sto0I05ZLaaztdF5XZeugA8A+ob+DeUZqReR9jd8o5+Ye4SAmdwACCqZLAYTOwVyQQJT/YGZtcTUTcUI41A==;5:ebz8ap+4/6Yi8OtFS8ceUmru4Su9PnGe0BE0LbQDPIURYRRLMKzRykJnrmlKG+qJ39brPruzMHFgBl+PTZ4h1WMN2Krq/MzPJ+vv2XG0Ng6PxZdnXDF+JgRP+phB+FsPMXAvS4sE77c1OdHoADwGhdyJkkTTTF1QsedH4ORCpJg=;7:fe8u4WBHaB8peBvVETw2Mp5WpvIUpXqIlQB33qTMksRC50s4KcJZJqUWGLPjg7qZkf+cW0HhUDWkGuu6lpAQJE2fN577c0umahSPSa7GP7WSjFqvdfhxUqy9a3STdL1aNJt0g1jw4Ae7Q1WhG+36C5ECR8mbNOX7Pg/I7BJ/XDaPbOKe/JJMOc36a0Wc23YMGHPFkYMJPL7Xhl9QEQIrp58XN2VycuXIa2sYKoiMj6yuQpCy6GWZVLQa5SytC8aG
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(51914003)(199004)(189003)(13464003)(14444005)(256004)(54906003)(105586002)(106356001)(74316002)(7736002)(102836004)(33656002)(217873002)(305945005)(99286004)(316002)(7696005)(7416002)(53546011)(6506007)(76176011)(97736004)(2900100001)(6116002)(3846002)(5250100002)(4326008)(8936002)(8676002)(25786009)(81166006)(81156014)(2906002)(6246003)(39060400002)(68736007)(229853002)(6916009)(5660300001)(66066001)(9686003)(53936002)(6436002)(55016002)(14454004)(71190400001)(478600001)(71200400001)(186003)(34290500001)(86362001)(26005)(476003)(486006)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3232;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 5f1a7ab2-87cb-48b5-94cd-08d624680837
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3232;
x-ms-traffictypediagnostic: MWHPR02MB3232:
x-microsoft-antispam-prvs: <MWHPR02MB3232602396F3B0267679EAD0AF140@MWHPR02MB3232.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(258649278758335)(192813158149592)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:MWHPR02MB3232;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3232;
x-forefront-prvs: 0808323E97
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K99tIa1qXl1pFiIBtOyaSVfAtlz5PnHtCQq3dTI4IjS5aKWkKiTkEi2WcaP6ldxtHrIdVyytgz+CyB6V5l9rti1Epfd2s/2yvGmAn8WRxxCyKWi52bB1vsLYK538IFgXFRYz6zV55GSwStdXXCqYH0805z1b2OyFBjpQXxrgpePX+G1fZLHIUTDjxVeIAZ1RkRwaTkKQXgxStTubtl8H3/CPtflv9bbMH+uodje4NKcAAb9oKhcon5XiEBf4n1zP9CkOgTyL1G2e7YNyT7bd5k2TUN8hUuArYzgW1hjYSMv33zJ6uvGMkHZ/XlLhfvqYQG+fuPSTf/evlufXyPIroH+ZqVBqlf15Jv48eOuU6wk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1a7ab2-87cb-48b5-94cd-08d624680837
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 10:57:35.1156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgW21haWx0bzpyb2JoQGtlcm5lbC5vcmddDQo+
IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDI2LCAyMDE4IDY6NDggUE0NCj4gVG86IE5hZ2Eg
U3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+DQo+IENjOiBib3Jpcy5icmV6
aWxsb25AYm9vdGxpbi5jb207IG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb207IHJpY2hhcmRAbm9k
LmF0Ow0KPiBkd213MkBpbmZyYWRlYWQub3JnOyBjb21wdXRlcnNmb3JwZWFjZUBnbWFpbC5jb207
IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsgbGludXgtDQo+IG10ZEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
PjsgTWljaGFsDQo+IFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+OyBuYWdhc3VyZXNoMTJAZ21h
aWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbTElOVVggUEFUQ0ggdjExIDEvM10gZHQtYmluZGluZ3M6
IG10ZDogYXJhc2FuOiBBZGQgZGV2aWNlIHRyZWUgYmluZGluZw0KPiBkb2N1bWVudGF0aW9uDQo+
IA0KPiBEVCBiaW5kaW5ncyBzaG91bGQgYmUgc2VudCB0byBEVCBsaXN0Lg0KU2luY2UgbGFzdCA0
IHZlcnNpb24gb2YgcGF0Y2hlcyBJIGFtIHNlbmRpbmcgbGlrZSB0aGlzLg0KVGhhbmtzIGZvciBs
ZXR0aW5nIHVzIGtub3cuDQpDdXJyZW50bHkgSSBhbSB3YWl0aW5nIGZvciBhcmFzYW5fbmFuZCBk
cml2ZXIgcmV2aWV3Lg0KT25jZSBpdCBpcyBkb25lLCBJIHdpbGwgYWRkcmVzcyBhbGwgdGhlIGNv
bW1lbnRzIGFuZCBzZW5kIG5ldyB2ZXJzaW9uLCBhbG9uZyB3aXRoIHRoZSBkcml2ZXIgY2hhbmdl
cw0KDQpUaGFua3MsDQpOYWdhIFN1cmVzaGt1bWFyIFJlbGxpDQoNCj4gDQo+IE9uIFR1ZSwgU2Vw
IDI1LCAyMDE4IGF0IDc6MjEgQU0gTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0KPiA8bmFnYS5zdXJl
c2hrdW1hci5yZWxsaUB4aWxpbnguY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRk
cyB0aGUgZHRzIGJpbmRpbmcgZG9jdW1lbnQgZm9yIGFyYXNhbiBuYW5kIGZsYXNoDQo+ID4gY29u
dHJvbGxlcg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0K
PiA+IDxuYWdhLnN1cmVzaGt1bWFyLnJlbGxpQHhpbGlueC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hh
bmdlcyBpbiB2MTE6DQo+ID4gIC0gVXBkYXRlZCBjb21wYXRpYmxlIGRlc2NyaXB0aW9uIGFzIHN1
Z2dlc3RlZCBieSBCb3Jpcw0KPiA+ICAtIFJlbW92ZWQgYXJhc2FuLWhhcy1kbWEgcHJvcGVydHkN
Cj4gPiBDaGFuZ2VzIGluIHYxMDoNCj4gPiAtIE5vbmUNCj4gPiBDaGFuZ2VzIGluIHY5Og0KPiA+
IC0gTm9uZQ0KPiA+IENoYW5nZXMgaW4gdjg6DQo+ID4gLSBVcGRhdGVkIGNvbXBhdGlibGUgYW5k
IGNsb2NrLW5hbWVzIGFzIHBlciBCb3JpcyBjb21tZW50cyBDaGFuZ2VzIGluDQo+ID4gdjc6DQo+
ID4gLSBDb3JyZWN0ZWQgdGhlIGFjcm9ueW1zIHRob3NlIHNob3VsZCBiZSBpbiBjYXBzIENoYW5n
ZXMgaW4gdjY6DQo+ID4gLSBSZW1vdmVkIG51bS1jcyBwcm9wZXJ0eQ0KPiA+IC0gU2VwYXJhdGVk
IG5hbmRjaGlwIGZyb20gbmFuZCBjb250cm9sbGVyIENoYW5nZXMgaW4gdjU6DQo+ID4gLSBOb25l
DQo+ID4gQ2hhbmdlcyBpbiB2NDoNCj4gPiAtIEFkZGVkIG51bS1jcyBwcm9wZXJ0eQ0KPiA+IC0g
QWRkZWQgY2xvY2sgc3VwcG9ydA0KPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4gLSBOb25lDQo+ID4g
Q2hhbmdlcyBpbiB2MjoNCj4gPiAtIE5vbmUNCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUv
YmluZGluZ3MvbXRkL2FyYXNhbl9uYW5kLnR4dCAgICAgICAgfCAzMyArKysrKysrKysrKysrKysr
KysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQv
YXJhc2FuX25hbmQudHh0DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL210ZC9hcmFzYW5fbmFuZC50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvYXJhc2FuX25hbmQudHh0DQo+ID4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi41NDZlZDk4DQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvYXJhc2FuX25h
bmQudHh0DQo+ID4gQEAgLTAsMCArMSwzMyBAQA0KPiA+ICtBcmFzYW4gTkFORCBGbGFzaCBDb250
cm9sbGVyIHdpdGggT05GSSAzLjEgc3VwcG9ydA0KPiA+ICsNCj4gPiArUmVxdWlyZWQgcHJvcGVy
dGllczoNCj4gPiArLSBjb21wYXRpYmxlOiAgICAgICAgICBTaG91bGQgYmUgInhsbngsenlucW1w
LW5hbmQiLCAiYXJhc2FuLG5mYy12M3AxMCINCj4gPiArLSByZWc6ICAgICAgICAgICAgICAgICBN
ZW1vcnkgbWFwIGZvciBtb2R1bGUgYWNjZXNzDQo+ID4gKy0gaW50ZXJydXB0LXBhcmVudDogICAg
SW50ZXJydXB0IGNvbnRyb2xsZXIgdGhlIGludGVycnVwdCBpcyByb3V0ZWQgdGhyb3VnaA0KPiAN
Cj4gRHJvcCB0aGlzLiBJdCBpcyBpbXBsaWVkLg0KPiANCj4gPiArLSBpbnRlcnJ1cHRzOiAgICAg
ICAgICBTaG91bGQgY29udGFpbiB0aGUgaW50ZXJydXB0IGZvciB0aGUgZGV2aWNlDQo+ID4gKy0g
Y2xvY2stbmFtZTogICAgICAgICAgTGlzdCBvZiBpbnB1dCBjbG9ja3MgLSAic3lzIiwgImZsYXNo
Ig0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIChTZWUgY2xvY2sgYmluZGluZ3MgZm9yIGRl
dGFpbHMpDQo+ID4gKy0gY2xvY2tzOiAgICAgICAgICAgICAgQ2xvY2sgcGhhbmRsZXMgKHNlZSBj
bG9jayBiaW5kaW5ncyBmb3IgZGV0YWlscykNCj4gPiArDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRp
ZXMgZm9yIGNoaWxkIG5vZGU6DQo+ID4gKy0gbmFuZC1lY2MtbW9kZTogc2VlIG5hbmQudHh0DQo+
ID4gKw0KPiA+ICtGb3IgTkFORCBwYXJ0aXRpb24gaW5mb3JtYXRpb24gcGxlYXNlIHJlZmVyIHRo
ZSBiZWxvdyBmaWxlDQo+ID4gK0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQv
cGFydGl0aW9uLnR4dA0KPiA+ICsNCj4gPiArRXhhbXBsZToNCj4gPiArICAgICAgIG5mYzogbmFu
ZEBmZjEwMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAieGxueCx6eW5x
bXAtbmFuZCIsICJhcmFzYW4sbmZjLXYzcDEwIg0KPiANCj4gTWlzc2luZyA7DQo+IA0KPiA+ICsg
ICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4ZmYxMDAwMDAgMHgxMDAwPjsNCj4gPiArICAgICAg
ICAgICAgICAgY2xvY2stbmFtZSA9ICJzeXMiLCAiZmxhc2giDQo+IA0KPiBNaXNzaW5nIDsNCj4g
DQo+ID4gKyAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmbWlzY19jbGsgJm1pc2NfY2xrPjsNCj4g
PiArICAgICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmZ2ljPjsNCj4gPiArICAgICAg
ICAgICAgICAgaW50ZXJydXB0cyA9IDwwIDE0IDQ+Ow0KPiA+ICsgICAgICAgICAgICAgICAjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD4N
Cj4gDQo+IE1pc3NpbmcgOw0KPiANCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIG5hbmRAMCB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDA+DQo+IA0KPiBNaXNzaW5nIDsN
Cj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbmFuZC1lY2MtbW9kZSA9ICJodyI7DQo+
ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gKyAgICAgICB9Ow0KPiA+IC0tDQo+ID4gMi43LjQN
Cj4gPg0K
