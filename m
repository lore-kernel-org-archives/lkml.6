Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485630-2-17131693629864365691
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485629; b=SvLhib5J1A43RZcrakygiqnbNCyLSb+7rpUaoqd/GHDNNHC
    SR2WXEtaK7E97RrqDgBk79Mdg+cMV+0oErrmdx0qDYqtzEIwUh25geUpTIdQ36iv
    tEz9qjA4DiW2wJz/Mf/RcgQHCtbkyBwnkKECgnu0es+geGE1zSAc2IUefAYJQVPf
    bu/0OHoun+kq0JJAXBjuUzJDMJsG4JgOHgtsGQIzRs5H6f8rK4XjASsHeTnv82ZM
    qGd8bx8GyZ5VvvPfQG7UsNyjQ4ooKa64NZ6N+kYCk3VsR9z2o0Cpr2DG7VOuvCFy
    zli8hPnohzQGjqeWCSc8wKjZF+btjurGdoJ1sIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485629; bh=PJoFwZ
    1TQjiQWmsaFIgZ1+zLr6yEMcsNHOn3gXyu+fU=; b=RaZxGzvenyrjLzh5dqd/ce
    QnV9CUHHjKBTwsvJei3Bl7unB0hBj0NJB5z8eWpVFYTIiDSWqBLtdkR27oB3ZgXy
    GT8bIYjZFuWitR+WNQxHfA81DCSF+Uj2lNz446NWqGXhGSGt8wyj9qnL/QGeOzdU
    IcOaQ71hRLYfu/Q1WrjJVNJ9UmPlxXDcs1KnVLt3QE56Clb05x26fPONeDvGQesu
    5qLykBkJ3DLY9v908LD90rLdQeHV7Sy1RLGYM3Z3c2SniathEvu2K7R+jmYGYRq4
    DcFLP8aoY9yEKif1n19EuKQ+U8UTIc62cyAnAZs7W7ONgxS2VnGREp3C2aYWmXNQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DQnoSfJ1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DQnoSfJ1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966521AbeCHFHG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:07:06 -0500
Received: from mail-cys01nam02on0096.outbound.protection.outlook.com ([104.47.37.96]:45952
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966507AbeCHFHD (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 072/101] sm501fb: don't return zero on failure
 path in sm501fb_start()
Thread-Topic: [PATCH AUTOSEL for 4.4 072/101] sm501fb: don't return zero on
 failure path in sm501fb_start()
Thread-Index: AQHTtpqYiS59GkjL0kCWKuB5D26oNA==
Date: Thu, 8 Mar 2018 05:02:02 +0000
Message-ID: <20180308050023.8548-72-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;7:zD8xRYN7qN0/sig5p2JQZvq3VVN7pCX5O/JQxFuuucq117OwTupL61ZiViPydtL1FzHgPrJ5IkD+xRRoUPGpCTHNXJm0p5FH3XfhQOvtU+kViem0YmTZOZGWu0tqQ4dQkxpqT5R3mrDW50odi1kDRrt43GvOIUHN9SMa7OErdmZIKs3qbwVVPT44pcl82OIkuA+syBQr9potxj6Tw856VKvwmKIXN1pDSaL7J9CXnHK/lfFsAExxtVuSj97cCQZf;20:CJXV9iTNrYx12wZJ7dlTswg9pK5ed3NBBONzn0Ls5mrHyFqsfKaJeTL2m3cJBt9jB/zC5q11F33IexrFFf58Er7VM1Zvw8lT/RjzOGyhfYKl3yff+KUjKMxzvTVPV2qNlILIZJdjMFw3b66UCk0lwf/4sXkj0kRUMADCpdJ0IRg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a28e2d6a-460a-4c33-bd41-08d584b26d31
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1016504823F7CB19851B4CD2FBDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(3660700001)(10290500003)(14454004)(25786009)(478600001)(53936002)(5660300001)(6436002)(6486002)(68736007)(110136005)(54906003)(316002)(6512007)(105586002)(22452003)(3280700002)(2900100001)(3846002)(6116002)(72206003)(4326008)(2906002)(59450400001)(6506007)(102836004)(86612001)(1076002)(36756003)(76176011)(4477795004)(26005)(186003)(107886003)(2950100002)(7736002)(97736004)(8676002)(99286004)(5250100002)(8936002)(81166006)(81156014)(86362001)(305945005)(2501003)(575784001)(66066001)(106356001)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 4SKAYKVVSQMZdrUGAdyretZRn8Wy0UIzfMaikgs87fXmbUfm/Ae7PHoF2IY4kljNO//CrJ3+UrTjtsUWEYRc17QmN10gIR3WfAYX92jGuwJ8RSfw3/6rqlzsNhMA/D0iJS61PE+56pwRHADbWBxg2jgLYfVkCn7K0DFrc5dlgEiLCwk3cpLBj9NahecE0Mgkuu1cJdUTVzwjSflp5fP2FpA0YsbsJXG3PHjtRea6Ru9fKs2C3fsDhaHtQ/43mpZtIH4JTXcp6CP9LNcpKJt8EH8qCVtW3XI11EgRGdkkyuIv/+35Fq6UoqkHDURYKS9JOvxJYtr2v1yOQytkSoWnXg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28e2d6a-460a-4c33-bd41-08d584b26d31
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:02.2609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit dc85e9a87420613b3129d5cc5ecd79c58351c546 ]

If fbmem iomemory mapping failed, sm501fb_start() breaks off
initialization, deallocates resources, but returns zero.
As a result, double deallocation can happen in sm501fb_stop().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/sm501fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index d0a4e2f79a57..d215faacce04 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1600,6 +1600,7 @@ static int sm501fb_start(struct sm501fb_info *info,
 	info->fbmem =3D ioremap(res->start, resource_size(res));
 	if (info->fbmem =3D=3D NULL) {
 		dev_err(dev, "cannot remap framebuffer\n");
+		ret =3D -ENXIO;
 		goto err_mem_res;
 	}
=20
--=20
2.14.1
