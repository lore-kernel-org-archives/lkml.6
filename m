Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C40C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8E520863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mK7YfvIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfBKIue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:50:34 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:4373 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfBKIue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:50:34 -0500
X-IronPort-AV: E=Sophos;i="5.58,358,1544511600"; 
   d="scan'208";a="23662875"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Feb 2019 01:50:33 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 11 Feb 2019 01:50:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBwRBuQUUOm8ZcfVXDtKXs42jcsewZ1trHNcitlHg/g=;
 b=mK7YfvIr+Px9YCNUZLdhBO9x7NTLSp67RtexQGIYLKWCuRwmDn3y4dtkLLFJ2zWmuHyhnipexBAv9tQ08G4/kFHgPurYe6SHQbNZ9lrqw2vzqZW6BGkpLoWL/WEc4XqNDYNIxAuQHot4K6TX7/Omw2UIvNyF8+KEIN0EhUepDmw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB2036.namprd11.prod.outlook.com (10.173.33.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Mon, 11 Feb 2019 08:50:30 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 08:50:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <beanhuo@micron.com>, <linux-mtd@lists.infradead.org>,
        <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Topic: [RESEND PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Index: AdS/3OnQZjj8XegeT+KSU6BShrHJ9QCCejAA
Date:   Mon, 11 Feb 2019 08:50:30 +0000
Message-ID: <3ac5ab46-bacc-12ec-82e6-728663057f79@microchip.com>
References: <BYAPR08MB4533F6B01EF90FC66BFB5C87DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
In-Reply-To: <BYAPR08MB4533F6B01EF90FC66BFB5C87DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0002.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::12) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB2036;6:AOgg1XTs0q8Po6ZFy90QSxeGvbHk2faTw7UXrRMWjfsTPcQW9SV7nfwv4KNQcsC4IIFNmZwy2PM2Kcq+dpU76GDw5Lzh/pKBcxJ+mX6FkMF7Nh9TYVNFW8GMZgrp/lq1HUXsY+39KVAZuGsiM0yV3XYyAAC6V4nsdBrIWy5ZV8O7bKO6HaQUvourejXyAFzPcVwn21bK/QUmzoXw7uZt+qhT7yF9ws+dspxSx3NgEmmL+f2LKjuoI3asCPeXmKRmcqAzrm8l4b42CpfIYD5Em2CzpGo7HLa0U2h56oGwgQctbLmI2PVolMKxD1mNB/zzBXsAZ5FwcclT9ZLkFHd0hHNPMbkKOiV0TcWCklBQm4Q6ZoIbU6Ix8ag4BvUJm/i67flZmObB5tpHvHMXk4DHEvIs6GfTlVEu6da+P+APY1QFmJYf96ZNjlcMk7dUO0ec2moYblCeJ5ywohSWzu0jLw==;5:dLjsdXIt3MDF8J5csBGF8e5E/EureUdisnPO4NXfl4Do1W6qTQy0fMIw/XQWVpiUkx+JwGwIFHvsXTsmSCX8cs6uoRRBaOdodp01QZhPkJMDoQ5ADgklsgn0KkCyXc5pGBnpdJblLZCaHBEB/zO1FFtKPm4d9dsv7DbRB7cKdTbXLT6l5CFwM+n4j8wOQnCQGbCLqQhGrG69Mf70AyO+sQ==;7:kr3+u99NaQO5S6ly/K6eM2WlMLnwDr8DxoiZC970N8FcKXg7037hYuoUwiHs4RlZaRMn7xnVNoNiNlk0VUOTWsm/B79OqNCxIaN7x0RITZ54vIiuY0jj9eqQnYDiiHeVc/GJKWzLQSHUutf4jnjrvA==
x-ms-office365-filtering-correlation-id: 8437c669-6aa7-43fb-7017-08d68ffdf9a5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB2036;
x-ms-traffictypediagnostic: BN6PR11MB2036:
x-microsoft-antispam-prvs: <BN6PR11MB203651B1A81A311C443288C5F0640@BN6PR11MB2036.namprd11.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(72206003)(76176011)(31686004)(7736002)(305945005)(106356001)(105586002)(8936002)(86362001)(2201001)(110136005)(2906002)(6116002)(3846002)(31696002)(53936002)(4744005)(36756003)(71190400001)(71200400001)(66066001)(316002)(229853002)(14454004)(97736004)(99286004)(6436002)(217873002)(186003)(68736007)(6246003)(6346003)(14444005)(52116002)(478600001)(486006)(25786009)(6512007)(2501003)(53546011)(81156014)(81166006)(8676002)(26005)(446003)(386003)(6506007)(102836004)(256004)(6486002)(476003)(2616005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB2036;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RMid/MmhCbWvxzgCJyhJV20LUu995KOT/wMZykWDldh5rsyCg00YW/bSFcSKEaQRS32UiJ1bLukiPIM4QQ75CJGjrgBIt7KTu60Fd4sWT/+OawAU1ddqhftUERart08iSIzrGa8CQKO7rw3VM+7juYIPDhh3Gs98s1dDH8ikUBJmYfASX0smyzLbXMShxmjsnsS7EP1G7mqV1U59QJLfRG3LfZHtjLT4jDhrchQPBKAuyHTEenCw8RFZT1sjZGo2+KCzL57FBRbldk6Etp2aG6jF2oJuPrcAbM1bPNu90cZDMSd7KN6dJ3EhMeeLLzNjM3oM22g5rnCtxa0dlK6n+OUaWkn5lmSuR5UDuOR/CDSEVnyx31HTcSRFbQzVUvKTUrKEzfQoC9EZv0O3jSpIv/16vZ5uApwP8yifRD3S1q0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD4492E5C185984D8C091E30EDD54752@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8437c669-6aa7-43fb-7017-08d68ffdf9a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 08:50:28.8413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2036
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzA4LzIwMTkgMDg6MzQgUE0sIEJlYW4gSHVvIChiZWFuaHVvKSB3cm90ZToNCj4g
RnJvbTogQmVhbiBIdW8gPGJlYW5odW9AbWljcm9uLmNvbT4NCj4gDQo+IENoYW5nZSBTTk9SX0hX
Q1BBU19SRUFEX09DVEFMIHRvIFNOT1JfSFdDQVBTX1JFQURfT0NUQUwuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBCZWFuIEh1byA8YmVhbmh1b0BtaWNyb24uY29tPg0KDQpSZXZpZXdlZC1ieTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgaW5j
bHVkZS9saW51eC9tdGQvc3BpLW5vci5oIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9tdGQvc3BpLW5vci5oIGIvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oIGluZGV4IDIzNTNh
ZjguLmIzZDM2MGIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaA0K
PiArKysgYi9pbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmgNCj4gQEAgLTQ4Nyw3ICs0ODcsNyBA
QCBzdHJ1Y3Qgc3BpX25vcl9od2NhcHMgew0KPiAgI2RlZmluZSBTTk9SX0hXQ0FQU19SRUFEXzRf
NF80CQlCSVQoOSkNCj4gICNkZWZpbmUgU05PUl9IV0NBUFNfUkVBRF8xXzRfNF9EVFIJQklUKDEw
KQ0KPiAgDQo+IC0jZGVmaW5lIFNOT1JfSFdDUEFTX1JFQURfT0NUQUwJCUdFTk1BU0soMTQsIDEx
KQ0KPiArI2RlZmluZSBTTk9SX0hXQ0FQU19SRUFEX09DVEFMCQlHRU5NQVNLKDE0LCAxMSkNCj4g
ICNkZWZpbmUgU05PUl9IV0NBUFNfUkVBRF8xXzFfOAkJQklUKDExKQ0KPiAgI2RlZmluZSBTTk9S
X0hXQ0FQU19SRUFEXzFfOF84CQlCSVQoMTIpDQo+ICAjZGVmaW5lIFNOT1JfSFdDQVBTX1JFQURf
OF84XzgJCUJJVCgxMykNCj4gLS0NCj4gMi43LjQNCj4gDQo=
