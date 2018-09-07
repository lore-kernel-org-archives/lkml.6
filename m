Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DBEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1133220857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="n9ROOlFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1133220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbeIGFQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:40 -0400
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:49760
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbeIGFQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj0u6JxGte7ogBjCD+etr5MoMVfDVYR9OhjHroES5tA=;
 b=n9ROOlFAt37YmjxS/t3KbyVdHzczHEQet7KzwmRiSUn16eSr13Vsr6Bll7VQv43nZGe8h9MIGX3contUviJRWQ6O96FXd1UVJPdYhfoGfNrfHqABH+5uJzcIt/hduy0vB0QpaSoBMnSZFbJIZVOg207VwajJVkgfxkZYCZYxMTc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 20/67] IB/rxe: Drop QP0 silently
Thread-Topic: [PATCH AUTOSEL 4.14 20/67] IB/rxe: Drop QP0 silently
Thread-Index: AQHURkL3F+l/K9DD3UmcAcxle7eSWg==
Date:   Fri, 7 Sep 2018 00:37:34 +0000
Message-ID: <20180907003716.57737-20-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:NxA0Ll7EIk60tjPOXEBekOJnIfonnSIK/oS/NwPL80bxB6IujPx/GQ9aDIE0QJzcktjWhkOflLgjNCEwOkOWFkxpGUXJhROJTVNs7t7XLmCLeVryukv5H1aXZannU+zPBj5in/swWjv8D9XhvHJiI/ubo203iQCDX3pyPRzc9LkNXkO+pFqi61NNy5ixrlv4bMy3oRIUXi2L8C5rizpICYWWP6EYR44yvk/81a3f/qIU7lf+nyLAL5JaPP4bM9PoBY8Ts6HDO4m1RAiwl4aCOY2yp53P4AXdt0IH/QPNzD7uyMaZXOPrakwzxMgq08tDtftOsD9llEBsMwb4itbaGSkP4AE3gIgovMxB18Y4yScd93dFbzJmCHi4VaXW9hQJ3AQ9pqeCRrOMu5VOcDj6AaF9dC8TabcQTAB/Z0g8dphNSHVZvrX6aDuu2w5UBtugHP72F2GBhYm3nTq6VsC37g==;5:+j0HGA4Q3Slp3R1CN9/rwIUHsNfxbpW/DxkfIfTgpkwcUR3XpnnzFemPB9szbr181qqdeLzek9WVr/8wqeEYsngkqq2LCM7qp/x97a3EkSp+wQLwVNhWaY7kVDLprCQfTGu2gOkk1gJH3REhf/jBHITvq9F+42UzRWjyO9Bp+HM=;7:esry8xdS0vHUPB85TcinUfX+XKQrUsWy0xxtqJQqILHnrWl2/5OnrN8MDiNzsBwJn5OZSArEa5jbqiCcCc7eoZG1wtUE135ibsx0toBDFP9EzObURdAOfrbdI4F9bEmM2fgHyeb9DFYyrWeu9/xrdrIj85xQwloaZkwNxcUSCPwRFwFqF4P6dtEfVvRPHK27wac5aerkNq2jZjVAmtZQZgQe/g8One/ylUKpcM3eaGTJh3xgZ2GoXBxM2Z6VfvWJ
x-ms-office365-filtering-correlation-id: 13f22286-6aac-4697-758d-08d6145a359b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB075747756AD1C925F30B03FBFB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: awjw1Yez4zbtC1+F3FVxIhI8W3YwrlUxudP8h/U1BsFqr1t6A9ACQdjKX+0d/J3/yIx1DxREcC+nBTMI4jNG+6qWvZDLWhHpollrQbdZDl/dr+K/pMIqAfiS0461yLSdat8xydiU+cTScsnBpOvYdAInpcjkFVpMVeHJTj+o81RgFneGXwB97/1CR5VG9vDMohoTE7xE7w6MGqrnmCX6mHeQvNfBd6lPzf6bxI2RA8E0gaTP2jlggKqCG+WQF607hreUF167fftMuoD590R6eYhBgGiXu2FuH0U0quTJVEb7zFJBe8SUfZ8ex8xt6G96yIF+tvZuV8KiQJhp8c99ld5lodcShGmILZyUV8eaksA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f22286-6aac-4697-758d-08d6145a359b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:34.1580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@oracle.com>

[ Upstream commit 536ca245c512aedfd84cde072d7b3ca14b6e1792 ]

According to "Annex A16: RDMA over Converged Ethernet (RoCE)":

A16.4.3 MANAGEMENT INTERFACES

As defined in the base specification, a special Queue Pair, QP0 is defined
solely for communication between subnet manager(s) and subnet management
agents. Since such an IB-defined subnet management architecture is outside
the scope of this annex, it follows that there is also no requirement that
a port which conforms to this annex be associated with a QP0. Thus, for
end nodes designed to conform to this annex, the concept of QP0 is
undefined and unused for any port connected to an Ethernet network.

CA16-8: A packet arriving at a RoCE port containing a BTH with the
destination QP field set to QP0 shall be silently dropped.

Signed-off-by: Zhu Yanjun <yanjun.zhu@oracle.com>
Acked-by: Moni Shoua <monis@mellanox.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/r=
xe/rxe_recv.c
index fb8c83e055e1..83412df726a5 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -225,9 +225,14 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 		goto err1;
 	}
=20
+	if (unlikely(qpn =3D=3D 0)) {
+		pr_warn_once("QP 0 not supported");
+		goto err1;
+	}
+
 	if (qpn !=3D IB_MULTICAST_QPN) {
-		index =3D (qpn =3D=3D 0) ? port->qp_smi_index :
-			((qpn =3D=3D 1) ? port->qp_gsi_index : qpn);
+		index =3D (qpn =3D=3D 1) ? port->qp_gsi_index : qpn;
+
 		qp =3D rxe_pool_get_index(&rxe->qp_pool, index);
 		if (unlikely(!qp)) {
 			pr_warn_ratelimited("no qp matches qpn 0x%x\n", qpn);
--=20
2.17.1
