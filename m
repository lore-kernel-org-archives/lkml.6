Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239852-2-17704752697570902885
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
    1523239852; b=lVWwAjTcgVDFpoRbg0Ff2IxkhNHhndP3BYSXx7QvKCadf91e1s
    V57NHshoMoTS25iYJPaGO0/wyZf57LnvNsu5y0s7Cz8dLrSL+hJRzp8Y6gTSGU9y
    wWEjJ85kSicvAXcQeB4nMbqwML+TzC4UgO2CEoPP/4G937w61ouc/eNs0KeVFoiN
    1OZ6d7YgwEUid8hYer9xS3yfHHwmIrgRR0AEHY8/blgqSwjuLwX+J3/+pZhS6BSK
    Z579sGUkIewQe4AuQlUZX67cL8sBQ+5gS/BdFFTahDlEPc48XeDcf8UqdGlO7kk2
    b+CXDdjUn1M456H/+6kk3bSvr5hnYt7xMffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239852; bh=VZ+rwi0QDD
    z/WfFYp/37rj62wNYV3fyp+pYLbXzZ3Qc=; b=jr4q9xygKcX0WSTR7YJNstF98w
    cbx2eLH1id1GkCB5eBRAiio9HRgLqK+cr3/KmAsjCYNU17r/dV9cq4m6EmeZj9mH
    Wy7yZquIUcZNxavoUpTaWZslnDX5syLkWY8HTGwcG3/IMRJrKsFCJ7B4Eopgzanl
    wQtaKbiaJ8Ysc71jrFxzR74sNyl7Oud02RX/87WriGuZBvASVUEF3MhdvrODe9Kj
    wOIk2PZ8eddqM/F/foDGxPA+g3pp6Xbjz7IvCNanrzKcAp5szm73IiO1FqBUTCyJ
    FEHh9jIEtLQE+FlQ8D/2mMjAo/ABcv2MtPiBMxEqRO+mVqlQYsC2Ftcoh6+A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FBeh/puw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FBeh/puw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFwmiiMWZGDRmfvLj6pn+lcZs9PraBp7BfyKNtxxZEhXYJRMQFFTEAZDOE0AnjeEsF455Lqww/By39/DUjANLP9K18W+L8wA+BkpckpooA0dD1YAI3Ao
    nmeqcnGga57q+XxpWS3Cp7h3SiH4x6mhVqKiQMY6qaiaWb3SwLXZp8cG5+2xTdjG7ScFmqgice7ZCxQxAt4qnw0Cx/1LuxspelIu8xBgp0eam19ngcLmtMmF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
    a=8b9GpE9nAAAA:8 a=yMhMjlubAAAA:8 a=YgAbPcieeLlcGDyTLZQA:9
    a=CDr9VsT_LFyPGb4L:21 a=kjwQfp6vLj7n601L:21 a=wPNLvfGTeEIA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757502AbeDICKb (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:10:31 -0400
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:16544
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756212AbeDIAbQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Vladimir Murzin <vladimir.murzin@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 162/293] dma: Take into account dma_pfn_offset
Thread-Topic: [PATCH AUTOSEL for 4.9 162/293] dma: Take into account
 dma_pfn_offset
Thread-Index: AQHTz5kxsxKS10aH9keVfokOyy1kRw==
Date: Mon, 9 Apr 2018 00:25:00 +0000
Message-ID: <20180409002239.163177-162-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:S2Ckg+raItUKFKUyXoycijiIH1PzmZl/VCZ/sq0BUHmFRmm5Zn6TXaGIC64lozP5oWUdCG8dWgWvInK/iboTPtEu8hNJyYtwMpMLGeA2QLL0T6rRqrN8GeQIBwUHrOmtHpVbxIrntOBNIkM6CuK/179zK9dwl606pyMbaqxpRg2F0mC6KSXN6Ndwvw8UuJnmOfI7OqSIT9lxCsLifisIWiihIu3h+Zj4HFPMb1LpEPAU2nO6XvD72Tw9C9R0uqKx;20:cHJU8nC49AZ0rBGHbZmOD64Og75Pqgf44D2Bc3VFucCLV4Ks7TR8Ee9Cxrfz3WhfaxjUmqK1AINWCxNzEybTIr7RaJrnJMK0ANeaIwZvaJkExDaN/QroS2ztdW6/gasll+bOCLsxW6hmRQHYgMRarpNyENDN3VKJU0IPjl9T+LY=
X-MS-Office365-Filtering-Correlation-Id: c6268656-e28c-4763-602f-08d59db132ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917545431DA7489157F6DE4FBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(5660300001)(15650500001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: X7cFl7mj+Luxmg9bHw9ND5s6TcDhi7bGq56CXworsPBHrfwi3QIia3p3chkNp1csf+rKIGSLNgPEN+XYw+2IGGcFQD+dD6TpQwH2eq4KzGRw7bpXgIz47g1/nOYUWXyHwcOOiGLoWPxpplbL/mVzs1JEOAOghRdIS2EQJfHOiOzB/vcHpANSx2SSsi5Do6vyAIW9VMtbgf5SDUbH5Wfzv2OCqxLaLtTz2pb7xbwrPR1KuRvGrgvI8B+7KoNrEiH3ROQgYbEAFV2Np0PKGg0WjTZsHlFdTEExqPHb8GkDzulVidVzHZAqBQkdyC0GUGC6dPUvKpDvHI5zKlhaTywywxGaqMlE5GOljHFhedtEIdsdCx9EJ7U4O8WyRcPHv7tBvzWPig49uWkuVeDU4GKS2om7jeohQVDYG44ZWBtEk1k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6268656-e28c-4763-602f-08d59db132ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:00.1907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vladimir Murzin <vladimir.murzin@arm.com>

[ Upstream commit 25f1e18870881f3366a5abec27b651983ce9032c ]

Even though dma-noop-ops assumes 1:1 memory mapping DMA memory range
can be different to RAM. For example, ARM STM32F4 MCU offers the
possibility to remap SDRAM from 0xc000_0000 to 0x0 to get CPU
performance boost, but DMA continue to see SDRAM at 0xc000_0000. This
difference in mapping is handled via device-tree "dma-range" property
which leads to dev->dma_pfn_offset is set nonzero. To handle such
cases take dma_pfn_offset into account.

Cc: Joerg Roedel <jroedel@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Reported-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Andras Szemzo <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 lib/dma-noop.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/dma-noop.c b/lib/dma-noop.c
index 3d766e78fbe2..9a7b5ed7ceac 100644
--- a/lib/dma-noop.c
+++ b/lib/dma-noop.c
@@ -7,6 +7,7 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
+#include <linux/pfn.h>
=20
 static void *dma_noop_alloc(struct device *dev, size_t size,
 			    dma_addr_t *dma_handle, gfp_t gfp,
@@ -16,7 +17,8 @@ static void *dma_noop_alloc(struct device *dev, size_t si=
ze,
=20
 	ret =3D (void *)__get_free_pages(gfp, get_order(size));
 	if (ret)
-		*dma_handle =3D virt_to_phys(ret);
+		*dma_handle =3D virt_to_phys(ret) - PFN_PHYS(dev->dma_pfn_offset);
+
 	return ret;
 }
=20
@@ -32,7 +34,7 @@ static dma_addr_t dma_noop_map_page(struct device *dev, s=
truct page *page,
 				      enum dma_data_direction dir,
 				      unsigned long attrs)
 {
-	return page_to_phys(page) + offset;
+	return page_to_phys(page) + offset - PFN_PHYS(dev->dma_pfn_offset);
 }
=20
 static int dma_noop_map_sg(struct device *dev, struct scatterlist *sgl, in=
t nents,
@@ -43,11 +45,12 @@ static int dma_noop_map_sg(struct device *dev, struct s=
catterlist *sgl, int nent
 	struct scatterlist *sg;
=20
 	for_each_sg(sgl, sg, nents, i) {
+		dma_addr_t offset =3D PFN_PHYS(dev->dma_pfn_offset);
 		void *va;
=20
 		BUG_ON(!sg_page(sg));
 		va =3D sg_virt(sg);
-		sg_dma_address(sg) =3D (dma_addr_t)virt_to_phys(va);
+		sg_dma_address(sg) =3D (dma_addr_t)virt_to_phys(va) - offset;
 		sg_dma_len(sg) =3D sg->length;
 	}
=20
--=20
2.15.1
