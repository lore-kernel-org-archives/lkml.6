Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121308-3-9780812867695562190
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
    t=1520121307; b=CCegKR3u366YlMh/d5yYOpnNCwM4tsJ6y2HjqAR5rzfTjQ+
    ujiKMxu4V8vmCdk7iAhpaijN2srYBt6fRrhJSV+9jZXh08IOQALC8vflkFcFKJ65
    c2vquerjrXgyNKouehbCNxVGMw2XL5HJIrf4aLdXWpMQVSAAnzlVTYCGx+YoxO5j
    hdhoJL/R9SB04e/tLQj/pNz96q0n6bNfvw/sCCqGQuStVHmHhD22PpkhBManPWJe
    TKPK0+NYBX6DpUzm3ncgPgzdsgwXX5d5KZxbyNpwg4jgRdE6ckpNikc6lDqXWRP5
    UltOq6/VlDc4vk5N7gWssK2g0YU5F/1+oJl2WIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121307; bh=JiDL1z
    Pgo5Ypsq4DRmkdQSUn4S+ilJH8dGOVRfnWbNo=; b=tGNq9N9yJw02nhBvZjAMnu
    OXjy5lIEnpJ7OcwsUtLlGM9OAghb8iVmYAdcyN/Nx/HbPOlg9zdkQHUH+SiGaOBW
    YU4/Ionezi/nmq4wPBAt7DqY16mgnN9VBNHehTQ4w4ieyNPb0aBiIr8HD+uBkXQY
    aFDYKfVyv8F5w6rLtRM1JT73GaS03IHSek1BrsbiLJMXNhMwLrkn8WZ+oMds+e6A
    mcNEZc+Ss/zblMZDsQ3QdspAWid76IODdBxtTqeJtYuAfgXsX0mgRzHQX5fO4JW+
    zF2TFMVnVQ2kO52lxDpFX3ZWSl1DldIBP+Ak2OjMBmfwBCuGEcEDIea3OUOgaxyA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ush4LPh2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ush4LPh2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeCCXzB (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:55:01 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:47215
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933909AbeCCWc4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Long Li <longli@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 063/219] PCI: hv: Lock PCI bus on device eject
Thread-Topic: [PATCH AUTOSEL for 4.9 063/219] PCI: hv: Lock PCI bus on device
 eject
Thread-Index: AQHTsz72+wxsR5x0H0emxMo2bADkPw==
Date: Sat, 3 Mar 2018 22:28:32 +0000
Message-ID: <20180303222716.26640-63-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1098;7:e4qwkoA1KXUr7pcyI0s32SpDfoEk1SRj1n7rxmyRZpoWdyXqFv/JEdj0eTXrC7ZeDHttBICFj66Hbcd/SzY7/aYykd/+B/QBaahoeeY8UidqBYL0UJBzflBYKCZMtFuRgUCT933pYBcGXEr7KIAfBkNQPU1QvjXy0rihxo2c2Pe32kTJt9MRQPZP3VyXw8K94+RtTaJlbVY9jVXBtGoYeIhN0i+NQZJcD2dyGGTGTSd0O5ONb4Z+75haeYZgXLdU
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95db4c85-6240-4d8d-3bbb-08d58156b27f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1098;
x-ms-traffictypediagnostic: MW2PR2101MB1098:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10986AC8690EDD699939CE23FBC40@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1098;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1098;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(366004)(396003)(346002)(199004)(189003)(2906002)(8936002)(36756003)(6512007)(81156014)(10290500003)(81166006)(99286004)(6436002)(68736007)(478600001)(3846002)(22452003)(53936002)(8676002)(110136005)(54906003)(4326008)(316002)(76176011)(6116002)(7736002)(105586002)(305945005)(3660700001)(1076002)(14454004)(97736004)(575784001)(25786009)(186003)(72206003)(26005)(102836004)(86362001)(6666003)(2501003)(3280700002)(6506007)(5660300001)(10090500001)(59450400001)(66066001)(106356001)(5250100002)(2900100001)(2950100002)(86612001)(6486002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1098;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ph3E/xQair2cljXDMU+Q5jToKw46N8SrGG9oT+7DSmylC/mzHGK3XpBCT2JDcN33/5CCkgAwxIZtLluMiN0AHsvglBalUoG/pQTDXvCM/EkhNDtQILnFND9ONpCoM3LFnzVpxMjjg553i5lgTtX3tKC1MCX4kthggcQwIGJkFdY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95db4c85-6240-4d8d-3bbb-08d58156b27f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:32.8694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Long Li <longli@microsoft.com>

[ Upstream commit 414428c5da1c71986727c2fa5cdf1ed071e398d7 ]

A PCI_EJECT message can arrive at the same time we are calling
pci_scan_child_bus() in the workqueue for the previous PCI_BUS_RELATIONS
message or in create_root_hv_pci_bus().  In this case we could potentially
modify the bus from multiple places.

Properly lock the bus access.

Thanks Dexuan Cui <decui@microsoft.com> for pointing out the race condition
in create_root_hv_pci_bus().

Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 43aa630f419a..d392a55ec0a9 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1206,9 +1206,11 @@ static int create_root_hv_pci_bus(struct hv_pcibus_d=
evice *hbus)
 	hbus->pci_bus->msi =3D &hbus->msi_chip;
 	hbus->pci_bus->msi->dev =3D &hbus->hdev->device;
=20
+	pci_lock_rescan_remove();
 	pci_scan_child_bus(hbus->pci_bus);
 	pci_bus_assign_resources(hbus->pci_bus);
 	pci_bus_add_devices(hbus->pci_bus);
+	pci_unlock_rescan_remove();
 	hbus->state =3D hv_pcibus_installed;
 	return 0;
 }
@@ -1597,8 +1599,10 @@ static void hv_eject_device_work(struct work_struct =
*work)
 	pdev =3D pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domain, 0,
 					   wslot);
 	if (pdev) {
+		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(pdev);
 		pci_dev_put(pdev);
+		pci_unlock_rescan_remove();
 	}
=20
 	memset(&ctxt, 0, sizeof(ctxt));
--=20
2.14.1
