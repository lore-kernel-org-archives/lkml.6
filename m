Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2F0C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A1F207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="FzqN+pY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfA2I2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:28:48 -0500
Received: from mail-eopbgr10092.outbound.protection.outlook.com ([40.107.1.92]:3460
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfA2I2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPaTnzksf2FWVaGTJS+KgiTrTOFX7dyE0rK3IKC7mL0=;
 b=FzqN+pY3gvKyoBB/oabhWbCl9dw1Yxf0VPBmsR7Hs4B2AooauibM/QnJs7w+HHdkArhySYj0N7ZgVFQADJssXk5/e+/8kJ5QKtwIC21xftQ+K5KzruIOEl8oep02tE81IargqNztS2JYoSIRNl6pYzQM4LAiNzZritMX4avxeqY=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB1533.EURPRD10.PROD.OUTLOOK.COM (10.166.146.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 08:28:43 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b%5]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:28:43 +0000
From:   Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/msm: fix building with DEBUG_FS=n
Thread-Topic: [PATCH] drm/msm: fix building with DEBUG_FS=n
Thread-Index: AQHUrOl+xwuNZRmmj0O0KiKEkWsM8KXF/3MA
Date:   Tue, 29 Jan 2019 08:28:42 +0000
Message-ID: <f2656698-a4ca-06c7-2d1c-8719f5ed8ebc@prevas.se>
References: <20190115154620.17964-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190115154620.17964-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::12) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR10MB1533;6:AxOZM9uoJWFNl4roocO58V6swA6JSp/sFrr0CYE5g51dtITfuwnBaaV2W2lVsbF/f9UBfMkLCpXvBrDMzOytiyCGdVqCfz5ZBO7ByZkjkXZAQgovomhxmBrqaGRVW7xPK5TXgHEfbyFcMiJN9uE4iHt0+mtT5nkRQae58UD9AkbUIMCZ0fNdrDRJz/6HUN9V7cc3DPqigjczp1KyWUZ3b7xHFN1ZkOwFgT3cgu9x2xN+iFvjBIgp2VX/MqjM4pJIv74GeJiuA/rhgX9JRV12Yhu8PGEL092MWuNDjXulalc3hHaCYZKaJdntXaOicm2KRIM6O/FH+eTukkCML98RZ7ZTEnBwwHC663v9OkhasDf0L3lawS9t//Ni1p5KhBcuPk+sEJN09A1vCuoXeTNHiqBp+Tk3Ddy58eFwY/wDCIO+gc8nAYBCC1sdXY5fkccDywkv8oMKEKN9gABNs+pJEQ==;5:24Pt4W2y59PJ8CF39yqOjV4UuVWg19HEcr3EO4CWivYJUr/MTu9VifMDXZ/gVy6QHLxtUFe+pJvZ4nnEAcIO4fK/e2M+vfsvaXWbadXsFuJR1/RApdYy4dhUh7K72i7UjdKmBV9ttK4p73hyeXhzqjAcIefFkUHxDdJ5earC8gSVk4p1CPkjJoj8d02ZW0r2bOjVHm+OGs6HbOtJR+RzRA==;7:gKkDiPuGQwS/xvQ9F/glgBsXJwgF89xpnMo++tzU4MQIVdIMf4BiBFfdfog4hz425aHzy0jS/moYJf1O/oJEVc0qsDqh1rGx+DquLrkOjIvBONPFXav40n0IH3N8fwoznzaR/1wfSC/P4HtduZiOTQ==
x-ms-office365-filtering-correlation-id: 9b7f9280-ccf7-43ce-f296-08d685c3c73b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1533;
x-ms-traffictypediagnostic: VI1PR10MB1533:
x-microsoft-antispam-prvs: <VI1PR10MB153335C73568A2A199C9B7058A970@VI1PR10MB1533.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(376002)(39850400004)(199004)(189003)(486006)(97736004)(102836004)(316002)(53936002)(81156014)(81166006)(68736007)(8676002)(31686004)(6512007)(105586002)(305945005)(52116002)(36756003)(2616005)(6506007)(4326008)(386003)(44832011)(8936002)(11346002)(76176011)(6246003)(106356001)(476003)(446003)(7736002)(256004)(2906002)(14454004)(99286004)(186003)(6116002)(26005)(229853002)(72206003)(478600001)(3846002)(66066001)(25786009)(110136005)(31696002)(71200400001)(6436002)(74482002)(71190400001)(54906003)(86362001)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB1533;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EHTAMzmneM3alPgMp+5EdnEg8ZPVxitUgyaxnO3eey+iUs6SSjQ7L2vpGKOqNtzJoL5mLcOLA0iQUFfYdYYoS1BuMJIY0GIx6w3+ecpgz25272OrobfR7GrbMV1krZCzWel9EjU8ppn2Gw0HoTxXMwUGycYH01/rftacvsfsVUDEct7mi7X5nIjr1Qp+7N2i5SVYZrbkT5IergYOQmBt/Lo2B4yCiNXm64K2Jn9bLaaPEbxVkWeTrOcF2XhJXjJ9na1lOmRkXkHBCa1M/bENIycPUHdJ5j5DxMeMOo5C8KmenipyJIOlvcLxNr8hwu64wGPQ/jSZOJoDAyrygZpfogh2ZO6gn2J4SBnoE+n4fC3WnsVUR9B9XraHgEzUmBbsVe3F+sjwwMunBjhTG6lX2ukRE9EMBd9yb+B1/1YMBSY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1FF602AEA431647996323B203580C27@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7f9280-ccf7-43ce-f296-08d685c3c73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:28:42.2371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cGluZw0KDQpPbiAxNS8wMS8yMDE5IDE2LjQ2LCBSYXNtdXMgVmlsbGVtb2VzIHdyb3RlOg0KPiBX
aXRoIENPTkZJR19ERVZfQ09SRURVTVA9eSBhbmQgQ09ORklHX0RFQlVHX0ZTPW4sIGJ1aWxkaW5n
IGZhaWxzOg0KPiANCj4gZHJpdmVycy9ncHUvZHJtL21zbS9hZHJlbm8vYTJ4eF9ncHUuYzo0Mjg6
NDogZXJyb3I6IOKAmHN0cnVjdCBtc21fZ3B1X2Z1bmNz4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg
4oCYc2hvd+KAmQ0KPiAgICAuc2hvdyA9IGFkcmVub19zaG93LA0KPiAgICAgXn5+fg0KPiBkcml2
ZXJzL2dwdS9kcm0vbXNtL2FkcmVuby9hMnh4X2dwdS5jOjQyODoxMTogZXJyb3I6IGluaXRpYWxp
emF0aW9uIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSBbLVdlcnJvcj1pbmNvbXBhdGli
bGUtcG9pbnRlci10eXBlc10NCj4gICAgLnNob3cgPSBhZHJlbm9fc2hvdywNCj4gICAgICAgICAg
ICBefn5+fn5+fn5+fg0KPiBkcml2ZXJzL2dwdS9kcm0vbXNtL2FkcmVuby9hMnh4X2dwdS5jOjQy
ODoxMTogbm90ZTogKG5lYXIgaW5pdGlhbGl6YXRpb24gZm9yIOKAmGZ1bmNzLmJhc2UuZ3B1X2J1
c3nigJkpDQo+IGNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0KPiAN
Cj4gRml4ZXM6IGMwZmVjN2Y1NjJlYzcgKGRybS9tc20vZ3B1OiBDYXB0dXJlIHRoZSBHUFUgc3Rh
dGUgb24gYSBHUFUgaGFuZykNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2NC4xOSsN
Cj4gU2lnbmVkLW9mZi1ieTogUmFzbXVzIFZpbGxlbW9lcyA8cmFzbXVzLnZpbGxlbW9lc0BwcmV2
YXMuZGs+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21zbS9tc21fZ3B1LmggfCA2ICsrKyst
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbXNtL21zbV9ncHUuaCBiL2RyaXZlcnMv
Z3B1L2RybS9tc20vbXNtX2dwdS5oDQo+IGluZGV4IGVmYjQ5YmI2NDE5MS4uNGNiNDFkYjdmOWU4
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbXNtL21zbV9ncHUuaA0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vbXNtL21zbV9ncHUuaA0KPiBAQCAtNjMsMTAgKzYzLDEyIEBAIHN0cnVj
dCBtc21fZ3B1X2Z1bmNzIHsNCj4gIAlzdHJ1Y3QgbXNtX3JpbmdidWZmZXIgKigqYWN0aXZlX3Jp
bmcpKHN0cnVjdCBtc21fZ3B1ICpncHUpOw0KPiAgCXZvaWQgKCpyZWNvdmVyKShzdHJ1Y3QgbXNt
X2dwdSAqZ3B1KTsNCj4gIAl2b2lkICgqZGVzdHJveSkoc3RydWN0IG1zbV9ncHUgKmdwdSk7DQo+
IC0jaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+IC0JLyogc2hvdyBHUFUgc3RhdHVzIGluIGRlYnVn
ZnM6ICovDQo+ICsjaWYgZGVmaW5lZChDT05GSUdfREVCVUdfRlMpIHx8IGRlZmluZWQoQ09ORklH
X0RFVl9DT1JFRFVNUCkNCj4gKwkvKiBzaG93IEdQVSBzdGF0dXMgaW4gZGVidWdmcyBvciBkZXZp
Y2UgY29yZWR1bXA6ICovDQo+ICAJdm9pZCAoKnNob3cpKHN0cnVjdCBtc21fZ3B1ICpncHUsIHN0
cnVjdCBtc21fZ3B1X3N0YXRlICpzdGF0ZSwNCj4gIAkJCXN0cnVjdCBkcm1fcHJpbnRlciAqcCk7
DQo+ICsjZW5kaWYNCj4gKyNpZmRlZiBDT05GSUdfREVCVUdfRlMNCj4gIAkvKiBmb3IgZ2VuZXJh
dGlvbiBzcGVjaWZpYyBkZWJ1Z2ZzOiAqLw0KPiAgCWludCAoKmRlYnVnZnNfaW5pdCkoc3RydWN0
IG1zbV9ncHUgKmdwdSwgc3RydWN0IGRybV9taW5vciAqbWlub3IpOw0KPiAgI2VuZGlmDQo+IA0K
DQo=
