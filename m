Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8CFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204D324B01
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204D324B01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933155AbeGCGeB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:34:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932730AbeGCGeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:34:00 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F0E43E25;
        Tue,  3 Jul 2018 06:33:59 +0000 (UTC)
Date:   Tue, 3 Jul 2018 08:33:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.9 000/101] 4.9.111-stable review
Message-ID: <20180703063357.GB21613@kroah.com>
References: <20180701160757.138608453@linuxfoundation.org>
 <CAMuHMdVcSkXAmuD2qsc0mk9pDx_Fd0Q_peBmZY6Mpfkq6gMQZg@mail.gmail.com>
 <20180702102413.GB16825@kroah.com>
 <CA+55aFzwn3M0q8Ps6VTKK98693P7verOAEggJ7AsR6CEgk6VGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzwn3M0q8Ps6VTKK98693P7verOAEggJ7AsR6CEgk6VGA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 09:47:59AM -0700, Linus Torvalds wrote:
> On Mon, Jul 2, 2018 at 3:24 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 02, 2018 at 11:57:36AM +0200, Geert Uytterhoeven wrote:
> > >
> > > > Pseudo-Shortlog of commits:
> > >
> > > Given you do publish a git tree with these changes, is there any specific reason
> > > you're not using a real shortlog? Sorting and grouping would make it
> > > easier to see
> > > which patches of mine you have backported.
> >
> > Many years ago Linus wanted it in this type of format as it was easier
> > to see what was being applied to the trees.
> 
> I think you refer to an old email of mine where I said:
> 
>  "I think Greg has a script he uses, so I'm cc'ing him here too. i'm not
>   sure I really like his one-liner format, but I'm not sure what the
>   right format would be. I *think* the format I'd prefer would be a
>   two-liner one (with a newline in between), something like
> 
>      git log --abbrev=12 --format="%h %aN <%aE>%n    %s%n"
> 
>   but that's more of a "maybe something along those lines.." than anything else"
> 
> Note that "maybe something along those lines", and in fact the format
> Greg uses doesn't have the commit ID in it, so it's more like
> 
>     git log --format="%aN <%aE>%n    %s%n"
> 
> I forget what the original format Greg used was, but I don't think it
> was "shortlog".  This is from almost a decade ago, and I couldn't
> actually find any of Greg's emails with the original format that I
> found to be inconvenient. I think it was something really dense and
> incomprehensible based on my " i'm not sure I really like his
> one-liner format", but..
> 
> Maybe just "shortlog" would be better. I agree that it's likely easier
> for authors to see what commits got done from them, thanks to the
> author grouping.

I don't think I was using git originally when I was creating these
patches and announcements as the stable trees started up just before git
was created.  But that changed years ago, let me mess with my scripts to
see if I can change this for future -rc announcements.

thanks,

greg k-h
