Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CFAC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D31221855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWCTWjvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfAWWlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:41:07 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40162 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfAWWlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:41:07 -0500
Received: by mail-vk1-f193.google.com with SMTP id v70so884989vkv.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KsuGk7pop23OLegUqnXGd0s7OEbV9gn0keYWjV0jsh8=;
        b=NWCTWjvDp1P8R9uyyGbYp0K62zahxhYytsywejV5NDsEkvxL1Eq6KhA/b4zJJCfvra
         5HK4SNQyzn65LSDzYvamLYeweQcPMM5HmmMIXcI6IBVRngioa/x9Q4C16idBy/aavJBX
         HqKWSGcssaSlvMTl6dfWj+Bse0Nf4NbLzIc94bQcsB6pe5+Ol8VNAVKeZKncWmEODPbX
         1Gk/axv9BTFHtt8dadgoSqBu1xJmchu421Ai9B0gMpLnYdhRw3m+TDJVpJsuWSBW4axl
         TTaYM29gkTa1vklr3+kQ11mQNoWw7ZO15d7elx7PWWS1bBHflrok12XWfL/bGxfDsMQm
         WcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsuGk7pop23OLegUqnXGd0s7OEbV9gn0keYWjV0jsh8=;
        b=YA/5YiODUAYSWXb7FzE6itIXmZ5zokErDBif1elIOLbPcqTefUrdakGGslTNXRDwjF
         +dM/KbMYVU7U8YD+zzoysB2TqVm2wH5ieSE4ab1bt3ZAwiqcXSlJpIIc8XV8fQ37oU3E
         AwNRh1nOVxcpAIoHmmF7UKJrhdYIEBUDR5q7KHtu3eEqrOTGystdSBiliiqSnS02DkKy
         2uIbcHYk2WoNgQP3qVezlSIxm5LeF7Z2Nxy3kQx0cwhsqaJDzLPEAE+CMBSVDZ/qYOJL
         nMdDnbHS7DRybNtFK44uyjGVX/+qn4/1HreDxy1ZJXj9KAJ0D56S61O8TsuJJOoXg2mG
         3Yxw==
X-Gm-Message-State: AJcUukfK0NrmS4fDnKivNTAerU/bGee/roZWCOLL+Wv2ZDIwBUaaL86I
        p+AYvw1ZRO99NtxEfUqbQBBbUGAjmRXt7TOCw4I=
X-Google-Smtp-Source: ALg8bN5RgxGh8/qnxL/2sopdpFv5qi/GWSd6q6Pqao9WruPXKCAiAJw79860gWt7KVGW8N69aiq8K9lPpSZs6s2ako0=
X-Received: by 2002:a1f:e807:: with SMTP id f7mr1645114vkh.16.1548283265284;
 Wed, 23 Jan 2019 14:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAOesGMjU0tjJwAqCADaAv6XrCGbjB8G2oT=4LxOgSQBHO7Gptw@mail.gmail.com>
In-Reply-To: <CAOesGMjU0tjJwAqCADaAv6XrCGbjB8G2oT=4LxOgSQBHO7Gptw@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 24 Jan 2019 00:40:40 +0200
Message-ID: <CAFCwf11sxVAi1fxeZ698rBoJbaV3WHRJAyqB3RyddDLzfOysxA@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Olof Johansson <olof@lixom.net>
Cc:     Dave Airlie <airlied@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai, Arnd Bergmann <arnd@arndb.de>,
        fbarrat@linux.ibm.com, andrew.donnellan@au1.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:52 PM Olof Johansson <olof@lixom.net> wrote:
>
> Hi,
>
> On Tue, Jan 22, 2019 at 4:01 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > Hello,
> >
> > For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> > for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> > Habana Labs since its inception two and a half years ago.
> >
> > Habana is a leading startup in the emerging AI processor space and we have
> > already started production of our first Goya inference processor PCIe card
> > and delivered it to customers. The Goya processor silicon has been tested
> > since June of 2018 and is production-qualified by now. The Gaudi training
> > processor solution is slated to sample in the second quarter of 2019.
> >
> > This patch-set contains the kernel driver for Habana's AI Processors
> > (AIP) that are designed to accelerate Deep Learning inference and training
> > workloads. The current version supports only the Goya processor and
> > support for Gaudi will be upstreamed after the ASIC will be available to
> > customers.
> [...]
>
> As others have mentioned, thanks for the amount of background and
> information in this patch set, it's great to see.
>
> Some have pointed out style and formatting issues, I'm not going to do
> that here but I do have some higher-level comments:
>
>  - There's a whole bunch of register definition headers. Outside of
> GPUs, traditionally we don't include the full sets unless they're
> needed in the driver since they tend to be very verbose.

And it is not the entire list :)
I trimmed down the files to only the files I actually use registers
from. I didn't went into those files and removed from them the
registers I don't use.
I hope this isn't a hard requirement because that's really a dirty work.

>  - I see a good amount of HW setup code that's mostly just writing
> hardcoded values to a large number of registers. I don't have any
> specific recommendation on how to do it better, but doing as much as
> possible of this through on-device firmware tends to be a little
> cleaner (or rather, hides it from the kernel. :). I don't know if that
> fits your design though.

This is actually not according to our design. In our design, the host
driver is the "king" of the device and we prefer to have all
initializations which can be done from the host to be done from the
host.
I know its not a "technical" hard reason, but on the other hand, I
don't think that's really something so terrible that it can't be done
from the driver.

>  - Are there any pointers to the userspace pieces that are used to run
> on this card, or any kind of test suites that can be used when someone
> has the hardware and is looking to change the driver?

Not right now. I do hope we can release a package with some
pre-compiled libraries and binaries that can be used to work vs. the
driver, but I don't believe it will be open-source. At least, not in
2019.

>
> But, I think the largest question I have (for a broader audience) is:
>
> I predict that we will see a handful of these kind of devices over the
> upcoming future -- definitely from ML accelerators but maybe also for
> other kinds of processing, where there's a command-based, buffer-based
> setup sending workloads to an offload engine and getting results back.
> While the first waves will all look different due to design trade-offs
> made in isolation, I think it makes sense to group them in one bucket
> instead of merging them through drivers/misc, if nothing else to
> encourage more cross-collaboration over time. First steps in figuring
> out long-term suitable frameworks is to get a survey of a few
> non-shared implementations.
>
> So, I'd like to propose a drivers/accel drivers subtree, and I'd be
> happy to bootstrap it with a small group (@Dave Airlie: I think your
> input from GPU land be very useful, want to join in?). Individual
> drivers maintained by existing maintainers, of course.
>
> I think it might make sense to move the CAPI/OpenCAPI drivers over as
> well -- not necessarily to change those drivers, but to group them
> with the rest as more show up.

I actually prefer not going down that path, at least not from the
start. AFAIK, there is no other device driver in the kernel for AI
acceleration and I don't want to presume I know all the answers for
such devices.
You have said it yourself: there will be many devices and they won't
be similar, at least not in the next few years. So I think that trying
to setup a subsystem for this now would be a premature optimization.

Oded

>
>
> -Olof
>
>
>
> -Olof
