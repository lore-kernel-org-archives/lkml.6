Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245630-2-4339734868376764625
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245630; b=dH9aBJsFFm6QB0Cn2C7NNVocKVzVlXRQP8qIPv6w3/y75Gaw/e
    9wAW0z+kNVjCmY6mnTOQtNq4mY+P5S0lMn0md5USdeBIwNNdgMcDjC2eyEAKLWn3
    F69/MMxigonebNTVI+YppNYdjGsQa6Bfmf553Ja0yMl9v4Se3Qj03W+InBdE0z17
    2S8kPt/KNGGQCZ3HVyvjB9cv5jQJk5zrN46ALoOhmw5f3pUje41Ma8zWhdgcb6h6
    jv5PKLmU/SlbXngtb8Q1SgWls8Ty4FMsvhC7DFEbXWyZwVNzAADK9Z2HlWkWwjgn
    QbAgn6sdo0gmhoj+9YjOWIyuX0sB6wu3PPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245630; bh=bQxqUyrafZ
    667zPHmIUyjHv8vBsvn0yJPZ+XiDU4JgY=; b=glbBmyQtfFRzPhFd4JvTH/lRF/
    lrqsWrZAec/1cXNfu4y7RgQaSBr4Q84+mbfHrUlZLLwHvJUUgxDko+JdgX1LvSgp
    Vdjn5hakT9sqOJN03WZ3JG+xsIuW2HKEX4Fp3vCH6axlln6Kdpol8CriKpyhiAKq
    S7Uj2BSrTB+W8xiLmQ1C01CCk855DkJHyBOwcpiOt8MaqEAPirAET5MwH7Sy/Zmd
    oSX/meMy1tBPAkl6fzM0Hwi4Dj6QZRokpUkmIwB9CwMmTM1FVHjFNRuiJ204w1cl
    pPDsvZie6leHWCnk2WNS4QF91NjhAuO418Vmd5T2kRoDRs9YIPSVJjRaiG9g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q00Xeunm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q00Xeunm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNQ4kjjdRm8JUHl8V/LKI2oOz2Gdpjq6cxdhafk+RFBgu8V/mq+HgScC3dwJRZ03c9EWvjEzACaUdUQV8sQNUqDEp1ivrisJaUTpJZ1H0DvF7OOIxyvL
    d3Xy57tymBqMm31eXZKhMkljP+bmV371YlszQ13p139BW/C6+wFfy7tg9oJNFAlWQ7bvwq9f75DUt81Xj6Oa1S9MinErpDO9oV0qKNp7KD2J6rVZe22eb9g2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=lGOlXp2JWegjt3AOumwA:9 a=E50zCCC-8hfv0dFM:21 a=aBxlsd6F4hzaoxQ_:21
    a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeDIDql (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:46:41 -0400
Received: from mail-cys01nam02on0118.outbound.protection.outlook.com ([104.47.37.118]:44776
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754167AbeDIAUM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Estrin <alex.estrin@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 130/189] IB/hfi1: Fix for early release of
 sdma context
Thread-Topic: [PATCH AUTOSEL for 4.15 130/189] IB/hfi1: Fix for early release
 of sdma context
Thread-Index: AQHTz5hJ7BrLzEXQQkufFzO0cVRArg==
Date: Mon, 9 Apr 2018 00:18:30 +0000
Message-ID: <20180409001637.162453-130-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:tvFaGhOR+AwCrK/turFdTTybR0HKo9jOx5XMN6HkeC9luU/4kuuLjP1jnzidMRp/bz/4Ic1nEW46O85wQQuu02BXtoxPGWJc+CuX9FliL3onZZP94K0UJuSvc8kq2VJnkFf+VCf7wdc0+oUJ3rOulfosdei1VsbEmqrCi01xHd+Di89lSsckqC1CZA54b3XHow4xi2OKvI5V556spQHShVUeHT+6P5t+mD4dr0lZywnNrh6prbfBu9EUwfkMREn2;20:YzejrITeVhTFZCgtCLrGgYBi6wKh6tTmr0AhquP6ci1eQqSNGfJhRRdDZSx4kHgjjSGjxa+a+18Pn8kh/xoyVOwFOPDxkAIX7Ah/kpyKWyhrPdSWSujnXd+DD2NVoedmoWNDE3NPPGIdVbTZcxr6ArpmS8ywdXfIxbXQHfSUyPE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62caf483-0292-4174-7e03-08d59dafa7e9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110CA1BAF25FA93272F1DF8FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: z6uILXWz2rF5K6DYFbaMPfEYAVIstlA1FU1DoD8RZoD27wlFlR5XyzJypee5juRV09MS7QxppOZbGke9oNN+72SNiUgbeECjINYq44htboYnu0EVbir3/iqsc9+86yTzqvR/KllPG8882M2ibOEVvyoC36ZaPCxf1hOU4kd2XddqA0o04F+gFksrZr5lPRf4VXyARd+ULH4Y9Chl8b1aEPnSM3JZlOzssJjmU2XFC6ACQmuKEODbGnQzYQXGinKyiFgYBcN7jWjVSRJr+k0AIlNd3zjiLd0idagJrO2kV+Bo66bZKeigNbmasDXxpqOKt4dcP0BJqcJO/HJJMjZJuaFL1J6biyIVKjamVVFCLpJ8X7wwgLH4eLggDwqL4Qi/1kMpsl0c1RpT0WRydrLQw6uBa5GIkkZ5MyP+hzUpdyc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62caf483-0292-4174-7e03-08d59dafa7e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:30.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alex Estrin <alex.estrin@intel.com>

[ Upstream commit 473291b3ea0e1df81f7abf13b8ab4b98a346df5e ]

With IRQF_SHARED flag set and CONFIG_DEBUG_SHIRQ enabled
module removal may result in panic in sdma_interrupt() routine
if associated sdma context was released before pci_free_irq();

[ 9198.939885] BUG: unable to handle kernel NULL pointer dereference at    =
       (null)
[ 9198.940514] IP: sdma_make_progress+0xa5/0x450 [hfi1]
[ 9198.941114] PGD 170bdc0067 P4D 170bdc0067 PUD 172063e067 PMD 0
[ 9198.941783] Oops: 0000 [#1] SMP
.....
[ 9198.958877] CPU: 132 PID: 64173 Comm: rmmod Tainted: G           OE   4.=
14.0-rc4+ #1
[ 9198.961032] Hardware name: Intel Corporation S7200AP/S7200AP, BIOS S72C6=
10.86B.01.02.0118.080620171935 08/06/2017
[ 9198.963323] task: ffff9681397f0000 task.stack: ffffae1647c40000
[ 9198.965695] RIP: 0010:sdma_make_progress+0xa5/0x450 [hfi1]
[ 9198.968082] RSP: 0018:ffffae1647c43be8 EFLAGS: 00010046
[ 9198.970503] RAX: 0000000000000000 RBX: ffff9680ce8b5ca8 RCX: 00000000000=
00000
[ 9198.973006] RDX: 0000000000000000 RSI: 0000000001a00d28 RDI: ffff9680ce8=
b5ca0
[ 9198.975546] RBP: ffffae1647c43c40 R08: ffff96814325ec00 R09: 00000000fff=
fffff
[ 9198.978142] R10: 000000004325e501 R11: ffff96814325ec00 R12: ffff9680ce8=
b5c44
[ 9198.980779] R13: ffff9680ce8b5ca0 R14: 0000000000000000 R15: ffff9680ce8=
b5b00
[ 9198.983462] FS:  00007f31196ba740(0000) GS:ffff96819df00000(0000) knlGS:=
0000000000000000
[ 9198.986231] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9198.989036] CR2: 0000000000000000 CR3: 000000170833f000 CR4: 00000000001=
406e0
[ 9198.991911] Call Trace:
[ 9198.994847]  sdma_engine_interrupt+0x82/0x100 [hfi1]
[ 9198.997852]  sdma_interrupt+0x61/0xc0 [hfi1]
[ 9199.000852]  __free_irq+0x1b3/0x2d0
[ 9199.003873]  free_irq+0x35/0x70
[ 9199.006909]  pci_free_irq+0x1c/0x30
[ 9199.009999]  clean_up_interrupts+0x53/0xf0 [hfi1]
[ 9199.013137]  hfi1_start_cleanup+0x117/0x190 [hfi1]
[ 9199.016315]  postinit_cleanup+0x1d/0x270 [hfi1]
[ 9199.019529]  remove_one+0x1f3/0x210 [hfi1]
[ 9199.022738]  pci_device_remove+0x39/0xc0
[ 9199.025974]  device_release_driver_internal+0x141/0x210
[ 9199.029268]  driver_detach+0x3f/0x80
[ 9199.032580]  bus_remove_driver+0x55/0xd0
[ 9199.035931]  driver_unregister+0x2c/0x50
[ 9199.039321]  pci_unregister_driver+0x2a/0xa0
[ 9199.042755]  hfi1_mod_cleanup+0x10/0xb50 [hfi1]
[ 9199.046196]  SyS_delete_module+0x171/0x250
...

Fix by exporting sdma_clean() and removing from sdma_exit().
sdma_exit() now just manipulates the engine state,
leaving the memory free to sdma_clean() which is now called
just before the dd is freed.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Michael J Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/hfi1/init.c |  1 +
 drivers/infiniband/hw/hfi1/sdma.c | 13 +++++++------
 drivers/infiniband/hw/hfi1/sdma.h |  1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1=
/init.c
index 117a74f22670..edf0a37100f7 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1219,6 +1219,7 @@ static void __hfi1_free_devdata(struct kobject *kobj)
 	free_percpu(dd->rcv_limit);
 	free_percpu(dd->send_schedule);
 	free_percpu(dd->tx_opstats);
+	sdma_clean(dd, dd->num_sdma);
 	rvt_dealloc_device(&dd->verbs_dev.rdi);
 }
=20
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1=
/sdma.c
index 31c8f89b5fc8..37424a81a7c9 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1276,13 +1276,15 @@ bail:
 	return -ENOMEM;
 }
=20
-/*
- * Clean up allocated memory.
- *
- * This routine is can be called regardless of the success of sdma_init()
+/**
+ * sdma_clean()  Clean up allocated memory
+ * @dd:          struct hfi1_devdata
+ * @num_engines: num sdma engines
  *
+ * This routine can be called regardless of the success of
+ * sdma_init()
  */
-static void sdma_clean(struct hfi1_devdata *dd, size_t num_engines)
+void sdma_clean(struct hfi1_devdata *dd, size_t num_engines)
 {
 	size_t i;
 	struct sdma_engine *sde;
@@ -1618,7 +1620,6 @@ void sdma_exit(struct hfi1_devdata *dd)
 		 */
 		sdma_finalput(&sde->state);
 	}
-	sdma_clean(dd, dd->num_sdma);
 }
=20
 /*
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1=
/sdma.h
index 374c59784950..46c775f255d1 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -420,6 +420,7 @@ struct sdma_engine {
 int sdma_init(struct hfi1_devdata *dd, u8 port);
 void sdma_start(struct hfi1_devdata *dd);
 void sdma_exit(struct hfi1_devdata *dd);
+void sdma_clean(struct hfi1_devdata *dd, size_t num_engines);
 void sdma_all_running(struct hfi1_devdata *dd);
 void sdma_all_idle(struct hfi1_devdata *dd);
 void sdma_freeze_notify(struct hfi1_devdata *dd, int go_idle);
--=20
2.15.1
