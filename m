Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84EAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CA520851
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="psuYdaeV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EJTBh6xL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfALAN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:13:59 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50192 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALAN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547252038; x=1578788038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lVb5k/Qt1nVDygdtStjYDyPav21L0w/AtNqFGgrcjVE=;
  b=psuYdaeVeiMA0AKhFkA58CYGhR31sC1wRZs+oerHl6jLyGO3Ud9cbP2S
   lwtaZGh788Ca7DCifzm+THsP7l0Ftu72ihTYQXHoxS9NjaxjHoeKTztOc
   joH/OYfpUUDAUuquZlo4fZuXADfdR6AOEVM0DvhEqJCDJ6ZdKKCXR4iUB
   1BvqCr1U6kKZNLpSY1BlwZaO+35tc56XN+xdikYp1JCKHuUlsbXb9Gqc9
   t3SFTEx0oDvW+fL83mT7P0Pvy+6eu9qRMrcihjfH3KJQaBQIMiAruhP6X
   iucfzA4c4rL5MTRxegO9k/RAgKghIa+9oCHKUCS4KXcIKmjUr60yWn/xE
   w==;
X-IronPort-AV: E=Sophos;i="5.56,467,1539619200"; 
   d="scan'208";a="103535855"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2019 08:13:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVb5k/Qt1nVDygdtStjYDyPav21L0w/AtNqFGgrcjVE=;
 b=EJTBh6xLNzXY7glGoS3o2JXbXoAvwP+ZPAGTXfQs0GdGwMwgdR8P6ttm/V4vgQK/t4xqlSSyWMiFkaPd3kUgWxl9CStwquQ8FQDvuIZCXQOLiXxMA8/KxfhyR4DSJqTFuI/vgTUcImDBv7gLPlRsc8S5LQLVrNt0D3NWcDYSE1s=
Received: from MWHPR04MB0401.namprd04.prod.outlook.com (10.173.48.18) by
 MWHPR04MB0481.namprd04.prod.outlook.com (10.173.48.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Sat, 12 Jan 2019 00:13:56 +0000
Received: from MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::10e5:e75d:3272:2d33]) by MWHPR04MB0401.namprd04.prod.outlook.com
 ([fe80::10e5:e75d:3272:2d33%7]) with mapi id 15.20.1516.016; Sat, 12 Jan 2019
 00:13:55 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Topic: [PATCH v3] RISC-V: defconfig: Enable Generic PCIE by default
Thread-Index: AQHUqgpOagOSSqCnS0mH6o+zJyJ+r6Wqw1MA
Date:   Sat, 12 Jan 2019 00:13:55 +0000
Message-ID: <6f59c0101b53d70b4f9c63c156b59151d99d8034.camel@wdc.com>
References: <20190112000346.2620-1-alistair.francis@wdc.com>
In-Reply-To: <20190112000346.2620-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0481;6:gDa9CZMfJTfmGAwXMrih+p3AlXVeRBqP8H9fM/yOHqf5oGx6KBjeEiorX46UN5xqFaw7GJdo4cWbGtFCFWiPX4jV1WnHjSbbDMEJX6i5sTarylL765PYe6g/hvEz23Y3AYzi2yDNUAs5/cGOOjL0YG5DNX6mtsXHw0zxT6jS0iiUyzCm3u4DhW/D+M5lA+bDwaa9gQtvEVYKOP8gqAvD6Qyir9PLtA9ZZCMkP0JWqRMhWEauWZAUQep0aAFtZLoBrc18CSoyVCQGSblSE/v6vRkU4PgvpNUQSCOwbBAE6MxH1WUHwIpMJs8T/LjjpQMvqOl1yFdMgX+w+u/qoq3OFRwd+GMLtkTfdnARQfIYt83IWEh1S22CXAPQ2WopyhfLbm6HcUGQ7UhK37SdyOr2lXnHMaegorpcxl/9eDyZOnX94+EcIpLbxZbs5LL9WjhbWw/epCFgGlijRn0Q0+Wnog==;5:mo4Vi6CvRfSRKrMz/vP2A/S2O+2vGgHVGAC/J4d+qBUfDOxL+E8PLTXuC2u/Iglwg5hhrwTjHPIVJ4qgfS/3bGSl1XzlrIuYMITGnN6kw9hQiYjiPi3ILcny5Ch/A8VDf7NTHsFFcM01KQ3YSN2RcPNWaXgZjLE4OVOK7BIZce3LJg8GHVjWYcv12B+qE1XSCsVEmhVCj1YOBZ8OCF52pg==;7:X9oMSZnsypyBt3e122ql5ZkJl28vQcVPijXDO/OvR/3xaIpQZxt+lTBnkXw/r54h0JMUTQNPO0DO1oBwiAwFXJjN7+6r8vdq9t1crSKxlN9rQu+Amt0LCZFbUCLNGlcJhCBOW7s+idmqfvj2mXQKNw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8f682d26-fb0d-49bc-81e8-08d67822d772
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0481;
x-ms-traffictypediagnostic: MWHPR04MB0481:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0481358854E16B02D304A35490860@MWHPR04MB0481.namprd04.prod.outlook.com>
x-forefront-prvs: 0915875B28
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(110136005)(105586002)(68736007)(478600001)(106356001)(305945005)(118296001)(229853002)(6506007)(102836004)(26005)(486006)(2501003)(4326008)(72206003)(186003)(25786009)(6116002)(3846002)(2616005)(476003)(2906002)(76176011)(6246003)(14454004)(14444005)(256004)(11346002)(36756003)(66066001)(6512007)(97736004)(5660300001)(86362001)(6486002)(71190400001)(99286004)(316002)(71200400001)(7736002)(53936002)(446003)(6436002)(8936002)(81166006)(8676002)(81156014)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0481;H:MWHPR04MB0401.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sejnGhDEA8Axg8/9MgOmc18OdFK3Q6TFb9CM/shAITgOV8IGIj7AtMBF/8HQH6C63oaXmTyTLIFPp6b0GUTSEs61/gZbSi/2qpC8QNpmXeB3aMBl8oj10C+NsfTcOzvhHFD/CrqJIsw37GYfdEHZE2hbyKwFV9QbgTq9QDZTYiWAQpNlqgLgMLvYiIRE7rO+WEJs2f/9dzONrte6XgAahkIK5qVONoHs9kdUNFRmJiroR68RDwtQAPlJf46JWuQpZeu1+RtQVQXWnD3WfF1lQsh8O+dXTr69OtCvCE4kuu+lhAfDKTfY/SronEZAIknCiB/kAiLpLMHycEPHiKUMVeOv56Y96KOqH4Up1nk83JBcJ0MyXlz6w66oXG90PpXJOVMXpiHAr0DmH2y1h81tq4bhrrABIv9WHxte7ARUR+Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CC1A2CC90DB504EBE404388530AD8AC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f682d26-fb0d-49bc-81e8-08d67822d772
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2019 00:13:55.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0481
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE5LTAxLTEyIGF0IDAwOjAzICswMDAwLCBBbGlzdGFpciBGcmFuY2lzIHdyb3Rl
Og0KPiBFbmFibGUgZ2VuZXJpYyBQQ0llIGJ5IGRlZmF1bHQgaW4gdGhlIFJJU0MtViBkZWZjb25m
aWcsIHRoaXMgYWxsb3dzDQo+IHVzDQo+IHRvIHVzZSBRRU1VJ3MgUENJZSBzdXBwb3J0IG91dCBv
ZiB0aGUgYm94Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3Rh
aXIuZnJhbmNpc0B3ZGMuY29tPg0KPiAtLS0NCj4gIGFyY2gvcmlzY3YvY29uZmlncy9kZWZjb25m
aWcgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvY29uZmlncy9kZWZjb25maWcN
Cj4gYi9hcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnDQo+IGluZGV4IGYzOTk2NTlkM2I4ZC4u
MThiNTBiZjQxYjY3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmln
DQo+ICsrKyBiL2FyY2gvcmlzY3YvY29uZmlncy9kZWZjb25maWcNCj4gQEAgLTE0LDYgKzE0LDgg
QEAgQ09ORklHX0VYUEVSVD15DQo+ICBDT05GSUdfQlBGX1NZU0NBTEw9eQ0KPiAgQ09ORklHX1NN
UD15DQo+ICBDT05GSUdfUENJPXkNCj4gK0NPTkZJR19QQ0lFUE9SVEJVUz15DQo+ICtDT05GSUdf
UENJX0hPU1RfR0VORVJJQz15DQo+ICBDT05GSUdfUENJRV9YSUxJTlg9eQ0KPiAgQ09ORklHX01P
RFVMRVM9eQ0KPiAgQ09ORklHX01PRFVMRV9VTkxPQUQ9eQ0KPiBAQCAtNDYsNyArNDgsNiBAQCBD
T05GSUdfSU5QVVRfTU9VU0VERVY9eQ0KPiAgQ09ORklHX1NFUklBTF84MjUwPXkNCj4gIENPTkZJ
R19TRVJJQUxfODI1MF9DT05TT0xFPXkNCj4gIENPTkZJR19TRVJJQUxfT0ZfUExBVEZPUk09eQ0K
PiAtQ09ORklHX1NFUklBTF9FQVJMWUNPTl9SSVNDVl9TQkk9eQ0KDQpBaCwgdGhpcyBzaG91bGRu
J3QgYmUgcmVtb3ZlZC4gU29ycnkgZm9yIHRoZSBzcGFtLCBJJ2xsIHNlbmQgYSB2NC4NCg0KQWxp
c3RhaXINCg0KPiAgQ09ORklHX0hWQ19SSVNDVl9TQkk9eQ0KPiAgIyBDT05GSUdfUFRQXzE1ODhf
Q0xPQ0sgaXMgbm90IHNldA0KPiAgQ09ORklHX0RSTT15DQo+IEBAIC02Myw3ICs2NCw2IEBAIENP
TkZJR19VU0JfU1RPUkFHRT15DQo+ICBDT05GSUdfVVNCX1VBUz15DQo+ICBDT05GSUdfVklSVElP
X01NSU89eQ0KPiAgQ09ORklHX1NJRklWRV9QTElDPXkNCj4gLUNPTkZJR19SQVM9eQ0KPiAgQ09O
RklHX0VYVDRfRlM9eQ0KPiAgQ09ORklHX0VYVDRfRlNfUE9TSVhfQUNMPXkNCj4gIENPTkZJR19B
VVRPRlM0X0ZTPXkNCj4gQEAgLTc3LDUgKzc3LDYgQEAgQ09ORklHX05GU19WNF8xPXkNCj4gIENP
TkZJR19ORlNfVjRfMj15DQo+ICBDT05GSUdfUk9PVF9ORlM9eQ0KPiAgQ09ORklHX0NSWVBUT19V
U0VSX0FQSV9IQVNIPXkNCj4gK0NPTkZJR19DUllQVE9fREVWX1ZJUlRJTz15DQo+ICBDT05GSUdf
UFJJTlRLX1RJTUU9eQ0KPiAgIyBDT05GSUdfUkNVX1RSQUNFIGlzIG5vdCBzZXQNCg==
