Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682549-2-14243535133616688838
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
    t=1517682549; b=ORAk/4FwG+M5GJ9PooaqrQ6nHnkGcsFtss5/orQ3RVRZNm7
    yZjwyc+yJlsfx1AyOcdPhDZlfaWw1QQk1YNel0EFgqSgHvbWKu8eChe7WS9bDo0j
    1fnchGmitNQfRO1E+jqTBORoO0TBkx0WEWWWyHJXx1sCaoTyLpKvNQXYIQbTV7gp
    XNSeVSUaHeZ9sauAsxGuRoG8QFXyZhJixJ/4QwfRiFu7diXthZWk2biREDtFCltv
    xT1DahKFCPpKlKqsGTnn//EiZdvA9Ai+G7dZQluribC7ncFWvVpeaIHeXBwwHUoW
    /PoQvnYVIrE8P8rZIPm1qAA+PazDa5eccBVnySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682549; bh=AihTgh
    CLSO1nH2cC1FSU3+NmzMduq7DGZkl69FZa0Ck=; b=NgYdPo85gjp7ahLbFAMeV+
    ITSlQtfOuJT1skRPGfxi5JHaKLw9hq6g7W/d4svU3Ppb0qy3h0H53Rell+D14gjc
    iHN9G0uRaOyf35LYaZIt/IweXu+eaI31zZaEHuGB9ipYQUhKueyAVu26fW3J9OB5
    YepZhMSHyAPpgI5v9jhoh9/YcU+XMew6piugLL65ZuxKRQ4PjOamRlPBTILfc9qV
    VMH8fQ+eN1NUtAMu/2hMGa6JTpo+gRRNl7dKk9jmknt8EPd05cLXO/pprhBHadEB
    /tJ55J4MjzXgkmuP/kTyvLIeFuPRJmjVekie0n+FUq4jy2yRM6Gki8aG2zZN56mQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gsKhcyjq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gsKhcyjq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbeBCS3E (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:29:04 -0500
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:54457
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753311AbeBCSEg (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:36 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nitzan Carmi <nitzanc@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 29/52] IB/mlx5: Fix mlx5_ib_alloc_mr error
 flow
Thread-Topic: [PATCH AUTOSEL for 4.9 29/52] IB/mlx5: Fix mlx5_ib_alloc_mr
 error flow
Thread-Index: AQHTnRlXa01YojoyXkOAkToWlvzpbA==
Date: Sat, 3 Feb 2018 18:03:49 +0000
Message-ID: <20180203180303.8490-29-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:m8qF9VeYShIjUHsHtLLc0lMVYgkKAtp1TH+etHUWhldXVbbAP9KTIvQPfNjiwxet4f9OkNvysJhYIxNeOWpZ2IISQchfUpBRzGJGj4f7aREsMYlYYuGIRVKJQe0Kg1CXYOsmptqKv8ha/HbxulyagkPc0OP6BsriDNGg/mP6Zv2YDcxdfSRc0iJvY/qwWSlldNpd4Dfz5NUI71BgB8qe0Kh3dNulTUyBXvY+uS2NCeRxgKYYx+yNESKywCpQeCFn
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bea94387-168d-4314-f506-08d56b307a7b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB1012E6423D935A50744FCF70FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(15760500003)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: L3tNvSiRgr3rz3W68JnQMPjaaY1yO6D4gDQ08CeP5vF3QDFk794V5VWC13GftH4llLxAeASGP1qKMFqyvKxjpw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea94387-168d-4314-f506-08d56b307a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:49.7526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nitzan Carmi <nitzanc@mellanox.com>

[ Upstream commit 45e6ae7ef21b907dacb18da62d5787d74a31d860 ]

ibmr.device is being set only after ib_alloc_mr() is
(successfully) complete. Therefore, in case mlx5_core_create_mkey()
return with error, the error flow calls mlx5_free_priv_descs()
which uses ibmr.device (which doesn't exist yet), causing
a NULL dereference oops.

To fix this, the IB device should be set in the mr struct earlier
stage (e.g. prior to calling mlx5_core_create_mkey()).

Fixes: 8a187ee52b04 ("IB/mlx5: Support the new memory registration API")
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Nitzan Carmi <nitzanc@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/m=
r.c
index 0a260a06876d..c7d5786d366b 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1648,6 +1648,7 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd,
 	MLX5_SET(mkc, mkc, access_mode, mr->access_mode);
 	MLX5_SET(mkc, mkc, umr_en, 1);
=20
+	mr->ibmr.device =3D pd->device;
 	err =3D mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
 	if (err)
 		goto err_destroy_psv;
--=20
2.11.0
