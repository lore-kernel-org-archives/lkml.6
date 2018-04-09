Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523243084-2-16328849017633734689
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243083; b=h4TbSGxI6xVuq1mIEq8IbbB8X8birpU98zwPKyQBUNjzNhQxva
    SQq+g+fLTmwVxGd97GeHAcGjFgWfrXPIKAD3tWnTZhrQOhUlctDBg4+rYH96m8RP
    xK4YIw+Alp7CwZIyZTckh/+fpk+6S/2SA2ToJcVhnip5OONu6RaRoLi1+E0aEs38
    jRA8RZaQw3KPC9WF1LtaMyycAKKGadCsIvYo6eWXBe4OAsWTUTW5u2/LMMqKJ9LK
    ghGk8/6FBWpUYfDCQJeYl1sD4MYpsUwz/JYzOW60HbfFK5JEZ/vO8U9HGJ1Z6Vjp
    uGqRY64Wx7hcEzFvjtrAx28ReFROawY+nfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243083; bh=3HS9cZV9+6
    b20eg84qn/pWGO2RyfdIkxvoXtzSq3Wpk=; b=P20BXuOtQ8Bdi9FgXZ1TFiiXLN
    7akFMIua+5QJMtb+VxkC580Xr/v91+LoTbC2chXwlihSMjCo4ZvbXsKQbXIIgqhW
    Guh9ir5R9ubK3ly4jzB3cWUOPFSrANZ4Gi49oKr/0TAasHutlxhIef5w87a5IBEb
    dmSylYdp3b6l3P8Tcg+OobGVlcmA7COZXDuDdRMivd1q1H5cLj9HFhK98G0aM/37
    CRo8AtLLgEJV6bFU54HQqm8Va0IgKurJ9U+v0wHEgAjEVsBd2voctw/f2/2qLnrU
    TZiv3Ze5R1c8b3h6q+JP5uwkXNQeE5HaIA9P/J+wsEpWhnw+l+Ir+sNiRxXg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EKlg308f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EKlg308f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJyP7mFMt31WXF7RyAcarHzCmRmb7QEOFZGFqPw+n5rGP4BdFdzYr08EolmQiPqJkK6gC5ViNe+9/sF5OSZd0hTn0ge8yebFFv4sUp5GpFzXn/JGl8V9
    2aKuBjcfuDQ/q51zM5FQ59LMLCc/jYe0xlqWyz4o38VPaL92Xf0Igadtb9Ea1KuNO18xUNg/ht3MBoeQ73scBANwn3YEkxJ4iouKqZltVDRIysaAj2fiOxvt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=XLwk/flg9bK2IbKqzd+p90dOJos=:19
    a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10 a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8
    a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8 a=6cWEt7ZjD-Q0cvKT7ncA:9
    a=OjgT3Z0PG_mwR5Mi:21 a=J-sRNLkprEcFnktM:21 a=wPNLvfGTeEIA:10
    a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDIDEk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:04:40 -0400
Received: from mail-sn1nam02hn0218.outbound.protection.outlook.com ([104.47.36.218]:59392
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932121AbeDIAYs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 108/161] IB/hfi1: Re-order IRQ cleanup to
 address driver cleanup race
Thread-Topic: [PATCH AUTOSEL for 4.14 108/161] IB/hfi1: Re-order IRQ cleanup
 to address driver cleanup race
Thread-Index: AQHTz5ivKmKr28nnDkyVfAw3IUoJeg==
Date: Mon, 9 Apr 2018 00:21:20 +0000
Message-ID: <20180409001936.162706-108-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:Zg3UPU+FOtm497/Pokd51g494mrpes8gjEHvk0xj+1YJm3Fpgrbyx6EV4MvoZ446u3YSf8+5D+aVSmHhaxS75XFomUwcjIM8TCGbegq9pBzWUP8c9bGOsvOberlqarQ7XRGnBOHhcOW1rFYOnh+YjyWVFoufYTSg9z0qfnMqeESqq/pJDi/sLLzvSAyRGsvr7VVeQ139ztIfiMElB+NG5ovuaP1Dy66cTvjgSiYVxlUQc/f6aOEttQ4Gfz/qgxil;20:B3wXH4+UX9BgTgLCZifLqGmVQbhTbIEUPQRItw58GOTGiJfzN4JkHNqxgIhq9WfLQ2xU3U/VaJ1U9Wq2D3DYCg6uKMmnU3KU+vB1aqXyusaYvlos9Lg+MUH1C52pVPXre/f5sJITjekvL8Gz36Zi/r8J6xQJIDse9dJzhkQPf0w=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c3fc128-1b3e-4ec9-8761-08d59db04cd4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09837A73832397590B1B1F44FBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(10090500001)(6486002)(107886003)(36756003)(4326008)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6512007)(26005)(14454004)(22906009)(169823001)(427584002)(217873001);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eVPuihhHUK0IXhkr4wDWtLvC2GinsL1cT2j0u2vUDFe1k1wFE270Rg6xgkc5SwYx43UeJTOlzaRXMjlVUJCQYrWzpx1BWvlizjvX/TR8/l2uz0+ilQ8Mk03oei/Ixq9bv8N9xGRGJ7+XejSVUmuHTF1GmJtHmEkxHpkdQi2ywxLk4V5+qWJa3g3BkAi9LVLvbqFwBoCnfSx4h0LykEZ30gHFGvjgiId+2v8teZ/2DW+6lnLO2j30LZd4X8rTE0s69/GsZBxWI8U5utsjTc1YHMVsu125oYjTyJLAwrTevdzwbiORLzYlfo4kmOyPD+KXsLLOhzKf6rqQazZcZm1XG/TnE0825picpMZ5kxnH2ANDlH83ezZXKD1hU/B6QyiBVtqBRDDVv4Dzyp72cFgTCeF1Fy0y2+80y6QAK0ihvCTIM9LgzxN9XWudk6DpvjWtanLq5iZcKHVOuMeFNfZcrukknI1oXtK9hUR9SxOhNPc/oXCzeeRkhKvInc6JwiLd
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3fc128-1b3e-4ec9-8761-08d59db04cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:20.6593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>

[ Upstream commit 82a979265638c505e12fbe7ba40980dc0901436d ]

The pci_request_irq() interfaces always adds the IRQF_SHARED bit to
all IRQ requests.

When the kernel is built with CONFIG_DEBUG_SHIRQ config flag, if the
IRQF_SHARED bit is set, a call to the IRQ handler is made from the
__free_irq() function. This is testing a race condition between the
IRQ cleanup and an IRQ racing the cleanup.  The HFI driver should be
able to handle this race, but does not.

This race can cause traces that start with this footprint:

BUG: unable to handle kernel NULL pointer dereference at   (null)
Call Trace:
 <hfi1 irq handler>
 ...
 __free_irq+0x1b3/0x2d0
 free_irq+0x35/0x70
 pci_free_irq+0x1c/0x30
 clean_up_interrupts+0x53/0xf0 [hfi1]
 hfi1_start_cleanup+0x122/0x190 [hfi1]
 postinit_cleanup+0x1d/0x280 [hfi1]
 remove_one+0x233/0x250 [hfi1]
 pci_device_remove+0x39/0xc0

Export IRQ cleanup function so it can be called from other modules.

Using the exported cleanup function:

  Re-order the driver cleanup code to clean up IRQ resources before
  other resources, eliminating the race.

  Re-order error path for init so that the race does not occur.

Reduce severity on spurious error message for SDMA IRQs to info.

Reviewed-by: Alex Estrin <alex.estrin@intel.com>
Reviewed-by: Patel Jay P <jay.p.patel@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/hfi1/chip.c | 18 ++++++++++++------
 drivers/infiniband/hw/hfi1/hfi.h  |  1 +
 drivers/infiniband/hw/hfi1/init.c |  4 +++-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1=
/chip.c
index 0e17d03ef1cb..82114ba86041 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -8294,8 +8294,8 @@ static irqreturn_t sdma_interrupt(int irq, void *data=
)
 		/* handle the interrupt(s) */
 		sdma_engine_interrupt(sde, status);
 	} else {
-		dd_dev_err_ratelimited(dd, "SDMA engine %u interrupt, but no status bits=
 set\n",
-				       sde->this_idx);
+		dd_dev_info_ratelimited(dd, "SDMA engine %u interrupt, but no status bit=
s set\n",
+					sde->this_idx);
 	}
 	return IRQ_HANDLED;
 }
@@ -12967,7 +12967,14 @@ static void disable_intx(struct pci_dev *pdev)
 	pci_intx(pdev, 0);
 }
=20
-static void clean_up_interrupts(struct hfi1_devdata *dd)
+/**
+ * hfi1_clean_up_interrupts() - Free all IRQ resources
+ * @dd: valid device data data structure
+ *
+ * Free the MSI or INTx IRQs and assoicated PCI resources,
+ * if they have been allocated.
+ */
+void hfi1_clean_up_interrupts(struct hfi1_devdata *dd)
 {
 	int i;
=20
@@ -13344,7 +13351,7 @@ static int set_up_interrupts(struct hfi1_devdata *d=
d)
 	return 0;
=20
 fail:
-	clean_up_interrupts(dd);
+	hfi1_clean_up_interrupts(dd);
 	return ret;
 }
=20
@@ -14770,7 +14777,6 @@ void hfi1_start_cleanup(struct hfi1_devdata *dd)
 	aspm_exit(dd);
 	free_cntrs(dd);
 	free_rcverr(dd);
-	clean_up_interrupts(dd);
 	finish_chip_resources(dd);
 }
=20
@@ -15229,7 +15235,7 @@ bail_free_rcverr:
 bail_free_cntrs:
 	free_cntrs(dd);
 bail_clear_intr:
-	clean_up_interrupts(dd);
+	hfi1_clean_up_interrupts(dd);
 bail_cleanup:
 	hfi1_pcie_ddcleanup(dd);
 bail_free:
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/=
hfi.h
index 3409eee16092..dc9c951ef946 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1954,6 +1954,7 @@ void hfi1_verbs_unregister_sysfs(struct hfi1_devdata =
*dd);
 int qsfp_dump(struct hfi1_pportdata *ppd, char *buf, int len);
=20
 int hfi1_pcie_init(struct pci_dev *pdev, const struct pci_device_id *ent);
+void hfi1_clean_up_interrupts(struct hfi1_devdata *dd);
 void hfi1_pcie_cleanup(struct pci_dev *pdev);
 int hfi1_pcie_ddinit(struct hfi1_devdata *dd, struct pci_dev *pdev);
 void hfi1_pcie_ddcleanup(struct hfi1_devdata *);
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1=
/init.c
index fba77001c3a7..d4fc8795cdf6 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1039,8 +1039,9 @@ static void shutdown_device(struct hfi1_devdata *dd)
 	}
 	dd->flags &=3D ~HFI1_INITTED;
=20
-	/* mask interrupts, but not errors */
+	/* mask and clean up interrupts, but not errors */
 	set_intr_state(dd, 0);
+	hfi1_clean_up_interrupts(dd);
=20
 	for (pidx =3D 0; pidx < dd->num_pports; ++pidx) {
 		ppd =3D dd->pport + pidx;
@@ -1696,6 +1697,7 @@ static int init_one(struct pci_dev *pdev, const struc=
t pci_device_id *ent)
 		dd_dev_err(dd, "Failed to create /dev devices: %d\n", -j);
=20
 	if (initfail || ret) {
+		hfi1_clean_up_interrupts(dd);
 		stop_timers(dd);
 		flush_workqueue(ib_wq);
 		for (pidx =3D 0; pidx < dd->num_pports; ++pidx) {
--=20
2.15.1
