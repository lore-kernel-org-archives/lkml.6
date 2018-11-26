Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D099AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840CD20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="VtucrV0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840CD20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeK0BlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:41:14 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:53211 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeK0BlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:41:13 -0500
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="24517342"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Nov 2018 07:46:53 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 26 Nov 2018 07:46:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VutZ4I5dxPb8vlTH//EaLdyW9rCTA1sEMMlnWV7p3hw=;
 b=VtucrV0BsaStzQTg9TDKTYtC30gxvqwUZ8DWNrbNvuwZdF+Gj/ycIb52S8AJEfQz/BmjECy3e09y9GM/g+I+NYMelw/kWGQCKq0DIn7dKG2IGGP++wGgL2P+NfY9qT7CfhyuhDFnpigQK3NmCEEWnukA+JNNxFk+FEO6Taw0N2U=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0615.namprd11.prod.outlook.com (10.163.159.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 14:46:50 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 14:46:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <harini.katakam@xilinx.com>, <Nicolas.Ferre@microchip.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <appanad@xilinx.com>
Subject: Re: [PATCH v2 4/4] net: macb: Add support for suspend/resume with
 full power down
Thread-Topic: [PATCH v2 4/4] net: macb: Add support for suspend/resume with
 full power down
Thread-Index: AQHUhZbYf5CxbcHOcUyrEaW+6kS1Xg==
Date:   Mon, 26 Nov 2018 14:46:50 +0000
Message-ID: <c844298e-d997-940f-be85-fd3442d01be5@microchip.com>
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
 <1543216072-9623-5-git-send-email-harini.katakam@xilinx.com>
In-Reply-To: <1543216072-9623-5-git-send-email-harini.katakam@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0044.eurprd09.prod.outlook.com
 (2603:10a6:802:28::12) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0615;6:0+D3vmeMMQDviw8Wr0M4Fqh9qb3G3iVeUEzRbwrHQ+49R3DmzqRbpWMgWaem+ZCO3SkPCsNGEJXZmpd6ITbjiO8mygdOh7vzWfsa9sDW3UbMecyiokAazCaKytXtLWsKsCMq1ytMHdMvolrEwPTm4kmB/N3Meci9ySO3JhGhxwROgVYKKSS0k4dlV03y9ceiFQZNJnBoMrOX3y/ckrJHq9yue+TOA7uPWyMRpbOCWPV/3fg0U0mxxyX1lUtJyaTMP1yHpU4YJBPTQueYL4HS/978tF+Z8P9wC73XalDKrex0QucQifVNZE2xYtPk024SDkhel5YMfknAlVrGl0wJYjjo714FwJfZYMoM/kkLdteieNxY6sIr44shRar+QH4RPB5Ek0WOGRL2Nu82zGALh3IG3R1FrjXYtCY8O5FPGHW1ICC0+2IIT0BW4rPiwo5rsZtoXpdzjwo1CtiUm8vj6w==;5:ukxwiAkLrY1YIQg7Rcc8wjHH8S4kML7i1uK12SZa4O9EdGSFzJ+upNUnjZbbJnFEJdZhZqQGEF0aY66kvaqH/OWjeJ1pau1RpbK7LZQVZQIOUOT24Bk5ZkSuceEolFRbTNHSSXJOWTtcgNHL0wtoJ0pro9hNZHKZBXFKZxAiMYY=;7:vWZkeRRMJHyVtxi6vdMuWHd/zz86HE9GeNjUY2WZQMTIDSO29yA3pdT913YI49rRyI0SrVFKwH/yuX5YRsZJRlXhMUAy+Ioa4avHkrQQd7zM/8I7fgyszqnuzuQlnUfUK6SQle/six63RPZgcTz0TQ==
x-ms-office365-filtering-correlation-id: 89560ad9-25bf-4822-7ec9-08d653adff88
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0615;
x-ms-traffictypediagnostic: BY2PR11MB0615:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-microsoft-antispam-prvs: <BY2PR11MB06158EC33FFDCCA47DF2FFD087D70@BY2PR11MB0615.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231443)(944501410)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0615;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0615;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(136003)(39860400002)(199004)(189003)(8676002)(52116002)(76176011)(6506007)(102836004)(186003)(53546011)(26005)(386003)(97736004)(229853002)(6436002)(99286004)(6512007)(486006)(53936002)(6486002)(36756003)(39060400002)(81166006)(2616005)(11346002)(446003)(14454004)(110136005)(316002)(54906003)(25786009)(15650500001)(2501003)(478600001)(72206003)(66066001)(5660300001)(106356001)(105586002)(3846002)(31696002)(6116002)(86362001)(14444005)(5024004)(256004)(8936002)(81156014)(6246003)(7736002)(476003)(31686004)(71200400001)(4326008)(71190400001)(305945005)(2906002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0615;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +TRNnF0x7ilTb96w9ZOdqnFQX73fWEAaxPPQjNSzyd7xzc8FBDtKkMhMOqGMISPjbI9RXzwaQFSA+ri2Njy56j8/yIiGLeDeoyemX0b69utjmsKryzHdCDCZkcKpRtATo+m5CROOA+EusyrDAY2hHHZ5UbN8mjjaclM9FBn6+JFyw0pb/nw/V6ka9Wa35ZQrmw2CQBM+y3pU6DaXJczx1G9/jYgiNFmF5Lo3ZmgBDDrZCg0fHFBAev/gwF9I+nTQT+UiCjqQMzhDjEHbfH0R/aMaUgCqG8scphU/yg9drZTvl674+XJDt50JrR1m0essH3vPr9aRIRoSwBmnDwx7Jy4+llx1G6bjcbHSK1t7Fdo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EAB3D1E1427F24BA3F4FDD99F62C3A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 89560ad9-25bf-4822-7ec9-08d653adff88
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 14:46:50.4059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0615
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI2LjExLjIwMTggMDk6MDcsIEhhcmluaSBLYXRha2FtIHdyb3RlOg0KPiBXaGVuIG1h
Y2IgZGV2aWNlIGlzIHN1c3BlbmRlZCBhbmQgc3lzdGVtIGlzIHBvd2VyZWQgZG93biwgdGhlIGNs
b2Nrcw0KPiBhcmUgcmVtb3ZlZCBhbmQgaGVuY2UgbWFjYiBzaG91bGQgYmUgY2xvc2VkIGdyYWNl
ZnVsbHkgYW5kIHJlc3RvcmVkDQo+IHVwb24gcmVzdW1lLiBUaGlzIHBhdGNoIGRvZXMgdGhlIHNh
bWUgYnkgc3dpdGNoaW5nIG9mZiB0aGUgbmV0IGRldmljZSwNCj4gc3VzcGVuZGluZyBwaHkgYW5k
IHBlcmZvcm1pbmcgbmVjZXNzYXJ5IGNsZWFudXAgb2YgaW50ZXJydXB0cyBhbmQgQkRzLg0KPiBV
cG9uIHJlc3VtZSwgYWxsIHRoZXNlIGFyZSByZWluaXRpYWxpemVkIGFnYWluLg0KPiANCj4gUmVz
ZXQgb2YgbWFjYiBkZXZpY2UgaXMgZG9uZSBvbmx5IHdoZW4gR0VNIGlzIG5vdCBhIHdha2UgZGV2
aWNlLg0KPiBFdmVuIHdoZW4gZ2VtIGlzIGEgd2FrZSBkZXZpY2UsIHR4IHF1ZXVlcyBjYW4gYmUg
c3RvcHBlZCBhbmQgcHRwIGRldmljZQ0KPiBjYW4gYmUgY2xvc2VkICh0c3UgY2xvY2sgd2lsbCBi
ZSBkaXNhYmxlZCBpbiBwbV9ydW50aW1lX3N1c3BlbmQpIGFzDQo+IHdha2UgZXZlbnQgZGV0ZWN0
aW9uIGhhcyBubyBkZXBlbmRlbmN5IG9uIHRoaXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLZWRh
cmVzd2FyYSByYW8gQXBwYW5hIDxhcHBhbmFkQHhpbGlueC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEhhcmluaSBLYXRha2FtIDxoYXJpbmkua2F0YWthbUB4aWxpbnguY29tPg0KPiAtLS0NCj4gdjIg
Y2hhbmdlczoNCj4gRml4ZWQgcGFyYW1ldGVyIHBhc3NlZCB0byBwaHkgY2FsbHMuDQo+IA0KPiAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYyB8IDM4ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9jYWRlbmNlL21hY2JfbWFpbi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNi
X21haW4uYw0KPiBpbmRleCA0Yjg1YWQ3Li5kY2IwMTk0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMNCj4gQEAgLTQyNDksMTYgKzQyNDksMzMgQEAgc3Rh
dGljIGludCBfX21heWJlX3VudXNlZCBtYWNiX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiAgew0KPiAgCXN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCj4gIAlzdHJ1Y3QgbWFjYiAqYnAgPSBuZXRkZXZfcHJpdihuZXRkZXYpOw0KPiArCXN0cnVj
dCBtYWNiX3F1ZXVlICpxdWV1ZSA9IGJwLT5xdWV1ZXM7DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFn
czsNCj4gKwl1bnNpZ25lZCBpbnQgcTsNCj4gKw0KPiArCWlmICghbmV0aWZfcnVubmluZyhuZXRk
ZXYpKQ0KPiArCQlyZXR1cm4gMDsNCj4gIA0KPiAtCW5ldGlmX2NhcnJpZXJfb2ZmKG5ldGRldik7
DQo+IC0JbmV0aWZfZGV2aWNlX2RldGFjaChuZXRkZXYpOw0KDQpJcyBpdCBuZWNlc3NhcnkgdG8g
cmVtb3ZlIHRoaXMgZnJvbSBoZXJlIGFuZCBoYXZlIGl0IG9uIGV2ZXJ5IGlmIGJyYW5jaD8NCg0K
PiAgDQo+ICAJaWYgKGJwLT53b2wgJiBNQUNCX1dPTF9FTkFCTEVEKSB7DQo+ICAJCW1hY2Jfd3Jp
dGVsKGJwLCBJRVIsIE1BQ0JfQklUKFdPTCkpOw0KPiAgCQltYWNiX3dyaXRlbChicCwgV09MLCBN
QUNCX0JJVChNQUcpKTsNCj4gIAkJZW5hYmxlX2lycV93YWtlKGJwLT5xdWV1ZXNbMF0uaXJxKTsN
Cj4gKwkJbmV0aWZfZGV2aWNlX2RldGFjaChuZXRkZXYpOw0KPiArCX0gZWxzZSB7DQo+ICsJCW5l
dGlmX2RldmljZV9kZXRhY2gobmV0ZGV2KTsNCj4gKwkJZm9yIChxID0gMCwgcXVldWUgPSBicC0+
cXVldWVzOyBxIDwgYnAtPm51bV9xdWV1ZXM7ICsrcSwgKytxdWV1ZSkNCj4gKwkJCW5hcGlfZGlz
YWJsZSgmcXVldWUtPm5hcGkpOw0KPiArCQlwaHlfc3RvcChuZXRkZXYtPnBoeWRldik7DQo+ICsJ
CXBoeV9zdXNwZW5kKG5ldGRldi0+cGh5ZGV2KTsNCj4gKwkJc3Bpbl9sb2NrX2lycXNhdmUoJmJw
LT5sb2NrLCBmbGFncyk7DQo+ICsJCW1hY2JfcmVzZXRfaHcoYnApOw0KPiArCQlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZicC0+bG9jaywgZmxhZ3MpOw0KDQpJbiB0aGUgcHJldmlvdXMgdmVyc2lv
biB5b3Ugc2FpZCB5b3UgZW5jb3VudGVyZWQgc29tZSBjcmFzaGVzIHdoaWxlDQpzdHJlc3Npbmcg
dGhpcyBwYXJ0IGlmIG1hY2Jfb3BlbigpL21hY2JfY2xvc2UoKSB3YXMgdXNlZCBpbiBoZXJlLiBD
b3VsZCB5b3UNCnNoYXJlIHRoZSB0ZXN0cyBzbyB0aGF0IEkgY2FuIGRlYnVnIGl0IG9uIG15IHNp
ZGU/DQoNCj4gIAl9DQo+ICANCj4gKwluZXRpZl9jYXJyaWVyX29mZihuZXRkZXYpOw0KPiArCWlm
IChicC0+cHRwX2luZm8pDQo+ICsJCWJwLT5wdHBfaW5mby0+cHRwX3JlbW92ZShuZXRkZXYpOw0K
PiAgCXBtX3J1bnRpbWVfZm9yY2Vfc3VzcGVuZChkZXYpOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+
IEBAIC00MjY4LDYgKzQyODUsMTEgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBtYWNiX3Jl
c3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3RydWN0IG5ldF9kZXZpY2UgKm5l
dGRldiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgCXN0cnVjdCBtYWNiICpicCA9IG5ldGRl
dl9wcml2KG5ldGRldik7DQo+ICsJc3RydWN0IG1hY2JfcXVldWUgKnF1ZXVlID0gYnAtPnF1ZXVl
czsNCj4gKwl1bnNpZ25lZCBpbnQgcTsNCj4gKw0KPiArCWlmICghbmV0aWZfcnVubmluZyhuZXRk
ZXYpKQ0KPiArCQlyZXR1cm4gMDsNCj4gIA0KPiAgCXBtX3J1bnRpbWVfZm9yY2VfcmVzdW1lKGRl
dik7DQo+ICANCj4gQEAgLTQyNzUsOSArNDI5NywyMSBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51
c2VkIG1hY2JfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAkJbWFjYl93cml0ZWwoYnAs
IElEUiwgTUFDQl9CSVQoV09MKSk7DQo+ICAJCW1hY2Jfd3JpdGVsKGJwLCBXT0wsIDApOw0KPiAg
CQlkaXNhYmxlX2lycV93YWtlKGJwLT5xdWV1ZXNbMF0uaXJxKTsNCj4gKwl9IGVsc2Ugew0KPiAr
CQltYWNiX3dyaXRlbChicCwgTkNSLCBNQUNCX0JJVChNUEUpKTsNCg0KSnVzdCBhc2tpbmcuLi4g
c2hvdWxkbid0IG90aGVyIHJlZ2lzdGVycyBiZSByZXN0b3JlZCBoZXJlIGFmdGVyIFNvQyBwb3dl
cg0KaXMgY3V0IG9mZj8NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiArCQlmb3Ig
KHEgPSAwLCBxdWV1ZSA9IGJwLT5xdWV1ZXM7IHEgPCBicC0+bnVtX3F1ZXVlczsgKytxLCArK3F1
ZXVlKQ0KPiArCQkJbmFwaV9lbmFibGUoJnF1ZXVlLT5uYXBpKTsNCj4gKwkJcGh5X3Jlc3VtZShu
ZXRkZXYtPnBoeWRldik7DQo+ICsJCXBoeV9pbml0X2h3KG5ldGRldi0+cGh5ZGV2KTsNCj4gKwkJ
cGh5X3N0YXJ0KG5ldGRldi0+cGh5ZGV2KTsNCj4gIAl9DQo+ICANCj4gKwlicC0+bWFjYmdlbV9v
cHMubW9nX2luaXRfcmluZ3MoYnApOw0KPiArCW1hY2JfaW5pdF9odyhicCk7DQo+ICsJbWFjYl9z
ZXRfcnhfbW9kZShuZXRkZXYpOw0KPiAgCW5ldGlmX2RldmljZV9hdHRhY2gobmV0ZGV2KTsNCj4g
KwlpZiAoYnAtPnB0cF9pbmZvKQ0KPiArCQlicC0+cHRwX2luZm8tPnB0cF9pbml0KG5ldGRldik7
DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo=
