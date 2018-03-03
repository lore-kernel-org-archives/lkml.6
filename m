Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123474-2-7197003491200905695
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123473; b=WcMI6jY4PWC2Fx2sVdZ/bQwKQY7gt8nryQZ1Vqu59rjHv8N
    BVvWlEfRqqlmxJyV4hlUzFmVRJefsv6cYLi7VrKQdGKsbHCUsTnWw+4Kh3zjWY/J
    kKZeneX9kw5oWGibKYJ2Sf4nEftDISQYd3BSrRAyfv8N+JsdmkQbGpix/4Nqsf3w
    MReYwaBJsfig/z98/wxWqScRM80wMx+MkV/hbs9s4OefTZpCfMJv197NWlYigIoB
    /+Wr/mlhZmslAjtaw77h2KRdapHcMOfzuEG/GapGeFvoGM3XjIw3+zk2dEUjsu6g
    5jOrpIT7/sGvKzfsN41SlrVnHJIiFCS8bF44oZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123473; bh=7uEefg
    euwkVTbWNtTD8/gGuphBpvnQqAVk7XO1+SWGc=; b=c2hSV2JLpn8LUjp1J2T/7k
    sQzm1cE2ynlY3oQtfNQnAbb+8m1mMZ4oypdT7qcjTwCdhllGVxV96klw/KR8c0dH
    CbRQdxlFXCQ9Y+if2zSCSJIQIXEvh5JWjDkKPAyHt1mVa3dvCqj2a8d/rJn4VcKq
    BLNZPwZfjcIxLBKb49bttnd6Ypl4dL+cIe+RFquSPkNxE+neKe42SZRCcwEU0EeS
    dqeZfUNv3gB6L/jlhoXBlk1zYONZvyyFgB2M/rOf6pNvLw0U2PiY+VHQzKcfAmgh
    sIGN8QB+HgS9Jk9iPi3ei62KT6Inp0ktCZzcUhzgeEzgem62Q4xz0TBBoOxTa7Uw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wy0lP3XC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wy0lP3XC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933087AbeCDAaX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:30:23 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:45281
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932401AbeCCW2D (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 101/102] IB/mlx5: revisit
 -Wmaybe-uninitialized warning
Thread-Topic: [PATCH AUTOSEL for 4.15 101/102] IB/mlx5: revisit
 -Wmaybe-uninitialized warning
Thread-Index: AQHTsz58yx7HL5fbRk6C7X4SqVSK6g==
Date: Sat, 3 Mar 2018 22:25:08 +0000
Message-ID: <20180303222318.26006-101-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:FwMXJLQMhoV9lOzNrWolqCJLsLhmfV/NQ3wdsxSbSYIxah2n09NjGSFoh0IDBqn/VdBNDnOhaGrDwi0qVnpvaQvPi/yQfS9FowSZgaWwpb8jD6C/kAGtb3AAJkmdc9v4+qr4/shEnbAvBUK7LvFz6h/HGD0eWa8hPXlDquowg7X+DpH6OQ641n2lQ5BXL5UkBerxt31oGbPLlGQYW29cSmmMueI/Zt7agarCLTuH2DFKcJfPdcB1fdbs9yXIvY40
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1282c2a-d638-403c-458e-08d58156027c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB0682151963655B2287FEE1FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(575784001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: BeobVXZZqtkI8nZQzvtOz90ejzyoDHy8rBU14Q8snX1bIg6rnGEP5NFTke0L0vFvcOPGpZcnUuVH3BQsdVJYe/v+FTZyGOlaDvXgK+dfVI1GKm2k/qLMUd6ibTnK+GN6VTFqVUCmoxZctVFyt51zU8WWt2AM7eEErAhT9CVrIhU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1282c2a-d638-403c-458e-08d58156027c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:08.1659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 1b19b95169cd52fe82cd442fec0b279fe25cc838 ]

A warning that I thought I had fixed before occasionally comes
back in rare randconfig builds (I found 7 instances in the last
100000 builds, originally it was much more frequent):

drivers/infiniband/hw/mlx5/mr.c: In function 'mlx5_ib_reg_user_mr':
drivers/infiniband/hw/mlx5/mr.c:1229:5: error: 'order' may be used uninitia=
lized in this function [-Werror=3Dmaybe-uninitialized]
  if (order <=3D mr_cache_max_order(dev)) {
     ^
drivers/infiniband/hw/mlx5/mr.c:1247:8: error: 'ncont' may be used uninitia=
lized in this function [-Werror=3Dmaybe-uninitialized]
drivers/infiniband/hw/mlx5/mr.c:1247:8: error: 'page_shift' may be used uni=
nitialized in this function [-Werror=3Dmaybe-uninitialized]
drivers/infiniband/hw/mlx5/mr.c:1260:2: error: 'npages' may be used uniniti=
alized in this function [-Werror=3Dmaybe-uninitialized]

I've looked at all those findings again and noticed that they are all
with CONFIG_INFINIBAND_USER_MEM=3Dn, which means ib_umem_get() returns
an error unconditionally and we never initialize or use those variables.
This triggers a condition in gcc iff mr_umem_get() is partially but not
entirely inlined, which in turn depends on the exact combination of
optimization settings. This is a known problem with gcc, with no
easy solution in the compiler, so this adds another workaround that
should be more reliable than my previous attempt.

Returning an error from mlx5_ib_reg_user_mr() earlier means that we
can completely bypass the logic that caused the warning, the compiler
can now see that the variable is never accessed.

Fixes: 14ab8896f5d9 ("IB/mlx5: avoid bogus -Wmaybe-uninitialized warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/m=
r.c
index d109fe8290a7..556e015678de 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1206,6 +1206,9 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u=
64 start, u64 length,
 	int err;
 	bool use_umr =3D true;
=20
+	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM))
+		return ERR_PTR(-EINVAL);
+
 	mlx5_ib_dbg(dev, "start 0x%llx, virt_addr 0x%llx, length 0x%llx, access_f=
lags 0x%x\n",
 		    start, virt_addr, length, access_flags);
=20
--=20
2.14.1
