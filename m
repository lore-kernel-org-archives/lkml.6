Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2389728-1520277756-2-6850007223209195176
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520277755; b=FRoPtqxtPb8O1Fh6/yfFa9NzrAukfshCcDsJYtuXjKhV8Oh
    mGgxdJolGvGt7t46Uhk7+tsdJXMWtdSZoPcSsj2shAKPbUxN329iEW6oUqmXp+lA
    GXhREZBwDzTo/2sjaC6WbzryjYTTxE9w6TE4TIk9oqeRa7/m8hCYQgDhnDKLVJu7
    bgCiDFywzn0ecLhPD8gOvQyQLs/juyT0JZxWtkExcNj72p3sYJLYw17yNvgs7q9s
    LM1FjORJ7fehQLiwOVdZxtNws0podQZVKOcwAdvzuf0+XjZg/xxewH5iuwCHNwIf
    XvoepBCaqqZ7YjTz8u4izgFrAy4J+UHlQeXriig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520277755; bh=+
    LCUbcoVX1KhIH6hJ3cBfo9hN8KgNjLAT01eYeJ9+7M=; b=kwLV0VetfBCVKl83X
    UT61xuEEwmKdhynelzzubp1wi489C3TDgCceHcS+01IouFRj8/bmF2KjtBny/n6d
    f5dVHa4ZaGE3buQZRi57+J9S5Zzv+4fBhFniaj0ZZYZwfhZXHAh8a6BQCo2o25ne
    sCZuxVCNjOwkj77Mm6AolD+nNYDvMkRCMq6AgNEfQQll8mdhsnFMl1C4JH4h2Kbz
    3UizkCyvvOTtgffwgBX/ZJdyxX/Au6RW4TzDBXJyFNXJYjFcXEeCeyFb2wKf/sHr
    k3fcPvgIP8qug2YWXx0MiQ12bWCdCtKLH6j/pPtP7ss9YmDqDVt5V3+YI7cDw8UZ
    1fWDQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Eo0mVGnq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Eo0mVGnq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: [PATCH v2 4/6] PCI: hv: remove hbus->enum_sem
Thread-Topic: [PATCH v2 4/6] PCI: hv: remove hbus->enum_sem
Thread-Index: AQHTtLdHnsXJFvisFEWUranPC/7lKA==
Date: Mon, 5 Mar 2018 19:22:19 +0000
Message-ID: <20180305192134.32207-5-decui@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0039;
 7:x81PwCpgpcrUfrCeYtHzbxNL9fiDheUprilufofgfLw1sxNj/OEP1fXTzx1wqRynCGNJ7XZH/thIkDLpIiBANjlWkbmphwXn0I0NNesUe/c9Mq/WvWWIZbO3TZKjcpAG/HycPr094X9/0a8MCt4JhJdhHYgE8v22MkjllQvUmYYU4UCWcH6BW4x4dCKKbf8Ry/6lAT+rRa8DTwLZ/hlR6KGwnCickIEW5BI90eWBtW0b8i/ufgKWSBirUA+j4t+a;
 20:1oyyCrzpkMxnckorcUJZm9Vaj2Po7Mq6aJ9f8F97yb849RT35gSj+EQqpu8rSQa1mw0p40hc6Mom5m7d/lRu3/A/NYQAgpUTlsFW4lhXy+0VDQmhbXTV1N8JPsif5JhzmYBfGmNq6Gmo1fuZmosTHN49+kv53/eyl1cLrYCS3yQ=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4317f52-3c8a-4a1c-920f-08d582ce6a11
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);
 SRVR:KL1P15301MB0039;
x-ms-traffictypediagnostic: KL1P15301MB0039:
x-microsoft-antispam-prvs: <KL1P15301MB00399DC11A68D5645F2EC8B2BFDA0@KL1P15301MB0039.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);
 SRVR:KL1P15301MB0039; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0039;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39380400002)(396003)(366004)(376002)(39860400002)(199004)(189003)(1076002)(7416002)(5660300001)(6116002)(316002)(76176011)(86362001)(106356001)(36756003)(4326008)(105586002)(2950100002)(77096007)(26005)(25786009)(3846002)(22452003)(110136005)(2201001)(59450400001)(99286004)(102836004)(6506007)(54906003)(186003)(86612001)(8936002)(66066001)(68736007)(3280700002)(81156014)(478600001)(1511001)(14454004)(8676002)(6436002)(81166006)(3660700001)(53936002)(2501003)(10290500003)(2906002)(6486002)(2900100001)(7736002)(6512007)(50226002)(305945005)(10090500001)(97736004)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0039;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-microsoft-antispam-message-info: eEUAGJ0cKpiodAoC7XUXhVAc4m0BKQdkkWnxnfB8lQDwHwTWlqNOgZUkCdJY9QoOmZQERAj01xbTa5G71at51zupuek2B90VjN9HEQeF+ASqYKergnQQc5SNv2bISW5sRd1BndNwczFYDvHGDYosXqe7dHXx27MrhijXHnZzQKu3VnF7s96I20e6/RUE7UjHK0YA5HC0dfDvErRMB3N93vkQYZmpP3kH/P+nh+ORX7l7zDThTa9I9K0wEC+Q8CigwSGdbvOrXnGKRgxHwkpLMOPNAnnYyur7O4r15TQFs2CaoCDcaCBfJJg7tRdWwODD+zD1JqbTa+a3ZFIS2bOhQA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4317f52-3c8a-4a1c-920f-08d582ce6a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 19:22:19.0978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0039
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
 
-	struct semaphore enum_sem;
 	struct list_head resources_for_children;
 
 	struct list_head children;
@@ -1592,12 +1591,8 @@ static struct hv_pci_dev *get_pcichild_wslot(struct hv_pcibus_device *hbus,
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
@@ -1618,11 +1613,6 @@ static void pci_devices_present_work(struct work_struct *work)
 
 	INIT_LIST_HEAD(&removed);
 
-	if (down_interruptible(&hbus->enum_sem)) {
-		put_hvpcibus(hbus);
-		return;
-	}
-
 	/* Pull this off the queue and process it if it was the last one. */
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 	while (!list_empty(&hbus->dr_list)) {
@@ -1639,7 +1629,6 @@ static void pci_devices_present_work(struct work_struct *work)
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
 	if (!dr) {
-		up(&hbus->enum_sem);
 		put_hvpcibus(hbus);
 		return;
 	}
@@ -1726,7 +1715,6 @@ static void pci_devices_present_work(struct work_struct *work)
 		break;
 	}
 
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
 	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
 					   hbus->sysdata.domain);
-- 
2.7.4
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
