Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965753AbeEXJCy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:02:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:55145 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965742AbeEXJCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:02:46 -0400
Date: Thu, 24 May 2018 11:02:41 +0200
From: Petr Tesarik <ptesarik@suse.cz>
To: Dave Young <dyoung@redhat.com>
Cc: dzickus@redhat.com, Neil Horman <nhorman@redhat.com>,
        Tony Luck <tony.luck@intel.com>, bhe@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config
 options
Message-ID: <20180524110241.3f60997c@ezekiel.suse.cz>
In-Reply-To: <20180524072627.GA1940@dhcp-128-65.nay.redhat.com>
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
        <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
        <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
        <877enucqr0.fsf@xmission.com>
        <20180523222236.5a96732e@ezekiel.suse.cz>
        <20180524014905.GB2031@dhcp-128-65.nay.redhat.com>
        <20180524085708.31aa311d@ezekiel.suse.cz>
        <20180524072627.GA1940@dhcp-128-65.nay.redhat.com>
Organization: SUSE Linux, s.r.o.
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018 15:26:27 +0800
Dave Young <dyoung@redhat.com> wrote:

> On 05/24/18 at 08:57am, Petr Tesarik wrote:
>[...]
> > What is "a very minimal initrd"? Last time I had to make a significant
> > adjustment to the estimation for openSUSE, this was caused by growing
> > user-space requirements (systemd in this case, but I don't want to
> > start flamewars on that topic, please).  
> 
> Still I think we have agreement and same feeling about the userspace
> memory requirement.   I think although it is hard, we have been still
> trying to shrink the initramfs memory use.
> 
> Besides of distribution use,  why people can not use some minimal
> initrd?  For example only a basic shell and some necessary tools and
> basic storage eg. raw disks supported, and he/she can just collect the
> panic infomation by himself in a shell.

Again, I'm having trouble with the definition of a "minimal initrd" and
also with the definition of a "workstation". I have already seen a sad
case where kdump started going OOM after connecting a 4K monitor,
because, well, it needed a bigger framebuffer...

OTOH you wrote in another mail that RH has tested some values on a
variety of hardware, so you seem to have a clue. Good for you. I still
believe it is moving policy into the kernel.

Based on past experience, I expect that certain users will argue that
"crashkernel=auto" should work out of the box on their HPE Superdome
with 600+ LUNs attached...

As you wrote elsewhere in the thread:

> I means this patch is not trying to force add a fixed value for crashkernel
> in kernel code. It provides another way one can use on kernel build time
> the value just works.

I don't mind if it is added, although I don't find it very useful.

Petr T
