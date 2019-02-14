Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26155C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB16B222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3bEOFdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403815AbfBNKp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:45:29 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36562 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfBNKp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:45:28 -0500
Received: by mail-ua1-f66.google.com with SMTP id j3so1868145uap.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 02:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhvrftkbPMTL/Jhbnmi6M0b2GCGpehOvM+8uZNtGuQc=;
        b=E3bEOFdPdCgrdftVYJ2f00Q2DF+PFQED8gE1AAi5J1P1WpcggTmKL7hrABToCbOX2l
         fb1NV5n/5Cv+mMc068aENNzljCFxTgmabG0xR7iUyYV+VLjA1kHKVRq2I23xzrEaG7Zx
         isS4Red548JNUKoQ++yFQncohje7yTkiX+pQwCperQFolc2OsZhCGO4JSW/oIf1DuYLV
         GYxqfYHj20buG0TkA5KEbWCuGtUzzqLZQCqe7wlaZu43zGLlvsHubBtJBCJsLEq9mBrR
         nAVmMwx4ZLouQKurvJiiYJGlMR8N3kmcmQzBH0Kpw0ffeTo6FotcZa1rZK6fTmUDU+9a
         TIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhvrftkbPMTL/Jhbnmi6M0b2GCGpehOvM+8uZNtGuQc=;
        b=q5ZLi6sFOKdTdnE+Wr/109oEtUEFO8rQ5GOJoozXkNyiXzWYg22TV6hUXDWsvW/WJa
         NU+VwiEDZQUTXoXNMhl7l/g/gjXIfjFGWXjtZKsbJQSZJZHaGacGTiOHkaEWq9RVK78D
         Cvze5LK9By2IuGZQV1ozmAyPyMg1FzXW62QIekY5INZJTmSLXk/LpqfXlpa3T+PXdDls
         DD8kzSTR1Zh4c/aXtLUpa0RbL/JJO+NclH5GLyp7UqpOmzekfIjgtd2kNSZOtS3mOok6
         R2Aeg206Q6rJdIf3zfGUQwZeB7HBp13TpmxacdrTFYI+gXdchllo4Wrvh0st8mqVhfsB
         RUqw==
X-Gm-Message-State: AHQUAuYhyqDpRelW3F1fnU9c0GiaSNh6VrZpkkqhNA2z/DvFi+65AP0l
        RKkOOQmVFn4ynenuhA7FXxbfhS/z6hd9V18KVho=
X-Google-Smtp-Source: AHgI3Ibdnh3V23oRPVZdDeyk4Lrx8EeBHEalZ3BAqLi2FuYInSauIWsNXQsZ+hsQ6imxpA5H1bX/vTn2lrSBYOO8DJM=
X-Received: by 2002:ab0:22d6:: with SMTP id z22mr1528192uam.66.1550141127279;
 Thu, 14 Feb 2019 02:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20190211151751.12336-1-oded.gabbay@gmail.com> <20190214071114.GA21381@kroah.com>
 <CAFCwf12VaYSpCtqyYsTGp2TZDJiJ4bYc4egrRY6mdzaceO_5Cw@mail.gmail.com>
 <CAFCwf11hP89LwKnyjuwnP1KLe0GwL_T=Z+eQ1uUEiPTnJRASpA@mail.gmail.com>
 <20190214100727.GA10405@kroah.com> <CAFCwf13-qVm_2UV5294jwwud4+oCZB_2WQfNmbg2qAUBCj4d4g@mail.gmail.com>
 <20190214103720.GA6518@kroah.com>
In-Reply-To: <20190214103720.GA6518@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 14 Feb 2019 12:45:00 +0200
Message-ID: <CAFCwf13Lwr7M2Jao+3k+w_VaQ-9J7dpu7AOS4B+udnG__Fd53A@mail.gmail.com>
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

On Thu, Feb 14, 2019 at 12:37 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 14, 2019 at 12:15:19PM +0200, Oded Gabbay wrote:
> > On Thu, Feb 14, 2019 at 12:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Feb 14, 2019 at 11:58:41AM +0200, Oded Gabbay wrote:
> > > > On Thu, Feb 14, 2019 at 9:13 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > > >
> > > > > On Thu, Feb 14, 2019 at 9:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Mon, Feb 11, 2019 at 05:17:36PM +0200, Oded Gabbay wrote:
> > > > > > > Hello,
> > > > > > > This is v4 of the Habana Labs kernel driver patch-set. It contains fixes
> > > > > > > according to reviews done on v3, mainly for the command buffer, sysfs and MMU
> > > > > > > patches. In addition, patch 2/15 was reduced in size from 4.3MB to 1.4MB.
> > > > > > >
> > > > > > > The patch-set is rebased on v5.0-rc6.
> > > > > > >
> > > > > > > Link to v3 cover letter: https://lkml.org/lkml/2019/2/4/1033
> > > > > > >
> > > > > > > Link to v2 cover letter: https://lkml.org/lkml/2019/1/30/1003
> > > > > > >
> > > > > > > Link to v1 cover letter: https://lwn.net/Articles/777342/
> > > > > > >
> > > > > > > I would appricate any feedback, question and/or review.
> > > > > >
> > > > > > There's been some 0-day bot feedback on some of these patches now that I
> > > > > > put them in my -testing branch.  So I'm going to drop the patch series
> > > > > > from there now and wait for a v5 of the series that hopefully will have
> > > > > > those issues fixed :)
> > > > > >
> > > > Hi Greg,
> > > > I looked at the 4 warnings I received from your emails, and they all
> > > > appear in i386 architecture.
> > > > I don't want to support 32-bit kernel and I don't intend to support it.
> > > > Can we just specify in kconfig that we don't support it, and then you
> > > > won't get these warnings ?
> > >
> > > No, if you use the correct kernel types and castings, you should be
> > > fine.
> > >
> > > > I initially set in kconfig to support only x86_64, and you told me
> > > > (and you were right) not to limit to that. But I do think I would like
> > > > to disable the driver on i386.
> > >
> > > You might want to not support it on 32bit kernels, but even then, I
> > > think all you need to do here is use the proper kernel types and you
> > > will be ok.
> > >
> > > As an example:
> > >    drivers/misc/habanalabs/goya/goya.c: In function 'goya_early_init':
> > >    drivers/misc/habanalabs/goya/goya.c:404:4: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> > >        "Not " HL_NAME "? BAR %d size %llu, expecting %llu\n",
> > >        ^~~~~~
> > >
> > > Use the correct printk type for a resource_size_t.
> > >
> > > You got that warning twice.
> > >
> > > Another one is:
> > > >> drivers/misc/habanalabs/device.c:283:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > >      volatile u32 *paddr = (volatile u32 *) addr;
> > >
> > > Now using a volatile makes me want to say "you are doing it wrong!", as
> > > yes, you shouldn't be reading directly from a memory pointer, you need
> > > to use the correct iomem accessors, right?
> > >
> > > So I think just fixing this stuff up should be simple, the
> > > resource_size_t fix is needed no matter what size kernel you run on.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > ok, got it, will be fixed.
> >
> > Regarding the volatile, this is not an I/O memory. This is host memory
> > that is changed by the device. That's why I wrote in the comment
> > there:
> > /*
> > * paddr is defined as volatile because it points to HOST memory,
> > * which is being written to by the device. Therefore, we can't use
> > * locks to synchronize it and it is not a memory-mapped register space
>
> What do you mean by "HOST" memory?  The memory that the processor is
> running on?
>
Yes, exactly. The memory of the server. Not a memory on my device.

> > */
> >
> > Am I missing something here ? I don't think I should use the iomem
> > accessors on host memory, right ? Assuming I'm right, is there another
> > way to ensure the compiler won't optimize this without using the
> > volatile keyword ?
>
> What are you trying to prevent from being "optimized" here?
>
> Are you sure you just don't need a correct memory barrier?  That's the
> only way to ensure that if you write to a location from one thread/cpu,
> it will show up to the other thread/cpu correctly.  volatile will not
> ensure that for you at all (hint, the compiler just ignores it for the
> most part.)

But the writing entity in this case is NOT another thread/cpu. The
writing entity is the device. So a memory barrier, IMO, won't help me
here, because memory barriers affect only on the CPU. Not on external
initiators.

AFAIK, the volatile keyword tells the compiler that the value of the
variable may change at any time--without any action being taken by the
code the compiler finds nearby. And this is exactly what happens here.
I poll on a memory location of the CPU, and that memory can change at
any time by the device.

Thanks,
Oded


>
> thanks,
>
> greg k-h
