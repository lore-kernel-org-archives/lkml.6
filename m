Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517681878-2-1846758403210003150
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681878; b=MMYQQnLm+7z4wwENaHfCiCs/FV8hvCDK7ZXbuxhNK3QQ3HX
    qWgysu63VFmOl5QXzMzHo6IdsZt6osI3lJjNEqYLBKO9z6BNhn6Z9yPv3Ra3rT2h
    sYeumJYmwKYWdvTcglEKdWQkGfnc/5yF5ZZrGTgANkaCxwaol7UBQwMcStqRlEsN
    SyQPaHcFUCISAf0viAJZGvU23llHsjFpOjOqcuBjixHsjx7+6k0ku2mfIyo9v9ek
    PVHUbspTirEgnbDTZhtMz2ooga19Fpvh/mSQ0iNj2GxRyfbuNKmqi3uj7/q5S157
    L+PC1sk+K/EghJ8IA2aeBoxbDfL8u3xWxee8kqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681878; bh=CuHYFG
    /4imeJNpksSAMg+8jkSP+mXJw2VB4BuydABu8=; b=fsCn/SxH1LX03tmE3VYBjw
    tOdNa8i7qqTIC4rkBIYWU1ih5X3oJCNybFEnSCXp0HjI66K8AAuv/u0BGMg9g+UL
    MWgN5GTktJXChjpnJiuLJV9meR+iEGBaC5J43wCo3Lekrp9gHm/pUay/bYtIVena
    Ra4J2PagSL8/zO/S2CVExtvCByw4z1AbSckjfxnKpCAcV4rJQ8aYjvPkzBFGIcbr
    qB6PiVEQS1zWu305xuDXW2CHyZLN8PL4AoEr/WN/zsO+eUHbj0bbHaRj0hvOaL0w
    nmF67Su+g1Xc1He4OvB1GHojS7xG4RCeNjsUevwGH8KqGmACU69KinuVNL15GKeQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kJ7QGH3h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kJ7QGH3h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbeBCSQq (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:16:46 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:39758
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752914AbeBCSHE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 21/24] xen/gntdev: Fix off-by-one error when
 unmapping with holes
Thread-Topic: [PATCH AUTOSEL for 3.18 21/24] xen/gntdev: Fix off-by-one error
 when unmapping with holes
Thread-Index: AQHTnRmHuNhLl6CN60Cj61sBgP5RQQ==
Date: Sat, 3 Feb 2018 18:05:09 +0000
Message-ID: <20180203180444.10801-21-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1025;7:a5pNsPihjAV0ocamWVncdVT29L/nE2cyEjCii8MYgLhq+GlqFSexPg+EcVeVsZzovelcoEG6fUgYd9g75VDkOYe1Q8TVHn39vOh+FwwpxiHkgaT9Oca1ImPFWxk+eWYHeRDwddyfSGAQxpCsKEKEbrXsbzsW66Gl8G2pzSvRw7V4ujqrLOLeJgcmbqZL2IuuSBo9ceXRRhrd10zN+mEx4IlJm5Jicn9T+9g51eLQ5ambhQFY/Ghu68KWeaMeZDSi
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 204c88f1-c9f3-434f-bfe3-08d56b30e390
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1025;
x-ms-traffictypediagnostic: BL0PR2101MB1025:
x-microsoft-antispam-prvs: <BL0PR2101MB1025761A2BDE19B85DA37740FBF80@BL0PR2101MB1025.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1025;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1025;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(6506007)(97736004)(86612001)(6116002)(3846002)(1076002)(76176011)(2906002)(26005)(6346003)(68736007)(102836004)(186003)(72206003)(2501003)(66066001)(2900100001)(53936002)(8666007)(6512007)(14454004)(106356001)(10290500003)(25786009)(8936002)(107886003)(478600001)(6486002)(81166006)(4326008)(81156014)(8676002)(5660300001)(5250100002)(2950100002)(3280700002)(7736002)(305945005)(36756003)(6436002)(6666003)(3660700001)(105586002)(110136005)(86362001)(316002)(99286004)(10090500001)(54906003)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1025;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: gQ7PXY6MJhCjc9ABmjjt9KyQL04b+DN/6O6J7cQBho/Yw+mqVP8X+ZJAvWSYP+k86JcOWjXb/4wA/l6urnVa6w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204c88f1-c9f3-434f-bfe3-08d56b30e390
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:09.6277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1025
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 951a010233625b77cde3430b4b8785a9a22968d1 ]

If the requested range has a hole, the calculation of the number of
pages to unmap is off by one. Fix it.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/xen/gntdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 91cc44611062..1c03e30f66b4 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -348,10 +348,8 @@ static int unmap_grant_pages(struct grant_map *map, in=
t offset, int pages)
 		}
 		range =3D 0;
 		while (range < pages) {
-			if (map->unmap_ops[offset+range].handle =3D=3D -1) {
-				range--;
+			if (map->unmap_ops[offset+range].handle =3D=3D -1)
 				break;
-			}
 			range++;
 		}
 		err =3D __unmap_grant_pages(map, offset, range);
--=20
2.11.0
