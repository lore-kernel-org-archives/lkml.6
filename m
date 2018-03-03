Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2878775-1520036469-2-2242488424989941231
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
    t=1520036469; b=FrgIuKOZFBTYt4uW5ay3RIQJdex8eSBI4RySGg51N4Io+VL
    uRPMl9jW68n4lsB2QzdwCsK3GJEe4prEqAGXemfYOe1UuKmfo1JDJcb2REgZURxd
    HNxrxZ05YZfewSwR4tWTNpaTepBtKncaetusTWIfRomTPs7F4Yot+LlIVggP8/qf
    nFbPmlvwLeVZGhhsasBI0hTy8bBXflE5gUPFhXsyMuNjdSJ7Yrge3uy68xFe9tNn
    U44J7m2xnpHSLZP465ehFr/br9TGGqQ1I714l+mqWPXZpkiK+c25l7yqU9lA4gQg
    NRcIiJUcnW6SJohfnNFrGTrDebnQnn67CQQk4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520036469; bh=a
    YLZXSL0FbZGE1Gv9JrzX8Zy1C+8T2/0ogI/2WwpV/k=; b=jxRqRbQYENTNtUB+5
    nfwIKp3ExA9jinFOXy7GtlN8bxge2e433z5oECUamvccPGeeBV4b8yA3Y9z1C1uU
    I6ed6EzECAsQXPBnPuhg2DJlLtlKUiaU3c1D9oP3fZcS985kX6p+q5llHP313oA2
    XV55FyLcgB9K3b01gvMgi2q46WILqYsGwS+SLpscGRmTtEpHcBtB0BbU+7EoJAoM
    qblwzhKc1RDAdVsk166PbJPNyKKjtpS8FIzObEjpgQMkT4YpzSqp34vbDuFPWd8S
    VujJgcHQnGOe8MuyYErBeJHhq/FjC0Dr+l3NYACcUojPtrBA94C7EeSLZup/f1h/
    wRvig==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rxi4IzjO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Rxi4IzjO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Stephen
 Hemminger <sthemmin@microsoft.com>
Subject: [PATCH 2/3] PCI: hv: serialize the present/eject work items
Thread-Topic: [PATCH 2/3] PCI: hv: serialize the present/eject work items
Thread-Index: AQHTsoV58ygEHWMoYEeyKVqO+bn/hg==
Date: Sat, 3 Mar 2018 00:20:46 +0000
Message-ID: <20180303001947.20564-2-decui@microsoft.com>
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
 7:wDzumdb6lZ67JknReSiPtUA1miPqv881sYQobViJf0PKUmPqwDcKlKVsCcP3KvmNhyeK4K/hQ63efKX4LW1et0eF8OUQ4kJ6Ps9QUW39X5vkYWmAohTHojOLc08AawsjpBBw1jyaw0hjSI7uPmm1ybR20HfIZkczEV64zF45Wpsy16vMj5SvrGTDrBszh+zSYPFEa+sA66FU34f4toac43RevpJXc8KzEdw2k66f83DUXPnuZQVeZD0payGa6XfL
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b436957e-4694-4cd3-441f-08d5809c9c6c
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);
 SRVR:KL1P15301MB0054;
x-ms-traffictypediagnostic: KL1P15301MB0054:
x-microsoft-antispam-prvs: <KL1P15301MB0054B50650B16AE62E27A9C2BFC40@KL1P15301MB0054.APCP153.PROD.OUTLOOK.COM>
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
x-microsoft-antispam-message-info: Mj9aJtiXsvrFx9T2zzJx57+enhmhSUFyZDe6/LUEhK4laVmj/Ut7W/D8tt3C0CgvIk5VG3K282CikeJenqembZN3Qd3cB16zzf66j/tFU/1yV40A5E/HbNATXgp6o7BtRhn8cWmmafFn/BdMZMDB37nzLO0qm+6ya9fGDGcEs1A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b436957e-4694-4cd3-441f-08d5809c9c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 00:20:46.6174 (UTC)
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

When we hot-remove the device, we first receive a PCI_EJECT message and
then receive a PCI_BUS_RELATIONS message with bus_rel->device_count == 0.

The first message is offloaded to hv_eject_device_work(), and the second
is offloaded to pci_devices_present_work(). Both the paths can be running
list_del(&hpdev->list_entry), causing general protection fault, because
system_wq can run them concurrently.

The patch eliminates the race condition.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
Tested-by: Chris Valean <v-chvale@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 1233300f41c6..57b1fb3ebdb9 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -461,6 +461,8 @@ struct hv_pcibus_device {
 	struct retarget_msi_interrupt retarget_msi_interrupt_params;
 
 	spinlock_t retarget_msi_interrupt_lock;
+
+	struct workqueue_struct *wq;
 };
 
 /*
@@ -1770,7 +1772,7 @@ static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
 	get_hvpcibus(hbus);
-	schedule_work(&dr_wrk->wrk);
+	queue_work(hbus->wq, &dr_wrk->wrk);
 }
 
 /**
@@ -1848,7 +1850,7 @@ static void hv_pci_eject_device(struct hv_pci_dev *hpdev)
 	get_pcichild(hpdev, hv_pcidev_ref_pnp);
 	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
 	get_hvpcibus(hpdev->hbus);
-	schedule_work(&hpdev->wrk);
+	queue_work(hpdev->hbus->wq, &hpdev->wrk);
 }
 
 /**
@@ -2463,11 +2465,17 @@ static int hv_pci_probe(struct hv_device *hdev,
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
 	sema_init(&hbus->enum_sem, 1);
 	init_completion(&hbus->remove_event);
+	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
+					   hbus->sysdata.domain);
+	if (!hbus->wq) {
+		ret = -ENOMEM;
+		goto free_bus;
+	}
 
 	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
 			 hv_pci_onchannelcallback, hbus);
 	if (ret)
-		goto free_bus;
+		goto destroy_wq;
 
 	hv_set_drvdata(hdev, hbus);
 
@@ -2536,6 +2544,9 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hv_free_config_window(hbus);
 close:
 	vmbus_close(hdev->channel);
+destroy_wq:
+	drain_workqueue(hbus->wq);
+	destroy_workqueue(hbus->wq);
 free_bus:
 	free_page((unsigned long)hbus);
 	return ret;
@@ -2615,6 +2626,8 @@ static int hv_pci_remove(struct hv_device *hdev)
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
 	put_hvpcibus(hbus);
 	wait_for_completion(&hbus->remove_event);
+	drain_workqueue(hbus->wq);
+	destroy_workqueue(hbus->wq);
 	free_page((unsigned long)hbus);
 	return 0;
 }
-- 
2.7.4
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
