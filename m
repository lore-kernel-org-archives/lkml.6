Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2389728-1520277778-2-8505920042152428370
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
    t=1520277777; b=H8rQnp/03oX6BK78jBY2jQsx2KZdIWpiihKJW3y+wirBsJY
    D0IhjHwvkV6l+Jjh0dtkPVNpKF+dIWDxLZEHO3HiYZlVFZwW7sbRmCZ28eRyLYqv
    n9XbD0yXRlGbBtTnzHXkTDbT2pnKLjc/ShjXRIXHTMp8feUwOhfPoiAaC+a9NCB2
    ZZcVopqpK70h7jcnWTuWjJGrCrs8AiopMZJ92UXfyzoGrHPw0cybjE3N+aR/DG9b
    I5oCiLJQcdjiUZHsFeP15b3b252vk+G9xYpp7RizxPEj/j9vPuMCGLHp+hToyxot
    HHPuzkIFNa6YQgb+GTl5T+uLdP+5imQLOKMEsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520277777; bh=0
    gG0fJ232B4TnMtoZg6B9lxawg5rOzbVakqVyJPpBQU=; b=EaB5px9J/YZQhU+Dt
    K06RWNjMUXk/0niLff6gkpv2I8DRyZPrNs755aV4kVuGDLm4dBJ1NHaODhzwmQeE
    8H9ia42bHQUnw6iJFNVhsBazs0BETV6f3VzMyjxNd11eTvHLSpTrWX6wMGhv9MXU
    vEiOaEAoGkNknfDsnmmuM17iXJn6aB0OTuUcLxbE5+VRjiYmk7sX2IXDK1zY6i7Y
    4TRSCsxKDHazEMxgY6qDrRGUOpz+rDt7VXVw+4eutOJ4JCaNVEoxgLGzu7GYP4bW
    gsLco99cXUyFYFjI4aVNWzJfjnoMf9Azd3Tb1HhdXDPXWvswD66jwoN3voNJs93R
    glYVg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lReeaGQL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lReeaGQL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v2 3/6] PCI: hv: serialize the present/eject work items
Thread-Topic: [PATCH v2 3/6] PCI: hv: serialize the present/eject work items
Thread-Index: AQHTtLdF9VixgM1SgE2S1sRr4R78NQ==
Date: Mon, 5 Mar 2018 19:22:17 +0000
Message-ID: <20180305192134.32207-4-decui@microsoft.com>
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
 7:vCnXLLktDG9wM9uw0/ZEZI+QhTjhA/+x1Dw0hTRrqRw6/lQOF1GKhIMe0RuH7yda1Azx4RCgfV52m+yCLTniZOR0aAXXam7BsnUYxjJNx+WRZhjIo28cpWxCbMHhaqImPTZYXskTPY72WWbcbCFwo4YqWWYEphCJffJKpr/kXA2mudZrjezSzSLkRV5WccDVG/WbNyBmp36e9RX0loMOhVW/95gjVnFOevxLbhWJ56nCI6RFH6FGYen2W0VrYhWN;
 20:BMIgCHOjLa3kcajAuWaXLSlf2Kw+CBdKZxdXT/91Oci7hCpLVG8gHhc7xKSc7nX8geFaELiJkU+YfPGCx3StpwOGHTYiqFvV/AuyeQho9TtswUE0MnWyAqnc6T1NwPNrAvKbbzqQMvxwIPA2IismqGUvDlZOQaIwHu2km3HcQiE=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 623ac24b-c760-401e-1983-08d582ce68d0
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);
 SRVR:KL1P15301MB0039;
x-ms-traffictypediagnostic: KL1P15301MB0039:
x-microsoft-antispam-prvs: <KL1P15301MB0039244EC49124947A88EDF7BFDA0@KL1P15301MB0039.APCP153.PROD.OUTLOOK.COM>
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
x-microsoft-antispam-message-info: oRGgeVPi4o4BUfpQJL9T7XFe43eTi3uunLbbXCJlhMe80sPwYZHajIG9MANgLlE+T85RmNTg6YafFJNyELT+ApohGyn7QZlbPcYvvKttQzC9iuoqTtm+YI6RcYW10vYSJFNrrPHRtA2yGhH4UvR0IMmiKVnaXidCAdkEQXdYLn/l0vrTN3z9zJsURQxJvIzPRCtyM51xwR6gdsly5daFflwrNi8+EU6SnQgh/JG71fPvDtkfO/IA/tLE0aqB4ITtkdKl6rTcI7QZwD8V1aZqZDoBB10A7lgzeCN31BHnKrsJSxvJs4iOvrCzk7iDSkkEWUK+6xodC0nsX5oQ+DdUig==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623ac24b-c760-401e-1983-08d582ce68d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 19:22:17.0320 (UTC)
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
 drivers/pci/host/pci-hyperv.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 04edb24c92ee..aaee41faf55f 100644
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
@@ -1845,7 +1847,7 @@ static void hv_pci_eject_device(struct hv_pci_dev *hpdev)
 	get_pcichild(hpdev, hv_pcidev_ref_pnp);
 	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
 	get_hvpcibus(hpdev->hbus);
-	schedule_work(&hpdev->wrk);
+	queue_work(hpdev->hbus->wq, &hpdev->wrk);
 }
 
 /**
@@ -2460,11 +2462,17 @@ static int hv_pci_probe(struct hv_device *hdev,
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
 
@@ -2533,6 +2541,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hv_free_config_window(hbus);
 close:
 	vmbus_close(hdev->channel);
+destroy_wq:
+	destroy_workqueue(hbus->wq);
 free_bus:
 	free_page((unsigned long)hbus);
 	return ret;
@@ -2612,6 +2622,7 @@ static int hv_pci_remove(struct hv_device *hdev)
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
