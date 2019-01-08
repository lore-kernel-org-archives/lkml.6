Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC75C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DF62064C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogqd8YzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfAHRyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:54:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38301 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHRyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:54:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so5364421wml.3;
        Tue, 08 Jan 2019 09:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PCpopvTGly/xSkUUqv4OqmXIiFN9cOB022MYpdxMoGY=;
        b=ogqd8YzN5qx2NzPeou2VhQA5ngyx0WoNIk7uYcSkaCjxMl0Nrco7SH5u/DfgroTz6r
         wyxa6Lmnv2lBHKsHpRsGwzAKy+KH+AwblvBdVjLjZ2ixwn7R0AqLoO+inPUcJLj3D4cc
         xcvmki7DY1JHlZnCJu550NxReiMAmdbKC7Jinohv3og+afDq6SFZL4ggsK6oNG8PdmG8
         iPI0wihUN2fUqoPceaXiS4NmbnbbER/1B+B3ASiLxx4Y7DYDrUtP0xRxdb2oZ8xhykQQ
         Kr1SoNXoU5NmRHyF74VP1ayAGCFdDKO+8xRDkiol6ejXbgFAX3GRupj3KaFNWsxwySmN
         e6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PCpopvTGly/xSkUUqv4OqmXIiFN9cOB022MYpdxMoGY=;
        b=pp05BquEAMqlIdwbHYgvNnU28OwjtHimQ56N6Hiadao6Z316mhalr217zlHsOhU8bX
         U5HFbXUSZ/MNl5eTXEJ37/wyDkjoK4M1aoiZQCR+p8XYZUFMgQm0VBpYZK2r6Qvey7Xm
         AOE1JZ9bFL2j6HDSoPvBJT9bcYtsJunJBinLJCYBh8z/wN9BWf52JSHFDWLBk1nfEunF
         qWWU+SEzw4acQ+4jWyV9rmZ6+FejaWoc7mXigYddGL00RHZUmOGv9gud2tFiM7N5XZsl
         rlos4UxrJD7H13nvFKnFyh7gJxdktY18ROzLEiWPUEwGiHg5FX/I6k9x1oqyafvKA8IM
         reYQ==
X-Gm-Message-State: AJcUukewUNqnHrtYYpi9L0Keh+47YSSknSWbEgMkPwyDHssTJZn2ljiR
        ZRaptJo4XaOQyKkDq7xWo4Tm38kY0gc=
X-Google-Smtp-Source: ALg8bN4WrR0O17zwC6MCOqj19pgjVSXFXoREvRfEcBCuJhZCQbUWAY8zgcGpzrFyUPp3bILi9olouA==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr2372903wmf.17.1546970056677;
        Tue, 08 Jan 2019 09:54:16 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e18sm71496900wrv.88.2019.01.08.09.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 09:54:15 -0800 (PST)
Date:   Tue, 8 Jan 2019 10:54:14 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] isdn: avm: Fix string plus integer warning from Clang
Message-ID: <20190108175414.GA16657@flashbox>
References: <20190108050649.9962-1-natechancellor@gmail.com>
 <CAKwvOdmaZ6bbnkPGqEeaB6MMnLm+7Q14MUbbq_kNz5usgcU0bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmaZ6bbnkPGqEeaB6MMnLm+7Q14MUbbq_kNz5usgcU0bA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:50:39AM -0800, Nick Desaulniers wrote:
> On Mon, Jan 7, 2019 at 9:07 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > A recent commit in Clang expanded the -Wstring-plus-int warning, showing
> > some odd behavior in this file.
> >
> > drivers/isdn/hardware/avm/b1.c:426:30: warning: adding 'int' to a string does not append to the string [-Wstring-plus-int]
> >                 cinfo->version[j] = "\0\0" + 1;
> >                                     ~~~~~~~^~~
> > drivers/isdn/hardware/avm/b1.c:426:30: note: use array indexing to silence this warning
> >                 cinfo->version[j] = "\0\0" + 1;
> >                                            ^
> >                                     &      [  ]
> > 1 warning generated.
> >
> > This is equivalent to just "\0" so fix it to clean up the warning.
> 
> Hard to tell what the intent of this was.  I also assume that they
> meant to set all version strings to the empty string.  I think just `=
> ""` would be better, as otherwise that creates a new data section
> containing two zero bytes vs the empty string which already probably
> exists throughout the kernel and can be deduplicated by the linker.
> https://godbolt.org/z/qf3Rn8
> Sorry I gave the quick LGTM in
> https://github.com/ClangBuiltLinux/linux/issues/309#issuecomment-452106468,
> that was my mistake.  Assuming there's no other comments (maybe from
> the maintainers) on what the intent of this code actually is, would
> you mind sending a V2?  (Sorry again for the quick LGTM on this
> version).

Of course, thank you for the explanation and further exploration. I'll
send a v2 later today/tomorrow to give some time for the maintainers to
chime in.

> 
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/309
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/isdn/hardware/avm/b1.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/isdn/hardware/avm/b1.c b/drivers/isdn/hardware/avm/b1.c
> > index 4ac378e48902..7fa8141e2019 100644
> > --- a/drivers/isdn/hardware/avm/b1.c
> > +++ b/drivers/isdn/hardware/avm/b1.c
> > @@ -423,7 +423,7 @@ void b1_parse_version(avmctrl_info *cinfo)
> >         int i, j;
> >
> >         for (j = 0; j < AVM_MAXVERSION; j++)
> > -               cinfo->version[j] = "\0\0" + 1;
> > +               cinfo->version[j] = "\0";
> >         for (i = 0, j = 0;
> >              j < AVM_MAXVERSION && i < cinfo->versionlen;
> >              j++, i += cinfo->versionbuf[i] + 1)
> > --
> > 2.20.1
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
