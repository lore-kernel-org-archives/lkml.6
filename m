Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489767-2-8111805437374626573
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
    t=1520489766; b=uuGI445Isv0q3lHic4uFeWiDj9N/9ybTryOemiRa5LE4mtV
    7ZX3AS8e0qXWBLANmCEdi3N7AESlon0iz0bjGkWM0I2bhKcLdnRtVhGtq8yQk1CZ
    7OO+F711Jo6jesGnIawwz9XEbb3skCQiGL0sj6X9SLyQB3uLMfg+H9ljge8YcC0v
    P3sz/OWtgUL57lTAvthDl9RhRKw+0/RsUkCIOj27CtWo8bdm/dYbDm9XtXfAvbYo
    ftyjHgF1AvwFKHZqlrDp1LsPRlzUkIp4+P3iaFLFFUV7w1A1b6eoLM+vZyvPwoLJ
    JKQ0Eg8gdTtQ/U4wWq1/QV/7bV60gzZIqHunlew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489766; bh=40hcQf
    RuWM0Fk1rSRJZB1cCQtqZoBii9yNp7yh+fyq0=; b=ZN+lwrryI0oHJ0in/WW4h9
    lqDzfc+1XFbsQRh2kCrrDmhGXWf4n5/zjcGRbqx/J7MUF4M6yI2AVPqCDcDTfzHs
    l30iROvslKprFEw8roCcIkEMFxPM6d616fIpszalLyy6ICK0Hh/cjKCGljGjS751
    HphNDTN7JbU2WHIeNyhHExFt5oy53ntLhtKDIIhAnFPVdUbeo8ZuyNOPD7/WQRsc
    MgCM8cnX3tb1Jo+NqzbezkW3jzikiic2YW6Udqbd9w/32XmwqNbKV38KzszJOpl9
    WYDI8xlJnS3TrPMpBWwXqSpxlxkN6000PDcFDN3auEPFnFscBzOkz+XjUxKSD/1w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UmdmemCd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UmdmemCd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965204AbeCHGQE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:16:04 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:14896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755187AbeCHFB1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:27 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 066/190] IB/mlx5: Take write semaphore when
 changing the vma struct
Thread-Topic: [PATCH AUTOSEL for 4.9 066/190] IB/mlx5: Take write semaphore
 when changing the vma struct
Thread-Index: AQHTtpo4tdt5BsQqiEGfDzIHoEsmTg==
Date: Thu, 8 Mar 2018 04:59:21 +0000
Message-ID: <20180308045810.8041-66-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:yzRfzNS7T+F/kuFllrFN3kzQoxc3XHDVjpZuR24y/XsOgqVclyFudm0uYVLcVN7rbL8LuOkCNYzRfuLlsZL8H53IyH45cdsT1vmJvmUwELl97rq/2disX7BWbpsDBiCY0PS9li14+SdlqOuxIk5+rlzPlYcNuDttKBkuJmtTVHepYWbotcB/41A1QCvGm5Wi1793LWFGk7a6kdzh6bS03v1p9FaGXUFqjGyCqYJNzpS339v0hRnoX95MOxtBkDPv;20:udzNNtO+zC8V/0YE5034t+8jI4Os2PFDMnOM6DWVWpm3o0kgZLcbRsS7ecHedFONKegGdMvWNOqnJk5uIbXiJ3rH9dEWdfawdRsEGyV8g1DIWNwG16ATD4YCfvGuVeYHAX+ooS9eAiWHNT61/KsSGktWhpFfM0yH7uFW/c0yxNo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 327c0397-b07f-48cc-f9f2-08d584b1a2c1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09996C38BFC6EB391709AB37FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: lA+zpB7oeF5D4uYhsnbrtPsqRXt66Y8JlpGShoaYPzW7FXSqi+LypEUhSSsShsSxUFpXan3faKdczUzqh7OTj4QV0y/9O+hFBaR3fKGFVpuKbkua6CDecA/hTY6D+px4wOZ8+l00eIkG1Ozj+AFSyIv/vl2nmSqvPpqbJsLNm2a0JIfJzwcLxtx5vjqeUyqzzc6GZfPdi8TSrvoJD23kG40EDyZWo12b/jWhqMATaFfRSnvwDa5LRT8FFlBPho3KECp2JquClZDi7n8mzErD+3gcxfScaDDrNP10nhv5Svhvggv77Jn1ydFOl30c3B62hQFmjbWdfP5a6pDkSMp9TQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327c0397-b07f-48cc-f9f2-08d584b1a2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:21.0128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maor Gottlieb <maorg@mellanox.com>

[ Upstream commit ecc7d83be3243835c9396a1a2fb8ce95f205207b ]

When the driver disassociate user context, it changes the vma to
anonymous by setting the vm_ops to null and zap the vma ptes.

In order to avoid race in the kernel, we need to take write lock
before we change the vma entries.

Fixes: 7c2344c3bbf97 ('IB/mlx5: Implements disassociate_ucontext API')
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx5/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index 5e29fbd3a5a0..150227786969 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1313,7 +1313,7 @@ static void mlx5_ib_disassociate_ucontext(struct ib_u=
context *ibcontext)
 	/* need to protect from a race on closing the vma as part of
 	 * mlx5_ib_vma_close.
 	 */
-	down_read(&owning_mm->mmap_sem);
+	down_write(&owning_mm->mmap_sem);
 	list_for_each_entry_safe(vma_private, n, &context->vma_private_list,
 				 list) {
 		vma =3D vma_private->vma;
@@ -1327,7 +1327,7 @@ static void mlx5_ib_disassociate_ucontext(struct ib_u=
context *ibcontext)
 		list_del(&vma_private->list);
 		kfree(vma_private);
 	}
-	up_read(&owning_mm->mmap_sem);
+	up_write(&owning_mm->mmap_sem);
 	mmput(owning_mm);
 	put_task_struct(owning_process);
 }
--=20
2.14.1
