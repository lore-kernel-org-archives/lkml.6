Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237206-2-8703058758266632603
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237206; b=M8a4CvDzFib1dC9oSyj42KXRKjMWBkcvc0YSWDphTF8nppp3kJ
    JICUnPB0FN/gJiJwwjlKlhR2KRhf3VpRc+TN0raxgV7V0R2/nRKWehkBNbUZ2eCv
    6a7YCXPLCmZSDBsXfCMLwzCkbw+8UC3mrRNZXuRQfKOLW6xQs0WMremPEaoCxVGP
    0TMpx21ufY7xbtus64ESOTBIOGNVkHiVLs35FYGLqc6+/F0HsxykTYHvwEf4+3/E
    Y1h53saa9qTk6TLU/tBttt/ucoe/W4AKNB3OkO38SEb3/DC9LGUqDyNceWto7Ogq
    +mGicOf25vdxHB8d1OFP2lhpHjRwaX4iAsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237206; bh=GQwI+4mnWV
    6P8zaxCgMcS++iHD3OroJw47f6+9CGNcY=; b=sSKxX/FVDNL2GNH6VTT3IDWMfQ
    n+jQWi2luwqASdo8ikBp7/WC5VahTyfgBISf61Q/gDzSJuZmkPTXQFussVOSc8/m
    dJRJ8jNBQ8o3Kst2G5DGA1vVuUNeKY7ihyWKdbpxvFud9fO7CSLRDOfiauH2ALjU
    ZiHVY+tfDrjja1VV5MgjOnbzYTuqfgaUYOM1OG7UIdGpBgm8XSRG0zVz1HS0ABvt
    IM2PBQB+Uax1KVrAtImXJNDR22clSc7ax1eYWiiKfH4AlOwsRejaOYrsksrnWopX
    2GIeOjdBfdZs4a952OJu2HUqhuaR53XcL9mrzqdD7ZKW97NTXjXzZ0Yo2EEQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OMpZuLKS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OMpZuLKS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMdRmmgTZTZXSktdBhLSeNEgvhRLlxjoY5W5lQ3JF4GtfzgKmrjrJz8FAZpmXAtp/Il66xeLWO4pWDCTEF8xjgFVkhQ5Vx3FtgkQT/rs48Gv6YABqbgy
    UO6+xiy/kNVMak9ML8+/I/MwlqqUP3IdXSZi81hLIYQ9JxAWk3DFMcjPpxmvplhWlOtx3ST7gjhVZqF9+s61ZC+n6+xSIp1tOceOijSc+PmHJN91AraSTG+g
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=Oq4t8tgYQg1ipdnpRg4A:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932773AbeDIB0b (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:26:31 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:39469
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932589AbeDIAgr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 063/162] irqchip/gic-v3-its: Fix MSI alias
 accounting
Thread-Topic: [PATCH AUTOSEL for 4.4 063/162] irqchip/gic-v3-its: Fix MSI
 alias accounting
Thread-Index: AQHTz5mugcF/mbXATkiJnjCCK9KQ7g==
Date: Mon, 9 Apr 2018 00:28:28 +0000
Message-ID: <20180409002738.163941-63-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:ZAcprnGaedchDm8xa4NbY097KV0RwiuZy/Lj096jjNaqAJPdCNPGyOTAeQQy/EFx8medWRWsWWOYRgbmmOMX1Ouz9wrd8BNx9zfg12KQwk3JltPi6nOUHqSbjvpgfaHv7C7YyU2HZu/k9b/qvAY9ofoLc/w9UH9h28q0JEO/zALWUwvxkxPuhjnc+W2AnG4PRLykOBEfhYBhiW8oq+j5bbE5iWxxLW2Sofb0fzk5rZcJTTBvk2IXuyvBe0i6Q3pa;20:bPU6lXM5v0JfRjM0wIQFUTJm5wlChWSVGKfAa84Su7F0VVoV4KMPuZpi8bhhNJRG+YTvzpchW5BGDcYQihW1Ys1n7Q9Jk440XIl8KH0hVxY8g/9G+KWruSkkK/zIO6kGKsYnLY4ih+720wW+HWjxgQBYabAmSEmNDzmhBaKVU20=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: db4b4b3a-f1e3-4ae4-9135-08d59db1f941
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885980F91542F72CFE6D7D6FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(60795455431006)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(575784001)(3846002)(6116002)(59450400001)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(15650500001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: PM5ykVWmmbTpMhzG8XjbcD/VWKDgvwwEnHXR/xYIWuNznfXdYAGW1cWS1fyp33pYYkzENeVd7yw47qIE4qquT3EbcQoLrQr+AcUoWgXe6HNqdNkgwuH2zbTCh4kSumO8nR3fuKkXQJxgdo4y8sMMs/sUTK0ChDnY3cLh1VPA/ws9yS0DbBqKw4uDV0m8gJl+FxRHra3ViM+biFOWRKE9sUYh+GcaGmVCJCYXXvDAaRts+MrSCCdQDUmdg5HC2K6IWNndidvj35Eb3ICuMaPu0T2TP5wqPX19907fhbCVvovmxlpr5KfjjOVqK0gZLwVvIK00X4hZiaCevTrniRQ89K9UyrB//PcAKNg43rKFCzqvGH7ufedQcayxRIE+iI8ufgOnnqdeCMr71Q3gPU7EBWQVtMTuQt9xlFp1ie1i+E4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4b4b3a-f1e3-4ae4-9135-08d59db1f941
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:28.2082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 3403b0259d152c3ca67b32bb710f826bc17c0d16 ]

The call to pci_for_each_dma_alias() in the ITS PCI code has aroused
suspicion in the past, and upon closer inspection does turn out to be
completely backwards. Rather than iterating through each RID alias of
the given device, what we actually want to be doing here is iterating
through all the *other* devices which may also alias the same RID, in
order to size the table for the worst case.

Do the right thing by ignoring the initial DMA aliases themselves and
just using that walk to detect an aliasing bridge, then walking back
down the bus topology as necessary to actually count everything else.

Our alias handling still isn't perfect, since we don't account for the
cases of certain bridges only taking ownership of transactions under
particular circumstances, but without completely reworking the ITS code
to cope with the notion of multiple DevIDs per device, it'll have to do.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 35 ++++++++++++++++------------=
----
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq=
-gic-v3-its-pci-msi.c
index aee60ed025dc..147a29faa34f 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -40,27 +40,22 @@ static struct irq_chip its_msi_irq_chip =3D {
 	.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
 };
=20
-struct its_pci_alias {
-	struct pci_dev	*pdev;
-	u32		count;
-};
-
-static int its_pci_msi_vec_count(struct pci_dev *pdev)
+static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
 {
-	int msi, msix;
+	int msi, msix, *count =3D data;
=20
 	msi =3D max(pci_msi_vec_count(pdev), 0);
 	msix =3D max(pci_msix_vec_count(pdev), 0);
+	*count +=3D max(msi, msix);
=20
-	return max(msi, msix);
+	return 0;
 }
=20
 static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
-	struct its_pci_alias *dev_alias =3D data;
+	struct pci_dev **alias_dev =3D data;
=20
-	if (pdev !=3D dev_alias->pdev)
-		dev_alias->count +=3D its_pci_msi_vec_count(pdev);
+	*alias_dev =3D pdev;
=20
 	return 0;
 }
@@ -68,9 +63,9 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 al=
ias, void *data)
 static int its_pci_msi_prepare(struct irq_domain *domain, struct device *d=
ev,
 			       int nvec, msi_alloc_info_t *info)
 {
-	struct pci_dev *pdev;
-	struct its_pci_alias dev_alias;
+	struct pci_dev *pdev, *alias_dev;
 	struct msi_domain_info *msi_info;
+	int alias_count =3D 0;
=20
 	if (!dev_is_pci(dev))
 		return -EINVAL;
@@ -78,16 +73,20 @@ static int its_pci_msi_prepare(struct irq_domain *domai=
n, struct device *dev,
 	msi_info =3D msi_get_domain_info(domain->parent);
=20
 	pdev =3D to_pci_dev(dev);
-	dev_alias.pdev =3D pdev;
-	dev_alias.count =3D nvec;
-
-	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
+	/*
+	 * If pdev is downstream of any aliasing bridges, take an upper
+	 * bound of how many other vectors could map to the same DevID.
+	 */
+	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
+	if (alias_dev !=3D pdev && alias_dev->subordinate)
+		pci_walk_bus(alias_dev->subordinate, its_pci_msi_vec_count,
+			     &alias_count);
=20
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
 	info->scratchpad[0].ul =3D pci_msi_domain_get_msi_rid(domain, pdev);
=20
 	return msi_info->ops->msi_prepare(domain->parent,
-					  dev, dev_alias.count, info);
+					  dev, max(nvec, alias_count), info);
 }
=20
 static struct msi_domain_ops its_pci_msi_ops =3D {
--=20
2.15.1
