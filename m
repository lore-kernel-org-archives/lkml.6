Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683300-2-16889130572124662838
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683300; b=fALhPNtZVHvKRRcMiM4/V2eXo/4k7ZCdCk2FXXWm9oaPsxD
    y08rKqopNw4TDIXT5zmQPiQSD9Cb0zaVwFCFYaKt/MS261NM++XmF9+YSS4P10V3
    x+4Q6Sizs1HYvAadH3U5NNe76g04MdpwPm76zYKGNAmA/bnRqJOK3fDYtXztR5Y7
    8OABIL3C9qDnMV5liA/JbCHhx98XtfqKeu6Pv9vkja1SMLKw3lPf6rp88ZxI1yDl
    K2/8xOB5x432Q3PBLO7EkgIaDOe7p3bKUsmua7wxdADDL6nc2Vr+WDC0LdzLG1iE
    Xjb0aDcuGdr0m1kFTMfOVMggSenuVtCm9CPEDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683300; bh=eqZcgb
    BAdMfAicLsY2bSUko9XbpQPDhyNE1QUr916Xc=; b=Qm6X/wAM8w/NCwFIuzITUM
    i4K9EWmKuVRxMQGpqeLjMMI71XCqtOosjDNy2kRqtl84fXtQmnVLpi/rqoAcOXoa
    cFDzupHbzIc32SjOc9u6nW4mijqp4QUX9VAonqsWMwewFzl7XyWb8bdyzfPxSZ1a
    4w0f2D84wD1PRZSX6TYDVxC4cwI+mWKZvdzH1udVcfdldUhKQg1HT+nZ9BdFqtog
    28H5injC/w3WSkJfrkwyExW79TGxQPHB2KVIc+50FH2pFqm1VQnnVmL41Dq8ahOA
    7Xy5LJQMJjhHVCwowfp4+FMUplw9OSz7L/Eyo3b+liNjP+BsiIOm8Yhi/cZnbuKw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fKG+Kf/T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fKG+Kf/T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbeBCSlb (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:41:31 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:1354
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752857AbeBCSDR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nitzan Carmi <nitzanc@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 066/110] IB/mlx5: Fix mlx5_ib_alloc_mr error
 flow
Thread-Topic: [PATCH AUTOSEL for 4.14 066/110] IB/mlx5: Fix mlx5_ib_alloc_mr
 error flow
Thread-Index: AQHTnRjygDbmA3Xvl0+pFk98nt7mSQ==
Date: Sat, 3 Feb 2018 18:01:00 +0000
Message-ID: <20180203180015.29073-66-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;7:imPCi31GGLxBTLQkYr9sHd4qMWnSglak6e5QN2MlKxd5Y2iTyKySY3597zuIl12Ut/6uTDXeDoQBIGx4P9AZEXnq/EkyLtkWiXnCStuQJXu1W1rgEzXeQYd/rlMVk/q0n3rCEAL0yrjWWCB9kGSlhM286ECt7f+OJPPB9v/5tLwbv4xHWjXXroALoxZPttzABg7+Vp2+/o7WZt0j/IJlauIxZdHxkMzvTKhaiVVnBzrn+wF+0xmHASQ/ADawOdI/
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c2da3c5-37f2-4548-2782-08d56b303bdf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB1105613EA3CB7206E8E93A9EFBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(59450400001)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(15760500003)(8676002)(110136005)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: YEkIBGca1IQ+4Z/TC7cqZppJZE06vOZqlgrnzhDoDMgMCPqRt+3c5bzCZrcFje2RVOK/PIdqt9qSKkQOkFt/8w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2da3c5-37f2-4548-2782-08d56b303bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:00.1440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
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
index 37bbc543847a..231b043e2806 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1637,6 +1637,7 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib_pd *pd,
 	MLX5_SET(mkc, mkc, access_mode, mr->access_mode);
 	MLX5_SET(mkc, mkc, umr_en, 1);
=20
+	mr->ibmr.device =3D pd->device;
 	err =3D mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
 	if (err)
 		goto err_destroy_psv;
--=20
2.11.0
