Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B93DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFBD222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550140645;
	bh=cls4lVs/PCE3HtsxUWHFuO38Y6+wP6nc/MExiEgf3kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BA9D4YeX6HHbAxMaoaV2CO4suMyk8V8RrRYyEnxV6+tt8u6LMuHG3arGvKccGoIAp
	 l/AkZ2ri8qf/05lHuzflKc5vxf5vXAEAGZJzzsQlga61RQobiZxmU57MrK7U+iGDwR
	 lpn9D/vAxYFL2iuo2HrUpKvNfgGLoUna7HV7flak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390650AbfBNKhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbfBNKhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:37:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04CC82229F;
        Thu, 14 Feb 2019 10:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550140642;
        bh=cls4lVs/PCE3HtsxUWHFuO38Y6+wP6nc/MExiEgf3kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4cJKy2GHtfdzdr8v9WqNQjW4bumOY4mXvfoEzZfQjAlnyHaYxVFPyFZfXfICdOXX
         qGRNAZbzYqogM13NSJ5DKuJN2X06+epdRu1MCXc5TrQVm1M9pdV2DdUgEHNgUomn3+
         Vi/DnF5Yk6j8Fw5DGowmnOq0oCK4bVaVAytR566c=
Date:   Thu, 14 Feb 2019 11:37:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Olof Johansson <olof@lixom.net>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4 00/15] Habana Labs kernel driver
Message-ID: <20190214103720.GA6518@kroah.com>
References: <20190211151751.12336-1-oded.gabbay@gmail.com>
 <20190214071114.GA21381@kroah.com>
 <CAFCwf12VaYSpCtqyYsTGp2TZDJiJ4bYc4egrRY6mdzaceO_5Cw@mail.gmail.com>
 <CAFCwf11hP89LwKnyjuwnP1KLe0GwL_T=Z+eQ1uUEiPTnJRASpA@mail.gmail.com>
 <20190214100727.GA10405@kroah.com>
 <CAFCwf13-qVm_2UV5294jwwud4+oCZB_2WQfNmbg2qAUBCj4d4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13-qVm_2UV5294jwwud4+oCZB_2WQfNmbg2qAUBCj4d4g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:15:19PM +0200, Oded Gabbay wrote:
> On Thu, Feb 14, 2019 at 12:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 14, 2019 at 11:58:41AM +0200, Oded Gabbay wrote:
> > > On Thu, Feb 14, 2019 at 9:13 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > >
> > > > On Thu, Feb 14, 2019 at 9:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Feb 11, 2019 at 05:17:36PM +0200, Oded Gabbay wrote:
> > > > > > Hello,
> > > > > > This is v4 of the Habana Labs kernel driver patch-set. It contains fixes
> > > > > > according to reviews done on v3, mainly for the command buffer, sysfs and MMU
> > > > > > patches. In addition, patch 2/15 was reduced in size from 4.3MB to 1.4MB.
> > > > > >
> > > > > > The patch-set is rebased on v5.0-rc6.
> > > > > >
> > > > > > Link to v3 cover letter: https://lkml.org/lkml/2019/2/4/1033
> > > > > >
> > > > > > Link to v2 cover letter: https://lkml.org/lkml/2019/1/30/1003
> > > > > >
> > > > > > Link to v1 cover letter: https://lwn.net/Articles/777342/
> > > > > >
> > > > > > I would appricate any feedback, question and/or review.
> > > > >
> > > > > There's been some 0-day bot feedback on some of these patches now that I
> > > > > put them in my -testing branch.  So I'm going to drop the patch series
> > > > > from there now and wait for a v5 of the series that hopefully will have
> > > > > those issues fixed :)
> > > > >
> > > Hi Greg,
> > > I looked at the 4 warnings I received from your emails, and they all
> > > appear in i386 architecture.
> > > I don't want to support 32-bit kernel and I don't intend to support it.
> > > Can we just specify in kconfig that we don't support it, and then you
> > > won't get these warnings ?
> >
> > No, if you use the correct kernel types and castings, you should be
> > fine.
> >
> > > I initially set in kconfig to support only x86_64, and you told me
> > > (and you were right) not to limit to that. But I do think I would like
> > > to disable the driver on i386.
> >
> > You might want to not support it on 32bit kernels, but even then, I
> > think all you need to do here is use the proper kernel types and you
> > will be ok.
> >
> > As an example:
> >    drivers/misc/habanalabs/goya/goya.c: In function 'goya_early_init':
> >    drivers/misc/habanalabs/goya/goya.c:404:4: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
> >        "Not " HL_NAME "? BAR %d size %llu, expecting %llu\n",
> >        ^~~~~~
> >
> > Use the correct printk type for a resource_size_t.
> >
> > You got that warning twice.
> >
> > Another one is:
> > >> drivers/misc/habanalabs/device.c:283:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >      volatile u32 *paddr = (volatile u32 *) addr;
> >
> > Now using a volatile makes me want to say "you are doing it wrong!", as
> > yes, you shouldn't be reading directly from a memory pointer, you need
> > to use the correct iomem accessors, right?
> >
> > So I think just fixing this stuff up should be simple, the
> > resource_size_t fix is needed no matter what size kernel you run on.
> >
> > thanks,
> >
> > greg k-h
> 
> ok, got it, will be fixed.
> 
> Regarding the volatile, this is not an I/O memory. This is host memory
> that is changed by the device. That's why I wrote in the comment
> there:
> /*
> * paddr is defined as volatile because it points to HOST memory,
> * which is being written to by the device. Therefore, we can't use
> * locks to synchronize it and it is not a memory-mapped register space

What do you mean by "HOST" memory?  The memory that the processor is
running on?

> */
> 
> Am I missing something here ? I don't think I should use the iomem
> accessors on host memory, right ? Assuming I'm right, is there another
> way to ensure the compiler won't optimize this without using the
> volatile keyword ?

What are you trying to prevent from being "optimized" here?

Are you sure you just don't need a correct memory barrier?  That's the
only way to ensure that if you write to a location from one thread/cpu,
it will show up to the other thread/cpu correctly.  volatile will not
ensure that for you at all (hint, the compiler just ignores it for the
most part.)

thanks,

greg k-h
