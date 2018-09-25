Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B28FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A896D20676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="AYy8gsPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A896D20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeIYXle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:41:34 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:24315 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeIYXle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:41:34 -0400
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="20487903"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 25 Sep 2018 10:33:01 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 25 Sep 2018 10:33:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfzxTSPpoGzskmu6J0cSdpN6pTalZncw2w+NGnyOxuA=;
 b=AYy8gsPxs8QNzJhsPEeTCJEVQdi/QX3ZZdNbWi7seYac6AKzqHz3s49bLAQKQ1ohJlL0bksSXQVhGxoqwOzm/aQpTaRJWe219c9VewzbNjyU3d+I3ZW9Ww1andh0/5T1bTEA+emT7PMg13A7EfbyZ8NQYxqeAnIwukBvuaqo9Is=
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com (10.174.112.135) by
 BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 25 Sep 2018 17:32:56 +0000
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::389e:3b37:851c:1235]) by BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::389e:3b37:851c:1235%11]) with mapi id 15.20.1143.019; Tue, 25 Sep
 2018 17:32:56 +0000
From:   <Woojung.Huh@microchip.com>
To:     <f.fainelli@gmail.com>, <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <UNGLinuxDriver@microchip.com>,
        <steve.glendinning@shawell.net>, <keescook@chromium.org>,
        <akurz@blala.de>, <hayeswang@realtek.com>,
        <kai.heng.feng@canonical.com>, <grundler@chromium.org>,
        <zhongjiang@huawei.com>, <bigeasy@linutronix.de>,
        <ran.wang_1@nxp.com>, <edumazet@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 3/7] lan78xx: Check for supported Wake-on-LAN modes
Thread-Topic: [PATCH net 3/7] lan78xx: Check for supported Wake-on-LAN modes
Thread-Index: AQHUVElSRngOMbMRpUm9i69iXavPIaUBPgVggAADLYCAAADmgA==
Date:   Tue, 25 Sep 2018 17:32:56 +0000
Message-ID: <BN6PR1101MB2130D18F03C79BC1E54C9FBAE7160@BN6PR1101MB2130.namprd11.prod.outlook.com>
References: <20180924205420.31309-1-f.fainelli@gmail.com>
 <20180924205420.31309-4-f.fainelli@gmail.com>
 <BN6PR1101MB2130115311A87CCF7D712B0FE7160@BN6PR1101MB2130.namprd11.prod.outlook.com>
 <f791e4b6-7493-b54b-a88f-47d0ef4a3409@gmail.com>
In-Reply-To: <f791e4b6-7493-b54b-a88f-47d0ef4a3409@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Woojung.Huh@microchip.com; 
x-originating-ip: [47.19.18.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2243;6:g6v61/tKn2FpsiRUGLphzb7LE7yXVWlajH4B4wAtPUR9ZeIZ7bEEsY8anVd+g9bVE/6X47Kgcx7+5jNx7NNLRDNhqmNgMDRYGmMI1DZxOaCP0+HVDszjzOKMbMHM1B9HW0gD/9bNzsvq3LSlv3dgphScX0kl81IRtAu61LS3Wc9HBQvvkUW0fmmIW+/9y1QdUG3s0PUwDAljoUFWSwae4cTiUB1+X9HwfqClwJYt1htioRhqtxSk9sRqarQJ+g3zGEyfXT55EUJkgmWW7j3/fgxc0q04UIko+RnkQxKHw5ptH+GWPqVDIZKPlFR2LKWUWxMsvBzRyhE7Ot+hdwKXoq3GoV7dhLkU4KBAsU2CBeL2ZSlpbzggzuRHxYDFVrUk2GejjZfX1IG2Tz1BYSImkGG3fDytIUMso4B+ZjdpjSUe95nZcHbLh4CMwQ1tl3PBxoufTRG/xlp/p6e0nlNqbQ==;5:7E+NA85ARUOS8m964MqkpJNzVzFTS5g4M1m7XnLmLsUZfxc59A+V5sHT3Xo8jraLBwUtH46orEeyPr+iMpXlxV05gIVL/syCcMW9m3W8VRJT8MqHiPeXyokLKDWc81D0WiWKahPTJ3Q/y8cPoDnFEAxSn0I8eLE2QzKhmMiZVDM=;7:EU3hgWppLW7ZXQ4wNr4+tBDWfi26ploNy0bmDxKbxdiWTUaC4Aix3lBl/PEjn0bF6MvKZIAPGrkreiA5WZG8N8W5BY8D0T/SqR3FOnhouxQmp//jkIBQB1UOHvjh/i+6OwUNXHdblr5ZkgwlwudbIH6sR2yZVKETXqjG56KhFYfyo9Zw108JOWzl8XSLYo1+16yRHqcpvmes+j6tuKlFusXZI87QnYMfwyK9ZcwrZAD3XO9iSH+F+pLQcscC8XmG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 61dcaf75-00f5-47dc-697f-08d6230cee94
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2243;
x-ms-traffictypediagnostic: BN6PR1101MB2243:
x-ld-processed: 3f4057f3-b418-4d4e-ba84-d55b4e897d88,ExtAddr
x-microsoft-antispam-prvs: <BN6PR1101MB2243C2E2693D830CCB806121E7160@BN6PR1101MB2243.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:BN6PR1101MB2243;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2243;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(76176011)(14454004)(476003)(4326008)(39060400002)(6116002)(3846002)(25786009)(2501003)(2900100001)(93886005)(486006)(478600001)(34290500001)(33656002)(6436002)(5250100002)(9686003)(72206003)(446003)(11346002)(186003)(26005)(55016002)(229853002)(6246003)(256004)(7736002)(305945005)(106356001)(74316002)(8936002)(66066001)(97736004)(8676002)(53936002)(5660300001)(2906002)(105586002)(54906003)(71190400001)(71200400001)(316002)(102836004)(81166006)(81156014)(7416002)(99286004)(86362001)(68736007)(6506007)(7696005)(110136005)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2243;H:BN6PR1101MB2130.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PKcI6+N2aZfa1lukK/+Mg965kzsZMZb/CiQE15Ihe19ruZcpAAI4HdpUI6fbz3aAzRIfH+h+a7WYkE8iQKIt+JOWNUZmPbgoe1GgKl76IecYhKy0LdekBYoVw88mntj72I3DWuWAauFmK3xYqeKv3GxrZ/bvP6XKcz/S76X4BDR+l4o2GIS0qe7OpirPLcHIHin7xcveeJuDF/nItTyHYDhnRtW3R9VGv4V5L7LJo/W2PXGhdRX1fulHmHAZHrvXJ426Z8YvCYQq17qr74zCE7KQrhji87JwsMYUpzmLvXSskLx+Zfj/wI/KddRtKAj/29b4N1s0bDj01ip4DQ7TY8TvFYR+menoFx8DY5b8Uas=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dcaf75-00f5-47dc-697f-08d6230cee94
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 17:32:56.7216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2243
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmxvcmlhbiwNCg0KPiA+PiArCWlmIChwZGF0YS0+d29sID09IDApDQo+ID4+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiA+PiArDQo+ID4gSXQgd2lsbCBtYWtlIGZ1bmN0aW9uIHJldHVybiB3aGVu
IGRpc2FibGluZyBXT0wuDQo+IA0KPiBIdWgsIHllcywgZ29vZCBwb2ludC4NCj4gDQo+ID4gSXMg
dGhlcmUgb3RoZXIgcGxhY2UgaGFuZGxpbmcgdGhpcyBzY2VuYXJpbz8NCj4gDQo+IEhvdyBkbyB5
b3UgbWVhbj8NCj4gDQpJIG1lYW50IHRoZXJlIGlzIGFub3RoZXIgcGF0aCBJIG1pZ2h0IG1pc3Mg
d2hlbiBkaXNhYmxpbmcgV09MIA0KdGhhbiB0aGlzIHh4eF9zZXRfd29sKCkuDQoNClRoYW5rcw0K
V29vanVuZw0KDQo=
