Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AC3C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A2D222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="IB+buRlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391022AbfBMJAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:00:08 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:31721 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390992AbfBMJAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:00:01 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="26473920"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2019 01:59:45 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 01:59:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcip/Rj9yUXjV1cOac0dIELXXE3/ecdWWaSMUGzD8LM=;
 b=IB+buRlZ7zPGrHiez0xHBFc+3jTXaSEZCfAHzwC38cKdX2PvbiuXi4fyrf6XAeSTGHn0OO7/lNJ4msmqIc25qyBR3T/n9dsqKs57AIpXBZ2jYcEDTRsO+P5aWxVppzEBqUevmw9NzVgopAJGwCZeZV5+NW96wM3TYBUUVRKFs5Y=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:59:41 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:59:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 00/11] add support for sam9x60 nand controller
Thread-Topic: [PATCH 00/11] add support for sam9x60 nand controller
Thread-Index: AQHUw3p0Qk7j4Mv+b0SI+TmizsqHdw==
Date:   Wed, 13 Feb 2019 08:59:41 +0000
Message-ID: <20190213085930.31578-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14bf4e33-50cf-4c51-cce7-08d691919719
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0019;
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCTjZQUjExTUIwMDE5OzIzOnl6U3pjQlVEdGFHMWJ1MTZuS0o5TUlzZk5a?=
 =?utf-8?B?Zkc3amszNW1tbjNsR3FhcXI0K1BocnoxcnlSWGNlSEdoajBlUVMzTGlxenBs?=
 =?utf-8?B?T3ZZWVpKNHBTVmFHOWgrZFJRdjhaNlRQWXdTYmdkTU5zRDB0NnFlNWZKSVJL?=
 =?utf-8?B?cHRDTGhObFFsRW0zUWhBcEFtemdVTENySW1sNGo1dEpabWNVOUdSQm51cmkv?=
 =?utf-8?B?MUdGbEZ6U2RpQUVNV2M2QjRWRTBZZCtzR1YwcEYraUVhSGp5WW9kbGk5bVY0?=
 =?utf-8?B?U2wyYUNRcXc2MzdJQ1k5ckxYT1VMY0oxdHRDZ0hwdjF3d0hndlYvY3N1SjRn?=
 =?utf-8?B?enZGOFZaS0VTaGtwU2tpQzBZRnhCRGZMNE96Z2JnQmhtZkZ2Y1AremwvOURk?=
 =?utf-8?B?UnF1TXFMOXJQbk9EZGo2aHRhN0V3eDNBZDBheGJ4WFJ5RllOTW03dUx6NXNw?=
 =?utf-8?B?YVppU0Z0aEZIU00wYmoyVkVHQ0Z0RGhqV0pYUWdTQlhPMytEQnZPbDdjNmFZ?=
 =?utf-8?B?Rm95cm5WUituWXBzWUdud0dkRE5jZ0h3QlNxL2FmbVpNaXpkZWZRYTM2blR3?=
 =?utf-8?B?ZDNXYTA3ZVBUVVRIZmdHUm50RVRlUCtIWHBCb1VodXd5T1NWQmwvbW5DYUN4?=
 =?utf-8?B?TUc3UGNNZHhseTZrWXVrNHp0bWRZSGhoczBwMDUvZlNva0hETEprVGJQTnNR?=
 =?utf-8?B?OVJySm1VbVVPSXNOTm02YytrVzhGNmVrNUM2V2NETERtQ0tnY1E0Q3MrYm8r?=
 =?utf-8?B?eDFZTWdrRVYyaXhwa1hEdVNXeENZL0JvQldZOGo4Nm5seXUvQ0tpdUVsM2hQ?=
 =?utf-8?B?emtxSFlKVzJSZFFtOUFDRjNpWmc0T1FnMjR2MnhndW96MFJxNWRJdTVMNnQ2?=
 =?utf-8?B?NFVxT3h4cGRLdkdzSmdSS1pXMjJRNjFGMU95L2prWlBpTXU2MEIyZG5nUzF4?=
 =?utf-8?B?VERHejVlb2h4RVN0Y2orRXZwRVdGbEtaWUl5NFZpb0RJMnFlL2hrbWRYb0pN?=
 =?utf-8?B?QXBmemJ3MEgrKzdJaVhIbmZMUnBqaUVzRU01ZWl3RTBVWktZNnNXb1ZyNGYr?=
 =?utf-8?B?dkZNcWl2Z1d3WTUyQTg4WHJLMGluTGVObTJMRXJ5TW5EbHFGb3VxWkRwNU1r?=
 =?utf-8?B?eXo1Ty9ZZGhlRmNjMmF6enYzZitoL2hoWXppemhxZ2Y3Q2drSWtZclhmTmxV?=
 =?utf-8?B?dit6V1dLbFVQaHpYZ0FXcWNJcWpmcnl6Q1UrNnQ2VkcwdFEzcTY2UTUxcEFz?=
 =?utf-8?B?eUp3UWlRdFc1Q09sSWdXQUgzbUJXOGROdDBFdnRQSDZkSDFXMHJabXlKQzNG?=
 =?utf-8?B?V2RDK2pMbjJRb294dzRKbVRyR2ZzLzZyU3JTS2lqWWtrQXIvcWFXZTJPTlkv?=
 =?utf-8?B?U3FCN2JsTjdub3N1TDRxNmZsc2FESUk4dFEwNTNHVFVCMjFmRS9NNzJmaHpC?=
 =?utf-8?B?UkJpRXZadndpK2gzRENXSUhNWHBwN09tcE9URHQxU3lrTUs1UVAyZVZCL0Ni?=
 =?utf-8?B?YjJMTXF6WTl6RnlmS2drLzd3TERMOFRNb3ZPb3dBbFpmQ1NWd2FORmZHeHk3?=
 =?utf-8?B?MHpuNVlyUFpsd20wZ1JTQkw3aEFjQ29USDhuUzJFMkcvVkJLVXQxbVM3UnND?=
 =?utf-8?B?S1pGRDVXYkRHYnliQllOcEkzdlNESDQ0azhDN2UxelB1d0dLU1RIemwxTm1D?=
 =?utf-8?B?a0JTSUJXTVo3VTY5TnY4anJNUTZNYlpWdVp4TFU0U3YzKzFSSzZSVnFiMDhS?=
 =?utf-8?B?VWxHTG5WZ1BBNExmc0NxQT09?=
x-microsoft-antispam-prvs: <BN6PR11MB00195F5A992F717D304E787BF0660@BN6PR11MB0019.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(81166006)(50226002)(106356001)(7416002)(6436002)(54906003)(2201001)(1076003)(81156014)(26005)(110136005)(476003)(102836004)(107886003)(8936002)(6512007)(6486002)(4326008)(2616005)(316002)(8676002)(105586002)(99286004)(66066001)(486006)(6116002)(3846002)(186003)(86362001)(2906002)(72206003)(71190400001)(14454004)(966005)(53936002)(71200400001)(478600001)(68736007)(6506007)(386003)(2501003)(52116002)(97736004)(7736002)(305945005)(6306002)(256004)(25786009)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0019;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GbMDcmv/Y/ahwS/4aoZYmoBFmahqvV4oIlyiHMgb4Y+QZrJDsQp8XhsK39Xa7X9bgMiEUUJltlfcw421GNJF76aj/zz4ToOFI9lBEchCpIvbKPwQk+h2GTS9pPHDNdtUTWrtS4IG06U9ehm1Nn4NAUH/q06RwkTbFNpHAadRwSgd+FcrTbfN7Brg5FMk5fMJZ7UMjdAIEhJTMubHvmyQHmNY5vcazVYAwBQ3kniKhIGL8GRB+Oni+YMnqnirEA9TEekzoFn5KZvXauBccqf/kesQoFnRLEAf9nreWIPZ9Y/wDrMXPTYHm2vr/BXU4HC+oIRLN5lpVC0MWeCCgTE7C5nFIxLIDluJwz9gPr14C3+5YFWiyVL7Bg/nuWfIgULdqmbNJtoUYVOQoNsj6jLQUKYijzvEVbGunNrF01vgRUM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53771A0CC529EC419819DE0424FC4221@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bf4e33-50cf-4c51-cce7-08d691919719
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:59:38.4918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0019
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQpUaGUg
c2FtOXg2MCBib2FyZCBkZWZpbmVzIHRoZSBDQ0ZHX0VCSUNTQSByZWdpc3RlciB1bmRlciBTRlIs
DQphbmQgbm90IGFzIGEgTUFUUklYIHJlZ2lzdGVyLCBhcyBwcmV2aW91cyBib2FyZHMgZG8uDQpO
QU5EIEZsYXNoIEkvT3MgYXJlIGNvbm5lY3RlZCB0byBEMTbigJNEMjMsIHRodXMNClNGUl9DQ0ZH
X0VCSUNTQS5ORkQwX09OX0QxNiBpcyBzZXQgdG8gMS4NCg0KVGVzdGVkIHVzaW5nIG10ZC11dGls
cy4NCg0KLSBwYXRjaGVzIFsxLCA3XSBhZGQgc3VwcG9ydCBmb3IgdGhlIHNhbTl4NjAgbmFuZCBj
b250cm9sbGVyLiBJIHdvdWxkDQogIHN1Z2dlc3QgdG8gZ2V0IHRoZW0gdGhyb3VnaCBsaW51eC1t
dGQgdHJlZSwgaWYgYWxsIGFncmVlLg0KLSBwYXRjaCA4IGNhbiBiZSB0YWtlbiBieSBBbGV4YW5k
cmUNCi0gcGF0Y2ggOSAtIFNQRFggY2hhbmdlLCBjYW4gYmUgdGFrZW4gYnkgTGVlDQotIHBhdGNo
IDEwIC0gU1BEWCBjaGFuZ2UsIGNhbiBiZSB0YWtlbiBieSBBbGV4YW5kcmUNCi0gcGF0Y2ggMTEg
LSBTUERYIGNoYW5nZSwgc2hvdWxkIGdvIHRocm91Z2ggbGludXgtbXRkDQoNCmR0IGNvbXBhdGli
bGUgc3RyaW5nIGZvciAibWljcm9jaGlwLHNhbTl4NjAtc2ZyIiBoYXMgYWxyZWFkeSBiZWVuDQpz
dWJtaXRlZCBhdCBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNzk5ODMxLw0K
DQpUdWRvciBBbWJhcnVzICgxMSk6DQogIEFSTTogYXQ5MTogYWRkIHNhbTl4NjAgU0ZSIGRlZmlu
aXRpb25zDQogIG1lbW9yeTogYXRtZWwtZWJpOiBhZGQgZ2VuZXJpYyBuYW1lIGZvciBlYmkgcmVn
bWFwDQogIGR0LWJpbmRpbmdzOiBtZW1vcnk6IGF0bWVsLWViaTogYWRkIHNhbTl4NjAgY29tcGF0
aWJsZQ0KICBtZW1vcnk6IGF0bWVsLWViaTogYWRkIHNhbTl4NjAgRUJJIHN1cHBvcnQNCiAgbXRk
OiByYXduYW5kOiBhdG1lbDogYWRkIGdlbmVyaWMgbmFtZSBmb3IgRUJJQ1NBIHJlZ21hcA0KICBk
dC1iaW5kaW5nczogbXRkOiBhdG1lbC1uYW5kOiBhZGQgc2FtOXg2MCBjb21wYXRpYmxlDQogIG10
ZDogcmF3bmFuZDogYXRtZWw6IGFkZCBzYW05eDYwIG5hbmQgY29udHJvbGxlciBzdXBwb3J0DQog
IG1lbW9yeTogYXRtZWwtZWJpOiBtb3ZlIE5VTV9DUyBkZWZpbml0aW9uIGluc2lkZSBhdG1lbC1l
YmkNCiAgbWZkOiBzeXNjb246IGF0bWVsOiBzd2l0Y2ggdG8gU1BEWCBsaWNlbnNlIGlkZW50aWZp
ZXJzDQogIG1lbW9yeTogYXRtZWwtZWJpOiBzd2l0Y2ggdG8gU1BEWCBsaWNlbnNlIGlkZW50aWZp
ZXJzDQogIG10ZDogcmF3bmFuZDogYXRtZWw6IHN3aXRjaCB0byBTUERYIGxpY2Vuc2UgaWRlbnRp
ZmllcnMNCg0KIC4uLi9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvYXRtZWwsZWJpLnR4dCAg
ICAgIHwgICAxICsNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvYXRtZWwtbmFuZC50eHQg
ICAgICAgICB8ICAgMSArDQogZHJpdmVycy9tZW1vcnkvYXRtZWwtZWJpLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgNDggKysrKysrLS0tDQogZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwv
bmFuZC1jb250cm9sbGVyLmMgICAgICAgfCAxMTcgKysrKysrKysrKysrKysrKy0tLS0tDQogZHJp
dmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvcG1lY2MuYyAgICAgICAgICAgICAgICAgfCAgIDUgKy0N
CiBkcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9wbWVjYy5oICAgICAgICAgICAgICAgICB8ICAg
NiArLQ0KIGluY2x1ZGUvbGludXgvbWZkL3N5c2Nvbi9hdG1lbC1tYXRyaXguaCAgICAgICAgICAg
IHwgICA3ICstDQogaW5jbHVkZS9saW51eC9tZmQvc3lzY29uL2F0bWVsLW1jLmggICAgICAgICAg
ICAgICAgfCAgIDYgKy0NCiBpbmNsdWRlL2xpbnV4L21mZC9zeXNjb24vYXRtZWwtc21jLmggICAg
ICAgICAgICAgICB8ICAgNSArLQ0KIGluY2x1ZGUvbGludXgvbWZkL3N5c2Nvbi9hdG1lbC1zdC5o
ICAgICAgICAgICAgICAgIHwgICA2ICstDQogaW5jbHVkZS9zb2MvYXQ5MS9hdG1lbC1zZnIuaCAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMzQgKysrKy0tDQogMTEgZmlsZXMgY2hhbmdlZCwgMTYx
IGluc2VydGlvbnMoKyksIDc1IGRlbGV0aW9ucygtKQ0KDQotLSANCjIuOS41DQoNCg==
