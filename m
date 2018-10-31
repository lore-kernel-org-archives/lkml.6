Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D33ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F27F20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="klE3hcZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F27F20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbeKABJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:09:10 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62393 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeKABJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:09:10 -0400
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="22610479"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Oct 2018 09:10:30 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 31 Oct 2018 09:10:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQcrBsDLdkaeUzmOgZKKoqfgLYjdafs4xlrBeuDLXN4=;
 b=klE3hcZBjS3kk3vRGVW+99kRA1KdfdlHrI8rWSfypzZEeGCrCgOl71BcwlVKT8REynKS7yrE82Nh88fwWDcbg9DSIEmjfz7Fa0UgJMlEXSFHtAotK4/6CiYjyrLm3tHNdI009iS0L259spQlpnE44FXuy3IiJWA4FkgCqN47CAc=
Received: from BLUPR11MB0740.namprd11.prod.outlook.com (10.163.216.18) by
 BLUPR11MB0387.namprd11.prod.outlook.com (10.162.91.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Wed, 31 Oct 2018 16:10:25 +0000
Received: from BLUPR11MB0740.namprd11.prod.outlook.com
 ([fe80::2dca:81f7:b419:fdf2]) by BLUPR11MB0740.namprd11.prod.outlook.com
 ([fe80::2dca:81f7:b419:fdf2%3]) with mapi id 15.20.1294.021; Wed, 31 Oct 2018
 16:10:25 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <harini.katakam@xilinx.com>, <Nicolas.Ferre@microchip.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <appanad@xilinx.com>
Subject: Re: [PATCH 4/4] net: macb: Add support for suspend/resume with full
 power down
Thread-Topic: [PATCH 4/4] net: macb: Add support for suspend/resume with full
 power down
Thread-Index: AQHUcTQ3Y2sOXR6TTEW0zqOILY4ikg==
Date:   Wed, 31 Oct 2018 16:10:25 +0000
Message-ID: <f69c428d-565e-cf8e-de53-45850f2625cf@microchip.com>
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
 <1540957223-30984-5-git-send-email-harini.katakam@xilinx.com>
In-Reply-To: <1540957223-30984-5-git-send-email-harini.katakam@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::48) To BLUPR11MB0740.namprd11.prod.outlook.com
 (2a01:111:e400:594c::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR11MB0387;6:KiVTXZ9X4/V2lnAu19yFuPB2jqwVBIDMG+AqyYY9qNK8fkPyqgEFJNOWuTRj7YC8eRUMjCdVGNI2JLLgminG7hyyUCp7BsoRWxgYmduogkIFnIljRBC0uEzv9636/22oLwdD73Y5LSiiG+wQZbYrGRw+BOPyDU4SybJoMCN2JWv0YAGeMl0Mf/uAVLmXx2zFvQ8BNdN4Z8o2FA++Yb/JiBdQfDHP4EFTGLYGq//WgeXjZQ49pbq/SujHoSD2SxZLmj+CivLdyuX6CCM32TVz4n4yeAVB4SSriGA2gMzVYbbulmFXsgWfZ/w+zV6nj6UgWUsK9WSCuw7G4Us4QMzKogr2Yhoaj5w/qjqqoVQZGQKEDosBWOPUnwrlWX3sRZfpcsz4ffpUIkWFUX5WKAVv8iFsqG2VeTcrkM1aXj2tBPyVQI8iVW0ZK4SSbbEQFdmUDs0be/tI3fwkPNzCcvaeIw==;5:bw0z58nf7dkQnIH/6ho+0OIaOd5nVuo/wQ9QWCRLaowyS2FW0HleLweC3gS5aXmpid6+rydzcBE6y734Wjh/FMfj138TiE/fL7wUEb67u0R5S5mCRu2wn0nCOQ9ejDa3LHBydv2b5AwVPxQbEBh1Ry5bh+mC9MJLt5jErHD+qgM=;7:gOMTl9w/u8ieeBGhX3rXeNUgs5XHFPoFFMJDy2OSBcqkmUUTU0Ycg36GKzu85/Bse9uM5TzUuMhlQTiIqdU/Sit4/kYsTctQ7v7v5qsmJyZPYfCKENkR9BzzKN4SHmSXtlzS64+VtB+blqkwPFRJvA==
x-ms-office365-filtering-correlation-id: d6491d59-85d6-4ded-9a41-08d63f4b5dd6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR11MB0387;
x-ms-traffictypediagnostic: BLUPR11MB0387:
x-microsoft-antispam-prvs: <BLUPR11MB03878AD1E5FA136094B66F0D87CD0@BLUPR11MB0387.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BLUPR11MB0387;BCL:0;PCL:0;RULEID:;SRVR:BLUPR11MB0387;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(66066001)(256004)(5024004)(14444005)(316002)(2906002)(54906003)(186003)(6246003)(110136005)(105586002)(2900100001)(229853002)(52116002)(106356001)(53936002)(6512007)(6306002)(476003)(71200400001)(486006)(76176011)(6486002)(11346002)(3846002)(6116002)(2616005)(71190400001)(6436002)(446003)(36756003)(14454004)(478600001)(7736002)(305945005)(26005)(39060400002)(86362001)(68736007)(2501003)(72206003)(31696002)(25786009)(966005)(6506007)(53546011)(386003)(99286004)(8936002)(102836004)(15650500001)(31686004)(4326008)(8676002)(97736004)(81156014)(81166006)(5250100002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR11MB0387;H:BLUPR11MB0740.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UNZadzGIiVpaPbJQpNftVkiy5ik8fe6NfVzc4FXgVZv7JgV60+5LAq6Ofo85e7YLmSXlxuI1xQbAhSHTt8PJEjOpWkvmhNAGD8sFm9ZebsvYAoO6m0/x9cRib5KNVLG0CWCwspkPd31ajLm3WHH7wV/z4RCt1iAyTGz9eozrrAjEjO9tGebaWDvdfxwC9NZU5+unvyKpJdODb1VJ+bf0HIOaXxmfWo0xG6k17EVglY7SO1TdMu8z7if+pI9b0O2q6Xc1EJ0sA0T8CEUY4HgrfQlP0n0YhuHPSqUeyXTrg8J8LutOwsUtlENFeU8B2j9iG/waRxlYhtFxx86oAPfjaZez2y9xqyuD7MFxQ3b9D5M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5005A59205FA974AA1D748A5F3B2CF7C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d6491d59-85d6-4ded-9a41-08d63f4b5dd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 16:10:25.7696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR11MB0387
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMxLjEwLjIwMTggMDU6NDAsIEhhcmluaSBLYXRha2FtIHdyb3RlOg0KPiBXaGVuIG1h
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
IEhhcmluaSBLYXRha2FtIDxoYXJpbmkua2F0YWthbUB4aWxpbnguY29tPg0KPiAtLS0NCj4gTm90
ZXM6DQo+IEkgd2FzIHVuYWJsZSB0byBkbyBhIGZ1bGwgbWFjYl9jbG9zZS9vcGVuIGluIHRoaXMg
cGF0Y2ggYXMgc3VnZ2VzdGVkDQo+IGJlY2F1c2UgaXQgd2FzIGZyZWVpbmcgYW5kIGFsbG9jYXRp
bmcgdGhlIGZ1bGwgUlgvVFggYnVmZmVycyBhbmQNCj4gdGhpcyB0aW1lIGNvbnN1bWluZywgYWxz
byBsZWFkaW5nIHRvIGEgY3Jhc2ggd2hlbiBkb25lIGNvbnRpbnVvdXNseQ0KPiBpbiBzdHJlc3Mg
dGVzdHMuIA0KPiANCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMg
fCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDM2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2NhZGVuY2UvbWFjYl9tYWluLmMNCj4gaW5kZXggMDljYjRiYi4uMGQxYWNiNCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYw0KPiArKysg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+IEBAIC00MjQ3LDE2
ICs0MjQ3LDMzIEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbWFjYl9zdXNwZW5kKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2ID0gdG9fcGxh
dGZvcm1fZGV2aWNlKGRldik7DQo+ICAJc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiA9IHBsYXRm
b3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiAgCXN0cnVjdCBtYWNiICpicCA9IG5ldGRldl9wcml2
KG5ldGRldik7DQo+ICsJc3RydWN0IG1hY2JfcXVldWUgKnF1ZXVlID0gYnAtPnF1ZXVlczsNCj4g
Kwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArCXVuc2lnbmVkIGludCBxOw0KPiArDQo+ICsJaWYg
KCFuZXRpZl9ydW5uaW5nKG5ldGRldikpDQo+ICsJCXJldHVybiAwOw0KPiAgDQo+IC0JbmV0aWZf
Y2Fycmllcl9vZmYobmV0ZGV2KTsNCj4gLQluZXRpZl9kZXZpY2VfZGV0YWNoKG5ldGRldik7DQo+
ICANCj4gIAlpZiAoYnAtPndvbCAmIE1BQ0JfV09MX0VOQUJMRUQpIHsNCj4gIAkJbWFjYl93cml0
ZWwoYnAsIElFUiwgTUFDQl9CSVQoV09MKSk7DQo+ICAJCW1hY2Jfd3JpdGVsKGJwLCBXT0wsIE1B
Q0JfQklUKE1BRykpOw0KPiAgCQllbmFibGVfaXJxX3dha2UoYnAtPnF1ZXVlc1swXS5pcnEpOw0K
PiArCQluZXRpZl9kZXZpY2VfZGV0YWNoKG5ldGRldik7DQo+ICsJfSBlbHNlIHsNCj4gKwkJbmV0
aWZfZGV2aWNlX2RldGFjaChuZXRkZXYpOw0KPiArCQlmb3IgKHEgPSAwLCBxdWV1ZSA9IGJwLT5x
dWV1ZXM7IHEgPCBicC0+bnVtX3F1ZXVlczsgKytxLCArK3F1ZXVlKQ0KPiArCQkJbmFwaV9kaXNh
YmxlKCZxdWV1ZS0+bmFwaSk7DQo+ICsJCXBoeV9zdG9wKGJwLT5waHlfZGV2KTsNCg0KSGkgSGFy
aW5pLA0KDQpJIGFwcGxpZWQgdGhlc2UgcGF0Y2hlcyBvbiBuZXQtbmV4dC9tYXN0ZXIgY2xvbmVk
IGZyb20gWzFdLCB1cGRhdGVkIHRoaXMNCm1vbWVudCwgYnV0IEkgZG9uJ3QgaGF2ZSBhIHBoeV9k
ZXYgbWVtYmVyIGluIHN0cnVjdCBtYWNiLiBNYXliZSB5b3Ugd2FudGVkDQp0byB1c2UgbmV0ZGV2
LT5waHlkZXYgPw0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQpbMV0gaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZGF2ZW0vbmV0LW5leHQuZ2l0
DQoNCj4gKwkJcGh5X3N1c3BlbmQoYnAtPnBoeV9kZXYpOw0KPiArCQlzcGluX2xvY2tfaXJxc2F2
ZSgmYnAtPmxvY2ssIGZsYWdzKTsNCj4gKwkJbWFjYl9yZXNldF9odyhicCk7DQo+ICsJCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmJwLT5sb2NrLCBmbGFncyk7DQo+ICAJfQ0KPiAgDQo+ICsJbmV0
aWZfY2Fycmllcl9vZmYobmV0ZGV2KTsNCj4gKwlpZiAoYnAtPnB0cF9pbmZvKQ0KPiArCQlicC0+
cHRwX2luZm8tPnB0cF9yZW1vdmUobmV0ZGV2KTsNCj4gIAlwbV9ydW50aW1lX2ZvcmNlX3N1c3Bl
bmQoZGV2KTsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiBAQCAtNDI2Nyw2ICs0Mjg0LDExIEBAIHN0
YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbWFjYl9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiAgCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19wbGF0Zm9ybV9kZXZpY2UoZGV2
KTsNCj4gIAlzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEo
cGRldik7DQo+ICAJc3RydWN0IG1hY2IgKmJwID0gbmV0ZGV2X3ByaXYobmV0ZGV2KTsNCj4gKwlz
dHJ1Y3QgbWFjYl9xdWV1ZSAqcXVldWUgPSBicC0+cXVldWVzOw0KPiArCXVuc2lnbmVkIGludCBx
Ow0KPiArDQo+ICsJaWYgKCFuZXRpZl9ydW5uaW5nKG5ldGRldikpDQo+ICsJCXJldHVybiAwOw0K
PiAgDQo+ICAJcG1fcnVudGltZV9mb3JjZV9yZXN1bWUoZGV2KTsNCj4gIA0KPiBAQCAtNDI3NCw5
ICs0Mjk2LDIxIEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbWFjYl9yZXN1bWUoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiAgCQltYWNiX3dyaXRlbChicCwgSURSLCBNQUNCX0JJVChXT0wpKTsN
Cj4gIAkJbWFjYl93cml0ZWwoYnAsIFdPTCwgMCk7DQo+ICAJCWRpc2FibGVfaXJxX3dha2UoYnAt
PnF1ZXVlc1swXS5pcnEpOw0KPiArCX0gZWxzZSB7DQo+ICsJCW1hY2Jfd3JpdGVsKGJwLCBOQ1Is
IE1BQ0JfQklUKE1QRSkpOw0KPiArCQlmb3IgKHEgPSAwLCBxdWV1ZSA9IGJwLT5xdWV1ZXM7IHEg
PCBicC0+bnVtX3F1ZXVlczsgKytxLCArK3F1ZXVlKQ0KPiArCQkJbmFwaV9lbmFibGUoJnF1ZXVl
LT5uYXBpKTsNCj4gKwkJcGh5X3Jlc3VtZShicC0+cGh5X2Rldik7DQo+ICsJCXBoeV9pbml0X2h3
KGJwLT5waHlfZGV2KTsNCj4gKwkJcGh5X3N0YXJ0KGJwLT5waHlfZGV2KTsNCj4gIAl9DQo+ICAN
Cj4gKwlicC0+bWFjYmdlbV9vcHMubW9nX2luaXRfcmluZ3MoYnApOw0KPiArCW1hY2JfaW5pdF9o
dyhicCk7DQo+ICsJbWFjYl9zZXRfcnhfbW9kZShuZXRkZXYpOw0KPiAgCW5ldGlmX2RldmljZV9h
dHRhY2gobmV0ZGV2KTsNCj4gKwlpZiAoYnAtPnB0cF9pbmZvKQ0KPiArCQlicC0+cHRwX2luZm8t
PnB0cF9pbml0KG5ldGRldik7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo=
