Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8CEC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7CC20989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwtS6dHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7CC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeIYFib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:38:31 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42561 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeIYFib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:38:31 -0400
Received: by mail-yb1-f195.google.com with SMTP id p74-v6so8428955ybc.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 16:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gN7FwjX9qqOQgtcCgCvRCQasGtTF/V4U+1KnI6W9vgk=;
        b=jwtS6dHDXyAmCEc5dxYlfgsoACvJuguOLW5CiqVO1aXdbyol9Qk2iTt8KaWDOnDYgc
         HTqd4eZci9PjeA6qcDNqGAIfnB26JWCjq1chLwWGEVkBOmF3CuMBdEYX2rl1o+eJv5AO
         Q0vMXMOiGvc3y2Q1B4VqrYHRz1iLoOmqn+Zti/qtZfwl3Qykw0OzuDbAaiZLGDqhpCBE
         NByOv8GRMmAtzyr88axHFcB6XePzjsPpLVBAq6PqYJ+XfEw+JhGdb+r361N2KRdxAozs
         0vFSfxFhH3BsLQzy7bkVhH+ssWeJs/2oS/6wWpDiTCs+MUhkII4gxfWEjSgNOQvB1p4O
         Hwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gN7FwjX9qqOQgtcCgCvRCQasGtTF/V4U+1KnI6W9vgk=;
        b=QCFsznNgD0/iziK6PDlF7S+ZLMFSD2SHMISBF+0nTHH74978RJGlGb2eFgptMd9ZAQ
         eCIGkUaKagCNhufQHzAqzUY1sSpLrRa5AXsdN5NtPiSRsw+4aCybJLdRydQO+oWqftr9
         M49jmqSmkbjl6LePIW73AmdYGywljLLX++1nt/GncK952BMskDoHaOVzvjIdCcMi6IhN
         5ZXb7BrxfQWeFsG/NXf4kY9NPRFie8E1nbrLB7Krri5SD5jiby/ftfJj5Symhs3RsLVd
         CNXTv/J/AUwNhfzJ52s5GmnOH2zsORxgBHhO9QxqNqksRGcYqJ/0YlWwQ2ENf+A93UCQ
         Pu4Q==
X-Gm-Message-State: ABuFfohHLzGyr5vq9GxGzgFzWiTpavo5o51NB8AG08ntE6+VLwoW0VD0
        /2yO3iyXfI0iDGEGC38Q3rIq664/LRhR2MT48Js=
X-Google-Smtp-Source: ACcGV630zl/yx6CeLdMpSdXuU4LDxVitNHJShQCtw4Bu5hPap0tlk0cMyoK8A+F+SwBiqrDFRsGMRfsLDnwtmaWi/bM=
X-Received: by 2002:a25:b941:: with SMTP id s1-v6mr564945ybm.60.1537832033498;
 Mon, 24 Sep 2018 16:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180912035352.11191-1-diego.viola@gmail.com> <CA+ToGPGSOsLpbOvjjb22B510qkNefdsUSiFTYON7c=oh0s8vcA@mail.gmail.com>
 <CANiq72m_X1U+NVf1VQuUcCi9-dERrCG3Y3tueRGbOpPd5u+a0g@mail.gmail.com>
In-Reply-To: <CANiq72m_X1U+NVf1VQuUcCi9-dERrCG3Y3tueRGbOpPd5u+a0g@mail.gmail.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Mon, 24 Sep 2018 20:33:41 -0300
Message-ID: <CA+ToGPHwo73ru+gf8dLPpPFmETvPpE8EwRGQCKYSrC1MedKrVw@mail.gmail.com>
Subject: Re: [PATCH TRIVIAL] Punctuation fixes
To:     miguel.ojeda.sandonis@gmail.com, jikos@kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Sat, Sep 22, 2018 at 9:59 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Diego,
>
> A few things, since it looks like this is your first patch.
>
> On Sat, Sep 22, 2018 at 5:56 PM, Diego Viola <diego.viola@gmail.com> wrote:
> > On Wed, Sep 12, 2018 at 12:54 AM Diego Viola <diego.viola@gmail.com> wrote:
> >>
> >> Signed-off-by: Diego Viola <diego.viola@gmail.com>
> >> ---
> >>  CREDITS     | 2 +-
> >>  MAINTAINERS | 2 +-
> >>  Makefile    | 2 +-
> >>  3 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/CREDITS b/CREDITS
> >> index 5befd2d71..b82efb36d 100644
> >> --- a/CREDITS
> >> +++ b/CREDITS
> >> @@ -1473,7 +1473,7 @@ W: http://www.linux-ide.org/
> >>  W: http://www.linuxdiskcert.org/
> >>  D: Random SMP kernel hacker...
> >>  D: Uniform Multi-Platform E-IDE driver
> >> -D: Active-ATA-Chipset maddness..........
> >> +D: Active-ATA-Chipset maddness...
>
> I think the extra dots is what was intended here :)

OK.

>
> >>  D: Ultra DMA 133/100/66/33 w/48-bit Addressing
> >>  D: ATA-Disconnect, ATA-TCQ
> >>  D: ATA-Smart Kernel Daemon
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index d870cb57c..6567bf245 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -93,7 +93,7 @@ Descriptions of section entries:
> >>            Supported:   Someone is actually paid to look after this.
> >>            Maintained:  Someone actually looks after it.
> >>            Odd Fixes:   It has a maintainer but they don't have time to do
> >> -                       much other than throw the odd patch in. See below..
> >> +                       much other than throw the odd patch in. See below.
> >>            Orphan:      No current maintainer [but maybe you could take the
> >>                         role as you write your new code].
> >>            Obsolete:    Old code. Something tagged obsolete generally means
> >> diff --git a/Makefile b/Makefile
> >> index 4d5c883a9..7b5c5d634 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -1109,7 +1109,7 @@ archprepare: archheaders archscripts prepare1 scripts_basic
> >>  prepare0: archprepare gcc-plugins
> >>         $(Q)$(MAKE) $(build)=.
> >>
> >> -# All the preparing..
> >> +# All the preparing...
> >>  prepare: prepare0 prepare-objtool
> >>
> >>  # Support for using generic headers in asm-generic
> >> --
> >> 2.19.0
> >>
> >
> > Jonathan,
> >
> > can you please merge my patch? After you merge this one, I'll go
> > through the rest of the documentation to make it more consistent.
>
> Jonathan is not responsible for these files. Jiri Kosina is the
> maintainer of the trivial tree.

OK, I'm CCing him with this email.

>
> There are 1700+ instances of a "two-stops ellipsis" in the kernel. I
> am not sure they were mistakes, given their prevalence, even if they are
> not formal/common English. Also, I am not sure a commit for each 3 is
> really appropriate! :) Maybe do the full sweep of the Documentation
> ones in a single patch?

Good idea, do you know what approach I can use for the full sweep? sed
perhaps? Doing this manually would be very tedious and using sed might
be error prone.

>
> Also, typically you would note in the subject that this is a "v2" of
> your previous patch (if I am not wrong, you sent a first version
> fixing only one of the 3 mistakes).

Correct, this is my V2 of the first patch. Sorry for not specifying that.

>
> Thanks for your first patch!
>
> Cheers,
> Miguel

Thanks,
Diego
