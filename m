Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376C6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9BC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="prGJxfED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbfAPFfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:35:19 -0500
Received: from mail-eopbgr740081.outbound.protection.outlook.com ([40.107.74.81]:53304
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfAPFfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIjYGMro4/jFmxz8owRhYmpF84DTkxFRfI8RtcNNx30=;
 b=prGJxfEDk3qIgP3Rgiw6L+EUDLg5ZILFIC2TzfOwRitJ2SoFFEbljU+OXUo//lmsa1hN2+UpssbEMJsf4QwEemWwj1bPVjkrn9f59Mmx+mHKUHXofCHwCzinUPZYDAEh9WwwAhjArDjV+PxNLo6V34WEJ8NMBfJmLbnyviSxi5s=
Received: from BYAPR05MB5592.namprd05.prod.outlook.com (20.177.186.153) by
 BYAPR05MB4613.namprd05.prod.outlook.com (52.135.233.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.8; Wed, 16 Jan 2019 05:35:06 +0000
Received: from BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::4a1:2561:2487:5919]) by BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::4a1:2561:2487:5919%4]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 05:35:05 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "syeh@vmware.com" <syeh@vmware.com>,
        "airlied@linux.ie" <airlied@linux.ie>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] drm/vmwgfx: Remove set but not used variable 'srf'
Thread-Topic: [PATCH -next] drm/vmwgfx: Remove set but not used variable 'srf'
Thread-Index: AQHUrT3B7duoF6ap7kSnMariygLoaqWxX/gA
Date:   Wed, 16 Jan 2019 05:35:05 +0000
Message-ID: <fa71970ceec73faff082008820389a9ad1a8f5be.camel@vmware.com>
References: <1547603735-148124-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1547603735-148124-1-git-send-email-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4613;20:hZ21HC7eIjGcDvuLiE23EBRq6geJJSojG/nF2nCRF4ZVPMbKBLrRcyDytZF7fDwbBe7Y851SMxb+GFMtU3gjreLSN4VF/LNncZrMoom5zkMoxMB4wAJc7Kq/HzTvzLtuaGqc1z0XHytZ4AbqLqb812pyNtIdeSbEhoBiEM4HeNU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8330cf8f-8e27-4aa5-76cb-08d67b745eb7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4613;
x-ms-traffictypediagnostic: BYAPR05MB4613:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB4613D601DE3845293908B042A1820@BYAPR05MB4613.namprd05.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(66066001)(25786009)(2906002)(71200400001)(118296001)(14454004)(478600001)(71190400001)(99286004)(2501003)(110136005)(316002)(54906003)(3846002)(6116002)(36756003)(6246003)(4326008)(6486002)(86362001)(6512007)(229853002)(102836004)(53936002)(6436002)(2201001)(6506007)(76176011)(106356001)(486006)(68736007)(26005)(186003)(256004)(14444005)(97736004)(5660300001)(8936002)(11346002)(7736002)(2616005)(81166006)(81156014)(446003)(305945005)(476003)(105586002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4613;H:BYAPR05MB5592.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aMYYQkS2paJoM6jFo4V8iZykXnr6Nb7ZOU1xqmYcyN6WoSgY4nOfTmYfAohEYPGAQJ7KOn3UtIArW3UNqmotWc0sAlHkBL2xmC7r/SlQx219isZfbxJbhJIQbMo+lvwg1SpyAz7mS0j4E3ZFRa1T0+ERBVHgasZDAOap73VrJT9GMk5YM+sBHBnSfqztnPK8JqFJzUlzJfqqnT6u7ZjefGj5oENhbOA2tx6HiFNPcxmWct9oVTH4VwbwLaTxQvjG1LezJRAA1zODcZV+Av5oHaatCpRyJga68NKeI4NgTw8JerCE4y4kq+IzAMJMybuXcObhxiB2p6VPXAYnYRmOZ6DhZFQqwwX+9BT8vviOGq0+MKvI8j5us2Kh9FqxxcV1r7xMSTi9EYNJVQWyl6Ve3CSg1fe4YYA2uGIQtQ3I7C8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7152DBF0C7F2A4687F2BAF30045C544@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8330cf8f-8e27-4aa5-76cb-08d67b745eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 05:35:05.4027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4613
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WXVlLA0KDQpUaGFua3MsDQpSZXZpZXdlZC1ieTogVGhvbWFzIEhlbGxzdHJvbSA8dGhlbGxzdHJv
bUB2bXdhcmUuY29tPg0KDQpXaWxsIGluY2x1ZGUgaW4gdGhlIG5leHQgLW5leHQgcHVsbC4NCi9U
aG9tYXMNCg0KDQpPbiBXZWQsIDIwMTktMDEtMTYgYXQgMDE6NTUgKzAwMDAsIFl1ZUhhaWJpbmcg
d3JvdGU6DQo+IEZpeGVzIGdjYyAnLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZScgd2FybmluZzoN
Cj4gDQo+IGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X3N1cmZhY2UuYzogSW4gZnVuY3Rp
b24NCj4gJ3Ztd19od19zdXJmYWNlX2Rlc3Ryb3knOg0KPiBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4
L3Ztd2dmeF9zdXJmYWNlLmM6MzM1OjIyOiB3YXJuaW5nOg0KPiAgdmFyaWFibGUgJ3NyZicgc2V0
IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0NCj4gDQo+IEl0IG5ldmVy
IHVzZWQgc2luY2UgY29tbWl0IDU0MzgzMWNmYzk3NiDDr8K8XiJkcm0vdm13Z2Z4OiBCcmVhayBv
dXQNCj4gc3VyZmFjZSBhbmQNCj4gY29udGV4dCBtYW5hZ2VtZW50IHRvIHNlcGFyYXRlIGZpbGVz
IikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNv
bT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9zdXJmYWNlLmMgfCAy
IC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9zdXJmYWNlLmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vdm13Z2Z4L3Ztd2dmeF9zdXJmYWNlLmMNCj4gaW5kZXggODBhMDFjZC4uM2I2OTc2ZSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfc3VyZmFjZS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X3N1cmZhY2UuYw0KPiBAQCAtMzMy
LDcgKzMzMiw2IEBAIHN0YXRpYyB2b2lkIHZtd19od19zdXJmYWNlX2Rlc3Ryb3koc3RydWN0DQo+
IHZtd19yZXNvdXJjZSAqcmVzKQ0KPiAgew0KPiAgDQo+ICAJc3RydWN0IHZtd19wcml2YXRlICpk
ZXZfcHJpdiA9IHJlcy0+ZGV2X3ByaXY7DQo+IC0Jc3RydWN0IHZtd19zdXJmYWNlICpzcmY7DQo+
ICAJdm9pZCAqY21kOw0KPiAgDQo+ICAJaWYgKHJlcy0+ZnVuYy0+ZGVzdHJveSA9PSB2bXdfZ2Jf
c3VyZmFjZV9kZXN0cm95KSB7DQo+IEBAIC0zNTksNyArMzU4LDYgQEAgc3RhdGljIHZvaWQgdm13
X2h3X3N1cmZhY2VfZGVzdHJveShzdHJ1Y3QNCj4gdm13X3Jlc291cmNlICpyZXMpDQo+ICAJCSAq
Lw0KPiAgDQo+ICAJCW11dGV4X2xvY2soJmRldl9wcml2LT5jbWRidWZfbXV0ZXgpOw0KPiAtCQlz
cmYgPSB2bXdfcmVzX3RvX3NyZihyZXMpOw0KPiAgCQlkZXZfcHJpdi0+dXNlZF9tZW1vcnlfc2l6
ZSAtPSByZXMtPmJhY2t1cF9zaXplOw0KPiAgCQltdXRleF91bmxvY2soJmRldl9wcml2LT5jbWRi
dWZfbXV0ZXgpOw0KPiAgCX0NCj4gDQo+IA0KPiANCg==
