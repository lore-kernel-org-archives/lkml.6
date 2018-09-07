Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D206AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8108F20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Tgmvnt4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8108F20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeIGF1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:27:25 -0400
Received: from mail-eopbgr700105.outbound.protection.outlook.com ([40.107.70.105]:7696
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730669AbeIGFSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsnaygC2s5GdQlIbrgeDTviT+Zh8sIktL+JRmW3aZTQ=;
 b=Tgmvnt4OY+/uCvCb274+JXe7neX+T17ooYUKLpHlIoSIMkHsTkzOqYnL2haigK6AwGXkeXszWRyvcl3NposxAGvEOGNwmhm8YVapPirIcBNaagey5+LyNww1tcnXChF3tkzWC7JsVV19kpzOSpT5YmuWGUdIdKcUzzrpt2FXm+M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Fri, 7 Sep 2018 00:40:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:42 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 14/43] IB/rxe: Drop QP0 silently
Thread-Topic: [PATCH AUTOSEL 4.9 14/43] IB/rxe: Drop QP0 silently
Thread-Index: AQHURkMYyIG/fcqSJEGihBPWe/r6bg==
Date:   Fri, 7 Sep 2018 00:38:28 +0000
Message-ID: <20180907003816.57852-14-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:RsAj0sqT4WXRLM1OEG8KFrm++ybCf1UMvsxIGhlO01Ly603tCvFfTGAYa/6rrXO4Ufq7u47pzdk6upzsxZZYb4NK+DPpgCRsZ0/Juq4reB2qXOs9kjGa6K/D3VnWX9Iv0lN5/w2NeHFaM5q/uERoMEJzWnLHM+vcFEYIwC6I4AAQndy2MMlhH5h8v4ts523a3RhPviK95yqEI8VhmPBAAVna2g0fof0PF8FAjpO4rIuqf7SX+OYNRNRa82rt3oh8O4q8Ma+7YkwXY/tpXNI1a6ClSjNR2Sd0VHMsTYdJx3GEVy6nEkQXOTzKWowWC54TndyjBGWz4EQNHOOE3g938O+z8L1RNbVSG886eeiTeNLQryCC5noGvgQlcbY5vveGO+LmyjwQKV6ali+CMohrYJAt8VFSBC0b1NlpwiEzFyZTXuemsT6YPK3y9x9IfzfPMOLhsD2AkfQcgBXYe2KjqA==;5:Q8UUvnfNXORscUX+KvdVS1rOe1aUCuIgElMgIYtV6+7hdusHIhPTXS9LkOH2u+c3KaNvjQQFBV34j9Spv8ze5JaMEWo4qFyloencAKsbX0x5nbPmfwacdSBpUtWGfx9z1HBS69HOTR5hZt7IEUrkngaFp8VT4xAr0PTJmlwBswE=;7:m1Z0ro6HkWOVReJy5s32wImcE93rr/IoNF95qcdH9MndJ2Q4pUKFCZMQqIWKgFWl94nUW51/gAIm8y5WZa5SQderk7m9eLslcudrLhiT39xROq/b9X47/UQSvuNqeHcwLsRLMFrbWgKsAIkCa5dzXYASEW/1yRRo6QgmFIw1e/4zbJhYCeMEq4Ehgf6ssCdt1Xo9XELTvjoda5TpL3POjrG6kXGBBe/IdU5k8BQraXEvaWog5oRmB//Jdy1gg61J
x-ms-office365-filtering-correlation-id: 710a584e-d4fc-4ca3-a290-08d6145a8a6d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB01490DF189A04D4D5E0E460EFB000@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(476003)(2616005)(105586002)(76176011)(446003)(486006)(6666003)(2900100001)(256004)(217873002)(66066001)(22452003)(1076002)(6346003)(316002)(86362001)(25786009)(4326008)(26005)(110136005)(102836004)(54906003)(86612001)(107886003)(6116002)(11346002)(5660300001)(6506007)(2501003)(6486002)(5250100002)(14454004)(7736002)(8936002)(68736007)(3846002)(53936002)(97736004)(6436002)(10090500001)(6512007)(305945005)(478600001)(99286004)(106356001)(81156014)(2906002)(10290500003)(36756003)(81166006)(186003)(8676002)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: tiXrf955YGgGbyBOST/tKByvO4rBh6VDR2HrWtBu87GhN7fApfpw5vygxIUEz/Aoz0XuDOHU9icpbHiS9MGfmdWamOZJD9g9+YYOk1z4O0WgZhpDiJA7h2JywBxlV3pcPcK8AKberpXMbr0z8BjlvnFaXrwe7vy5pGdTf3GunX0HG1xB5Tlik3gnDfwkxwtk6waaDTMFO8TKYzvXs+M/sWKkCL/FhLbD0a4u06OC2quSGB/Tg7dVjRa6oVOuJcpYsZAJhjD2bOmobULLXi0az4mUQXWm64gG0ppKq4E9rA97wAVRBdWS9JvC5RtQ8+d8vDhBW1+QUFgFA5y6vJ3A8RPm33k1K1ZG/wcCLlWde18=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710a584e-d4fc-4ca3-a290-08d6145a8a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:28.7535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
index 46f062842a9a..db6bb026ae90 100644
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
