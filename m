Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AH8x225PJ+3HQ5RIOgpWwy5Q6O5gNuH+xnQ9srjxQPCk9SDFFQVysEtp99TyrZqhYUn3x6vgdeKt
ARC-Seal: i=1; a=rsa-sha256; t=1517593879; cv=none;
        d=google.com; s=arc-20160816;
        b=lVugF3uJDSTD842LTEw4PvIpO+FL054KahpYV/O4q98FJgBFMmiMwhe/yOP5DzZT2G
         8IC+zOzA1n9nvD8fy9EU/4zAwsPF+/OCUhxdhjsBxRUD52jUugmG2ZJvOTgGewHiIcxb
         CI8NEMVn4NbjyI3f13Hm8u+E0tu4FpkI1PelwlinAihcOxLoNF1pdq0OhoXRvujO56cX
         aGJiwIoIJFin5tMYAaGQjRMo61CgcZSuzgCrMcXRXY7DboTi6yr2ow/cc1owlNmfiFF7
         3FfHAjIXJWwB+yLimyA9aiRrUrI272DtEitP4IOUleZur4LTmK9cVLq+PSsf1e5M5Vkb
         sAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=DTdMks5FOqPykh74QOeHsHnFlRqA27EdavLV0zSebgQ=;
        b=V+R8uwaWEpE9uYJWXbMMKosY2jD0WeiM5VxLtKYxDJp/n3UOXVtBAFqlQP5SXNSBcw
         TadbZZmBWU9MkToOa6VjllsoWu/RcOMDgoe6E5tII2DDb+Vupb5cv7DGhpY+ArL0TqgR
         KU4YFU48KBNVIhFkCBjyphdyxZ/KybdTid9MBWtVGjej6lP4piE8tIlBbgpj5B5RK0sa
         GHBA9goOHek/k4SxebG631QLlaO4RMj0iriKZljEi8lUtOR5o9ELvSesvmmpMc04EUBA
         qv3woqsItR7oElnH0htxG6zcd1WUGym85XRaWxfl4ghOjEOXy6s0JpzNuwqioWw5ljk8
         uNdw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=KvmH/WNd;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=KvmH/WNd;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 2 Feb 2018 12:51:00 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Asit Mallick <asit.k.mallick@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Ashok Raj <ashok.raj@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v6 3/5] KVM: VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
Message-ID: <20180202175100.GS28192@char.us.oracle.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-4-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517522386-18410-4-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020216
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582262223506?=
X-GMAIL-MSGID: =?utf-8?q?1591312519880626170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 10:59:44PM +0100, KarimAllah Ahmed wrote:
> Intel processors use MSR_IA32_ARCH_CAPABILITIES MSR to indicate RDCL_NO
> (bit 0) and IBRS_ALL (bit 1). This is a read-only MSR. By default the
> contents will come directly from the hardware, but user-space can still
> override it.
> 
> [dwmw2: The bit in kvm_cpuid_7_0_edx_x86_features can be unconditional]
> 
> Cc: Asit Mallick <asit.k.mallick@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jun Nakajima <jun.nakajima@intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
