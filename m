Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681767-2-6380036701789946308
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681766; b=tV1mHGp3wbJIc5MCcLv4UqUkuEToGGczIZW2YhjOTsv8/pm
    TlzqlPoe6dYeeqodxPWWie5AIxtm0s8T4TvUr1ButpQZErLfSBrNt8MAI3l7ulMz
    A6W8iw/6i1fLrN+ZFN734N0UuaBk6WtQmXqk3kP5ZEDw0FHM4kugXBTvHzgwxOv2
    MK93VvgQQe4grAhEXd92jncx2EBmGf7CbfAbW3lt/ZxGKH31i4Srps6JRxFdSylo
    xkhXM3DA5Jt/DEGJpoxJg6GZqV0ieZ316/1JRard4lCyhIq0p5EQD7+LwuPAMFrR
    FPamnrjRhJnvSQImaiu4VOpCrLgnEyHarMOYT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681766; bh=9Fe6Hd
    x5rDLblPvd2Cmll2PmoThUaxyCOauGlJuSbrQ=; b=bBfu1UfGVDJ7VZZBJCg5pC
    CdjYj0IgAyMEC7wrzndo4wga7AABsB0bp9xuU1Jp0oGo/vOZslDLEbrKmBM2ts7N
    Y/nO52laDOaRt512Ik6FMJcwCBoYjWbamM7isqX07kR9InUegfT6ZXZ3ZJDGn3H5
    7MgvhZohJjJGtyrYzBhG0RWn0j9zROu2s+0Z9tSaGHRgXEtqdws5oXefu+dZHBx/
    qaI3yNbF1yBMrlYKDiUj+Z3l109yclLSRVxE2c78/hHvSNGqKPQ6S8KvczFYsESp
    ShvDnqJFZvtWcLYoE6DWr9291Wvk1MCJa5lJ9j8R1eJbrlIE65Wl2W9UY0cIE+3A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G+ZEOC3p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G+ZEOC3p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbeBCSOz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:14:55 -0500
Received: from mail-co1nam03on0107.outbound.protection.outlook.com ([104.47.40.107]:45036
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753403AbeBCSHL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 30/32] xen/gntdev: Fix partial gntdev_mmap()
 cleanup
Thread-Topic: [PATCH AUTOSEL for 4.4 30/32] xen/gntdev: Fix partial
 gntdev_mmap() cleanup
Thread-Index: AQHTnRl2jDgMZ5ehJka6natczJwYGg==
Date: Sat, 3 Feb 2018 18:04:41 +0000
Message-ID: <20180203180413.7438-30-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:RUPVZ3JRg40gNk627R2HW/4hbXPTIhL2vP2s+NhQ7MMCt7NFf72IraujbNRhBCzR6UZd2/F/UGQGlYmaHsvHILctsWdjlG/zaEiELaBCgE9CkVTwgD6j05O/PBBcAaavcBSzge6kzlvcy7/XAwtZsNhfyQx3wQpHo91OLI4glQhQrmwMLhv4Tr+MCN0AYNyfZl9a3VRbIB/nvyzFDdgpkIFp3fa8kvPGrH99yPkHaZHh0vQLyXLoLpZsFPmhy/sW
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26b3c427-f28e-453e-1e77-08d56b30c914
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB100992C328A3F3C32FB19697FBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(8666007)(575784001)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: kRnJZZVmBcLgY89g7HOfcXAJT508Lzrn7hs6yYTbsJvB+yzEfyMi4qTZXC6GiYYnRdWJjzcHfRNobkkGVcHtCw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b3c427-f28e-453e-1e77-08d56b30c914
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:41.3308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit cf2acf66ad43abb39735568f55e1f85f9844e990 ]

When cleaning up after a partially successful gntdev_mmap(), unmap the
successfully mapped grant pages otherwise Xen will kill the domain if
in debug mode (Attempt to implicitly unmap a granted PTE) or Linux will
kill the process and emit "BUG: Bad page map in process" if Xen is in
release mode.

This is only needed when use_ptemod is true because gntdev_put_map()
will unmap grant pages itself when use_ptemod is false.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/xen/gntdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 44a9d8eb0eb4..1865bcfa869b 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -874,8 +874,10 @@ unlock_out:
 out_unlock_put:
 	mutex_unlock(&priv->lock);
 out_put_map:
-	if (use_ptemod)
+	if (use_ptemod) {
 		map->vma =3D NULL;
+		unmap_grant_pages(map, 0, map->count);
+	}
 	gntdev_put_map(priv, map);
 	return err;
 }
--=20
2.11.0
