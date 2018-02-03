Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681306-2-1879309270185606556
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681305; b=TucAOUUF6Ue4i37YgGmQc/E99r+xsjlOizCM0ezLo/S3VoE
    em6a6quS1OJjT3qWRKjMYcYV76BltGDQ8hzx1tUJDVvrBoqXyZY/q4XJPWpoGJcd
    LGakvTGBwOkjYN9C3iMYCikdA4SlQM20nxxjmyZiqs7q9XZ6+xO0Qyn5U5nmSYQC
    gWCc1AwczBHsWDzcTdqsGa6DV4WFyglDy4qoCHHsap2DP7EAbv9mo2UQ7Y4Y3WZG
    au5siCT17ywdIcgYdv/Y8d+NomOp1QBc+9vCS5rh++OQv+OjUKb7yEB2ngc6/eAt
    5rFvbAIGIX5wMjh+lYa4Yzag6xXADYOkJnk9p1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681305; bh=06i6wE
    M7VQ2RbmjrGFGlk2bDfQ9oPCKtRNoMp5vAnkM=; b=ZIHq43x6qwiH8SbwTDQa4Y
    IsX/RJDmYD+YvyBVr8rzZtJATlnLo0UHDaobhhjriLsOrU2HiOZTBdX4f25f1VVl
    eIdXB2+DjM+9H2+qdvVKwx2RsqfUdZRf13R0VOgPVDzjap8DRDCatTgO/3WbYdSm
    rxMg5ACOao+9AyF+Yy2zrdPZ5LxiMEA78KgKkQHqMW2FtoQq5fBKYFv+En6ySXw3
    d02cJnKDKCL4gdS+qgu6yYNhLFkWC3o7+lMFv4O4VHKE+YGC32LLuuoTiHGjq7zL
    1Shp8D6Sg/ryBOiatbG1BUjYsVsYRI9QeLVqXaxnzLNBn+GWMQyM3vwGAf4xu71w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xj4rL4Ed x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xj4rL4Ed x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753652AbeBCSIX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:08:23 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:53867
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753007AbeBCSFE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 095/110] powerpc/pseries: Make RAS IRQ
 explicitly dependent on DLPAR WQ
Thread-Topic: [PATCH AUTOSEL for 4.14 095/110] powerpc/pseries: Make RAS IRQ
 explicitly dependent on DLPAR WQ
Thread-Index: AQHTnRkDg9TMo6jud0GD4ZNmuZJ4qQ==
Date: Sat, 3 Feb 2018 18:01:28 +0000
Message-ID: <20180203180015.29073-95-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:K5p5fIG3MCqyGnPbT5czMqSvk7nom1rq5dK+7tG/00xIvpbpSXBb9mV+vMu9y4dnUZXejR5Z7pZYuH+MbT5eojLJZEXEEqhY3f3qlpA8LqB8ZJpkGJYDx1WavO8aMPaL1pOpqG3IsQjEPCSwV8TeGqV/LMc+KwDMb1aCq6FMA7j0Hc96ekOe53eRTQGjPjfXGN6S1ZSbL8k5T1p7LOdiEnM10kugUAODdVifESWpx37FphGZrr+oh4S4HzcZVEgz
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ea70a85-f7aa-45ed-fd04-08d56b3055f9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB104143C71134C416B55A9828FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: vqv0bHgGWPgWtUPauQgl+sKW8WtKo39TtJDFFU56N6AaWgMNnWkAArFXGQ9pnWtzOnoGS0al6biKZMe4gZvcUQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea70a85-f7aa-45ed-fd04-08d56b3055f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:28.6127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit e2d5915293ffdff977ddcfc12b817b08c53ffa7a ]

The hotplug code uses its own workqueue to handle IRQ requests
(pseries_hp_wq), however that workqueue is initialized after
init_ras_IRQ(). That can lead to a kernel panic if any hotplug
interrupts fire after init_ras_IRQ() but before pseries_hp_wq is
initialised. eg:

  UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes)
  NET: Registered protocol family 1
  Unpacking initramfs...
  (qemu) object_add memory-backend-ram,id=3Dmem1,size=3D10G
  (qemu) device_add pc-dimm,id=3Ddimm1,memdev=3Dmem1
  Unable to handle kernel paging request for data at address 0xf94d03007c42=
1378
  Faulting instruction address: 0xc00000000012d744
  Oops: Kernel access of bad area, sig: 11 [#1]
  LE SMP NR_CPUS=3D2048 NUMA pSeries
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2-ziviani+ #26
  task:         (ptrval) task.stack:         (ptrval)
  NIP:  c00000000012d744 LR: c00000000012d744 CTR: 0000000000000000
  REGS:         (ptrval) TRAP: 0380   Not tainted  (4.15.0-rc2-ziviani+)
  MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28088042  XER: 2004000=
0
  CFAR: c00000000012d3c4 SOFTE: 0
  ...
  NIP [c00000000012d744] __queue_work+0xd4/0x5c0
  LR [c00000000012d744] __queue_work+0xd4/0x5c0
  Call Trace:
  [c0000000fffefb90] [c00000000012d744] __queue_work+0xd4/0x5c0 (unreliable=
)
  [c0000000fffefc70] [c00000000012dce4] queue_work_on+0xb4/0xf0

This commit makes the RAS IRQ registration explicitly dependent on the
creation of the pseries_hp_wq.

Reported-by: Min Deng <mdeng@redhat.com>
Reported-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Tested-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/pseries/dlpar.c   | 21 ++++++++++++++++++---
 arch/powerpc/platforms/pseries/pseries.h |  2 ++
 arch/powerpc/platforms/pseries/ras.c     |  3 ++-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platform=
s/pseries/dlpar.c
index e45b5f10645a..e9149d05d30b 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -586,11 +586,26 @@ static ssize_t dlpar_show(struct class *class, struct=
 class_attribute *attr,
=20
 static CLASS_ATTR_RW(dlpar);
=20
-static int __init pseries_dlpar_init(void)
+int __init dlpar_workqueue_init(void)
 {
+	if (pseries_hp_wq)
+		return 0;
+
 	pseries_hp_wq =3D alloc_workqueue("pseries hotplug workqueue",
-					WQ_UNBOUND, 1);
+			WQ_UNBOUND, 1);
+
+	return pseries_hp_wq ? 0 : -ENOMEM;
+}
+
+static int __init dlpar_sysfs_init(void)
+{
+	int rc;
+
+	rc =3D dlpar_workqueue_init();
+	if (rc)
+		return rc;
+
 	return sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
 }
-machine_device_initcall(pseries, pseries_dlpar_init);
+machine_device_initcall(pseries, dlpar_sysfs_init);
=20
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platfo=
rms/pseries/pseries.h
index 4470a3194311..1ae1d9f4dbe9 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -98,4 +98,6 @@ static inline unsigned long cmo_get_page_size(void)
 	return CMO_PageSize;
 }
=20
+int dlpar_workqueue_init(void);
+
 #endif /* _PSERIES_PSERIES_H */
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/=
pseries/ras.c
index 4923ffe230cf..81d8614e7379 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -69,7 +69,8 @@ static int __init init_ras_IRQ(void)
 	/* Hotplug Events */
 	np =3D of_find_node_by_path("/event-sources/hot-plug-events");
 	if (np !=3D NULL) {
-		request_event_sources_irqs(np, ras_hotplug_interrupt,
+		if (dlpar_workqueue_init() =3D=3D 0)
+			request_event_sources_irqs(np, ras_hotplug_interrupt,
 					   "RAS_HOTPLUG");
 		of_node_put(np);
 	}
--=20
2.11.0
