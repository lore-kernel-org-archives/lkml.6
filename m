Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0157BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C8120846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CcHWQQlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C8120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbeGWKHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:07:37 -0400
Received: from mail-eopbgr680058.outbound.protection.outlook.com ([40.107.68.58]:12120
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388043AbeGWKHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8RA2bfNoBBLFaflopTDX7mHNuDibUbI/cxnFQ+jfio=;
 b=CcHWQQlhmEN22YDIgdmvW/vd+dZtI5Vu/EMo8YQOFP9u8RYDSjCoYvUTX2CnFMwBa/6bp7Egfy4JPB4yszH1MfDi4HELoVgtuZja32QIk1j0ecral2GTmN7PcfdxkJVJRvvQtJujeHsHkqlhOoxK/bSoThbF/Ch2bkPXBXw9Ppc=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3182.namprd02.prod.outlook.com (10.164.133.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 09:05:42 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::3cbb:410c:be52:450]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::3cbb:410c:be52:450%5]) with mapi id 15.20.0973.022; Mon, 23 Jul 2018
 09:05:39 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.co" <ada@thorsis.co>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [LINUX PATCH v11 3/3] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Thread-Topic: [LINUX PATCH v11 3/3] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Thread-Index: AQHUGOoLniN+aTtuWkq5HvPOVPEQk6SZO2PwgANA4wCAABom4A==
Date:   Mon, 23 Jul 2018 09:05:39 +0000
Message-ID: <MWHPR02MB262381A5BE3BE24EEF060F41AF560@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1531294612-29526-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <MWHPR02MB2623DFB0D13FF25DECC16027AF570@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20180723093038.5f6933d3@xps13>
In-Reply-To: <20180723093038.5f6933d3@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3182;6:lnDzBKi5w0KizrBir9BIIIc4/lu4U7iBWQp3QANXhI0PwbT/ob51hCCvdQN1tmi2slOxahOP28NfVuvHbnY0Y+f8jGIyniPLytkjfFhBl4TKbfENiZPdbTfXCWFnUngYb4wd7QdWfCHIxmmzgdpeXmNaCumErinHJbkAs5Zq5VIKNUA+BM0LHn5XllURjx/HoqFwzLy+m5WkrXnHUv0DVqapkNwV+RhP6qLiI3td4CunARsldHh8yGRkNaMSLXZ4oe6J8KPLTigONqg0qSvopM3E4P6eYrJXA2NpjlXj6EWVUihCfBOL2p70lqy03KCaMSbrDRHzElunnSpfWkfGQQZN3o4Olt+ftxG4ufUUb2iUAc+wLHOTtCmYPm82X1H0vY82Yi4ydzrVEqfw4w0mTDXv6f1xLbczgEVPat+XAbaU4u67LmTwRd6DHoILbzJoUwSk1Zh0IzoqWDwcdTE2tw==;5:1WX1ZKB5Y8y4eJKroBfly891hW2ub91Dqsz1DAOw2sT1jzO9w23zgJhiSWPTZvy5xAQiLrp+Loe3h3qPljSJ4eFLumLvxNwDqjrRiZcoCNk7ySH+PEc5jYqW+HsRyQrw6AHLQmLGMQpRnAxRL0a3mymIu8dHuFMr2vyD6EcUzoo=;7:x0eCEutgsI2WNTWQNVSBrZ57LDd81m47EmO/M2j9800+hDq47FdJ2dus36mqgSWTH24fDLx3+dVhFiIua+CyP1V+xzm4sPX+Pd7B40gmrZ6nVVVBsxth8dd6N5jYSla+SrEQmvAojgJ5SZSsbtaVegJXzJan7VGbApMcGpeqxkOJFdbuTpmtuMJNA9eJzADktA0ktwX6qkPw19PMMvGl+6WiS1N9nTbEyhmTJ3QlCdmD+RafazAn1ZrX71FNkAT8
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(13464003)(93886005)(4326008)(102836004)(55236004)(217873002)(26005)(68736007)(39060400002)(55016002)(6436002)(7736002)(86362001)(5250100002)(105586002)(305945005)(53546011)(6506007)(106356001)(8936002)(81166006)(81156014)(9686003)(8676002)(7696005)(76176011)(316002)(25786009)(229853002)(2900100001)(2906002)(5660300001)(476003)(6116002)(3846002)(478600001)(53936002)(14454004)(486006)(256004)(74316002)(97736004)(11346002)(446003)(66066001)(7416002)(107886003)(6246003)(6916009)(186003)(54906003)(33656002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3182;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 95ec9fc4-f0c6-433a-5d6c-08d5f07b7650
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3182;
x-ms-traffictypediagnostic: MWHPR02MB3182:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-microsoft-antispam-prvs: <MWHPR02MB3182DF813E4AA1D2E3374DDAAF560@MWHPR02MB3182.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB3182;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3182;
x-forefront-prvs: 0742443479
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Hhdiwyk5Q1NGPXzJGrtOx/ug9pF9prSysPD3NlTemnhGdndegr1C2bZPODJL+rcKQKi2WPnC758EyKbAYkZZm2vBuvQ/wV0CvC+lpfQdpAN8LwO2gIFuVjWFRfnJEF/DLPHlmVIS+tTLSR2UJWDnnfIbZU+1/5fw108fSxg9Jf9q7nK0WJ4/KfHti4DbwuMIw1fuwaqA3R+lhDzg53EicRZi0Ir2Edv7IpKwcSRL6dnqMzcvlBb7c0aatvt3ed+Db/e+8skxnZGzMThz0Ou0ll3wWanKKjKRybbeERh3uvCn17E/znnKdrX7CBNcgAhvknqXUTjOcbSZ9ui3Wv1lutbbkk5mCkom159Gg+7a8xw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ec9fc4-f0c6-433a-5d6c-08d5f07b7650
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 09:05:39.6682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgW21haWx0bzptaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tXQ0KPiBTZW50OiBNb25k
YXksIEp1bHkgMjMsIDIwMTggMTowMSBQTQ0KPiBUbzogTmFnYSBTdXJlc2hrdW1hciBSZWxsaSA8
bmFnYXN1cmVAeGlsaW54LmNvbT4NCj4gQ2M6IGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbTsg
cmljaGFyZEBub2QuYXQ7IGR3bXcyQGluZnJhZGVhZC5vcmc7DQo+IGNvbXB1dGVyc2ZvcnBlYWNl
QGdtYWlsLmNvbTsgbWFyZWsudmFzdXRAZ21haWwuY29tOyBmLmZhaW5lbGxpQGdtYWlsLmNvbTsN
Cj4gbW1heWVyQGJyb2FkY29tLmNvbTsgcm9nZXJxQHRpLmNvbTsgbGFkaXNAbGludXgtbWlwcy5v
cmc7IGFkYUB0aG9yc2lzLmNvOw0KPiBob25naHVpLnpoYW5nQG1lZGlhdGVrLmNvbTsgbGludXMu
d2FsbGVpakBsaW5hcm8ub3JnOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5hZ2FzdXJlc2hrdW1hcnJlbGxpQGdtYWlsLmNv
bTsgTWljaGFsIFNpbWVrDQo+IDxtaWNoYWxzQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
TElOVVggUEFUQ0ggdjExIDMvM10gbXRkOiByYXduYW5kOiBwbDM1MzogQWRkIGJhc2ljIGRyaXZl
ciBmb3IgYXJtIHBsMzUzDQo+IHNtYyBuYW5kIGludGVyZmFjZQ0KPiANCj4gSGkgTmFnYSwNCj4g
DQo+IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+IHdyb3RlIG9u
IFN1biwgMjIgSnVsIDIwMTgNCj4gMDc6MDQ6NDEgKzAwMDA6DQo+IA0KPiA+IEhpIE1pcXVlbCwN
Cj4gPg0KPiA+IENvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB5b3VyIHJldmlldyBjb21tZW50cz8N
Cj4gPiBJIHdpbGwgYWRkcmVzcyBpZiBhbnkuDQo+IA0KPiBXZSBhcmUgYWxtb3N0IGF0IHRoZSBl
bmQgb2YgYSBwcmV0dHkgYmlnIHJlbGVhc2UsIEkgcmFuIG91dCBvZiB0aW1lIHRvIGRvIGFub3Ro
ZXIgcmV2aWV3IG9mIHlvdXINCj4gc2VyaWVzLCBzb3JyeSBmb3IgdGhlIGRlbGF5Lg0KTm8gcHJv
YmxlbSwgYW5kIHRoYW5rcyBmb3IgeW91ciByZXBseS4NCg0KVGhhbmtzLA0KTmFnYSBTdXJlc2hr
dW1hciBSZWxsaQ0KPiANCj4gUmVnYXJkcywNCj4gTWlxdcOobA0K
