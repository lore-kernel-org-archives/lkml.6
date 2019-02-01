Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B9FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5EE21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ZnKr5zUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfBANee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:34:34 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:46366 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfBANed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:34:33 -0500
X-IronPort-AV: E=Sophos;i="5.56,548,1539673200"; 
   d="scan'208";a="25740249"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Feb 2019 06:34:32 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 06:34:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CoLmDdoc8R1hyK51IVzdg9IlPsF4owLDan3aQ7Dsfo=;
 b=ZnKr5zUUcM4PjM75+gW77QH6ZdofZ0S2pESo6D7HgnUbbKZ3lUfW/dC8wPMcc9C4W+EuTpXqd10UeqhFUp5zQx/8SboifWIa8lmnOGjihko4FQUXkedRfr4iJ9JU/pRO0ukETz04/EdKLpI8mR4Ww20N/FdS/YOobHbNqMFW/M8=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1934.namprd11.prod.outlook.com (10.175.54.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Fri, 1 Feb 2019 13:34:30 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1558.023; Fri, 1 Feb 2019
 13:34:30 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <hch@lst.de>, <john@phrozen.org>, <vkoul@kernel.org>,
        <dmitry.tarnyagin@lockless.no>, <sudipm.mukherjee@gmail.com>,
        <balbi@kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 05/18] macb_main: pass struct device to DMA API functions
Thread-Topic: [PATCH 05/18] macb_main: pass struct device to DMA API functions
Thread-Index: AQHUugsvj9N+ac4FwkevDZDD3e1gsqXK8ZcA
Date:   Fri, 1 Feb 2019 13:34:30 +0000
Message-ID: <e23bc61b-0c62-486b-ee85-fcfd8d86fdcf@microchip.com>
References: <20190201084801.10983-1-hch@lst.de>
 <20190201084801.10983-6-hch@lst.de>
In-Reply-To: <20190201084801.10983-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:40::22) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1934;6:1MyhO7dOEXr+xc4OPNWFMJC0vyalnqga7QLuvHx1MpR0k9GdBgPmyL9/Fj30jf7OB/CMx2iSM5lzecw8OCJGoZBTdxvblMTMXz+2/7IqlTPJ2s/7kEnIVgnZ2dIpcC+CiRDUHCEyAp1l/dw3NeT1adYTFZTVm7ZBYDz0B8iMYk0HzjzCLRK1WbjYNzZauKVMw8bvvEvSXn5O0GyBO2mHVjlmyUehySllWgK4hqhWzSgft590UNvD9pIs55E8xZLtkZ8IU+wZh3y/Spq6Pl2ddSiSAPxWNHqzQWGBfZPjRPNvyPWOmaYSPqkg0a2YW7xdKmmAWeBQ2EsgluQibW4fY5jT9Hg6gwXkhcm+HDDM2N89VbZdHfpoFYErtgFmz4+ClFz7CU63vGtoVu+dNvukdULG5clyoqi3jdjEabhGrHgktHW3tGuRpqTqJ7dVshOHXuT65lw9TwmQCFJ3UNPwTw==;5:wpd6yaVk8Z9Giu65gMKmQQs27DBhkBbeqMbBzmw6qpHp3UL3d6GY9boG6pzLz6LfCFHMl3waBIHMj+yIQR7j5R8F3SVogVlkxn83aaDttPK9F/RPEEsCd1HmTG8g3mH7fk4u27rsNKLHwsAerAgo0LWa3BwuDR5qdGjnwy+ksdraRynDn7M47zprIs7RTA8DxkupwTmf4yoZurvTDn9MQQ==;7:55mCbT9QvGX7ZrrlI8bjNYnF0zDOlzfn7/01gqUnnnvVqLIfPOBhz2FfkEfCHFc6+J9A/SUG93rN5wzdWhDP6NQkv+RhCqmkIWkXdc2xgdPDW9qobnubdNeyGtbyOJzCTXq/1pNtFRiapGU5ZzWiTg==
x-ms-office365-filtering-correlation-id: 0971a900-3bd0-4dae-0604-08d68849fdff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1934;
x-ms-traffictypediagnostic: MWHPR11MB1934:
x-microsoft-antispam-prvs: <MWHPR11MB1934574940737923CA05461BE0920@MWHPR11MB1934.namprd11.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(189003)(199004)(2616005)(11346002)(3846002)(31696002)(6116002)(446003)(86362001)(31686004)(105586002)(476003)(53936002)(486006)(106356001)(7736002)(39060400002)(8676002)(36756003)(8936002)(305945005)(81156014)(81166006)(71190400001)(71200400001)(97736004)(6246003)(68736007)(72206003)(6436002)(186003)(26005)(14454004)(6486002)(256004)(386003)(478600001)(4326008)(6512007)(6506007)(316002)(110136005)(217873002)(2906002)(66066001)(53546011)(2501003)(99286004)(25786009)(2201001)(102836004)(76176011)(7416002)(52116002)(229853002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1934;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GExem889GjJ+wQUFk33uiOq3+80PVsjRpbAg4qWjMjUuIqsI8vyezuM0VRNAazDjB+FaIHgcWKjnjtowj7KKsAdihhTCNtQEHBVA0KVEaLhmimWEV/TCVFHdcvwO4nZ40vDLoheTHmwcxxAs4331TfoI72nInnyfOYcP5HsNS7DPUrl3qbfD5ROSQ4pZ/TFP8GJpgLXzQ9WLrxsBE1QhVi913lT4W6SshG2nOYRdrK54tgr9jmeJUPDO/J5IZlf+9xeySUvmxKgJCWGX2PCGF3efCQxyy5Wu6BHAXVx5WhC9R4SkGnaVYQPeJp6uMjHKL0apBIgTYred0orDhre0HwZ1b4rzM954E/CKqPFFHS4aHaSbgMQSzVHY/wITL/RedhbNH/wmgfO9hiiIY9XCPGGnSXQqxaQZhbdwER5oZ5k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DC9437E6C81014BBE5FC3185E3DE5FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0971a900-3bd0-4dae-0604-08d68849fdff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 13:34:25.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1934
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDIvMjAxOSBhdCAwOTo0NywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZSBE
TUEgQVBJIGdlbmVyYWxseSByZWxpZXMgb24gYSBzdHJ1Y3QgZGV2aWNlIHRvIHdvcmsgcHJvcGVy
bHksIGFuZA0KPiBvbmx5IGJhcmVseSB3b3JrcyB3aXRob3V0IG9uZSBmb3IgbGVnYWN5IHJlYXNv
bnMuICBQYXNzIHRoZSBlYXNpbHkNCj4gYXZhaWxhYmxlIHN0cnVjdCBkZXZpY2UgZnJvbSB0aGUg
cGxhdGZvcm1fZGV2aWNlIHRvIHJlbWVkeSB0aGlzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQoNCkFja2VkLWJ5OiBOaWNvbGFzIEZlcnJlIDxu
aWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYyB8IDggKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+IGluZGV4IDJiMjg4MjYxNWU4Yi4uNjFhMjc5NjNm
MWQxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFp
bi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMNCj4g
QEAgLTM2NzMsOSArMzY3Myw5IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBhdDkxZXRoZXJfc3RhcnRf
eG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiAgIAkJLyogU3RvcmUgcGFja2V0IGluZm9ybWF0
aW9uICh0byBmcmVlIHdoZW4gVHggY29tcGxldGVkKSAqLw0KPiAgIAkJbHAtPnNrYiA9IHNrYjsN
Cj4gICAJCWxwLT5za2JfbGVuZ3RoID0gc2tiLT5sZW47DQo+IC0JCWxwLT5za2JfcGh5c2FkZHIg
PSBkbWFfbWFwX3NpbmdsZShOVUxMLCBza2ItPmRhdGEsIHNrYi0+bGVuLA0KPiAtCQkJCQkJCURN
QV9UT19ERVZJQ0UpOw0KPiAtCQlpZiAoZG1hX21hcHBpbmdfZXJyb3IoTlVMTCwgbHAtPnNrYl9w
aHlzYWRkcikpIHsNCj4gKwkJbHAtPnNrYl9waHlzYWRkciA9IGRtYV9tYXBfc2luZ2xlKCZscC0+
cGRldi0+ZGV2LCBza2ItPmRhdGEsDQo+ICsJCQkJCQkgIHNrYi0+bGVuLCBETUFfVE9fREVWSUNF
KTsNCj4gKwkJaWYgKGRtYV9tYXBwaW5nX2Vycm9yKCZscC0+cGRldi0+ZGV2LCBscC0+c2tiX3Bo
eXNhZGRyKSkgew0KPiAgIAkJCWRldl9rZnJlZV9za2JfYW55KHNrYik7DQo+ICAgCQkJZGV2LT5z
dGF0cy50eF9kcm9wcGVkKys7DQo+ICAgCQkJbmV0ZGV2X2VycihkZXYsICIlczogRE1BIG1hcHBp
bmcgZXJyb3JcbiIsIF9fZnVuY19fKTsNCj4gQEAgLTM3NjUsNyArMzc2NSw3IEBAIHN0YXRpYyBp
cnFyZXR1cm5fdCBhdDkxZXRoZXJfaW50ZXJydXB0KGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4g
ICAJCWlmIChscC0+c2tiKSB7DQo+ICAgCQkJZGV2X2tmcmVlX3NrYl9pcnEobHAtPnNrYik7DQo+
ICAgCQkJbHAtPnNrYiA9IE5VTEw7DQo+IC0JCQlkbWFfdW5tYXBfc2luZ2xlKE5VTEwsIGxwLT5z
a2JfcGh5c2FkZHIsDQo+ICsJCQlkbWFfdW5tYXBfc2luZ2xlKCZscC0+cGRldi0+ZGV2LCBscC0+
c2tiX3BoeXNhZGRyLA0KPiAgIAkJCQkJIGxwLT5za2JfbGVuZ3RoLCBETUFfVE9fREVWSUNFKTsN
Cj4gICAJCQlkZXYtPnN0YXRzLnR4X3BhY2tldHMrKzsNCj4gICAJCQlkZXYtPnN0YXRzLnR4X2J5
dGVzICs9IGxwLT5za2JfbGVuZ3RoOw0KPiANCg0KDQotLSANCk5pY29sYXMgRmVycmUNCg==
