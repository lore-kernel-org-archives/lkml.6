Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486659-2-7360063322718158984
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486658; b=t6BkNWBbF/lA/Bi3NaRkkwQhxi60XmxGmZeAasQ0zR1bXap
    PX+PDTlrWuqf/lg8SE9RuNNe//3wbqJsd852VLaNbhzhDSULBohNihc4EiulIKnI
    sY94aiqgF8sAv2j/0T3nPZa1u/6iZXaLaKkvXvNsgEre7j/qPPDtV1hnoX5S+W2d
    rijWIsmbSHdb0MQMJzGH01+9fwAS0TL5OAOXIx7gTCz/VexvkOKuU3rt/h6M2zCx
    /SN/tTamniVd4Iybwz8muKd4RdLNtd45oOWXgxdN5X5TOxpt+KoUkwzUqwhv+VgM
    W24NUzxcMzXFxJDcZyn5qwOuMhCcoBEp9o187+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486658; bh=hsTbWq
    5CloYJpihY8DROqWezzRyk14J9gxxs+k9roMA=; b=EICk9vVg75Vj/YqnMxeUXk
    tfzjUB0QgI/b1SEETUipwZdv5uqjLL71loj9pHq1GeK/m6i5zeuRMbK7vC+2EGsJ
    utqcyyFBVYxoAPExAo5V0/Pp1IzxQfhGjb1q6cLFkYDl4nIQPkMz3zV9U3bI2Vev
    lKtVM9ng7aYtZ2j95eQYs1INNgidFdWV0dcb+rw2YyizVkpauNAZb2aCJvzTuDwV
    hxIOYYqpJoTE8KH/Fna6VEO5vk6IFcOAXtjTJPl2Qot9fmYaD12DIqXbJ460VRn/
    M/WHJJS/gf/ah+sE65WbcFxp8asasYoAtqkHdtx834UOY9Cykul5/Hg1020JYngQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MWC8vJD0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MWC8vJD0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966648AbeCHFYQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:24:16 -0500
Received: from mail-bl2nam02on0124.outbound.protection.outlook.com ([104.47.38.124]:55497
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965533AbeCHFHu (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 090/101] IB/umem: Fix use of npages/nmap
 fields
Thread-Topic: [PATCH AUTOSEL for 4.4 090/101] IB/umem: Fix use of npages/nmap
 fields
Thread-Index: AQHTtpqeHRw9vpdWBkmYkhjC2kxTjQ==
Date: Thu, 8 Mar 2018 05:02:12 +0000
Message-ID: <20180308050023.8548-90-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;20:O7mgSY2UDXcBxJY0zv2O0CPcSQ9ahg4r38U6FP9iXcVMxfO7PbgbRobcaW/ar5n4M2N3gUHekHn2ERdBYMnYMoGv4Vuv8lW9n/4yNY4X2I4x3WKv7z86hQp3OpS0HvpbrldoFF2wm3hTxmMTqj0X/V93G6xkS3VeaNZ3EXmT5G4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d68bedb-bcf5-48ec-e6ec-08d584b28911
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727FD0816685015364E07BBFBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: de110B2/AdHZBZlZAwN0UfgA+ieXWH+I/IfDGkuYcg/QDcQeJ6d7u7fVqRoIdRRcZqj3f6BwehhAqS9gndN66wsJ54Fila44WPzbDOP/5/pLC0H4UFKk9NvUEogUW0kmK5G2l7aDrOKUt2FpPlWnxdEkVXLdTFBueCJicil4pEaKe6aakZr7BL8/+0Fuo2gorFuEN9hKEUYGngHi3MWcDTg3BBGcOi9syPwgvhc+3msAPsS3MJmMXUwHJt0NptDsQADVpBz7vtjq566hhByYfPHdhj7PU/ORvyHVmuqx/BzWjMAB+iKfJeOj9ZINvzCIsvwVin3jMAHBmeirhzLurg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d68bedb-bcf5-48ec-e6ec-08d584b28911
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:12.6932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Artemy Kovalyov <artemyko@mellanox.com>

[ Upstream commit edf1a84fe37c51290e2c88154ecaf48dadff3d27 ]

In ib_umem structure npages holds original number of sg entries, while
nmap is number of DMA blocks returned by dma_map_sg.

Fixes: c5d76f130b28 ('IB/core: Add umem function to read data from user-spa=
ce')
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/umem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index 0ae337bec4f2..6790ebb366dd 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -354,7 +354,7 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, =
size_t offset,
 		return -EINVAL;
 	}
=20
-	ret =3D sg_pcopy_to_buffer(umem->sg_head.sgl, umem->nmap, dst, length,
+	ret =3D sg_pcopy_to_buffer(umem->sg_head.sgl, umem->npages, dst, length,
 				 offset + ib_umem_offset(umem));
=20
 	if (ret < 0)
--=20
2.14.1
