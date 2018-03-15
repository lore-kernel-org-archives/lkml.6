Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-426994-1521124645-2-11840930688198660355
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521124644; b=LUfJCLk6iZbapd3TYiPvih1qDQZ5O6BZHlFTl6bxlYjahQW
    ZJcVtztBixiub/5ElgZj3mcEri+YCWUsZWgiVWzHFPxqkHB2wYMPuPfT1OKtAZ5t
    qfDcpFySSysL8jqrCEC7iCspwRKqbcfyCmHzCJgGT+W/Ly+VysvoHWVEw+huMtSV
    SHU/bWQ3inVWrCem3TDvesAToEGnC44Yskm3cmxzv1GDPMeu8zlgeCb117gQ3Cge
    SphLLdm4r51558KuFF2cjJY5PI5cKHC95cBFkksslfZrh43XfiSQ8EUq9/oI/KhU
    cDGnYb13wm2SEbTLWI5RyIRLy8BAHytyOgaiYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521124644; bh=I
    eQ3AiCU3R1jLrqDZ57LIp+b2Yg6w7DPGByEuNyqSIk=; b=Ogz3f9oy+a0TDeM4h
    Z+d+06h/7HyLkZd6E6tq8n8/VwS2NPPs8wvMt1d0wel1Jg1M2dhJzEQJvLW/Ye6o
    FogfYxrgAVWMlVY76k5jjmY04r6u8HXNkEYdctMHf+7TRojn3Az2hRg14PCMLv+V
    CAGwMQRUN9qZ8M6+jTEN5ISv2xrN4PFaNxUVlnMaSlbyfYpGOK8RDUei0Tx8GNPt
    mm3LOm7VJM0ufkIfObQpJhxFYiXNO9j1uT92ncoiwNio646FyyoWeoALUb5SX7x5
    d2qLpZUJtsUzdJChAQRJZVFGJ6514fe/pp9TiMmNiBvXjU+hekq58gpin4gv9ovH
    tK8/A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OvWnucKG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OvWnucKG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
Thread-Topic: [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
Thread-Index: AdO8O9wjluyUtMmzRL221ru1GgEj1w==
Date: Thu, 15 Mar 2018 14:21:51 +0000
Message-ID: <KL1P15301MB0006E2FA71F87B312D9DECA4BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-15T14:21:49.2100255Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2601:600:a27f:df20:d8b5:442c:6a7d:25c6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0069;
 7:y50A8j/pmB/ISSFr6lcM0nqmk1xE6jIeldvTGIif5RxYhKXI03wcYSiRpYUj3mqQ9Je7Kpfx5zLjVKF8hqiwqJLWNDDnCEs4er19qNG8aYt/+TMlUUR/PPq1m7M10Gf/1FhhmvBctTWar8xN1zodPoa+jm12jsh2uzjMo8efw9tSMjeJ4svN05Slj/J+xw7aZ3kIjxy/QD/Ti2spnMzMAjUyjiqOKycU579hV1LC6eZ72w9ga3MnIiEQr+2xl+IG;
 20:F4qRvRML9tqzQEI9PzyCXZfrxw+6+dFMansB48xJTQ7sx6uXxCx1m8QfO89dTr3yFf/7ya8gZCOrDIdMahS6rDUYJDDJJDYx9InFKKvHrrQ991gcg9lVTxHQ210h43mJpUULU1V+sra5MAm+QHUCdqz849Rs4giMkLNzAyNWHck=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60ff5c64-97d0-4efe-7d0c-08d58a8018d5
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0069;
x-ms-traffictypediagnostic: KL1P15301MB0069:
x-microsoft-antispam-prvs: <KL1P15301MB00699CA467E83845916CA051BFD00@KL1P15301MB0069.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0069; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0069;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39380400002)(346002)(366004)(39860400002)(376002)(199004)(189003)(105586002)(77096007)(8990500004)(7416002)(2501003)(102836004)(106356001)(1511001)(6506007)(5660300001)(186003)(3280700002)(2201001)(4326008)(8936002)(86362001)(33656002)(3660700001)(2906002)(10090500001)(68736007)(25786009)(8676002)(81166006)(81156014)(59450400001)(6436002)(6116002)(7736002)(74316002)(46003)(305945005)(107886003)(110136005)(54906003)(53936002)(86612001)(478600001)(22452003)(14454004)(316002)(6636002)(97736004)(9686003)(7696005)(99286004)(10290500003)(55016002)(2900100001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0069;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: ZT3DYoSwr+SAvjTWeSpethuKrmdU3zNm8+SFnPH/9flyIgZJihU9P048D19Z6bHNhwLA1NChVOXWeGzUpuuOe/n8XFxzmDeBxS1bBEA1r4g8x2dzo+jthWRa0EGtTABrHPEuHpL7WNnOWOeM5CX9RIv3WczdHnAFh1pqp1U5Z3INA6dMZ3EtcoZxP36AfGyO//6hcyDOhVKrvvIRdbnVorb1tA+5S/Mp/+Kvls717L2s/fAIA3BkZaLl8T4q86Tuu1uYAiqvHTYtp+Lc+iAueSyVBaKwWIWjq7X/Q63IMAP34RuvXDC+H7mzjvWKkcHt2x3VWMmoCs1A+DrhGCcPmg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ff5c64-97d0-4efe-7d0c-08d58a8018d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 14:21:51.3790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0069
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

Since we serialize the present/eject work items now, we don't need the
semaphore any more.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 1d2e1cb617f4..0dc2ecdbbe45 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -447,7 +447,6 @@ struct hv_pcibus_device {
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
 
-	struct semaphore enum_sem;
 	struct list_head resources_for_children;
 
 	struct list_head children;
@@ -1648,12 +1647,8 @@ static struct hv_pci_dev *get_pcichild_wslot(struct hv_pcibus_device *hbus,
  * It must also treat the omission of a previously observed device as
  * notification that the device no longer exists.
  *
- * Note that this function is a work item, and it may not be
- * invoked in the order that it was queued.  Back to back
- * updates of the list of present devices may involve queuing
- * multiple work items, and this one may run before ones that
- * were sent later. As such, this function only does something
- * if is the last one in the queue.
+ * Note that this function is serialized with hv_eject_device_work(),
+ * because both are pushed to the ordered workqueue hbus->wq.
  */
 static void pci_devices_present_work(struct work_struct *work)
 {
@@ -1674,11 +1669,6 @@ static void pci_devices_present_work(struct work_struct *work)
 
 	INIT_LIST_HEAD(&removed);
 
-	if (down_interruptible(&hbus->enum_sem)) {
-		put_hvpcibus(hbus);
-		return;
-	}
-
 	/* Pull this off the queue and process it if it was the last one. */
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 	while (!list_empty(&hbus->dr_list)) {
@@ -1695,7 +1685,6 @@ static void pci_devices_present_work(struct work_struct *work)
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
 	if (!dr) {
-		up(&hbus->enum_sem);
 		put_hvpcibus(hbus);
 		return;
 	}
@@ -1782,7 +1771,6 @@ static void pci_devices_present_work(struct work_struct *work)
 		break;
 	}
 
-	up(&hbus->enum_sem);
 	put_hvpcibus(hbus);
 	kfree(dr);
 }
@@ -2516,7 +2504,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
-	sema_init(&hbus->enum_sem, 1);
 	init_completion(&hbus->remove_event);
 	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
 					   hbus->sysdata.domain);
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
