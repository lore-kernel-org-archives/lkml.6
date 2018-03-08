Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489710-2-14394343300231733452
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
    t=1520489710; b=PyUsO4n3x2CcTtWuZYeG09+HUFDBZzbviNzrWVDpOkz5ACp
    kJxFqK3eOXo5T3v5z3ngQW2g4P+wshbn1KAeGd+GINdd1DZNlXBqFhHILXCa+Pr7
    z8X7v+5v8xE30ohY19uBqmxUjTFzZF3m+niu+aI5tL6Ueq11ybzBs0nXfqV4EFDw
    s2gym+AGhSevqz+Pbnt3laSSmcTm2IkCt5ECto/wCaXEO+L4M5qO+jNtQny7Yjbd
    HeYGED1NKIICYI66IgS8SNtUINevMzlxYp7fKqjkXk9S2mc2kxDf3XSnZVH2blbt
    ETFrUChgRMNMxMXdDLpwm27zZnr8B/zhID4+9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489710; bh=q7IdrC
    Zxz7EsiUr1YOFjPDnWxyGoWi7855uq38FdwTs=; b=Xy5c7E1EVIFYTmBhdUAo4T
    rKUPGIDYkGrnlp7ZHi+FtrvJ98O2dS2xwGdhz4NnOyzIbIhAINDQkBxV8l+FgkTF
    875TCFzLOKN6xiOGijTgvANEMDMnig9/1DARnsbQpP94G3G9B4hqQz4J6zy704iO
    8JB3GU/rbBpb9rzYrVDXKGwQn6u3b94E3XqR96mUjl63/dbM2Gl5X77RwyM+Xitv
    Yxs3tVOcy2zTX1ltYBxRLAokvBZbqY9ucztzaxy4du2y3Am8EdNz16d4WM9G2U3j
    0SE08AntprsPmy1yJtY/rBIAoXx0ZcN94YO05wXwt59hRU3N3cgAxyJvx9a63CMQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gs1zX7Tf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gs1zX7Tf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964955AbeCHGOm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:14:42 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:14896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965328AbeCHFBa (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Moni Shoua <monis@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 068/190] IB/mlx5: Set correct SL in completion
 for RoCE
Thread-Topic: [PATCH AUTOSEL for 4.9 068/190] IB/mlx5: Set correct SL in
 completion for RoCE
Thread-Index: AQHTtpo4IOrl3H2T6U2RqW+9TkODag==
Date: Thu, 8 Mar 2018 04:59:21 +0000
Message-ID: <20180308045810.8041-68-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:I44zLOH6mb5RQ+EpKwGpxBdPtAzmBetE4HpRDAoJOrC9Y2XG9wfh6WMulHc8dKu8dOvQu5IAclUerGPfK1yXRgDzNsRfLuxiWBSzmSMhF/WT8AOY23UocdmmfTfq8HTC2mg41h/kcnZCgvKAMdz8wq/GkEYccy+MypUWpkY8PgY/EksEM64whooH4TL5N4peYmZyS8/z15RkPimukkC/Wyrc5AeMRi66V6Cw3Yi14IRCMdlHPw3fVi4SlMSZU3tu;20:dh4QcOhCf7iZMPS5i6IMllW2AYAOUUwh2N3oMeK5ZU0zMFr5Wddk1KA4lCZrpImmgYNWvSypQNBFGqK70WEARyz+zXxKgPT9ra2TUAj2Jm6htEXelGYWqlgQckPAe9CZY4fA7gmGKXpduAxEdmmmJ+jfIEqpa9eY3wXlstslJm0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db6c045a-a61d-4614-39e8-08d584b1a377
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0999E91B20F5B42206BEC49BFBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(68736007)(86612001)(53936002)(26005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: dYK6kUpKDF9G+qi9NeyD7VDHKEkR9k+8yYmmnGu3Y8OGWnpOyfD/PjlCNP/J8uNT+KT1iwLq+EKg7S5jLsuH1/tIjwGMCRPYB0jqe6v/R43hZG67cNWhTXLtQJrhf4/EbymojcaTbd/VbEfOxJM0jxSZ36dELW0saRTz1t1TA3eH9URXuxYbjlfusbS60Bj20l8TGm8BO27Od+5723OUTgK8M5lqNgIkRsnbMs8UdtTuibUYfWr/g36oJ+LzkFxqAfr60bUcPQbyN14s46ZasBY69pvmwxk/OZPbzUMdJqva6SLVYwpxhiBom8C3nEWEcUF24Ob/zwGKiDmVS+FSug==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6c045a-a61d-4614-39e8-08d584b1a377
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:21.9224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Moni Shoua <monis@mellanox.com>

[ Upstream commit 12f8fedef2ec94c783f929126b20440a01512c14 ]

There is a difference when parsing a completion entry between Ethernet
and IB ports. When link layer is Ethernet the bits describe the type of
L3 header in the packet. In the case when link layer is Ethernet and VLAN
header is present the value of SL is equal to the 3 UP bits in the VLAN
header. If VLAN header is not present then the SL is undefined and consumer
of the completion should check if IB_WC_WITH_VLAN is set.

While that, this patch also fills the vlan_id field in the completion if
present.

Signed-off-by: Moni Shoua <monis@mellanox.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/mlx5/cq.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/c=
q.c
index fcd04b881ec1..4c32e5b8b106 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -172,6 +172,8 @@ static void handle_responder(struct ib_wc *wc, struct m=
lx5_cqe64 *cqe,
 	struct mlx5_ib_srq *srq;
 	struct mlx5_ib_wq *wq;
 	u16 wqe_ctr;
+	u8  roce_packet_type;
+	bool vlan_present;
 	u8 g;
=20
 	if (qp->ibqp.srq || qp->ibqp.xrcd) {
@@ -223,7 +225,6 @@ static void handle_responder(struct ib_wc *wc, struct m=
lx5_cqe64 *cqe,
 		break;
 	}
 	wc->slid	   =3D be16_to_cpu(cqe->slid);
-	wc->sl		   =3D (be32_to_cpu(cqe->flags_rqpn) >> 24) & 0xf;
 	wc->src_qp	   =3D be32_to_cpu(cqe->flags_rqpn) & 0xffffff;
 	wc->dlid_path_bits =3D cqe->ml_path;
 	g =3D (be32_to_cpu(cqe->flags_rqpn) >> 28) & 3;
@@ -237,10 +238,22 @@ static void handle_responder(struct ib_wc *wc, struct=
 mlx5_cqe64 *cqe,
 		wc->pkey_index =3D 0;
 	}
=20
-	if (ll !=3D IB_LINK_LAYER_ETHERNET)
+	if (ll !=3D IB_LINK_LAYER_ETHERNET) {
+		wc->sl =3D (be32_to_cpu(cqe->flags_rqpn) >> 24) & 0xf;
 		return;
+	}
+
+	vlan_present =3D cqe->l4_l3_hdr_type & 0x1;
+	roce_packet_type   =3D (be32_to_cpu(cqe->flags_rqpn) >> 24) & 0x3;
+	if (vlan_present) {
+		wc->vlan_id =3D (be16_to_cpu(cqe->vlan_info)) & 0xfff;
+		wc->sl =3D (be16_to_cpu(cqe->vlan_info) >> 13) & 0x7;
+		wc->wc_flags |=3D IB_WC_WITH_VLAN;
+	} else {
+		wc->sl =3D 0;
+	}
=20
-	switch (wc->sl & 0x3) {
+	switch (roce_packet_type) {
 	case MLX5_CQE_ROCE_L3_HEADER_TYPE_GRH:
 		wc->network_hdr_type =3D RDMA_NETWORK_IB;
 		break;
--=20
2.14.1
