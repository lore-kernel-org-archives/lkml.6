Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389914-1522787552-2-12705573900062407008
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522787551; b=pYSKE0Hnmp/6fISHDKeqwJZ0/wO0XZg1Wsi6hNZ2IhQAWk8+m0
    Z7QYC6uQ+M4DDMxFTuAZ4gAb3ExjmJ2uPDOjNyU/Go3eKCGeojkfl0/PS7nmveXg
    Bqp0l8s7ToKGvp0Pj+xYtIkuDP1awPMFiRXzbLxn8j95jS09yswNMKB8R1fppGeU
    731ZU+y0M1ag8KszS1zzidjO5qGxLQQuMrgFrWK84l3Sq5nJclJjbJq/xgGS6wCE
    MY338fNDjZhzLPVknN6Fym3UEW80fMO4zWFZVKO9Nf8y6kY/uUivyCjIPu0rx3R3
    A/9T02bsRQEDggmvab/UetMOZITWT2iJA5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522787551;
    bh=7nVxoW2mWHQZHVqLXcFahK38g8UyIo/yMO0yU/5QXlE=; b=u/Qz93cs8YXz
    NeYjnLTfGQb3Ssx3Vbv+Fz7iNvbCWwlsUO94NlOye2vWtwyNIt981YwvTE2PDdlm
    iA2TiUbAp0VPzdhHOvlwWxIK/CEuF9hk3Omj9ahTVtVBcmO4spVfvD1cIlK2ofqH
    gPJ9RtpGWiS15juuX8VuWC3NlD50Z2j4+2mCmshGrmbs1liiD/lPfT/qgVAWHuHZ
    fT6qbSmzLuyjABr+qapNlrebiEVpJGb2jMUjbLnPGqsxbCURL0qgpe/bsuh71jRF
    zuMC4YLUZ55gZ5QvjZO7W6aB89cgfPO2XrRblsWdg+waDBOlBB5NEjWmJUg+4iNz
    elvKV9yd6Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFJOUI6iLNDMSHBjG+VIPCroVIetd/UvqtbO4/9ol4e1alieXTxHb8cnFtPMnmt5VWAWNC/cJdnWCY2/gG41luXDpG7452FlEgDs1BX8DPCSWrMeKEd+
    hfcgtJAsS9PgMfDAZFPNqljhwCWbzVvvMVPHiAuNzhFazv+1aCvaY91SrK+VJqJSQOB6WgQJepH2h6ZP/QL2yf3e8q6KZtL/hbINJaosSnDi30Ij8WPuoVbp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FqpbrowB-PMA:10 a=7d_E57ReAAAA:8
    a=z1H5ADGQAAAA:8 a=VwQbUJbxAAAA:8 a=edYEmElN1ERKE9bkRq4A:9
    a=O5yQwVLplLfhOP8h:21 a=HD7VF34pCW-a5tCm:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=cNhwqobjEIRUxE0uuXBi:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeDCUc3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 16:32:29 -0400
Received: from mail.efficios.com ([167.114.142.138]:45932 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeDCUc2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Apr 2018 16:32:28 -0400
Date: Tue, 3 Apr 2018 16:32:26 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <1649799886.2451.1522787546557.JavaMail.zimbra@efficios.com>
In-Reply-To: <17439540.2334.1522773387555.JavaMail.zimbra@efficios.com>
References: <20180327160542.28457-1-mathieu.desnoyers@efficios.com> <20180327160542.28457-3-mathieu.desnoyers@efficios.com> <20180401171356.085a2a33@alans-desktop> <1890356924.1736.1522683188833.JavaMail.zimbra@efficios.com> <17439540.2334.1522773387555.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH for 4.17 02/21] rseq: Introduce restartable
 sequences system call (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: rseq: Introduce restartable sequences system call (v12)
Thread-Index: ZlI8yYRhtR4Zm8XQBnk6z8Kg2ePiGrPMLD+wVMwzSuE=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 3, 2018, at 12:36 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 2, 2018, at 11:33 AM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
>> ----- On Apr 1, 2018, at 12:13 PM, One Thousand Gnomes
>> gnomes@lxorguk.ukuu.org.uk wrote:
>> 
[...]
>>> I still like the idea it's just the latencies concern me.
>> 
[...]
> 
> Looking into this a bit more, I notice the following: The pgprot_noncached
> (_PAGE_NOCACHE on x86) pgprot is part of the vma->vm_page_prot. Therefore,
> in order to have userspace provide pointers to noncached pages as input
> to cpu_opv, they need to be part of a userspace vma which has a
> pgprot_noncached vm_page_prot.
> 
> The cpu_opv system call uses get_user_pages_fast() to grab the struct page
> from the userspace addresses, and then passes those pages to vm_map_ram(),
> with a PAGE_KERNEL pgprot. This creates a temporary kernel mapping to those
> pages, which is then used to read/write from/to those pages with preemption
> disabled.
> 
> Therefore, with the proposed cpu_opv implementation, the kernel is not
> touching noncached mappings with preemption disabled, which should take
> care of your latency concern.

[...]

The following extra check should let userspace know it's trying to
provide a pointer to noncached memory by returning -1, errno=EFAULT.

Is the approach acceptable ?

Thanks,

Mathieu

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42..0245481 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2425,6 +2425,18 @@ static inline struct page *follow_page(struct vm_area_struct *vma,
        return follow_page_mask(vma, address, foll_flags, &unused_page_mask);
 }
 
+static inline bool is_vma_noncached(struct vm_area_struct *vma)
+{
+       pgprot_t pgprot = vma->vm_page_prot;
+
+       /* Check whether architecture implements noncached pages. */
+       if (pgprot_val(pgprot_noncached(PAGE_KERNEL)) == pgprot_val(PAGE_KERNEL))
+               return false;
+       if (pgprot_val(pgprot) != pgprot_val(pgprot_noncached(pgprot)))
+               return false;
+       return true;
+}
+
 #define FOLL_WRITE     0x01    /* check pte is writable */
 #define FOLL_TOUCH     0x02    /* mark page accessed */
 #define FOLL_GET       0x04    /* do get_page on page */
diff --git a/kernel/cpu_opv.c b/kernel/cpu_opv.c
index 197339e..e4395b4 100644
--- a/kernel/cpu_opv.c
+++ b/kernel/cpu_opv.c
@@ -362,7 +362,19 @@ static int cpu_op_pin_pages(unsigned long addr, unsigned long len,
        int ret, nr_pages, nr_put_pages, n;
        unsigned long _vaddr;
        struct vaddr *va;
+       struct vm_area_struct *vma;
 
+       vma = find_vma_intersection(current->mm, addr, addr + len);
+       if (!vma)
+               return -EFAULT;
+       /*
+        * cpu_opv() accesses its own cached mapping of the userspace pages.
+        * Considering that concurrent noncached and cached accesses may yield
+        * to unexpected results in terms of memory consistency, explicitly
+        * disallow cpu_opv on noncached memory.
+        */
+       if (is_vma_noncached(vma))
+               return -EFAULT;
        nr_pages = cpu_op_count_pages(addr, len);
        if (!nr_pages)
                return 0;

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
