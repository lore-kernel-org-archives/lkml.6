Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-984164-1520360609-2-3460864332922158146
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
    t=1520360608; b=UM6FGZ3DKkG3/v9pKBdRCXP0/xjlAKjGTHuVSuyaj2rlinq
    7Shprggq6U8vZ0LrYDG7moym04ff7Va3i6tRw72rpGr81wdMJlUlqVY45hzsdEJ1
    kx7ULwtGN8cLGozywG4Nawq5fG94zVYFODCx17mbYR6nQtN//JRbEbCZe6Veadaz
    EZfE1oBf4xlb90g3QhMYgqNyYzSK618vnYQYsrI9RUaigbt45tiy7NUCN2TPW+aG
    ZJefKU3u0rU3SswQA/5uhUx0/0CXznK7a/b/OR3dNPacSB7W8jbzu83LcB64yQoZ
    PF5yXVscHbuDzCv3rIjIBYyqQ80zupgiXrug5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520360608; bh=fI09oB
    ugTBMw/6wJrr5UWqNpvgm9pXkZrMeZGwGi6Ao=; b=Wgs2VO/3q3jBJfgPFfn2dB
    bzhIknS58U/uC8WpkV9JR6PmeDE3jVTQVIj5agYawUqSKbYqiuftSiB70Fp3HgMU
    YkytVpFVcvt4UUbEMuk6FZylwRUFcANDNm3KKU8exKhq1uo4BKU3QSTS522DzpG9
    5Yft/3IZL2jNx2JugFAiXGQEgZPBAatSHvAl7IfiStZtUj953eJrO1xLyoBb68tr
    F/sf/CeDrUWhShrTMvQfs2V9iZPBg2pWIPghCu7IQj3OHvXSOu9YBiOzkCS1Uq+B
    TATJ+2tkb5Hoy+bXed29OGgt+8MBm0y2TfWBCYne6i83w4Hh2uAM+st1zTO1lBKg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lSM020TC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lSM020TC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbeCFSXM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 13:23:12 -0500
Received: from mail-sg2apc01on0120.outbound.protection.outlook.com ([104.47.125.120]:45036
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753851AbeCFSWA (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 13:22:00 -0500
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
Subject: [PATCH v3 3/6] PCI: hv: serialize the present/eject work items
Thread-Topic: [PATCH v3 3/6] PCI: hv: serialize the present/eject work items
Thread-Index: AQHTtXf/Svimyxa0lEG1rzwqwCqgUQ==
Date: Tue, 6 Mar 2018 18:21:51 +0000
Message-ID: <20180306182128.23281-4-decui@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0021;7:99tQDu8SpvW4KlaMeSuSYMBsAYEGqczyypohg7fkQLgpU0znAJHMnN+oaz73IxVaJBAzs6fDSKZ/16FcUBV/X0tjmOuCeJbikvx9XpzSLbjOOv2Jw9bVnOA4Qgld4ksHSmZXtjEOcEgKlI989W/yYaYsHquT4rfegILOds4McqzZvPiSHKb6lsycxmhMEnDCXOex4S3sayoP4H8UXD2QtNh6nqAw3a9kSmJLBR4fPZWbKoqYaENgECXqJYY4cig8;20:OuIsGzbuXfCdYQxm2kHqjWZgrrJFG4qKjG0povHtOqx1ee6DlEB4kSJkevPBexD/CP8wk/jI/GLApXx65XX/L/VW2U6/sKkpHl3p+SQCgKWmcDdRuL893PJsYbbPPFFAI3AwbdyNIWNbRnbRWlI5cAhMXVJLAZEiFSXaYFiufsI=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a32b673-c0e8-4301-360a-08d5838f2215
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0021;
x-ms-traffictypediagnostic: KL1P15301MB0021:
x-microsoft-antispam-prvs: <KL1P15301MB002164D69044795407628FFEBFD90@KL1P15301MB0021.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:KL1P15301MB0021;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0021;
x-forefront-prvs: 06036BD506
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(346002)(376002)(366004)(199004)(189003)(5660300001)(36756003)(22452003)(1511001)(10090500001)(2501003)(66066001)(316002)(7736002)(14454004)(10290500003)(2201001)(99286004)(305945005)(7416002)(478600001)(76176011)(25786009)(4326008)(86362001)(102836004)(106356001)(6506007)(105586002)(186003)(77096007)(26005)(3660700001)(59450400001)(110136005)(2900100001)(54906003)(68736007)(50226002)(97736004)(8676002)(81156014)(81166006)(8936002)(53936002)(3280700002)(6116002)(86612001)(6436002)(6512007)(2906002)(1076002)(6486002)(2950100002)(3846002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0021;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: BnTYXDTiNR7cIV22RE6DCNgaDWrNiI6dDiaqV+LAoM6bzCDxk4kpAgAudEmJlQFv6xICAbt8vWumiwgYANtPmWR0TwDzoC1HaWVr5WzZfeZegxgsQSp+2cHrtUmH0Uc8nJEErwmF+yP6LVr5r9+Zfme5VTjqpZKSnR5g764Huhx6/pvGWbVG3bcus9kpnoW4BAIr4q+TKu0Db+9K51m3pm/aqdmIQlZH9WROlr086ibnChFnCnpK/EWGYu7wlMYQvVQcG3SNszcXPRupqIp99qIUbw814n6+hpblYT3a7bqbGkXneaMNzZb6IQyJ89N7q0yqUqiw+5lTo1z+vbCJMQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a32b673-c0e8-4301-360a-08d5838f2215
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2018 18:21:51.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0021
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When we hot-remove the device, we first receive a PCI_EJECT message and
then receive a PCI_BUS_RELATIONS message with bus_rel->device_count =3D=3D =
0.

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
=20
 	spinlock_t retarget_msi_interrupt_lock;
+
+	struct workqueue_struct *wq;
 };
=20
 /*
@@ -1770,7 +1772,7 @@ static void hv_pci_devices_present(struct hv_pcibus_d=
evice *hbus,
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
=20
 	get_hvpcibus(hbus);
-	schedule_work(&dr_wrk->wrk);
+	queue_work(hbus->wq, &dr_wrk->wrk);
 }
=20
 /**
@@ -1845,7 +1847,7 @@ static void hv_pci_eject_device(struct hv_pci_dev *hp=
dev)
 	get_pcichild(hpdev, hv_pcidev_ref_pnp);
 	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
 	get_hvpcibus(hpdev->hbus);
-	schedule_work(&hpdev->wrk);
+	queue_work(hpdev->hbus->wq, &hpdev->wrk);
 }
=20
 /**
@@ -2460,11 +2462,17 @@ static int hv_pci_probe(struct hv_device *hdev,
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
 	sema_init(&hbus->enum_sem, 1);
 	init_completion(&hbus->remove_event);
+	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
+					   hbus->sysdata.domain);
+	if (!hbus->wq) {
+		ret =3D -ENOMEM;
+		goto free_bus;
+	}
=20
 	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
 			 hv_pci_onchannelcallback, hbus);
 	if (ret)
-		goto free_bus;
+		goto destroy_wq;
=20
 	hv_set_drvdata(hdev, hbus);
=20
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
--=20
2.7.4
