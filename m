Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4F5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D58020685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZThYU8be";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="l69bHBuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfBTLDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:03:17 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:41416 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727887AbfBTLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:03:10 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KB08VD012140;
        Wed, 20 Feb 2019 03:02:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=5tTNCyXElGO2nWNZhl//GZnpsQICqrJSkoi0YNHBgIA=;
 b=ZThYU8besTJ6VVp8HZBiVUy76P6DdBSxMP5ZvcgQTFjnwdLXi8SbZVqsFzLFunm6YQTI
 SUKI8IKznlYepSP6JpJqebm0gUFtNfXjJd+bsuBOKzqGAnxdaM5KGUx3lCBJ4Xc0Ggnx
 /3hoScxPEwXndU1glFsQjvF0mGD0KbhWOzc3Io/OmdWEe94qlcDgJKYoZROCqdTUmDZ8
 1d1aluXmIY6Vo1Wk83NF/TWDvvXU6hkP/bwgMJRFwInZ0fbMR5cvx5F66i/zZMV3OwMs
 X23VvfPCIFexUGvmqcLdy9TxorUqOTu9lseFSlkWR4wKtV/aCah9k1twANlR7RfFEIMK vw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qrh8xbr2r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 03:02:52 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Feb
 2019 03:02:51 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Feb 2019 03:02:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tTNCyXElGO2nWNZhl//GZnpsQICqrJSkoi0YNHBgIA=;
 b=l69bHBuU3mbu9Glibo30um39mvY6H/KYjqUOCgv9r4gcc81J5rUJYdZI+wuJRkcVTFycdWc5GGAIlxCaaHhhmEwZYtfwkhLO/iqbqftBXZb6t9GqDbwO4h8zoshcARq1Ss8u4ryUfJGx2l2PzYs0d5GVUt+0m6nT4ZHvANWHHNQ=
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
Subject: [PATCH v3 7/8] net: thunderx: move link state polling function to VF
Thread-Topic: [PATCH v3 7/8] net: thunderx: move link state polling function
 to VF
Thread-Index: AQHUyQvOeMTHUI5Z20ii+cNR7DGtew==
Date:   Wed, 20 Feb 2019 11:02:45 +0000
Message-ID: <20190220110225.9497-8-vlomovtsev@marvell.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20190220110225.9497-1-vlomovtsev@marvell.com>
In-Reply-To: <20190220110225.9497-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4a0a04f-85a4-43b6-a7ce-08d69722f22d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1350;
x-ms-traffictypediagnostic: CY4PR18MB1350:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1350;20:+1pD+dYdyRM1osTgbY6VYZuc5auR5vDJUEig9IuSn+1bZZ6Eyu7gpOdb5UywzfRYCD8zNMEV5Ze2sYWEeXkCFQrCHb7Ab8xiV7QAlF2hZlORUlvJ1my6Ur6RQEhUHE3k7vs+DJ44UXpvPPNfkJYQJTfYEkpISLksSvE8gs3FlXU=
x-microsoft-antispam-prvs: <CY4PR18MB13506CA55B4F817AF3080AA0CD7D0@CY4PR18MB1350.namprd18.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(86362001)(97736004)(478600001)(476003)(11346002)(2616005)(14444005)(68736007)(446003)(6512007)(5660300002)(256004)(186003)(99286004)(14454004)(76176011)(2906002)(36756003)(6486002)(2201001)(102836004)(6506007)(2501003)(6436002)(26005)(316002)(8936002)(305945005)(7736002)(25786009)(1076003)(53936002)(71200400001)(54906003)(81156014)(4326008)(110136005)(106356001)(107886003)(66066001)(81166006)(6116002)(8676002)(71190400001)(105586002)(3846002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1350;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7NYT+5F9cXm2RT2vAmMMPpWwevpfAJh8U+a9eRcfgCP3PgHfTAJrHRRHpl5kCAaDVQJguvf+4+zEGfNXBaxC2TJUrx7PrsN+sM+NT06vFgYuTovJxqnR2RRMwpiwK2qNql+dXQcRf+a/x4+fGkg8Nu3AaZd6gENA6J/QOk7ixU/DXXc0vlRd6zVcRKpkMBoIMaod2Ocz3SXL3JdUxZOAAY1gXepmy9PlL9/aWmefyfy8evKsbFQxrBoMWAQQ5FMg+zpIaPJ7cQyLUHs4A0WlFe11HW0oTttfSC1IWq8CEMgQ07yEO9ru2sytX1xnGli/jMEmN9zpbWqCExGluvL7JmRrPiiQVm5NaEJLr7VuKjqCSrk1nnXYnKl+rdyPRe92BUNS8If9H+ykz4k7tPZ712F0eVa7hMS4G3EYQwxc9tA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a0a04f-85a4-43b6-a7ce-08d69722f22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:02:45.2992
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
 mlxlogscore=984 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the link change polling task to VF side in order to
prevent races between VF and PF while sending link change
message(s). This commit is to implement link change request
to be initiated by VF.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h     |  2 +-
 .../net/ethernet/cavium/thunder/nic_main.c    | 39 ++++++++++++--
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 52 +++++++++++++------
 3 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethern=
et/cavium/thunder/nic.h
index 86cda3f4b37b..62636c1ed141 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -331,7 +331,7 @@ struct nicvf {
 	struct workqueue_struct *nicvf_rx_mode_wq;
 	/* mutex to protect VF's mailbox contents from concurrent access */
 	struct mutex            rx_mode_mtx;
-
+	struct delayed_work	link_change_work;
 	/* PTP timestamp */
 	struct cavium_ptp	*ptp_clock;
 	/* Inbound timestamping is on */
diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/e=
thernet/cavium/thunder/nic_main.c
index 620dbe082ca0..8ab71dae3988 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -929,6 +929,35 @@ static void nic_config_timestamp(struct nicpf *nic, in=
t vf, struct set_ptp *ptp)
 	nic_reg_write(nic, NIC_PF_PKIND_0_15_CFG | (pkind_idx << 3), pkind_val);
 }
=20
+static void nic_link_status_get(struct nicpf *nic, u8 vf)
+{
+	union nic_mbx mbx =3D {};
+	struct bgx_link_status link;
+	u8 bgx, lmac;
+
+	mbx.link_status.msg =3D NIC_MBOX_MSG_BGX_LINK_CHANGE;
+
+	/* Get BGX, LMAC indices for the VF */
+	bgx =3D NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+	lmac =3D NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+
+	/* Get interface link status */
+	bgx_get_lmac_link_state(nic->node, bgx, lmac, &link);
+
+	nic->link[vf] =3D link.link_up;
+	nic->duplex[vf] =3D link.duplex;
+	nic->speed[vf] =3D link.speed;
+
+	/* Send a mbox message to VF with current link status */
+	mbx.link_status.link_up =3D link.link_up;
+	mbx.link_status.duplex =3D link.duplex;
+	mbx.link_status.speed =3D link.speed;
+	mbx.link_status.mac_type =3D link.mac_type;
+
+	/* reply with link status */
+	nic_send_msg_to_vf(nic, vf, &mbx);
+}
+
 /* Interrupt handler to handle mailbox messages from VFs */
 static void nic_handle_mbx_intr(struct nicpf *nic, int vf)
 {
@@ -1108,6 +1137,13 @@ static void nic_handle_mbx_intr(struct nicpf *nic, i=
nt vf)
 		lmac =3D NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
 		bgx_set_xcast_mode(nic->node, bgx, lmac, mbx.xcast.mode);
 		break;
+	case NIC_MBOX_MSG_BGX_LINK_CHANGE:
+		if (vf >=3D nic->num_vf_en) {
+			ret =3D -1; /* NACK */
+			break;
+		}
+		nic_link_status_get(nic, vf);
+		goto unlock;
 	default:
 		dev_err(&nic->pdev->dev,
 			"Invalid msg from VF%d, msg 0x%x\n", vf, mbx.msg.msg);
@@ -1419,9 +1455,6 @@ static int nic_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *ent)
 		goto err_disable_sriov;
 	}
=20
-	INIT_DELAYED_WORK(&nic->dwork, nic_poll_for_link);
-	queue_delayed_work(nic->check_link, &nic->dwork, 0);
-
 	return 0;
=20
 err_disable_sriov:
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index 2332e3e95e0e..503cfadff4ac 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -242,21 +242,24 @@ static void  nicvf_handle_mbx_intr(struct nicvf *nic)
 		break;
 	case NIC_MBOX_MSG_BGX_LINK_CHANGE:
 		nic->pf_acked =3D true;
-		nic->link_up =3D mbx.link_status.link_up;
-		nic->duplex =3D mbx.link_status.duplex;
-		nic->speed =3D mbx.link_status.speed;
-		nic->mac_type =3D mbx.link_status.mac_type;
-		if (nic->link_up) {
-			netdev_info(nic->netdev, "Link is Up %d Mbps %s duplex\n",
-				    nic->speed,
-				    nic->duplex =3D=3D DUPLEX_FULL ?
-				    "Full" : "Half");
-			netif_carrier_on(nic->netdev);
-			netif_tx_start_all_queues(nic->netdev);
-		} else {
-			netdev_info(nic->netdev, "Link is Down\n");
-			netif_carrier_off(nic->netdev);
-			netif_tx_stop_all_queues(nic->netdev);
+		if (nic->link_up !=3D mbx.link_status.link_up) {
+			nic->link_up =3D mbx.link_status.link_up;
+			nic->duplex =3D mbx.link_status.duplex;
+			nic->speed =3D mbx.link_status.speed;
+			nic->mac_type =3D mbx.link_status.mac_type;
+			if (nic->link_up) {
+				netdev_info(nic->netdev,
+					    "Link is Up %d Mbps %s duplex\n",
+					    nic->speed,
+					    nic->duplex =3D=3D DUPLEX_FULL ?
+					    "Full" : "Half");
+				netif_carrier_on(nic->netdev);
+				netif_tx_start_all_queues(nic->netdev);
+			} else {
+				netdev_info(nic->netdev, "Link is Down\n");
+				netif_carrier_off(nic->netdev);
+				netif_tx_stop_all_queues(nic->netdev);
+			}
 		}
 		break;
 	case NIC_MBOX_MSG_ALLOC_SQS:
@@ -1325,6 +1328,8 @@ int nicvf_stop(struct net_device *netdev)
 	struct nicvf_cq_poll *cq_poll =3D NULL;
 	union nic_mbx mbx =3D {};
=20
+	cancel_delayed_work_sync(&nic->link_change_work);
+
 	/* wait till all queued set_rx_mode tasks completes */
 	drain_workqueue(nic->nicvf_rx_mode_wq);
=20
@@ -1427,6 +1432,18 @@ static int nicvf_update_hw_max_frs(struct nicvf *nic=
, int mtu)
 	return nicvf_send_msg_to_pf(nic, &mbx);
 }
=20
+static void nicvf_link_status_check_task(struct work_struct *work_arg)
+{
+	struct nicvf *nic =3D container_of(work_arg,
+					 struct nicvf,
+					 link_change_work.work);
+	union nic_mbx mbx =3D {};
+	mbx.msg.msg =3D NIC_MBOX_MSG_BGX_LINK_CHANGE;
+	nicvf_send_msg_to_pf(nic, &mbx);
+	queue_delayed_work(nic->nicvf_rx_mode_wq,
+			   &nic->link_change_work, 2 * HZ);
+}
+
 int nicvf_open(struct net_device *netdev)
 {
 	int cpu, err, qidx;
@@ -1533,6 +1550,11 @@ int nicvf_open(struct net_device *netdev)
 	/* Send VF config done msg to PF */
 	nicvf_send_cfg_done(nic);
=20
+	INIT_DELAYED_WORK(&nic->link_change_work,
+			  nicvf_link_status_check_task);
+	queue_delayed_work(nic->nicvf_rx_mode_wq,
+			   &nic->link_change_work, 0);
+
 	return 0;
 cleanup:
 	nicvf_disable_intr(nic, NICVF_INTR_MBOX, 0);
--=20
2.17.2
