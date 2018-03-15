Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-426994-1521123679-2-3231132368394698459
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
    t=1521123679; b=SOLsL8iioNmmAkjVi+mK5n38KXaDwOnzDhEwfcZQQsLWbD4
    SulJZhuzxUhUc9vZsYE7nfBqteBgjH0Tx8nHH/Tx/uWhtUSnnGqnhbyDEp8Lk13z
    IBywvBf7pyqLGrQfomkvhC7uYS+Mon6NSLrTim8UrZOCk1bgVBTWwWx3wDNeKrfk
    /TDQNBen6eQNhLzLxpXqzS/EmC7Wdeo6YbHJbI5DGKGqMsvGjSvfsA62ZrUeO3L6
    ADBP5xgU3n357EPWjdA1G0nG1dvCatbDl52SHYLjaBk9B5K29ttUwo5t8eQG+tXJ
    YfMdQr0cWoyiavPTGiVYAZIhjmwfOCGkeZZiIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521123679; bh=M
    W2p6l/foKctVDSPBzhHx8D9xNsAWDhyyv2/N1hoYbY=; b=KnCdF3wM5MxldOGE0
    aQJLE7X2RjQWsEAQU38Y1TH+zI7Clmg5rt2BTSNkNt7yRi9kvggVYq9HkMmvHiiS
    ACIYHMF/FvmOtbBIhijAQEKWoZWtsHm5m6gwTfzuX3cnsVy7QYAI5wCLCoKoJJjr
    cs1nG9tCvStvs502LUj9FukONv030jvCYz50oKFm+wtAfzB/f14Ex5Hy2+NDfKE9
    S8TFbTO0q8LyxqTY/bOg3HPNN/4WOsxhFHb9JPwBuB5kZRnekv4XD0upOSVpoGrr
    IZQlFEIuRInnnyt/AxLnfRIKgxZ9SyQdPCHlcF8AE+7zpFJijgO9VCza2F4CKbft
    Hkkmg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RUlFGRow x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RUlFGRow x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v4 1/2] PCI: hv: Serialize the present and eject work items
Thread-Topic: [PATCH v4 1/2] PCI: hv: Serialize the present and eject work
 items
Thread-Index: AdO8O3aRSVmxMVp3Qwu6AztIm4xINg==
Date: Thu, 15 Mar 2018 14:20:53 +0000
Message-ID: <KL1P15301MB0006C96F94181FFB93A222D8BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-15T14:20:51.0093173Z;
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
 7:lza4qqebRSRuO9G98CiaYY6OES6xPYL/LEkx3tYzaF6twvdEZs4y1tJoZyt4rz1udcvvLuFM/AK8xB3Ts1F61JcMiXTZqWRF3aYb2gKAe3tMUbKXyFKCTk5h1vjTk0Ui6tDQgv1p1DmBQ0/aWI2bteUzI5NhLIedDKBKtOqwQ1jh7hAZPgfmK1oxIR71zcPO268fkM+0/UJz1HwB1qnpQvwzuTMaDY9R3zJOi+jWdiw0RMR+H/t3yfrzfcMDNQtD;
 20:8xdGke7aZWI9k3GddcHDbjURcfVkms17okuRX7G1j1MAa5HEIqh+5YvjyMAX8z/uT8IIMyKGJKkUKioODKTjS8It7vg7/i0/8EXWpGF6dOfe7IhsTju1UrLen1bH2bbmaGuIOXFGHAtOkKwyjucwJjPLL/aXVRGV029dJmsF6l8=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14db2b02-20a1-445b-3bbd-08d58a7ff611
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:KL1P15301MB0072;
x-ms-traffictypediagnostic: KL1P15301MB0072:
x-microsoft-antispam-prvs: <KL1P15301MB007273EBF6033A84E673ABC6BFD00@KL1P15301MB0072.APCP153.PROD.OUTLOOK.COM>
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
x-microsoft-antispam-message-info: nDJQE78JLXY7HBkl471N+JSnet5ZhD8BgeRQ0Fj3xtXX384VSNr+JKri+/RFmGmixSX0XO1pCzDHqCf/sP8Px9R3Tl9lb0t6r7Pz5hwqXx4q8otWXsB/lcmGL2KwOcfVLtMzaWzGer0d2d/HWXyQHpEVya7k7rCwgD8seWsdEmo2KYltbgync/6+akGB7Y/FotPUidXVCnZY49g31poH1LtRbtRCFCipBovj0JaasynQnNFP7R9lHXGqk5YEkZZ/c4q59ftcES1gm2UFWRT0UKlKgEKcuMNxonDjzaus5ps5h3Aiw+uREhVM7V2Rru7JaVZp+/qxJW2QqhodczV5TQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14db2b02-20a1-445b-3bbd-08d58a7ff611
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 14:20:53.0972 (UTC)
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

When we hot-remove the device, we first receive a PCI_EJECT message and
then receive a PCI_BUS_RELATIONS message with bus_rel->device_count == 0.

The first message is offloaded to hv_eject_device_work(), and the second
is offloaded to pci_devices_present_work(). Both the paths can be running
list_del(&hpdev->list_entry), causing general protection fault, because
system_wq can run them concurrently.

The patch eliminates the race condition.

Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
Tested-by: Chris Valean <v-chvale@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: stable@vger.kernel.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 2faf38eab785..5e67dff779a7 100644
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
 
@@ -2536,6 +2544,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hv_free_config_window(hbus);
 close:
 	vmbus_close(hdev->channel);
+destroy_wq:
+	destroy_workqueue(hbus->wq);
 free_bus:
 	free_page((unsigned long)hbus);
 	return ret;
@@ -2615,6 +2625,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
 	put_hvpcibus(hbus);
 	wait_for_completion(&hbus->remove_event);
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
