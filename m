Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0832C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3332082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jr1Tyq4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbfAPGT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:19:27 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:1333 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbfAPGT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:19:27 -0500
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; 
   d="scan'208";a="26477945"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 15 Jan 2019 23:19:24 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 15 Jan 2019 23:19:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NByypZFWjagvW5Y2AcMKZgxN1lXdnRFEOiYR+yCP/Gs=;
 b=jr1Tyq4KyHcONZIuyO03Rt4B/QAtrg61+IQipci3pYjUFp68dEAKRFNCZekd7llGM8Tgd8MqQP4F6g0Xrx2l4NGzyFGA5ZCYDwbaLEYZgmlCJYSmDS1eoUPU77zTm/cPzi/yiHLqQ7ngSVec7y80J4eN9UihgkuD99IXJsuteSE=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1684.namprd11.prod.outlook.com (10.173.28.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 06:19:20 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 06:19:20 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <yogeshnarayan.gaur@nxp.com>, <linux-mtd@lists.infradead.org>,
        <boris.brezillon@bootlin.com>, <broonie@kernel.org>,
        <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <robh@kernel.org>, <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <computersforpeace@gmail.com>, <frieder.schrempf@exceet.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/5] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Topic: [PATCH v7 2/5] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Index: AQHUrLnyGdnur+dY+UC8ZO94XGejjaWxbVaA
Date:   Wed, 16 Jan 2019 06:19:20 +0000
Message-ID: <cb800292-a732-f6f4-650e-00bffe760e5a@microchip.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547546584-5254-3-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547546584-5254-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0109.eurprd04.prod.outlook.com
 (2603:10a6:803:64::44) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1684;6:VV0nXFtkUbxdq+5rOiocPF0mc0bHLZOqszbzgcr23ZixFT/Xls4yzDEWDGNkU5P062gCZJKQLe2MvoAyPnHVWYY+1tQthcZQHi7qshtE/iC/D6G6f4E5NHS5jINLc7Z0iGTwjQdTdtP1/3hvEz1DDUHeX5q6d/6HVPKm3yCeDlotA6do9DDLQYf+naGldudMgCRVP8npLe9fvrS874VsObH0bWTJ8CmQswcngZyhiFYgSmR+B7UdasQkTuWX2AyN4vawlplH7lUQR86JIlJsieHvq2l6q7nydVNl/NUqsslELPkIzr9P/hOb15iXvd1W9k1jj+8xELqMyjb7TIuGVBfnJtA2duCSVG2cdbMKSfuBhh9ovsd7PH1oLzMR3LhxFw0tk4d0pnLPv3KlnFeczDPUeFVJzln5vSo3ezCVjzGeIaUWDIfWEMMZ+Wpf+FdEB7CDmrK97P3TORgLSIEp4w==;5:kT5HcADGRBFVxGCTos4gILUBKRDs5kblL/DSEP57f07DIbsLlxYkfRzLghc/dqHVunONhagIteTaIqQHAWgIXaScJ70R5KiH7gi/pgJoJJQTikjFmbzbgBRENGJHHbiTmxWXO15pA+k+xSc6kc7fC/Ep5Oqlm315LgnDqkndSyLf9zTNhnAt7Ru5QxQdtmTSM1fL1JUtGQNvBHOPx4vOgA==;7:DKNWsSrkOoc5XbguE5ppXszpJnK1vzONnE4i3nbsdETPt1Wlvdwzn9PqzkaiEE+/zNKtVawl7RMx5GhEs/EAhfLKrF/w01w9w2xSy+5gni9QkzxJjhNMbccCyFcKAsu3+7jjT3AJCrUI0lUCg61ASQ==
x-ms-office365-filtering-correlation-id: 4f85e8c4-14e4-4c6f-5064-08d67b7a8cc5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1684;
x-ms-traffictypediagnostic: BN6PR11MB1684:
x-microsoft-antispam-prvs: <BN6PR11MB1684CE75096A18BCBDA2F42CF0820@BN6PR11MB1684.namprd11.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(14454004)(66066001)(3846002)(86362001)(53936002)(6506007)(6116002)(386003)(31696002)(4326008)(14444005)(256004)(53546011)(97736004)(72206003)(71190400001)(71200400001)(39060400002)(6512007)(7736002)(305945005)(316002)(81156014)(81166006)(102836004)(36756003)(8936002)(8676002)(2201001)(6246003)(76176011)(54906003)(229853002)(105586002)(106356001)(52116002)(7416002)(25786009)(26005)(5660300001)(110136005)(11346002)(6436002)(68736007)(476003)(2616005)(486006)(186003)(31686004)(446003)(99286004)(6486002)(2501003)(478600001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1684;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 56DyFUFyEiivMs9sUknZhhkqJ3HyL11rRmxFIIdjpAFo3Ptm6gQtRNLl384NVy4D8oUJ7AxRRDVNBPDNUiUFsVl9e7mJcRkReL72gFkB7Pyjmee/3pyWBpkcBMfeNPWr409qvnU0sn308Q6pp/NpD+6QlqpehzaK6Op9Q2vyNoCmh0zbueebyk9olMaO6v5FetgS21/qO0rPv/ra3TYjsI0HBhc7Py01VFANwNBhN2Pqd0AMzcFj745xjhAByYNEPeoegwOnK0ZlXmTfYolW+EuyzpZ+gCRECR6HHnyfBvAtQzCpDcCrKhxB09KkU7Aaha5Awnwzpe54wPftqMxo9ar1H3nKGmqpG4tpV+JcQ1FZJuPS1fcSyoEpbNgyKIGccsUoLwpEXqLATMwLZzeLYOe9otJm6lhwfy3FCEymn3E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <94D5D15A0F9C1B4FA92B2F87B7A562AA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f85e8c4-14e4-4c6f-5064-08d67b7a8cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 06:19:17.3601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1684
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAxLzE1LzIwMTkgMTI6MDUgUE0sIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+
IEFkZCBvY3RhbCByZWFkIGZsYWcgZm9yIGZsYXNoIG10MzV4dTUxMmFiYS4NCj4gVGhpcyBmbGFz
aCwgbXQzNXh1NTEyYWJhLCBpcyBvbmx5IGNvbXBsYWludCB0byBTRkRQIEpFU0QyMTZCIGFuZCBk
b2VzDQo+IG5vdCBzZWVtIHRvIHN1cHBvcnQgbmV3ZXIgSkVTRDIxNkMgc3RhbmRhcmQgdGhhdCBw
cm92aWRlcyBhdXRvDQo+IGRldGVjdGlvbiBvZiBPY3RhbCBtb2RlIGNhcGFiaWxpdGllcyBhbmQg
b3Bjb2Rlcy4gVGhlcmVmb3JlLCB0aGlzDQo+IGNhcGFiaWxpdHkgaXMgbWFudWFsbHkgYWRkZWQg
dXNpbmcgbmV3IFNQSV9OT1JfT0NUQUxfUkVBRCBmbGFnLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
VmlnbmVzaCBSIDx2aWduZXNockB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBOYXJh
eWFuIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL3NwaS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4g
aW5kZXggODcyZDcwNzIyNjcyLi41M2EzYmNjNmE1NWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5v
ci5jDQo+IEBAIC0xODc3LDcgKzE4NzcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2lu
Zm8gc3BpX25vcl9pZHNbXSA9IHsNCj4gIAkvKiBNaWNyb24gKi8NCj4gIAl7DQo+ICAJCSJtdDM1
eHU1MTJhYmEiLCBJTkZPKDB4MmM1YjFhLCAwLCAxMjggKiAxMDI0LCA1MTIsDQo+IC0JCQlTRUNU
XzRLIHwgVVNFX0ZTUiB8IFNQSV9OT1JfNEJfT1BDT0RFUykNCj4gKwkJCVNFQ1RfNEsgfCBVU0Vf
RlNSIHwgU1BJX05PUl9PQ1RBTF9SRUFEIHwNCj4gKwkJCVNQSV9OT1JfNEJfT1BDT0RFUykNCj4g
IAl9LA0KPiAgDQo+ICAJLyogUE1DICovDQo+IA0K
