Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2531651-1526582786-2-1944222159468318728
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526582786; b=NSyeywu8fRXnLSsVWXNlFNNJOwxVKWbIDPOQRuYLQknHiPePPn
    XtlYCUarcgU/oE3uECLAiCmvgaKPdKg2LahjomPrAB9UOe0Z1BKHCNj0aUEtji0Q
    iUisVr9BI3vgChPCzq4NKSI/drm7kAImYgo38h7ILdYSJMaEDx4lO+pLaV3sf17Q
    s85moGT/QvtFvBXf75ifoWxotMOft7bcgCG2FkgHQCnkFWo/YDA0cAAbNfF4jaDm
    oVJuatsrKj8k3z5TQi5bvRdl2AcWpLXmix3eb63q4EN3oOhA1AeCB/2ONUdtTBGL
    lGTEJ3dlDOZevFxqrHTnYIoZQogIv3/8mggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:subject:to:cc:message-id:date
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526582786; bh=uRrXjKNlDGJt93HiKjpfWpkfR3RYtS
    dw2xcsDk7ZMjU=; b=f7EBBTVh4OD6UJYzpnJjprbqdAzttd1HIKfdCy1YKYM8VO
    ox0aGkczMRxrwy/FIuRB9CY0nzrd4y2aI3oDs+ABP856MBQTnvfYloJq7AGi380Z
    ONmQak/HE94al/9pZ8SFP2Tfge6jlrylE+PNzpRU4Bt7bsNorC4wpI+PYqHsM5mE
    +oNBDtZomBorryeDi42C66Vzmdm2f9pZXJNviQtAduYW33S+swAFfBNELd6UKK1D
    v4MsZZBKuPvsTgRbt8xLwwx8GrkPo921CXE+GXBXQ4dpCdB3QGDa2MdZhtJxXhDL
    PAbSjwZIBJfQTU4aR4t9z9lboMzpiRnGNKfgEDgg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
    header.i=@oracle.com header.b=Gs+KXMUF x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
      header.i=@oracle.com header.b=Gs+KXMUF x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCtWDvoA87fE42PnJ8hV/hZlZd1wFx/e278zKgnsDXUe50ouAbJhvbiYH/M2bcAdZz+lc/b2VGxGXhRNg2stlFOn52Lx/Z+/qIFXHj8JYoxUiGXKQCly
    yfgkUoKTig3ME4VpSa7hQBFtTLx1Kadx0iivEmR2bsVAQsCEarxxOUGTTncmwlH12H09IDO3q0w1bz7NeBZDTPENUyQsDaYka+WM4CyC9NLLyDCPrBgl0M1J
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=_1eiS0DOzhJj2cjQq14A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbeEQSqY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 14:46:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43364 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQSqX (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 May 2018 14:46:23 -0400
From: Joe Jin <joe.jin@oracle.com>
Subject: [PATCH UPSTREAM] xen-swiotlb: fix the check condition for
 xen_swiotlb_free_coherent
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        John Sobecki <john.sobecki@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Cc: ASHISH_B_SRIVASTAVA <ashish.b.srivastava@oracle.com>,
        stable@vger.kernel.org
Message-ID: <25d8a709-9f2f-fe09-f66c-2a0704ddbbb0@oracle.com>
Date: Thu, 17 May 2018 11:45:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8896 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805170176
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When run raidconfig from Dom0 we found that the Xen DMA heap is reduced,
but Dom Heap is increased by the same size. Tracing raidconfig we found
that the related ioctl() in megaraid_sas will call dma_alloc_coherent()
to apply memory. If the memory allocated by Dom0 is not in the DMA area,
it will exchange memory with Xen to meet the requiment. Later drivers
call dma_free_coherent() to free the memory, on xen_swiotlb_free_coherent()
the check condition (dev_addr + size - 1 <= dma_mask) is always false,
it prevents calling xen_destroy_contiguous_region() to return the memory
to the Xen DMA heap.

This issue introduced by commit 6810df88dcfc2 "xen-swiotlb: When doing
coherent alloc/dealloc check before swizzling the MFNs.".

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Tested-by: John Sobecki <john.sobecki@oracle.com> 
Reviewed-by: Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: stable@vger.kernel.org
---
 drivers/xen/swiotlb-xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index e1c60899fdbc..a6f9ba85dc4b 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -351,7 +351,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 	 * physical address */
 	phys = xen_bus_to_phys(dev_addr);
 
-	if (((dev_addr + size - 1 > dma_mask)) ||
+	if (((dev_addr + size - 1 <= dma_mask)) ||
 	    range_straddles_page_boundary(phys, size))
 		xen_destroy_contiguous_region(phys, order);
 
-- 
2.14.3 (Apple Git-98)
