Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1CDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD8320685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SQWBplFS";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="kat91Bib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfBTLDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:03:08 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:41368 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727695AbfBTLDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:03:01 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KB08VC012140;
        Wed, 20 Feb 2019 03:02:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Bm0HEVsxeUEXCA80njpkZJxSHyeZNjhZlaMrdHpnDec=;
 b=SQWBplFS4WoGqhCDW2tdyi77CJ7RJpN/5XcOi/SRJ3N6dj2QRgmHUR/aKcXvBtR+k1aa
 nWsUyxo2f1zXNWmRI6MG8sqdEk+sEoeYGT/gFXgDsk0pqnXHP2Min/+vckDNWWdd5n9a
 8NasEVo1/OzE3+ub2BkTpcY6oQ7whqMtIhIrMfYxD+akLVOsFKGNVi+i7lJX4yjycG9M
 9BWgnTSj8s1fUZqYRWkAfKqUbEaJRDdSW2Ynj+O3EI9P2a3FR2x37BQe6PMDAyf8yPLE
 Mc3+dk0XEvuSvOFcxp9HpGsDv7FIrguYh0qsgWiuzK7u7c/lUXKB5bIqW+usn46T52Ju Mg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qrh8xbr2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 03:02:51 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Feb
 2019 03:02:50 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Feb 2019 03:02:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm0HEVsxeUEXCA80njpkZJxSHyeZNjhZlaMrdHpnDec=;
 b=kat91Bibq2AbvlQXUvXrjY1F/x1qbTDEe+ZgcB+hcRhZyE7kdEXp7ZqpEqXaRSLeK1gk/9IKTvENFbx/lej7e0yvdNEmdquWfzqS32DTtgsy3q4Abx26klySw85xdpXqFSlAwMgVdJnfyIbUaMg4cBB5t3KhUAp2cC2DdNr67W8=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB1350.namprd18.prod.outlook.com (10.173.247.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 11:02:46 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 11:02:46 +0000
From:   Vadim Lomovtsev <vlomovtsev@marvell.com>
To:     "sgoutham@cavium.com" <sgoutham@cavium.com>,
        "sunil.kovvuri@gmail.com" <sunil.kovvuri@gmail.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "dnelson@redhat.com" <dnelson@redhat.com>,
        Vadim Lomovtsev <vlomovtsev@marvell.com>
Subject: [PATCH v3 6/8] net: thunderx: add mutex to protect mailbox from
 concurrent calls for same VF
Thread-Topic: [PATCH v3 6/8] net: thunderx: add mutex to protect mailbox from
 concurrent calls for same VF
Thread-Index: AQHUyQvOVRRvbB8gek2WSVgPEu58Rg==
Date:   Wed, 20 Feb 2019 11:02:44 +0000
Message-ID: <20190220110225.9497-7-vlomovtsev@marvell.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20190220110225.9497-1-vlomovtsev@marvell.com>
In-Reply-To: <20190220110225.9497-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbf4cede-d842-43f6-8012-08d69722f1ef
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1350;
x-ms-traffictypediagnostic: CY4PR18MB1350:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1350;20:PFqfnNSguQSny6TkDCNhnD+SBZbzveoA+W4zZ9xPyOPGqBSXvF5OtMiIBMIXe9UaC9R1/Fhcrd7A8h6H9GtPV+g+BXAmXgnNzqX7cm95ov7chpP7wShE50fKd6wldTpuXeQR5k7tPkf6ZDeLj7yHgVbwMyLTlblLadKgQOoqk+w=
x-microsoft-antispam-prvs: <CY4PR18MB13509FE2DE6AED883CA37729CD7D0@CY4PR18MB1350.namprd18.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(86362001)(97736004)(478600001)(476003)(11346002)(2616005)(14444005)(68736007)(446003)(6512007)(5660300002)(256004)(186003)(99286004)(14454004)(76176011)(2906002)(36756003)(6486002)(2201001)(102836004)(6506007)(2501003)(6436002)(26005)(316002)(8936002)(305945005)(15650500001)(7736002)(25786009)(1076003)(53936002)(71200400001)(54906003)(81156014)(4326008)(110136005)(106356001)(107886003)(66066001)(81166006)(6116002)(8676002)(71190400001)(105586002)(3846002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1350;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cDpcc9VKLV2i9NBP6lpJ3gOvGq+Jv2kj8N//k8D3nXdO8Z6bZhOTyy6Y5l28qcz3otD5jVTD8nHaSjli8edY95PIQZjp4DXmRsUH9KkDIc86L/EsHOUoMfjCIWSEjmg3nAs0fvQEy6DvU5Uv+in0S5fsAmKSUloPaEzqB1e/Q/MNeZzdZCRY1yO/+dTf7VK/aF4GheNVWSR+qGpPnECNu1Nklym8fb0R148S1eHg/46gua6FUHNoJRySKLZEWyhMNF+CioDzSNPKmsO+KVa+JrJsFr5bk9DbTaQ1Stnas6ZvzPtD4DO4fpICQz8DEkwdOOEL/1eO9Jdl9+cuYk9xf6Mhh0Pr4/P6d3DQkUsS9qt7Lo9wGPZzS6Eb8ZO7D61qEa3WQFeEhlSzL/HZPdKOvXfEBqrz/kQtgz40MSEtMEs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf4cede-d842-43f6-8012-08d69722f1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:02:44.9079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1350
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_09:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=601 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases it could happen that nicvf_send_msg_to_pf() could be called
concurrently for the same NIC VF, and thus re-writing mailbox contents and
breaking messaging sequence with PF by re-writing NICVF data.

This commit is to implement mutex for NICVF to protect mailbox registers
and NICVF messaging control data from concurrent access.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h        |  2 ++
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethern=
et/cavium/thunder/nic.h
index 227343625e83..86cda3f4b37b 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -329,6 +329,8 @@ struct nicvf {
 	spinlock_t              rx_mode_wq_lock;
 	/* workqueue for handling kernel ndo_set_rx_mode() calls */
 	struct workqueue_struct *nicvf_rx_mode_wq;
+	/* mutex to protect VF's mailbox contents from concurrent access */
+	struct mutex            rx_mode_mtx;
=20
 	/* PTP timestamp */
 	struct cavium_ptp	*ptp_clock;
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index da5986ca7bee..2332e3e95e0e 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -124,6 +124,9 @@ int nicvf_send_msg_to_pf(struct nicvf *nic, union nic_m=
bx *mbx)
 {
 	int timeout =3D NIC_MBOX_MSG_TIMEOUT;
 	int sleep =3D 10;
+	int ret =3D 0;
+
+	mutex_lock(&nic->rx_mode_mtx);
=20
 	nic->pf_acked =3D false;
 	nic->pf_nacked =3D false;
@@ -136,7 +139,8 @@ int nicvf_send_msg_to_pf(struct nicvf *nic, union nic_m=
bx *mbx)
 			netdev_err(nic->netdev,
 				   "PF NACK to mbox msg 0x%02x from VF%d\n",
 				   (mbx->msg.msg & 0xFF), nic->vf_id);
-			return -EINVAL;
+			ret =3D -EINVAL;
+			break;
 		}
 		msleep(sleep);
 		if (nic->pf_acked)
@@ -146,10 +150,12 @@ int nicvf_send_msg_to_pf(struct nicvf *nic, union nic=
_mbx *mbx)
 			netdev_err(nic->netdev,
 				   "PF didn't ACK to mbox msg 0x%02x from VF%d\n",
 				   (mbx->msg.msg & 0xFF), nic->vf_id);
-			return -EBUSY;
+			ret =3D -EBUSY;
+			break;
 		}
 	}
-	return 0;
+	mutex_unlock(&nic->rx_mode_mtx);
+	return ret;
 }
=20
 /* Checks if VF is able to comminicate with PF
@@ -2208,6 +2214,7 @@ static int nicvf_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
 							nic->vf_id);
 	INIT_WORK(&nic->rx_mode_work.work, nicvf_set_rx_mode_task);
 	spin_lock_init(&nic->rx_mode_wq_lock);
+	mutex_init(&nic->rx_mode_mtx);
=20
 	err =3D register_netdev(netdev);
 	if (err) {
--=20
2.17.2
