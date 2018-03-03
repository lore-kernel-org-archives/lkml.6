Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2878775-1520036466-2-4044515271437855850
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520036465; b=UQ5eLg1DG6T6INyJf3FG++sDK5JRTIf1RzJnS4OzfIILspS
    LPisyjn/1gEylDK8VfkKGd6PXzNewzdKk6i38NrsLWHA2wtkx5JbQdTsdH59mzjy
    3HpH+luiY1YBMcCgcUuQKzmDsKOey1ncxr/Hdia9A4BIyRatS06znoEmzyy2Xw10
    EaDzANTfE5RGOmpdUV4PNnt6Y1BV/RfboRaJxlp8a0Jh4XSVg+8C5qhEWxuLaq+0
    79g4EaGEVDl1RKztJJlBoA1Us9XbZIQSL6NGpT8VTtE2kPGg3ptHkthoBbQCugN+
    kbZWDV0kzvOI3n4a0XsXfUZMjjSBxm4NfXfZutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520036465; bh=b
    ICTXCwACnyEO/2a/QJ9gFU+fdDZZPLiyBZpKdp1aX0=; b=QDA8zBmh03JzRe9l0
    BQBx1eHXQKhtATb6709KVmFnSL7QyIV9vHTGujHQoNX3abqgiqWx/E5HeehgT3dm
    GNPR0mPWSuidUhmnu2G6t/TARH7cyPgySG8IVRRvm7l2t7buycXgOIFXf+MQZXwY
    90mgtSLHlA3wHvHgSWfgzKaYKX0BqcCpDGczx3Fs0qEOVUTGuC9ybkwEXRakgvbo
    5x3c4U2CAkE79cgMo3Hb1CH14LsVUJtEMrUn9bFP3D1zT7eLcCMoQBWWxaEuTfr4
    ABfrb+xdyFBZ0VQBpwl429nwJyms4QbQhhKrjttwI0wq/oGUyj1DkDWuKD6jV3Fw
    cElsw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PMesG9Fd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PMesG9Fd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>
Subject: [PATCH 3/3] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Thread-Topic: [PATCH 3/3] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Thread-Index: AQHTsoV6L95yC1dTN0ioPU1T64sHqw==
Date: Sat, 3 Mar 2018 00:20:47 +0000
Message-ID: <20180303001947.20564-3-decui@microsoft.com>
References: <20180303001947.20564-1-decui@microsoft.com>
In-Reply-To: <20180303001947.20564-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.15.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0054;
 6:R4WaJhpG4KHsj/7ZXrbrFw/0mjcuqViw6kaSi8xIlJIAsZdHh+kz76kleTUZiWJ34AJHfcwgXUwAE7lCrRicOPNz9QOE29lG+WM6qxlYzISqkNeLAeMq6PAhq339hRXGE85w0xcnARRGnGsAuLY2r6t5NNGf2B0XDLM67m6RUXXx/tk4AViFsrWBVVGtDifICdge9h5LN+rGNA3n0TQIKaSMyRQun0ZAMJ6CA/z77/N7tX15ufp9BS4qYL+qJt/iV8lBbFo6fGGYvHvH7DDRZTOMtCo1FjaY3Z8IPB+UdRh5DtDnR63cfa2kA9RdVNzS3R69HkZfSdGSbk8Mw7hiWGvcIb057PRbn3gI8Rbc/042C+uq+Oh4HngDl7ez1PgN;
 5:0GDHJTrd+yT4ST+SkbntEU/0R6MF2Rdfx+w6wOq0k7S/PC9Im0Oxd/f9aYXjt22+1Rlql+sWcWWhOw4ljj1iUJ+vCo7H/ewPLMsgEyeSrMq+aCSkr3l784ECfjc4nm+5D/sdeyzPWe4BuD87g46ydQ+5iB40Z/vkmxq/KJV4EPM=;
 24:LOvUWXXDgg36Sxa1ZX9MVvXlC9kH5WCrZEmjs/TJuygdu8TFrsB+fLrHV8yStYdH07oTikPCFbFGPXrjaXMnxG7j2R4N83BQiLB2ujX9U9s=;
 7:vi5aAjl+IDD8XVY4HpWDzTmgoi7ETacs4djZdJsbH3+I+t0NtvnePQh7I+ypDLWzpvClaLRn+4qkkUl4R2fCszHxoPIorIOsXYBuVVZTDg+ivsNLqoC0skPQE0iWt5X+pBZX6k7geXmWVErzJON1xrPjDy0fAS7exOj0vc+pZxeRLlzLz60SdhGogA2R+XJTRK/N2uMhoCFk0yyo15YWHARykLNWMWfNhTky3queuqFgeQazMnVUUbfZLlUWYd3I
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3070aba-d2f6-4335-50d9-08d5809c9d01
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);
 SRVR:KL1P15301MB0054;
x-ms-traffictypediagnostic: KL1P15301MB0054:
x-microsoft-antispam-prvs: <KL1P15301MB005406526BE175109D1059CEBFC40@KL1P15301MB0054.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);
 SRVR:KL1P15301MB0054; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0054;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(5660300001)(2906002)(4326008)(6116002)(8936002)(86362001)(2501003)(8676002)(6506007)(2900100001)(6436002)(14454004)(3660700001)(86612001)(305945005)(36756003)(99286004)(316002)(97736004)(25786009)(110136005)(1511001)(102836004)(54906003)(81166006)(10090500001)(81156014)(59450400001)(3280700002)(26005)(186003)(77096007)(6512007)(6636002)(76176011)(478600001)(2950100002)(3846002)(1076002)(22452003)(10290500003)(106356001)(66066001)(6486002)(50226002)(7416002)(68736007)(7736002)(105586002)(53936002)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0054;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: ksyLwVvxzSFbl08WN4s2dp5vNH86iz12D5fRmPUt6Sfrs1EHXnQEotzONA2DzDyQJMyCFZiZbhVtKaiNSzKcvt5LUFzD3BwN8ZtW2BULSBMFZeGWg5sj3ZPfSBMn2iMKxNsoUdZvUyzzAEPqXQgBMDbno51INKBcQ3/hxmr3D4I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3070aba-d2f6-4335-50d9-08d5809c9d01
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 00:20:47.5321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0054
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Jack Morgenstein <jackm@mellanox.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
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
index 57b1fb3ebdb9..32d6b03cdd40 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -522,6 +522,8 @@ struct hv_pci_compl {
 	s32 completion_status;
 };
 
+static void hv_pci_onchannelcallback(void *context);
+
 /**
  * hv_pci_generic_compl() - Invoked for a completion packet
  * @context:		Set up by the sender of the packet.
@@ -666,6 +668,31 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
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
@@ -1108,8 +1135,37 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
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
