Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488944-2-6119771723019593960
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488943; b=MMQi3b/c6dkQsSf05MoNCFfyZ1wz2rkLXd2Ns9bz1lY0ifU
    tKb94MKuh+IJ42M5zzYh8z5U7J+EDqimVvjWHKlxBQOWlNgzSCwjs9TG8y2TqAb4
    8qBnTAnEugtS+zd/k/Rre9iXZRPfi+s0WbyPlt4Tiw+86KO2QB9TFDBinNjjymm0
    wSuVRtutpE+lVZEENeCAnC4EwXv/r5lnB1j4MwoXuba73qK4Z2s/WP0QcOeOVAqz
    nu51hZBgiHJ4umc9jmNSDJnTVrmKqVYM8BTr7uPWvMFxLnMbcQs8WzveSxdnAc9F
    LLoXVaHcE/+8sp9FO8odUFaQpP21/S4M5V3FHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488943; bh=Lkv9jl
    eYonGMXo+Zkc7HMVZPz89KnRWFjRUj7d+djV4=; b=Dv3NvetE6aYuNpPeZ7G6Wc
    PZYAcJc9Me6dBcM4L0mP8bnzLFPQC4xN8R7/X4yOQg3RSRyk5WE6jYiViZnME+ye
    nTxMyYxpjWyFbgfb8tXOXR3lK1o8nNzY/VgV6QRBGJiMqcK4m1PhCRq4Q3NxxD3E
    c4Z1REvn6t8sGvNS4IBQSJp4O+CtdGhN1yAT3v5ZP7iNzSilQnuJWv49BCuJCHIE
    KTnnfXomuxb2Nzcqtf3oFo9CFfBw9lg1P856FNYI/a/DxQtMAE+y2Wd8b6+X34r5
    kYTOmFLtRSoygkuyYCkvdWg0w95FQ9nXPL3i0sG9hBITPU/hLT4lKNTLTtv8ngVw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dtMCyG0r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dtMCyG0r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755384AbeCHFCf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:02:35 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:45129
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755275AbeCHFCa (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tadeusz Struk <tadeusz.struk@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 113/190] IB/hfi1: Fix softlockup issue
Thread-Topic: [PATCH AUTOSEL for 4.9 113/190] IB/hfi1: Fix softlockup issue
Thread-Index: AQHTtppEbKuGvI1fNkqOlyIshor1fg==
Date: Thu, 8 Mar 2018 04:59:41 +0000
Message-ID: <20180308045810.8041-113-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:enanyL0bodnxs2BnJ1rI2SDYVUvAAQnxOpHqMFqZUkGaxPlKFUNQhkYKksR/7iAcHoE/ZAIPfvnb12fx/biOMDiqM/iMD86rph7M3b4qy4Tz4Sgr409d4fP24hhY8n4FcA0TWwgPU1lCtFKg/liKkhBcTpZ04kWPiGFqcHG88WUSKHk4FAYhqksadVQ51gsZB/fP6dpLWNsBITnRNdwC+A5zQP1ZwwjRxR2afAbY8dKRnenZT+4R5y+SrRdnmZEW;20:fN+m5ZtVDyGbuwie3935HE0i6pBnc62oZapNhkIgc+sywKZou66n1t2NVyQdNmuhhOtWjNRESa9HqSm1pSM2LDunKmp9BJdy9dKN4timBKY3+JFD3BRL0oEJ6jCwflgWphqICwLMHxk6rApLymIpLKbUgMsCM/dAM/GKuVFLJi4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f377e81-7e8d-4e45-7956-08d584b1c391
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0997BD197B3E3E092419083BFBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(575784001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ZHQhzTSk5oz/3GtVZfXUTgyhtaqFwI97faR6+rZJVVawUUQ6oyhu3RLE8BzvyMTSB/r4/5dQOEYvPXC4SHvV1Zix8Y2N7+03oJATelUTyFADmbXec0flAGh9Er7twUHf8X+JZ9OD5jDLo5qQIuWKGeZBtPdr4H/02pN8YwXoX5JHVzBLMHz837jS/CodkK+NKe5Ir3Asm+ZGmG+mxVimh9WRwDojs6a2O8SAF5aQG4c7fLyhCq4YJS7jXFz1UFc++v5Hhj1TKVHX58v9hswfSePm1awhAlX+qV3BVtqGD6fXFvGpauneARtt0SaW+mQ4YtNEpyWqApgvtPcqVnnSqw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f377e81-7e8d-4e45-7956-08d584b1c391
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:41.6914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tadeusz Struk <tadeusz.struk@intel.com>

[ Upstream commit 22546b741af8355cd2e16739b6af4a8f17081839 ]

Soft lockups can occur because the mad processing on different CPUs acquire
the spin lock dc8051_lock:

[534552.835870]  [<ffffffffa026f993>] ? read_dev_port_cntr.isra.37+0x23/0x1=
60 [hfi1]
[534552.835880]  [<ffffffffa02775af>] read_dev_cntr+0x4f/0x60 [hfi1]
[534552.835893]  [<ffffffffa028d7cd>] pma_get_opa_portstatus+0x64d/0x8c0 [h=
fi1]
[534552.835904]  [<ffffffffa0290e7d>] hfi1_process_mad+0x48d/0x18c0 [hfi1]
[534552.835908]  [<ffffffff811dc1f1>] ? __slab_free+0x81/0x2f0
[534552.835936]  [<ffffffffa024c34e>] ? ib_mad_recv_done+0x21e/0xa30 [ib_co=
re]
[534552.835939]  [<ffffffff811dd153>] ? __kmalloc+0x1f3/0x240
[534552.835947]  [<ffffffffa024c3fb>] ib_mad_recv_done+0x2cb/0xa30 [ib_core=
]
[534552.835955]  [<ffffffffa0237c85>] __ib_process_cq+0x55/0xd0 [ib_core]
[534552.835962]  [<ffffffffa0237d70>] ib_cq_poll_work+0x20/0x60 [ib_core]
[534552.835964]  [<ffffffff810a7f3b>] process_one_work+0x17b/0x470
[534552.835966]  [<ffffffff810a8d76>] worker_thread+0x126/0x410
[534552.835969]  [<ffffffff810a8c50>] ? rescuer_thread+0x460/0x460
[534552.835971]  [<ffffffff810b052f>] kthread+0xcf/0xe0
[534552.835974]  [<ffffffff810b0460>] ? kthread_create_on_node+0x140/0x140
[534552.835977]  [<ffffffff81696418>] ret_from_fork+0x58/0x90
[534552.835980]  [<ffffffff810b0460>] ? kthread_create_on_node+0x140/0x140

This issue is made worse when the 8051 is busy and the reads take longer.
Fix by using a non-spinning lock procure.

Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Reviewed-by: Mike Marciszyn <mike.marciniszyn@intel.com>
Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/hfi1/chip.c | 86 +++++++++++++++++++++++------------=
----
 drivers/infiniband/hw/hfi1/hfi.h  |  7 ++--
 drivers/infiniband/hw/hfi1/init.c |  2 +-
 3 files changed, 57 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1=
/chip.c
index 4682909b021b..1e5672fe84b6 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -6379,18 +6379,17 @@ static void lcb_shutdown(struct hfi1_devdata *dd, i=
nt abort)
  *
  * The expectation is that the caller of this routine would have taken
  * care of properly transitioning the link into the correct state.
+ * NOTE: the caller needs to acquire the dd->dc8051_lock lock
+ *       before calling this function.
  */
-static void dc_shutdown(struct hfi1_devdata *dd)
+static void _dc_shutdown(struct hfi1_devdata *dd)
 {
-	unsigned long flags;
+	lockdep_assert_held(&dd->dc8051_lock);
=20
-	spin_lock_irqsave(&dd->dc8051_lock, flags);
-	if (dd->dc_shutdown) {
-		spin_unlock_irqrestore(&dd->dc8051_lock, flags);
+	if (dd->dc_shutdown)
 		return;
-	}
+
 	dd->dc_shutdown =3D 1;
-	spin_unlock_irqrestore(&dd->dc8051_lock, flags);
 	/* Shutdown the LCB */
 	lcb_shutdown(dd, 1);
 	/*
@@ -6401,35 +6400,45 @@ static void dc_shutdown(struct hfi1_devdata *dd)
 	write_csr(dd, DC_DC8051_CFG_RST, 0x1);
 }
=20
+static void dc_shutdown(struct hfi1_devdata *dd)
+{
+	mutex_lock(&dd->dc8051_lock);
+	_dc_shutdown(dd);
+	mutex_unlock(&dd->dc8051_lock);
+}
+
 /*
  * Calling this after the DC has been brought out of reset should not
  * do any damage.
+ * NOTE: the caller needs to acquire the dd->dc8051_lock lock
+ *       before calling this function.
  */
-static void dc_start(struct hfi1_devdata *dd)
+static void _dc_start(struct hfi1_devdata *dd)
 {
-	unsigned long flags;
-	int ret;
+	lockdep_assert_held(&dd->dc8051_lock);
=20
-	spin_lock_irqsave(&dd->dc8051_lock, flags);
 	if (!dd->dc_shutdown)
-		goto done;
-	spin_unlock_irqrestore(&dd->dc8051_lock, flags);
+		return;
+
 	/* Take the 8051 out of reset */
 	write_csr(dd, DC_DC8051_CFG_RST, 0ull);
 	/* Wait until 8051 is ready */
-	ret =3D wait_fm_ready(dd, TIMEOUT_8051_START);
-	if (ret) {
+	if (wait_fm_ready(dd, TIMEOUT_8051_START))
 		dd_dev_err(dd, "%s: timeout starting 8051 firmware\n",
 			   __func__);
-	}
+
 	/* Take away reset for LCB and RX FPE (set in lcb_shutdown). */
 	write_csr(dd, DCC_CFG_RESET, 0x10);
 	/* lcb_shutdown() with abort=3D1 does not restore these */
 	write_csr(dd, DC_LCB_ERR_EN, dd->lcb_err_en);
-	spin_lock_irqsave(&dd->dc8051_lock, flags);
 	dd->dc_shutdown =3D 0;
-done:
-	spin_unlock_irqrestore(&dd->dc8051_lock, flags);
+}
+
+static void dc_start(struct hfi1_devdata *dd)
+{
+	mutex_lock(&dd->dc8051_lock);
+	_dc_start(dd);
+	mutex_unlock(&dd->dc8051_lock);
 }
=20
 /*
@@ -8418,16 +8427,11 @@ static int do_8051_command(
 {
 	u64 reg, completed;
 	int return_code;
-	unsigned long flags;
 	unsigned long timeout;
=20
 	hfi1_cdbg(DC8051, "type %d, data 0x%012llx", type, in_data);
=20
-	/*
-	 * Alternative to holding the lock for a long time:
-	 * - keep busy wait - have other users bounce off
-	 */
-	spin_lock_irqsave(&dd->dc8051_lock, flags);
+	mutex_lock(&dd->dc8051_lock);
=20
 	/* We can't send any commands to the 8051 if it's in reset */
 	if (dd->dc_shutdown) {
@@ -8453,10 +8457,8 @@ static int do_8051_command(
 			return_code =3D -ENXIO;
 			goto fail;
 		}
-		spin_unlock_irqrestore(&dd->dc8051_lock, flags);
-		dc_shutdown(dd);
-		dc_start(dd);
-		spin_lock_irqsave(&dd->dc8051_lock, flags);
+		_dc_shutdown(dd);
+		_dc_start(dd);
 	}
=20
 	/*
@@ -8534,8 +8536,7 @@ static int do_8051_command(
 	write_csr(dd, DC_DC8051_CFG_HOST_CMD_0, 0);
=20
 fail:
-	spin_unlock_irqrestore(&dd->dc8051_lock, flags);
-
+	mutex_unlock(&dd->dc8051_lock);
 	return return_code;
 }
=20
@@ -11846,6 +11847,10 @@ static void free_cntrs(struct hfi1_devdata *dd)
 	dd->scntrs =3D NULL;
 	kfree(dd->cntrnames);
 	dd->cntrnames =3D NULL;
+	if (dd->update_cntr_wq) {
+		destroy_workqueue(dd->update_cntr_wq);
+		dd->update_cntr_wq =3D NULL;
+	}
 }
=20
 static u64 read_dev_port_cntr(struct hfi1_devdata *dd, struct cntr_entry *=
entry,
@@ -12001,7 +12006,7 @@ u64 write_port_cntr(struct hfi1_pportdata *ppd, int=
 index, int vl, u64 data)
 	return write_dev_port_cntr(ppd->dd, entry, sval, ppd, vl, data);
 }
=20
-static void update_synth_timer(unsigned long opaque)
+static void do_update_synth_timer(struct work_struct *work)
 {
 	u64 cur_tx;
 	u64 cur_rx;
@@ -12010,8 +12015,8 @@ static void update_synth_timer(unsigned long opaque=
)
 	int i, j, vl;
 	struct hfi1_pportdata *ppd;
 	struct cntr_entry *entry;
-
-	struct hfi1_devdata *dd =3D (struct hfi1_devdata *)opaque;
+	struct hfi1_devdata *dd =3D container_of(work, struct hfi1_devdata,
+					       update_cntr_work);
=20
 	/*
 	 * Rather than keep beating on the CSRs pick a minimal set that we can
@@ -12094,7 +12099,13 @@ static void update_synth_timer(unsigned long opaqu=
e)
 	} else {
 		hfi1_cdbg(CNTR, "[%d] No update necessary", dd->unit);
 	}
+}
+
+static void update_synth_timer(unsigned long opaque)
+{
+	struct hfi1_devdata *dd =3D (struct hfi1_devdata *)opaque;
=20
+	queue_work(dd->update_cntr_wq, &dd->update_cntr_work);
 	mod_timer(&dd->synth_stats_timer, jiffies + HZ * SYNTH_CNT_TIME);
 }
=20
@@ -12330,6 +12341,13 @@ static int init_cntrs(struct hfi1_devdata *dd)
 	if (init_cpu_counters(dd))
 		goto bail;
=20
+	dd->update_cntr_wq =3D alloc_ordered_workqueue("hfi1_update_cntr_%d",
+						     WQ_MEM_RECLAIM, dd->unit);
+	if (!dd->update_cntr_wq)
+		goto bail;
+
+	INIT_WORK(&dd->update_cntr_work, do_update_synth_timer);
+
 	mod_timer(&dd->synth_stats_timer, jiffies + HZ * SYNTH_CNT_TIME);
 	return 0;
 bail:
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/=
hfi.h
index cc87fd4e534b..a3279f3d2578 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -475,7 +475,7 @@ struct rvt_sge_state;
 #define HFI1_PART_ENFORCE_OUT	0x2
=20
 /* how often we check for synthetic counter wrap around */
-#define SYNTH_CNT_TIME 2
+#define SYNTH_CNT_TIME 3
=20
 /* Counter flags */
 #define CNTR_NORMAL		0x0 /* Normal counters, just read register */
@@ -929,8 +929,9 @@ struct hfi1_devdata {
 	spinlock_t rcvctrl_lock; /* protect changes to RcvCtrl */
 	/* around rcd and (user ctxts) ctxt_cnt use (intr vs free) */
 	spinlock_t uctxt_lock; /* rcd and user context changes */
-	/* exclusive access to 8051 */
-	spinlock_t dc8051_lock;
+	struct mutex dc8051_lock; /* exclusive access to 8051 */
+	struct workqueue_struct *update_cntr_wq;
+	struct work_struct update_cntr_work;
 	/* exclusive access to 8051 memory */
 	spinlock_t dc8051_memlock;
 	int dc8051_timed_out;	/* remember if the 8051 timed out */
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1=
/init.c
index a3dd27b1305d..84a97f3f9299 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1078,11 +1078,11 @@ struct hfi1_devdata *hfi1_alloc_devdata(struct pci_=
dev *pdev, size_t extra)
 	spin_lock_init(&dd->uctxt_lock);
 	spin_lock_init(&dd->hfi1_diag_trans_lock);
 	spin_lock_init(&dd->sc_init_lock);
-	spin_lock_init(&dd->dc8051_lock);
 	spin_lock_init(&dd->dc8051_memlock);
 	seqlock_init(&dd->sc2vl_lock);
 	spin_lock_init(&dd->sde_map_lock);
 	spin_lock_init(&dd->pio_map_lock);
+	mutex_init(&dd->dc8051_lock);
 	init_waitqueue_head(&dd->event_queue);
=20
 	dd->int_counter =3D alloc_percpu(u64);
--=20
2.14.1
