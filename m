Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A167C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C22820663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=AQUANTIA1COM.onmicrosoft.com header.i=@AQUANTIA1COM.onmicrosoft.com header.b="iyX/+sVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfAXO6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:58:50 -0500
Received: from mail-eopbgr740079.outbound.protection.outlook.com ([40.107.74.79]:63790
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728343AbfAXO6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=AQUANTIA1COM.onmicrosoft.com; s=selector1-aquantia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41ezd6Lthz2qpZ+7aDMvlWtghyjXSWw/SVjq6+m+KOY=;
 b=iyX/+sVGjYRjrc5TZP2gP1inov5AcRzG90udcKyfSiXnRCoA9zUcmWzIVQIkWPTQIa8n+vxpRVRfwj1dgvTBfrb17nqct4qoUsPq4ZZBHDydP/uFvZpNrK35U+7LB081inE7XbfDJ2uScJrT8Lr3epA1boTfOk4jpFInmUOXlDE=
Received: from CY1PR11MB0585.namprd11.prod.outlook.com (10.163.145.148) by
 CY1PR11MB1013.namprd11.prod.outlook.com (10.164.69.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Thu, 24 Jan 2019 14:58:45 +0000
Received: from CY1PR11MB0585.namprd11.prod.outlook.com
 ([fe80::8147:ca47:f50e:53a2]) by CY1PR11MB0585.namprd11.prod.outlook.com
 ([fe80::8147:ca47:f50e:53a2%6]) with mapi id 15.20.1537.031; Thu, 24 Jan 2019
 14:58:45 +0000
From:   Igor Russkikh <Igor.Russkikh@aquantia.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "sd@queasysnail.net" <sd@queasysnail.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "quentin.schulz@bootlin.com" <quentin.schulz@bootlin.com>,
        "allan.nielsen@microchip.com" <allan.nielsen@microchip.com>
Subject: Re: [PATCH net-next 06/10] net: introduce a net_device_ops macsec
 helper
Thread-Topic: [PATCH net-next 06/10] net: introduce a net_device_ops macsec
 helper
Thread-Index: AQHUs/VHTDDHcLikN0iSEG9G8OLaxA==
Date:   Thu, 24 Jan 2019 14:58:45 +0000
Message-ID: <f9b58195-9345-ab13-87b2-2c261aa89b58@aquantia.com>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
 <20190123155638.13852-7-antoine.tenart@bootlin.com>
In-Reply-To: <20190123155638.13852-7-antoine.tenart@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::36) To CY1PR11MB0585.namprd11.prod.outlook.com
 (2a01:111:e400:5324::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [95.79.108.179]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR11MB1013;6:dOopMZKzhddPb5MZjcCNYrA28Ykujnd+go03jgBDA7oEl5k76Khh0hBiddtuA2wUz6USlL9rCxrmLtn6/ncr3RVLX0gxgjf22Z4ZxhLbqEQ8uPu5jZahMhXzGmEGvJJGgbi/UkdpzXY0zUQsGGYLJhU9LASR/Pwj69UYbh/gVVLqZnt5G5r9MX42a6EKpUY9RWFtF1rCwpTO7B8M3h81gGxLOwtw6m39MH5rWiHDkJX++q8Zti0N6wZRFfI4UYYXH67n6FJ+kI5oxD7+5Z9ESBxptxGidLYlVb5TYq0SEXouqCS2BMsYP7TV9WIwawyGrJ+S5d1YKWJ3Z60gqAI/lVWbPwL69TJDgXKH0SfELqgSG7CXUvJpJlPC1n6qL/OzSMccV5Sut1zV44BBLGVvIkcwDv5ofxa4ZD5coydtWebtjNEH7CMNgjG6lEUP3kj7BwJe78UkCrSFy/C+9/Xyjw==;5:JU0FKzOpWSrR/zGQaG0RMHpaYi4MgkdcZZK/bIex0i9XQBssRmowkctqZHgJ9u2Y+MP8TZjifGpAzEiuEP+b6xIiOyqKucga/ZHVieUrOKIqb5AKLl6isRuwIwYZAE0BGgNBKrR3XvD0Tdo/VMqaJ3h9Q2r4f2jWv+p/VC08fj2eHyff07+Q0d7mbZNL+aSJJl5NZNgeI7jlpzgLnYV+sQ==;7:H8a4BUF/hp6/ams0V9d35i6ZDeiY2u0UO1e96JWkvdWlcP+Sxo/d6RodtKOSpgI5268WJTTG1tfk4ikDoqftmiBrdhoONf0Z0T14U3s7lo9qzcVNDPE4bMKS2QpGOeLXbFoAWniSltEvi1LzV/UiwQ==
x-ms-office365-filtering-correlation-id: 75ac8897-9a4b-4b96-1edb-08d6820c7000
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:CY1PR11MB1013;
x-ms-traffictypediagnostic: CY1PR11MB1013:
x-microsoft-antispam-prvs: <CY1PR11MB10130F95F22F9B5BB765BC5C989A0@CY1PR11MB1013.namprd11.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39850400004)(396003)(136003)(189003)(199004)(7736002)(52116002)(305945005)(53936002)(71190400001)(71200400001)(102836004)(76176011)(229853002)(36756003)(39060400002)(446003)(6246003)(4744005)(99286004)(31686004)(6486002)(106356001)(105586002)(6346003)(6116002)(186003)(3846002)(68736007)(26005)(6436002)(2501003)(66066001)(44832011)(6512007)(31696002)(86362001)(25786009)(386003)(6506007)(72206003)(256004)(2201001)(14454004)(8676002)(2906002)(476003)(7416002)(2616005)(4326008)(478600001)(54906003)(110136005)(11346002)(81166006)(81156014)(8936002)(486006)(316002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR11MB1013;H:CY1PR11MB0585.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: aquantia.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Igor.Russkikh@aquantia.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O5lVW5WqpYRRR4LZI1IKjoD1Om3K0EulXRx79W1k4N8h9t07xs62qTu7oasSWKagfUwnDVay9WlX9ifpiTkvpNziPHOypPlT/Rt9Bc1imVkXI18j3tid0ZhEstgC3cq/RQLDIu6VMTlkEu74RQpy56gB7iY7tYS9YmTNtiAUdOIlMQvd2tizJeq5gYIasI9D9GWzaHGjrwK3HkS1JvnsXaKncnzBRQ9yRM7lU02NQs43LQB/+tRd1GpYSCU+7a5VKy0fvVQLW0eoTm/IYLFeRHZiZCQuKRAO/lUBXKK5umWNvhy3GYq5DU2zMg8nXfZF7u9VdZK/tc44y1wbtn6+luohHPuA6J34Xv7aR0JUt3YsPyyQuGK/l/l+6TFO7kub4qFrXRpCc0AxJ8INEdWDSKFrC3SeYMbr/lAAf5+qbx4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9149453953C024CAA32F549D1DE07A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aquantia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ac8897-9a4b-4b96-1edb-08d6820c7000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 14:58:41.5447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 83e2e134-991c-4ede-8ced-34d47e38e6b1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR11MB1013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBBbnRvaW5lLA0KDQpJdHMgZ3JlYXQgdG8gc2VlIG1hY3NlYyBodyBvZmZsb2FkIGluZnJh
c3RydWN0dXJlIGhhcHBlbmluZyENCg0KPiBAQCAtMTQ0MSw2ICsxNDQ1LDEwIEBAIHN0cnVjdCBu
ZXRfZGV2aWNlX29wcyB7DQo+ICAJCQkJCQl1MzIgZmxhZ3MpOw0KPiAgCWludAkJCSgqbmRvX3hz
a19hc3luY194bWl0KShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPiAgCQkJCQkJICAgICAgdTMy
IHF1ZXVlX2lkKTsNCj4gKyNpZmRlZiBDT05GSUdfTUFDU0VDDQo+ICsJaW50CQkJKCpuZG9fbWFj
c2VjKShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPiArCQkJCQkgICAgICBzdHJ1Y3QgbmV0ZGV2
X21hY3NlYyAqbWFjc2VjKTsNCj4gKyNlbmRpZg0KPiAgfTsNCg0KTW9zdCBvZiBuZG8ncyBhcmUg
bmFtZWQgYnkgYWN0aW9uIHZlcmJzLiBUaGlzIG5kbyBpcyBhYml0IG1pc2xlYWRpbmcsIHJlYWRl
cg0KbWF5IGhhdmUgZGlmZmljdWx0aWVzIHVuZGVyc3RhbmRpbmcgd2hhdA0KDQorCWlmIChwaHlk
ZXYtPmRydi0+bWFjc2VjKQ0KKwkJcmV0ID0gcGh5ZGV2LT5kcnYtPm1hY3NlYyhwaHlkZXYsIG1h
Y3NlYyk7DQoNCmlzIGFjdHVhbGx5IGRvaW5nLg0KDQpNYXkgYmUgaXQnZCBiZSBiZXR0ZXIgcmVu
YW1pbmcgdG8gYXQgbGVhc3QgbmRvX2RvX21hY3NlYygpLCBvciBuZG9fc2V0dXBfbWFjc2VjKCkN
Cj8NCg0KU2ltaWxhciBjb21tZW50IGlzIGZvcg0KDQorc3RydWN0IG5ldGRldl9tYWNzZWMgew0K
DQpJdCByZWFkcyBsaWtlIGEgbWFjc2VjIGRldmljZSBjb250ZXh0LCBidXQgaXQgaXMgYSBtYWNz
ZWMgY29uZmlndXJhdGlvbiBjb21tYW5kLg0KDQpSZWdhcmRzLA0KICBJZ29yDQo=
