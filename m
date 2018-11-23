Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C641FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736D920685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="b4sYx8OB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736D920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409825AbeKWXXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:23:52 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:33209 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409812AbeKWXXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:23:52 -0500
X-IronPort-AV: E=Sophos;i="5.56,269,1539673200"; 
   d="scan'208";a="23605138"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Nov 2018 05:39:48 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 23 Nov 2018 05:39:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDCukqyJAsimpPVUGSBdE8PBxi8FFtsjbLUbzA4Sd9w=;
 b=b4sYx8OBtXtZt0mwC2Rwd6xJsMX9rXqAMOxFqTrTtnFTFQlaw/OKGty2b1zWoVe6OGpm7r3qef2d1bNnqi31jma3dTe2jOVL5nv8KmEopkTw+IPtm0gNQIXtvUW7vDtwLBkS9od+TN9xwZnPiloJFN72dIJgf9zdBk3YO0MwyhA=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1793.namprd11.prod.outlook.com (10.175.99.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Fri, 23 Nov 2018 12:39:44 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1339.029; Fri, 23 Nov 2018
 12:39:44 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexander.sverdlin@nokia.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Topic: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Index: AQHUgmAPRuGauPbUmUaN5hsWx0CViKVdHRGAgAANy4CAABD/gIAAEpMA
Date:   Fri, 23 Nov 2018 12:39:44 +0000
Message-ID: <70ac7381-bea8-8f1a-a03b-bc03478dbd7c@microchip.com>
References: <20181122123552.15756-1-tudor.ambarus@microchip.com>
 <3d8a2b83-282d-7cb2-3c8b-addae3c2af7f@nokia.com>
 <65d03690-a475-dc5b-ab9d-14e6216ba0bd@microchip.com>
 <679e7fb8-f424-b72c-ac8a-315926080ede@nokia.com>
In-Reply-To: <679e7fb8-f424-b72c-ac8a-315926080ede@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0031.eurprd05.prod.outlook.com
 (2603:10a6:803:1::44) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.253.132]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1793;6:JZY5uP6IlOOutiNEOrzmkBY4DJ4N6Gy+PSor4O0KEfRTNuxTVz9nFINdCnwx29qWJySCrgLpJHC3GoHNk2FPD9fvoNh01TO7nWycmhsiwXrQuGzORqRF9cmt+zOAEsU1Kj+/AI0hSB02mF17Qs+5PuCmcJnxgdfcJu7ZOpVWuaUDQRZM/7TYE+nh+xnc7J7ExSkAX6k2+m+K28ajMBfmLo6HNglsj31zB3X8l5HH2ZHcsANzqSnFFEOKVMISQAO50FbKct0W4pnTPh4sDv57w71iUBd1K1Uo2ll11Yng6DoWfXgsTln+sHIRVUazVKeeSzEb28TEY67m2VxGFXnuBrc6K/Low5U1UCDLNDZg9fJ7lhSIgWwkvl2wZjdlEKvLufGcVTrtTdt03BP82/9EBjBzIPc4rd+KtpeU3FuRTaVN+hDBe6qQyiOQlN+jF/mUZPAdX4OUdwDr6fu+lvN0ew==;5:X6n0iHk1HvdoOWSFLR8FILJlo1ZYENjn+1JBkZ5NOG7EtA3ZaINmyxhLwXXbDFXTd6PT86W2e0oDYHZuihUjuWME8hvD1DuSez8h0UKqt47jomHUbhPuHNF4HW+qzOgG0pMRw+Bw3zvyaLzZNKjfAaR22VAHMHQN8no9jYrbiI8=;7:MfZDc7ciU/+m+sE1w7NMW9AQMDkNwJPnhLSWsm1LK+h3BH8Oe6JW6FAkMai7B4kt8+StN14HGre5F5Q86N8Zozzr3wlkztH9dm0zQc3rp5xvD1FKMaVUksCLm6BgHpmubNzZYkBGcty+z4Abq34mlg==
x-ms-office365-filtering-correlation-id: c48baf73-6096-4799-4d92-08d65140beba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1793;
x-ms-traffictypediagnostic: BN6PR11MB1793:
x-microsoft-antispam-prvs: <BN6PR11MB179354FFBC32A13AB60EC463F0D40@BN6PR11MB1793.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1793;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1793;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(366004)(199004)(189003)(256004)(53936002)(6246003)(72206003)(7736002)(305945005)(4326008)(5660300001)(66066001)(6512007)(39060400002)(2501003)(86362001)(14454004)(446003)(36756003)(97736004)(2616005)(3846002)(31696002)(2906002)(486006)(6116002)(478600001)(229853002)(11346002)(476003)(8936002)(54906003)(110136005)(186003)(26005)(53546011)(102836004)(2900100001)(68736007)(316002)(76176011)(52116002)(6486002)(106356001)(71200400001)(93886005)(6506007)(386003)(2201001)(31686004)(105586002)(81166006)(25786009)(99286004)(8676002)(6436002)(81156014)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1793;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OZGLWspjIyhbU7w7OipWcsRNA90DK3zy51aGj8rbiND9mA4VWdcvJgLwI1k3Ma5Ec5H+q1XcFOHXkfGHCgt2IQ5FXiBl89aa7LyjCgcShvD3AClut+v1UykusBhMYmTucDm1YSqx/+w4LgutNm90oQgWRg5LM/meHcs4kavh+PVF+ei2nSE6+kG//4aVoTklub9VswcGxPt54h4WgSMdiTLCTb7vzyDlk4WvNe5/j/Ecj4HINr5BvEzCO2/ODkE8UfDc5H/LeWCxnpvKO8YioKka4acAa5kBztomOPG4g8nIKn03mNjQyz29PPGtLmhLRcxROCUU6gLKfL4syNG7PSRRf1NnrXqXivkpLsQ46MM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACD8B41C0E4C5D4094ABF638ACA5464A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c48baf73-6096-4799-4d92-08d65140beba
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 12:39:44.6937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1793
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFsZXhhbmRlciwNCg0KT24gMTEvMjMvMjAxOCAwMTozMyBQTSwgU3ZlcmRsaW4sIEFsZXhh
bmRlciAoTm9raWEgLSBERS9VbG0pIHdyb3RlOg0KPiBTbyBlcmFzZXNpemUgaXMgYmFjayB0byB0
aGUgdmFsdWUgYmVmb3JlIG5vbi11bmlmb3JtIHN1cHBvcnQgcGF0Y2hlcywNCj4gcGFydGl0aW9u
cyBhcmUgbm90IG1hZGUgcmVhZCBvbmx5IGFueSBtb3JlLCBidXQgYWN0dWFsIHdyaXRlIG9yDQo+
IGVyYXNlIHN0aWxsIGZhaWxzLg0KDQpIb3cgZG9lcyB0aGUgZXJhc2UgZmFpbD8NCg0KV2hhdCBt
YXAgY29uZmlndXJhdGlvbiBpcyBzZWxlY3RlZD8gV2hlcmUgYXJlIHRoZSBoeWJyaWQgYmxvY2tz
LCBhdCB0aGUgYm90dG9tDQpvciBhdCB0aGUgdG9wIG9mIHRoZSBhZGRyZXNzIHNwYWNlPw0KDQpE
b2VzIHRoZSBlcmFzZSBmYWlsIGV2ZW4gd2hlbiBhZGRyZXNzIGlzIGFsaWduZWQgd2l0aCA2NGsg
YW5kIHRoZSBzaXplIG11bHRpcGxlDQpvZiA2NGs/IERvZXMgdGhlIGZvbGxvd2luZyBmYWlsPw0K
DQokIG10ZF9kZWJ1ZyBlcmFzZSAvZGV2L3lvdXJfbXRkIDAgNjU1MzYNCg0KVGhlIG5vbi11bmlm
b3JtIGVyYXNlIHdpbGwgZmFpbCBpZiBpdCBjYW4ndCBzZWxlY3QgYSBzZXF1ZW5jZSBvZiBjb21t
YW5kcyB0aGF0DQpjYW4gZXJhc2UgdGhlIGVudGlyZSByZXF1ZXN0ZWQgY2h1bmsuDQoNCkNoZWVy
cywNCnRhDQo=
