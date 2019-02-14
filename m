Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D982070C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJvpP34e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437136AbfBNLkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:40:47 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35604 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388002AbfBNLkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:40:47 -0500
Received: by mail-ua1-f67.google.com with SMTP id d2so1914743ual.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 03:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zu4xXWWcRfokrYuKH0aL1uXf/Gr9KjLHPzbN4ZK2vpA=;
        b=WJvpP34ey1FTPM7Bqv6/HOldP57+9LiBAcbSAnlD9EVs9f0KepKAeicuPt7yYkX0bQ
         btcYhc8kj8N6bHMXk72c61/qc/jeQdPfsl1v3Mckqdnn5XJbi0Uq8EEniDLWUn7LK/ug
         6Lx7Wp7TpBqoNKModHau5KxRyq3m8f/USJgR6JebPuU38E6tGPxjThF+EKPYUXWwXyJE
         RehlvKpPtkoQJw9rHI+QR0Rn7/Q59YTAy8TobudqyBRUOn8lFCTfdE10ibLq8cHb4mIH
         X5WGfl6EwJju/+bXTWjeUSc//aQdmak1SG/ZWXIustYWlWUNx2+geh5GhA7RDjhUC/HW
         JI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zu4xXWWcRfokrYuKH0aL1uXf/Gr9KjLHPzbN4ZK2vpA=;
        b=pehHeXI/OdF6ChnzeE9/5XldOQy4EAFIuk0QefjKa43+E3ywzwZnUjOu568paWgyQw
         3ao2hhIaKs7w+WHD7evEtq2XsF4nt9vO5zESjz0JWLPQwN5VnwgwMcqrWJJ7DBO0T4JZ
         k4HDf0oZpvrvrrmElm6pXSOPUZKCLQhv5+5i9Z7rv2svSO/Oxytf6ikeBJ3spGhHokuw
         QVDNFv3xlS4pdMeZquiP+QgiyEGMQIrSnHvUQ81a2C/Y5xjgs9LRsQ/TLki8hJ2zLjmW
         nB977EDL4ZS40uCjM2eiV+N2nVbV1Z0RwpyeltX1N8RbmIkG//cFbcc2M6o0OKGb/314
         nXYg==
X-Gm-Message-State: AHQUAua/ZGu0DuHddcugsLErY+T46BHi094bGPhSuoSX8LTAj2KWWjqq
        NGp/wYkvfL+o/2wi5DqdCZ8QbMdW1gYWwRDa0yqsQKJd
X-Google-Smtp-Source: AHgI3IblOMbqM5LnW4Q025cll8vgUNBwDOn5Je+oYNgXOd6j8YemQHVfsd8KV2+qQdut5zgrhifsCldLO2jKU8T0JOQ=
X-Received: by 2002:ab0:22d6:: with SMTP id z22mr1630062uam.66.1550144445093;
 Thu, 14 Feb 2019 03:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20190211151751.12336-1-oded.gabbay@gmail.com> <20190214071114.GA21381@kroah.com>
 <CAFCwf12VaYSpCtqyYsTGp2TZDJiJ4bYc4egrRY6mdzaceO_5Cw@mail.gmail.com>
 <CAFCwf11hP89LwKnyjuwnP1KLe0GwL_T=Z+eQ1uUEiPTnJRASpA@mail.gmail.com>
 <20190214100727.GA10405@kroah.com> <CAFCwf13-qVm_2UV5294jwwud4+oCZB_2WQfNmbg2qAUBCj4d4g@mail.gmail.com>
 <20190214103720.GA6518@kroah.com> <CAFCwf13Lwr7M2Jao+3k+w_VaQ-9J7dpu7AOS4B+udnG__Fd53A@mail.gmail.com>
 <20190214110426.GA9566@kroah.com>
In-Reply-To: <20190214110426.GA9566@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 14 Feb 2019 13:40:18 +0200
Message-ID: <CAFCwf10qgc3_BxbnMm-A52=66+QJB7p+s2WZeXyMgD06t3h5LQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Habana Labs kernel driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Olof Johansson <olof@lixom.net>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 1:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 14, 2019 at 12:45:00PM +0200, Oded Gabbay wrote:
> > On Thu, Feb 14, 2019 at 12:37 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Feb 14, 2019 at 12:15:19PM +0200, Oded Gabbay wrote:
> > > > On Thu, Feb 14, 2019 at 12:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Feb 14, 2019 at 11:58:41AM +0200, Oded Gabbay wrote:
> > > > > > On Thu, Feb 14, 2019 at 9:13 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Feb 14, 2019 at 9:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Feb 11, 2019 at 05:17:36PM +0200, Oded Gabbay wrote:
> > > > > > > > > Hello,
> > > > > > > > > This is v4 of the Habana Labs kernel driver patch-set. It contains fixes
> > > > > > > > > according to reviews done on v3, mainly for the command buffer, sysfs and MMU
> > > > > > > > > patches. In addition, patch 2/15 was reduced in size from 4.3MB to 1.4MB.
> > > > > > > > >
> > > > > > > > > The patch-set is rebased on v5.0-rc6.
> > > > > > > > >
> > > > > > > > > Link to v3 cover letter: https://lkml.org/lkml/2019/2/4/1033
> > > > > > > > >
> > > > > > > > > Link to v2 cover letter: https://lkml.org/lkml/2019/1/30/1003
> > > > > > > > >
> > > > > > > > > Link to v1 cover letter: https://lwn.net/Articles/777342/
> > > > > > > > >
> > > > > > > > > I would appricate any feedback, question and/or review.
> > > > > > > >
> > > > > > > > There's been some 0-day bot feedback on some of these patches now that I
> > > > > > > > put them in my -testing branch.  So I'm going to drop the patch series
> > > > > > > > from there now and wait for a v5 of the series that hopefully will have
> > > > > > > > those issues fixed :)
> > > > > > > >
> > > > > > Hi Greg,
> > > > > > I looked at the 4 warnings I received from your emails, and they all
> > > > > > appear in i386 architecture.
> > > > > > I don't want to support 32-bit kernel and I don't intend to support it.
> > > > > > Can we just specify in kconfig that we don't support it, and then you
> > > > > > won't get these warnings ?
> > > > >
> > > > > No, if you use the correct kernel types and castings, you should be
> > > > > fine.
> > > > >
> > > > > > I initially set in kconfig to support only x86_64, and you told me
> > > > > > (and you were right) not to limit to that. But I do think I would like
> > > > > > to disable the driver on i386.
> > > > >
> > > > > You might want to not support it on 32bit kernels, but even then, I
> > > > > think all you need to do here is use the proper kernel types and you
> > > > > will be ok.
> > > > >
> > > > > As an example:
> > > > >    drivers/misc/habanalabs/goya/goya.c: In function 'goya_early_init':
> > > > >    drivers/misc/habanalabs/goya/goya.c:404:4: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> > > > >        "Not " HL_NAME "? BAR %d size %llu, expecting %llu\n",
> > > > >        ^~~~~~
> > > > >
> > > > > Use the correct printk type for a resource_size_t.
> > > > >
> > > > > You got that warning twice.
> > > > >
> > > > > Another one is:
> > > > > >> drivers/misc/habanalabs/device.c:283:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > > > >      volatile u32 *paddr = (volatile u32 *) addr;
> > > > >
> > > > > Now using a volatile makes me want to say "you are doing it wrong!", as
> > > > > yes, you shouldn't be reading directly from a memory pointer, you need
> > > > > to use the correct iomem accessors, right?
> > > > >
> > > > > So I think just fixing this stuff up should be simple, the
> > > > > resource_size_t fix is needed no matter what size kernel you run on.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > ok, got it, will be fixed.
> > > >
> > > > Regarding the volatile, this is not an I/O memory. This is host memory
> > > > that is changed by the device. That's why I wrote in the comment
> > > > there:
> > > > /*
> > > > * paddr is defined as volatile because it points to HOST memory,
> > > > * which is being written to by the device. Therefore, we can't use
> > > > * locks to synchronize it and it is not a memory-mapped register space
> > >
> > > What do you mean by "HOST" memory?  The memory that the processor is
> > > running on?
> > >
> > Yes, exactly. The memory of the server. Not a memory on my device.
> >
> > > > */
> > > >
> > > > Am I missing something here ? I don't think I should use the iomem
> > > > accessors on host memory, right ? Assuming I'm right, is there another
> > > > way to ensure the compiler won't optimize this without using the
> > > > volatile keyword ?
> > >
> > > What are you trying to prevent from being "optimized" here?
> > >
> > > Are you sure you just don't need a correct memory barrier?  That's the
> > > only way to ensure that if you write to a location from one thread/cpu,
> > > it will show up to the other thread/cpu correctly.  volatile will not
> > > ensure that for you at all (hint, the compiler just ignores it for the
> > > most part.)
> >
> > But the writing entity in this case is NOT another thread/cpu. The
> > writing entity is the device. So a memory barrier, IMO, won't help me
> > here, because memory barriers affect only on the CPU. Not on external
> > initiators.
> >
> > AFAIK, the volatile keyword tells the compiler that the value of the
> > variable may change at any time--without any action being taken by the
> > code the compiler finds nearby. And this is exactly what happens here.
> > I poll on a memory location of the CPU, and that memory can change at
> > any time by the device.
>
> And how is that memory location mapped into the device memory?  As such,
> it's iomemory, right?
>
> volatile doesn't tell the compiler much, if anything, anymore.
>
> I can't seem to trace back the code here (it's split across multiple
> emails), but it seems that the memory location is coming from struct
> armcp_packet in one location, and a dma pool in another one.  I don't
> know what the rules are for dma mapped memory, but it feels like
> 'volatile' is not the way to use it :)
>
Yes, this is dma coherent memory.

And I actually found one call to this function where we use this
function for polling on host memory that is changed by another
thread/core.
Therefore, I replaced the volatile with an mb() to flush the CPU read
and write buffers. I believe that is enough and I hope this closes
this issue :)

Oded


> thanks,
>
> greg k-h
