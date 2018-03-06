Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-984164-1520360539-2-8393958865071604381
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520360537; b=Je15/QGPAZzlxMeCMX/6I199YUgZqGJONfmh8JLyWhcDfvE
    O73l80j4PYVv3BZC8aj+1CyPdpfXm/tfQhIko/Ot4cJfPRpTk8x2XsepTD2R4eyn
    yIPBSLLrv50SI8Syy5WNyQ+HDcLnPvVfojZKoRZsKJlNJXx0Ep3N1L4u4PbCrbAo
    KhfXRvrcyKj2lM3Sj+tpKdyz+98wCPlnAbUvyodtrbeuXF8UtM7mlmlWwE8JLZUZ
    26O+jEc6I2XT0l3URtsPzpluLiVEw8Lm1ttCxqDmsmCPgD07XoTPMhKKlwr/9Z4o
    d8zxsnVz5GNHcNvbQSwHNtroFUvCAHSo2vLNNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520360537; bh=t
    TWMStG6vcmNgbAum8yoILWhEuy25MJ9WX/GrbiKvB0=; b=I4B6vKZFAfila5rGe
    4oZ+wPMM/ltW5EINYIFGBGLPVQHC5x3BgCk/ggmOV+WxWCoMJnTUAQX7Bb+z/Owj
    mdWceZmcY/nSJ/3I/nwNfr5yvj74N23B42oNSBk1U9n0/unLZMtCHgj96abCwsce
    Ux1xYnZ9/rB9FytaMAekdTrwSdSXp+XgvmN2F9s77KgHn9kjtArQPVwogwU1z+mQ
    XeFro3IzYRUYVsu1B39XNjnxG0yvERn0zhBHqlza6C8QhOdWFlYK1m+/E7Be9qWE
    0aWAbbeSAIzH+rKlwWOnWCT0iWUj0ER2bgwJo8dlk921guaqMiVk7wOePLazYsAl
    5bPsQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hvNyN9vD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hvNyN9vD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Thread-Topic: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Thread-Index: AQHTtXgCGuFYGGn/Jki0TgY7mD098w==
Date: Tue, 6 Mar 2018 18:21:56 +0000
Message-ID: <20180306182128.23281-7-decui@microsoft.com>
References: <20180306182128.23281-1-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.15.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0021;
 20:m9gQqhvr1w+owKtsW/YeMgQC6K2iNjECK5cdYbAL2Lm400rCF/+A17GxukB7fzJVJtTPAL1LJ/94arKRrS8gH4TodTgbbtIKrA5wyiTgEWCGZTBzaXLNsM/namyOJLJ8PnEMtQ/+LB/adc2eCHCEamnSWILqaTEGntRRKZZZJOU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f812c978-69a3-4a91-59f7-08d5838f2576
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0021;
x-ms-traffictypediagnostic: KL1P15301MB0021:
x-microsoft-antispam-prvs: <KL1P15301MB0021B7A9F776793562F92B78BFD90@KL1P15301MB0021.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:KL1P15301MB0021; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0021;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39860400002)(39380400002)(346002)(376002)(366004)(199004)(189003)(5660300001)(36756003)(22452003)(1511001)(10090500001)(2501003)(66066001)(316002)(7736002)(14454004)(10290500003)(2201001)(99286004)(305945005)(7416002)(478600001)(76176011)(25786009)(4326008)(86362001)(102836004)(106356001)(6506007)(105586002)(186003)(77096007)(26005)(3660700001)(59450400001)(110136005)(2900100001)(54906003)(68736007)(50226002)(97736004)(8676002)(81156014)(81166006)(8936002)(53936002)(3280700002)(6116002)(86612001)(6436002)(6512007)(2906002)(1076002)(6486002)(2950100002)(3846002)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0021;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: Z+DQi9QUKLFO76ZxXIY8Nr4XEUxzCLzhesqk6t7s7v+KuyyLKAjgnxglsmzWd+6yrEaG5YQ3hKr0M2AF1bmfZTMme9n6V2o4FD3H+WHbD3mdyNGXGj/Et5f78BO99+fhNR7qFGj/l28UQpamAr5Jcrcpq99ZGHr6pHCDAgYWuMkTcSwp8TF8lBNvg9BCK0urTFxcyw0wl/ipx3AaVZ9SldptUfR5oOIQs7hoxFHotMU5Ztvk2gmJ9mzvsKDvWM5Tw2qL+O5t6W02MKJV5I7w4fcGhgYtvwnP3X1ZDWR0zWmXsS5u+JArFQRf36u0sAx/cg5/+MBQGLem0amdCgSx9Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f812c978-69a3-4a91-59f7-08d5838f2576
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:21:56.9934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0021
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Jack Morgenstein <jackm@mellanox.com>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

1. With the patch "x86/vector/msi: Switch to global reservation mode"
(4900be8360), the recent v4.15 and newer kernels always hang for 1-vCPU
Hyper-V VM with SR-IOV. This is because when we reach hv_compose_msi_msg()
by request_irq()  -> request_threaded_irq() -> __setup_irq()->irq_startup()
 -> __irq_startup() -> irq_domain_activate_irq() -> ... ->
msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is
disabled in __setup_irq().

Fix this by polling the channel.

2. If the host is ejecting the VF device before we reach
hv_compose_msi_msg(), in a UP VM, we can hang in hv_compose_msi_msg()
forever, because at this time the host doesn't respond to the
CREATE_INTERRUPT request. This issue also happens to old kernels like
v4.14, v4.13, etc.

Fix this by polling the channel for the PCI_EJECT message and
hpdev->state, and by checking the PCI vendor ID.

Note: actually the above issues also happen to a SMP VM, if
"hbus->hdev->channel->target_cpu == smp_processor_id()" is true.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
Tested-by: Chris Valean <v-chvale@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
---
 drivers/pci/host/pci-hyperv.c | 58 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 265ba11e53e2..50cdefe3f6d3 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -521,6 +521,8 @@ struct hv_pci_compl {
 	s32 completion_status;
 };
 
+static void hv_pci_onchannelcallback(void *context);
+
 /**
  * hv_pci_generic_compl() - Invoked for a completion packet
  * @context:		Set up by the sender of the packet.
@@ -665,6 +667,31 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
 	}
 }
 
+static u16 hv_pcifront_get_vendor_id(struct hv_pci_dev *hpdev)
+{
+	u16 ret;
+	unsigned long flags;
+	void __iomem *addr = hpdev->hbus->cfg_addr + CFG_PAGE_OFFSET +
+			     PCI_VENDOR_ID;
+
+	spin_lock_irqsave(&hpdev->hbus->config_lock, flags);
+
+	/* Choose the function to be read. (See comment above) */
+	writel(hpdev->desc.win_slot.slot, hpdev->hbus->cfg_addr);
+	/* Make sure the function was chosen before we start reading. */
+	mb();
+	/* Read from that function's config space. */
+	ret = readw(addr);
+	/*
+	 * mb() is not required here, because the spin_unlock_irqrestore()
+	 * is a barrier.
+	 */
+
+	spin_unlock_irqrestore(&hpdev->hbus->config_lock, flags);
+
+	return ret;
+}
+
 /**
  * _hv_pcifront_write_config() - Internal PCI config write
  * @hpdev:	The PCI driver's representation of the device
@@ -1107,8 +1134,37 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	 * Since this function is called with IRQ locks held, can't
 	 * do normal wait for completion; instead poll.
 	 */
-	while (!try_wait_for_completion(&comp.comp_pkt.host_event))
+	while (!try_wait_for_completion(&comp.comp_pkt.host_event)) {
+		/* 0xFFFF means an invalid PCI VENDOR ID. */
+		if (hv_pcifront_get_vendor_id(hpdev) == 0xFFFF) {
+			dev_err_once(&hbus->hdev->device,
+				     "the device has gone\n");
+			goto free_int_desc;
+		}
+
+		/*
+		 * When the higher level interrupt code calls us with
+		 * interrupt disabled, we must poll the channel by calling
+		 * the channel callback directly when channel->target_cpu is
+		 * the current CPU. When the higher level interrupt code
+		 * calls us with interrupt enabled, let's add the
+		 * local_bh_disable()/enable() to avoid race.
+		 */
+		local_bh_disable();
+
+		if (hbus->hdev->channel->target_cpu == smp_processor_id())
+			hv_pci_onchannelcallback(hbus);
+
+		local_bh_enable();
+
+		if (hpdev->state == hv_pcichild_ejecting) {
+			dev_err_once(&hbus->hdev->device,
+				     "the device is being ejected\n");
+			goto free_int_desc;
+		}
+
 		udelay(100);
+	}
 
 	if (comp.comp_pkt.completion_status < 0) {
 		dev_err(&hbus->hdev->device,
-- 
2.7.4
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
