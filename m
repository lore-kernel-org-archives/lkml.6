Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245674-2-2240578257280069727
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
    1523245673; b=YBpburemaY6V0tKHbvjHB2/0bHcobF5rCGua9ZzzCR4Z9My4jI
    lEzJI02tJTYAJZDlHkancyIr5qnNxaBAca06NFEm/R4eEfK+nMcRGM/hQRPn6lyb
    XQmU1XtfHee8okLs9Xhr5Krw7JB+OFLuUNp/X2sjskpmwMy//eQhXGpmWgMOQsVL
    I0yovk8m3MEfDzu15viN+mH6Vu0ozoMO3sJt8tX9PfPHIUtQE12v3cAlfE4Paz5e
    8DuAw6X0uZeHxyX11QpuHHPnXtgE5e8GfQFYAcS426aASWD2RL9BLA2AtcuH031t
    17DRyK1+r8VLsnCqZyRl8yzRkJlRzWL9LmbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245673; bh=7d87n/QSp3
    IGS4QiW7OIJTUdwcuGEEw5ASqfuOZrffE=; b=ndXCout/lIRmpRzOa2RO3g3ESE
    pdxP0HxSWgZqQIBlAJZuLc4aZA2t+uLvG+ax/0L7Qmg+3ZJTAY4WToldOl1OxsvJ
    SBVNj9n2IOh6lkS2VVY3n8aCT2LoUJIrgSaS9a15I6/zqJGjdUWYEYl6WfCPmCFo
    1DY/N3ZJ8QZ6/TbIvLqKLYsE2/jZDq8Sir2aqETZ8h6t9DVgSpBaryDD6lUkBF0L
    Vy3RUn4puMqHGOgkVMpsL1FNhvwVa3lr1/OX1mEdwI826DPVl8i5YgyeljEH5UXh
    C7Al792MeGYOTyeg1L8u2S6pQKB5EgmmVYlpoRxd/6UUxeiniOw0wDKDCO6A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lbWTMWDh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lbWTMWDh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI6SrEKW9yz6dn3kkM8CQLfBbANpbNNdeOcPT+7km8vmiTPG0vYGUs1Z/quXwJURGMs7G+UKzT70P1nm6e/TviRHKdnfyqwuzvJ4Wle9DvPqi/Yhm86b
    EDMbFAxgY6OqgGf+LIQQuRgfD647Iiq7jLKJEVqkUlzsKsWfaZXO0CHZL5S38Dr+nYzmTxEPIMMSFmJCrkMYdNnzEXCv2lPEIoBmc0bUKOz1uRuDQDSvEX/+
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=XLwk/flg9bK2IbKqzd+p90dOJos=:19
    a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10 a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8
    a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8 a=6cWEt7ZjD-Q0cvKT7ncA:9
    a=OjgT3Z0PG_mwR5Mi:21 a=J-sRNLkprEcFnktM:21 a=wPNLvfGTeEIA:10
    a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeDIDrW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:47:22 -0400
Received: from mail-bn3nam01hn0242.outbound.protection.outlook.com ([104.47.33.242]:40224
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754157AbeDIAUL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 129/189] IB/hfi1: Re-order IRQ cleanup to
 address driver cleanup race
Thread-Topic: [PATCH AUTOSEL for 4.15 129/189] IB/hfi1: Re-order IRQ cleanup
 to address driver cleanup race
Thread-Index: AQHTz5hJ0ZTrnbEoQUC6jQAHf17uSA==
Date: Mon, 9 Apr 2018 00:18:29 +0000
Message-ID: <20180409001637.162453-129-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:a/euYdNl+aOrp6nfn2J2lvazORu/QCxxi/MuApXOj1EDlSGqDTZ9SUoQWY+ZuSrYGdTK2bRRgsvyo97RX5kaeBkTYkaZVeXjBH3dpndhLUzUiqUW04VdwlrGvFcwZ7Lyj/rxQEhC4xquOfhsCXddt64Bc6r4elrlzEcc5Gz+Hyaj0qsOb/mLL81hTjyqtM0feeffOt3+h35tUS/0KjZhWX8pMZS1YJkCIdiMODxzz9xIgO5V4/4OYhA566YDkbPl;20:jtit3AElmhS1ojsJAsgCJKBQPADByPt7lUQ1rYuUcqHT4Pq5TG2UEwnp+lWl1pGPzWh5c13CfGLZDmhN8yviO1YmFWY6CbmPzx8Tb6dl7Hc4ORtyKKvqdAeA/kMOyA+2T7Fe66IqQydMjrkWvPPYhA0qf1mpETnV2WpNhX69IcM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 439b0d2b-6730-4c60-ea11-08d59dafa731
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11102FA2172CD6E79E95E8ABFBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(427584002)(169823001)(217873001);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qIA7P3HkxE+oC83QStJIVV1WOztk0mxnLR5GBBxAGvriyrZFfwTSNa0iY8f24g6vCCyy49q/R8lId68dlbNonz+H6UG1DPm1Itf+11J1Df8IdbVG4kChUFivWp2I78Dx0UiwVO18rTgRLAjV4Qb7X2EjCPlewJC4Bzau5t5RhdYYTv0oZtIrBdOPrOXJBouyNkRSXw0DhrCfr4RizkpZ74SNt26p1nnlprG5hMu9dGXSTliri2CsFmRnavgO+hhbJs7gWw2gCEfD+5td4qbQMT5z1Hi0H1Ib0dVC7w2U81LiWtKq0PivDPH8iBaVsfS7ejtkmMN1JVFO+jXpdKaz2MOcvM33yypD5VgtgCU+uWd5fc6JBGDgGj/HuRWDig41uvpPg8lkjmkojaofEhD0vo2kAmkqEmgG5dWEXfJaqHb5tmvbUTlscskTOhxa37xqWt7B7EFdEqJu9sflF7gf+cimg59HWiEGHv7yM+/gUn9NeRwTBwc54HsDofEZkcYP
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439b0d2b-6730-4c60-ea11-08d59dafa731
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:29.8320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
index 4f057e8ffe50..a7a5d19b1fe4 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -8263,8 +8263,8 @@ static irqreturn_t sdma_interrupt(int irq, void *data=
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
@@ -12984,7 +12984,14 @@ static void disable_intx(struct pci_dev *pdev)
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
@@ -13345,7 +13352,7 @@ static int set_up_interrupts(struct hfi1_devdata *d=
d)
 	return 0;
=20
 fail:
-	clean_up_interrupts(dd);
+	hfi1_clean_up_interrupts(dd);
 	return ret;
 }
=20
@@ -14772,7 +14779,6 @@ void hfi1_start_cleanup(struct hfi1_devdata *dd)
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
index 8ce9118d4a7f..3c3f71d7919d 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1957,6 +1957,7 @@ void hfi1_verbs_unregister_sysfs(struct hfi1_devdata =
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
index 8e3b3e7d829a..117a74f22670 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1058,8 +1058,9 @@ static void shutdown_device(struct hfi1_devdata *dd)
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
@@ -1702,6 +1703,7 @@ static int init_one(struct pci_dev *pdev, const struc=
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
