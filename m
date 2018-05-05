Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-977734-1525482783-2-14356457069423786759
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525482782; b=bNxDatnHmxPOGJP932HbRz+2Gjq63Ckb7nQiStYbKQDHoWJVEq
    hLbYqsgX1pT+Xa+GtPMyX78QztsZNInmUin3mGsTf13t2b3sM4d+7KpewZam+sLj
    6nfXRZYO6G3/t+3veOzhHYN6wdE+EJaR3DI2GbB+9xrqFgIESm2MYBayih1Winpv
    LviKRSP/iaoSnrG6zHky/NCZVYXkupDo5kXLzF3Ma2Oq1EdrIkJx9nzvmIYQBvl1
    24zC/EpckuCGzhuWrJb4XSdgYGsBCnVCG1GRxdDbQipz6zBldOQIMe5v7Gb4wtXd
    0pFj0HqJsneiqw0RZH+rZbseKG7u8DCTtCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1525482782; bh=KGgq+6nib5Pt6Rdcq/j4dFx
    TkY/lA2jAEeJGR9gxbbE=; b=g9Oay33eUIN2ZYhto1km7T2yOksX1BzJELR/Sgn
    quFLA+MjMhPK/fQ2eSp+0+wgFURNWbZUREt8VnlRxbZ3tFxVmNGW7UMHMhEalL1A
    vCLA5bmjKkH7xsSw7MbUMm9J9mkyUqMtA8wwrj8CGBQ4YxxDPf1pGqLH3X+Hf8so
    KeUDU96EER25Wpw1KQ4pFHT1dyekR4lsGFZTDv6EukpJGHmseTa4od3VxPc8YIaE
    5GL+8/JsQ+aQ/et2rzXCwtO495qrMTgWf/Hy0vJEdHvZVRiqwDC8aUYDL5rADwgp
    NGsMm5pK2Ds9pY8WTq2Yle+YCRJOGhcAYvnOgaQgnit/c8w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=us.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=us.ibm.com header.result=pass header_org.domain=ibm.com
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=us.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=us.ibm.com header.result=pass header_org.domain=ibm.com
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL1bWLS4t2uRbedp3mRrf8Cxy3r9UuxgjAAeTBADITRPT35HRvs5ohNyXyZCBheJJ2VN/zG9HL6tgm0rTUJA53zlixGYdrMv8XZrSPnM9vAVc44YqYBe
    YTvZdLGM3IrKBstM9iUAO+b8VsRiIDniAhYlPbgBlOeX/J5HQlxj8M0z0Wwb9v1n4H+tVMr9syq1BkRx7QzDjUTP8zl8TET/U8yDHfZNE+HnW1rvWoqEmWxp
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=oYajKyDWE3nUfSxrg04A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeEEBM7 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 4 May 2018 21:12:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751751AbeEEBM7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 May 2018 21:12:59 -0400
Date: Fri, 4 May 2018 18:12:43 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
        arnd@arndb.de
Subject: Re: [PATCH v13 3/3] mm, powerpc, x86: introduce an additional vma
 bit for powerpc pkey
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
 <1525471183-21277-3-git-send-email-linuxram@us.ibm.com>
 <1e37895e-5a18-11c1-58f1-834f96dfd4d5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e37895e-5a18-11c1-58f1-834f96dfd4d5@intel.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18050501-0020-0000-0000-0000041929E7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050501-0021-0000-0000-000042AE531D
Message-Id: <20180505011243.GB5617@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805050009
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 03:57:33PM -0700, Dave Hansen wrote:
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 0c9e392..3ddddc7 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -679,6 +679,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >  		[ilog2(VM_PKEY_BIT1)]	= "",
> >  		[ilog2(VM_PKEY_BIT2)]	= "",
> >  		[ilog2(VM_PKEY_BIT3)]	= "",
> > +		[ilog2(VM_PKEY_BIT4)]	= "",
> >  #endif /* CONFIG_ARCH_HAS_PKEYS */
> ...
> > +#if defined(CONFIG_PPC)
> > +# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
> > +#else 
> > +# define VM_PKEY_BIT4	0
> > +#endif
> >  #endif /* CONFIG_ARCH_HAS_PKEYS */
> 
> That new line boils down to:
> 
> 		[ilog2(0)]	= "",
> 
> on x86.  It wasn't *obvious* to me that it is OK to do that.  The other
> possibly undefined bits (VM_SOFTDIRTY for instance) #ifdef themselves
> out of this array.
> 
> I would just be a wee bit worried that this would overwrite the 0 entry
> ("??") with "".

Yes it would :-( and could potentially break anything that depends on
0th entry being "??"

Is the following fix acceptable?

#if VM_PKEY_BIT4
                [ilog2(VM_PKEY_BIT4)]   = "",
#endif

-- 
Ram Pai
