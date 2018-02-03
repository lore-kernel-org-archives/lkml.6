Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681662-2-1931233276993593523
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
    t=1517681661; b=gPBZzVYVzsCDCF+FcWzkJC+sV36NIFvofGbUqnC8oYJCym0
    fE+1Lx6AmjgFl1SWF6lelHPhY/NZYk/ZzP9JozbcLW/HmmyhXZB/u4/X8zz1g25c
    A91FT+hGIQCSLHf3/IDrFWcJA/lZJ/NsUYjSVfWTR6hkNwzQyflrw6RPPpc/l8ce
    UjXCnSi8kyx3Vp1kWtZlum0iuhtY2i1aDO02WK/Z2WluFdXzYJ2g3ONoXWrx9DDh
    O7n49u4EsniWB1nYcxzWDUehtjwVNU+3u8qph+whsSIjNyDms+jI7iVFKYEiRZ4W
    BPH8l3mcF6V6wDFjtG5qV9TGywuhJxt7nhPELLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681661; bh=F6J9Sk
    NNdUhOj+jHZqRYfxYLf4LgdDsKFpqDcVBPOUA=; b=OAOBti1TxEpxHY0BK+e2TP
    SRuVKBOETXtMnHR8sy/SNe3CBmPiEO6umLiXkdiShgIo4nPojvPy9eTtm5GuIchd
    F595vvAqntwRGKTDZ1Ox1d6gTVaW50Y+7y99K5M1FWhucDx9/beDhv/XjM2hOVtr
    Zp02YsDdiJG+VbIfkBg+ffrxnMbFBWBmZ8VdHR3FE4bJB/FYKHzmsBwyShCYvYc8
    8GgvXDAwIacwsSLS9qab8nnsnhJYdY4ZCSPapGN/FYt8XiEAFqWaAwOv451FZOyC
    YC7YBLo9gf2MvXzELvayu670qFT/dFS02D2IRVumv+AYxOcScLeYUU7vMHA7UihQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y7f5PsOH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y7f5PsOH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753606AbeBCSHw (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:52 -0500
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:54457
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753350AbeBCSFI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
        Nitzan Carmi <nitzanc@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 32/52] IB/mlx4: Fix mlx4_ib_alloc_mr error
 flow
Thread-Topic: [PATCH AUTOSEL for 4.9 32/52] IB/mlx4: Fix mlx4_ib_alloc_mr
 error flow
Thread-Index: AQHTnRlYTWa6J05gv0KZ16v5Gh35FA==
Date: Sat, 3 Feb 2018 18:03:51 +0000
Message-ID: <20180203180303.8490-32-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:OgxTzOVQAqB3cZdJWkbIGV2Sv7d7J0eWz7o89E5cRf1YrmEUoi5x5HyCG1/u1BqNJVY0AV3vHV0E0dyurkrJgN7ceDLQ9eVhEmCMwamTIcoBmdQHwv502ehchPJxm36zgf9eekO75rRzJzHp3BzIWPe2j0nwdksYkoDSHgSKSLbV3IhEZnGtN+bYK2Bj+dqiISlOydKsHuFJoUX3FAbdZnY6C7+nG+5wyNp0RfNOKE10pRvDfH4G/SJLqU6UH/iw
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20fff3d6-6906-4191-ccff-08d56b309a61
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB1012FCE12AC9CD4238B4012EFBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(6666003)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(575784001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(15760500003)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: qyRH7cqpI1M7TOS8JfDpOXX+4hTXR+K1blHqhcfOb9WhzKiKsffqNEsEDruZg8lPIXR5auzGpU+KLwjsyr+rgA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fff3d6-6906-4191-ccff-08d56b309a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:51.7058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
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
index 5d73989d9771..ae41623e0f13 100644
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
