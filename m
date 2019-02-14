Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55093C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F64222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMWKkEGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438246AbfBNKPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:15:48 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34004 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfBNKPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:15:47 -0500
Received: by mail-vk1-f194.google.com with SMTP id y14so1267383vkd.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 02:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNcSyhDa48b59JPN1VQvijxe+4UIRP5B7UqXxeP2Yys=;
        b=aMWKkEGbNu5tb31bxN6FHciu9DP1xk8xnEW01DfnWGN1w2dLske61OkqNFx9CP51A5
         81KYqvQ8zgQlicML93pua4TtQP4L253t06QoseEWqfcdZnsKA/8en4iIBGVMLCjQ2Cyv
         qi5A4QJrTJWJowXI9U09dzflsVVC4Av9ihNtw9pBB59JCiBCh5WOAv7PjzRUFhUtdhaO
         DCCDowiWR53a0Pq8solR+sJlNKjmHWsnObgRujNzEef2XqOsEcyKmJyNciwejAHg0eCi
         pIVldd6HyhBv5ffIdP80urCjNtNf5jjLcb9yOy72j36+CTmsxmycmL0Xhi9Lq6r1mcf9
         85ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNcSyhDa48b59JPN1VQvijxe+4UIRP5B7UqXxeP2Yys=;
        b=ah5ElEuMOzvz3l0xdRETMI5wlaIHsbjrC7HeuLix1Y3IbotsZObPAROIwvUdNChC3q
         7Uk9GIyG1JpTvPPe4ssgRRWT2iOfp76ORYTFuUXtQaBm5xBSqM6QpbKHOP/WJGoaH+a0
         1fNtpwxVN6ndXTPKv+D5YfkLpevnZH2q+9qnKsVeeziSBSUmRKFFBeLQ3HwDhuOsu758
         1xkGLCLdeV6wOhBIv2X/nHLZ+0ObQeTdkMjktqYPN2eX2FpJMI6PeQN3K21DMZ/pn8fR
         6KH0/cpeLvQdRO+djycDHFsMVajZcqwxnM1E0vSWMfFZ/B/xhvUIH5E/Ct75GxoTIiF+
         CIZw==
X-Gm-Message-State: AHQUAuaSXz4SxpU1xo7KXA01FnjshlXfWQcCzb567vWaHUz9lIyfOgO9
        +vyk923qc259VGAiLi7qC8VUE6bgpa5L9xXbvXvH+fIB
X-Google-Smtp-Source: AHgI3IaIF+idRD+3JXKRg5raSyJRkkznFacUMrhp6oSWF6HHWAvZt9xeyj0gIfh4XF8QhS/F71LtLoWtTsKqMaV+9tY=
X-Received: by 2002:a1f:9042:: with SMTP id s63mr1462479vkd.17.1550139346077;
 Thu, 14 Feb 2019 02:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20190211151751.12336-1-oded.gabbay@gmail.com> <20190214071114.GA21381@kroah.com>
 <CAFCwf12VaYSpCtqyYsTGp2TZDJiJ4bYc4egrRY6mdzaceO_5Cw@mail.gmail.com>
 <CAFCwf11hP89LwKnyjuwnP1KLe0GwL_T=Z+eQ1uUEiPTnJRASpA@mail.gmail.com> <20190214100727.GA10405@kroah.com>
In-Reply-To: <20190214100727.GA10405@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 14 Feb 2019 12:15:19 +0200
Message-ID: <CAFCwf13-qVm_2UV5294jwwud4+oCZB_2WQfNmbg2qAUBCj4d4g@mail.gmail.com>
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

On Thu, Feb 14, 2019 at 12:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 14, 2019 at 11:58:41AM +0200, Oded Gabbay wrote:
> > On Thu, Feb 14, 2019 at 9:13 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > >
> > > On Thu, Feb 14, 2019 at 9:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Feb 11, 2019 at 05:17:36PM +0200, Oded Gabbay wrote:
> > > > > Hello,
> > > > > This is v4 of the Habana Labs kernel driver patch-set. It contains fixes
> > > > > according to reviews done on v3, mainly for the command buffer, sysfs and MMU
> > > > > patches. In addition, patch 2/15 was reduced in size from 4.3MB to 1.4MB.
> > > > >
> > > > > The patch-set is rebased on v5.0-rc6.
> > > > >
> > > > > Link to v3 cover letter: https://lkml.org/lkml/2019/2/4/1033
> > > > >
> > > > > Link to v2 cover letter: https://lkml.org/lkml/2019/1/30/1003
> > > > >
> > > > > Link to v1 cover letter: https://lwn.net/Articles/777342/
> > > > >
> > > > > I would appricate any feedback, question and/or review.
> > > >
> > > > There's been some 0-day bot feedback on some of these patches now that I
> > > > put them in my -testing branch.  So I'm going to drop the patch series
> > > > from there now and wait for a v5 of the series that hopefully will have
> > > > those issues fixed :)
> > > >
> > Hi Greg,
> > I looked at the 4 warnings I received from your emails, and they all
> > appear in i386 architecture.
> > I don't want to support 32-bit kernel and I don't intend to support it.
> > Can we just specify in kconfig that we don't support it, and then you
> > won't get these warnings ?
>
> No, if you use the correct kernel types and castings, you should be
> fine.
>
> > I initially set in kconfig to support only x86_64, and you told me
> > (and you were right) not to limit to that. But I do think I would like
> > to disable the driver on i386.
>
> You might want to not support it on 32bit kernels, but even then, I
> think all you need to do here is use the proper kernel types and you
> will be ok.
>
> As an example:
>    drivers/misc/habanalabs/goya/goya.c: In function 'goya_early_init':
>    drivers/misc/habanalabs/goya/goya.c:404:4: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
>        "Not " HL_NAME "? BAR %d size %llu, expecting %llu\n",
>        ^~~~~~
>
> Use the correct printk type for a resource_size_t.
>
> You got that warning twice.
>
> Another one is:
> >> drivers/misc/habanalabs/device.c:283:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>      volatile u32 *paddr = (volatile u32 *) addr;
>
> Now using a volatile makes me want to say "you are doing it wrong!", as
> yes, you shouldn't be reading directly from a memory pointer, you need
> to use the correct iomem accessors, right?
>
> So I think just fixing this stuff up should be simple, the
> resource_size_t fix is needed no matter what size kernel you run on.
>
> thanks,
>
> greg k-h

ok, got it, will be fixed.

Regarding the volatile, this is not an I/O memory. This is host memory
that is changed by the device. That's why I wrote in the comment
there:
/*
* paddr is defined as volatile because it points to HOST memory,
* which is being written to by the device. Therefore, we can't use
* locks to synchronize it and it is not a memory-mapped register space
*/

Am I missing something here ? I don't think I should use the iomem
accessors on host memory, right ? Assuming I'm right, is there another
way to ensure the compiler won't optimize this without using the
volatile keyword ?

Thanks,
Oded
