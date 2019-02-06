Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26846C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA67420823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OpJz7wL1";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Msn8X0+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfBFKOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:14:45 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:39680 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729187AbfBFKOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:14:07 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16AA358016805;
        Wed, 6 Feb 2019 02:14:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=mD57Pz4kw6vQvhnuaEVlrO3B59YB1i1nAdFGqNum71s=;
 b=OpJz7wL1nsRqaFVM2UmR5opGEyqAob7nUPa/RnIwhkAeBCnJEJZfX20ucf/NpKoZy8Ck
 2uJaf+HIvYX9kz/NasljvizSsNjlLfaFRkhbfAOwCKFy/bVzsFaRqw34g7cZu8vMQWFl
 jN/Dqsk2VGV4q/dLQK5NFjoVXBrYH2ZDzaVvCOxzNoLMAMKKCiJDqsY33KE6rXIk8GZ7
 2Jao9B+1lfnBFJKl2Jg6Gd7m76FjmlKyS5CbJhlrWqdrILrj6zIJt8LeoSZ/W4ejE9zu
 cEJw9u7WGKoj67G1BQPozE/aDrh8tBfe1rt2jBLj/npv9F/C0+JNAKUfLrHoggM4rHaj zA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2qfc2augvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Feb 2019 02:14:00 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Feb
 2019 02:13:59 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Feb 2019 02:13:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD57Pz4kw6vQvhnuaEVlrO3B59YB1i1nAdFGqNum71s=;
 b=Msn8X0+Z+gbppGIZUF0B1/lIanEPeZzFCAfD4gZbRi9joC0BY60UWRlXSr8b7jOcRftM+nAE+Erg/aIS7xzES+DYSA6j7/vPfmbSxxSh7jT58/dHNyVgdOhfLV5Rm6BxflxUFIEtfjeS9Bm4pTrJ/fGfDM/4hTin4U1TfObPD/Y=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.184.11) by
 CY4PR18MB1238.namprd18.prod.outlook.com (10.172.176.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 10:13:58 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137%10]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 10:13:58 +0000
From:   Vadim Lomovtsev <vlomovtsev@marvell.com>
To:     "sgoutham@cavium.com" <sgoutham@cavium.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "dnelson@redhat.com" <dnelson@redhat.com>,
        Vadim Lomovtsev <vlomovtsev@marvell.com>
Subject: [PATCH 5/8] net: thunderx: rework xcast message structure to make it
 fit into 64 bit
Thread-Topic: [PATCH 5/8] net: thunderx: rework xcast message structure to
 make it fit into 64 bit
Thread-Index: AQHUvgSrY+mmCIeLzkuZ0JIBASS9Tg==
Date:   Wed, 6 Feb 2019 10:13:56 +0000
Message-ID: <20190206101351.16744-6-vlomovtsev@marvell.com>
References: <20190206101351.16744-1-vlomovtsev@marvell.com>
In-Reply-To: <20190206101351.16744-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1238;20:tX/yZcOj9QTmwwX4rEOmkGFZSbg2LyDq7y4nlyjDk+e3nGmEHkaccILOc7b9AU/yYp2SBNDthHzpO35mbfjXcQ7Vvx+x5q8NNcraQqJXFDzmbRV+7MiARvFyJRpNx/Lgf+NGF6ZqfqxpWwo4cND/3NdP9fCNOfNsvpzdg/YnICg=
x-ms-office365-filtering-correlation-id: fe04d8e1-4493-4b6f-8f81-08d68c1bcf21
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1238;
x-ms-traffictypediagnostic: CY4PR18MB1238:
x-microsoft-antispam-prvs: <CY4PR18MB1238BD8BABA131405D2DD412CD6F0@CY4PR18MB1238.namprd18.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(2501003)(14444005)(256004)(2201001)(86362001)(4326008)(105586002)(6512007)(106356001)(36756003)(486006)(68736007)(102836004)(1076003)(6436002)(66066001)(6506007)(97736004)(14454004)(8936002)(71190400001)(26005)(316002)(81166006)(81156014)(11346002)(107886003)(54906003)(110136005)(76176011)(7736002)(8676002)(99286004)(305945005)(71200400001)(186003)(478600001)(15650500001)(6486002)(2906002)(476003)(25786009)(2616005)(446003)(53936002)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1238;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6x4B0coMYuWD5wIJ/f5qmSQtzosbNnZXhSjbnmw7ZdidU4ITWwbHz2EF+0vcOqXX5qMN+ENa8mO9+tszRMcE0ps+LngGYQ8LG1bI7snbPrEDdSLZA97JP8D/XHDNfWiPCcjmWBzRA/Xg9w0SpsI/vwHjKWr4hn+dfLzwieBdIN3LecZEHwOQk5mIThk7LuSofHjA2ll1c9AF4n/cBbPMz9xBRZ3rLT9AuektSjnR6dV6JHPaeMw6wewXMtRcWVmiEM0WemEXm5SjCl3kMWDJWaJOJdh5MCTMZYQONd1ka4R7H5r4Qew+TrlLNpCCB3DzxE2sfiD4N19YeUlqUTqJIkRZX4SdsGrJraZRjFcVKUgFOZPXOgvHWUWkkoE7EdlGqXw1WLDa+IErMQ6H8h5ipIOSgFvbx2PsVfCHD4Mdh68=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe04d8e1-4493-4b6f-8f81-08d68c1bcf21
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 10:13:56.3613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1238
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_06:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=363 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To communicate to PF each of ThunderX NIC VF uses mailbox which is
pair of 64 bit registers available to both VFn and PF.

This commit is to change the xcast message structure in order to
fit it into 64 bit.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h        | 6 ++----
 drivers/net/ethernet/cavium/thunder/nic_main.c   | 4 ++--
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 6 +++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethern=
et/cavium/thunder/nic.h
index 376a96bce33f..227343625e83 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -577,10 +577,8 @@ struct set_ptp {
=20
 struct xcast {
 	u8    msg;
-	union {
-		u8    mode;
-		u64   mac;
-	} data;
+	u8    mode;
+	u64   mac:48;
 };
=20
 /* 128 bit shared memory between PF and each VF */
diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/e=
thernet/cavium/thunder/nic_main.c
index 90497a27df18..620dbe082ca0 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -1094,7 +1094,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, in=
t vf)
 		bgx =3D NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
 		lmac =3D NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
 		bgx_set_dmac_cam_filter(nic->node, bgx, lmac,
-					mbx.xcast.data.mac,
+					mbx.xcast.mac,
 					vf < NIC_VF_PER_MBX_REG ? vf :
 					vf - NIC_VF_PER_MBX_REG);
 		break;
@@ -1106,7 +1106,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, in=
t vf)
 		}
 		bgx =3D NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
 		lmac =3D NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
-		bgx_set_xcast_mode(nic->node, bgx, lmac, mbx.xcast.data.mode);
+		bgx_set_xcast_mode(nic->node, bgx, lmac, mbx.xcast.mode);
 		break;
 	default:
 		dev_err(&nic->pdev->dev,
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index dbd8862d60d6..30c7f54b4f17 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1964,7 +1964,7 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
 		 * its' own LMAC to the filter to accept packets for it.
 		 */
 		mbx.xcast.msg =3D NIC_MBOX_MSG_ADD_MCAST;
-		mbx.xcast.data.mac =3D 0;
+		mbx.xcast.mac =3D 0;
 		if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
 			goto free_mc;
 	}
@@ -1974,7 +1974,7 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
 		/* now go through kernel list of MACs and add them one by one */
 		for (idx =3D 0; idx < mc_addrs->count; idx++) {
 			mbx.xcast.msg =3D NIC_MBOX_MSG_ADD_MCAST;
-			mbx.xcast.data.mac =3D mc_addrs->mc[idx];
+			mbx.xcast.mac =3D mc_addrs->mc[idx];
 			if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
 				goto free_mc;
 		}
@@ -1982,7 +1982,7 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
=20
 	/* and finally set rx mode for PF accordingly */
 	mbx.xcast.msg =3D NIC_MBOX_MSG_SET_XCAST;
-	mbx.xcast.data.mode =3D mode;
+	mbx.xcast.mode =3D mode;
=20
 	nicvf_send_msg_to_pf(nic, &mbx);
 free_mc:
--=20
2.17.2
