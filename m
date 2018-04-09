Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242196-2-12913326727035069607
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242195; b=JnLXgEU1aALcfw9eIAeiQZQHAvMYxp0QNOVdKWK9hgcVQm2O1U
    66o7+UrZcafDL5TfjyyMwaZ+B2IovqG1Sd5bT1eDpxDK1nHJVLFl1SQy0D8FzIK7
    /bUGCSgZxiAsr4vAE1dEJDFFUR/ppmQESDu5jemUhiUgmimu387X03xp6VGUILRd
    hrf6mAPssA0JoD0ZH3GGm2Ks9i49T9SeVmVKo4dE4HjdX/Cg7kT15FAc7xEtY453
    97XOf+h6fk5oz0yKsUj1BHJjNvJ2fN+FitNqj0Hi8fxdwCsS5UUgeTZE4AoRwYGd
    L4i6q6gpWw4K8Alg4GHW1cZPSnAgV3fdy+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242195; bh=9bAY5ZNTGf
    fjTx57TVlw1PVfEb0OUE6f+PC5IWDjfUo=; b=fpBvHwCdpzjwkPlhN2da2T+b9+
    ygyOalwyZccBMxkl0Rhle4P6JzOaekx9KM7uWSQfwaHbeN1PeBDuJi0CAMHJc0u9
    GWRe+Ms4pRvS/IFAX5g4hY2pWBkMMpLd2Y6wKNEJg6arXL3AkUvjZwJwDV9xHuZU
    sYNgGUidChXdqgGiHIMuF/hLgif9JBu07HvSgjJyrGo4bNaHZ8nXmB3vbVwDU/vt
    jCeimQXWq/9umxb0SKVjJnPMYF2IK726Dr11GUX0JK48LKwkMjnZApbo6/HIBRjl
    wgGxEXvpJ+zrSPc1UbcNOos7b/16tK1vk8503aGIiANPKxYPdoo4hOg77mWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PkxRXfZT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PkxRXfZT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCHj6hquJvr9jkuDJtxGQ5B7n/jm2kFiX3JLCpt+YGylN3Iz0sJTM/7NOQF/66ANHkpuGtuKZLZAx23IzTpO2aEe+ZScQU8SS1156JswdI56tIwRnHFu
    PYtEHa2UVMSybS4arvm2QRliBZsMR+zVUqalFvwpohNCPClUJpKb9+On7RMj95hq0Sk1ahmJ5+z0+kP88i0ONzXcgB+LDCe/gG6blJT56/xuWrSSYDf8CsxU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=3DfWnJiXAAAA:8 a=yMhMjlubAAAA:8 a=wlzNjK1lAZS8pu3RYYIA:9
    a=wPNLvfGTeEIA:10 a=fbZbCd7XTi_oNd1tYRxB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932597AbeDICs4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:48:56 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:2811
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755330AbeDIA0g (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Rakesh Pandit <rakesh@tuxera.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 002/293] nvme-pci: fix multiple ctrl removal
 scheduling
Thread-Topic: [PATCH AUTOSEL for 4.9 002/293] nvme-pci: fix multiple ctrl
 removal scheduling
Thread-Index: AQHTz5jiabZzN+tEhkKG9rDuoA+X1A==
Date: Mon, 9 Apr 2018 00:22:47 +0000
Message-ID: <20180409002239.163177-2-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:TnxaJ9RMUcIu26VGsaiMJ4LWl9XCZAjZP9Wpt0bS6UOy3CDm6Owyzi0Ersukw2PnH3WKKzjnQlpFpr2DXCDeTEdFdOmM1Ud/EezD0LcPzBYlhb2V19+FJBh3eP7vbOmv+4ToehqwhIj6TFuM/GKfm3bpZK7mIFhsVbaONfNaNxUoa5iQnNS9UZwoZIhLkOCiwUCJTB19jEuVm0WrQ1f3nV/+o31JKFj/FEQ0d1k3s6h+hynFYE/YIi3/ZQlNW58W;20:3b50G+wHdZCAWemQvntLjqqXXvVPR/pnmlZgIwzPYiHpYG6VTCK+cxMeEf9HERFUupvnSrlzumHsrXwGewIvbjp6g0RenXq7ApSL1fBPztZRVSCxXEWi0KLo6nfc7At9fwRGKxLCzsqGk5QdgU05uoiDiCQxignzn9wRAUN3wiE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 885d5ee0-f68d-472f-f658-08d59db08a3d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10152D3E272029D5CA7A26A1FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(51234002)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: pby+OspKorrhnoJefm8Ig+97aM5oqBrxwH4dSdiKrcVbBqz+xoTU/MWqkOIrsvQWkV6X+ghTzuX73YIRwZJGxv6GYWVjE8Y0pBKlpBbKjZwSIG2HbS2g0MGiRbh7oktHQKkqQf/tnRE2YI4dR3orvhffE/zhPhyAGWqM+GHhvQtpcHgD/KV6G2frSjEzHaS4MtzRVRDT3M0mUlArKQZvINWdUHeh7a5jR+c/vdSFVP6j9y/Ak/kHEBO3BciUZAJX/rCgdbB3hTfKw6+obEeZsmzmU4kldOpwS9DppH/2ZjVhRJBinsGpqW3WhQCz+F7CXha1Bu0Ax80F24Dtc+KUKs5imvwVNBx1ekeDKq04ZvAtQb1iXb4CYuJwLv7ToruwKCU/kF+0//MeDu4ZD4DlfcxFvl9pujMEBSbPEaSMH4c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885d5ee0-f68d-472f-f658-08d59db08a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:47.0654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rakesh Pandit <rakesh@tuxera.com>

[ Upstream commit 82b057caefaff2a891f821a617d939f46e03e844 ]

Commit c5f6ce97c1210 tries to address multiple resets but fails as
work_busy doesn't involve any synchronization and can fail.  This is
reproducible easily as can be seen by WARNING below which is triggered
with line:

WARN_ON(dev->ctrl.state =3D=3D NVME_CTRL_RESETTING)

Allowing multiple resets can result in multiple controller removal as
well if different conditions inside nvme_reset_work fail and which
might deadlock on device_release_driver.

[  480.327007] WARNING: CPU: 3 PID: 150 at drivers/nvme/host/pci.c:1900 nvm=
e_reset_work+0x36c/0xec0
[  480.327008] Modules linked in: rfcomm fuse nf_conntrack_netbios_ns nf_co=
nntrack_broadcast...
[  480.327044]  btusb videobuf2_core ghash_clmulni_intel snd_hwdep cfg80211=
 acer_wmi hci_uart..
[  480.327065] CPU: 3 PID: 150 Comm: kworker/u16:2 Not tainted 4.12.0-rc1+ =
#13
[  480.327065] Hardware name: Acer Predator G9-591/Mustang_SLS, BIOS V1.10 =
03/03/2016
[  480.327066] Workqueue: nvme nvme_reset_work
[  480.327067] task: ffff880498ad8000 task.stack: ffffc90002218000
[  480.327068] RIP: 0010:nvme_reset_work+0x36c/0xec0
[  480.327069] RSP: 0018:ffffc9000221bdb8 EFLAGS: 00010246
[  480.327070] RAX: 0000000000460000 RBX: ffff880498a98128 RCX: dead0000000=
00200
[  480.327070] RDX: 0000000000000001 RSI: ffff8804b1028020 RDI: ffff880498a=
98128
[  480.327071] RBP: ffffc9000221be50 R08: 0000000000000000 R09: 00000000000=
00000
[  480.327071] R10: ffffc90001963ce8 R11: 000000000000020d R12: ffff880498a=
98000
[  480.327072] R13: ffff880498a53500 R14: ffff880498a98130 R15: ffff880498a=
98128
[  480.327072] FS:  0000000000000000(0000) GS:ffff8804c1cc0000(0000) knlGS:=
0000000000000000
[  480.327073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  480.327074] CR2: 00007ffcf3c37f78 CR3: 0000000001e09000 CR4: 00000000003=
406e0
[  480.327074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  480.327075] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  480.327075] Call Trace:
[  480.327079]  ? __switch_to+0x227/0x400
[  480.327081]  process_one_work+0x18c/0x3a0
[  480.327082]  worker_thread+0x4e/0x3b0
[  480.327084]  kthread+0x109/0x140
[  480.327085]  ? process_one_work+0x3a0/0x3a0
[  480.327087]  ? kthread_park+0x60/0x60
[  480.327102]  ret_from_fork+0x2c/0x40
[  480.327103] Code: e8 5a dc ff ff 85 c0 41 89 c1 0f.....

This patch addresses the problem by using state of controller to
decide whether reset should be queued or not as state change is
synchronizated using controller spinlock.  Also cancel_work_sync is
used to make sure remove cancels the reset_work and waits for it to
finish.  This patch also changes return value from -ENODEV to more
appropriate -EBUSY if nvme_reset fails to change state.

Fixes: c5f6ce97c1210 ("nvme: don't schedule multiple resets")
Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/host/pci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e48ecb9303ca..8cc856ecec95 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1263,7 +1263,7 @@ static bool nvme_should_reset(struct nvme_dev *dev, u=
32 csts)
 	bool nssro =3D dev->subsystem && (csts & NVME_CSTS_NSSRO);
=20
 	/* If there is a reset ongoing, we shouldn't reset again. */
-	if (work_busy(&dev->reset_work))
+	if (dev->ctrl.state =3D=3D NVME_CTRL_RESETTING)
 		return false;
=20
 	/* We shouldn't reset unless the controller is on fatal error state
@@ -1755,7 +1755,7 @@ static void nvme_reset_work(struct work_struct *work)
 	struct nvme_dev *dev =3D container_of(work, struct nvme_dev, reset_work);
 	int result =3D -ENODEV;
=20
-	if (WARN_ON(dev->ctrl.state =3D=3D NVME_CTRL_RESETTING))
+	if (WARN_ON(dev->ctrl.state !=3D NVME_CTRL_RESETTING))
 		goto out;
=20
 	/*
@@ -1765,9 +1765,6 @@ static void nvme_reset_work(struct work_struct *work)
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
=20
-	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
-		goto out;
-
 	result =3D nvme_pci_enable(dev);
 	if (result)
 		goto out;
@@ -1841,8 +1838,8 @@ static int nvme_reset(struct nvme_dev *dev)
 {
 	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
 		return -ENODEV;
-	if (work_busy(&dev->reset_work))
-		return -ENODEV;
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
+		return -EBUSY;
 	if (!queue_work(nvme_workq, &dev->reset_work))
 		return -EBUSY;
 	return 0;
@@ -1944,6 +1941,7 @@ static int nvme_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 	if (result)
 		goto release_pools;
=20
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING);
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
=20
 	queue_work(nvme_workq, &dev->reset_work);
@@ -1987,6 +1985,7 @@ static void nvme_remove(struct pci_dev *pdev)
=20
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
=20
+	cancel_work_sync(&dev->reset_work);
 	pci_set_drvdata(pdev, NULL);
=20
 	if (!pci_device_is_present(pdev)) {
--=20
2.15.1
