Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F39217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="N6NM20u0";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="qSKiwAIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfBRJwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:52:40 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56018 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727414AbfBRJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:52:35 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1I9qE5d025142;
        Mon, 18 Feb 2019 01:52:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=hhtZVHCRcI1BBAdinCqqmRaof8yQo0lW3rGEBD9Baew=;
 b=N6NM20u0VV79QqFml7G2SS9Wb+OM2/FB0qlA96jBZ5zuRGeBbtfE7QMvuuhA1IhESOFa
 15WF0GeZRVwNk1ZSlz8NnZiNkN2YGHlZDll9YPpamdyjCzI/CNcBRwS9WKjlGDoilYyA
 fA2c7OVTvp6dKx/6kEEj6/PJzjZNfswdXNdazFc+nSzYYdRbZvT5FX6wZZYiWse8/m0z
 x4DBJAFn0cXlxSOFOQGtjspOl3Tane80k0Swqlg9GFymhDzFAueonbU8jbYvx1VHt9x9
 Gj2C44nkW8HRrxycGhzNEM3BKF7ciQldnnIVvMJ9RV6xHupn7mF44LZM4fNEgfzIqIcz eQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qpjwpw14e-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 01:52:23 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 18 Feb
 2019 01:52:20 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 Feb 2019 01:52:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhtZVHCRcI1BBAdinCqqmRaof8yQo0lW3rGEBD9Baew=;
 b=qSKiwAIUg3UFz1B1HLtuCWY4Fk+ggcFLFaIGye+sBqWuV4w3jaszHafOuL8mObPKLpBb/2H9hwgcLsVBientwirAynbxzX06wljunScRZGagRCsiAbtk6DwCPHQWj52i8wpKVg3KXc6fUJt1f2KlG7l1hIkxWvnxOFLk5phgbK8=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB0968.namprd18.prod.outlook.com (10.173.182.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Mon, 18 Feb 2019 09:52:16 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1622.020; Mon, 18 Feb 2019
 09:52:16 +0000
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
Subject: [PATCH v2 4/8] net: thunderx: add nicvf_send_msg_to_pf result check
 for set_rx_mode_task
Thread-Topic: [PATCH v2 4/8] net: thunderx: add nicvf_send_msg_to_pf result
 check for set_rx_mode_task
Thread-Index: AQHUx2+gKELUmj4/e0W3KtlNy90j+w==
Date:   Mon, 18 Feb 2019 09:52:15 +0000
Message-ID: <20190218095159.3847-5-vlomovtsev@marvell.com>
References: <20190218095159.3847-1-vlomovtsev@marvell.com>
In-Reply-To: <20190218095159.3847-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4590be43-f6d7-4345-ddaa-08d69586c40c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB0968;
x-ms-traffictypediagnostic: CY4PR18MB0968:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB0968;20:eXAmt3iT9nyBC3ZKo6AZo3Pbw+A54DPFp0Ft7lZhS3vm21HbtMUy3UMyOECty5pCB4T7rPV+05V5aRTLw09ZftWf1mk1RIysEkvBNOUm2xZJNZuU66RaSlrp6N0H5Y4aQ3vMn9ccszk7zKNDuSecwxNnZiNneukHUT5qUpwDcxU=
x-microsoft-antispam-prvs: <CY4PR18MB09685494CC7A40435DFBD68ACD630@CY4PR18MB0968.namprd18.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(486006)(7736002)(305945005)(316002)(4326008)(110136005)(54906003)(25786009)(99286004)(8936002)(476003)(5660300002)(186003)(2616005)(76176011)(81166006)(81156014)(6436002)(446003)(11346002)(14454004)(2906002)(8676002)(71190400001)(71200400001)(6506007)(256004)(68736007)(1076003)(2501003)(2201001)(36756003)(6486002)(53936002)(86362001)(106356001)(102836004)(26005)(97736004)(3846002)(105586002)(66066001)(6116002)(478600001)(6512007)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB0968;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A30TjzFlgc/FcQD9G0QjVrnNKdIqpl9sGmagQCdqz8+3WPZ51z88JkWpf7eDYyyppRemrsShWFkwLXDIQcvq/VetS2nAca0lrkfkd4Pf6YJA/qJtDSerqsAnPLGht3NLv8QwT4gIKhMJsdVCcQYOEBivRF/Ajw1k9wdznNIO+i4uL4XCXyHoFJqppugqtpIcNyvGzO/FX+pndipN15IpOt/sxn/W7KFGLAbaunPukk7wveSNHA6bKZP8bqmvrBP2D/Z2sDO0R0a+SvtPdLqlF98XNrIl/pAMr5W5sgUkBpGrKCtECJWAWM8tqs6B9S9NHn4FiaUNSVChg/9HCzuSc6SdrehvvIALXytmBO7BguMGBgQ0cOt25Xn3o1IvHvB/4VQ3uMdkz2Tf3hFyxFhYLXB7RQJ6sFaw+6dFJ7wo2No=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4590be43-f6d7-4345-ddaa-08d69586c40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 09:52:15.3426
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rx_set_mode invokes number of messages to be send to PF for receive
mode configuration. In case if there any issues we need to stop sending
messages and release allocated memory.

This commit is to implement check of nicvf_msg_send_to_pf() result.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index b0e8a04e0f1e..dbd8862d60d6 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1956,7 +1956,8 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
=20
 	/* flush DMAC filters and reset RX mode */
 	mbx.xcast.msg =3D NIC_MBOX_MSG_RESET_XCAST;
-	nicvf_send_msg_to_pf(nic, &mbx);
+	if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
+		goto free_mc;
=20
 	if (mode & BGX_XCAST_MCAST_FILTER) {
 		/* once enabling filtering, we need to signal to PF to add
@@ -1964,7 +1965,8 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
 		 */
 		mbx.xcast.msg =3D NIC_MBOX_MSG_ADD_MCAST;
 		mbx.xcast.data.mac =3D 0;
-		nicvf_send_msg_to_pf(nic, &mbx);
+		if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
+			goto free_mc;
 	}
=20
 	/* check if we have any specific MACs to be added to PF DMAC filter */
@@ -1973,9 +1975,9 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
 		for (idx =3D 0; idx < mc_addrs->count; idx++) {
 			mbx.xcast.msg =3D NIC_MBOX_MSG_ADD_MCAST;
 			mbx.xcast.data.mac =3D mc_addrs->mc[idx];
-			nicvf_send_msg_to_pf(nic, &mbx);
+			if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
+				goto free_mc;
 		}
-		kfree(mc_addrs);
 	}
=20
 	/* and finally set rx mode for PF accordingly */
@@ -1983,6 +1985,8 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
 	mbx.xcast.data.mode =3D mode;
=20
 	nicvf_send_msg_to_pf(nic, &mbx);
+free_mc:
+	kfree(mc_addrs);
 }
=20
 static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
--=20
2.17.2
