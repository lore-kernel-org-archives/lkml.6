Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BEBC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33CB2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33CB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeLLJEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:04:22 -0500
Received: from mail-eopbgr740054.outbound.protection.outlook.com ([40.107.74.54]:57856
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbeLLJEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrGMOjVxXR4JNfhb6OLo+4vHcjPFSBLFmfhX+zuLZCo=;
 b=V9MNKmzdtouJrMU0aBcuQ2opSqs1c4nWiF7kONg+giTA7wp0oyKS8/APX7fexnQd8WoaK5IahRD6kcpwjXXii5q86bLNoy5hHAplJBY4bwNGNtlbex0h6iO4Z/yLPt+BcvcKhTvCVWOMCRfNR8XmABj/Io1zhSxK+svAxpYX2rw=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2880.namprd02.prod.outlook.com (10.175.50.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 09:04:17 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::a8e5:2cda:352a:6e61]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::a8e5:2cda:352a:6e61%10]) with mapi id 15.20.1425.016; Wed, 12 Dec
 2018 09:04:16 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: RE: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUd+lSRlJXewM/lk6msOyQbhKEh6VQmgMggAVkGQCAAK7ewIAAH7YAgAFcNKCAAGhpAIAAGiwAgATHTPCAHUh8EIAAOYWAgAAN+AA=
Date:   Wed, 12 Dec 2018 09:04:16 +0000
Message-ID: <MWHPR02MB26236CEF8A2110B20C825198AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <MWHPR02MB26234433484426F333E9B60EAFDC0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181118204324.373ca9cc@bbrezillon>
        <MWHPR02MB2623AAEC160F40F061E23194AFD80@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181119090246.49060019@bbrezillon>
        <BN6PR02MB2610C7D048E4A192E041BE14AFD90@BN6PR02MB2610.namprd02.prod.outlook.com>
        <20181120120244.7d2442b5@bbrezillon>    <20181120133624.3fa4742d@xps13>
        <MWHPR02MB26238A2271B33470ABFA1023AFD40@MWHPR02MB2623.namprd02.prod.outlook.com>
        <MWHPR02MB26239C2B2A7050310BEF1E9CAFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181212091135.1d0cc9a6@xps13>
In-Reply-To: <20181212091135.1d0cc9a6@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2880;6:hxpxpdD+DHcFvZMj85rUZPmNa/JzZmF9nRHX4YH08UrvlpdDpUMrZQD9iLTopHTmsGXnt7HlpGRJR0XQQgX3krDmyKJkMilrqTdGpR+DgsGzkhdy4liq5RkAdvAtrKn8DOtY69Jy5aaEpZwIlmHMWfc8/6bgmKdVhxAruR8OkzF2l1n5MuuPz2D6l+rON5z+qjKmiPH/b8mzDUpRXOupQDPDiz07htfauogKoYSZqOHS8PMhq8RraHijhSp8SeiYcSP5wNNl18oKttm+T/JXTUba73sutfXALYPfbFGvXISbkUP2/uLK0ixa/O9dBWgCS9qZ7TyX3nc+PNunR4KciNMT4kdI6EBYKIJhYJxsqysO23BjC+OHJZCKofeZwq0/fEmqcyL+4RHfnd4e2hUI3E6GqXY2mSNgXwxAvH4eSjHAJkWvCHYqfRU+UzAFI1yIszhDDZIcEnLZrloYFWfYdA==;5:lKBKYzpd0Pp9XHHG8NawYxVQ77Q1/VDwoe+6U0LFrGbYZywhZkgj8kWd3ouBjLlsVMR5eZMWH+v85n4K2UiegJVM1w3Ba2sSRhbDczxYVpJ0LY6/d7h4r4GK3s3se1LDCn3qvU8h7N1i7paTWqB6+cFUp+OtmkIIpDPQmczgE3A=;7:dF1Si5Pzuqu8U1L7MuA8Fj4PrUCFN2Mt+C6nqjg+gu29BTHg15ESU2mtXPrcwctttcyD/ywy5RcLMAUmRjf/BiRrfW65fr2ss0vn2FLTcF2xAvWEJt/S2o3jQZT+ZVTR45F+ZanUl7IoGehp6VxefQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(366004)(346002)(136003)(13464003)(199004)(189003)(3846002)(102836004)(186003)(229853002)(256004)(9686003)(26005)(66066001)(6306002)(8676002)(4326008)(476003)(6116002)(6246003)(97736004)(446003)(53546011)(316002)(93886005)(11346002)(39060400002)(54906003)(486006)(33656002)(7416002)(25786009)(53936002)(99286004)(6506007)(76176011)(6436002)(5660300001)(105586002)(7736002)(106356001)(6916009)(74316002)(217873002)(7696005)(55016002)(86362001)(68736007)(71190400001)(966005)(71200400001)(305945005)(2906002)(14444005)(14454004)(8936002)(81156014)(478600001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2880;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 391c8ba0-5297-4922-76be-08d66010cb52
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2880;
x-ms-traffictypediagnostic: MWHPR02MB2880:
x-microsoft-antispam-prvs: <MWHPR02MB288014FBB111B5EBFC995CE7AFA70@MWHPR02MB2880.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2880;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2880;
x-forefront-prvs: 0884AAA693
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RokINkw7PfhdhQDdbKoqRg3hh8HfEohrg+Ts84bEtct5ny99Z8zuUkTDEeCUnkH2RrQBKQrbGde45akIxVt63tPXhog0KQZ8t9fXxNuu3I3L+IvDeF5fojj3KsUY6qCK8B4dvXsnGhdffLLxWctkxwykg+C+EqGYlxZV2RKgZXrfWnLxLxAsXQSW4lQvedYvyDKIf7mrgmxlBEPTi9uQVrSplbfL4RHfvpAmmDkze3pQv9W531VrhzbWoqVTYy13kSdMEpthSj9omOrRAtahL5ZndtP+sFzI6DHuypyCGWi6UbBsdimqHpWcEWm1Jaq3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391c8ba0-5297-4922-76be-08d66010cb52
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 09:04:16.4863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2880
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgW21haWx0bzptaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tXQ0KPiBTZW50OiBXZWRu
ZXNkYXksIERlY2VtYmVyIDEyLCAyMDE4IDE6NDIgUE0NCj4gVG86IE5hZ2EgU3VyZXNoa3VtYXIg
UmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+DQo+IENjOiBCb3JpcyBCcmV6aWxsb24gPGJvcmlz
LmJyZXppbGxvbkBib290bGluLmNvbT47IHJvYmhAa2VybmVsLm9yZzsgcmljaGFyZEBub2QuYXQ7
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBtYXJlay52YXN1dEBnbWFpbC5jb207
IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBuYWdhc3VyZXNoMTJAZ21haWwuY29t
OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47DQo+IGNvbXB1dGVyc2ZvcnBlYWNl
QGdtYWlsLmNvbTsgZHdtdzJAaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW0xJTlVYIFBB
VENIIHYxMiAzLzNdIG10ZDogcmF3bmFuZDogYXJhc2FuOiBBZGQgc3VwcG9ydCBmb3IgQXJhc2Fu
DQo+IE5BTkQgRmxhc2ggQ29udHJvbGxlcg0KPiANCj4gSGkgTmFnYSwNCj4gDQo+IE5hZ2EgU3Vy
ZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlQHhpbGlueC5jb20+IHdyb3RlIG9uIFdlZCwgMTIgRGVj
IDIwMTgNCj4gMDU6Mjc6MDMgKzAwMDA6DQo+IA0KPiA+IEhpIEJvcmlzICYgTWlxdWVsLA0KPiA+
DQo+ID4gQW4gdXBkYXRlIHRvIG15IGNvbW1lbnRzIG9uIHRocmVhZCBodHRwczovL2xrbWwub3Jn
L2xrbWwvMjAxOC8xMS8xNS82NTYuDQo+ID4gSW4gdGhpcyBJIHNhaWQsIHdpbGwgdGFrZSBhIGRl
ZmF1bHQgZXJyb3IgY291bnQgdmFsdWUgYXMgMTYgYW5kIGR1cmluZw0KPiA+IHBhZ2UgcmVhZCwg
d2lsbCBjaGVjayB0aGUgZXJyb3IgY291bnQgUmVnaXN0ZXIgdmFsdWUgd2l0aCB0aGlzIGFuZCBp
Zg0KPiA+IGl0IGlzIGVxdWFsIHRvIG9yIGdyZWF0ZXIgdGhhbiB0aGUgZGVmYXVsdCBjb3VudCgx
NikgdGhlbiBJIGFtIGNoZWNraW5nIGZvciBFcmFzZWQgcGFnZXMuDQo+ID4gQnV0IGJpdFs3OjBd
IGluIEVDQ19FcnJvcl9Db3VudF9SZWdpc3RlcigweDM4KSB3aWxsIHVwZGF0ZSBmb3IgZWFjaCBl
cnJvciBvY2N1cnJlZC4NCj4gPiBMaW5rOg0KPiA+IGh0dHBzOi8vd3d3LnhpbGlueC5jb20vaHRt
bF9kb2NzL3JlZ2lzdGVycy91ZzEwODcvdWcxMDg3LXp5bnEtdWx0cmFzY2FsZS0NCj4gcmVnaXN0
ZXJzLmh0bWwgYW5kIGNoZWNrIGZvciBOQU5EIG1vZHVsZSwgRUNDX0Vycm9yX0NvdW50X1JlZ2lz
dGVyLg0KPiA+DQo+ID4gSSBtZWFuIHByZXZpb3VzbHkgSSBkZXBlbmRlbnQgb24gVG90YWwgZXJy
b3IgY291bnQgdmFsdWUgKGJpdFsxNjo4XSksDQo+ID4gYnV0IHdlIGNhbiBzaW1wbHkgY2hlY2sg
Zm9yIGJpdFs3OjBdIFRvIHNlZSB0aGUgZXJyb3Igb2NjdXJyZWQgb3Igbm90Lg0KPiA+IEkgdHJp
ZWQgd2l0aCB0aGlzIGFwcHJvYWNoIGFuZCBJIGRvbid0IHNlZSBhbnkgaXNzdWVzIHdpdGggdGhh
dC4NCj4gPiBJIHJhbiB1YmlmcyB3aXRoIHRoaXMgYW5kIEkgYW0gYWJsZSB0byBzZWUgdGhlIGJp
dFs3OjBdIGNvdW50IGlzDQo+ID4gdXBkYXRlZCBmb3IgZXJhc2VkIHBhZ2UgcmVhZCBhbmQgdGhl
biB3aWxsIFVzZSBuYW5kX2NoZWNoX2VyYXNlZF9lY2NfY2h1bmsoKSB0byBzZWUgdGhlDQo+IGJp
dGZsaXBzLg0KPiA+DQo+ID4gSWYgaXQgaXMgb2ssIEkgd2lsbCB1cGRhdGUgdGhlIGRyaXZlciBh
bmQgd2lsbCBzZW5kIG5ldyBwYXRjaCwgYnV0IGRvIHlvdSBoYXZlIGFueSBvdGhlcg0KPiBjb21t
ZW50cyBvbiB2MTI/DQo+IA0KPiBJcyAnbmFuZGJpdGVycnMgLWknIHJ1bm5pbmcgY29ycmVjdGx5
IG5vdz8NClllcywgYnV0IHdpdGggc29tZSBjaGFuZ2VzIGluIGRyaXZlci4NCkkgaGF2ZSBhZGRl
ZCB0aGUgbG9nIGFuZCBjaGFuZ2VzIGRvbmUgaW4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgv
MTEvMjMvNzA1Lg0KRG8geW91IHNlZSBhbnkgaXNzdWVzIHdpdGggdGhhdCBhcHByb2FjaD8NCg0K
VGhhbmtzLA0KTmFnYSBTdXJlc2hrdW1hciBSZWxsaS4NCg==
