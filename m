Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487411-2-1064491076699958739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520487410; b=PxxHdw+tdZF2jLDhQNhkqmyICEDjAviWw7ifJLSA6CC4zSt
    RPQIRD8TfhKI4amCjbk+m8vjPccCvLbcv36LC99jqWjKCYMEKpjUZgcg5du6FB7x
    NH7FNzQUPEC1MprGzD/tEH/384obD02VNcbCawjEDSo4rIL4BIuovR8OqjnmmczI
    cyHJsZ/WqNh0HioIgapCcKcmBjTUHGVdszX/HM5WtjQrLINNPfpIx+9k1fvlVcRi
    YHIqKURNBDDrePvIs7UbaOxuEozAHktNJ+Rx0yD03nMre5K3X2tcg8ke2FDrMEwY
    fnSYaHlC/h+HSUqOfnIqJuNMLMSDhblZWRtl1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487410; bh=tKf4XG
    bg1NNTaJCxjzkodjqT0MpkWX77MR2iPBOeUj8=; b=jT8w6gdSPWmApX1sjSbYUh
    LTQ4L7iV8uwyQaZdgsD47+Jz1+qRTG3YDkxgsnRdTnwZYgFvg5yr9zCPGi9fN+GN
    yebH44+SPhWQSr9uEEb01QcMWAOiCfXqHQcyUo3kgluMROG+SDLfTcNVYBaIVl6b
    LgOI0aQThGamNZ3ftsgt8lqEom12vbZDRfpd2+EVSikHwke51MexRVtPcOIVZZIX
    Uxdp6PEL82c7G9S7Mb+iywM/3+jtmUwDUD+OBiPDq/wibNKZTzmJZxwICcneNhgR
    ui95XRP+bUJtA/wASQmOIKM3rxyu7z3L1Dt9+FkcFBh3S6EN0zlGxHgoMrQgcOaw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Fauzx/65 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Fauzx/65 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966412AbeCHFgs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:36:48 -0500
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:7384
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935281AbeCHFF5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 039/101] IB/mlx4: Take write semaphore when
 changing the vma struct
Thread-Topic: [PATCH AUTOSEL for 4.4 039/101] IB/mlx4: Take write semaphore
 when changing the vma struct
Thread-Index: AQHTtpqL9911LPXbikCx1Vl6SMCTUw==
Date: Thu, 8 Mar 2018 05:01:40 +0000
Message-ID: <20180308050023.8548-39-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:PejwRVzZtxeSrmlUx3c4y8YD0m/ayLNAo7j0te+LKHrR7OS500S29M3CIlsyAa/vy3pYLYESrnl75aB9qYhI8Ozr7XxonWIa0a7p9JU9IKCQa6NbXgeBkfdRll1qsuC52+nYhAcG9C4L0fBTpXIFZ3MGNuiv/Al5wVfD48U9PXB0gg7lx1M+lwEOeAuGgBx8bQhv+P4336fe8YMhpvbhSlfk7gxaF9s+rT+gj9Z65Pl7nDnTf8vnbvkreE+r1Rrv;20:D2gu10+snnYmfxfyFW9ZE8PNSmhOI5E6IcgkYhyMOTrdwF8g5w+IS2BB93IZqa74JH8e/pobC27t97lJUThJNPMG/19f3FNrG/f+YNvSxyzBivNwfN3m5yWx5xxy9G36lDNJVUGYVqbSSv11dRUVcAYY8pyMyxeTmxidugSil0c=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65af310e-be53-41fb-7b25-08d584b243c9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046A6841567A70D6B1D073FFBDF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(53936002)(3660700001)(5660300001)(6436002)(6512007)(36756003)(3846002)(478600001)(105586002)(305945005)(6116002)(1076002)(2900100001)(72206003)(3280700002)(68736007)(7736002)(97736004)(22452003)(14454004)(6666003)(2501003)(106356001)(10090500001)(10290500003)(2950100002)(81156014)(25786009)(54906003)(107886003)(59450400001)(76176011)(6506007)(2906002)(110136005)(99286004)(26005)(186003)(86362001)(102836004)(81166006)(5250100002)(4326008)(575784001)(8676002)(86612001)(316002)(8936002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: P7TfNSTnaikNV1/r+5jj1tv8XVHvYndkmwV2quIMdGbXDJgewzEpVfiHsjrDBUwM6NoU/cgmfXN1HMzFwWUR1LpzVVRJi0XoyhYMEpQxSEM5cxWPIK3SdmgRH1vfifWjyjNzG4kMvGF9Gck+d6IcL/upkBy8GHqc07XiINv5T/XX3ULskcxc5i7xhFEQBaa/+2ZhEds+2+RBwZFK5nxb7wyGmbWsXkdpje+AE9g7BLgWyzN+5sm+E1RbyvhJ2lRJuDfeltL0+4y1ZWhTKs1bRlDx+0qhVULBiJe2zpKjPcqbewKBMcQdUeN6dstSKaxB26xcQ4B3Zeggtif7SjchSQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65af310e-be53-41fb-7b25-08d584b243c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:40.9488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maor Gottlieb <maorg@mellanox.com>

[ Upstream commit 22c3653d04bd0c67b75e99d85e0c0bdf83947df5 ]

When the driver disassociate user context, it changes the vma to
anonymous by setting the vm_ops to null and zap the vma ptes.

In order to avoid race in the kernel, we need to take write lock
before we change the vma entries.

Fixes: ae184ddeca5db ('IB/mlx4_ib: Disassociate support')
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx4/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4=
/main.c
index 5a2a0b5db938..9119e0b3c2b8 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1041,7 +1041,7 @@ static void mlx4_ib_disassociate_ucontext(struct ib_u=
context *ibcontext)
 	/* need to protect from a race on closing the vma as part of
 	 * mlx4_ib_vma_close().
 	 */
-	down_read(&owning_mm->mmap_sem);
+	down_write(&owning_mm->mmap_sem);
 	for (i =3D 0; i < HW_BAR_COUNT; i++) {
 		vma =3D context->hw_bar_info[i].vma;
 		if (!vma)
@@ -1059,7 +1059,7 @@ static void mlx4_ib_disassociate_ucontext(struct ib_u=
context *ibcontext)
 		context->hw_bar_info[i].vma->vm_ops =3D NULL;
 	}
=20
-	up_read(&owning_mm->mmap_sem);
+	up_write(&owning_mm->mmap_sem);
 	mmput(owning_mm);
 	put_task_struct(owning_process);
 }
--=20
2.14.1
