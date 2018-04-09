Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240488-2-2546086538504633343
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
    1523240487; b=Gw5vlMYOEgiGBX2+65ZbPR/t2RpuZjI1+l0FmRk6ulxVNXxcPT
    PjR2A00g1k/nHVH3YTUEeKVnX1SO7Z7Cmn2ChD0M27zW3X6Xofgn59iAOK8QsF1C
    pZ/swcdUF0Hf8yJrG8mrIfOVxvoJ0dgMlo1EUd2D/ebnKmwSU1vzSJGv7rp5BE87
    JqSqEVavKQg9j1PlN91jE11eFK2oQ2sWrfmZ0aYFg52T2tUMl/7VvGCw7egssSI+
    XvG68yYrqhjVYKbWJ1RIXYmtce1ZHyMUHMlCUrNX769h1J70gxZ2FeXh/2NN+Iyv
    5u0B7RNC3GpnKnZHs1FjNkFSXFkwBupyzu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240487; bh=f2SatDRZko
    d08o0e4yzLWl2nubWwncggzG441I8QK/c=; b=f3Xcm/nba1IemrV/04B2CcXEm1
    GAJLjUZmO7ZEcvOIbKrGWdjYqIF/RVbgnQCBi2KS1nw2mgi45WfNfTHNZJCbgU76
    IjyC9eb11pOP8mK47/D9LX8ATpiQJ52K24cdSaa76wVTfmk3a4bF0ssEy+AgoGVo
    AEg+jWOdl0Z1S/bSJrjaDFqQ7ISNII/I3gnmyMmsYY5MftDU7mRtrGlHrwOlGciP
    /EDnwraoqBpM12Fre8Zz8Ujb9IDh0bLCahmoE2zxfdYldTwsVgc7vSMVIEdqMLw7
    BlmF1mwGZa7Hdc0V00nsI1s/+BzQ9B8Yn7e2n1ioJE7J+CT1v8HiatD8pLhw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XIobL+2p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XIobL+2p x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC80v/wkvlx4Z0GXcdv0zef7WWIPpnhEmKWs8oQHNaPoVd7NzcNbjoH8C2UuL+D8Qup2zsRgJQxXTna98izmrU4DnVJvpKesGGfznuGQhkoYeedGwKzj
    rdyDHM+FDnPCR/OG2WwuKtefqClXcfFxHqoTX04/FRf7rX/Yrck5Okosn7nDr/pXp7/ps8FfNMhLE6Om/wBRqiKkLUeeFss6kaegQDkvrmqNPxlc6aIUULrz
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=Oq4t8tgYQg1ipdnpRg4A:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755283AbeDICUg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:20:36 -0400
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:7529
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755997AbeDIA3p (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 118/293] irqchip/gic-v3-its: Fix MSI alias
 accounting
Thread-Topic: [PATCH AUTOSEL for 4.9 118/293] irqchip/gic-v3-its: Fix MSI
 alias accounting
Thread-Index: AQHTz5kdgdhSPSoT1U+lLdM5wBcGVA==
Date: Mon, 9 Apr 2018 00:24:25 +0000
Message-ID: <20180409002239.163177-118-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:ej6JfrXgx9zIQ3N5QAcZncWbMRMywoDFWpev27ay79sSl1sQRwpcMDg1cO68LH1piRPBzucO0KO9bNWgdw6lxwm15jJ6DxOFCi8LY/t6UlqVQDfKgsTl4faZ4LwfHLVkOJYvOCkadptqWJ1IkHM9tL8Hik01aopw5lKq73UAz8hFnEqIq/77pAHJZH/pRLrKbp7mKSpwl35/J/1VInatmS1gUtzhd5/MrJa5as1xv+WhlUS0pLp01UekfCPX6y2Y;20:Sg87Tnh1/nCE5SdKj48xTMcbm7P/3X6qBhiHHRNMcI8TlvMnk+1Cw2eROdVZ29htoQKI6FRK1xPNOBwnq12C70G+aov4M+aMMlDs8GezpiRrk8N/uAeeOB/WdE/71ztMhgI1GwqeXudpQ15xRxVbQ0yAm40lYTouZH8s9HvlTZg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a4cd51f-5603-4ca6-e6f4-08d59db0fc56
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032ECD75A949F405C3877E5FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(60795455431006)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(15650500001)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(575784001)(3280700002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Rml2KVWhVPe04o0ni3EXJIbKCG6ZU4bAb9FfR+LWgG35h5NcDCjNes4+zou6bjVEWKB10mOzxRHUk8VzCmRNv1hnboBHC4PO+mGNgWC0KBwLzjNlXjfNPBHYFm/4FBniEeKvmbfpvJvORg7HGRS6IXQsQk5YrOFh8ahUqGiA5S6qP/CVOp9NPHz8824pBzdIxytX4tagjTTsAUjfFd3hv4h6uaOhAlU8tMwnIg+SAEm9HzR4MnuSHu54AqSaKgvbaX40rJCQ0rJls+EP9NCEoSn4eF/Pum5vq/jyMeOJb6ocAtoC9H8tyR7aFuU53aUbJZ7No7aJ51drAJUQVUuUipgM+/PlIwuyvdvu96LHE68an0GQYdWdF9ncodcgzxCozDVv74q5ba59kkOx6rC7xmrF2GlCsS+RjcvHC92EJAU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4cd51f-5603-4ca6-e6f4-08d59db0fc56
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:25.2531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
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
index aee1c60d7ab5..77931214d954 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -41,27 +41,22 @@ static struct irq_chip its_msi_irq_chip =3D {
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
@@ -69,9 +64,9 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 al=
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
@@ -79,16 +74,20 @@ static int its_pci_msi_prepare(struct irq_domain *domai=
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
