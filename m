Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521482126-2-17121703835770051545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482124; b=sSztrr5aruEkKGglUKBkLqxPpmeRBj6BeqbDCegseZUWpUZ
    5cYMjT3OxGeEw4vmJflbi8IJtHpijDhUN3NRsnl4xKh+hOziCT/7Vn25BJflfzIQ
    4rp27ICyd8kZw8HF5QVb3LyipB2aDGASNSzd0e1Gyaqp7+UgtRnVOXCAiIstjJxb
    LycRdOCbffYV8MpwOWA7tG7ixZ4FDaXD0ehoEKW1EMreDeNYn4GyyyxmUJz2Cp6r
    WyYLtO/+hjQvX0GaT2fhKZhUWNGRZoK7n7U1wcBRhFNwxhHyzB8iE9Ul+z39DYAE
    7aDHaom/4Cuh5MkRGmgVslZ9oJGuN78l0gKiyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482124; bh=ZYv3GL
    i1tNob3xpQUd+RESDm91uzKZO5NjtCfpdOLA0=; b=IAT5r8RaA3WSs3PHcmxODx
    6XTGrA8u+UuvCYnlSV4Qyni5CsAVEOaMXDmuclBRf7BXLBKiMdvCcpuFcHhtivaf
    PqtkPre8na3/aRDBNXIeb5H/HPsEB1wPPLHoq3YSlZJCb63s7p7jHn15c6hcaiKu
    9gOGQ8JU6Yd0EBAYHd0DZ15qTc+9itRZIvBacY/swqNPjKFMwU4/mC1Glnhxxgt4
    qA6+OIpv5vpR0zgfg4f9E+kfVQ+bvUq/zniZgFuDjdt+/MAN7qo8Y9136MJ5hG28
    q2r+5JhNxQGhw2Wt/OoHeWN5Ewr0AEas+Ehm1lPGZ38oaxpoyryZnYMdDJbvg2yA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZdjvCiCP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudegkeehnecuvehluhhsthgvrhfuihiivgepfeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZdjvCiCP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudegkeehnecuvehluhhsthgvrhfuihiivgepfeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965757AbeCSRzI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:55:08 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:4621
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965686AbeCSQEp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Rakesh Pandit <rakesh@tuxera.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 217/281] nvme-pci: fix multiple ctrl removal
 scheduling
Thread-Topic: [PATCH AUTOSEL for 4.9 217/281] nvme-pci: fix multiple ctrl
 removal scheduling
Thread-Index: AQHTv5ujW5xpql/l406CpkgVRb9Y6g==
Date: Mon, 19 Mar 2018 16:02:10 +0000
Message-ID: <20180319155742.13731-217-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:tRXIMvYlHKYj+mIvFHyI3FW6H8LTyKvPa92moVaSrKjgiOVc0edwDIFjSgVD++bpJCHkq1BPwhHCEKEshffd5albeHWE3MYPCZgKePgfYdDcMclmyD3mbe+GknwQhXIJv0Ce/WbVCXCP/+CbkkzG5v6i6tNRO2JPOech6Bxg63H7TAt2ri8mEm4+E6YJ2hP7CtxQI7tM5ZATzHQiZmWWdM/rC30oqUQ/m4HlkXfo0Zieyi24u6HJdv16p4fEJcG9;20:sG7X9xT1SJUL2WvrnufLiU+H/oG/TjY6vTb9pUs7YCYn4Hl8L3xAhARHHJvM3ULAqFdqdMSc5kwrDgCtIXXS4L2n+RS6DvpWmYJUHfx5OWJuywnul3fEgkxe+nJ/ZSeQH/gnDWNTrv4FT74VwtNUpwuYCX89YyJjVSFE1fI7SHw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01924640-d80b-4ead-089d-08d58db31d70
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08055B862A97FB155F350FE5FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(51234002)(54906003)(3280700002)(316002)(66066001)(22452003)(10290500003)(4326008)(6512007)(72206003)(478600001)(25786009)(107886003)(53936002)(2501003)(5250100002)(36756003)(76176011)(106356001)(110136005)(97736004)(99286004)(26005)(1076002)(8936002)(3846002)(2950100002)(86362001)(186003)(305945005)(575784001)(3660700001)(5660300001)(6116002)(6666003)(6506007)(59450400001)(102836004)(81156014)(81166006)(10090500001)(105586002)(8676002)(14454004)(6436002)(2900100001)(6486002)(7736002)(68736007)(86612001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 3lzkfjhypZCGvwevf0/DjH3aQ1gMNLiuODE8oWtMVWkI7ef+yRDbmTVzH8/K2uApIpPSi0tveo2WQKUM1dBTlvb0zsCpPeCvfspyhGJuQkRZmeK1B0NH8CdA1N4Esm8474o+gxJWtzXb1pST7PGL6GxeeL5ZRCMuP0lu3RdTrku9xmR71MrAfr58NJ4ycUFIiCzKcEyClcGHmAp/C+oUJ0D1y+erC2NgVPp25YDm1tXCWHE73FQTNEZ8vQdbwH7yPf8pFOn03D4sb1g+kptqeL9YYuRWiXY9uxMfjNlXrrTlgmp7QRA7X5+L6/eTytD63YVDjKihVCk2YYy9LiOEMA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01924640-d80b-4ead-089d-08d58db31d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:10.1501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
2.14.1
