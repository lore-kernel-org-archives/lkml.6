Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7BDC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF622077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lY+QMwLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF622077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeIBRoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:44:30 -0400
Received: from mail-by2nam01on0107.outbound.protection.outlook.com ([104.47.34.107]:36283
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbeIBRWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyO5E4RDP4mUFsfaE4lKh/WsFoZHs/Gqtyfvi/y1wQY=;
 b=lY+QMwLASFK11EBbThToMdSnggUk8+QzGC22OVSrjYoiIJJhGrln7J5zJjbVA4JS3Ergn/FDL/VSY15TZcMpAX5UqSm9JGvkA4HGL2q2D4shA4exlbqiZ7/vtfwsHwRBHWZxM7+hj0XEzJ1N3pyaSiTgFQY1WRcwWiP08mGMZcc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lijun Ou <oulijun@huawei.com>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 127/131] RDMA/hns: Update the data type of
 immediate data
Thread-Topic: [PATCH AUTOSEL 4.18 127/131] RDMA/hns: Update the data type of
 immediate data
Thread-Index: AQHUQr2nxuU5ieCyd0GKyLpBCOVwvQ==
Date:   Sun, 2 Sep 2018 13:05:42 +0000
Message-ID: <20180902064601.183036-127-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:DB124FSlghkSfCdHrGL8BtHInzgF8Nx16/1xuKJn7h9JgO9BMqU/ioeiRcsvzsmmXiFgnEo3gA4Sy13iqMw4y1JHMZ3BsAdKTwOL7xvO3ZSbzuUM7Vwe6irnhqDH8SowwpABdn9EXwaCfott8rDMEh3mV+Oxz25bEro+RwaarIggXHjI39nkIHmVomSkSOsFIWPzBI7pSEWzJiR/FDAm4S1aY5nkAipQq3wa8loUmvKBh+1eo7QvKfKWjfud5gBjnIcUk3Q342THjy0FrMc1oAC4iXtMjwUVH25S5BX6QYn7anKy1CSVgbSty5NxsYTgtctCLJ2azrJIwwbb4xnzQwEGkpbHoy2oPSnxGrWhm2BixHWsfyK0TvwnFxXIpLBiSRES50FslHk6VrjSoCi6VwKf8u8HxnzMakD6TdEOS6PgIoRYFVx/lD0lXkRZRw6ovM7AxQF8vN01RToMjj04DQ==;5:aGCb86BMTDOoiLtC/o7VRklqppY1Kz/TJNZgpfYc6eKkNjJVbli7ZJlL7NzSQapSwORK8N/dSlPZ0R8h5qr05ApPpifPZqmY2ON0xAuPtU2ZPwINxfemwVxuSgeX+YSZMytmQsuofXMrbqxo/m2M82z87lbrsseba7rzwtcMcOw=;7:ETwgOqD3sQ+v4kYjCbd/XWN5rNDjujpwI/VFAACqvxkDk+rkyvwlKLbkSPvo+IDNqLCp6/Pkhbgfor8Xv6JFgwd7UVuZrEYWys9+1pRAFqaPbwDcqGcCwQxAF2XpaQ2y0GZGdmBqi7O3TXTlW1A8Ir+Bsmvh1arazuwz9vaVtZ4KWx4I9W/xe7zNmQpCoDZoUhrb7u7XzXmIjbMI4JPYDE0bTqr9Yo2HFANqVaSAWMwS//4xwknl0FfPtQvd/452
x-ms-office365-filtering-correlation-id: e0aa5561-37e7-477e-a186-08d610d4df2d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822AF0DD0334C6A57CE8348FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(575784001)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(6666003)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002)(14773001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Sjqcr+nkI8gEY3VB4lxiatPksqg+J9uWx9n91lIMeJNPy3/6eKx1ALSpHGPlgsQfmLYgt7fB+IYbUl9SjqdkT9SW+jgLqDqzC5973Fj+y3EADys6i6fVT/0vDXldP4CIBEjw3WEHHmGYMaTsmWCkIH41iqOVgJX5Dq6nfLpymp1PQP/G58V5cByNK3XD+1XM9Yy0rhaZkazkU+9qbyiD/nWBaQwgvdcoMiJ3PFMBcyeDBsOddrxBLQkkmbr/L/C45069IAWyFFw+5Shh460/OBhSzA0nIlisNyNU6qyrWKrVzQ9N5WMRv57doZqkA2qbvVkGrg/YUnMXR64bkbaS9cCzytHI7qnBQ5qbrtAKht4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0aa5561-37e7-477e-a186-08d610d4df2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:42.8219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

[ Upstream commit 0c4a0e2987a51415de73180ce9f389a99b3dddd1 ]

Because the data structure of hip08 is little endian, it needs to fix the
immediate field of wqe and cqe into __le32.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 ++++++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  6 +++---
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniban=
d/hw/hns/hns_roce_hw_v2.c
index a6e11be0ea0f..c00925ed9da8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -273,7 +273,8 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp, st=
ruct ib_send_wr *wr,
 			switch (wr->opcode) {
 			case IB_WR_SEND_WITH_IMM:
 			case IB_WR_RDMA_WRITE_WITH_IMM:
-				ud_sq_wqe->immtdata =3D wr->ex.imm_data;
+				ud_sq_wqe->immtdata =3D
+				      cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
 				break;
 			default:
 				ud_sq_wqe->immtdata =3D 0;
@@ -371,7 +372,8 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp, st=
ruct ib_send_wr *wr,
 			switch (wr->opcode) {
 			case IB_WR_SEND_WITH_IMM:
 			case IB_WR_RDMA_WRITE_WITH_IMM:
-				rc_sq_wqe->immtdata =3D wr->ex.imm_data;
+				rc_sq_wqe->immtdata =3D
+				      cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
 				break;
 			case IB_WR_SEND_WITH_INV:
 				rc_sq_wqe->inv_key =3D
@@ -1931,7 +1933,8 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *h=
r_cq,
 		case HNS_ROCE_V2_OPCODE_RDMA_WRITE_IMM:
 			wc->opcode =3D IB_WC_RECV_RDMA_WITH_IMM;
 			wc->wc_flags =3D IB_WC_WITH_IMM;
-			wc->ex.imm_data =3D cqe->immtdata;
+			wc->ex.imm_data =3D
+				cpu_to_be32(le32_to_cpu(cqe->immtdata));
 			break;
 		case HNS_ROCE_V2_OPCODE_SEND:
 			wc->opcode =3D IB_WC_RECV;
@@ -1940,7 +1943,8 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *h=
r_cq,
 		case HNS_ROCE_V2_OPCODE_SEND_WITH_IMM:
 			wc->opcode =3D IB_WC_RECV;
 			wc->wc_flags =3D IB_WC_WITH_IMM;
-			wc->ex.imm_data =3D cqe->immtdata;
+			wc->ex.imm_data =3D
+				cpu_to_be32(le32_to_cpu(cqe->immtdata));
 			break;
 		case HNS_ROCE_V2_OPCODE_SEND_WITH_INV:
 			wc->opcode =3D IB_WC_RECV;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniban=
d/hw/hns/hns_roce_hw_v2.h
index d47675f365c7..7e2c740e0df5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -768,7 +768,7 @@ struct hns_roce_v2_cqe {
 	__le32	byte_4;
 	union {
 		__le32 rkey;
-		__be32 immtdata;
+		__le32 immtdata;
 	};
 	__le32	byte_12;
 	__le32	byte_16;
@@ -926,7 +926,7 @@ struct hns_roce_v2_cq_db {
 struct hns_roce_v2_ud_send_wqe {
 	__le32	byte_4;
 	__le32	msg_len;
-	__be32	immtdata;
+	__le32	immtdata;
 	__le32	byte_16;
 	__le32	byte_20;
 	__le32	byte_24;
@@ -1012,7 +1012,7 @@ struct hns_roce_v2_rc_send_wqe {
 	__le32		msg_len;
 	union {
 		__le32  inv_key;
-		__be32  immtdata;
+		__le32  immtdata;
 	};
 	__le32		byte_16;
 	__le32		byte_20;
--=20
2.17.1
