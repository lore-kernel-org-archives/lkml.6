Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC9AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D846720657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bEpEL+6P";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Fu08aNLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfANNxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:53:08 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:40250 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbfANNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:53:07 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0EDoMGG026842;
        Mon, 14 Jan 2019 05:52:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=Mvp/pFsiFeyK8ZeeErJnLoo9ul6u2uZz7tec7jQ+CEs=;
 b=bEpEL+6PSKWRyFmNsjRiP4kg6AHdk4efsLtP/2WTZS5RWJyrsujagtzmSXWmKChftcrB
 NLV6F3+2trluq+Fau+p+x4Xyku4vkJgC3UT4Nsqpgy/V4Ncsrau5dLna73lXgW1quudC
 YXA7/8DHn40zaViU35sPM/MZ2Js9Vpqs8JldnQSLnxrX2iXLJtnbJNGmLOTjrAk4GDzt
 voU+c5to1fX4pYW9Z8hydoIQyarD4uJFH5/a541/cJyAIVhoEO1iYzPS+JJgHghPunp/
 tPQcJX/WvRPhGJ0DkPvXG9KYz4ZJrRF5s82eZ1qOrITQF4v+BYPZyeyGVXYeZXXVNFyR lw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2q0q7dh2ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 14 Jan 2019 05:52:30 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 14 Jan
 2019 05:52:29 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 14 Jan 2019 05:52:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mvp/pFsiFeyK8ZeeErJnLoo9ul6u2uZz7tec7jQ+CEs=;
 b=Fu08aNLnl+YAfoDOH7atn5Y6+r2jtAFHCpWNRIH291ElIGXktMI8rPO7rQHLKcxAf+3+0vyvmRK3LQT9Lep90zmlQDSRC5RbcLJm4viXVFWNN/fHyHyRpHRUgPydSZAuZrRpzraruCgwdo7G2NAUxZihhWA6A81NR7BBnuRnpeo=
Received: from MN2PR18MB2797.namprd18.prod.outlook.com (20.179.20.218) by
 MN2PR18MB3069.namprd18.prod.outlook.com (20.178.255.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Mon, 14 Jan 2019 13:52:24 +0000
Received: from MN2PR18MB2797.namprd18.prod.outlook.com
 ([fe80::416e:4d2f:ff08:afaf]) by MN2PR18MB2797.namprd18.prod.outlook.com
 ([fe80::416e:4d2f:ff08:afaf%2]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 13:52:24 +0000
From:   Nagadheeraj Rottela <rnagadheeraj@marvell.com>
To:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Srikanth Jampala" <jsrikanth@marvell.com>,
        Nagadheeraj Rottela <rnagadheeraj@marvell.com>
Subject: [PATCH] crypto: cavium/nitrox - Invoke callback after DMA unmap
Thread-Topic: [PATCH] crypto: cavium/nitrox - Invoke callback after DMA unmap
Thread-Index: AQHUrBBgBV2sbd5SxkKZY/Lwo/ur4g==
Date:   Mon, 14 Jan 2019 13:52:24 +0000
Message-ID: <20190114135204.20693-1-rnagadheeraj@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::11) To MN2PR18MB2797.namprd18.prod.outlook.com
 (2603:10b6:208:3b::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [115.113.156.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR18MB3069;20:xT4DJ2BwmQNBdVrJJ/6lkJ8cKl5Jnij+q59GSPKNTlGOPc3pq9sXfUS6SQqN0SOsd1ZHGxSWhsddVOlYoTRN24Oxso5zZah71hYWbj2gXo2qMmSXorlWeNiW+xDa0wQrt4Z0keXeJ5UQWXWrygUu3n6wsNR7+9B8vQtWC9zTaw8=
x-ms-office365-filtering-correlation-id: fe29b619-e5cf-4e55-72b2-08d67a2782fd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MN2PR18MB3069;
x-ms-traffictypediagnostic: MN2PR18MB3069:
x-microsoft-antispam-prvs: <MN2PR18MB30693DCD2042FD7581DEE012D6800@MN2PR18MB3069.namprd18.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39830400003)(376002)(346002)(136003)(366004)(199004)(189003)(2906002)(305945005)(4326008)(478600001)(110136005)(316002)(54906003)(66066001)(1076003)(71200400001)(71190400001)(53936002)(14454004)(6506007)(86362001)(25786009)(55236004)(7736002)(107886003)(26005)(6512007)(102836004)(105586002)(106356001)(386003)(52116002)(186003)(97736004)(6436002)(2616005)(8676002)(6116002)(476003)(81156014)(81166006)(36756003)(8936002)(6486002)(2501003)(68736007)(5660300001)(99286004)(256004)(14444005)(3846002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3069;H:MN2PR18MB2797.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UvTkSA5EpzfUnC/lI3bEbPWg2rBGG3RTNwJrAxfteDNCp608EZdVddFqw1rxdgpGkLJMuwvSoZuKqsE7EfTpuf4IHos3Rjkt62NJ+0ShrH9lmGxf/mBixE9MxvI1lOcYSw1sghXTZasi6Es7Ue3H7nmV+zFXdirar43zy3y8P8zPWvhCEnn1TSV6ujAPUBbiZ9xiWCGxJ7uORZ6CMFTJcDFqZ9Jry3gRIaK74SpJqyWHhthwvDrDzbVXnimM5b+qPMbEZln022IYSPvIfb86YXTEzJ4cPw57aMyicoS1wG4uFe465/wVp6X5Ykl03Ym3NEY01XNfvwEvjT36DiUmrv9vyT4s2KQ4safdvqhcevjMyCWsPG5Eg6kz0TM6uhkZmzuxAqb7g6s9s4Tr9alPOq3PiZPju/wHpje3FR3gaF8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe29b619-e5cf-4e55-72b2-08d67a2782fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 13:52:24.1496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3069
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=693 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In process_response_list() invoke the callback handler after unmapping
the DMA buffers. It ensures DMA data is synced form device to cpu
before the client code access the data from callback handler.

Fixes: c9613335bf4f ("crypto: cavium/nitrox - Added AEAD cipher support")
Signed-off-by: Nagadheeraj Rottela <rnagadheeraj@marvell.com>
---
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c b/drivers/crypto/=
cavium/nitrox/nitrox_reqmgr.c
index fe070d75c842..4c97478d44bd 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_reqmgr.c
@@ -537,6 +537,8 @@ static void process_response_list(struct nitrox_cmdq *c=
mdq)
 	struct nitrox_device *ndev =3D cmdq->ndev;
 	struct nitrox_softreq *sr;
 	int req_completed =3D 0, err =3D 0, budget;
+	completion_t callback;
+	void *cb_arg;
=20
 	/* check all pending requests */
 	budget =3D atomic_read(&cmdq->pending_count);
@@ -564,13 +566,13 @@ static void process_response_list(struct nitrox_cmdq =
*cmdq)
 		smp_mb__after_atomic();
 		/* remove from response list */
 		response_list_del(sr, cmdq);
-
 		/* ORH error code */
 		err =3D READ_ONCE(*sr->resp.orh) & 0xff;
-
-		if (sr->callback)
-			sr->callback(sr->cb_arg, err);
+		callback =3D sr->callback;
+		cb_arg =3D sr->cb_arg;
 		softreq_destroy(sr);
+		if (callback)
+			callback(cb_arg, err);
=20
 		req_completed++;
 	}
--=20
2.13.6

