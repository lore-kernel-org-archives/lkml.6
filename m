Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586FFECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065132147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LRd8hglp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065132147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbeIQI0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:22 -0400
Received: from mail-eopbgr730108.outbound.protection.outlook.com ([40.107.73.108]:57545
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728803AbeIQI0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXFDKdJ6+ceHTk+hdOmQ7rcgF90mlYFSzDNcJAdgxcs=;
 b=LRd8hglpEN4J/MjhnnHy/i+Ztuxm0NfilG3b6T+ibOvxGGgKOSZqfXGXiXl2m6279BgDPSVWLbet+pPuJFMCyIpniNl1OmqxY9k3K5A7gV8HcZUgkx08ilqBqvaseXw6673eYJan+iToKKolh1Qo6NpXlGieY5Fa2S1MYSte4LI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:01:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tarick Bedeir <tarick@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 035/136] IB/mlx4: Test port number before
 querying type.
Thread-Topic: [PATCH AUTOSEL 4.18 035/136] IB/mlx4: Test port number before
 querying type.
Thread-Index: AQHUTjKaAtrC1qDwB0SA9UKLjFpXMA==
Date:   Mon, 17 Sep 2018 03:00:34 +0000
Message-ID: <20180917030006.245495-35-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:0XjREj4VQQTDuKDVF5yZ1hCTHm5+29YMpGBGLlekfGZWcujtNX0TFyEb0sRDDPOqpGQ+dnr5f1xd8e63WFs9xTNU6swlxmU/QNp3Vi1eD5UA2eLdRzNcetPekudSaEnNYcmvi+QPnCM9kZ5VwtOQRV9ZK57rJPsqAHedDbjlQGNmBfJCqlmsr0AItAMscVDJbh0pOga0qUwxWYByEPx0021WyaCev64soimX3WIV4lQcizG0Nzb4YnSeU0vWW6rzpGyFdN/ph7Knx0/EdAz6Lt6DDAZYbbZBhCFq6WhYeOVLn8sWXkbwH6CgSPbETOMxFtWW8LviFpfqbhHnF0WuVEBi9zVykKEQurpoTP+UgpfwBkXL7UtQAVl6Z+M7X587Pc49lI1ZdZ5Bytuyd1SvfBA3jZdRwpDWJUJU1MontSdkDUOTzhzUXcTHNbv8d8Ytj6DZhZ2+d0Z1AOerUZ4zPQ==;5:CCjpN65sSBQMIS9P1YyUfsHPRj4v3ZUfJmTHIY27n/h+8sxlDrfB/iasmrZ5+zVtdWRFiGPRScBVUCkSC+wge70dq4jK5lGaolvpBafXFrr4Pwvym1MdRj5sVDIuvSaYX+UrzVQVMjJB1Q8x3FZHf78+5TU2fDjQPZ9MTlfDg6E=;7:6waiOtdamVAtZt7TlGK9d6Yyb2nXPvdZ5y2sX/6q8q0oPPJhz39kuVygzBfvPRpLZ+HidVwIySlBR2TRFq77FmgSFbofQ8KtjBapSt5uJMm+qf9TL+OsScjDmek8yti18OoE4vo2IoJ2XLoAH95xxrptudeitE9QJlrGaGkGv8BlOxIQOLzCr1EuEnhBauOvDVg4pQonYu9P1fZQyxATvihQZi5QyC8tnx9O+dq7wfRFmZVh3KexJgr6+hwLguQO
x-ms-office365-filtering-correlation-id: 14165025-f88e-4e5c-1330-08d61c49cdfc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0629328D74177EBF4DC934BCFB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(6666003)(7736002)(68736007)(4326008)(86362001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(14444005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zXsnso6nSj3EZDWbgz/NPYvtaEthD9/XlDb60lKNG9+1uJuW38D7an6oW6lWUQyXZ/H3NPwAvvAebeV8NgsLtxpjno0FCynspyZLLf0IAjkOvYu59F02bGsIZYOiVSDb+yRXLhpWtvfhbWaabIpB8QXtJt58XmrXGv4pLrqym8X1uEZIZFkBnwbYHxBldIZ2Xlus8ICVxh0rlTAWTCWKJmTEu3a/T85Tr+tSw1te8zV7x4cLayi4NrT+IgZOPxNH0iYtEsV8s4hAvM3DcKJ+/ZuCugp+2azwBRZ1wdsUa7Dc4myYcYuCaAl9e7xYXZTL5XhZPfX496PQ5/OSbWY6x8qmBSkSlje852yYp4VTn6s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14165025-f88e-4e5c-1330-08d61c49cdfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:34.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tarick Bedeir <tarick@google.com>

[ Upstream commit f1228867adaf8890826f2b59e4caddb1c5cc2df7 ]

rdma_ah_find_type() can reach into ib_device->port_immutable with a
potentially out-of-bounds port number, so check that the port number is
valid first.

Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
Signed-off-by: Tarick Bedeir <tarick@google.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/q=
p.c
index 3b8045fd23ed..b94e33a56e97 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4047,9 +4047,9 @@ static void to_rdma_ah_attr(struct mlx4_ib_dev *ibdev=
,
 	u8 port_num =3D path->sched_queue & 0x40 ? 2 : 1;
=20
 	memset(ah_attr, 0, sizeof(*ah_attr));
-	ah_attr->type =3D rdma_ah_find_type(&ibdev->ib_dev, port_num);
 	if (port_num =3D=3D 0 || port_num > dev->caps.num_ports)
 		return;
+	ah_attr->type =3D rdma_ah_find_type(&ibdev->ib_dev, port_num);
=20
 	if (ah_attr->type =3D=3D RDMA_AH_ATTR_TYPE_ROCE)
 		rdma_ah_set_sl(ah_attr, ((path->sched_queue >> 3) & 0x7) |
--=20
2.17.1
