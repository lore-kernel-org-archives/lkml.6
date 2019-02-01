Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6977C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A95920815
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="eip4Ux5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfBAIzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:55:52 -0500
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:11424
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbfBAIzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvlfNi4TvvDDFEwIyvhOSFdf2Wb2HLaSp/m4JDG782U=;
 b=eip4Ux5GEyh8uc5pDsItbPNXWgFa8YV7ba+KO+dAR6QoPAUnZcgJWFTLk7xZl/ANf//eYn/bVHmaDFBchfoGMAIRTJ5C3yv7mbZjY1IijhfdATbLHjoWUVYuPL0XrtlmSW8viRgsxBkIcnCvGgqIErCKmAxfGtvcGbdlJxpiwaY=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB4536.eurprd03.prod.outlook.com (20.177.32.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Fri, 1 Feb 2019 08:55:47 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7%2]) with mapi id 15.20.1558.026; Fri, 1 Feb 2019
 08:55:47 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] drm/xen-front: Drop pointless static qualifier in
 fb_destroy()
Thread-Topic: [PATCH -next] drm/xen-front: Drop pointless static qualifier in
 fb_destroy()
Thread-Index: AQHUtW60TrLIk68W5Eusgo0RNwKK2qXEPKMAgAZwV4A=
Date:   Fri, 1 Feb 2019 08:55:47 +0000
Message-ID: <abc50111-8924-dbfa-9f5d-16f102f30cac@epam.com>
References: <1548504338-114487-1-git-send-email-yuehaibing@huawei.com>
 <4c371af3-8856-39a7-d06e-6b55749567e5@epam.com>
In-Reply-To: <4c371af3-8856-39a7-d06e-6b55749567e5@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB4536;6:hgnh7UghY1eumUHEFSk0vlwUNRCZ74iK5Q8Y8X74xxgk2Vy4RF/c0iCA5q2fFC2K+Wgk11zxGXoJTQcfEBPe9tRJnCdg+iiGQ7bD3LHLL8b6xXMvNcBKtwaAQARTOi0VYZfdQUqHMHk9LiXp/jqPod4/1XmE8rqTPuEnE9y+/dWHf0BPPcMvVln1yX1mHiWQuvNlPu6CAO+LD/IANfstVIktV3cfAvliNFDhUHOAj9/WxkyTbQEkXXJIPZitjp6eX1dWCSxeZZJm+CVUPclLGkhSB7NOro7OBx81ZLLc+7IyyWfSoGndy0G5sPArB08DAyGPv8+LIz8BVe/e0fbAN4LMLW0cLSF3UNNP5ZNmZ6oFM1u2jPfuYYLbEB+dd2q1I6xKvple++Gt6ROVVUtMmpleYMhhuDU1L6EXOeHMHPOJUI2+Xbv4ga/PaeKmibZIRJSoRuEGakbDrhopGPdtQA==;5:JrMzJZEvmz2SgOTis9dHbZ2BCT9ifsV8+lYm30PuLzOK1ei6XqtvEEOxQ8k6YGC0ARZA14BPdV/olOktDzL0dU/NnujM+hHigDm2feJEBW0eq9KFQv/vAkL7lxN4GTFUG6HPtOLPDchOuKBYzvAXabVun12N8iMuheZwtQBLC8kWUUuMKsYqpMBIX6E4Hbl+6UOogtOsh/xNiESPeRO2nQ==;7:ZHaCClmT0XjpcOha5etN7Z1olqiy5EiUu9plDggN4VNdF8PB8Toh7wDG40uYMLTVlQQED7qz7z6PZEm61OR85uQIBNHQcPQ4AYiWvh9PVsgy/f5Mjjc17Ost6X1+wVn5/qh2nO2buTrPi10uLLsBaw==
x-ms-office365-filtering-correlation-id: a8172e49-f40b-464c-afde-08d688230f2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB4536;
x-ms-traffictypediagnostic: AM6PR03MB4536:
x-microsoft-antispam-prvs: <AM6PR03MB4536917C786ECF100C0F9C1AE7920@AM6PR03MB4536.eurprd03.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(136003)(376002)(346002)(199004)(189003)(36756003)(99286004)(3846002)(31696002)(6116002)(86362001)(476003)(54906003)(486006)(6246003)(478600001)(229853002)(446003)(110136005)(8676002)(25786009)(105586002)(106356001)(11346002)(2616005)(14454004)(26005)(81166006)(81156014)(72206003)(53546011)(6506007)(316002)(102836004)(55236004)(66066001)(8936002)(68736007)(186003)(31686004)(76176011)(7736002)(97736004)(4326008)(305945005)(2906002)(256004)(71200400001)(71190400001)(14444005)(6512007)(6486002)(6436002)(80792005)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4536;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qF0VC1KWIoyVwx0u+7LvHtzH0oGsuFrqcoQN+R9TJHS4Sd22XK/2rKt3Hk5imFNb4do5Ek5uynZhxmeUvDwf0sEFj33B7hkCpLJRGcG0RjOLEq1lCe/A+sQbr7e1RzxBOKlcd+vwfQbulcunEJDEBKlIMPnY3xEe9zaxLXpm6m97AHJh1g9QelGOOtnfu2zCpbKiQ5Kov+QVdeVPzLaTDGvQ7xL/1eBacjTj9Q0xZKau9hR9771+wzV8TuhXgjpTmot8kGA3Ndvq1ig8zpD4AprQmAb3jQF9hUJZC1b4+133LulRUeau8ifHU9AP3GPXFAXA8JFgMokNxyEU86h04zlgiTGqo2LRZHoyVAzVlkfKnkUBvpovHQLYUHVMrsqc9Z/1LqDrwh2zXjeMqnnTZbm3X4QYuFOuXj4pDzWxiTI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <627F55A0C668C648BFE3709A3B6726AC@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8172e49-f40b-464c-afde-08d688230f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 08:55:47.8008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4536
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yOC8xOSA4OjM2IEFNLCBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyB3cm90ZToNCj4gT24g
MS8yNi8xOSAyOjA1IFBNLCBZdWVIYWliaW5nIHdyb3RlOg0KPj4gVGhlcmUgaXMgbm8gbmVlZCB0
byBoYXZlIHRoZSAnc3RydWN0IGRybV9mcmFtZWJ1ZmZlciAqZmInIHZhcmlhYmxlDQo+PiBzdGF0
aWMgc2luY2UgbmV3IHZhbHVlIGFsd2F5cyBiZSBhc3NpZ25lZCBiZWZvcmUgdXNlIGl0Lg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCj4g
R29vZCBjYXRjaCwgdGhhbmsgeW91IQ0KPiBSZXZpZXdlZC1ieTogT2xla3NhbmRyIEFuZHJ1c2hj
aGVua28gPG9sZWtzYW5kcl9hbmRydXNoY2hlbmtvQGVwYW0uY29tPg0KSWYgbm9ib2R5IG9iamVj
dHMgSSdsbCBhcHBseSB0aGlzIHRvIGRybS1taXNjLWZpeGVzIG5leHQgTW9uZGF5DQo+PiAtLS0N
Cj4+IMKgIGRyaXZlcnMvZ3B1L2RybS94ZW4veGVuX2RybV9mcm9udF9rbXMuYyB8IDIgKy0NCj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnRfa21zLmMgDQo+
PiBiL2RyaXZlcnMvZ3B1L2RybS94ZW4veGVuX2RybV9mcm9udF9rbXMuYw0KPj4gaW5kZXggODYw
ZGEwNS4uYzI5NTVkMyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZW4veGVuX2Ry
bV9mcm9udF9rbXMuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3hlbi94ZW5fZHJtX2Zyb250
X2ttcy5jDQo+PiBAQCAtNTQsNyArNTQsNyBAQCBzdGF0aWMgdm9pZCBmYl9kZXN0cm95KHN0cnVj
dCBkcm1fZnJhbWVidWZmZXIgKmZiKQ0KPj4gwqDCoMKgwqDCoMKgwqAgY29uc3Qgc3RydWN0IGRy
bV9tb2RlX2ZiX2NtZDIgKm1vZGVfY21kKQ0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
eGVuX2RybV9mcm9udF9kcm1faW5mbyAqZHJtX2luZm8gPSBkZXYtPmRldl9wcml2YXRlOw0KPj4g
LcKgwqDCoCBzdGF0aWMgc3RydWN0IGRybV9mcmFtZWJ1ZmZlciAqZmI7DQo+PiArwqDCoMKgIHN0
cnVjdCBkcm1fZnJhbWVidWZmZXIgKmZiOw0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX2dlbV9v
YmplY3QgKmdlbV9vYmo7DQo+PiDCoMKgwqDCoMKgIGludCByZXQ7DQo+Pg0KPj4NCj4+DQo+Pg0K
Pj4NCg==
