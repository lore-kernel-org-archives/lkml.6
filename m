Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeB0JLj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:11:39 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:42903 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbeB0JLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:11:36 -0500
X-Google-Smtp-Source: AH8x225UaP3jo6fRLF54TR7CfQGZnIRNT38TJFXmnGUvKolbn8uc/XkhwmdpqhAjolQaGmuQ03Zv6w==
Date: Tue, 27 Feb 2018 19:11:25 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 5/5] powerpc/mm/slice: use the dynamic high slice
 size to limit bitmap operations
Message-ID: <20180227191125.659d5cbe@roar.ozlabs.ibm.com>
In-Reply-To: <87bmga7qng.fsf@linux.vnet.ibm.com>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
        <5badd882663833576c10b8aafe235fe1e443f119.1518382747.git.christophe.leroy@c-s.fr>
        <87bmga7qng.fsf@linux.vnet.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 14:31:07 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
> > The number of high slices a process might use now depends on its
> > address space size, and what allocation address it has requested.
> >
> > This patch uses that limit throughout call chains where possible,
> > rather than use the fixed SLICE_NUM_HIGH for bitmap operations.
> > This saves some cost for processes that don't use very large address
> > spaces.  
> 
> I haven't really looked at the final code. One of the issue we had was
> with the below scenario.
> 
> mmap(addr, len) where addr < 128TB and addr+len > 128TB  We want to make
> sure we build the mask such that we don't find the addr available.

We should run it through the mmap regression tests. I *think* we moved
all of that logic from the slice code to get_ummapped_area before going
in to slices. I may have missed something though, it would be good to
have more eyes on it.

Thanks,
Nick
