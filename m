Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682256-2-6919091425480057518
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enit, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682255; b=A0j4nCK0wnKqdtA8TCt4/BZ/wGWRkMyEoA0iyZshfi+0huS
    pk4grH133qaCYqp7UKC9Go2QDjQsY0aQ4LtfJS2z9SzhQDW/36iaQeLnfKNkRVBe
    2yswcuOxWC5c6vcw606FY9FPFdjPKXiHsIqs/HEjio6H6fYC/LQ7wyB15Bv/qA9g
    17ksHRXuvo8/bM/DI2sm5Z0mQbyu7zc6fhprxunUBJA/ZaJUJneYAwfnkv2pgVjQ
    AAI4xzJHN7jGuPwFzKOWrBJFVjwaj/VURx7jCMJ+IeFOM2R4FENmntf+I4Ogsjsx
    yE+6g1EJOL0LD9xUwP8btAK4QLQI3UU5p2iCLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682255; bh=HPglsI
    NvpmHacwE75p6fSkyJTuFTfycS3ICpLwok8Cc=; b=o25FUNRmI4Dd5ZHl2BBpP5
    32ejdmnuKhBcnbGI5msxHHrVCZv2aLCQDpSyyIIymMrsbO4CVs3or2Wewn8sYccI
    3hwG0KW5AHPu7uzySc+sq4A3EfI36Zslm3OmL0oEslBV5eNMfjKT90p5T9dswQBi
    xfliK4bCZsA5jvOOBaAC+quUJmtyLl6Ey1jVdmBeQCnESxqZFJM4cUWI0qrztKeI
    1LVDjYt9HnVCdZlxxhplIO71P36hejT5pJKUp04gHxY2dOPPDfUuwR55iww6/gwW
    kLAAP2K1QhVejjvtEM/4ugWJ7tW7u+nDcB+Ke12IbwX7+fn8G/+y4hWCc3VPSs1w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LyUW0JBd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LyUW0JBd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754453AbeBCSYM (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:24:12 -0500
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:42587
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753424AbeBCSGK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
        Nitzan Carmi <nitzanc@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 17/32] IB/mlx4: Fix mlx4_ib_alloc_mr error
 flow
Thread-Topic: [PATCH AUTOSEL for 4.4 17/32] IB/mlx4: Fix mlx4_ib_alloc_mr
 error flow
Thread-Index: AQHTnRlx4LeMGQEP10CVadmgwhtytg==
Date: Sat, 3 Feb 2018 18:04:33 +0000
Message-ID: <20180203180413.7438-17-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:vAPcIEfaOYb6COd6BqpL5fgpy3bQ/Hs3uEb3vGoZF9n0ovwa3w/8DsrcJ2Gg+1nPOJxPwlFd50U4/tgtZpkhkAASlvxu+Y2NhMrrP51ponm1IIcguW5yKC2QvkiObX8J3+XVB1VaNkdfkBLWPcdKTxQ2PXGWEwRErXp4fjWnU3qou9uxQELnT2SZ72v29R8aHOc76TnvRwFb8wdaQnqH9pOTr//LVBzJmO1lVHptxYWOqHEwtylVVKAUB5z0Cwna
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4e415a6-23b4-4414-45a6-08d56b30c264
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB1009E8C0CF4071B8A30C4F60FBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(15760500003)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(575784001)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: hNMYv5PogDy1fyF4XBUsVCnlKxd2VyI60GclBP8JVSOY+jRvn/Z9K0lynY1rCkSUCocAPO3ucTyYdBUR6NB8OQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e415a6-23b4-4414-45a6-08d56b30c264
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:33.2996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit 5a371cf87e145b86efd32007e46146e78c1eff6d ]

ibmr.device is being set only after ib_alloc_mr() is successfully complete.
Therefore, in case imlx4_mr_enable() returns with error, the error flow
unwinder calls to mlx4_free_priv_pages(), which uses ibmr.device.

Such usage causes to NULL dereference oops and to fix it, the IB device
should be set in the mr struct earlier stage (e.g. prior to calling
mlx4_free_priv_pages()).

Fixes: 1b2cd0fc673c ("IB/mlx4: Support the new memory registration API")
Signed-off-by: Nitzan Carmi <nitzanc@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx4/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/m=
r.c
index 4d1e1c632603..ce87e9cc7eff 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -424,7 +424,6 @@ struct ib_mr *mlx4_ib_alloc_mr(struct ib_pd *pd,
 		goto err_free_mr;
=20
 	mr->max_pages =3D max_num_sg;
-
 	err =3D mlx4_mr_enable(dev->dev, &mr->mmr);
 	if (err)
 		goto err_free_pl;
@@ -435,6 +434,7 @@ struct ib_mr *mlx4_ib_alloc_mr(struct ib_pd *pd,
 	return &mr->ibmr;
=20
 err_free_pl:
+	mr->ibmr.device =3D pd->device;
 	mlx4_free_priv_pages(mr);
 err_free_mr:
 	(void) mlx4_mr_free(dev->dev, &mr->mmr);
--=20
2.11.0
