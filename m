Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2461EC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EE02173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FO13Lb+t";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="NnFscCFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbeLXQGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 11:06:12 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:44570 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725648AbeLXQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 11:06:12 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBOFtPva014003;
        Mon, 24 Dec 2018 08:06:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=LcyZ0RCuHIanWTuK/q5H6bIG7nAoTlBn/0MZS3toURk=;
 b=FO13Lb+tfCgyhvqGg3jMCH4QHFZZjutOFzo4tKILFybPkmIuklvTN5WUpVlAt0N8MJTY
 LgTu6eltDimLzmWC017J/RTpifGZXrPRbNdBohVuxcUIYUxbEHf4wuaOch/MxPxry9qA
 l3OFop45zE82935GhFNrhKbVrGzti31oIItTJZd4ifSM7xhKe4vaRuk3A5wFxDA7YRbE
 En5A8WTMH1StLMcNd9tw9lQ0brkaDsW3u7aS8gReKPlTiIkzEARfxOi4IxcZ/Ozwt279
 Zgk1j35ZBgXEfAO+e3+J9i/JbkQBaLL81hDq/XiwRsW5P/cBslwi6eI9nr3iDcA+vWBG Yw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2pjv9r1ksp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Dec 2018 08:06:09 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Dec
 2018 08:06:08 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.56) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Dec 2018 08:06:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcyZ0RCuHIanWTuK/q5H6bIG7nAoTlBn/0MZS3toURk=;
 b=NnFscCFzGxz3pF77yK+k5TUOeGapQmjOFqbFCoNbgFci9Pn/jhJyr45HcEURGVIZ0O/G5FR1xyN553E3HjHmMEXzql6EKgbPnXTqBUd1UtIUYYrUizGf7NP/KlgbpCUhbUkYYPX0yVqUmkwRL2U1vy8+G2KtQPV5M5exib+UeUw=
Received: from CY4PR18MB1253.namprd18.prod.outlook.com (10.172.176.11) by
 CY4PR18MB1013.namprd18.prod.outlook.com (10.173.183.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 16:06:06 +0000
Received: from CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::d074:6c50:6559:3baa]) by CY4PR18MB1253.namprd18.prod.outlook.com
 ([fe80::d074:6c50:6559:3baa%12]) with mapi id 15.20.1446.026; Mon, 24 Dec
 2018 16:06:06 +0000
From:   Sudarsana Reddy Kalluru <skalluru@marvell.com>
To:     Ivan Mironov <mironov.ivan@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Ariel Elior <ariel.elior@cavium.com>,
        Sudarsana Kalluru <sudarsana.kalluru@cavium.com>,
        "everest-linux-l2@cavium.com" <everest-linux-l2@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH v2] bnx2x: Fix NULL pointer dereference in
 bnx2x_del_all_vlans() on some hw
Thread-Topic: [EXT] [PATCH v2] bnx2x: Fix NULL pointer dereference in
 bnx2x_del_all_vlans() on some hw
Thread-Index: AQHUm5s/L9O9kr6JuUiJqq8V86uG/qWODVTg
Date:   Mon, 24 Dec 2018 16:06:06 +0000
Message-ID: <CY4PR18MB1253E8A065AB1B9C2241D593D3BB0@CY4PR18MB1253.namprd18.prod.outlook.com>
References: <20181224151305.31027-1-mironov.ivan@gmail.com>
In-Reply-To: <20181224151305.31027-1-mironov.ivan@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2402:3a80:518:4801:dda5:10df:c5f6:ce95]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1013;20:J4HWPyAgoSVAZfp3vgyJCxMJ3ZwIVP+ZnLu6yr6XUk/riGoB9bTbMRBkNWF/efZqBmFG8nzWrc4Ew52c33OdY5W9tLPdz06AUR0SGCOFfnC/cnQJEweVxpWNnL54BeKsuX3mApz1adJygLMBVSHXq2dfS5vLPub2iN22CkkW8t4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b30d98da-544d-46a5-e4d0-08d669b9b641
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1013;
x-ms-traffictypediagnostic: CY4PR18MB1013:
x-microsoft-antispam-prvs: <CY4PR18MB1013E349249B0FA895DA526BD3BB0@CY4PR18MB1013.namprd18.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR18MB1013;BCL:0;PCL:0;RULEID:;SRVR:CY4PR18MB1013;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(376002)(136003)(396003)(366004)(51914003)(199004)(189003)(13464003)(2906002)(478600001)(33656002)(6436002)(7736002)(106356001)(105586002)(186003)(102836004)(99286004)(74316002)(7696005)(76176011)(305945005)(110136005)(54906003)(6506007)(53546011)(71200400001)(71190400001)(14454004)(46003)(316002)(486006)(476003)(256004)(11346002)(446003)(14444005)(575784001)(55016002)(6116002)(9686003)(81156014)(81166006)(86362001)(8676002)(25786009)(68736007)(229853002)(8936002)(97736004)(4326008)(5660300001)(39060400002)(2501003)(6246003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1013;H:CY4PR18MB1253.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: avcDqSAUvwsR/wYvOkTBIDMkxgn5zQ5dSqoCwpG09/ioBqDx6K5Pbx3J3/ZEMzbRFn1HZXsxlpdiRCpl7t+jKHSKJWAWeTkPBRzB6RTHvg3lbI+diHZEjzjLgstrv7KCbrSzzUM+wualVJzyjQkvWneYKP90vnZqWxBUeryf/PPVPNflfYFrOMl8a+1Z+zd2qAHNNFRsAkrUP6l/SlYuSto5TRHDyghpQiduPkYNrSWFS1zA46MX2mMpc8Ay0kqTmLKgJbrblyeSyPwGDPk37Ge1Gk8vuCSsZaNbxYDa4mGXa1bdP6rQxBmfgLxaaMr7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b30d98da-544d-46a5-e4d0-08d669b9b641
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 16:06:06.5410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1013
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-24_09:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812240140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Ivan Mironov [mailto:mironov.ivan@gmail.com]=20
Sent: 24 December 2018 20:43
To: netdev@vger.kernel.org
Cc: Ariel Elior <ariel.elior@cavium.com>; Sudarsana Kalluru <sudarsana.kall=
uru@cavium.com>; everest-linux-l2@cavium.com; David S. Miller <davem@daveml=
oft.net>; linux-kernel@vger.kernel.org; Sudarsana Reddy Kalluru <skalluru@m=
arvell.com>; Ivan Mironov <mironov.ivan@gmail.com>
Subject: [EXT] [PATCH v2] bnx2x: Fix NULL pointer dereference in bnx2x_del_=
all_vlans() on some hw

External Email

----------------------------------------------------------------------
This happened when I tried to boot normal Fedora 29 system with latest avai=
lable kernel (from fedora rawhide, plus some unrelated custom
patches):

	BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
	PGD 0 P4D 0
	Oops: 0010 [#1] SMP PTI
	CPU: 6 PID: 1422 Comm: libvirtd Tainted: G          I       4.20.0-0.rc7.g=
it3.hpsa2.1.fc29.x86_64 #1
	Hardware name: HP ProLiant BL460c G6, BIOS I24 05/21/2018
	RIP: 0010:          (null)
	Code: Bad RIP value.
	RSP: 0018:ffffa47ccdc9fbe0 EFLAGS: 00010246
	RAX: 0000000000000000 RBX: 00000000000003e8 RCX: ffffa47ccdc9fbf8
	RDX: ffffa47ccdc9fc00 RSI: ffff97d9ee7b01f8 RDI: ffff97d9f0150b80
	RBP: ffff97d9f0150b80 R08: 0000000000000000 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
	R13: ffff97d9ef1e53e8 R14: 0000000000000009 R15: ffff97d9f0ac6730
	FS:  00007f4d224ef700(0000) GS:ffff97d9fa200000(0000) knlGS:00000000000000=
00
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: ffffffffffffffd6 CR3: 00000011ece52006 CR4: 00000000000206e0
	Call Trace:
	 ? bnx2x_chip_cleanup+0x195/0x610 [bnx2x]
	 ? bnx2x_nic_unload+0x1e2/0x8f0 [bnx2x]
	 ? bnx2x_reload_if_running+0x24/0x40 [bnx2x]
	 ? bnx2x_set_features+0x79/0xa0 [bnx2x]
	 ? __netdev_update_features+0x244/0x9e0
	 ? netlink_broadcast_filtered+0x136/0x4b0
	 ? netdev_update_features+0x22/0x60
	 ? dev_disable_lro+0x1c/0xe0
	 ? devinet_sysctl_forward+0x1c6/0x211
	 ? proc_sys_call_handler+0xab/0x100
	 ? __vfs_write+0x36/0x1a0
	 ? rcu_read_lock_sched_held+0x79/0x80
	 ? rcu_sync_lockdep_assert+0x2e/0x60
	 ? __sb_start_write+0x14c/0x1b0
	 ? vfs_write+0x159/0x1c0
	 ? vfs_write+0xba/0x1c0
	 ? ksys_write+0x52/0xc0
	 ? do_syscall_64+0x60/0x1f0
	 ? entry_SYSCALL_64_after_hwframe+0x49/0xbe

After some investigation I figured out that recently added cleanup code tri=
es to call VLAN filtering de-initialization function which exist only for n=
ewer hardware. Corresponding function pointer is not set (=3D=3D 0) for old=
er hardware, namely these chips:

	#define CHIP_NUM_57710			0x164e
	#define CHIP_NUM_57711			0x164f
	#define CHIP_NUM_57711E			0x1650

And I have one of those in my test system:

	Broadcom Inc. and subsidiaries NetXtreme II BCM57711E 10-Gigabit PCIe [14e=
4:1650]

Function bnx2x_init_vlan_mac_fp_objs() from drivers/net/ethernet/broadcom/b=
nx2x/bnx2x_cmn.h decides whether to initialize relevant pointers in bnx2x_s=
p_objs.vlan_obj or not.

This regression was introduced after v4.20-rc7, and still exists in v4.20 r=
elease.

Fixes: 04f05230c5c13 ("bnx2x: Remove configured vlans as part of unload seq=
uence.")
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
v2:
- As suggested by Sudarsana Reddy Kalluru, do not call bnx2x_del_all_vlans(=
) at
  all if (!CHIP_IS_E1x(bp)).
v1:
- Check for chip num instead of (vlan_obj->delete_all !=3D 0).
v0:
- Patch introduced.
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net=
/ethernet/broadcom/bnx2x/bnx2x_main.c
index b164f705709d..3b5b47e98c73 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9360,10 +9360,16 @@ void bnx2x_chip_cleanup(struct bnx2x *bp, int unloa=
d_mode, bool keep_link)
 		BNX2X_ERR("Failed to schedule DEL commands for UC MACs list: %d\n",
 			  rc);
=20
-	/* Remove all currently configured VLANs */
-	rc =3D bnx2x_del_all_vlans(bp);
-	if (rc < 0)
-		BNX2X_ERR("Failed to delete all VLANs\n");
+	/* The whole *vlan_obj structure may be not initialized if VLAN
+	 * filtering offload is not supported by hardware. Currently this is
+	 * true for all hardware covered by CHIP_IS_E1x().
+	 */
+	if (!CHIP_IS_E1x(bp)) {
+		/* Remove all currently configured VLANs */
+		rc =3D bnx2x_del_all_vlans(bp);
+		if (rc < 0)
+			BNX2X_ERR("Failed to delete all VLANs\n");
+	}
=20
 	/* Disable LLH */
 	if (!CHIP_IS_E1(bp))
--
2.20.1

Thanks for the changes.
Acked-by: Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>
