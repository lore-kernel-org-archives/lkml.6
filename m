Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389728-1520277774-2-3812833092100314084
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520277773; b=WHhzpQcRluCWuW+QluFOW1/tbk/Fw/IYd91U798eaLl1p6w
    GPMjS2FOO/w98qepZawGhe4sNpAmJ0XtG/O3vtgxYTW/bbKuzdQI0kjRzHlH70uO
    SQzOHn+KOaVdR7R62f3GtfQYPi/j+5xpgtbNulaBiKzgU7RQPoQBzpSMAtVGAFCo
    NBS06G2FFt5T8cd3hRNGpCaxfeT/axgnCnAv7Qd4To+8Jx95F4an3c7ZInyYNdQp
    3SaHjCwdZoSJYlwI+uImvdIeYxvk+C9/SA3HObS218jJa5N874+437mSb54KsLbT
    Eb9oElePqQeO7IOE5fJ7MjPJiuDOs3H7sJzNCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520277773; bh=tAOOSS
    QQsqXNLgTPumpQNKaAHNv0N1+erEoP8A8AHWM=; b=YsgRGsRakJtlkV5PtLs2AS
    cgUizK07Bt8kaUppmc7N4sD83Gdd31hv1R3B69LvPrFHiZI6CKD7vW6QxVZerI7w
    BDscALvpZ67OEPLG2NsFteSU04H+4ok0R+2BerLJdG4t0V38WKoNLgyf8KFs7U9s
    36QbCqTLDEEWvv5APeRrGNE7a0n6J2TQWJMGQXuYq3OBKrsvVjJnzExiU6eddhyP
    n92DNNsbdnv5YyW6UeTwCVYKFHO5TEJ2+5db+QUYUxHdYl3yD+8h1oP1vidXnXza
    +0885K1iPxTb0NDEUxxhSIYNpvSwqww1rhZQLyezQ9y13wnjQNwXNB9EAty/8uIg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mOg91EKv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mOg91EKv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeCETWg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 14:22:36 -0500
Received: from mail-pu1apc01on0111.outbound.protection.outlook.com ([104.47.126.111]:38336
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752969AbeCETWb (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Mar 2018 14:22:31 -0500
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jack Morgenstein <jackm@mellanox.com>
Subject: [PATCH v2 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Thread-Topic: [PATCH v2 6/6] PCI: hv: fix 2 hang issues in
 hv_compose_msi_msg()
Thread-Index: AQHTtLdKnncg+QyU5kGvRKAFXQRGnw==
Date: Mon, 5 Mar 2018 19:22:24 +0000
Message-ID: <20180305192134.32207-7-decui@microsoft.com>
References: <20180305192134.32207-1-decui@microsoft.com>
In-Reply-To: <20180305192134.32207-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.15.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0039;20:a5UhjxpHMRwvjA9iZJKbdILsDz/tsAwSEv32p4woN0IbUTSMt579p6CwX9Nmv6ZQTzzljKlLnnR1KRXyCfTwFimTG4gt1vhzD1O8S42fJW+74DpHovdj4jjzlQVGymIH7M5Iqt/OtI2M1jAcLgqru2HY0Uci6mmJP0cBhKbWVXI=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49c2159a-2049-45e4-1f08-08d582ce6d27
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:KL1P15301MB0039;
x-ms-traffictypediagnostic: KL1P15301MB0039:
x-microsoft-antispam-prvs: <KL1P15301MB0039AC15861794387EDD2843BFDA0@KL1P15301MB0039.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:KL1P15301MB0039;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0039;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(199004)(189003)(1076002)(7416002)(5660300001)(6116002)(316002)(76176011)(86362001)(106356001)(36756003)(4326008)(105586002)(2950100002)(77096007)(26005)(25786009)(3846002)(22452003)(110136005)(2201001)(59450400001)(99286004)(102836004)(6506007)(54906003)(186003)(86612001)(8936002)(66066001)(68736007)(3280700002)(81156014)(478600001)(1511001)(14454004)(8676002)(6436002)(81166006)(3660700001)(53936002)(2501003)(10290500003)(2906002)(6486002)(2900100001)(7736002)(6512007)(50226002)(305945005)(10090500001)(97736004)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0039;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Xy+xeOz5EuX4ZmEgKi4sds1TSc7EyCfdcjZxi6tWegQwFzJ8cKKnY2UifP9+6ne8BbSfv4fnCUSkXwAzLhKyRdTMkpu3wX6xadO+bHAczUnbCZ7Yj7oDuuX39bI9sJB/IevIr3fG0fywSA7xTjIlsw4M41ODCLHdg9ttWrE9NXX5zjJ0GgXeeXLqXwgk6Qdmi2zc0NM+rOKiyDpriDVNofCAXZn7UI5RJFpx7/YpwgLO2KDnku9qOcRjYsr5XlYK1Cr6pceFCnWhompBEgKhfVvWCE7ArQ+jec95RgqHihAO1pmQCdDyEtAbF8QwY03x/RaEHZA+LJsnULtLx+mGlg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c2159a-2049-45e4-1f08-08d582ce6d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 19:22:24.2612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0039
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
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
"hbus->hdev->channel->target_cpu =3D=3D smp_processor_id()" is true.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
Tested-by: Chris Valean <v-chvale@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
---
 drivers/pci/host/pci-hyperv.c | 58 +++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index d3aa6736a9bb..114624dfbd97 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -521,6 +521,8 @@ struct hv_pci_compl {
 	s32 completion_status;
 };
=20
+static void hv_pci_onchannelcallback(void *context);
+
 /**
  * hv_pci_generic_compl() - Invoked for a completion packet
  * @context:		Set up by the sender of the packet.
@@ -665,6 +667,31 @@ static void _hv_pcifront_read_config(struct hv_pci_dev=
 *hpdev, int where,
 	}
 }
=20
+static u16 hv_pcifront_get_vendor_id(struct hv_pci_dev *hpdev)
+{
+	u16 ret;
+	unsigned long flags;
+	void __iomem *addr =3D hpdev->hbus->cfg_addr + CFG_PAGE_OFFSET +
+			     PCI_VENDOR_ID;
+
+	spin_lock_irqsave(&hpdev->hbus->config_lock, flags);
+
+	/* Choose the function to be read. (See comment above) */
+	writel(hpdev->desc.win_slot.slot, hpdev->hbus->cfg_addr);
+	/* Make sure the function was chosen before we start reading. */
+	mb();
+	/* Read from that function's config space. */
+	ret =3D readw(addr);
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
@@ -1107,8 +1134,37 @@ static void hv_compose_msi_msg(struct irq_data *data=
, struct msi_msg *msg)
 	 * Since this function is called with IRQ locks held, can't
 	 * do normal wait for completion; instead poll.
 	 */
-	while (!try_wait_for_completion(&comp.comp_pkt.host_event))
+	while (!try_wait_for_completion(&comp.comp_pkt.host_event)) {
+		/* 0xFFFF means an invalid PCI VENDOR ID. */
+		if (hv_pcifront_get_vendor_id(hpdev) =3D=3D 0xFFFF) {
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
+		if (hbus->hdev->channel->target_cpu =3D=3D smp_processor_id())
+			hv_pci_onchannelcallback(hbus);
+
+		local_bh_enable();
+
+		if (hpdev->state =3D=3D hv_pcichild_ejecting) {
+			dev_err_once(&hbus->hdev->device,
+				     "the device is being ejected\n");
+			goto free_int_desc;
+		}
+
 		udelay(100);
+	}
=20
 	if (comp.comp_pkt.completion_status < 0) {
 		dev_err(&hbus->hdev->device,
--=20
2.7.4
