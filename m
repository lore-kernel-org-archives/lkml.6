Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682544-2-15520487976042008263
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enitda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682543; b=sTYBv2NyFw52mAHq9tPW6c0eJYUzAOFOEWbiDru/KWS1yzD
    yCLNqSxrrfjgM7ofzo8RiJwbf15grTW6aqxceJ0w6Gjk6qNPswYUV7FQP1hw4dn8
    Lmt9DrOtQ/4iyMZUndNrZrgMEKX6AOqqr7VaP/Dco0FvRm9WLJu4Srxl9jBlbNpD
    LLgq4yRBQSnDqlj2AlEYwOAxuMv3mVs6g5skwibq243Q5sQfeFo1Qxfv4A51dcMT
    RpKsxhm5I9qHw2B2vC93/opbFESesOAC2eu6zfkwv7x3+sG5bhJMcIBiCpAzatyN
    UcVarFJqeKYXjOnIwceI6CXwTyxQobrZF5oLEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682543; bh=sM+xIW
    HnJcBT9t+lrL/s3fSCw5NgvlXYhbsUzieuLx0=; b=qiNKr2HkIveOGY6NJjrNW/
    lp+EeqhOThBUql6r+6IpRR7wE3Otg3PRTMXlSiznwfEbDrPtPb0HIVfAeCArdv8Z
    3tbyzR+P1rZAhOOsEEA7+VsrekTybCrx4BXLtZnVcGdlhRh6cnxZIlzmLbTe10vq
    kMoje+ZP6dV7yBJ8mKmNlCarbVMN/DcpvTOQj+azZYHwnNcrnFPz4a6mWGudyhln
    +X7ayvwpiGZna2HVuG3xFCTaOjluI4+YQOXigEGSyYpAc7zCZz/lGWNujsp8Qju/
    sFRzcqsWuuNKhbrbUCc+psniDdORcc4VgC6NGMDBoF0H3AGt5bzRbEYztWQsXuWg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DHDaVzK9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DHDaVzK9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754591AbeBCS3B (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:29:01 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:1354
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753103AbeBCSEm (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
        Nitzan Carmi <nitzanc@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 073/110] IB/mlx4: Fix mlx4_ib_alloc_mr error
 flow
Thread-Topic: [PATCH AUTOSEL for 4.14 073/110] IB/mlx4: Fix mlx4_ib_alloc_mr
 error flow
Thread-Index: AQHTnRj8Sj/t63GiS0qWwJz4759GXg==
Date: Sat, 3 Feb 2018 18:01:16 +0000
Message-ID: <20180203180015.29073-73-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;7:inYReKl8SMy4AMtKVfEs3B9eW1D1vOBE0qRv2hmT3JJ9mKyGWmx8JveGoHVD0SPas/0SKoW16r5tM+S608sn5BgSDMPSAovuEDog1TIGIVUTK5k7nMR4VqrLHf8KLl0SCI0p3sBJuaC/fuOTfMO8qOh6h1V6BA1ildfpmtiwQamC4AkD4S1CcO+qo4wtOMtGNcP7puxfndV7GvYLh11+kt0C+uOpnQ/I1HY6AHiPswgVwHfWddZ2uvTzSxk8XoJQ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be9d1d07-30ba-45b1-e8de-08d56b303dc7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB11051344B9D41C0DEFC6F165FBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(59450400001)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(15760500003)(8676002)(110136005)(575784001)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: sKXTPG/30/sCRknsMIPR9YfGcKnWRoIDwLOtEr5hh0Cbr+ZVFbMk9DWpjcCfqsvRz/74G7MuTei9MvS72MfYPg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9d1d07-30ba-45b1-e8de-08d56b303dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:16.7378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
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
index e6f77f63da75..e80a7f764a74 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -406,7 +406,6 @@ struct ib_mr *mlx4_ib_alloc_mr(struct ib_pd *pd,
 		goto err_free_mr;
=20
 	mr->max_pages =3D max_num_sg;
-
 	err =3D mlx4_mr_enable(dev->dev, &mr->mmr);
 	if (err)
 		goto err_free_pl;
@@ -417,6 +416,7 @@ struct ib_mr *mlx4_ib_alloc_mr(struct ib_pd *pd,
 	return &mr->ibmr;
=20
 err_free_pl:
+	mr->ibmr.device =3D pd->device;
 	mlx4_free_priv_pages(mr);
 err_free_mr:
 	(void) mlx4_mr_free(dev->dev, &mr->mmr);
--=20
2.11.0
