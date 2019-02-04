Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEC6C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAECD20820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="OyGNQXrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfBDG45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 01:56:57 -0500
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:65341
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbfBDG4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 01:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vx3xRrT6iutbmdJqG6g77HT41AnOn5AVoVT4BaDC6oA=;
 b=OyGNQXrXy2Ene+kG9TUfDA2lpEd7ksBKCWpa3RFWIgzgfOE0LfuK8OyTlDj+jeX+UPnw3BGoW2fnHCvSflHhf70/DMG+KVtWn3qV/BqyFBCj3tFgS5aa1uZSFGMUhOd0dYY5rBp35BpYNIIe/Ec0Mrv8eTGa4Ejio6DiIlriotQ=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB5045.eurprd03.prod.outlook.com (20.178.90.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 06:56:52 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7%2]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 06:56:52 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>
Subject: Re: [Xen-devel] [PATCH -next] drm/xen-front: Drop pointless static
 qualifier in fb_destroy()
Thread-Topic: [Xen-devel] [PATCH -next] drm/xen-front: Drop pointless static
 qualifier in fb_destroy()
Thread-Index: AQHUtW60TrLIk68W5Eusgo0RNwKK2qXPQr6A
Date:   Mon, 4 Feb 2019 06:56:51 +0000
Message-ID: <0e7914bf-98e8-654a-83a0-cb59833d9280@epam.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR03MB5045;6:WBnt78jqgvNb3Wf5e2OETGCrFT4y3wggh1K33p7t1uw5S513u7t4/5xPiiHasf+JdVp6mhG7Jqq//c3TH/mes8FOQCHq/iVtT98cBaozNKxepVep9OJ5+QDaL9+U+4NHsgM3NxTnXml7YCiRG+Sij3eOWvrZ3a/7JHL0y1nvok/AC7HgtMYGRN3NRnRzr2lGXlYhf0uns1D9ml53vQQqgD8yIU/dzVYgT0yhwiFl7D5FTk7R84QSJBhG2mZ/uQuqUSQbw1XefP9Yte9mkMNm3C2cIWJGKUhAYPu8xrugzKM/nkHbdR3gOYFQMFoUKui6Oali9fFIVWeSKf10LCvV2yeUObkpAyd5n+HMSRbB014+i+7RNHis/H3o9bCQe0O37532d6yEHjYqYhcXTvthzVhbArj6aNgwgWu8jajcso9SW7nL5NTAk20W1a9cKcJgH1+U49kPKqUmNfEzttBamA==;5:UlL+Tr+wb0iXONEsR3lEny1FLdegTHt9BQqUu1mBvv5Q/KOIlCaX3XoDl6UhpKcHRF1Ntil4eiY1eVtohWxmeN+K4CWaYBzRksjXKslu4WgILVJw4Ju/fy3VBgZnOM9RXW3EHg/4CDdsneayEtsrDV6VqyDqH/Q3bchq6b568RhH6js4+M+CwpL9dq8wtrzIWbvS8FRDr2EQjr80TNkAfA==;7:PfhZKBFFWRDlSPv/oNG4M4jnvbeWTtlCxQAuN5cm2aQXwYoCt1m3qcaaRuwH1w+To+JhA18c1vusEA7Rcd6jFBlgDKPF9SNR+03CDqN4taWuYPJQPnccIxgtySPTxwXAfavOgIHcCN2y+PIfOvxV2w==
x-ms-office365-filtering-correlation-id: 46b78fad-a477-4d3c-d051-08d68a6df11c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB5045;
x-ms-traffictypediagnostic: AM6PR03MB5045:
x-microsoft-antispam-prvs: <AM6PR03MB504515891E0C586F1DE629DBE76D0@AM6PR03MB5045.eurprd03.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(2616005)(305945005)(31696002)(80792005)(316002)(71190400001)(486006)(446003)(26005)(14454004)(68736007)(476003)(110136005)(54906003)(7736002)(11346002)(4744005)(97736004)(71200400001)(86362001)(36756003)(55236004)(256004)(99286004)(53936002)(8936002)(6486002)(76176011)(14444005)(53546011)(478600001)(102836004)(2906002)(25786009)(6506007)(81166006)(81156014)(72206003)(8676002)(6246003)(6116002)(3846002)(106356001)(6512007)(39060400002)(66066001)(105586002)(6436002)(229853002)(31686004)(4326008)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB5045;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PrdajnZ31f0oCv3199kNHPAZmmdcQdCVRFKlkDzx6AYhgu52+T9P6mwR1coWf5RNG23I+z7TujovOKxgWBColXjthSpJmHSoponvMGjlGJYbNdFsaRvEARye2NEjAgkPrh3QVYJr8FzPBqNnH6jeumlfxUrGdfSi6AuQ+6ZEQn0M5cULp/HyQ+hbSJ41uekwHQwbwsN2jju+6nmx6TlDl6/0UNvhN5FSlicd5IiFBYq4usYoAEBlXnSU6vNaBFk0vw9x6PM/rBJtPI7E2XZViFECbdcFKgtgl8q1lbxyXjKZ4nrDyf9pAdBOkyxFFGKvZW/GwWT4wrYNDi4LmOykvAsgl+3zQT5EyjnkBHZpX7T8+b77H9vmKyutMQFOQlDIUFInfpPesnVbX7IZUwmgcXRUDYbr+kOwiD6MIqzBYis=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0D0D8A274CA424D9F625AC9DD889250@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b78fad-a477-4d3c-d051-08d68a6df11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 06:56:51.9498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yNi8xOSAyOjA1IFBNLCBZdWVIYWliaW5nIHdyb3RlOg0KPiBUaGVyZSBpcyBubyBuZWVk
IHRvIGhhdmUgdGhlICdzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYicgdmFyaWFibGUNCj4gc3Rh
dGljIHNpbmNlIG5ldyB2YWx1ZSBhbHdheXMgYmUgYXNzaWduZWQgYmVmb3JlIHVzZSBpdC4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiAt
LS0NCj4gICBkcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnRfa21zLmMgfCAyICstDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnRfa21zLmMgYi9kcml2
ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnRfa21zLmMNCj4gaW5kZXggODYwZGEwNS4uYzI5
NTVkMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3hlbi94ZW5fZHJtX2Zyb250X2tt
cy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS94ZW4veGVuX2RybV9mcm9udF9rbXMuYw0KPiBA
QCAtNTQsNyArNTQsNyBAQCBzdGF0aWMgdm9pZCBmYl9kZXN0cm95KHN0cnVjdCBkcm1fZnJhbWVi
dWZmZXIgKmZiKQ0KPiAgIAkgIGNvbnN0IHN0cnVjdCBkcm1fbW9kZV9mYl9jbWQyICptb2RlX2Nt
ZCkNCj4gICB7DQo+ICAgCXN0cnVjdCB4ZW5fZHJtX2Zyb250X2RybV9pbmZvICpkcm1faW5mbyA9
IGRldi0+ZGV2X3ByaXZhdGU7DQo+IC0Jc3RhdGljIHN0cnVjdCBkcm1fZnJhbWVidWZmZXIgKmZi
Ow0KPiArCXN0cnVjdCBkcm1fZnJhbWVidWZmZXIgKmZiOw0KPiAgIAlzdHJ1Y3QgZHJtX2dlbV9v
YmplY3QgKmdlbV9vYmo7DQo+ICAgCWludCByZXQ7DQo+ICAgDQpBcHBsaWVkIHRvIGRybS1taXNj
LW5leHQ=
