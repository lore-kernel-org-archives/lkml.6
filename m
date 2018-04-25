Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653671-2-756705180118866415
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
    1524653670; b=WLB8vgLHCTdOWFnou5ycdoRZ3z+X3QZ4qPFrnD6zZuFErNZJn7
    SxcPriGbJUDrxfW5zt35OtJbHg1zzT2b6yre+aQ4pUmeSegTYaYDSTrGbzBuva1m
    0Ht3+y6EVlO7lNRnzPwjG71vGEaH8GxQZP6dyefgypYpR1C0eHKC5C12KCeyWwkH
    LQYoTaFJ/48Hi8pTdHyne/XOEPyeU1xurWokinvT6eba700gqFo/XWqVEzaB7J7q
    iJDNQVUB/1980NBjiriTX2jtegw/3/wN3enky3AhzEo/BiG2DQi42x1Q0W83sTHE
    jLTDnk2dXsqzlvS2z2CgUAVT4wMD+ZYAeBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653670; bh=tMWWiwaUlzzY25OYrZuC9jKUxAfOw3
    1U/3nVYR3W0Vc=; b=qvmjU9W3khK2qwI7Fwca7GTnMWU8mjJTcFKLZTX2Q56ZqZ
    o249IEkQu6DVXYNQyez3veLOVx1JohHY1mX5F5cbjlrfDBVmYGZsrH+SRaZANeMz
    eaEexcXH+OLlo6XQwxBihO7p2W2F3cUNTVVUjCI94SNvh7W9AfYvb57bspNr7Y8N
    4GkRdzKw4AQ9jxADyK7lXJWwrNpROcx6u2jP6bRD6eBeyoz7rLS3kP1i/JjhLHVR
    8+tfuH4C54CXburq9+DJkrr8DqUxK8Em0K3D/x2j0Lv/aFx0LgB9uQNPbIjjk5Q4
    cEWDNDCjwI3MEuZupdSAVmndj7EtL6EFMBAzhEFA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfFibLAg1BL7EkOqrP1aDZDPwHkIKD/uabDNVjTvcuL5ZegP5VSn4f8IRe1//WnMFU93GP7+JR4YC/XWA4uzdhipbRj5wiT9HAc8/VKk2bue3W4d8s/f0
    SJvp5tz5eqyK2qVzx3rjcRjY2VEe9f9QO/s2lmt83iJf2g1ULfchiMZaIJlmOw7KS3Z1OpgGivcwB0JxkQ2/s0AeWqtb++/zJL+5v0bUC6fMHD35kcYd446o
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
    a=7CQSdrXTAAAA:8 a=zAyngx5bAAAA:8 a=J1Y8HTJGAAAA:8 a=oGMlB6cnAAAA:8
    a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=WPyIoOwQAAAA:8 a=jIQo8A4GAAAA:8
    a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=hzj1nXxdle4KTAAxqCMA:9
    a=8_EjQHUU7Cj42UGb:21 a=uCfH2SEsDRPKLTTm:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=4LA4qAFo6bo561LpWNDU:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=S-HzPIwwDS8t1QcwSuWs:22
    a=Lf5xNeLK5dgiOs8hzIjU:22 a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754212AbeDYKna (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:43:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53014 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753730AbeDYKnZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Daney <david.daney@cavium.com>,
        David Miller <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Nitin Gupta <nitin.m.gupta@oracle.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 113/183] asm-generic: provide generic_pmdp_establish()
Date: Wed, 25 Apr 2018 12:35:33 +0200
Message-Id: <20180425103246.988906567@linuxfoundation.org>
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

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>


[ Upstream commit c58f0bb77ed8bf93dfdde762b01cb67eebbdfc29 ]

Patch series "Do not lose dirty bit on THP pages", v4.

Vlastimil noted that pmdp_invalidate() is not atomic and we can lose
dirty and access bits if CPU sets them after pmdp dereference, but
before set_pmd_at().

The bug can lead to data loss, but the race window is tiny and I haven't
seen any reports that suggested that it happens in reality.  So I don't
think it worth sending it to stable.

Unfortunately, there's no way to address the issue in a generic way.  We
need to fix all architectures that support THP one-by-one.

All architectures that have THP supported have to provide atomic
pmdp_invalidate() that returns previous value.

If generic implementation of pmdp_invalidate() is used, architecture
needs to provide atomic pmdp_estabish().

pmdp_estabish() is not used out-side generic implementation of
pmdp_invalidate() so far, but I think this can change in the future.

This patch (of 12):

This is an implementation of pmdp_establish() that is only suitable for
an architecture that doesn't have hardware dirty/accessed bits.  In this
case we can't race with CPU which sets these bits and non-atomic
approach is fine.

Link: http://lkml.kernel.org/r/20171213105756.69879-2-kirill.shutemov@linux.intel.com
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Daney <david.daney@cavium.com>
Cc: David Miller <davem@davemloft.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/asm-generic/pgtable.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -309,6 +309,21 @@ extern void pgtable_trans_huge_deposit(s
 extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 #endif
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/*
+ * This is an implementation of pmdp_establish() that is only suitable for an
+ * architecture that doesn't have hardware dirty/accessed bits. In this case we
+ * can't race with CPU which sets these bits and non-atomic aproach is fine.
+ */
+static inline pmd_t generic_pmdp_establish(struct vm_area_struct *vma,
+		unsigned long address, pmd_t *pmdp, pmd_t pmd)
+{
+	pmd_t old_pmd = *pmdp;
+	set_pmd_at(vma->vm_mm, address, pmdp, pmd);
+	return old_pmd;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PMDP_INVALIDATE
 extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 			    pmd_t *pmdp);
