Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4716C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8FB20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="j1ofZiyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8FB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeLGJ2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:28:30 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:44392 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeLGJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:28:29 -0500
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="24107395"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 07 Dec 2018 02:28:29 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 7 Dec 2018 02:28:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8cPdMVXKzFXy20wJlhBcOnYHAvPQyJJCe18wPBDVsw=;
 b=j1ofZiyEXL9uYRs9u74g6LuGRx+0wMkyPcK+bDKJdAk3ksXTKMspK4poRAulgxtIQCJ4LWdjn63+rlis4OcpdoTdPzjxOXH1xpv2ZomADSZss4zQE1q6OlWGyexNAQ1RpG2hL/VTf7OZ/tVZFq3N7W76rlZozYw8Se+QRmghSeg=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1907.namprd11.prod.outlook.com (10.175.100.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Fri, 7 Dec 2018 09:28:27 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 09:28:27 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <liu.xiang6@zte.com.cn>, <linux-mtd@lists.infradead.org>
CC:     <marek.vasut@gmail.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <boris.brezillon@bootlin.com>,
        <liuxiang_1999@126.com>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: spi-nor: Add 4B_OPCODES flag to is25lp256
Thread-Topic: [PATCH] mtd: spi-nor: Add 4B_OPCODES flag to is25lp256
Thread-Index: AQHUfBmm9tl+IxU4GUeEseVHTzhVz6VzJi2A
Date:   Fri, 7 Dec 2018 09:28:27 +0000
Message-ID: <30b2e604-af78-1e72-6325-9f188b960a5d@microchip.com>
References: <1542200118-3024-1-git-send-email-liu.xiang6@zte.com.cn>
In-Reply-To: <1542200118-3024-1-git-send-email-liu.xiang6@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0063.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::25) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1907;6:rvEx0rRHAcUsQai5WPttrlUqMYGPmJnDoF3LHa/nAfla5WCjKxn1DJ3scoYI2PO9PJYsJPgwnReV0rz7h5MUQvKqI55xUrP7DI3iKwHOzno1jaEPr5znkj0/Js949+5lLhwGtBrHQFw5yMv0cbgE4VJGGBnh4aXr52GPfXe9TJw61nJYuJTRWGlI51yjRx+3jnYzl9rPiwIx3TTMxfJ/kBZDJYqiMoXbjKQmIexA7O3aLo/VrvLYBHeniCNbbnj3LyZmF+hA+plVxcTqhh3rZHt1zbLqazax7HBLJT0YuWgyoEvNJ6j9z63ZnNI6kRmoJTVaR7x3GCPoC2AIz5qRjkxZpUUbWidnI5+eouQ6wBNq45iA3VM2aDKLevO973b9fhkhQLTyhoz6fHb39lriQTHcQ1BxWTmNjuWCIyEgEbst0q7rswtTj4rklgXAxFLbnP8j1mjCNy7lZAhNSIpMVA==;5:z9X9DLJ5m7IndFP/ndWLrdxZrf37LNbcAb7yaKnxBjVokbYJE5fwMkNzWzBue137uznWfAD4JGltk5mAuuLBLIDKRmShu4T0qIW59Q+83Zv7b2n91oGkMgIuABAPWlkn5sZFIaGbrOSncOLfta+Pgu3Xk2FUe9YF+YSgl3kvfVI=;7:IaAsMNMffoFP5CsaqRLDcAasWy4jqmF4cR9wvn4Z5VwVWAor5hxgnagWeVTLrRC7+kSS6SteddBbgkwQmcqQU+R/Fni9BKHiwc+phmjz/fzhqtMYRPVrBU6T+Vf2+4NDjbcZ3wW9CQUTc2dkjCVDnw==
x-ms-office365-filtering-correlation-id: 44e9a109-0f10-474f-fb93-08d65c2657a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1907;
x-ms-traffictypediagnostic: BN6PR11MB1907:
x-microsoft-antispam-prvs: <BN6PR11MB190726A06835F6376D6FD6E6F0AA0@BN6PR11MB1907.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1907;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1907;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(6436002)(54906003)(5660300001)(229853002)(6246003)(316002)(97736004)(72206003)(26005)(39060400002)(486006)(446003)(99286004)(4326008)(71200400001)(71190400001)(53936002)(6486002)(68736007)(2616005)(6512007)(14454004)(476003)(110136005)(8936002)(7736002)(25786009)(31696002)(31686004)(81166006)(81156014)(8676002)(52116002)(305945005)(14444005)(256004)(86362001)(105586002)(3846002)(6116002)(36756003)(106356001)(386003)(478600001)(102836004)(76176011)(11346002)(66066001)(6506007)(186003)(53546011)(2501003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1907;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WT9hRWsOdg6QvDWo15NMORYhItf+D3PeJokhezo2Kl4WZZjBJZRxn5lD8jTwZNvzZGlMLKG1rcLXI2IjD/8mh6/oduFwdo8IN2TLiUfBFS/z4nvSzht/Ineq7GxL9Dp3WlB/4vjnjVmqRYrA9CR5ZtMtnBt/rgAg1wieFPTmFeeOtwmF8eSKVJJOS6tICKD+Emj04ihKkD4XtHTswiROwi5N8CbaRSi92dRtKKISXa7rZSBN2nm1bHgyN2GPxSc5X+7awGGp9M0vgd5lokZmCwK1qdZjXMAC0veo9V37bInr1WJI7wYT01vnWnPSyoxKZsrondcltcROdw+rA5ztJ6lh0fG4Bq0rHycA5PyiFaY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <964AE1560568C347A3B60F3B5D1E4FE5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e9a109-0f10-474f-fb93-08d65c2657a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 09:28:27.1628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1907
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzE0LzIwMTggMDI6NTUgUE0sIExpdSBYaWFuZyB3cm90ZToNCj4gVGhlIGlzMjVs
cDI1NiBzdXBwb3J0cyA0LWJ5dGUgb3Bjb2RlcyBhbmQgcXVhZCBvdXRwdXQuDQo+IA0KPiBTdWdn
ZXN0ZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGJvb3RsaW4uY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBMaXUgWGlhbmcgPGxpdS54aWFuZzZAenRlLmNvbS5jbj4NCg0KUmV2
aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCg0K
PiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL3Nw
aS1ub3IuYw0KPiBpbmRleCAzZTU0ZTMxLi4zZWJhMTNhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1u
b3IuYw0KPiBAQCAtMTM1Nyw3ICsxMzU3LDcgQEAgc3RhdGljIGludCBzcGlfbm9yX2lzX2xvY2tl
ZChzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgbG9mZl90IG9mcywgdWludDY0X3QgbGVuKQ0KPiAgCXsg
ImlzMjVscDEyOCIsICBJTkZPKDB4OWQ2MDE4LCAwLCA2NCAqIDEwMjQsIDI1NiwNCj4gIAkJCVNF
Q1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCkgfSwNCj4gIAl7ICJpczI1bHAyNTYiLCAgSU5GTygw
eDlkNjAxOSwgMCwgNjQgKiAxMDI0LCA1MTIsDQo+IC0JCQlTRUNUXzRLIHwgU1BJX05PUl9EVUFM
X1JFQUQpIH0sDQo+ICsJCQlTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FV
QURfUkVBRCB8IFNQSV9OT1JfNEJfT1BDT0RFUykgfSwNCj4gIAl7ICJpczI1d3AwMzIiLCAgSU5G
TygweDlkNzAxNiwgMCwgNjQgKiAxMDI0LCAgNjQsDQo+ICAJCQlTRUNUXzRLIHwgU1BJX05PUl9E
VUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4gIAl7ICJpczI1d3AwNjQiLCAgSU5G
TygweDlkNzAxNywgMCwgNjQgKiAxMDI0LCAxMjgsDQo+IA0K
