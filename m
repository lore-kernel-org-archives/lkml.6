Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2358C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2982190B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="GDIsqoD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfBOQdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:33:01 -0500
Received: from mail-eopbgr750052.outbound.protection.outlook.com ([40.107.75.52]:28751
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfBOQdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZgeowXzBd42zinrMbLSCcWJ879IosMmx55HvJQXVz0=;
 b=GDIsqoD6dbeJSOElrf4cgh3FUziomW8TlKlOWC4yYYILm5slMu4jJS1essTq2GH1mTo+dFDCvv5VgI8q2MfYZST2RYy9j6o8wDOCZ8kBRqKVSpzzhiM+14aLyffJCao+zhoeOheNdAbb9MVEd7vNWWqX750JG7QNjnTqikSE+JU=
Received: from BYAPR05MB5048.namprd05.prod.outlook.com (20.177.230.218) by
 BYAPR05MB6149.namprd05.prod.outlook.com (20.178.55.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.9; Fri, 15 Feb 2019 16:32:47 +0000
Received: from BYAPR05MB5048.namprd05.prod.outlook.com
 ([fe80::2846:d7c4:356d:d409]) by BYAPR05MB5048.namprd05.prod.outlook.com
 ([fe80::2846:d7c4:356d:d409%2]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 16:32:47 +0000
From:   Vishnu DASA <vdasa@vmware.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>
CC:     Vishnu DASA <vdasa@vmware.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: [PATCH] VMCI: Support upto 64-bit PPNs
Thread-Topic: [PATCH] VMCI: Support upto 64-bit PPNs
Thread-Index: AQHUxUwV6nWluENUEEaVtzCnZJ3Kig==
Date:   Fri, 15 Feb 2019 16:32:47 +0000
Message-ID: <20190215162738.21334-1-vdasa@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::44) To BYAPR05MB5048.namprd05.prod.outlook.com
 (2603:10b6:a03:9d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdasa@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d753d5c-3672-43a0-cdfe-08d6936337df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6149;
x-ms-traffictypediagnostic: BYAPR05MB6149:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6149;20:CGI3vARcddIHcJVdu5A/aGLvHNDvVN0mnfJsH0YeFBBzO4ktTZXtczg2bkM2vsn7hQ5iRXeT7dnylHGd8ZnXGvxx6VFk3BIsKOQOvhraB07Wz++oxPlCazlq0qKZrjiRMfOd9URpFfY3Hs+YbcanM76kK6no15uioAnXuwDv1TY=
x-microsoft-antispam-prvs: <BYAPR05MB61497036275E002C876447B7CE600@BYAPR05MB6149.namprd05.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(366004)(346002)(376002)(189003)(199004)(86362001)(6436002)(2616005)(14454004)(305945005)(476003)(26005)(1076003)(36756003)(66066001)(316002)(478600001)(6486002)(54906003)(6506007)(256004)(14444005)(99286004)(2501003)(102836004)(110136005)(386003)(68736007)(186003)(30864003)(3846002)(7736002)(8936002)(8676002)(25786009)(6116002)(50226002)(81156014)(2906002)(97736004)(6512007)(105586002)(81166006)(71200400001)(4326008)(52116002)(486006)(71190400001)(6636002)(53936002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6149;H:BYAPR05MB5048.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hpdC7bHlzNX5VYSGLakjwnMbRbTkkr1G4J0KtwF6kGhMHYcnb+Gk5knOyHDnCFjZ0OUdJjEAIfij5EIa2EUS8xpwOt7v3gPmpL39WwdjdNkp8miaUJ4E+2c6E7/tHewCLOV6ks8XrR8G+2WsYZyiodfpamdl7wM31Q/PT3y60SmiSD73wIQBhHXZKzlOW8mL2Nb3arytz03rxu3OEucJ2UzcY+b4BpsAdLY69l8DpcO9abLlbwaICQYiFdQ3rNz1Ac70l132uvktRi3qYUQU1kE1FFRO997YDIGUOqc++dS4yrw1QOOv5oQBmKtvtj4S3JGmq0Fi1IAlHk2Rae8z1cQ+FSNOZ1JnEw/39os85lkbAXyZ85U5m+7thSQShJLgt0q8LHI2IGAcWqZj+R8j2wwdOrQO32gOG25bdQaklEA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d753d5c-3672-43a0-cdfe-08d6936337df
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 16:32:46.5781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support in the VMCI driver to handle upto 64-bit PPNs when the VMCI
device exposes the capability for 64-bit PPNs.

Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_doorbell.c   |  9 ++--
 drivers/misc/vmw_vmci/vmci_doorbell.h   |  2 +-
 drivers/misc/vmw_vmci/vmci_driver.h     |  2 +
 drivers/misc/vmw_vmci/vmci_guest.c      | 39 ++++++++++++---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 63 ++++++++++++-------------
 drivers/misc/vmw_vmci/vmci_queue_pair.h |  4 +-
 include/linux/vmw_vmci_defs.h           |  7 ++-
 7 files changed, 77 insertions(+), 49 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_doorbell.c b/drivers/misc/vmw_vmci/=
vmci_doorbell.c
index b3fa738ae005..7824c7494916 100644
--- a/drivers/misc/vmw_vmci/vmci_doorbell.c
+++ b/drivers/misc/vmw_vmci/vmci_doorbell.c
@@ -330,7 +330,7 @@ int vmci_dbell_host_context_notify(u32 src_cid, struct =
vmci_handle handle)
 /*
  * Register the notification bitmap with the host.
  */
-bool vmci_dbell_register_notification_bitmap(u32 bitmap_ppn)
+bool vmci_dbell_register_notification_bitmap(u64 bitmap_ppn)
 {
 	int result;
 	struct vmci_notify_bm_set_msg bitmap_set_msg;
@@ -340,11 +340,14 @@ bool vmci_dbell_register_notification_bitmap(u32 bitm=
ap_ppn)
 	bitmap_set_msg.hdr.src =3D VMCI_ANON_SRC_HANDLE;
 	bitmap_set_msg.hdr.payload_size =3D sizeof(bitmap_set_msg) -
 	    VMCI_DG_HEADERSIZE;
-	bitmap_set_msg.bitmap_ppn =3D bitmap_ppn;
+	if (vmci_use_ppn64())
+		bitmap_set_msg.bitmap_ppn64 =3D bitmap_ppn;
+	else
+		bitmap_set_msg.bitmap_ppn32 =3D (u32) bitmap_ppn;
=20
 	result =3D vmci_send_datagram(&bitmap_set_msg.hdr);
 	if (result !=3D VMCI_SUCCESS) {
-		pr_devel("Failed to register (PPN=3D%u) as notification bitmap (error=3D=
%d)\n",
+		pr_devel("Failed to register (PPN=3D%llu) as notification bitmap (error=
=3D%d)\n",
 			 bitmap_ppn, result);
 		return false;
 	}
diff --git a/drivers/misc/vmw_vmci/vmci_doorbell.h b/drivers/misc/vmw_vmci/=
vmci_doorbell.h
index e4c0b17486a5..410a21f8436f 100644
--- a/drivers/misc/vmw_vmci/vmci_doorbell.h
+++ b/drivers/misc/vmw_vmci/vmci_doorbell.h
@@ -45,7 +45,7 @@ struct dbell_cpt_state {
 int vmci_dbell_host_context_notify(u32 src_cid, struct vmci_handle handle)=
;
 int vmci_dbell_get_priv_flags(struct vmci_handle handle, u32 *priv_flags);
=20
-bool vmci_dbell_register_notification_bitmap(u32 bitmap_ppn);
+bool vmci_dbell_register_notification_bitmap(u64 bitmap_ppn);
 void vmci_dbell_scan_notification_entries(u8 *bitmap);
=20
 #endif /* VMCI_DOORBELL_H */
diff --git a/drivers/misc/vmw_vmci/vmci_driver.h b/drivers/misc/vmw_vmci/vm=
ci_driver.h
index cee9e977d318..2fbf4a0ac657 100644
--- a/drivers/misc/vmw_vmci/vmci_driver.h
+++ b/drivers/misc/vmw_vmci/vmci_driver.h
@@ -54,4 +54,6 @@ void vmci_guest_exit(void);
 bool vmci_guest_code_active(void);
 u32 vmci_get_vm_context_id(void);
=20
+bool vmci_use_ppn64(void);
+
 #endif /* _VMCI_DRIVER_H_ */
diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmc=
i_guest.c
index dad5abee656e..928708128177 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -64,6 +64,13 @@ struct vmci_guest_device {
 	dma_addr_t notification_base;
 };
=20
+static bool use_ppn64;
+
+bool vmci_use_ppn64(void)
+{
+	return use_ppn64;
+}
+
 /* vmci_dev singleton device and supporting data*/
 struct pci_dev *vmci_pdev;
 static struct vmci_guest_device *vmci_dev_g;
@@ -432,6 +439,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev=
,
 	struct vmci_guest_device *vmci_dev;
 	void __iomem *iobase;
 	unsigned int capabilities;
+	unsigned int caps_in_use;
 	unsigned long cmd;
 	int vmci_err;
 	int error;
@@ -496,6 +504,23 @@ static int vmci_guest_probe_device(struct pci_dev *pde=
v,
 		error =3D -ENXIO;
 		goto err_free_data_buffer;
 	}
+	caps_in_use =3D VMCI_CAPS_DATAGRAM;
+
+	/*
+	 * Use 64-bit PPNs if the device supports.
+	 *
+	 * There is no check for the return value of dma_set_mask_and_coherent
+	 * since this driver can handle the default mask values if
+	 * dma_set_mask_and_coherent fails.
+	 */
+	if (capabilities & VMCI_CAPS_PPN64) {
+		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+		use_ppn64 =3D true;
+		caps_in_use |=3D VMCI_CAPS_PPN64;
+	} else {
+		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+		use_ppn64 =3D false;
+	}
=20
 	/*
 	 * If the hardware supports notifications, we will use that as
@@ -510,14 +535,14 @@ static int vmci_guest_probe_device(struct pci_dev *pd=
ev,
 				 "Unable to allocate notification bitmap\n");
 		} else {
 			memset(vmci_dev->notification_bitmap, 0, PAGE_SIZE);
-			capabilities |=3D VMCI_CAPS_NOTIFICATIONS;
+			caps_in_use |=3D VMCI_CAPS_NOTIFICATIONS;
 		}
 	}
=20
-	dev_info(&pdev->dev, "Using capabilities 0x%x\n", capabilities);
+	dev_info(&pdev->dev, "Using capabilities 0x%x\n", caps_in_use);
=20
 	/* Let the host know which capabilities we intend to use. */
-	iowrite32(capabilities, vmci_dev->iobase + VMCI_CAPS_ADDR);
+	iowrite32(caps_in_use, vmci_dev->iobase + VMCI_CAPS_ADDR);
=20
 	/* Set up global device so that we can start sending datagrams */
 	spin_lock_irq(&vmci_dev_spinlock);
@@ -529,13 +554,13 @@ static int vmci_guest_probe_device(struct pci_dev *pd=
ev,
 	 * Register notification bitmap with device if that capability is
 	 * used.
 	 */
-	if (capabilities & VMCI_CAPS_NOTIFICATIONS) {
+	if (caps_in_use & VMCI_CAPS_NOTIFICATIONS) {
 		unsigned long bitmap_ppn =3D
 			vmci_dev->notification_base >> PAGE_SHIFT;
 		if (!vmci_dbell_register_notification_bitmap(bitmap_ppn)) {
 			dev_warn(&pdev->dev,
-				 "VMCI device unable to register notification bitmap with PPN 0x%x\n",
-				 (u32) bitmap_ppn);
+				 "VMCI device unable to register notification bitmap with PPN 0x%lx\n"=
,
+				 bitmap_ppn);
 			error =3D -ENXIO;
 			goto err_remove_vmci_dev_g;
 		}
@@ -611,7 +636,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev=
,
=20
 	/* Enable specific interrupt bits. */
 	cmd =3D VMCI_IMR_DATAGRAM;
-	if (capabilities & VMCI_CAPS_NOTIFICATIONS)
+	if (caps_in_use & VMCI_CAPS_NOTIFICATIONS)
 		cmd |=3D VMCI_IMR_NOTIFICATION;
 	iowrite32(cmd, vmci_dev->iobase + VMCI_IMR_ADDR);
=20
diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmc=
i/vmci_queue_pair.c
index 264f4ed8eef2..f5f1aac9d163 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -435,8 +435,8 @@ static int qp_alloc_ppn_set(void *prod_q,
 			    void *cons_q,
 			    u64 num_consume_pages, struct ppn_set *ppn_set)
 {
-	u32 *produce_ppns;
-	u32 *consume_ppns;
+	u64 *produce_ppns;
+	u64 *consume_ppns;
 	struct vmci_queue *produce_q =3D prod_q;
 	struct vmci_queue *consume_q =3D cons_q;
 	u64 i;
@@ -462,31 +462,13 @@ static int qp_alloc_ppn_set(void *prod_q,
 		return VMCI_ERROR_NO_MEM;
 	}
=20
-	for (i =3D 0; i < num_produce_pages; i++) {
-		unsigned long pfn;
-
+	for (i =3D 0; i < num_produce_pages; i++)
 		produce_ppns[i] =3D
 			produce_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
-		pfn =3D produce_ppns[i];
-
-		/* Fail allocation if PFN isn't supported by hypervisor. */
-		if (sizeof(pfn) > sizeof(*produce_ppns)
-		    && pfn !=3D produce_ppns[i])
-			goto ppn_error;
-	}
-
-	for (i =3D 0; i < num_consume_pages; i++) {
-		unsigned long pfn;
=20
+	for (i =3D 0; i < num_consume_pages; i++)
 		consume_ppns[i] =3D
 			consume_q->kernel_if->u.g.pas[i] >> PAGE_SHIFT;
-		pfn =3D consume_ppns[i];
-
-		/* Fail allocation if PFN isn't supported by hypervisor. */
-		if (sizeof(pfn) > sizeof(*consume_ppns)
-		    && pfn !=3D consume_ppns[i])
-			goto ppn_error;
-	}
=20
 	ppn_set->num_produce_pages =3D num_produce_pages;
 	ppn_set->num_consume_pages =3D num_consume_pages;
@@ -494,11 +476,6 @@ static int qp_alloc_ppn_set(void *prod_q,
 	ppn_set->consume_ppns =3D consume_ppns;
 	ppn_set->initialized =3D true;
 	return VMCI_SUCCESS;
-
- ppn_error:
-	kfree(produce_ppns);
-	kfree(consume_ppns);
-	return VMCI_ERROR_INVALID_ARGS;
 }
=20
 /*
@@ -520,12 +497,28 @@ static void qp_free_ppn_set(struct ppn_set *ppn_set)
  */
 static int qp_populate_ppn_set(u8 *call_buf, const struct ppn_set *ppn_set=
)
 {
-	memcpy(call_buf, ppn_set->produce_ppns,
-	       ppn_set->num_produce_pages * sizeof(*ppn_set->produce_ppns));
-	memcpy(call_buf +
-	       ppn_set->num_produce_pages * sizeof(*ppn_set->produce_ppns),
-	       ppn_set->consume_ppns,
-	       ppn_set->num_consume_pages * sizeof(*ppn_set->consume_ppns));
+	if (vmci_use_ppn64()) {
+		memcpy(call_buf, ppn_set->produce_ppns,
+		       ppn_set->num_produce_pages *
+		       sizeof(*ppn_set->produce_ppns));
+		memcpy(call_buf +
+		       ppn_set->num_produce_pages *
+		       sizeof(*ppn_set->produce_ppns),
+		       ppn_set->consume_ppns,
+		       ppn_set->num_consume_pages *
+		       sizeof(*ppn_set->consume_ppns));
+	} else {
+		int i;
+		u32 *ppns =3D (u32 *) call_buf;
+
+		for (i =3D 0; i < ppn_set->num_produce_pages; i++)
+			ppns[i] =3D (u32) ppn_set->produce_ppns[i];
+
+		ppns =3D &ppns[ppn_set->num_produce_pages];
+
+		for (i =3D 0; i < ppn_set->num_consume_pages; i++)
+			ppns[i] =3D (u32) ppn_set->consume_ppns[i];
+	}
=20
 	return VMCI_SUCCESS;
 }
@@ -951,13 +944,15 @@ static int qp_alloc_hypercall(const struct qp_guest_e=
ndpoint *entry)
 {
 	struct vmci_qp_alloc_msg *alloc_msg;
 	size_t msg_size;
+	size_t ppn_size;
 	int result;
=20
 	if (!entry || entry->num_ppns <=3D 2)
 		return VMCI_ERROR_INVALID_ARGS;
=20
+	ppn_size =3D vmci_use_ppn64() ? sizeof(u64) : sizeof(u32);
 	msg_size =3D sizeof(*alloc_msg) +
-	    (size_t) entry->num_ppns * sizeof(u32);
+	    (size_t) entry->num_ppns * ppn_size;
 	alloc_msg =3D kmalloc(msg_size, GFP_KERNEL);
 	if (!alloc_msg)
 		return VMCI_ERROR_NO_MEM;
diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.h b/drivers/misc/vmw_vmc=
i/vmci_queue_pair.h
index ed177f04ef24..46c0b6c7bafb 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.h
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.h
@@ -28,8 +28,8 @@ typedef int (*vmci_event_release_cb) (void *client_data);
 struct ppn_set {
 	u64 num_produce_pages;
 	u64 num_consume_pages;
-	u32 *produce_ppns;
-	u32 *consume_ppns;
+	u64 *produce_ppns;
+	u64 *consume_ppns;
 	bool initialized;
 };
=20
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index b724ef7005de..eaa1e762bf06 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -45,6 +45,7 @@
 #define VMCI_CAPS_GUESTCALL     0x2
 #define VMCI_CAPS_DATAGRAM      0x4
 #define VMCI_CAPS_NOTIFICATIONS 0x8
+#define VMCI_CAPS_PPN64         0x10
=20
 /* Interrupt Cause register bits. */
 #define VMCI_ICR_DATAGRAM      0x1
@@ -569,8 +570,10 @@ struct vmci_resource_query_msg {
  */
 struct vmci_notify_bm_set_msg {
 	struct vmci_datagram hdr;
-	u32 bitmap_ppn;
-	u32 _pad;
+	union {
+		u32 bitmap_ppn32;
+		u64 bitmap_ppn64;
+	};
 };
=20
 /*
--=20
2.19.1

