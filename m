Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38944C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A66218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="xW2YDxCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfAWXQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:16:29 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45923 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfAWXQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:16:29 -0500
Received: by mail-io1-f68.google.com with SMTP id c2so3080215iom.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U683wiu2cXkZaa6Y9YxxJr4NP8GMfyJ8YKCyetqBhZA=;
        b=xW2YDxCAUwt8goNmt4GOy2QYGGkQEFEqf5Zc5PGy61pCCqqwPunSJDV6iQlzIx0wa4
         8h+rqXAajCDotfkP6xD6JJTn110jLreFeC18/oKkTF8EgmGiYJouwVgXOLs4yotCrvg0
         0yohqHsOcSaT4Op4Bz1XGBTCY1y7OxRv+oya+Zd3rmEb51W5GodO8mVEN+IfjTDd67H7
         ykaxTyb1pLxwfsihHgapLG65iEhmf4ZlL4yUJ/oTJlhzTtc6aN/waBjygU+SVKfguPA5
         PV9FWzivn/a0WDW+S5GPvwELTSx+shNVesVkgT1UrHhoWUdv45xhUy20xmbJtROBExyu
         U5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U683wiu2cXkZaa6Y9YxxJr4NP8GMfyJ8YKCyetqBhZA=;
        b=Or+XOqFocrDSZrxl/U5yINrn2KDmvBSL3Gat8UTKlAUCHZ00Q+RVgm12V0W3G+W+DP
         dswBjQnrfGhssyUUTy5Pn/jX8XWxqZlRUfEFjm100C0CluXBKIadEkoX/PbISs4TZfVH
         2MpIzv4vMgPgzeRKoNDUhAEGOsgSATC5MZbIro01aBglsaYfe9cewM4O/IYkMCP7yjt/
         lN5krFM4bIaPRJ1qanipTQSbdTA2w3fG7LYieNvbhdosall7U9CqOylGr+k2ll4r7+mQ
         HXmqyV5RvlO8QPxyEKzH0KvfwcnVLL8ygACxkcuJhGP3tTnXJS2O8PfCSr3zNfxVJ8sG
         EHlg==
X-Gm-Message-State: AHQUAua8yjd4cZZ6gKgCVdQ+4qvMH4mvYseRhJopt+vB5Nb83JHRXgZX
        NU4jQdFwaLCENfoC7J7HfRTdlbdvriB+yCSqOYmJ0w==
X-Google-Smtp-Source: ALg8bN5LEg3iHVIe84+sUv7j0SKANB5/brHXBe69lQKNtz4VvIgVHO47cRuP/BK0JlHYplrMkyJOTBxw6YyFMhScQ1U=
X-Received: by 2002:a5e:c107:: with SMTP id v7mr2684098iol.155.1548285387956;
 Wed, 23 Jan 2019 15:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAOesGMjU0tjJwAqCADaAv6XrCGbjB8G2oT=4LxOgSQBHO7Gptw@mail.gmail.com>
 <CAFCwf11sxVAi1fxeZ698rBoJbaV3WHRJAyqB3RyddDLzfOysxA@mail.gmail.com>
In-Reply-To: <CAFCwf11sxVAi1fxeZ698rBoJbaV3WHRJAyqB3RyddDLzfOysxA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 23 Jan 2019 15:16:14 -0800
Message-ID: <CAOesGMgUTE_AHE6h5jbB6sdX0EdiMwKnMmRKo4U6t8wXt1wtWQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Dave Airlie <airlied@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai, Arnd Bergmann <arnd@arndb.de>,
        fbarrat@linux.ibm.com,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 2:41 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Wed, Jan 23, 2019 at 11:52 PM Olof Johansson <olof@lixom.net> wrote:
> >
> > Hi,
> >
> > On Tue, Jan 22, 2019 at 4:01 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> > > for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> > > Habana Labs since its inception two and a half years ago.
> > >
> > > Habana is a leading startup in the emerging AI processor space and we have
> > > already started production of our first Goya inference processor PCIe card
> > > and delivered it to customers. The Goya processor silicon has been tested
> > > since June of 2018 and is production-qualified by now. The Gaudi training
> > > processor solution is slated to sample in the second quarter of 2019.
> > >
> > > This patch-set contains the kernel driver for Habana's AI Processors
> > > (AIP) that are designed to accelerate Deep Learning inference and training
> > > workloads. The current version supports only the Goya processor and
> > > support for Gaudi will be upstreamed after the ASIC will be available to
> > > customers.
> > [...]
> >
> > As others have mentioned, thanks for the amount of background and
> > information in this patch set, it's great to see.
> >
> > Some have pointed out style and formatting issues, I'm not going to do
> > that here but I do have some higher-level comments:
> >
> >  - There's a whole bunch of register definition headers. Outside of
> > GPUs, traditionally we don't include the full sets unless they're
> > needed in the driver since they tend to be very verbose.
>
> And it is not the entire list :)
> I trimmed down the files to only the files I actually use registers
> from. I didn't went into those files and removed from them the
> registers I don't use.
> I hope this isn't a hard requirement because that's really a dirty work.

Yeah, it's always awkward to do this kind of cleanup. drivers/staging
was created in part for allowing a driver to go through this while
in-tree, if that helps.

> >  - I see a good amount of HW setup code that's mostly just writing
> > hardcoded values to a large number of registers. I don't have any
> > specific recommendation on how to do it better, but doing as much as
> > possible of this through on-device firmware tends to be a little
> > cleaner (or rather, hides it from the kernel. :). I don't know if that
> > fits your design though.
>
> This is actually not according to our design. In our design, the host
> driver is the "king" of the device and we prefer to have all
> initializations which can be done from the host to be done from the
> host.
> I know its not a "technical" hard reason, but on the other hand, I
> don't think that's really something so terrible that it can't be done
> from the driver.

This is why I was asking. It makes for a lot of boilerplate in the
driver, all with magic constants. They usually end up in some other
layer, but they're often constants no matter what.

> >  - Are there any pointers to the userspace pieces that are used to run
> > on this card, or any kind of test suites that can be used when someone
> > has the hardware and is looking to change the driver?
>
> Not right now. I do hope we can release a package with some
> pre-compiled libraries and binaries that can be used to work vs. the
> driver, but I don't believe it will be open-source. At least, not in
> 2019.

See my other reply, having the lowest layer of the interface from
userspace open might be an approach worth exploring.

> > But, I think the largest question I have (for a broader audience) is:
> >
> > I predict that we will see a handful of these kind of devices over the
> > upcoming future -- definitely from ML accelerators but maybe also for
> > other kinds of processing, where there's a command-based, buffer-based
> > setup sending workloads to an offload engine and getting results back.
> > While the first waves will all look different due to design trade-offs
> > made in isolation, I think it makes sense to group them in one bucket
> > instead of merging them through drivers/misc, if nothing else to
> > encourage more cross-collaboration over time. First steps in figuring
> > out long-term suitable frameworks is to get a survey of a few
> > non-shared implementations.
> >
> > So, I'd like to propose a drivers/accel drivers subtree, and I'd be
> > happy to bootstrap it with a small group (@Dave Airlie: I think your
> > input from GPU land be very useful, want to join in?). Individual
> > drivers maintained by existing maintainers, of course.
> >
> > I think it might make sense to move the CAPI/OpenCAPI drivers over as
> > well -- not necessarily to change those drivers, but to group them
> > with the rest as more show up.
>
> I actually prefer not going down that path, at least not from the
> start. AFAIK, there is no other device driver in the kernel for AI
> acceleration and I don't want to presume I know all the answers for
> such devices.

I'm not saying you have to have those answers, I'm just saying let's
start grouping them now so we at least have one place to look at them,
especially since we now have more than 2.

> You have said it yourself: there will be many devices and they won't
> be similar, at least not in the next few years. So I think that trying
> to setup a subsystem for this now would be a premature optimization.

It is initially not about building the shared subsystem as much as
grouping the general type of devices together, get someone to keep an
overall view across them, and encouraging more work between vendors
such as cross-review, etc.


-Olof
