Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02006217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cLQPeMWo";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="eo1c6LyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfBRJwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:52:34 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56008 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727414AbfBRJwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:52:33 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1I9qE5f025142;
        Mon, 18 Feb 2019 01:52:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=tU6PuN2duHKzBXHAYGpkSYO1zEgzSldYz7FyzRR3jFk=;
 b=cLQPeMWovKdhxWr0jQxiJouNgMcongEwsaQ63uKsAZERCzt0zoxn/y4ojXOLel231aCl
 /r4niFd8li4G0p98Obi9yfUxwbdXlugmufRgSqLf+OG/HcaaaJfiYHhtEwVvBJnsGIb7
 K1YN+AeWKPXN4mMxuKMlq9BrN66sEf30DB/kkkG4Sy2UiEGUowlaP2Nc76f0MdKUiuqu
 Ng6XaoRzVYASyud89hcdX0RjMIRsp1N53AsTuXei4YvhJyMBl2/mMPW++gt/HwXlvI7q
 EteaS7MuIT03R/E5IZzSo0bKQralHRtO2wFQtgQUPVvWPK4aVZWUKhsfCDgDv9EB+QUm mg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qpjwpw14e-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 01:52:24 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 18 Feb
 2019 01:52:21 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 Feb 2019 01:52:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU6PuN2duHKzBXHAYGpkSYO1zEgzSldYz7FyzRR3jFk=;
 b=eo1c6LyLt1lt2qFxHM4/Vqq4jWO8/hriqbMBWgkXRn+oa6ww0KRhgDJ6+yErwAhc5pa0z620aP8T7VZvuFb5CQUUePAR2xDF/3mlwZIsw2DpcWAmcP+e0LaKrwsrfCYr3OqdFhs1qnwiTj1JCy9ogaN+9IrhMY6ffw+lAycZUoM=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB0968.namprd18.prod.outlook.com (10.173.182.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Mon, 18 Feb 2019 09:52:17 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1622.020; Mon, 18 Feb 2019
 09:52:17 +0000
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
Subject: [PATCH v2 6/8] net: thunderx: add mutex to protect mailbox from
 concurrent calls for same VF
Thread-Topic: [PATCH v2 6/8] net: thunderx: add mutex to protect mailbox from
 concurrent calls for same VF
Thread-Index: AQHUx2+hTIFyMZfLski+mfyZ4KOVlg==
Date:   Mon, 18 Feb 2019 09:52:15 +0000
Message-ID: <20190218095159.3847-7-vlomovtsev@marvell.com>
References: <20190218095159.3847-1-vlomovtsev@marvell.com>
In-Reply-To: <20190218095159.3847-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f83702a8-6e69-4564-50eb-08d69586c4c9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB0968;
x-ms-traffictypediagnostic: CY4PR18MB0968:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB0968;20:zC0tjJAALaCXEL8o23yREOWMBiFFJRzY/T9q52icU8OBoW56rbEGNPJ2fIiGW+lcRLowjU/CJRVJWszbYcTx4nzuWt1wnWD46OtB97uU5gPzSCu+70rXLrGhgBWzWTx1W0G7SOFFOsd7J/SpMTcNpmmJz0XHAF0TF4agqjH02i0=
x-microsoft-antispam-prvs: <CY4PR18MB09688AFD86B1298A2039B4A5CD630@CY4PR18MB0968.namprd18.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(486006)(7736002)(305945005)(316002)(4326008)(110136005)(54906003)(25786009)(99286004)(8936002)(476003)(5660300002)(186003)(2616005)(76176011)(81166006)(81156014)(6436002)(446003)(11346002)(14454004)(2906002)(8676002)(71190400001)(71200400001)(14444005)(6506007)(256004)(68736007)(1076003)(2501003)(2201001)(36756003)(6486002)(53936002)(86362001)(106356001)(102836004)(26005)(15650500001)(97736004)(3846002)(105586002)(66066001)(6116002)(478600001)(6512007)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB0968;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zlYKT9DnuuzahpllPqnjUTsd3trjG7A+R7QU5EIOagHV5MCTqP858t3m98xZ5oOXeMgJg026q/fjWRh5Mh4xxxLPDlsqjyC6lDMcr2GlIGlVBZUq5o7h2RSU3RtuHsbykFVo6k8betnlWA3VaiQKK5SqG/BC97yGDSLctcH5DCCRKuqNJ2VpzYOc+rDS+lWL3PqoW+s3x0h6Z3mfdFprit5woHCcu6l40Qieiy9QyRHYf38GWaNE4mwgp9EUDC5fYqrkBTqB1KqTYrcL/6qtk1oYon/Ulx41J+dYVmNgcqqaEJK2akxInhI8noDzZMYp3hv+B6mnurQXssn/OcjZWT3VjfU23IFTXAR66M1aOUPPoEFul4Gq+1qGRz+qwDzI0G4kHzHbmieDIdGAutXMpTj5mooGeifkbD0REoXuKWA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f83702a8-6e69-4564-50eb-08d69586c4c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 09:52:15.9391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB0968
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=588 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180075
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
index 30c7f54b4f17..a05e2989ec76 100644
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
@@ -2211,6 +2217,7 @@ static int nicvf_probe(struct pci_dev *pdev, const st=
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
