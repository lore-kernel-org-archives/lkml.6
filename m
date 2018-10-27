Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D8DC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC2420824
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elt7TEOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC2420824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeJ0PF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 11:05:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35359 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbeJ0PFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id q12-v6so497789wmq.0;
        Fri, 26 Oct 2018 23:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HWfMrph8e/QdCRT9hyqcC5RTeNy6Cd43nR34MMh8yUc=;
        b=elt7TEOQTLoh9Nii+HJAVN1GEQlYVZUKCnkCTO11IpfHNvqMOhY6yuHGvSLo326sO3
         9qcNBucx9Vsq0xh/NQ9z8KQJJw185yDdp6UnesDYIprdkqj1kSUZRtyoZAHe6tJORidP
         Q0VqyE9B9GowFyypAcvUogZkjRbBb2wiYxU9imOcG1d6Dky11lschZ6tSSYEJlBZC/ES
         qGLgwFO8czxMKXKqDg1mZ9FgBuq/RG4zwmcZ50wQcXohyPpynXayICi6DUbplY9H1Gnw
         j7aJDysH4gYEO4eL2ENNOxj7PU2p4bFZEh4frlerwHgdlLGKdlOE/fdIEBB3nLSBI1qY
         StEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HWfMrph8e/QdCRT9hyqcC5RTeNy6Cd43nR34MMh8yUc=;
        b=F2+FYR6CtEaMz+m/66Sa3h0GwLhkdg090+qjsQA4tMEvMEZzXXXXzpsankwIZcsvV1
         LZRourRchi9TEXZrUFuMs8BRZ/dj/4J7I+E6gQwvwbz1uYJRLxUc8J1L7VmcezcE9YWo
         jHPPtUIryznk6zEjIzpAv7R0tHpTvQHsDmXlvUPfOPxTQFrPTZaAV2jE7aR6QspiZj3R
         hBB7+zulI8W+TmH7AKqK2mgbj1UE/WgztMY/GDV1MfBQSauGQ9SYF5krrvBENLIfLbTG
         9lCl+S+sk/eCYKPQ5L+FLaSG/Z3371UEe8rVehih3wU474xi/p/o86VB3LGHRIAez1/H
         JLFg==
X-Gm-Message-State: AGRZ1gJ3oPS/LoCyZuywBsPmBUqUJTpc/BGY8/IymbHDWB+18rYgi2d4
        WBKs/x1nlWaTFPpzZ1ahE/M=
X-Google-Smtp-Source: AJdET5eFC05hS/iBEakxEQI1wqC2E1sr5kY3lTdIhQpBZFPrWrNbkHu2M8YOObERFBjGfq23VdFOiQ==
X-Received: by 2002:a1c:dcc:: with SMTP id 195-v6mr7445960wmn.117.1540621527859;
        Fri, 26 Oct 2018 23:25:27 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l67-v6sm17320180wma.20.2018.10.26.23.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 23:25:27 -0700 (PDT)
Date:   Fri, 26 Oct 2018 23:25:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
Message-ID: <20181027062525.GA22995@flashbox>
References: <20181025225548.GA10326@flashbox>
 <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org>
 <CAKwvOdnYx60JkJHJkD7CYA9yx5Oa7Tn9q4aZ3-tcZGx++yoduQ@mail.gmail.com>
 <1540589437.66186.124.camel@acm.org>
 <CAKwvOdm-xYRqCBXhLC1ceC44_rEmggW4qiSgGpRkpL+p-NadVg@mail.gmail.com>
 <1540591147.66186.127.camel@acm.org>
 <CAKwvOdmUhtK10cbYFoEJJp4O8LA_F-+f68A_NcL_fm_FH6QodA@mail.gmail.com>
 <20181027033552.GA29237@thunk.org>
 <ac63f6d2-d9f3-c512-892d-2e4450fd4c1e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac63f6d2-d9f3-c512-892d-2e4450fd4c1e@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:15:11PM -0700, Bart Van Assche wrote:
> On 10/26/18 8:35 PM, Theodore Y. Ts'o wrote:
> > The second observation I'll make is that if someone is proposing a
> > cleanup patch, it's unfair to dump on the person proposing the cleanup
> > patch the (non-trivial) effort to drop a driver/file system/subsystem.
> 
> Hi Ted,
> 
> Maybe I was not clear enough. It never was my intention to suggest that Nick
> or Nathan should remove the OSD code. This is something I'm willing to do
> myself. BTW, I'm still waiting for someone to explain me why the patch at
> the start of this thread was submitted by people who never have used the
> libosd driver and who do not have any plans to use it ever.
> 

Hi Bart,

We've been cleaning up Clang warnings seen in various configurations. In
this case, I believe this warning shows up in an arm64 allyesconfig
build (would probably show up in an x86_64 one too but I'm not going to
test right now).

More info: https://github.com/ClangBuiltLinux/linux/issues/58

Cheers,
Nathan

> > If the maintainer wants to drop a driver/file system, that should be
> > the maintainer's responsibiltiy; not someone proposing a
> > cleanup/maintenance patch.
> 
> I think anyone who makes tree-wide changes has the freedom to suggest to
> remove a driver. Having to modify drivers that are no longer maintained when
> doing tree-wide changes can be a real pain.
> 
> Additionally, you may have missed earlier discussions on the linux-scsi
> mailing list about this driver. The first time it was suggested to remove
> this driver was several years ago. The outcome of a discussion of a few
> weeks ago is that there is agreement about the removal of this driver. See
> also the following messages:
> * https://www.spinics.net/lists/linux-scsi/msg123738.html
> * https://www.spinics.net/lists/linux-scsi/msg123742.html
> 
> Bart.
