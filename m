Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222C9C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60EA2082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="VPL4Wa9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60EA2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeJ3Pji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:39:38 -0400
Received: from mail-co1nam03on0047.outbound.protection.outlook.com ([104.47.40.47]:1728
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbeJ3Pji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNE0YzpJ88hbY6efadIJspa2Oti6qE8S1ZXjWjg2jeI=;
 b=VPL4Wa9odjwR8lSslayvU1ohhDwSO2EOa203Rwoj3noj3ljb41H8Ng2dwrwIs5mYa8Bydb0FXebESZOorPpMqOwKXb4xGQajWMCPygAE2lcGXZRevXswNEb5fjhViI6FKCK1kwaxSVeOXgO8VVeV3EM0HjjuzP09IcN5irarV04=
Received: from BYAPR07MB5365.namprd07.prod.outlook.com (20.177.125.18) by
 BYAPR07MB5527.namprd07.prod.outlook.com (20.177.231.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 30 Oct 2018 06:47:20 +0000
Received: from BYAPR07MB5365.namprd07.prod.outlook.com
 ([fe80::4012:e217:427e:320b]) by BYAPR07MB5365.namprd07.prod.outlook.com
 ([fe80::4012:e217:427e:320b%3]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 06:47:19 +0000
From:   "Mody, Rasesh" <Rasesh.Mody@cavium.com>
To:     maowenan <maowenan@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Rahman, Ameen" <Ameen.Rahman@cavium.com>
Subject: RE: bnx2: rx_fw_discards: BCM5716 sporadically drops packets when
 update to driver version 2.2.6
Thread-Topic: bnx2: rx_fw_discards: BCM5716 sporadically drops packets when
 update to driver version 2.2.6
Thread-Index: AQHUbNotBIAsCBK6RUOWb9pCZ4eUJ6U3XB3Q
Date:   Tue, 30 Oct 2018 06:47:19 +0000
Message-ID: <BYAPR07MB536505C0A8C27C76C352C3239FCC0@BYAPR07MB5365.namprd07.prod.outlook.com>
References: <1a94796f-1760-f332-46f0-6ab0b5a0aab7@huawei.com>
In-Reply-To: <1a94796f-1760-f332-46f0-6ab0b5a0aab7@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.186.1.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5527;6:MZ/y0bRqPz23B367v8g/NVKrgaifF/Dim1jy1JKVzG1cnnNbohZoxxPmRtT+IzxQLhdjRCzXAbClDzhK8URVtbdaiZHOfn1ehg95a0AnWXLd6dOITd7AF4GWwzasMa/jM6QXYfmRz8XoHI5G99GMQovlr18olwN3LjEF0nSC8Dc187EtOXP2yq1tO6L+VoRrxTMbw5onBr9PhpoYbNxdLOLONsiRRXqmXJMkO7LzVTUUNEO6JFDNOghx6CGJ+1WEiNkuHsLGvWVE2AHTSZo0sNwOl+k/wuJ8XbtfUNWr85zcL/K3nomeSn4WVCEcBJo4GOvEXmjhUu2BPoMxTj5ozxOBONxCdK+fVsqZQDyT+8pQpWCjaJvAaWI3vDULBKAZohlsdeXzbm6uiLhCo5bvZ8mOeLLiGmxRw0JURXwByKp29IIrNV6ixZo9v5AkVJoU/gnH6vY0QzCGdDQQ+J5CPA==;5:XSYxmKvhg78V7CaVFWspfvnKnIxtlupQzc7SmBOFfeBVnL8XltClS+uw6z36HMg8D7Br94TYC3lZ9VqdGUzcf7vvOWVFYSZmM90vqhssh46Hwaa4RuuRm/Vdyf5hhLBNJBok+Eo/8FSB05giyfmcpHJ4GChV/HOaG8u901aVm0c=;7:WBmgU1nq99iVqeMc+wAI2vzVVvj0COYSXTiOJvWULBtJ0gg1G2dQ6lruh0skFwd6zTeugJC2e4Q7GpDgYBY2V+tsPhihNOkIsYqxw7BrHzxq7HmfmXPzZneREGqSul/LPB2SfdfmIfvXSTrWiuToa+gDUMa4zm+k4dfDKoFCYNnhXUZTQCHsUOLsHMxweMtR+vmjFKMjFC2Xjbh5UtnA+ajPCvUVX/Xg01Daur5jtRec93hIgkpNyZ3PMNY9S2cn
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(24433001)(189003)(31014005)(55016002)(2900100001)(81156014)(6306002)(7736002)(305945005)(74316002)(81166006)(2906002)(5660300001)(9686003)(33656002)(8676002)(72206003)(11346002)(53936002)(186003)(3846002)(6116002)(107886003)(486006)(39060400002)(6246003)(476003)(15650500001)(14454004)(316002)(446003)(5250100002)(66066001)(25786009)(4326008)(26005)(2501003)(256004)(105586002)(2201001)(76176011)(14444005)(68736007)(6436002)(71200400001)(7696005)(478600001)(106356001)(86362001)(8936002)(110136005)(71190400001)(6506007)(229853002)(102836004)(99286004)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5527;H:BYAPR07MB5365.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: aa9ef60f-31bc-4573-cb01-08d63e3389c6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5527;
x-ms-traffictypediagnostic: BYAPR07MB5527:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasesh.Mody@cavium.com; 
x-microsoft-antispam-prvs: <BYAPR07MB552733661AD24076C7965D869FCC0@BYAPR07MB5527.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231382)(944501410)(52105095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5527;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5527;
x-forefront-prvs: 08417837C5
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: az2yXQVDxSBw0huAsW/ddrJq6k73I5kQ9x6qLTFCNVRD2vbSBQlzL7wNLyjCOC8DU29R3Oxd3esiI/ZZ2XakPs2HZ2IfjmoXhM27INVYYkZklq5i2rBB0+YJ2Pm/bETqB0kaH8QK9mBiLsPwWJGXskYuy39crVpSsWJBqz67wjmc2paeyAVl7nksJxilPHstx5ty3gBzMq+jrClN4QGTWUUa7p4I+Ell/8/XPbNW737vkqrMIDQ0HcYejGfGk0pYu9TiN3wJMSzlbdlSXBQwbSwZDxVFz3eeeN3Y6uXK7w1d/yTrgnYNWCSuS1IKuAZbaU/tUkLGh6+EuBI2GxtMorxZ5qEQ9l/j8fSMHZb0r6w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9ef60f-31bc-4573-cb01-08d63e3389c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 06:47:19.3546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5527
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IG1hb3dlbmFuIDxtYW93ZW5hbkBodWF3ZWkuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBP
Y3RvYmVyIDI1LCAyMDE4IDg6MTYgUE0NCj4NCj5Iae+8jA0KPg0KPkFmdGVyIEkgdXBkYXRlIHZl
cnNpb24gb2YgYm54MiBkcml2ZXIgZnJvbSAyLjIuMSB0byAyLjIuNiwgSSBmaW5kIEJDTTU3MTYN
Cj5zcG9yYWRpY2FsbHkgZHJvcHMgcGFja2V0cywgd2hpY2ggc2hvd3MgaW4gcnhfZndfZGlzY2Fy
ZHMuDQo+QzM2LTE0MS01On4gIyAgZXRodG9vbCAtUyBOSUMwDQo+DQo+TklDIHN0YXRpc3RpY3M6
DQo+ICAgICByeF91Y2FzdF9wYWNrZXRzOiAxMTkwMg0KPg0KPiAgICAgcnhfbWNhc3RfcGFja2V0
czogMjE3DQo+DQo+ICAgICByeF9iY2FzdF9wYWNrZXRzOiA0OTU0MzIwDQo+DQo+ICAgICByeF9m
aWx0ZXJlZF9wYWNrZXRzOiAzMjg3OTMNCj4NCj4gICAgIHJ4X2Z3X2Rpc2NhcmRzOiAyNzQyDQo+
DQo+QzM2LTE0MS01On4gIw0KPg0KPjVzIGxhdGVyOg0KPg0KPkMzNi0xNDEtNTp+ICMgIGV0aHRv
b2wgLVMgTklDMA0KPg0KPk5JQyBzdGF0aXN0aWNzOg0KPiAgICAgcnhfdWNhc3RfcGFja2V0czog
MTE5MTANCj4NCj4gICAgIHJ4X21jYXN0X3BhY2tldHM6IDIxNw0KPg0KPiAgICAgcnhfYmNhc3Rf
cGFja2V0czogNDk1ODExNw0KPg0KPiAgICAgcnhfZmlsdGVyZWRfcGFja2V0czogMzI4ODk3DQo+
DQo+ICAgICByeF9md19kaXNjYXJkczogMjc1MA0KPg0KPkMzNi0xNDEtNTp+ICMNCj4NCj5zbyBy
eF9md19kaXNjYXJkczogMjc0Mi0tLS0tPiByeF9md19kaXNjYXJkczogMjc1MCwgbG9zdCA4IHBh
Y2tldHMuDQo+DQo+dGhlIGluZm9ybWF0aW9uIG9mIGJueDINCj5DMzYtMTQxLTU6fiAjIG1vZGlu
Zm8gYm54Mg0KPmtlcm5lbC9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS9ibngyLmtvDQo+
DQo+ZmlybXdhcmU6ICAgICAgIGJueDIvYm54Mi1ydjJwLTA5YXgtNi4wLjE3LmZ3DQo+DQo+Zmly
bXdhcmU6ICAgICAgIGJueDIvYm54Mi1ydjJwLTA5LTYuMC4xNy5mdw0KPg0KPmZpcm13YXJlOiAg
ICAgICBibngyL2JueDItbWlwcy0wOS02LjIuMWIuZncNCj4NCj5maXJtd2FyZTogICAgICAgYm54
Mi9ibngyLXJ2MnAtMDYtNi4wLjE1LmZ3DQo+DQo+ZmlybXdhcmU6ICAgICAgIGJueDIvYm54Mi1t
aXBzLTA2LTYuMi4zLmZ3DQo+dmVyc2lvbjogICAgICAgIDIuMi42DQo+DQo+DQo+MSkgRmlyc3Rs
eSwgSSBjaGVjayB0aGUgcGF0Y2hlcyBmcm9tIDIuMi4xIHRvIDIuMi42LCBiZWxvdyBwYXRjaCBp
cyBpbnRlcmVzdGluZy4NCj5odHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZA0KPj0wMDIxODUwZDA0MTdhNGRj
MzhlZDg3MWQ5MjliNjUxYjg3ZTJlYWQ5DQo+RG8gbm90IGVuYWJsZSBmaWx0ZXIgU09SVCBNT0RF
IGluIGNoaXAgaW5pdCByb3V0aW5lLiBUaGlzIHBhdGNoIGFkZHJlc3NlcyBhbg0KPmlzc3VlIHdo
ZXJlIEJDTTU3MTYgc3BvcmFkaWNhbGx5IGRyb3BzIHBhY2tldHMgd2hlbiBjaGFuZ2luZyBtdWx0
aWNhc3QgbGlzdC4NCj4NCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvYWRj
b20vYm54Mi5jDQo+Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS9ibngyLmMNCj5pbmRl
eCA4OTU3ZWI1ZjQ0NzguLjhjOWE4Yjc3ODdkMiAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9icm9hZGNvbS9ibngyLmMNCj4rKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9h
ZGNvbS9ibngyLmMNCj5AQCAtNDk4NCw4ICs0OTg0LDYgQEAgYm54Ml9pbml0X2NoaXAoc3RydWN0
IGJueDIgKmJwKQ0KPg0KPiAgICAgICAgYnAtPmlkbGVfY2hrX3N0YXR1c19pZHggPSAweGZmZmY7
DQo+DQo+LSAgICAgICBicC0+cnhfbW9kZSA9IEJOWDJfRU1BQ19SWF9NT0RFX1NPUlRfTU9ERTsN
Cj4tDQo+ICAgICAgICAvKiBTZXQgdXAgaG93IHRvIGdlbmVyYXRlIGEgbGluayBjaGFuZ2UgaW50
ZXJydXB0LiAqLw0KPiAgICAgICAgQk5YMl9XUihicCwgQk5YMl9FTUFDX0FUVEVOVElPTl9FTkEs
DQo+Qk5YMl9FTUFDX0FUVEVOVElPTl9FTkFfTElOSyk7DQo+DQo+DQo+MikgU2Vjb25kbHksIEkg
cmV2ZXJ0IHRoaXMgcGF0Y2gsIGFmdGVyIHZlcmlmeSBpdCwgSSBmaW5kIHJ4X2Z3X2Rpc2NhcmRz
IGRvZXMgbm90DQo+aW5jcmVhc2luZy4NCj5zbyBJIHRoaW5rIHRoaXMgcGF0Y2ggY2FuIGZpeCBj
dXJyZW50IGlzc3VlLiBCdXQgSSdtIG5vdCBzdXJlIHRoZSBpc3N1ZSBvZiB0aGlzDQo+cGF0Y2gg
dG8gZml4IHdpbGwgYmUgcmVwcm9kdWNlZD8NCj5JJ20gbm90IGNvbnZpbmNlZCB0aGF0IHdoYXQg
ZmFjdG9yIHdpbGwgdHJpZ2dlciByeF9md19kaXNjYXJkcyBpbmNyZWFzaW5nPw0KPkFuZCBob3cg
dG8gZml4IHRoaXM/DQoNCkNhbiB5b3UgcGxlYXNlIHJld29yZCB5b3VyIHBvaW50IGFib3ZlPyBp
LmUuIHdoYXQgaXMgd29ya2luZyBhbmQgd2hhdCBpcyBub3QuIEkgYW0gbm90IHN1cmUgaWYgSSB1
bmRlcnN0YW5kIGl0IGNvbXBsZXRlbHkuDQoNCklzIHRoZSByeF9md19kaXNhY2FyZCBjb3VudCBp
bmNyZW1lbnRpbmcgd2l0aCAyLjIuNiB1cHN0cmVhbSBkcml2ZXIgb24gQkNNNTcxNj8gV2hhdCBp
cyB0aGUga2VybmVsIHZlcnNpb24/DQpXaGljaCB0ZXN0IGlzIGJlaW5nIHJ1bj8NCg0KPg0KPlRo
YW5rcyBhIGxvdC4NCj4NCj4NCj4NCj4NCj4NCj4NCj4NCj4NCj4NCj4NCj4NCg0K
