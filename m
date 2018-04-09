Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243424-2-2122057620842216361
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243423; b=r5VBkm5VXvbZWdbYtElniaLrpPzdS017PhfT7ZGNMf2jdS03J/
    6T2UD0y9efTYmVgkrvnnCWECu3svWi23+oAp+2koLyWmVHY4t5T1yLPe85/awOAp
    Qj+TIlnC72sBtyyT5BDWWRwl+96o1TLUOWhrRCe7Bt3vdi7sO1pl1YHi2GJV8LTl
    yFMZdMWe92hiJ9yiSVKhcbrPFebHysGw8oG8qnJzfLneNNbE9kBAg5rgMcQUjQxy
    qL89R7MaNc40mAHwsB4kx3ywlovd5vEbApiUb22HMyRLVAqvg17aWSEXmHh40ae0
    FPgxkx65NF7UfWLdS8BzB/O0nObr/wIt7GpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243423; bh=tCu69jlAcX
    szeYZ4eWv3MYxUUWLLIrXL1GcXJK7ziAY=; b=oNhIJzfVRyVNWY9lSfRJpqpw4m
    gXS80/Pj15V/4P8VmygPGIFNNSI4aq5SQcMm8SlUzxbUNGtXBPNyrfvKvxRNkHHK
    ozkUL+xqAx6pAWvKnsKHdIGvrXOurzFVkXU7J1sEr+1zob/YQ7uaBOdZJI2gxdTD
    ODsKko99w+VvmVJNuIdJvX2J/LN9UWSSNcPDbkrkkoOdfglm65Gkfxyxf8fSafS0
    EqG9JLr3/7aYM+NtTRbJBTXWUxuN6lDpRQF0gW4LVAAMrbYdJrij7AIJnp3Ou37x
    3CGnvfIXpMLvehH0AkpVpN6zBiTxHhXAm74TSPOKCwTZR+F0tGi4FRe8hsDw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z86Dw3hT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z86Dw3hT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNpWfxS+EP63KTYlv/OFtg0AUK6NdUKtu4+dwo4PFkIXRuUdD95KE7EnOk4sjxGRK7uGuiyW7XWxNsSND0Dncf0roVz2wWCFre5QvB/unDu6AEPS/kT4
    6FxMqkONiitsohWQV4CV7xl7+iYJzV/sMrKehUDdZ5prtvzYc2ex0PGK2pjlVmlIj8+1VYEmu3KABKJ6IFFnj9RpGUmWxY11bVmYi+1+aYCwHShk22YUBiki
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=CbDCq_QkAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=o-1mH1Emnmi-EsdI7UUA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754739AbeDIDKF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:10:05 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:63840
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755056AbeDIAYc (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 087/161] RDMA/mlx5: Avoid memory leak in case
 of XRCD dealloc failure
Thread-Topic: [PATCH AUTOSEL for 4.14 087/161] RDMA/mlx5: Avoid memory leak in
 case of XRCD dealloc failure
Thread-Index: AQHTz5ihqmfGm/V+CUiXkID/91m1Uw==
Date: Mon, 9 Apr 2018 00:20:57 +0000
Message-ID: <20180409001936.162706-87-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:MMcMamac43x/rye7709lspBMqNEa7Avfm54CQoLmFkj15g6zSDspFYvycSc3DMhz985Ui8uATZzogSfNRYacodjyMLwXbpuCRH7kJlP9fe8S4JiNlfebvjhOyByAqTuJbn4nJV3bt/uwkLPNF6ezVPjKLsBgyR1Bg5zxORpRQYKx/RdpU18U5DoYQ7mxzSxiPQ+A6JRe1nWv9IyZSvf+Nx2dQQHO//4rQ431p4ApQNsGisjmO8GM/piqbmXHxC1g;20:rDuSfkfUzau6WIbm+CUGhodB5tB4nSv/BUJLtOVwI8yFReVDWVJlDjgPDA3Ej+KeKuSRqBuzcZ/SioPTJfYAkU3BWCv4RUzhEfBX4m64zC5p9oLQoJp6l5lQZo821aSNGWLT7vx0NSsNLixqwAmrsdNegssYMjY/jem6AQ6w+I8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e4b9983-1873-47af-3ea7-08d59db04228
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09844D7234ACA29FB1BFB842FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(59450400001)(14454004)(6666003)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: W7m3ZzTeqikdc2z6gJkU26D3DGRCL5TCSRDPKswWAsDXcQqOTNKeyimj5oA4vUqJ5qCFTioYiyq5chZMZ0EpQQJ1bi07rg87I60MZFQ5NsNuWSyyFlXN/KaLFjoQ7ypYJZdREsKWsNva5GN8YWKNaqmQtQCLkIDWQI2UpUt5t/2VCMJS5ohukzs8r1sSNxvwzdEzYqhn57TCF4ahhxQ+CNo9alhQzZ0L3r8IG2khPhcwC+DiwAbtmbYRxM4bAiPTADNRTAhMPZf1BVEATCHWcRfVlDXFnRDd/MeaHE3640gOkPsPcxkP4bX90jRVi1xJy0y05IXbVpY+4eh6o7IfkTLx8dZbGmhAVv+ly5e+I394Wjfn62FNP4hF1SDO4wo15J3wQvXOhOhu24PKNdTxJgaEk9Y+h07xoUheKt/dFeM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4b9983-1873-47af-3ea7-08d59db04228
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:57.3314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit b081808a66345ba725b77ecd8d759bee874cd937 ]

Failure in XRCD FW deallocation command leaves memory leaked and
returns error to the user which he can't do anything about it.

This patch changes behavior to always free memory and always return
success to the user.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/q=
p.c
index c4d8cc1c2b1d..e1978d91a2f7 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4636,13 +4636,10 @@ int mlx5_ib_dealloc_xrcd(struct ib_xrcd *xrcd)
 	int err;
=20
 	err =3D mlx5_core_xrcd_dealloc(dev->mdev, xrcdn);
-	if (err) {
+	if (err)
 		mlx5_ib_warn(dev, "failed to dealloc xrcdn 0x%x\n", xrcdn);
-		return err;
-	}
=20
 	kfree(xrcd);
-
 	return 0;
 }
=20
--=20
2.15.1
