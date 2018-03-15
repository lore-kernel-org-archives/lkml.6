Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-373521-1521123692-2-18321254534146722386
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521123692; b=Z8E6ecsgcI0CxptL7YIbaVyrkz8O+OFq6/QoyFsjZjf/OtV
    EUv/5ZiqMdaj8Asulcc0w26lfRb+CLeFTgPDhgb2Ldzx5ZOlee2D/bKpx7YiZFtT
    2H51yBZVimIlH1ouiG7o6PBUiH6d30LXc6Z8AH3Swh9V6rpvtUonghQK/IuJTKh8
    J8CBYifFsMdBk7ohONwwELY/xbY4aI8WSGc7LPvFRLngVW+gm5MmaDD1jn27mCW2
    dwT1/K8pUCItllh3+e1fGAMIJvdboAPiynautxiQTO3J4jpM51VlPsy9ciYMsD0U
    8z3fUMIkkeSm+TRTi2nRszNsyfvVTu8KWPcRAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521123692; bh=j
    KFm115nYoWTXp3fhMOBIPwRyq57ErJtvLhnRo/LJKI=; b=DSZxlgLQu2T3WQ19z
    8I2bROzsFjRmF7WPhzz9So3KXR4NKaro16D5J217ZqczOcY5CWGvQjWfgrZgTbI6
    8nKlzfFFJ2mUZ0x6WpmTZqMPVY7nA6g+x87OlaS8/AfhcsaoPDWtb+DyQLTlvDqz
    Ndmq7QTL7XclrKyTZnXZSTLh8goqoxLUzHHiVnIlOscNLX8YdEXe/tfuvz+6qcp/
    72rnqd0MAwGU4+8YDn2wtmhocf/NVdLCa5qjpfdKWLS08db43jRaIFRmkO2S9TOa
    F/uC4rD/1zCRZA8e0b9P0v1t3U7IwxwyhiVk/BYBsiKryqC/cXYq3xYnjQuwE6gL
    rVbRg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zwl6S/l9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Zwl6S/l9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v4 2/2] PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()
Thread-Topic: [PATCH v4 2/2] PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()
Thread-Index: AdO8O4kEYfjYpPA4SNKhP2VbewlXZA==
Date: Thu, 15 Mar 2018 14:21:08 +0000
Message-ID: <KL1P15301MB00066707A5CC8A328CF2429CBFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-15T14:21:05.9351840Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2601:600:a27f:df20:d8b5:442c:6a7d:25c6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0072;
 7:cERJbhrHV3TRuKNPUN7s2fSdYTdSlOfx7K2PcjGjiUGc7zi57F/bKdGJlSOl4k2JncQlVh+qeUDWBW6zqSvZLqCEDvpY3SOPpyaZF9OAL7U5HYsIUPyPLSASuzSqCfm4Qv4+ZwkdKoO8LEPMSUlXJQdEfn4GH/PB//pID7P/yNnBIsqaH9bpNPYDsuH7ZvuSZ5YJfukNIaJSVawDtltx7BBhFcPRCNPzNMG1Bds+pziCPU55hEGZG0bb1nBR52Wr;
 20:URytUCp3dmLCfUVa2OftNx29vMjjXlyZvtb8qei3yNGBfE5Bm8+2dQKBcyYrMQyoccLRbnwCP0H3F1tUfHCcEQ2nxq4asfv/jjJjyjpJnQpVMPTUsXiRBdxHdkmTlJ4h7WQF1g5jXy1VbaFSs9bM99qh9TgnlgBe1R38+RKbiH0=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b4db9fb-014d-40a7-c3b2-08d58a7fff12
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0072;
x-ms-traffictypediagnostic: KL1P15301MB0072:
x-microsoft-antispam-prvs: <KL1P15301MB0072DBB3ABEDCC748CFB8AEFBFD00@KL1P15301MB0072.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0072; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0072;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(39380400002)(189003)(199004)(14454004)(7696005)(4326008)(2900100001)(478600001)(5660300001)(68736007)(10290500003)(7416002)(3660700001)(97736004)(110136005)(7736002)(74316002)(107886003)(54906003)(86362001)(316002)(22452003)(25786009)(99286004)(2501003)(2201001)(8936002)(305945005)(6116002)(10090500001)(102836004)(33656002)(2906002)(81166006)(186003)(86612001)(77096007)(53936002)(8990500004)(6636002)(8676002)(105586002)(55016002)(1511001)(6436002)(9686003)(106356001)(81156014)(3280700002)(59450400001)(46003)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0072;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: +SXZ7qlHevDTy2ze2G0O8oU8k7y/nBxOXG8oFjdqVo0+ZnE1eEGTV7M8+1wP3JZv0WiVoWLISwYY8CWpAjlqkUc4AteDlpjLbl3HH38SpyZpaJf4wGYjEoswiFeumdHdOcWFlIH5t4LdtEPwcTZnqRrLi5wMejEKrE1lBHIi1/miKT/XjC321dNIi2Y2HjfDfHrnd2X1gsXNXWPXS40ySTjcbYP+q361qJ2qis0MOrCNG9BiLdlhKPK/lFGf3EV9fYD2xOykxhaYOEXWv4g1pm8RJmqHQv/r6RBLEMAdNJOGTaCBY4aVXfah+LTl8l6pnD+SiPpuoUiQINnREz5ZzA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4db9fb-014d-40a7-c3b2-08d58a7fff12
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 14:21:08.2067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0072
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael Kelley
 \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
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

1. With the patch "x86/vector/msi: Switch to global reservation mode",
the recent v4.15 and newer kernels always hang for 1-vCPU Hyper-V VM
with SR-IOV. This is because when we reach hv_compose_msi_msg() by
request_irq() -> request_threaded_irq() ->__setup_irq()->irq_startup()
-> __irq_startup() -> irq_domain_activate_irq() -> ... ->
msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is
disabled in __setup_irq().

Note: when we reach hv_compose_msi_msg() by another code path:
pci_enable_msix_range() -> ... -> irq_domain_activate_irq() -> ... ->
hv_compose_msi_msg(), local irq is not disabled.

hv_compose_msi_msg() depends on an interrupt from the host.
With interrupts disabled, a UP VM always hangs in the busy loop in
the function, because the interrupt callback hv_pci_onchannelcallback()
can not be called.

We can do nothing but work it around by polling the channel. This
is ugly, but we don't have any other choice.

2. If the host is ejecting the VF device before we reach
hv_compose_msi_msg(), in a UP VM, we can hang in hv_compose_msi_msg()
forever, because at this time the host doesn't respond to the
CREATE_INTERRUPT request. This issue exists the first day the
pci-hyperv driver appears in the kernel.

Luckily, this can also by worked around by polling the channel
for the PCI_EJECT message and hpdev->state, and by checking the
PCI vendor ID.

Note: actually the above 2 issues also happen to a SMP VM, if
"hbus->hdev->channel->target_cpu == smp_processor_id()" is true.

Fixes: 4900be83602b ("x86/vector/msi: Switch to global reservation mode")
Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
Tested-by: Chris Valean <v-chvale@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
---
 drivers/pci/host/pci-hyperv.c | 58 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 5e67dff779a7..acb1941423a9 100644
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
