Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653054-2-7747591634259220774
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653054; b=Ma0QBCe869ubGMJuL0NYELEEGxdeOWYVOwjIzdnA4eG6b4fVrT
    Kumq5+lBTzRNjFf1ZKXEXRbeOxAmGPB4tnjjDdtlLhBw4aNEQcbucfPZmrIbFSjk
    vKgJ0N7BymPVqUdt/FGpCmmS8/WVQhbPJSrgX3K10XSOtcMt9/Tspms3TaElrvvm
    8TQ5Y29wDAjbTh3C7I8FoaeK7mNtICR+9cTNEueJhfIwQNukG/oK9cJKrv6dpP9z
    ueduxhUIFlGjjCkjnjXMNQAEvEsKJwu0fhX5fcohWktv0olgYr9ILy7LZ5pHIfQw
    qmVTqHDhAxFdZyPdT7N1kGmq51hIyQ2Qg3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653054; bh=9Vn0tKtc64cqJP/sJWIxcaGhuyOs1B
    Q/d/u/SBqwpC0=; b=WrwimBYg0zXYa/c1IEuF+oMJXynvtCaJK41787yJra7uVA
    +YbivcEhX+mD9R6WGY+onKN4WFAVSGzvSZLEzjlL1fNSxLjpsxvx6J5HYtpL0KMy
    LB9gGxbT9IVPqOwtjGuJl4+coDmxaHwej5CHwRU2oLaaxbMLAYkioAzCsPwPqYaJ
    KMM9HhsCqpRyWXvj540/U6Ijl4w1GDEOcyUKB+5SHUe1lzyf8NMxV99bGigNfalV
    D/Bvuhujb2O2QLVWVV3lHcusk4lpkiXRRaZNWyD7GRgzxmtHnDP/OZcysqAiPn1J
    vR1Fk/l5kc2eCsoNK3bcjWJn43o3a4bh/yzdcaBw==
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
X-CM-Envelope: MS4wfMbBpxHi1MyES8JlHeCQAO9PPT4g2hMOADCjXS3Cb1IsjA8/rFlTo/gxrWPusX7E9VztrdjkE0GiyIhWgzZWkfNM80Fk+nXRzTuDLn04u+bFQUj0GNeo
    5gkEL6C1utotA8oXA5aD+HtXX6YmX4PJ+wyPa28o2k0NzsxxEy0cLfzqk4SnLuYV61fIVP+d8AdbAYxJUZfqNQmfbFBOWnTfkmCAzHLIVmfEtrrU73jXh8ma
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=GPGmiASCH5f4YPUYGTYA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753947AbeDYKoL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:44:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53228 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754115AbeDYKoG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:44:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 164/183] powerpc/mm/hash64: Zero PGD pages on allocation
Date: Wed, 25 Apr 2018 12:36:24 +0200
Message-Id: <20180425103249.115159030@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>


[ Upstream commit fc5c2f4a55a2c258e12013cdf287cf266dbcd2a7 ]

On powerpc we allocate page table pages from slab caches of different
sizes. Currently we have a constructor that zeroes out the objects when
we allocate them for the first time.

We expect the objects to be zeroed out when we free the the object
back to slab cache. This happens in the unmap path. For hugetlb pages
we call huge_pte_get_and_clear() to do that.

With the current configuration of page table size, both PUD and PGD
level tables are allocated from the same slab cache. At the PUD level,
we use the second half of the table to store the slot information. But
we never clear that when unmapping.

When such a freed object is then allocated for a PGD page, the second
half of the page table page will not be zeroed as expected. This
results in a kernel crash.

Fix it by always clearing PGD pages when they're allocated.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
[mpe: Change log wording and formatting, add whitespace]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -73,10 +73,16 @@ static inline void radix__pgd_free(struc
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
+	pgd_t *pgd;
+
 	if (radix_enabled())
 		return radix__pgd_alloc(mm);
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
-		pgtable_gfp_flags(mm, GFP_KERNEL));
+
+	pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+			       pgtable_gfp_flags(mm, GFP_KERNEL));
+	memset(pgd, 0, PGD_TABLE_SIZE);
+
+	return pgd;
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
