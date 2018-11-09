Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7BDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983312081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="d5H5cfjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983312081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeKJDWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:22:01 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:31276 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbeKJDWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:22:01 -0500
X-IronPort-AV: E=Sophos;i="5.54,483,1534834800"; 
   d="scan'208";a="23077348"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Nov 2018 10:40:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 9 Nov 2018 10:40:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lq8LLtxyLa8nCWFDRY6stJMonGTHgVC6Lg4djPf8yJY=;
 b=d5H5cfjCTU+sCND3iBHYFRAytDwtZGL6ED8V5fIo7t+h5O1fh/z+IuiBGvG1Eh5iNmHHeG4g6yZU4F9Osh9FCwNN05fC/CPe/iZN10MPHICG5bXEy2XUE2CbSlO3A1cKzefqAxJe4H9gNhJ2LeY/xFpmfkef/MJiHa0jsWMULIA=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1955.namprd11.prod.outlook.com (10.175.100.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 17:40:21 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 17:40:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <cyrille.pitchen@wedev4u.fr>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH] mtd: spi-nor: mark desirable switch case fall through
Thread-Topic: [PATCH] mtd: spi-nor: mark desirable switch case fall through
Thread-Index: AQHUeFNJm6LH43gO+0eRZHpCMxJGwA==
Date:   Fri, 9 Nov 2018 17:40:21 +0000
Message-ID: <20181109174017.19269-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0254.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::21) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1955;6:rG0COFoLKGjBrmFWypNmt2wVicLxA8QfsglR0yG362gLKrxhPmluv4u+HXvoKljZaBnBJlsFW40dToPZ2Sa/WYDofNAfbM8kXydI0Dup6iXEGMx365uOPS4/za9xRis/pypJdFU6hjG/0RGtD9WS+eBD2RsuQgd7lp/+cAKJQiJoZgUpaZ3Ef5Vxd9dDA4VpZcVnmBg3c3B44WtJJRg5bCo0FqtnUtJrLvwugZoQMcQF/md9YTpub/sgR/pGFQdfr00qhb8SU3lFBZgyZLqNXWWo2XF/Tz5+WSbipMeytDiZQhuMWszYp6IGNwELdFon0f+Yy8jM9gLlDBMcSzTr3KRtg6mf5SBbV2pRthQybnFtujHQG0eumYjPrmkQazUdqb2oC4KuMl38BqN9C8a5k3XHRlu4KPAedudGVwXH2yVg9d6PaWe2a2j+gfifLVUrK8w66jXt43RlPZW3B9Ez+A==;5:fiP/asU1XSd74hnu6NoGtuKOx/gMG7ngG6uonjzv2xXc4+8E4baxeTJ6GFb22gCtBDo7JuROF7S7P+73oS0SJ9/qWLxlk2MY8c2QAvixBEeLJLMHP9ZW2+oOZySLDExg5FQwawY7gMLPw6QQrA2cW1RBs1n6AaCP7fGv+9yz7uk=;7:eoGZq4ZTTMCO3FGHKdexipm0UEWI1vv4O3ve6Fx9JmDp4IZz7bDxSX0zaYI2XBABt/ryiGvUJYnb/oOuayVUjwx1JddWKjHB1M/7R1M/zMSgpBCDLFUDZ7WUXlcxb5AiYfjowwWKniDcaqPh85mkUw==
x-ms-office365-filtering-correlation-id: c6ee66f8-722b-4a6b-581d-08d6466a6b84
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1955;
x-ms-traffictypediagnostic: BN6PR11MB1955:
x-microsoft-antispam-prvs: <BN6PR11MB19554096C3CAB0AC174323BCF0C60@BN6PR11MB1955.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1955;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1955;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(52116002)(25786009)(71190400001)(86362001)(72206003)(256004)(14444005)(99286004)(8936002)(81156014)(81166006)(36756003)(8676002)(97736004)(71200400001)(68736007)(186003)(110136005)(39060400002)(478600001)(5660300001)(386003)(1857600001)(105586002)(26005)(106356001)(2900100001)(6506007)(54906003)(102836004)(316002)(6486002)(6436002)(486006)(305945005)(4326008)(2501003)(7736002)(6512007)(107886003)(6116002)(3846002)(2906002)(1076002)(14454004)(53936002)(66066001)(2201001)(476003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1955;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: avQTT8a1fnBAnKt21V0JI9eeCU+JgSVXzuCzYPPo7bISiR6LW2GEvCXi97DbS37usmQMiEVIb6mAJZTlZaKu//N1wgRxOA6cy8IUsxrf8iLg7VVOvaW3JW6V+m7TuMGk/+Mu3JfnMq5safP+ub7VFdXdcLyPgiufqMn79Icx1rlwc/ZznT3sVO4AbBKDvKIYMHiM+AoByXXNf476LHvkBnHJSp9Ro3HPXcRcAeNtHojkhEptW3O/NCa0BdGMDpSp695GoYQAP4HK+ivzgmXNDNScbMoRp8S7BPBpq2s9wO7ce3pCiN+z+CpX0sTX3mQ0XLEsVBgm3moIsvC6tYf18qhQAvTq1VtP4j1JcjyynJg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF4E685A3DA8054D8686BC8CA57D5182@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ee66f8-722b-4a6b-581d-08d6466a6b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 17:40:21.1443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1955
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Z2NjIDcgd2l0aCAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoIHJhaXNlczoNCg0KZHJpdmVycy9tdGQv
c3BpLW5vci9zcGktbm9yLmM6IEluIGZ1bmN0aW9uIOKAmHNldF80Ynl0ZeKAmToNCmRyaXZlcnMv
bXRkL3NwaS1ub3Ivc3BpLW5vci5jOjI4OToxMzogd2FybmluZzogdGhpcyBzdGF0ZW1lbnQgbWF5
IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dDQogICBuZWVkX3dyZW4gPSB0
cnVlOw0KICAgfn5+fn5+fn5+fl5+fn5+fg0KZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmM6
MjkwOjI6IG5vdGU6IGhlcmUNCiAgY2FzZSBTTk9SX01GUl9NQUNST05JWDoNCiAgXn5+fg0KDQpR
dWlldCB0aGUgd2FybmluZyBieSBtYXJraW5nIHRoZSBleHBlY3RlZCBzd2l0Y2ggZmFsbCB0aHJv
dWdoLg0KDQpTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3Jv
Y2hpcC5jb20+DQotLS0NCiBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDEgKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQv
c3BpLW5vci9zcGktbm9yLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KaW5kZXgg
OTQwN2NhNWY5NDQzLi44MDY1ZDVkNzZiZTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL210ZC9zcGkt
bm9yL3NwaS1ub3IuYw0KKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCkBAIC0y
ODcsNiArMjg3LDcgQEAgc3RhdGljIGlubGluZSBpbnQgc2V0XzRieXRlKHN0cnVjdCBzcGlfbm9y
ICpub3IsIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvICppbmZvLA0KIAljYXNlIFNOT1JfTUZSX01J
Q1JPTjoNCiAJCS8qIFNvbWUgTWljcm9uIG5lZWQgV1JFTiBjb21tYW5kOyBhbGwgd2lsbCBhY2Nl
cHQgaXQgKi8NCiAJCW5lZWRfd3JlbiA9IHRydWU7DQorCQkvKiBmYWxsIHRocm91Z2ggKi8NCiAJ
Y2FzZSBTTk9SX01GUl9NQUNST05JWDoNCiAJY2FzZSBTTk9SX01GUl9XSU5CT05EOg0KIAkJaWYg
KG5lZWRfd3JlbikNCi0tIA0KMi45LjQNCg0K
