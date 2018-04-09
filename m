Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbeDIUIl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:08:41 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34830 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754782AbeDIUIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:08:34 -0400
X-Google-Smtp-Source: AIpwx4/Uwschzs0zc5ElY5OXA1n0SdXgRPAuuz4sakKjG6pG8MNb8WrQdU5q2wt0Jvx3LUuvFlegdQ==
Date: Mon, 9 Apr 2018 13:08:31 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@infradead.org>
cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        mhocko@kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/3] mm: replace __HAVE_ARCH_PTE_SPECIAL
In-Reply-To: <20180409175757.GA12938@infradead.org>
Message-ID: <alpine.DEB.2.21.1804091307480.56406@chino.kir.corp.google.com>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com> <1523282229-20731-3-git-send-email-ldufour@linux.vnet.ibm.com> <20180409175757.GA12938@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2018, Christoph Hellwig wrote:

> > -#ifdef __HAVE_ARCH_PTE_SPECIAL
> > +#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
> >  # define HAVE_PTE_SPECIAL 1
> >  #else
> >  # define HAVE_PTE_SPECIAL 0
> 
> I'd say kill this odd indirection and just use the
> CONFIG_ARCH_HAS_PTE_SPECIAL symbol directly.
> 
> 

Agree, and I think it would be easier to audit/review if patches 1 and 3 
were folded together to see the relationship between the newly added 
selects and what #define's it is replacing.  Otherwise, looks good!
