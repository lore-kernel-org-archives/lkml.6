Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488273-2-9057954551438627414
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488272; b=j1Y+XR51RgqRuklTrFFLUa87ywWU1f4fdPNZzHEwUD5A9XW
    AZYkt7pCrb8KFoaUl2jNHHvYmp9Z24K75qZrVGnaWN3nZzB0wH2unp7XIjQlAAkv
    3HXUdqeSm5TbOXGYBInztHYa+NoOy4UT3x98mr2ic1IDAESSEdXlCibtCJVzNuZ0
    5+zzPI3HtKH60g6ltEHo1JmlR82SQ9z5s/FMcbQfcgu8auEpj+euZs1e0nssYB5i
    BQzuUE1cT8/3bUDY1FGeU+wRE96RdisTaKPeKMSBnULDwZn7Ja0+onmWtT8HVJGO
    8BS9gK52KVL3rCGpUzpaUA/lB060tkZnEogBHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488272; bh=hq86JH
    yia3LYq5oI9SjiYRUujyrp/RMzxRh3M7eHRa0=; b=JpTAMuVR9XxK6jSkhXxmfQ
    KgXBsuQDV7tft2OoXdiNjpcJzeoQBZITBvegLshwbeMRuwkXTUBylIsmzxCTMV97
    b9sutyzSAtwta7ZG9UcImKmAq8nXGibvq4DNT9TkTPxlAtE3WwyM8/G8Av09j6f2
    IcCF/Scfp9P+LCq5N1bHcw2hrlWcn+wHXZQh7J1eQlkWmoeaOuymm9bPRxsIbZ7v
    YyA8W0rt+jgWeGqvB1yIVEqYW7wVkUa07aim0mbBnoJv2g91xXy1yJlq8aOLs4W6
    OJ45QBES8iwLIPxrbrp8Y11B//OSASryBk6UgO0YJxByZ+mygkxpuFU9uviwusVg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PMkWBEo0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PMkWBEo0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965083AbeCHFu6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:50:58 -0500
Received: from mail-co1nam03on0138.outbound.protection.outlook.com ([104.47.40.138]:9600
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935458AbeCHFER (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 172/190] RDMA/cma: Use correct size when
 writing netlink stats
Thread-Topic: [PATCH AUTOSEL for 4.9 172/190] RDMA/cma: Use correct size when
 writing netlink stats
Thread-Index: AQHTtppUEavpESIs+0S+L17mdTMC/g==
Date: Thu, 8 Mar 2018 05:00:08 +0000
Message-ID: <20180308045810.8041-172-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:hu84XEQ4uObo+w5RrctcqootuDdHBozbg8QEr5+/SacD/LPUfgJ3/P8+IW16AAkUhqNRdmKT87Bjr7HFP1MGNuIZWJ4Z/9SjQBJP/rGkqXEBUcp6WxysTR6i7JsbBBCcztMUbHABJnbjkGZ7Dca42DmsPoxzPReh26kvwGCBt+eW1WpX2fwsVfn7i+CnrinSAZTJYnTsAM7IERAmqUsz955+a5FniZstTlA9lKa+CK+O0bZXD0NhixI6sPPe3hoo;20:WHFSKWXrgpr1qZsQHjnBCwvD/AK7xvjq7nKG3nedJ7tdFjuW+4DSMGT34rrvVXJ+7TSBaTUSLVmIztuCdaKjkXpTfPN4L/8JFm1QxBOW+F7b4EN1AtrtYTvWBFBFmsdT4LuBNuReFXVKstMby9TcyU8gMJtrDmMZxDfs0F3suB0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfb91190-e8c4-4c46-168c-08d584b209c9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919605C67A60AFC6DAB64E4FBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: mkP9OlOpoH6+LY2++lL8c50gM+RjVymrMscjw5R+SNxbGunSTpU7SWKu/jxamqdUFS5HJ8gZ3kFBLhLKJpK3i5YqoRt7zJ2nyR07Jc9j5m3EIhryrHRk9AHLqhrYo5z+c13z/BauAzMY0wTRhNZfD4xfFMSxOVnaJGaKYxh6bM8TB10tg8RZYtwfkGIvukB44LJj+uX3bu1Xifog5N0IFpU7UiSuxNjgqWKOhH9mYPtJBDRcY9G98Pjk0N+KC4xYCexu0iIuv9DblWOds4vDUHJOi3PSpgs/SDRPHRMn8bF5ZxbIJuDCMxUOroS+LpRcpHyVcZ2aHzzLqjq2RHWPWg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb91190-e8c4-4c46-168c-08d584b209c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:08.7125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 7baaa49af3716fb31877c61f59b74d029ce15b75 ]

The code was using the src size when formatting the dst. They are almost
certainly the same value but it reads wrong.

Fixes: ce117ffac2e9 ("RDMA/cma: Export AF_IB statistics")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 30f01613b518..de3d08c24715 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4336,7 +4336,7 @@ static int cma_get_id_stats(struct sk_buff *skb, stru=
ct netlink_callback *cb)
 					  RDMA_NL_RDMA_CM_ATTR_SRC_ADDR))
 				goto out;
 			if (ibnl_put_attr(skb, nlh,
-					  rdma_addr_size(cma_src_addr(id_priv)),
+					  rdma_addr_size(cma_dst_addr(id_priv)),
 					  cma_dst_addr(id_priv),
 					  RDMA_NL_RDMA_CM_ATTR_DST_ADDR))
 				goto out;
--=20
2.14.1
