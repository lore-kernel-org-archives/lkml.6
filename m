Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90830C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474A7217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474A7217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeHDOZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 10:25:42 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:46806 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeHDOZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 10:25:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id A02802964C;
        Sat,  4 Aug 2018 08:25:05 -0400 (EDT)
Date:   Sat, 4 Aug 2018 22:25:37 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: manual merge of the powerpc tree with the m68k
 tree
In-Reply-To: <CAMuHMdXTW8iSA+HnnDNzoNkMwUchLY1J6YBYCBCfGRT5UatBqg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1808042209030.9@nippy.intranet>
References: <20180802092708.10e1a71d@canb.auug.org.au> <20180802094154.6d88f03c@canb.auug.org.au> <CAMuHMdXTW8iSA+HnnDNzoNkMwUchLY1J6YBYCBCfGRT5UatBqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018, Geert Uytterhoeven wrote:

> Hi Stephen,
> 
> On Thu, Aug 2, 2018 at 1:42 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > [forgot the conflict resolution ...]
> >
> > On Thu, 2 Aug 2018 09:27:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Today's linux-next merge of the powerpc tree got a conflict in:
> > >
> > >   arch/m68k/mac/misc.c
> > >
> > > between commit:
> > >
> > >   5b9bfb8ec467 ("m68k: mac: Use time64_t in RTC handling")
> > >
> > > from the m68k tree and commit:
> > >
> > >   ebd722275f9c ("macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver")
> > >
> > > from the powerpc tree.
> > >
> > > I fixed it up (see below) and can carry the fix as necessary. This 
> > > is now fixed as far as linux-next is concerned, but any non trivial 
> > > conflicts should be mentioned to your upstream maintainer when your 
> > > tree is submitted for merging.  You may also want to consider 
> > > cooperating with the maintainer of the conflicting tree to minimise 
> > > any particularly complex conflicts.
> 
> Ah, now I remember Finn said he was going to rebase his series once the 
> time64_t patch has entered my tree...
> 

The conflict I was worried about was avoided when I dropped v3 patch 10/12 
("macintosh: Use common code to access RTC"). I'll rework that patch after 
all the PMU and RTC work makes its way into Linus' tree.

> > --- a/arch/m68k/mac/misc.c
> > +++ b/arch/m68k/mac/misc.c
> > @@@ -90,11 -85,11 +90,11 @@@ static void cuda_write_pram(int offset
> >   }
> >   #endif /* CONFIG_ADB_CUDA */
> >
> > - #ifdef CONFIG_ADB_PMU68K
> > + #ifdef CONFIG_ADB_PMU
> >  -static long pmu_read_time(void)
> >  +static time64_t pmu_read_time(void)
> >   {
> >         struct adb_request req;
> >  -      long time;
> >  +      time64_t time;
> >
> >         if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
> >                 return 0;
> 
> Thanks, looks good to me!
> 

Looks good to me, too.

Thanks.

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
