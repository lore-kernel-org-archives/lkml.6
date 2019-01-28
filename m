Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FE5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ECE20882
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="VeaikcuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfA1GgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:36:13 -0500
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:4640
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfA1GgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsqYq1St/JcDADIuYTPOpk9pIf+DCHgrjKl3Ssi9jek=;
 b=VeaikcuYMIiO8kQJOv4pVijUXJ0egUmib3NQwfWT1rZuvzh46Wtuqm2uxEdPowZodD1M9gaxBrfs/gfvpl2l2xUg98njgFCgEBw+FlzAj5iChmhBMQKERVT6iZDJCtxmBh+emjZNCwVq6WXdNna/LY2Ut7gRXgMSxVbQJmV6XCA=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB4101.eurprd03.prod.outlook.com (20.177.38.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Mon, 28 Jan 2019 06:36:08 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7%2]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 06:36:08 +0000
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
Thread-Index: AQHUtW60TrLIk68W5Eusgo0RNwKK2qXEPKMA
Date:   Mon, 28 Jan 2019 06:36:08 +0000
Message-ID: <4c371af3-8856-39a7-d06e-6b55749567e5@epam.com>
References: <1548504338-114487-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1548504338-114487-1-git-send-email-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB4101;6:rkCiF+iFSBHayEKPiamIdo63xz86F9HI+6U6op/x45tWJqAFs8xrGQ4dVAjDzSagopO3TptD6Y6TB+A7MX5AmqmjaxDwcVPry4rjrPwAifio2DxE3sCsKW6+JhLow9SBKwXs9cRyKN2u0UfnsDJbJWO0TLLR4jdMi0Fjd/K2XdNA6b9Jw/mnc+wy9g08YJsKbHcLjFod2kD/RQulrnkNv+ZemBC2osMF7qCtpVwC814tr5hQWV25BX7l5g4qzLWqEv5UvSHRfsH3R4greVdtINC5cJsjrmsTjt5IoTbmnJW+uPjOZqcRoeUcDHeMdPSfdW0MsFgbrHOMGz8LofD3V6G5OWTaZ588U46w7gX4CJ3J4CjiQ/479r3RpyaDEv25o2cmnT+badLQQ4m9m77dKw+GzL2XOr6N2ZJ/eVU5B/oxRkpxjpKXHVbXR6CfSy03sTKH0DmdrYWV7fPre73Kpw==;5:BDE9TAdmdkvv1H9YdrPCWtr+W1PIRvJFFJ2OFoMgRe0Hy4Q9VLlTksUBSFZGazSesN+eGA6OVFwjCgWKxPmysph7STCsj249VIQvshekbTo1bF0qLKb03qNSdw8rUgW9YTK2SNkLXScef4lLrUJseEnZ3n4rYCscy0SKT4kJ/1Gqev81jK/tz7FFm16IPikARDDgmzWeZgdLctfCNh061w==;7:t/olj9Ytz+YaZDYgpQFTzMbaaPj4kpQ+gC+FGq1O7G9JlKhTsIg6HCMTGrxTtZm7dMhGZevuKZCgqUTHMsMSNmlU/nqNhlioxR6iD97LiZ1nQwUk9SUOuoHI1TheVCqm+gILprmhg8JIHEalnfpJtg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9ce63b53-0559-418e-b3b5-08d684eae31c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB4101;
x-ms-traffictypediagnostic: AM6PR03MB4101:
x-microsoft-antispam-prvs: <AM6PR03MB41019CFDDA7F893EF33E0C47E7960@AM6PR03MB4101.eurprd03.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(8676002)(4326008)(7736002)(80792005)(6246003)(6486002)(186003)(478600001)(36756003)(31696002)(68736007)(97736004)(6512007)(256004)(14444005)(6436002)(4744005)(229853002)(8936002)(305945005)(71190400001)(71200400001)(25786009)(81156014)(81166006)(53936002)(76176011)(486006)(446003)(6506007)(476003)(86362001)(2616005)(11346002)(110136005)(54906003)(72206003)(102836004)(14454004)(105586002)(2906002)(106356001)(66066001)(99286004)(6116002)(3846002)(316002)(55236004)(31686004)(26005)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4101;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s7rNh5vWdOTBwh9IAK6nFaYgZgndjdP51ElGrj0CsfJZra3O6wFrpVxHJxZN3aQr+OUaAChV7ofmwEYk0yDM61OLnkiW8V14J04qEsQwJwyigJwekECiUSZcYzj5SDN3TeFHsGaBNjZuMgDeaY5rVfR7JW2NNB+7/hYFlSG7BjpmLZVY0EXSai3AmA7hOPh6QA/2zc43Xg3uf6C/E1IIVdMRt7+3/cnMWtSllZ5KhD7RTPFqa8whzCdExJeCZf6VPfEuXSk+w9ZJh7CnQEm3n4gCMIL7jcTCVqA72Cu/hRg9oLthijHnk4uN6+zNcbAm9WArT9X/0laxzCmepZ4JfEBHTv0XBwSzE+fx/oJ2PPcj1H9On+Pv/IoFK45RzVnzFbQ6xw9S8MA4aWHjx+Rhe/NG3qWxiTfkfCys+JvRoVI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <221780DB5666A6408C5CCE91CF0BE7C5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce63b53-0559-418e-b3b5-08d684eae31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 06:36:08.6245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yNi8xOSAyOjA1IFBNLCBZdWVIYWliaW5nIHdyb3RlOg0KPiBUaGVyZSBpcyBubyBuZWVk
IHRvIGhhdmUgdGhlICdzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYicgdmFyaWFibGUNCj4gc3Rh
dGljIHNpbmNlIG5ldyB2YWx1ZSBhbHdheXMgYmUgYXNzaWduZWQgYmVmb3JlIHVzZSBpdC4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KR29v
ZCBjYXRjaCwgdGhhbmsgeW91IQ0KUmV2aWV3ZWQtYnk6IE9sZWtzYW5kciBBbmRydXNoY2hlbmtv
IDxvbGVrc2FuZHJfYW5kcnVzaGNoZW5rb0BlcGFtLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9n
cHUvZHJtL3hlbi94ZW5fZHJtX2Zyb250X2ttcy5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL3hlbi94ZW5fZHJtX2Zyb250X2ttcy5jIGIvZHJpdmVycy9ncHUvZHJtL3hlbi94
ZW5fZHJtX2Zyb250X2ttcy5jDQo+IGluZGV4IDg2MGRhMDUuLmMyOTU1ZDMgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS94ZW4veGVuX2RybV9mcm9udF9rbXMuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnRfa21zLmMNCj4gQEAgLTU0LDcgKzU0LDcgQEAg
c3RhdGljIHZvaWQgZmJfZGVzdHJveShzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYikNCj4gICAJ
ICBjb25zdCBzdHJ1Y3QgZHJtX21vZGVfZmJfY21kMiAqbW9kZV9jbWQpDQo+ICAgew0KPiAgIAlz
dHJ1Y3QgeGVuX2RybV9mcm9udF9kcm1faW5mbyAqZHJtX2luZm8gPSBkZXYtPmRldl9wcml2YXRl
Ow0KPiAtCXN0YXRpYyBzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYjsNCj4gKwlzdHJ1Y3QgZHJt
X2ZyYW1lYnVmZmVyICpmYjsNCj4gICAJc3RydWN0IGRybV9nZW1fb2JqZWN0ICpnZW1fb2JqOw0K
PiAgIAlpbnQgcmV0Ow0KPiAgIA0KPg0KPg0KPg0KPg0KPg0K
