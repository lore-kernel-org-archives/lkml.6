Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBAEECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20C720BEC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="IuFyzclS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20C720BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbeGQNOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:14:40 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:21041 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731213AbeGQNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:14:39 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 17 Jul 2018 21:42:08 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id A9A9481765;
        Tue, 17 Jul 2018 21:42:07 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,365,1526310000"; 
   d="scan'208";a="285603599"
Received: from mail-os2jpn01lp0144.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.144])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2018 21:42:07 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsIJyjChOYKtaNA3VnSbzh6G8g58BXBPxN57ZJlVZj0=;
 b=IuFyzclS5ynJsmZjQjCXxohH6UvUnpr9iPCWpaK0D1QKuEeUKjpsGaKv6dXIT2xTSs4VCGCiKFe3L8G9uqFhGM2NMkNAbwSJP7jK2y8yt1yfYervglF4MaLHT+yHdL23FGvhzM8B/859gc8WE+ErA8MjZQLaDUCckrj3vUDB2rU=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1200.jpnprd01.prod.outlook.com (10.174.226.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Tue, 17 Jul 2018 12:42:02 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::69c3:9892:2e04:3333]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::69c3:9892:2e04:3333%2]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 12:42:02 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Simon Horman <horms@verge.net.au>
CC:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH 2/2] i2c: designware: Add support for a bus clock
Thread-Topic: [PATCH 2/2] i2c: designware: Add support for a bus clock
Thread-Index: AQHUHONXv++x9VJe70Gk9EuuSmoVI6STU7qAgAAEdoCAAAK7oA==
Date:   Tue, 17 Jul 2018 12:42:02 +0000
Message-ID: <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
         <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
         <20180717120737.bipotpki3yhn6klf@verge.net.au>
 <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
In-Reply-To: <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1200;7:pVVA5l8KJu5/wKP+mg6Jsy6i5vonaf9r4qoPCNS4CbKaxAESCr6RHxr36Ia2IwR8YXoSqx4bkgkAliA6YNX5tp1Fn2Vq8T0ZUyyv2Ykct/Djv2yFTxzVU9KQUyCeSJtDlBIOvSYx2D8N/dj8dDOelcNPa2bZUdJXDGEUblTGFsfRtOTMtid3l3jxp0WwegiEBAsaAO/hFZVE38GID7ENRg4DXBAmAVygXw/yFWPi/ldjgPyAbwO1JDt0OrU82815;20:lsu/5MtbKAfcwno8iUhBfmywH/Xnuzo5NmrgeOMb1mVEs2Po4YENiOwkjMNEgOmdJAiQkTMb9Vmw7J0QYoIO8nhBBltznKVHbhJsLejNdWToPR06DsJbbrNG0XOkGgnohuSYdFz1i+bSKDRgxAC9+EQu4ipeX8oJwSRP48Nn7A8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 890b9553-cc63-432e-bd3b-08d5ebe2b1fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1200;
x-ms-traffictypediagnostic: TY1PR01MB1200:
x-microsoft-antispam-prvs: <TY1PR01MB120059E536985176214D4369F55C0@TY1PR01MB1200.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1200;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1200;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(136003)(366004)(396003)(189003)(199004)(486006)(476003)(9686003)(11346002)(7736002)(74316002)(305945005)(446003)(6246003)(44832011)(5250100002)(8676002)(8936002)(186003)(256004)(4326008)(25786009)(105586002)(76176011)(106356001)(7696005)(53546011)(6506007)(53936002)(81156014)(14444005)(2906002)(2900100001)(81166006)(26005)(102836004)(229853002)(6116002)(110136005)(55016002)(33656002)(3846002)(14454004)(5660300001)(316002)(93886005)(54906003)(478600001)(68736007)(86362001)(6436002)(97736004)(66066001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1200;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uUQogPFN5z86KDOaa8AjO2q9GGyOcsk6i910pcKt3798fP+uG4UpzBV94zYo/5tHf/mX6Bm3SDCgSvazVo3bRJprMqtBUVWb0zProFHruD89MuC24CPDQOC2sMov13SQwSm9m6ZmS9ohEGXKqkQqFV/AKeMlAlTH96jYgfHtQ5ajTY/8mm0KkfFCC29RxB6I6hmrzNw3KAg1CLOlIDLU4a58o+Pxmxuy9vmkMtMuA8JeZuoxRApOs7yYkU614vGPra0PdNd8qfKj8DL6MCRhYY016wo5yj8GDwyy/5vaAeEm5EIOesKGgD/Oj+KmWGbm6FwaopL76VwsIMcsn8BcQHWqTPw8xB0AP4GfZoqAjms=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890b9553-cc63-432e-bd3b-08d5ebe2b1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 12:42:02.2628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2ltb24sIEFuZHksDQoNCk9uIDE3IEp1bHkgMjAxOCAxMzoyNCwgQW5keSBTaGV2Y2hlbmtv
IHdyb3RlOg0KPiBPbiBUdWUsIDIwMTgtMDctMTcgYXQgMTQ6MDcgKzAyMDAsIFNpbW9uIEhvcm1h
biB3cm90ZToNCj4gPiBPbiBNb24sIEp1bCAxNiwgMjAxOCBhdCAwOTo1OToxM0FNICswMTAwLCBQ
aGlsIEVkd29ydGh5IHdyb3RlOg0KPiA+ID4gVGhlIFN5bm9wc3lzIEkyQyBDb250cm9sbGVyIGhh
cyBhIGJ1cyBjbG9jaywgYnV0IHR5cGljYWxseSBTb0NzIGhpZGUNCj4gPiA+IHRoaXMgYXdheS4N
Cj4gPiA+IEhvd2V2ZXIsIG9uIHNvbWUgU29DcyB5b3UgbmVlZCB0byBleHBsaWNpdHkgZW5hYmxl
IHRoZSBidXMgY2xvY2sgaW4NCj4gPiA+IG9yZGVyIHRvIGFjY2VzcyB0aGUgcmVnaXN0ZXJzLg0K
PiA+ID4gVGhlcmVmb3JlLCBlbmFibGUgYW4gb3B0aW9uYWwgYnVzIGNsb2NrIHNwZWNpZmllZCBi
eSBEVC4NCj4gDQo+ID4gPiArCQkvKiBPcHRpb25hbCBidXMgY2xvY2sgKi8NCj4gPiA+ICsJCWlm
ICghSVNfRVJSKGRldi0+YnVzY2xrKSkgew0KPiA+DQo+ID4gSSBzdXNwZWN0IHRoYXQgZXJyb3Ig
dmFsdWVzIHN0b3JlZCBpbiBkZXYtPmJ1c2NsaywgIG90aGVyIHRoYW4NCj4gPiAtRU5PRU5ULCBz
aG91bGQgYmUgdHJlYXRlZCBhcyBlcnJvcnMuDQpJU19FUlIgY2F0Y2hlcyBhbGwgZXJyb3JzIGFu
ZCBpcyB0aGUgY29ycmVjdCB3YXkgdG8gY2hlY2sgdGhlIHZhbHVlDQpyZXR1cm5lZCBieSBkZXZt
X2Nsa19nZXQuDQoNCj4gV2hpbGUgeW91ciBwb2ludCBzb3VuZHMgdmFsaWQgKGRvbid0IHJlbWVt
YmVyIGhvdyBjbGtfZ2V0KCkgaXMNCj4gaW1wbGVtZW50ZWQpLCBOVUxMIGlzIGFsc28gT0sgdG8g
aGF2ZS4NCk9rIGFzIGluIHRoZXJlIGlzIG5vIGJ1cyBjbG9jaywgcmlnaHQ/DQpTbyBpdCBzaG91
bGQgYmU6DQogaWYgKCFJU19FUlJfT1JfTlVMTCAoZGV2LT5idXNjbGspKSB7DQoNClRoYW5rcw0K
UGhpbA0K
