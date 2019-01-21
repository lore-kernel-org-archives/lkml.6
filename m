Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BB5C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0E520861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BrCO9dSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfAUIkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:40:42 -0500
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:2449
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728085AbfAUIkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw3M2f4c1Zrn0pwvic5yCxdhCM6bboetmdGAbvP8/y0=;
 b=BrCO9dSUYHiradhpiWqXq1y8duV4JBLvj2wrWkFYMltM4XP1iGXLW17p3Oj5nTiMRrfj0JqeCStUQTclstW1ix0LMiIxuD+6gAO4GPYrH/scnq/D5myzFcbn2bOzYijLgBRXQyFqnTrgPFnEZoC7tSgP5WSEXaVONfFz2kFrZ60=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB2102.eurprd08.prod.outlook.com (10.168.86.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Mon, 21 Jan 2019 08:40:37 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 08:40:37 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: drm/komeda: Remove unused variable
Thread-Topic: drm/komeda: Remove unused variable
Thread-Index: AQHUsWT7qbHkB2NzlEKRCJhqfvP0AA==
Date:   Mon, 21 Jan 2019 08:40:37 +0000
Message-ID: <20190121084022.GA20856@james-ThinkStation-P300>
References: <20190118214018.GA24089@embeddedor>
In-Reply-To: <20190118214018.GA24089@embeddedor>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY3PR01CA0090.ausprd01.prod.outlook.com
 (2603:10c6:0:19::23) To DB6PR0801MB1990.eurprd08.prod.outlook.com
 (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB2102;6:K6g7BtGl6MZEBjuA+ZdVgbygm1LOVdX3CFLDawG7q/OmquIv1m40+J4un8C0bLeyVBWnNuQw9Qbg6diqV42vi1iaiyfmkUehGcXYiwFaVidIJDQSumpd2BTwOCZ3nR4lfqs7Pa4va+ZTS9u7v8CpxIEhg0rmKymwVHFKgTDXEGP5z5URLA0iEneyENSNWAs+xOlIvDAhOHIDlMZM0Xu7iVheJZCNA1igb2j5pI4Vn2i9+6RU+Vw4M7/rmcHW1XK101EknVHxR2Vv0mLSAdj6fZVRO3SMJjnCWRNAXTUfFA9CMw45xdVCOPbEAFfk9Wt7bmdyBuAXN2fWsuqSHNpvpYQWx6EA1dgzHhddzRmxVlsQyehL/8EV255TUhbsZ4Dthga7MycfdoudDAHS752XredR/dbrrALlA7ORQP0bdaGhCHDh+zdkXsRfdjElfDNMH1+s2DaL9lsz49nrCFcEcA==;5:zWYefuf9HF1Jc2FIetRMr/QM5VqFyxHNchQMOcx4oJyVMgnrpRG1xycCJpxY7IimN5JVDj7eSBTOhfVjJmU4kp7tJDVcnzBm1VksxJe16wz0MAl1etVA7Jy89MwXZC8MPEkD6hKxjOi9FUTYlzbPs62v5YL0Xqx0PlgZNMdhe78e01gDwzKtYT2ipJDGfY5ufcM8SgkDWKP3hHn82Rgvzw==;7:monkEXPw5cNfcT6l/CXryvVetuL8XFtGdz5XaTmMFMreSPtYW6bEL0imTbR8WlimO46lv5aSjMGmkKQdWO1JpPKksq8ALh9bDPKAEWoKUGltIo4HwCrHTB50M/+0yRP2hDfBM9xXww1axonHtcPeiA==
x-ms-office365-filtering-correlation-id: b67076d3-21de-470b-29b8-08d67f7c1dd9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2102;
x-ms-traffictypediagnostic: DB6PR0801MB2102:
x-microsoft-antispam-prvs: <DB6PR0801MB210268A71EFC6F41DD4AE6F3B39F0@DB6PR0801MB2102.eurprd08.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(136003)(346002)(39850400004)(366004)(376002)(40434004)(189003)(199004)(55236004)(486006)(71200400001)(71190400001)(229853002)(76176011)(106356001)(6916009)(7736002)(305945005)(33656002)(186003)(4326008)(386003)(6506007)(68736007)(33716001)(26005)(6486002)(33896004)(105586002)(6246003)(53936002)(1076003)(25786009)(6436002)(6116002)(102836004)(3846002)(99286004)(66066001)(81166006)(54906003)(2906002)(81156014)(316002)(8936002)(9686003)(6512007)(58126008)(8676002)(256004)(446003)(345774005)(14444005)(5024004)(97736004)(478600001)(14454004)(52116002)(86362001)(11346002)(476003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB2102;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SBT3PL/dznyOK0qUAanoLmCvi+59CRXO0bunj8XtSd1sHNWVbKsP8Ivm4c7k8sz7bGJzxpKdHLgsSlPVfoCbLMEavbHnsCTWov7+D4t+TGrKJoPENfVivrh0EE74RtT8zMSnj9oS+8jDKp1F5FH7GcphDNuXrLRjWi6USddeN1CX+rP9MR/ivd1hJ4v36B8/EMRCZGDX/3hqAhKFa4005p5pON1wgovOMjcmPapDb2g2DHsd9uRtoZSqQSsjswszk76QvrvQtaApdecYuZROyUxFQhJTBdSQX4fU5uws62Xh4KP+60/5M0x219uQgV9jNyACkZvbH6Xp5T9if3HIYZiIDd6m6qDGd9GasUosHX38Iy51zDyIoGu3QIFX9Ct9BEIKMVdvXuFlc+joQUe8huuvgkA+65L8YqO/Q4FxrC0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <707F688609CCB84CBC3A01C2935C3FF1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67076d3-21de-470b-29b8-08d67f7c1dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 08:40:36.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3VzdGF2bzoNCg0KVGhhbmsgeW91IGZvciBoZWxwaW5nIGZpeCB0aGlzIHByb2JsZW0NCg0K
DQpPbiBGcmksIEphbiAxOCwgMjAxOSBhdCAwMzo0MDoxOFBNIC0wNjAwLCBHdXN0YXZvIEEuIFIu
IFNpbHZhIHdyb3RlOg0KPiBSZW1vdmUgdW51c2VkIHZhcmlhYmxlICpwZGV2KiBpbiBrb21lZGFf
cGFyc2VfZHQoKToNCj4NCj4gZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS8va29t
ZWRhX2Rldi5jOiBJbiBmdW5jdGlvbiDigJhrb21lZGFfcGFyc2VfZHTigJk6DQo+IGRyaXZlcnMv
Z3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEvL2tvbWVkYV9kZXYuYzo1MjoyNjogd2FybmluZzog
dW51c2VkIHZhcmlhYmxlIOKAmHBkZXbigJkgWy1XdW51c2VkLXZhcmlhYmxlXQ0KPiAgIHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19wbGF0Zm9ybV9kZXZpY2UoZGV2KTsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICBefn5+DQo+DQo+IEZpeGVzOiA3ZThkNGZjZjhkYWYgKCJk
cm06IGFybS9rb21lZGE6IFJlbW92ZSBJUlEgcGFyc2luZyBmcm9tIGluaXRpYWwgc2VyaWVzIikN
Cj4gU2lnbmVkLW9mZi1ieTogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9y
LmNvbT4NClJldmlld2VkLWJ5OiBKYW1lcyBRaWFuIFdhbmcgKEFybSBUZWNobm9sb2d5IENoaW5h
KSA8amFtZXMucWlhbi53YW5nQGFybS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2Fy
bS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZGV2LmMgfCAxIC0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3Bs
YXkva29tZWRhL2tvbWVkYV9kZXYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21l
ZGEva29tZWRhX2Rldi5jDQo+IGluZGV4IDE2ZjRlNzJhYmMxYS4uMGZlNjk1NGZiYmY0IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9kZXYu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9kZXYu
Yw0KPiBAQCAtNDksNyArNDksNiBAQCBzdGF0aWMgaW50IGtvbWVkYV9wYXJzZV9waXBlX2R0KHN0
cnVjdCBrb21lZGFfZGV2ICptZGV2LCBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPg0KPiAgc3Rh
dGljIGludCBrb21lZGFfcGFyc2VfZHQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qga29tZWRh
X2RldiAqbWRldikNCj4gIHsNCj4gLXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19w
bGF0Zm9ybV9kZXZpY2UoZGV2KTsNCj4gIHN0cnVjdCBkZXZpY2Vfbm9kZSAqY2hpbGQsICpucCA9
IGRldi0+b2Zfbm9kZTsNCj4gIHN0cnVjdCBjbGsgKmNsazsNCj4gIGludCByZXQ7DQpJTVBPUlRB
TlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRz
IGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUg
bm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1l
ZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVy
c29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1h
dGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
