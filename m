Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA805C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F9020857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O5aI1BO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F9020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeIGFOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:24 -0400
Received: from mail-eopbgr710107.outbound.protection.outlook.com ([40.107.71.107]:21288
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728163AbeIGFOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMRgt+x6ogUW/f441oDzNH9RNGoVMd1Mtkc2TxqXo7s=;
 b=O5aI1BO0fpFsi6GQz/MI56aUwUatTPy6EqRzDfN0K2lxXb56/6Xbktl1tFQhRY3Yb/krOPgXF3I7ruxdUyRB4jg+WDOag7NQEPn3EUrPEtHmo0Jkxa694gmJru/N/EYkx+s+sBRqX6cn+3Mm8e6IK5XF96uL7NWlgCCgZyzI3w8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:36:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 28/88] IB/rxe: Drop QP0 silently
Thread-Topic: [PATCH AUTOSEL 4.18 28/88] IB/rxe: Drop QP0 silently
Thread-Index: AQHURkLGVNVgwAZVQkmzXMNiAMjQLw==
Date:   Fri, 7 Sep 2018 00:36:11 +0000
Message-ID: <20180907003547.57567-28-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:q3bFKvPqXUXEwirwchBNZ00iqku03g8vSuWhaZ1bOfQuUrz0x2nzt+BMMm0ylJaBrW+NWxEnBsRh7dMIR80qhBWCKDhlYg8Ghzf9nScZuvz/hoUv836wHc3t4CNZFl6nTsq/pSPJLD1SyXGQgCtM4ak+pS0eL6uQO8tMSAnqTEi5n+Il4n7Nu2/JhZwhkfNfyiUSql0AW9ZgiKCHvSQ28bMnVtPqNm/yjvogaVWLuu2uw7aS+PevBZPuacBXcLn18Qv9k1gTM99FbOoQbCK+NrshSh15HPGjQEAw4u3wGqVou8guC+VXsR0qne+aFw/Ve37CEV7jVgpFqbALS72yOstAmikJhOAIzM0fdrgfXmVkJ2tr4dbkwPf7DsZG1DBgOvGQZAiFcqkmxNQH0i+l0MEavyQgjgWy9oQb4od9zDXvZ1BKXL8AmXApoteWG9NEv6RcPUQSdePmt4GvynAuEw==;5:4dPmFn4r/F7RgZEXj56WIHimF/P+FF6GQy9JlPVM9zmFMES5nW8l8Wvyx7Zy0oT4p+FaCmb6f9QSkaqwxl+PoIl18Njh8N3UTm02Y9pj6TRd4nSJMege8MC/zrPD5fPsszcC8yELIhiVITFmmkwooScr7axs5BT9ptZblieWSVk=;7:fAK5dc2f5n2MqhYdf8nflNBmeCGUG25yhAv2WoBPhoWE55WZ3rv342gcLGJ75/78mFTir+sQCviXBNls4obNAbsO4VPQ3B/Ce76tTEzYtelIGzk9VyAX/aHk1P5zDgEv6wp/RiAP+dffI9WwAYSSBYOR1lt+3UrD1kDkjrIlDwgmkyDU2QJyhg+fPSdPf7i8rCNV6OaozEP0EPl6KaiglqXAv6EQqSqiubxnLD78zUJYDW7f54Fyd/zdtzBM0lcQ
x-ms-office365-filtering-correlation-id: 1721e0f2-7a87-4a0f-0680-08d61459e979
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB08241792A27F516FF207BDF7FB000@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(22452003)(256004)(102836004)(6506007)(217873002)(10290500003)(186003)(26005)(5660300001)(4326008)(6346003)(81156014)(81166006)(110136005)(54906003)(72206003)(316002)(575784001)(1076002)(6116002)(3846002)(8936002)(107886003)(14454004)(86612001)(2900100001)(105586002)(106356001)(5250100002)(86362001)(76176011)(2501003)(53936002)(10090500001)(68736007)(66066001)(36756003)(6436002)(99286004)(6512007)(486006)(25786009)(2906002)(6486002)(478600001)(7736002)(305945005)(2616005)(476003)(11346002)(97736004)(8676002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: mSwehAnniBtCUFWTBS5+IswVr42bgxe8/Bw1VBP3eFVZ97I48DO0d0tyDUP5Zg2KGerKSALU00M1Wt+ZixciLfh0VmX9ASHsy/ivEq+f/7ADjNgXCWd1s2dWLhbt94J9jx/t5C+/eVnsI4K0i8OsFEq4TigAPLL6L1yyT07imP33Xy+ddYCcxH+9mS+BGdmlBw5vnvRTwYpameuwcGGCdcn7gRnZXk8ojPpe3jG6qED7K5mJ5BcYDhtsvladnn1KlbtS7eGUqk1E/Fmky2QUUH1itoaDjM6ykE2eb4f6MDeH33dMjennH4SmXM/EF9wTluxkPGIRcIvs6JHUMmRV4ILrLT31EPzSwg/9t14cKpU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1721e0f2-7a87-4a0f-0680-08d61459e979
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:11.9229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
index dfba44a40f0b..fe45d6cad6cd 100644
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
