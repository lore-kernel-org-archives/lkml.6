Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858D7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B012080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="YfeAw3mB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B012080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeKAHu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:50:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45967 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeKAHu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:50:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so16373635ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+AWPvS1ybMd/GJs1XxIzYJE6EQJCAlsQ6yYrHC9vYM=;
        b=YfeAw3mBtCZ4yDGaXX7TE94z3MlBGMx/dYwsWA6iZ7ElHyA7tv6KzqfFdKyMhE5IvP
         1i070ldez/bVNUDR7JmYZVjU+ryUoOpjUsKL/WrdpZ6PuxBI3qcCLQv7VdOgHaCq/Irn
         LtpIo+HBKalo1KXDn8ZR05PfhL0UI9Ef1IJguHs+UBnBg9U9971sAtsp1QwKg+YhtIFW
         qVuocEyj8hvnSGdqkY+jBwZcjzU98uOylwaSOTsE08Wj66YZSNHfLnDoilDzgGb0blIg
         592ep+Ngng3eXRP5kDFIazXR2+K8dXh7+1+wBLWKeVzvN16xp+bArH9IDeVQjPnPTjeQ
         w3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+AWPvS1ybMd/GJs1XxIzYJE6EQJCAlsQ6yYrHC9vYM=;
        b=rMQkN2aZyuI8u1+cuSMYeY4v/SyyPpJP9LnrV2J60N79kGr5KWAT/s6O4vo93Ftmpj
         Afs/BBy4XvWkhwVjPgq7RlFPd8+hEYnYsS129xpeGDNfWI7I/1r/Oa0ZMcfK1zomyePS
         j0T5lGvLtIrBdLtScUu3zfEz1FB5VW9NMhLMbMBPrEg6H2drc6yqOCOTIE2yVtuQ0TT+
         Obq5tC94omaqQfd7TzO/Q9toAMhEegPdCjB6yzfRnBYdkRy/BM2qc5AFeVrY4lyMWh5n
         nv0iwofL30vaHML6IsU8QV3YBmTxEbYtwmfVf67vb4y+Bv1PRTfl/LUB1wL5ExZVFrle
         TsLg==
X-Gm-Message-State: AGRZ1gIWzLsCbfdi+cxwO9IpUz6igU3bZ6KxFVW4Hd+xB9AlV+n5WaTJ
        4hoI5hmnCKcGeFjgU3UWObNvhU4HKJjkWediWPCI6A==
X-Google-Smtp-Source: AJdET5edcUhXQKmMP/bWjCjEJ5/yit/gdLNG6PcEkDTk3JuPxcKFGkQSReAqIH4aLvicH8ohswXcJVA8PYzdheL6KrA=
X-Received: by 2002:a2e:94ce:: with SMTP id r14-v6mr1531873ljh.34.1541026250462;
 Wed, 31 Oct 2018 15:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOesGMjXZNURZ4SdKjssYCcFv3=4MYLBpBpzvvb1rNM-fo=QHQ@mail.gmail.com>
 <mhng-111820e6-59c0-479a-a10f-f3729007ba70@palmer-si-x1c4>
In-Reply-To: <mhng-111820e6-59c0-479a-a10f-f3729007ba70@palmer-si-x1c4>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 31 Oct 2018 15:50:38 -0700
Message-ID: <CAOesGMj+wXcN_7yvakC=SvtYjO=TTqrs8YiVX1xT7-4p1pC_Mg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: defconfig: Enable printk timestamps
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     davem@sunset.davemloft.net, anup@brainfault.org,
        Albert Ou <aou@eecs.berkeley.edu>, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 1:42 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 31 Oct 2018 12:20:40 PDT (-0700), Olof Johansson wrote:
> > On Tue, Oct 30, 2018 at 5:37 AM Anup Patel <anup@brainfault.org> wrote:
> >>
> >> The printk timestamps are very useful information to visually see
> >> where kernel is spending time during boot. It also helps us see
> >> the timing of hotplug events at runtime.
> >>
> >> This patch enables printk timestamps in RISC-V defconfig so that
> >> we have it enabled by default (similar to other architectures
> >> such as x86_64, arm64, etc).
> >>
> >> Signed-off-by: Anup Patel <anup@brainfault.org>
> >
> > Acked-by: Olof Johansson <olof@lixom.net>
> >
> > For next time: doing a re-format of the defconfig (to shuffle config
> > order), plus changes in the same patch, tends to be a bit fragile. For
> > cases like these, I'd recommend hand-pruning to just flip the one
> > option if needed, and then have Palmer or Andrew refresh the defconfig
> > during a merge window if needed (usually quite rare).
>
> I poked around and it looks like most architectures have this enabled for at
> least one defconfig, with the big architectures having it enabled for all of
> them.

It's pretty convenient to have it on, and I think those who haven't
probably don't use those defconfigs much.

> I decided to do a bit of a case study here to try and figure out why some
> architectures have this enabled for some defconfigs but not for others, and as
> far as I can tell it's just an oversight.  Specifically, looking at sparc32 (#
> CONFIG_PRINTK_TIME is not set) vs sparc64 (CONFIG_PRINTK_TIME=y) I can't find
> any reason for the difference.  sparc32's setting can be traced back to

I'm not sure sparc32 is overly active these days, which might help explain it?

>     commit 216da721b881838d639a3987bf8a825e6b4aacdd
>     Author: David S. Miller <davem@sunset.davemloft.net>
>     Date:   Sun Dec 17 14:21:34 2006 -0800
>
>         [SPARC]: Update defconfig.
>
>         Signed-off-by: David S. Miller <davem@davemloft.net>
>
> which changes everything in the defconfig, while the sparc64 version dates back to
>
>     commit 3ebc284d52757cf39788731f8fddd70a89f7fc23
>     Author: David S. Miller <davem@sunset.davemloft.net>
>     Date:   Mon Jan 9 14:36:49 2006 -0800
>
>         [SPARC64]: Update defconfig.
>
>         Signed-off-by: David S. Miller <davem@davemloft.net>
>
> When we first submitted out port upstream we had an empty defconfig, with the
> theory being that we should just pick whatever the default in Kconfig is for
> everything.  That's obviously the wrong thing to do because most of those
> options are bogus.  At the time I didn't care enough to look because I just
> wanted something to work, but now I find myself asking the question "what goes
> in a defconfig?"  Is it:
>
> * What I, as the maintainer of arch/riscv, want?  That's essentially what it is
>   now, as we have things like "CONFIG_R8169=y" in there because I happened to
>   have one sitting around when we needed to plug in an Ethernet card to test
>   out PCIe.
> * What distributions expect?  There's a major element of this in there right
>   now, as half this stuff was just selected because the Debian and Fedora guys
>   suggested we do so because adding things to the RISC-V defconfig made it
>   easier to put together their build scripts.  For example, we ended up with
>   "CONFIG_EXPERT=y" because some setting necessary for the distros was hidden
>   behind it -- that seems like an odd default.
> * What users expect?  I'm not even sure who users are in this case, as from my
>   understating most people use distro kernels and don't twiddle Kconfig
>   options.
> * What is necessary to work on RISC-V hardware?  This seems like the most
>   reasonable use for an arch-specific defconfig, and subsumes things like
>   "CONFIG_SIFIVE_PLIC=y" because without the PLIC driver nothing will work (but
>   the PLIC driver shouldn't be enabled by default for all architectures, as
>   it's useless everywhere else).
>
> Maybe I've opened up a big can of worms here...  It just seems silly to have
> most of our current defconfig be RISC-V specific.

So, on 32-bit ARM we have heavy defconfig proliferation, and for arm64
there was a push to only have one defconfig. I'm heavily in favor of
the latter.

On ARM64, the options turned on, are more or less "what makes the
kernel useful on systems". Anything that would be needed to boot to a
rootfs tends to be =y, while some other things that might be optional
and not used everywhere tends to go in as modules.

Beyond that, for the most part it is maintainer preference. I've
normally turned on platforms and drivers I need for my boot farm on
the multi*defconfig configs on 32-bit ARM, and the same has been going
for 64-bit.

Distros will always want something different, for policy reasons or
otherwise. Main purpose of mainline defconfigs is to make mainline
kernels useful and bootable, so having more of a superset approach
makes a lot of sense in my mind.

> Anyway, I'm happy with the change because it meets my "what I want" criteria
> :).  I'll split it into two parts, though, as that way when someone else has to
> go to some archaeology on our port they'll be less likely to get lost.

Sounds good to me. On ARM, we sometimes do the "refresh defconfig"
runs across the board, but not for every release since it tends to get
churny. Make sure you do it before -rc1 to avoid conflicts if
contributors base branches on -rc1 and send them to you (probably not
that common yet).



-Olof
