Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A33C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA09521855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pYwsK2GX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfAWVw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:52:28 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52870 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfAWVw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:52:28 -0500
Received: by mail-it1-f195.google.com with SMTP id d11so1677018itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 13:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbSUMIZsaBkRjHX5bpoAKD/0YK6fYjnKaVQEAnf4tT8=;
        b=pYwsK2GXquIMXkBOwLZVJbBugooU8bOF7rPks+HXH0dn4zcF/w1w3RjUjvF8Fbh2WX
         UdX4SUMtH9YCAOVwb50hQFZvN7320igVG9rmkki6MpoXEbU+Vrp+YvemQkVzwEnMDJJ0
         8pR7GwQBQYx+7ATVV6gutSc7zopd3z8E8JB3bzJoCgBoUQh2eAPDg49Qm6E0eTtasoTg
         WWitnZPdOChLB4Y++siszQABRvi2j5Jl7aOHJ6Ekplc/MBDYCBKA+mtb6F82uojvtf+B
         irJcyvFRjF+GDluOSGjvEuqhm9y01gx7+3B0n0iLD+a5S+fJsMPGeAxQMqqfPGFPW98B
         OToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbSUMIZsaBkRjHX5bpoAKD/0YK6fYjnKaVQEAnf4tT8=;
        b=VV7UvmuUGJ64V0WLFrxyHLXXPi3rimdmVa05/nmy/ymfYV5eLqtWYmGqYsiw0+4vpT
         X+OsMsZSNGCbt9VA876IX272bpP0nGirZPFNMiTTRANiy8YvjDNjwWk4mqbUU6+NITJQ
         qHXREgwVcFXg2UL2Q+8MISr+SgeGP+O1McWs6RUCZmt1T7MBXCjXa0FYui1ciCpswHwo
         GmsNN3KRzYMcbX97/aIjyTAVPho2nUn6IM/tcCT6DJFLDp1+f250O2N1mjwFzl8mB0nb
         vDxUbZLU4pENKX3fPxeGtUmLgL+AR+Zlvj/7BtvDNrMjnqBnKXgonwDhwO9BvWoEppGl
         IYwQ==
X-Gm-Message-State: AJcUukdGZ74eFmm8OYfHEZ585cd2z9vNd0Fj8tpdwHegm4BUdQDCcSEw
        50jDyvuc62d1AviLfDCiPPeB7lKGKx49SFinqWOOUw==
X-Google-Smtp-Source: ALg8bN4tBjNgWMn4jW2VKKv3znFTJQDEXfM8UUsk1IKjn+RTNY0dgXKMyvd7WmrPnnl1iI3roSVgdjqYhZxl7P+8R+A=
X-Received: by 2002:a02:98d2:: with SMTP id c18mr2485693jak.11.1548280346763;
 Wed, 23 Jan 2019 13:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
In-Reply-To: <20190123000057.31477-1-oded.gabbay@gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 23 Jan 2019 13:52:15 -0800
Message-ID: <CAOesGMjU0tjJwAqCADaAv6XrCGbjB8G2oT=4LxOgSQBHO7Gptw@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai, Arnd Bergmann <arnd@arndb.de>,
        fbarrat@linux.ibm.com, andrew.donnellan@au1.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 22, 2019 at 4:01 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> Hello,
>
> For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> Habana Labs since its inception two and a half years ago.
>
> Habana is a leading startup in the emerging AI processor space and we have
> already started production of our first Goya inference processor PCIe card
> and delivered it to customers. The Goya processor silicon has been tested
> since June of 2018 and is production-qualified by now. The Gaudi training
> processor solution is slated to sample in the second quarter of 2019.
>
> This patch-set contains the kernel driver for Habana's AI Processors
> (AIP) that are designed to accelerate Deep Learning inference and training
> workloads. The current version supports only the Goya processor and
> support for Gaudi will be upstreamed after the ASIC will be available to
> customers.
[...]

As others have mentioned, thanks for the amount of background and
information in this patch set, it's great to see.

Some have pointed out style and formatting issues, I'm not going to do
that here but I do have some higher-level comments:

 - There's a whole bunch of register definition headers. Outside of
GPUs, traditionally we don't include the full sets unless they're
needed in the driver since they tend to be very verbose.
 - I see a good amount of HW setup code that's mostly just writing
hardcoded values to a large number of registers. I don't have any
specific recommendation on how to do it better, but doing as much as
possible of this through on-device firmware tends to be a little
cleaner (or rather, hides it from the kernel. :). I don't know if that
fits your design though.
 - Are there any pointers to the userspace pieces that are used to run
on this card, or any kind of test suites that can be used when someone
has the hardware and is looking to change the driver?

But, I think the largest question I have (for a broader audience) is:

I predict that we will see a handful of these kind of devices over the
upcoming future -- definitely from ML accelerators but maybe also for
other kinds of processing, where there's a command-based, buffer-based
setup sending workloads to an offload engine and getting results back.
While the first waves will all look different due to design trade-offs
made in isolation, I think it makes sense to group them in one bucket
instead of merging them through drivers/misc, if nothing else to
encourage more cross-collaboration over time. First steps in figuring
out long-term suitable frameworks is to get a survey of a few
non-shared implementations.

So, I'd like to propose a drivers/accel drivers subtree, and I'd be
happy to bootstrap it with a small group (@Dave Airlie: I think your
input from GPU land be very useful, want to join in?). Individual
drivers maintained by existing maintainers, of course.

I think it might make sense to move the CAPI/OpenCAPI drivers over as
well -- not necessarily to change those drivers, but to group them
with the rest as more show up.


-Olof



-Olof
