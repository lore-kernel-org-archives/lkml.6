Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA325C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 10:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA8B2082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 10:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA8B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeKDUCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 15:02:02 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40117 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbeKDUCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 15:02:01 -0500
Received: by mail-ua1-f68.google.com with SMTP id n7so2160778uao.7;
        Sun, 04 Nov 2018 02:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NWmuAl1RI++3h4Iz0G3U92vdOfXpDIqD7r90dbT9UEk=;
        b=T8Ns8JCREaon0QDNRSG0x13lmwQt65crRtq5vu3wg88cXYd/+jSfv0qlR50iTiTspc
         jKVJ9mMao1VfVm6u3I4GWkNjmi5izmaeSgYt2luPZbt8n1a7tU7STy5ULzX08qmOJEIw
         5q3MalsCw0yUCmykuvhbcG5xSmK2/gmCiNxK86MOAtBkypn9maAdriDjim0S+RQI8HPG
         maY8Y7D41mofKxvXdnhDzvy0c8SxiQPmQt4deRKZjYM6HLlgKi2AM2haC3VKVXrcsVph
         jjpIHI1W/uXWw23x75/C2CyBx7ukRzThMDoaFHJ61NZtsZQt0YqsHJzuBZmSfwiLVQNQ
         uNHw==
X-Gm-Message-State: AGRZ1gLa0KBh4unXEDqyQlbScoSko3tSQGNQLm1IEtMajPdqn5juxhEE
        AJFEQg5a7dwkRsH5y+JT7g+oRaqHAuUeXrc0Jgw=
X-Google-Smtp-Source: AJdET5dVRKNb2ZUUK7gyNr5cERGoaViJO78lBE4AHZQ6BUiC4QEyriiY1QA/CsyduFBKciy3S24X6hVXh5RSwVFE7vk=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr7676309uad.78.1541328449196;
 Sun, 04 Nov 2018 02:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com> <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
 <20181025081911.GB11343@kroah.com> <20181025193901.GD26403@thyrsus.com>
 <20181025204718.GB25649@thunk.org> <20181025214123.GA2448@thyrsus.com> <87a7n165h6.fsf@notabene.neil.brown.name>
In-Reply-To: <87a7n165h6.fsf@notabene.neil.brown.name>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 4 Nov 2018 11:47:17 +0100
Message-ID: <CAMuHMdXw1XAkGv1G3uR5Lx7nffHdAS2G26VPYVzZOUYfhfSmHQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] The linux devs can rescind their license grant.
To:     neil@brown.name
Cc:     esr@thyrsus.com, Theodore Tso <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        visionsofalice@redchan.it,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rms@gnu.org, bruce@perens.com, moglen@columbia.edu,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>, editor@lwn.net,
        Laura Abbott <labbott@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        mishi@linux.com, linux-kernel-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 12:12 AM NeilBrown <neil@brown.name> wrote:
> On Thu, Oct 25 2018, Eric S. Raymond wrote:
> > Theodore Y. Ts'o <tytso@mit.edu>:
> >> On Thu, Oct 25, 2018 at 03:39:01PM -0400, Eric S. Raymond wrote:
> >> > Under Jacobsen vs. Katzer (535 f 3d 1373 fed cir 2008) authors of
> >> > GPLed software have a specific right to relief (including injunctive
> >> > relief) against misappropriation of their software. That ruling (which
> >> > was the case of first impression on the binding status of the GPL)
> >> > reputational damage is *specifically* recognized as grounds for relief.
> >>
> >> I've read the legal briefs, and I'm pretty sure they don't say what
> >> you are claiming they say.  Yes, I'm not a lawyer --- but that's OK
> >> --- neither are you.
> >
> > How much are you willing to gamble on not being wrong?
> >
> >> The *vast* majority of the "anti-CoC dissidents" who have been
> >> advancing this argument, have, as near as I can tell, little or no
> >> copyright ownership in the kernel.
> >
> > I do not have any facts with which to dispute this specific claim.
> > However, I do notice that a significant number of long-time
> > contributors have put themselves in the anti-CoC camp. I note Al Viro
> > as a recent example.
>
> I think you are blurring two groups here.
> Ted describes "anti-CoC dissidents" as people who are advancing an
> argument about rescinding their license.  This is a smaller groups than
> the "ant-CoC camp" who don't really like the CoC.  I suspect is it is a
> much smaller group when restricting to actual copyright holders.
>
> I am against the CoC as it stands, but rescinding any license is such an
> enormous over-reaction, I find the concept laughable.

Indeed. While I cannot comment on the legality of the rescinding, this
rescinding is definitely not compatible with "be nice to each other",
which is what all kernel developers who do not like the CoC as it
stands, and who I'm aware of, do like as a general principle.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
