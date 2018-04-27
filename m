Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-356304-1524840561-2-11679494348429541290
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840561; b=cho+DfspbYnkPBN9jFZwSDNpQhgTD8K8a6kOxbGD8tGkNPRFCH
    xnEEEq7sw/C8fyji9Ep0cM2UZXNmH0r7iGEFq0WS6EYYXcEHeMQmQK/Mh8bZ1hCR
    ENNQlCZ+ctnw88lyQWIeIGGDMp4Nb3gAU34x9CfO/xlg9PdrX9GWk0KOd6EqZs/U
    +U2YP5CiQcBEJJ9jGs1G6rGo3no/40EQQtPjnMj5+zWC/1Fn+FgsSmW4wY3H2aqd
    N8y7uqlmvNTvQZm0OrfOqxOnq6JyRkm+Pj7t8JYRDNxIGQifzRQqt6k62Cs8l1hs
    qz7GGDx2XLzRk4/QgpfbGgrH5bZXmmN9PyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840561; bh=ztAZr44WfGQi9Pfd+JUd4ERPlKqN6j
    vI2CV+kGlQRl0=; b=VXmtM5y7F5yydpylfxjt+R04cXPBOWpuiRh2hICBQy0de/
    zeI3IqQOHmgmPmSf+KCcv0gsov5ycPxKOThydLP27GznBCx8xkmPHpaRFkMANy+U
    EgHu2sE3VcY95YDZ3GA4BTXhrwUffDvIGKDhKHiDEd1L4e2RcRVRhkx6HJlpLGba
    FklSug+Jnvc5PNID/MLd5HFBUZf2l/RCU6BRuMQbU07+Cu2DpY0VWssYSH/YCI4R
    Ft1ELn7dD9lnXnZC8kv+5B0tet/AHv00fKuPZMxq0j9SlhCXF8FmFPnfIVDEY9FN
    IHOlKfcyblWybYx9d2D6IymYFU72udRbg10bym5g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJeIoZtgXfttFqkTbPHsXLkvM2vkVH/C0Jp3w0pWqdbFNGVPt90a5vIvGT3uHSV07U1XgQeAWx1t/xe5aOFDSdXfBq5vEAXnSUCxsG7KyZCqcYx677fg
    FDXiJskXk+hmr1t/Q/5XbS6VMbKBLaEchFy4a5EfqQchrP5AXMJLpYH2sNogIZfqDVa5Lg8qy8vucCiH3mM8ohjwZqi4wDTjO5+YdcvK08m08+64Kf+mWRGJ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=_TN53eZWIOXTJY2F9Q0A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934047AbeD0OtC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934306AbeD0OHj (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:07:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904C2218C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 46/80] s390: add optimized array_index_mask_nospec
Date: Fri, 27 Apr 2018 15:58:39 +0200
Message-Id: <20180427135735.290504187@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit e2dd833389cc4069a96b57bdd24227b5f52288f5 ]

Add an optimized version of the array_index_mask_nospec function for
s390 based on a compare and a subtract with borrow.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/barrier.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -49,6 +49,30 @@ do {									\
 #define __smp_mb__before_atomic()	barrier()
 #define __smp_mb__after_atomic()	barrier()
 
+/**
+ * array_index_mask_nospec - generate a mask for array_idx() that is
+ * ~0UL when the bounds check succeeds and 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ */
+#define array_index_mask_nospec array_index_mask_nospec
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+						    unsigned long size)
+{
+	unsigned long mask;
+
+	if (__builtin_constant_p(size) && size > 0) {
+		asm("	clgr	%2,%1\n"
+		    "	slbgr	%0,%0\n"
+		    :"=d" (mask) : "d" (size-1), "d" (index) :"cc");
+		return mask;
+	}
+	asm("	clgr	%1,%2\n"
+	    "	slbgr	%0,%0\n"
+	    :"=d" (mask) : "d" (size), "d" (index) :"cc");
+	return ~mask;
+}
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASM_BARRIER_H */
