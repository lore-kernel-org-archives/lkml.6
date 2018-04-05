Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2765921-1522931286-2-579856578441588554
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522931286; b=EHjC9/F5v36+kvzTzkUil/F6i4IKlEQyVgp8GmJUYHbH03XZ9Y
    Mbj7PP9sqIEvCv9i+0saEQip0fl7/ssDpt67Ix004QS7ZvSdRtv6bqwMf4eGqm7p
    eGC5KiVttlPB6Sb3FdWJP4z4t9RA9PMjhh6a5qi3tVKOlRq+vtvJIJzzviEMu5eG
    lmphofFGTOksjKHi+hdACXw2dm8yiMp7z8vW7ZPJc+czYIfIyvbM9vfbx5ZK3nf6
    3IEDyRYmbZJzxbMKVF93HY4DWLFIJzMAbDnOX1BckifjuxVVC9wYKEArFfWOq8/a
    TIV6ob7/xunh9p+FRYRqHEn5KdRJsQ1qp4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522931286; bh=DBN3c/9BZAhJhCsf4fQ/DePZVpnxs3
    cKbrxeBBlSvt8=; b=sr4z3X7FQU/4yXDJ/4vohJ8/GuahwnPgYp+JtZwdlxyPtx
    IOXdtxU+n49bTWMhHzO7Qm1wYf4nVxGog0aLVG5kp4QiVVAlv+Kq9s7zAEPiMu7H
    WmuRtrU0wp16cH/q06Zo7bKExNfLgFwfbJwFu60eE1KIWbZQhhc7FmOhOZqqw4PK
    xu+UZg9cNy8t+gLxAsXSnZzJutbv7/0DDR6Ow08vv8okbDgtH9pI0yO0chKEoe8P
    NMbh3lp8TB5gF3CT6jcv/xj21Js/inOY0v6i/l0ZZfX2JpbnaotY+mDPPVej0PD3
    RBnPHXQBc3RzsMGXtydgaAAcjZT4tfq2caKff9Yw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBnaqDD4CdkxLUTAgupRe1gmQ7bFlQceqz+Ty9CFM9OCqrKnzR+fXBeid5ts3hnKmHW7wUJaATZy+2nOJvDxEijLUHEo3yBy4NxX90Sy2hXzr30sjfdS
    ikJ//yM7IM/FkZmoWDMTGCXsrnDsAZe943a397vmW+bSDtOTHFHozYEJsa94HoEJKXr47ldvP+HRvcBY7oxYHOIU0RcHjuDHc103EmpyxUSi2q29OnJHzzTr
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VnNF1IyMAAAA:8
    a=WLmoxOVsM5wSZHIjxkgA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeDEM2D (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 08:28:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751061AbeDEM2C (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 08:28:02 -0400
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, aarcange@redhat.com, minchan@kernel.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        hughd@google.com, borntraeger@de.ibm.com,
        gerald.schaefer@de.ibm.com, stable@vger.kernel.org
Subject: [PATCH v1 1/1] mm/ksm: fix inconsistent accounting of zero pages
Date: Thu,  5 Apr 2018 14:27:54 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18040512-0044-0000-0000-00000543CDA7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040512-0045-0000-0000-00002883E960
Message-Id: <1522931274-15552-1-git-send-email-imbrenda@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804050131
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When using KSM with use_zero_pages, we replace anonymous pages
containing only zeroes with actual zero pages, which are not anonymous.
We need to do proper accounting of the mm counters, otherwise we will
get wrong values in /proc and a BUG message in dmesg when tearing down
the mm.

Fixes: e86c59b1b1 ("mm/ksm: improve deduplication of zero pages with colouring")

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
 mm/ksm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 293721f..2d6b352 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1131,6 +1131,13 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	} else {
 		newpte = pte_mkspecial(pfn_pte(page_to_pfn(kpage),
 					       vma->vm_page_prot));
+		/*
+		 * We're replacing an anonymous page with a zero page, which is
+		 * not anonymous. We need to do proper accounting otherwise we
+		 * will get wrong values in /proc, and a BUG message in dmesg
+		 * when tearing down the mm.
+		 */
+		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
 	flush_cache_page(vma, addr, pte_pfn(*ptep));
-- 
2.7.4
