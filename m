Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D51C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A299B20858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="m+i9vXnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A299B20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJHS5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:57:00 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:8871
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbeJHS47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+Ub4/j943AW24dE6SwcloOwWmjUtQZvcKb9RJBsAL0=;
 b=m+i9vXnDfZPYjOjhDg7dea8NPcUzlIpY35O3ozyapyQhrHfIlUCDJy15PjeayUztyiB4cFe06s+35LwapMBTQwee41HXJAfQ9VW82He+K4jR6EdWwzsK/OtxivxGNAb2xHviLAHWPqsTiUB/B5it26F/ELPyjCdIOi9qNik4ZlA=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4027.eurprd04.prod.outlook.com (52.134.107.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Mon, 8 Oct 2018 11:45:36 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::d971:723:f402:76bd%2]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 11:45:36 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset
 gpio signal polarity
Thread-Topic: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset
 gpio signal polarity
Thread-Index: AQHUVkRSdlHfynMwIEC0L77BDqk26KUVTE6A
Date:   Mon, 8 Oct 2018 11:45:36 +0000
Message-ID: <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com>
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
 <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR03CA0034.eurprd03.prod.outlook.com (2603:10a6:20b::47)
 To DB7PR04MB4667.eurprd04.prod.outlook.com (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4027;6:DPBeZp+3ulFgk6ES7rwUo2YsusroqqSBiSvjheVMwst1YPjj0JKnS4iAqpw971z69tMERzL/k4Sg1+ksgdYqA+d6ZJ+Ip7lvbjJh36b2eaCaqxstcbZdw0SvKGczdHxWK6R+NSaHfU7Iv7r26KvgZQmn0yQTkjSvM4MZ7eUFYv3Hiq1LOAaqownh1xh76Rrc7yaXep5r5wx2RGbpWlJReNKOyu1uWzY4yQw6mwSywb87OfHt23ANuKAid1jLHkoUGdMW7SeCV0MbKgjoWASoPXCAClUdsenhW71NlGwFgx/wTWPydhCTfOK4l8U0HsxFLyKYYn8rT/gK1rWYM7+9cn8Aw+RbyqLd+5cgGTtfHC5sztHFgvPai3KeW7tm8UCy+/RGodev70HhFY0W+DjD+RJQ62/ULxJJ4MWn5ljDLqmj48OgkhVnIupHm1NIvSviIAnqH1XIGRLu0/UMBxjAAw==;5:ZbTg/bURq8/Iu3lrAChlqg0cU7t83LxQ5MYB4TntkUTw3fM/zFx0qpdip59ma8M8fNABU+crdx6+y2xgVP/qL07zADecdFFoKel8BJVnqSX5N0bi5ZQ7WxLC082bg0Jfoka/klupMvg+UMTeq314M6NcjYb4FDSMULH98zirihY=;7:afcXkiFaavjSKIDCoH3beigIv8riNkqXnlbSEaH4VbNpqt87P5JweRX0ll/k0k8fvVZlqFDgmdEJQcPOa7Lyf1yW5ie0R+gpVUAqrR09CXx/oTaOIeuKfgror76y7vFwONjx2TTsumurzPmc7Ed2ezRQZ4OiwPpovsSGwBwV5FqU4XhHp3FVM39Cz+S06kt9wTHMlgr0k6MOHdIkNJ23vGZtcYiNmPPmqR4mkifmDrBDH63d6cerNv+QbUsxR9XC
x-ms-office365-filtering-correlation-id: 31ea88b2-da26-4b31-accc-08d62d138fae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4027;
x-ms-traffictypediagnostic: DB7PR04MB4027:
x-microsoft-antispam-prvs: <DB7PR04MB402703F53E302904A8453F259EE60@DB7PR04MB4027.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:DB7PR04MB4027;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4027;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(39850400004)(376002)(189003)(199004)(486006)(36756003)(99286004)(106356001)(6246003)(52116002)(31686004)(105586002)(76176011)(6116002)(3846002)(5250100002)(31696002)(72206003)(14444005)(85182001)(256004)(66066001)(478600001)(86362001)(2900100001)(14454004)(217873002)(53546011)(476003)(386003)(6506007)(26005)(316002)(54906003)(2616005)(11346002)(446003)(102836004)(2906002)(305945005)(110136005)(25786009)(6436002)(97736004)(8936002)(7736002)(81156014)(81166006)(8676002)(68736007)(186003)(6486002)(71200400001)(71190400001)(4326008)(53936002)(6512007)(229853002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4027;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xkFzpfPLiCN+ZiMs0JGPmJWi4EJfl6pypPOirL8R/EKUJ3z27TjQBnflond1EPuCTCIciihTmkwVwuvP2QQMeyLt+H5JrH3J/TDVvRwc+7MI4ESDxEr89jQxJ3Z+W6xxtLql8gm9xNhm5cg30ZJU7mxj+gUhx47MJqF3udFz42FKWmNJoGD+9B2egOogWgM+mOTtRpMkha0/NxV5pm0krbgURLqZE4BLdxB2G8LTnPmtk/fisOtPtIV6SJPHgvapsE6mmQaII6Uhftq0PL9lfHk9x8+rPGbmpU5xzKMZe/D+6ezWnlUDx9x28NXm930o91972MflHUFSMIe0KFoi2oHqlhbFWIIvrm6kk9bH9Xw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B98601C3A58BD4C8A3FB63AC42DA47A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ea88b2-da26-4b31-accc-08d62d138fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 11:45:36.1471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcuOS4yMDE4IDExOjI0LCBNaWNoYWwgVm9rw6HEjSB3cm90ZToNCj4gVGhlIHJlc2V0IHNp
Z25hbCBvZiB0aGUgU1NEMTMwNiBPTEVEIGRpc3BsYXkgaXMgYWN0dWFsbHkgYWN0aXZlLWxvdy4N
Cj4gQWRhcHQgdGhlIERUIHRvIHJlZmxlY3QgdGhlIHJlYWwgd29ybGQuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBNaWNoYWwgVm9rw6HEjSA8bWljaGFsLnZva2FjQHlzb2Z0LmNvbT4NCj4gLS0tDQo+
IHYyIGNoYW5nZXM6IE5ldyBwYXRjaCBpbiB0aGUgc2VyaWVzDQoNCkJhcnRsb21pZWoganVzdCBx
dWV1ZWQgdGhlIGZpcnN0IHR3byBwYXRjaGVzIGZvciB2NC4yMC4NCldpbGwgc29tZWJvZHkgdGFr
ZSB0aGlzIG9uZT8gT3RoZXJ3aXNlIHRoaXMgU29NIHdpbGwgZW5kIHVwIHdpdGgNCmJyb2tlbiBP
TEVEIGRpc3BsYXkgcmVzZXQuDQoNClRoYW5rcywgTWljaGFsLg0KDQo+IA0KPiAgIGFyY2gvYXJt
L2Jvb3QvZHRzL2lteDI4LWNmYTEwMDM2LmR0cyB8IDMgKystDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDI4LWNmYTEwMDM2LmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDI4
LWNmYTEwMDM2LmR0cw0KPiBpbmRleCBlNTRmNWFiLi5iZTM0MDZlIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL2FybS9ib290L2R0cy9pbXgyOC1jZmExMDAzNi5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9v
dC9kdHMvaW14MjgtY2ZhMTAwMzYuZHRzDQo+IEBAIC0xMSw2ICsxMSw3IEBADQo+ICAgDQo+ICAg
L2R0cy12MS87DQo+ICAgI2luY2x1ZGUgImlteDI4LmR0c2kiDQo+ICsjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvZ3Bpby9ncGlvLmg+DQo+ICAgDQo+ICAgLyB7DQo+ICAgCW1vZGVsID0gIkNyeXN0YWxm
b250eiBDRkEtMTAwMzYgQm9hcmQiOw0KPiBAQCAtOTUsNyArOTYsNyBAQA0KPiAgIAkJCQkJcGlu
Y3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gICAJCQkJCXBpbmN0cmwtMCA9IDwmc3NkMTMwNl9j
ZmExMDAzNj47DQo+ICAgCQkJCQlyZWcgPSA8MHgzYz47DQo+IC0JCQkJCXJlc2V0LWdwaW9zID0g
PCZncGlvMiA3IDA+Ow0KPiArCQkJCQlyZXNldC1ncGlvcyA9IDwmZ3BpbzIgNyBHUElPX0FDVElW
RV9MT1c+Ow0KPiAgIAkJCQkJc29sb21vbixoZWlnaHQgPSA8MzI+Ow0KPiAgIAkJCQkJc29sb21v
bix3aWR0aCA9IDwxMjg+Ow0KPiAgIAkJCQkJc29sb21vbixwYWdlLW9mZnNldCA9IDwwPjsNCj4g
DQo=
