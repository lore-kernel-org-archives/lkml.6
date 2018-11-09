Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB34C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0067E20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 13:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="yDQaH1Oi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0067E20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeKIXAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:00:09 -0500
Received: from mail-eopbgr710043.outbound.protection.outlook.com ([40.107.71.43]:29344
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727676AbeKIXAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvbAoxdKFKF8froRAhNAypGoZ7LHhaO5p4StLvnCOyY=;
 b=yDQaH1OiEqW2DggQYuUn7UGjiaGMP2H7HVX+GxwdOwWP98lECji0lUrBSahfubWpNmKDs6OwFu9dDNPvQpZ2P6/0+0vFfXJ8BO2+XWEqMfsEq8bkk4sPxdC6knPjdQlGmZGHTAG3/j+UFZh4I3YzR5qAKEVuU2bMLqOTeqfMkY8=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2784.namprd02.prod.outlook.com (10.175.49.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 13:19:28 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c%6]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 13:19:28 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [LINUX PATCH v12 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Topic: [LINUX PATCH v12 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Index: AQHUd+lLNqh5tQSG70at2ta/kVZ5BaVG+ymAgABk50CAAAa0gIAABvRw
Date:   Fri, 9 Nov 2018 13:19:28 +0000
Message-ID: <MWHPR02MB2623087507F40BAF55D0FA98AFC60@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20181109072857.75e86cb6@bbrezillon>
        <MWHPR02MB26235AB9959635CAA1B2B878AFC60@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181109135405.3b93b267@xps13>
In-Reply-To: <20181109135405.3b93b267@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2784;6:1tuPY7YIxP5yOyWxM63CFHQft9do3LV4Mm49UbbJ0GeBHpFY1j4KIfEzYRgL2dRFU5CbGWrM4Qjk0HSdWhkgIToCTaHZHzkMi2bopntfI69Pv6vFPFwZ9Zv+a6Vm8GZT8mydF3xgwCVZc25fiJf2d5M84OdV5UaM26rg/ym3TAxDhW1N6U99PYqKxtkdZQxwGqzJDFATTkeEaUUL/HffSNPQP+bYMknhvGQy6bSNN4qh0EUgFHY1t3E6xrr66zeNMcC1zy4ZWnuUAOC7MvyZfEB6T6h4q+N79b/8ZCtd4p0gZy7w4slpbGB+UCrhhgR5zrAOMvT9dtNzJhtKbclnebnyiHseFT/MHsvhHsmfu5Z3XRhujkOBB2MliROVr2EuDNi/DFJqWEx8zxsI2M5UAUHxhaY0Y8YOD5nAbyL3YEA9rZcLh20ARxuuC9OVwJmphYRBPGsaWr/Pp0Td3mwRuA==;5:7++y1pjiWYhJxwTZ6k3MpvHU/3IVmPd8BjNlKAY7pu+GMLef3a7PKcVsZ+0QZiN4V/yCq9OgUlsBNhMl3hcZ84Ml/XicymJmbsx2lc1KIQYRu4ikEaRc3FT8n+CBP5702m2W3WHsRYSWEBH/pYqbiXQfifAMLOC4RIl6nKXzYLs=;7:6i5ML/O8BBCaWiMUR8SDWFbemo/UvjWuM6301FuFrVbSAerDoQWkR6XqxPOpgp369vMURYgsW2E7ROmV23kmjcP8y5LevIrya783shto5JkC+4X+01B5wAA6tyg7DJMNjdaxTQl5jdtCCXaP1o1XAg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(199004)(13464003)(102836004)(6436002)(6246003)(81166006)(74316002)(76176011)(7696005)(305945005)(6506007)(53546011)(5660300001)(7736002)(2906002)(2900100001)(229853002)(71200400001)(8676002)(66574009)(81156014)(99286004)(71190400001)(3846002)(8936002)(97736004)(6116002)(33656002)(106356001)(14454004)(6916009)(9686003)(4326008)(105586002)(68736007)(66066001)(26005)(39060400002)(256004)(186003)(478600001)(54906003)(86362001)(53936002)(25786009)(55016002)(14444005)(217873002)(11346002)(93886005)(486006)(476003)(316002)(446003)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2784;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: c27314fb-27d6-480b-e398-08d64645fa13
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2784;
x-ms-traffictypediagnostic: MWHPR02MB2784:
x-microsoft-antispam-prvs: <MWHPR02MB27843503499C99C3174B3CB5AFC60@MWHPR02MB2784.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(258649278758335)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2784;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2784;
x-forefront-prvs: 08512C5403
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DhHVVuciSRQzYXSmrj2d9VIPaqnMJM62rVOZSuygqhwo18YdFzM0OITGgZ7sCoSKyo3nKRC0lFZoe5nlzxVdAbG1zRHVmx8362VOb9G9BJK700H1jmHu208AxpOUh3y9H9GgjGZ9z6SYbk1UIi0hLKfObDhWmjuzMVS8900zilb4uyzkkiHdJn6TmOK3NwAtxBEFsQikE1Dqt5b5MrszV+j4Es/jn0zuj87CuHeqyZLNpbz4gTmZDZGv+cdu5go6Td+1SlIN2wxh3d04z9RpnEBix3lbHjzkfCvctPbdVJjCMbqn4Ed5Aw7ur1ZFipnHYR/iAF/cNUS07ZeAGepUe4L2r/2R+vB7I5r3lOZtPNc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27314fb-27d6-480b-e398-08d64645fa13
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 13:19:28.0808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgW21haWx0bzptaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tXQ0KPiBTZW50OiBGcmlk
YXksIE5vdmVtYmVyIDksIDIwMTggNjoyNCBQTQ0KPiBUbzogTmFnYSBTdXJlc2hrdW1hciBSZWxs
aSA8bmFnYXN1cmVAeGlsaW54LmNvbT4NCj4gQ2M6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJl
emlsbG9uQGJvb3RsaW4uY29tPjsgcmljaGFyZEBub2QuYXQ7IGR3bXcyQGluZnJhZGVhZC5vcmc7
DQo+IGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbTsgbWFyZWsudmFzdXRAZ21haWwuY29tOyBN
aWNoYWwgU2ltZWsNCj4gPG1pY2hhbHNAeGlsaW54LmNvbT47IGxpbnV4LW10ZEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBuYWdhc3VyZXNoMTJA
Z21haWwuY29tOyByb2JoQGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtMSU5VWCBQQVRDSCB2
MTIgMS8zXSBkdC1iaW5kaW5nczogbXRkOiBhcmFzYW46IEFkZCBkZXZpY2UgdHJlZSBiaW5kaW5n
DQo+IGRvY3VtZW50YXRpb24NCj4gDQo+IEhpIE5hZ2EsDQo+IA0KPiBbLi4uXQ0KPiANCj4gPiA+
ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvYXJh
c2FuX25hbmQudHh0DQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L210ZC9hcmFzYW5fbmFuZC50eHQNCj4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+
ID4gaW5kZXggMDAwMDAwMC4uYjUyMmRhZg0KPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvYXJhc2FuX25hbmQu
dHh0DQo+ID4gPiA+IEBAIC0wLDAgKzEsMzIgQEANCj4gPiA+ID4gK0FyYXNhbiBOQU5EIEZsYXNo
IENvbnRyb2xsZXIgd2l0aCBPTkZJIDMuMSBzdXBwb3J0DQo+ID4gPiA+ICsNCj4gPiA+ID4gK1Jl
cXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gPiA+ICstIGNvbXBhdGlibGU6CQlTaG91bGQgYmUgInhs
bngsenlucW1wLW5hbmQiLCAiYXJhc2FuLG5mYy12M3AxMCINCj4gPiA+ID4gKy0gcmVnOgkJCU1l
bW9yeSBtYXAgZm9yIG1vZHVsZSBhY2Nlc3MNCj4gPiA+ID4gKy0gaW50ZXJydXB0czoJCVNob3Vs
ZCBjb250YWluIHRoZSBpbnRlcnJ1cHQgZm9yIHRoZSBkZXZpY2UNCj4gPiA+ID4gKy0gY2xvY2st
bmFtZToJCUxpc3Qgb2YgaW5wdXQgY2xvY2tzIC0gInN5cyIsICJmbGFzaCINCj4gPiA+ID4gKwkJ
CShTZWUgY2xvY2sgYmluZGluZ3MgZm9yIGRldGFpbHMpDQo+ID4gPiA+ICstIGNsb2NrczoJCUNs
b2NrIHBoYW5kbGVzIChzZWUgY2xvY2sgYmluZGluZ3MgZm9yIGRldGFpbHMpDQo+ID4gPiA+ICsN
Cj4gPiA+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXMgZm9yIGNoaWxkIG5vZGU6DQo+ID4gPiA+ICst
IG5hbmQtZWNjLW1vZGU6IHNlZSBuYW5kLnR4dA0KPiA+ID4NCj4gPiA+IFdoeSBpcyBpdCByZXF1
aXJlZD8gQ2FuJ3QgeW91IGZhbGxiYWNrIHRvIEhXIHdoZW4gdGhpcyBwcm9wIGlzIG1pc3Npbmc/
DQo+ID4gWWVzLCB3ZSBjYW4uDQo+ID4gRG8geW91IHdhbnQgbWUgdG8gdXBkYXRlIHRoYXQgaW4g
ZHJpdmVyIG5vdz8NCj4gPiBMb29rcyBsaWtlIHlvdSBoYXZlIHNvbWUgY29tbWVudHMgaW4gZHJp
dmVyIGFzIHdlbGwsIHNvIHdoaWxlDQo+ID4gYWRkcmVzc2luZyB0aG9zZSBJIHdpbGwgdXBkYXRl
IHRoZSBjb2RlIHRvIGZhbGxiYWNrIHRvIEhXIEVDQyB3aGVuIEl0IGlzIG1pc3NpbmcuDQo+IA0K
PiBZZXMsIHBsZWFzZS4NCj4gDQo+ID4NCj4gPiA+IE9oLCBhbmQgcmVnIGlzIG5vdCBsaXN0ZWQg
aW4gdGhlIHJlcXVpcmVkIHByb3BzLg0KPiA+IFdoaWNoIHJlZz8NCj4gPiBJIGFscmVhZHkgbWVu
dGlvbiB0aGlzICIgcmVnOglNZW1vcnkgbWFwIGZvciBtb2R1bGUgYWNjZXNzICIgaW4gcmVxdWly
ZWQgcHJvcGVydGllcy4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBOYWdhIFN1cmVzaGt1bWFyIFJl
bGxpDQo+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+ICtGb3IgTkFORCBwYXJ0aXRpb24gaW5mb3Jt
YXRpb24gcGxlYXNlIHJlZmVyIHRoZSBiZWxvdyBmaWxlDQo+ID4gPiA+ICtEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbXRkL3BhcnRpdGlvbi50eHQNCj4gPiA+ID4gKw0KPiA+ID4g
PiArRXhhbXBsZToNCj4gPiA+ID4gKwluZmM6IG5hbmRAZmYxMDAwMDAgew0KPiA+ID4gPiArCQlj
b21wYXRpYmxlID0gInhsbngsenlucW1wLW5hbmQiLCAiYXJhc2FuLG5mYy12M3AxMCI7DQo+ID4g
PiA+ICsJCXJlZyA9IDwweDAgMHhmZjEwMDAwMCAweDEwMDA+Ow0KPiA+ID4gPiArCQljbG9jay1u
YW1lID0gInN5cyIsICJmbGFzaCI7DQo+ID4gPiA+ICsJCWNsb2NrcyA9IDwmbWlzY19jbGsgJm1p
c2NfY2xrPjsNCj4gPiA+ID4gKwkJaW50ZXJydXB0LXBhcmVudCA9IDwmZ2ljPjsNCj4gPiA+ID4g
KwkJaW50ZXJydXB0cyA9IDwwIDE0IDQ+Ow0KPiA+ID4gPiArCQkjYWRkcmVzcy1jZWxscyA9IDwx
PjsNCj4gPiA+ID4gKwkJI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJ
bmFuZEAwIHsNCj4gPiA+ID4gKwkJCXJlZyA9IDwwPjsNCj4gDQo+IFRoaXMgb25lLCBmb3IgdGhl
IENTIGxpbmUocykuDQpPayBnb3QgaXQuIEkgd2lsbCB1cGRhdGUuDQoNClRoYW5rcywNCk5hZ2Eg
U3VyZXNoa3VtYXIgUmVsbGkNCj4gDQo+ID4gPiA+ICsJCQluYW5kLWVjYy1tb2RlID0gImh3IjsN
Cj4gPiA+ID4gKwkJfTsNCj4gPiA+ID4gKwl9Ow0KPiA+DQo+IA0KPiANCj4gVGhhbmtzLA0KPiBN
aXF1w6hsDQo=
