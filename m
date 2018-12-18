Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE2AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA54217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EijPXKx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeLRFeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 00:34:01 -0500
Received: from mail-eopbgr700070.outbound.protection.outlook.com ([40.107.70.70]:24074
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726322AbeLRFeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 00:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1NMrzt4ubXj2l+J1Gflsc7Xpr+iBj/uobEIX8c0zRY=;
 b=EijPXKx6skjiDyQA3jl7U+/auZWTl6U+BhlxxwbZTpoAgHA1SfhQU8kjtZjfM91jcVlQFYwFmMGlCtQzH6i2CJt9SxSpB4LkayO7cyKq2Y0vqJPrrmC2CLWHXeTdoqZO/Q9BO/H9ACqakYqFp32a/zccVDGcce2wa+v+KyO9/4E=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2669.namprd02.prod.outlook.com (10.175.49.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 05:33:54 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::a8e5:2cda:352a:6e61]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::a8e5:2cda:352a:6e61%10]) with mapi id 15.20.1425.023; Tue, 18 Dec
 2018 05:33:53 +0000
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
Thread-Index: AQHUd+lSRlJXewM/lk6msOyQbhKEh6VQmgMggAVkGQCAAK7ewIAAH7YAgAFcNKCAAGhpAIAAGiwAgATHTPCAHUh8EIAAOYWAgAAN+ACAAAI3gIAAQgWwgAADhoCAB72ScIAAVsEAgADHyzA=
Date:   Tue, 18 Dec 2018 05:33:53 +0000
Message-ID: <MWHPR02MB26237B932D7F3CCEE0476FE0AFBD0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <MWHPR02MB26234433484426F333E9B60EAFDC0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181118204324.373ca9cc@bbrezillon>
        <MWHPR02MB2623AAEC160F40F061E23194AFD80@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181119090246.49060019@bbrezillon>
        <BN6PR02MB2610C7D048E4A192E041BE14AFD90@BN6PR02MB2610.namprd02.prod.outlook.com>
        <20181120120244.7d2442b5@bbrezillon>    <20181120133624.3fa4742d@xps13>
        <MWHPR02MB26238A2271B33470ABFA1023AFD40@MWHPR02MB2623.namprd02.prod.outlook.com>
        <MWHPR02MB26239C2B2A7050310BEF1E9CAFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212091135.1d0cc9a6@xps13>
        <MWHPR02MB26236CEF8A2110B20C825198AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212100931.149b0cac@xps13>
        <MWHPR02MB2623EDA15BE59304795F3034AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212141825.69711c57@xps13>
        <MWHPR02MB26235AE6567A06EF4C6362E6AFBC0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181217174114.24196d17@xps13>
In-Reply-To: <20181217174114.24196d17@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2669;6:nxWhUVkVhi2WEXMjBA0KTMdC2A7esX0N3EImssye0FYRMm+MBzUpLbfHDN+vzALkVHyr/vJcFSWxUznOCw1b2QxwMCkP6iPgsHRqKo6ObPAugUokvwRjT+l42mRz75zDpE6ZsbZvliCP/sbeAyL67xEka0oPo/Q/Iaam1OZEraBfzcKkcalqhMsPnTcAA3SGxPdCsSa+2qZ/qNNrw54+LWDQMn99ugQEASr056aB7D2q3zF1tGo5kqFi7lVLyVGZXLCGY+Jjo3vXT8oJf/+l+asiRb6UkUUFnR+RsD9Y+vuZsE+TRYfJKsDJ8NmenjnLhGMlmGtYG/W7wsWAkr6ZSv+tBB+rE8hCKJ/WREqTNV9FRuAwgpqxgQnFHE4Y+XFTeAERozpqu2kZFPz/cB6S0dwrhKeP1KVgcjFdWYe0J9OZME2avfanSMIDgZkxdvwX16OvGxFk7OEOin6c5gOkYA==;5:+dD2mmzFpepFIEb791BIEMsc7TtHXGJA9gKtA743me6ON1ag4qcb407l2WZJLKMD3nyG3V7HM58vPTD/en0VFAySY+W+UemXmgyJGSeg7P/QoTcy2AX0FoZMClpK9L2+8Vl5PVfr+nf+EuI6J6kmkrbRuZTC/hXjLRemb1PwWmo=;7:ReU41vAkSZkyvxoDuchuwdhQf1fhj0UH39wwnu0Qp4StmfvCpKaQMIn9VKBv0ZcyizqLs7/vsb3DudjrMRtkqrRrKpX/2vqQi3nds6cmFdLJxHfWLQjcg88NlixTPMZW55Xeeh1Ty8FuqYVsV1yhcg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39850400004)(136003)(13464003)(199004)(189003)(186003)(81156014)(106356001)(105586002)(3846002)(6116002)(54906003)(14454004)(26005)(7416002)(6916009)(33656002)(76176011)(486006)(5660300001)(102836004)(2906002)(74316002)(93886005)(7736002)(305945005)(6436002)(229853002)(7696005)(478600001)(8936002)(446003)(11346002)(68736007)(99286004)(97736004)(6506007)(86362001)(217873002)(25786009)(53936002)(4326008)(71190400001)(9686003)(55016002)(256004)(476003)(66574012)(316002)(14444005)(53546011)(39060400002)(8676002)(81166006)(66066001)(6246003)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2669;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: b34e29b0-3ceb-4bb7-fb70-08d664aa660d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2669;
x-ms-traffictypediagnostic: MWHPR02MB2669:
x-microsoft-antispam-prvs: <MWHPR02MB266982B84C76141A5F9FBF3AAFBD0@MWHPR02MB2669.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2669;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2669;
x-forefront-prvs: 08902E536D
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2DBTzlBP91C2Pj4DSJnUCd/0gxEwHPwAEczPz+Pr11OqXStxsdFE13WIloGg7/LJe5t+Zme1XpfuljCkBCK83/meWfhnNCCZlZPVyX+95VHmhmKpp1TweJkbjFWs1S3Cb6sbht5ClvaqeZod6X7A1kL0rS24hL3IDern/Q6cD/Y9LAcHA0lX8qFbhuk9hay2ULafGW4aB9TufqUtUPgwYuRbA9rHJnn6V3/GBJwBsSCV8bBQU72bcqx6BeqvRkz3ZJvyQ/F7Ym3lTaORbOKWwcpHHv/agjVKVsoD9pFRMNAerCKaABxEtUtlx6YeqvuC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34e29b0-3ceb-4bb7-fb70-08d664aa660d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 05:33:53.7976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2669
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pcXVl
bCBSYXluYWwgW21haWx0bzptaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tXQ0KPiBTZW50OiBNb25k
YXksIERlY2VtYmVyIDE3LCAyMDE4IDEwOjExIFBNDQo+IFRvOiBOYWdhIFN1cmVzaGt1bWFyIFJl
bGxpIDxuYWdhc3VyZUB4aWxpbnguY29tPg0KPiBDYzogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5i
cmV6aWxsb25AYm9vdGxpbi5jb20+OyByb2JoQGtlcm5lbC5vcmc7IHJpY2hhcmRAbm9kLmF0OyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWFyZWsudmFzdXRAZ21haWwuY29tOyBs
aW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbmFnYXN1cmVzaDEyQGdtYWlsLmNvbTsg
TWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+Ow0KPiBjb21wdXRlcnNmb3JwZWFjZUBn
bWFpbC5jb207IGR3bXcyQGluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtMSU5VWCBQQVRD
SCB2MTIgMy8zXSBtdGQ6IHJhd25hbmQ6IGFyYXNhbjogQWRkIHN1cHBvcnQgZm9yIEFyYXNhbg0K
PiBOQU5EIEZsYXNoIENvbnRyb2xsZXINCj4gDQo+IEhpIE5hZ2EsDQo+IA0KPiBbLi4uXQ0KPiAN
Cj4gPiBJbnNlcnRlZCBiaXRlcnJvciBAIDQ4LzcNCj4gPiBTdWNjZXNzZnVsbHkgY29ycmVjdGVk
IDI1IGJpdCBlcnJvcnMgcGVyIHN1YnBhZ2UgSW5zZXJ0ZWQgYml0ZXJyb3IgQA0KPiA+IDUwLzcg
RUNDIGZhaWx1cmUsIGludmFsaWQgZGF0YSBkZXNwaXRlIHJlYWQgc3VjY2Vzcw0KPiA+IHJvb3RA
eGlsaW54LXpjMTc1MS1kYzItMjAxOF8xOn4jDQo+ID4NCj4gPiBCdXQgZXZlbiBpbiB0aGlzIGNh
c2UgYWxzbywgZHJpdmVyIGlzIHNheWluZyBFQ0MgZmFpbHVyZSBidXQgcmVhZCBzdWNjZXNzLg0K
PiA+IFRoYXQgbWVhbnMgY29udHJvbGxlciBpcyBhYmxlIHRvIGRldGVjdCBlcnJvcnMgb24gcmVh
ZCBwYWdlIHVwIHRvIDI0IGJpdCBvbmx5Lg0KPiA+IEFmdGVyIHRoYXQgdGhlcmUgaXMgbm8gd2F5
IHRvIHNheSB0byB0aGUgdXBwZXIgbGF5ZXJzIHRoYXQgdGhlIHBhZ2UgaXMgYmFkIGJlY2F1c2Ug
b2YgdGhlDQo+IGxpbWl0YXRpb24gaW4gdGhlIGNvbnRyb2xsZXIuDQo+IA0KPiBUaGlzIGlzIG1v
cmUgdGhhbiBhICJsaW1pdGF0aW9uIiwgdGhlIGRlc2lnbiBpcyBicm9rZW4uIEkgYW0gbm90IHN1
cmUgaG93IHRvIHN1cHBvcnQgc3VjaA0KPiBjb250cm9sbGVyLCBhbmQgSSBhbSBub3Qgc3VyZSBp
ZiB3ZSBldmVuIHdhbnQgdG8uDQoNClRoZSBudW1iZXIgb2YgZXJyb3JzIHRoYXQgYXJlIGNvcnJl
Y3RhYmxlIGlzIGxpbWl0ZWQgYnkgYSBwYXJhbWV0ZXIgJ3QnKHRvdGFsIG51bWJlciBvZiBlcnJv
cnMpLA0KSWYgdGhlcmUgaXMgYSBjb25kaXRpb24gdGhhdCB0aGUgbnVtYmVyIG9mIGVycm9ycyBn
cmVhdGVyIHRoYW4gJ3QnLCB0aGVuIHRoZSBjb250cm9sbGVyIHdvbid0IGJlIGFibGUgdG8gZGV0
ZWN0IHRoYXQuDQpJIGd1ZXNzIHRoaXMgY29uY2VwdCBpcyBzYW1lIGZvciBvdGhlciBjb250cm9s
bGVycyBhcyB3ZWxsLg0KSW4gQXJhc2FuIGl0IGlzIGxpbWl0ZWQgdG8gMjQtYml0Lg0KDQpFdmVu
LCBpbiBjYXNlIG9mIEhhbW1pbmcsIGl0IGlzIDEtYml0IGVycm9yIGNvcnJlY3Rpb24gYW5kIDIt
Yml0IGVycm9yIGRldGVjdGlvbi4NCldoYXQgd2lsbCBoYXBwZW4gaWYgdGhlcmUgYXJlIG11bHRp
cGxlIGVycm9ycyhncmVhdGVyIHRoYW4gMi1iaXQpPw0KDQpUaGFua3MsDQpOYWdhIFN1cmVzaGt1
bWFyIFJlbGxpDQo+IA0KPiA+IENvdWxkIHlvdSBwbGVhc2Ugc3VnZ2VzdCBhbnkgYWx0ZXJuYXRp
dmUgdG8gcmVwb3J0IHRoZSBlcnJvcnMgaW4gdGhhdCBjYXNlPw0KPiANCj4gU2hhbGwgd2Ugc3Vw
cG9ydCB0aGUgY29udHJvbGxlciB3aXRob3V0IHRoZSBodyBFQ0MgZW5naW5lPyBCb3JpcywgYW55
IHRob3VnaHRzPw0KPiANCj4gDQo+IFRoYW5rcywNCj4gTWlxdcOobA0K
