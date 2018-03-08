Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486599-2-1673168896863987446
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486598; b=tlZKF3sC8Xb1xAp/bUXZZElg3jphFrXk+uMVGWWlxeZjOKc
    LJGJWYa4T6GPT1yKyxlLlEp/FyL2GvVB8HsbZMsvgLxebjkXitje9lBttQ/mXI/t
    84DhmPO/jegnEaqaS2MQINOsCGmLlZACvNqhJucD7rAoEgHFlH+r9BqREgPkJoM4
    pGQUktgSVtccrYJrc62RE7sYB1qKZQ0PjUzebkGJ+FDSz/AVjv8SaNHQKsSC8S/Y
    Udl5RJTh+svs+7ncdMh/8zdhgOz1VIkOW4LpbjgmnrpSX6DUEe6boXgGS0TiQGkw
    oFn+hIvG2DTm5Tt++mRU1KpyibqDDY+xzBERlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486598; bh=UR5YYQ
    e9P9cX2A6jSS4K9UXj0XHs/ePJFDNSc2KBq8M=; b=aTbu8QHc+m18Mh1qu/ZFpR
    yoFqYZE9cZYFzzdoNyRBGbIVsULeTOSYGzA997O6Oz4PSTS2COI76c0dt0eoZin6
    H78jWSeMLhCS7Md4NFfrMbTJj1yiP1wdru1cr5sIoEGOChe7aq0PN7QSLAUfPFL0
    Q0yJfNBpycHT3lXD6vIdSIIj3wgpTkN+NR9yXd6UXefhx9BeB6cFQbdn/scUSj1K
    ltA97MCaxNgsFMZfjTdg7QJYtFaNthig0HcMU2gtxalYX9Vp2LJHQOdPi9ZtTVBu
    0hZ46sqOy9lNzSx8Bmy/dH7Al3smzGjUa8IZnTMpFjLXX9g9Y/f+Cw21AHS+HgEg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CQjTgNGa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CQjTgNGa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966453AbeCHFXQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:23:16 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:56636
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966647AbeCHFIB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jerry Snitselaar <jsnitsel@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 096/101] iommu/vt-d: clean up pr_irq if
 request_threaded_irq fails
Thread-Topic: [PATCH AUTOSEL for 4.4 096/101] iommu/vt-d: clean up pr_irq if
 request_threaded_irq fails
Thread-Index: AQHTtpqgBUUi4lFLVkCyEYWgDbaTfw==
Date: Thu, 8 Mar 2018 05:02:15 +0000
Message-ID: <20180308050023.8548-96-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:Ewb51PbUE2mZCUNJrAm5l1MPJ0zZihxdJmaJWxnNdw0SGVST+WSH/dB0y04aJ4SCjz9YqWrV+czXqOKDHqfd8NUFtC+dG3flCmhseMTkE3exa+sAqNAj+GYOU/LaGVgXudyHj6fI9Vg8RNuGVq4Ygs4b4qpmR9cG0dMiXUxD6dEfUVyUg7gJCuXHUHnty+q2pUNK0MWaonC2Qk5ysWk8x/S9VaJsP5ZfNhDRABppAulGc01clIjwbQ9nAhZAQ5nq;20:WwVHoJkGDl5q2XtWRB2VNHiixxxEPWYrsAIGztI0036U4SM0xrdLUGdvZnfQ7EUfipr0zTQmrMtsReDm0n7Ieko7fhVMZvAAcg1ifJibdGQdPSItC5Et83ck5koUMyhNw8R/XgTrk5K+nyMQt9kZE26qIJmEehAhHoI0vTEssTk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb03f90f-918c-4b7a-e269-08d584b28ce9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072750FDC2BDE4B33BDEA457FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: DbCAbi6pBmvd4V3K19twhAXGt4MbGuu1jSLERYDiDV9Tjbrrc5SgRlKsRO2Qp3gHCGZPKM0KeqjXz/nVIqVoDPGO5AIXZaAUB46KErHoeJPm2xpyExzgiuSBJduTnMNWpCdQqNuvgf1S6U6Oi9Vx/kGYC48/4O5FSwomWa7Iz79LCiQvBWKPRL6baNHkevdD4j6n3T8AYZv/lUuLq+iZVZC9SoWmaBp4Ay8AS+99NVCTNSyrX6LWixxVLBcgdJ484PI89PjIzNzf53EGEAzVwCDdcdrFiQeFY7gumuz+gY217/o2tB+EpnHj0wCAXpNXj7uGYVQ16pmj1G1hEa6DQA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb03f90f-918c-4b7a-e269-08d584b28ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:15.5493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jerry Snitselaar <jsnitsel@redhat.com>

[ Upstream commit 72d548113881dd32bf7f0b221d031e6586468437 ]

It is unlikely request_threaded_irq will fail, but if it does for some
reason we should clear iommu->pr_irq in the error path. Also
intel_svm_finish_prq shouldn't try to clean up the page request
interrupt if pr_irq is 0. Without these, if request_threaded_irq were
to fail the following occurs:

fail with no fixes:

[    0.683147] ------------[ cut here ]------------
[    0.683148] NULL pointer, cannot free irq
[    0.683158] WARNING: CPU: 1 PID: 1 at kernel/irq/irqdomain.c:1632 irq_do=
main_free_irqs+0x126/0x140
[    0.683160] Modules linked in:
[    0.683163] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2 #3
[    0.683165] Hardware name:                  /NUC7i3BNB, BIOS BNKBL357.86=
A.0036.2017.0105.1112 01/05/2017
[    0.683168] RIP: 0010:irq_domain_free_irqs+0x126/0x140
[    0.683169] RSP: 0000:ffffc90000037ce8 EFLAGS: 00010292
[    0.683171] RAX: 000000000000001d RBX: ffff880276283c00 RCX: ffffffff81c=
5e5e8
[    0.683172] RDX: 0000000000000001 RSI: 0000000000000096 RDI: 00000000000=
00246
[    0.683174] RBP: ffff880276283c00 R08: 0000000000000000 R09: 00000000000=
0023c
[    0.683175] R10: 0000000000000007 R11: 0000000000000000 R12: 00000000000=
0007a
[    0.683176] R13: 0000000000000001 R14: 0000000000000000 R15: 00000100100=
00000
[    0.683178] FS:  0000000000000000(0000) GS:ffff88027ec80000(0000) knlGS:=
0000000000000000
[    0.683180] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.683181] CR2: 0000000000000000 CR3: 0000000001c09001 CR4: 00000000003=
606e0
[    0.683182] Call Trace:
[    0.683189]  intel_svm_finish_prq+0x3c/0x60
[    0.683191]  free_dmar_iommu+0x1ac/0x1b0
[    0.683195]  init_dmars+0xaaa/0xaea
[    0.683200]  ? klist_next+0x19/0xc0
[    0.683203]  ? pci_do_find_bus+0x50/0x50
[    0.683205]  ? pci_get_dev_by_id+0x52/0x70
[    0.683208]  intel_iommu_init+0x498/0x5c7
[    0.683211]  pci_iommu_init+0x13/0x3c
[    0.683214]  ? e820__memblock_setup+0x61/0x61
[    0.683217]  do_one_initcall+0x4d/0x1a0
[    0.683220]  kernel_init_freeable+0x186/0x20e
[    0.683222]  ? set_debug_rodata+0x11/0x11
[    0.683225]  ? rest_init+0xb0/0xb0
[    0.683226]  kernel_init+0xa/0xff
[    0.683229]  ret_from_fork+0x1f/0x30
[    0.683259] Code: 89 ee 44 89 e7 e8 3b e8 ff ff 5b 5d 44 89 e7 44 89 ee =
41 5c 41 5d 41 5e e9 a8 84 ff ff 48 c7 c7 a8 71 a7 81 31 c0 e8 6a d3 f9 ff =
<0f> ff 5b 5d 41 5c 41 5d 41 5
e c3 0f 1f 44 00 00 66 2e 0f 1f 84
[    0.683285] ---[ end trace f7650e42792627ca ]---

with iommu->pr_irq =3D 0, but no check in intel_svm_finish_prq:

[    0.669561] ------------[ cut here ]------------
[    0.669563] Trying to free already-free IRQ 0
[    0.669573] WARNING: CPU: 3 PID: 1 at kernel/irq/manage.c:1546 __free_ir=
q+0xa4/0x2c0
[    0.669574] Modules linked in:
[    0.669577] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2 #4
[    0.669579] Hardware name:                  /NUC7i3BNB, BIOS BNKBL357.86=
A.0036.2017.0105.1112 01/05/2017
[    0.669581] RIP: 0010:__free_irq+0xa4/0x2c0
[    0.669582] RSP: 0000:ffffc90000037cc0 EFLAGS: 00010082
[    0.669584] RAX: 0000000000000021 RBX: 0000000000000000 RCX: ffffffff81c=
5e5e8
[    0.669585] RDX: 0000000000000001 RSI: 0000000000000086 RDI: 00000000000=
00046
[    0.669587] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
0023c
[    0.669588] R10: 0000000000000007 R11: 0000000000000000 R12: ffff8802762=
53960
[    0.669589] R13: ffff8802762538a4 R14: ffff880276253800 R15: ffff8802762=
83600
[    0.669593] FS:  0000000000000000(0000) GS:ffff88027ed80000(0000) knlGS:=
0000000000000000
[    0.669594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.669596] CR2: 0000000000000000 CR3: 0000000001c09001 CR4: 00000000003=
606e0
[    0.669602] Call Trace:
[    0.669616]  free_irq+0x30/0x60
[    0.669620]  intel_svm_finish_prq+0x34/0x60
[    0.669623]  free_dmar_iommu+0x1ac/0x1b0
[    0.669627]  init_dmars+0xaaa/0xaea
[    0.669631]  ? klist_next+0x19/0xc0
[    0.669634]  ? pci_do_find_bus+0x50/0x50
[    0.669637]  ? pci_get_dev_by_id+0x52/0x70
[    0.669639]  intel_iommu_init+0x498/0x5c7
[    0.669642]  pci_iommu_init+0x13/0x3c
[    0.669645]  ? e820__memblock_setup+0x61/0x61
[    0.669648]  do_one_initcall+0x4d/0x1a0
[    0.669651]  kernel_init_freeable+0x186/0x20e
[    0.669653]  ? set_debug_rodata+0x11/0x11
[    0.669656]  ? rest_init+0xb0/0xb0
[    0.669658]  kernel_init+0xa/0xff
[    0.669661]  ret_from_fork+0x1f/0x30
[    0.669662] Code: 7a 08 75 0e e9 c3 01 00 00 4c 39 7b 08 74 57 48 89 da =
48 8b 5a 18 48 85 db 75 ee 89 ee 48 c7 c7 78 67 a7 81 31 c0 e8 4c 37 fa ff =
<0f> ff 48 8b 34 24 4c 89 ef e
8 0e 4c 68 00 49 8b 46 40 48 8b 80
[    0.669688] ---[ end trace 58a470248700f2fc ]---

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/intel-svm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index f929879ecae6..a7d516f973dd 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -127,6 +127,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 		pr_err("IOMMU: %s: Failed to request IRQ for page request queue\n",
 		       iommu->name);
 		dmar_free_hwirq(irq);
+		iommu->pr_irq =3D 0;
 		goto err;
 	}
 	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
@@ -142,9 +143,11 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
 	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
 	dmar_writeq(iommu->reg + DMAR_PQA_REG, 0ULL);
=20
-	free_irq(iommu->pr_irq, iommu);
-	dmar_free_hwirq(iommu->pr_irq);
-	iommu->pr_irq =3D 0;
+	if (iommu->pr_irq) {
+		free_irq(iommu->pr_irq, iommu);
+		dmar_free_hwirq(iommu->pr_irq);
+		iommu->pr_irq =3D 0;
+	}
=20
 	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
 	iommu->prq =3D NULL;
--=20
2.14.1
