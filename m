Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-984164-1520360568-2-14119225277504374189
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
    t=1520360567; b=YCQlkUq9LV1j8y1PqI6FoHHVfLzK8VYaCEObolEWpiUyihN
    D0IIDPUnA5X7vLYFUm6eJqynGD5nnVe4cfxCDtMAYSgDKxZsuRwdljzrbn+MZ4mu
    tyLmntuWcuZgm/yizOl487bJt6j3TYDxnLVVc/UTricd7hYl7uz1BUPcQUc0jzCz
    yNouyux7fJay/NnbOKy6KonJITwF/inatS3eYiLOCMyebnIvgVWY0+GEj/Li9dve
    9l+fiw0ghU4XV8sO+Gh41pZnpUEV4LmTyCJRnRDhwayZT1/LhD1ThlWMLnc+Oqv9
    85EtmM6o2/uw01kcp1q+xQ8Fllj7nCPEzwzPPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520360567; bh=VDTAi3
    6vNiAF4XVqq9pvE55MGIRQ1Z0hdhYgldmKj1I=; b=ZRl5O+qIR9JV3QzUvbKZ9w
    ZB1e4hAV8LkjfcyKWR2pMMr0/Xx1Q/DIl9e0+Y2khOLX/RRy74a6i1beDrXkiMeG
    g5fJ1v1DaLXphArNXdow6kKm1DntBkALB1Hwb6WkTkz/oLdhuplT3IVM5vhQRe/D
    llWNatdjDSOOMvfE7Q/00z6yCRuHzvMKZh8m/M9Sc87Xolgt7l7wDk/XbSAdDj/H
    HtL5hlQMrzJB5HXtZX4mcOu/F85yBoVdDUuPRcaXSAmCTQc8t97fQZEMgv2nyelN
    nnkJ0Dgwus6E2wSBWYtDuTzeLQjgCqixJfaZl0TrtFSQ4jF9PdZq8J5Xr0edgAag
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bg3ZfJBy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bg3ZfJBy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbeCFSWH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 13:22:07 -0500
Received: from mail-sg2apc01on0120.outbound.protection.outlook.com ([104.47.125.120]:45036
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752910AbeCFSWE (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 13:22:04 -0500
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
        Jack Morgenstein <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3 4/6] PCI: hv: remove hbus->enum_sem
Thread-Topic: [PATCH v3 4/6] PCI: hv: remove hbus->enum_sem
Thread-Index: AQHTtXgAa8fIMcLAyEOTQ7E5yzw6yA==
Date: Tue, 6 Mar 2018 18:21:53 +0000
Message-ID: <20180306182128.23281-5-decui@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0021;7:fsqFatwG45sLEfd8foLvMXB2QMAHM2eey548hsHd6atoR9kuOcVJoIxLLrnORz3MfIijDcOqq9WZexs7tc+opr7iDhHQN8SwxweVvROBrFIB40L5msVSQMAQeH3AJXfWjbsnMmHhIHML/UHPBrqAn/pZ31XY4kn76lscgpk+M90bT/RTJvnxSnN/elTeguPg97dv1tkdc9/nGIuqJ9JaGki7cBEUuYQHqU3pOPoMQe4KlymPJscGKrlJ034xJGzn;20:UckhJojJ5f0HqEpwlJywaTqdUh9rLrXJTk2YfLoSipdCKXJDm1BVbmt9MB6YYnmT+KXmNRivCn27bW/R5DiU5NC/5nvc5ecgISVUYDXL5lth+l6Y/69/1oujuXNdHVE9NS2s62dfkCYTlUVBhtTFC6y834JHzcJRI3U8oy89DPw=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60a49d86-6b35-44ed-1b6a-08d5838f233c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0021;
x-ms-traffictypediagnostic: KL1P15301MB0021:
x-microsoft-antispam-prvs: <KL1P15301MB002139E57B2AEEC4188059CBBFD90@KL1P15301MB0021.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:KL1P15301MB0021;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0021;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(346002)(376002)(366004)(199004)(189003)(5660300001)(36756003)(22452003)(1511001)(10090500001)(2501003)(66066001)(316002)(7736002)(14454004)(10290500003)(2201001)(99286004)(305945005)(7416002)(478600001)(76176011)(25786009)(4326008)(86362001)(102836004)(106356001)(6506007)(105586002)(186003)(77096007)(26005)(3660700001)(59450400001)(110136005)(2900100001)(54906003)(68736007)(50226002)(97736004)(8676002)(81156014)(81166006)(8936002)(53936002)(3280700002)(6116002)(86612001)(6436002)(6512007)(2906002)(1076002)(6486002)(2950100002)(3846002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0021;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ZjCcjs3j4XmPLnljmyx+Yp0MwronQ1sN6t0acnN9cYPaNY6AnByaXHIu536SZto2j4/T1NRTd/OH0OV4lZrkahNdqvFRNjBRm4BvBi3zsGH7DKuRVM/2I38RHk2i5aX1qxl5IKoTXKnE+TOd2uH6Ecvac3uEwRy5z/yAGaACSe27cMRrADXu2MAneh7k9MZGMKgovEocXG5NlKqITOKV/7M1Vpa7h/UxRJcy7IgXOsN3KTSIgL7nyDdOmFZSs7CfwcMMhAokeqQTZVGcp8sV/huJ0cE1hj/5741No9jJG8LPKJ4ZzM04/YJ28rPra3YN0r08pH52/FEYujS0EKwECw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a49d86-6b35-44ed-1b6a-08d5838f233c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:21:53.2983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0021
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since we serialize the present/eject work items now, we don't need the
semaphore any more.

This is suggested by Michael Kelley.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index aaee41faf55f..3a385212f666 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -447,7 +447,6 @@ struct hv_pcibus_device {
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
=20
-	struct semaphore enum_sem;
 	struct list_head resources_for_children;
=20
 	struct list_head children;
@@ -1592,12 +1591,8 @@ static struct hv_pci_dev *get_pcichild_wslot(struct =
hv_pcibus_device *hbus,
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
@@ -1618,11 +1613,6 @@ static void pci_devices_present_work(struct work_str=
uct *work)
=20
 	INIT_LIST_HEAD(&removed);
=20
-	if (down_interruptible(&hbus->enum_sem)) {
-		put_hvpcibus(hbus);
-		return;
-	}
-
 	/* Pull this off the queue and process it if it was the last one. */
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 	while (!list_empty(&hbus->dr_list)) {
@@ -1639,7 +1629,6 @@ static void pci_devices_present_work(struct work_stru=
ct *work)
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
=20
 	if (!dr) {
-		up(&hbus->enum_sem);
 		put_hvpcibus(hbus);
 		return;
 	}
@@ -1726,7 +1715,6 @@ static void pci_devices_present_work(struct work_stru=
ct *work)
 		break;
 	}
=20
-	up(&hbus->enum_sem);
 	put_hvpcibus(hbus);
 	kfree(dr);
 }
@@ -2460,7 +2448,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
-	sema_init(&hbus->enum_sem, 1);
 	init_completion(&hbus->remove_event);
 	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
 					   hbus->sysdata.domain);
--=20
2.7.4
