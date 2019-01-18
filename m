Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D9C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18FC2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdIhxyH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfARRlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:41:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43045 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfARRlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:41:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so16017529wrs.10;
        Fri, 18 Jan 2019 09:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mzg9EUTLIPNvLNagZk6C9yYZnrObcy0P2m78oV2lBeQ=;
        b=MdIhxyH6ftWR+BTRROYBjDElVBHxIxDvuhZSJw5lEB2jBH7pVzfBl1z87mHmc6UeRB
         a0DVpzqWz4a0WZZHDGExDZbddmCuXf50I3QO8ouRNjs9PGRZA14cdKFBLWoQFX6OdJUw
         f27vVfa58iYAFNjnkfrjlQVoqvphHJZ01dQXfMPROY56oatIVaMYijO5uF0h1ozKfNQo
         6n1ekZGYo4YGadLMwekdMtNVehi6IRhgS0S3+xfYRbEACve5UCpDEJ0XQaWYrhdUp+2I
         ks3mzpw0Aqt+4g38uC8QpPfgNhBPT52yWakgzLTyu0eiP9RUUeH0eG4QOkdeI7b9Qf2j
         kAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mzg9EUTLIPNvLNagZk6C9yYZnrObcy0P2m78oV2lBeQ=;
        b=ftXCwlRcRR6gnPupq1dDqNucxREMz65G4QAm1jLDNrG4nDtAIk/+sZe1IjJF2sltke
         NK5y2xc4vsEt+CkoDToUIhDijxc9onjCykaZQffoteiNrbIvDgDf4BuY+7fDGlK5bzI2
         CkNxLwJqDkVpULZ013P0hgSRIpR6GVfrCgXb5aDvUxNWaol3KrKru43akqDdpaq4f9s0
         vmSXPC+qYw7yPDAkBhtnZ+piOlOmXyOnsHAoaEF/DNgR0L79+IFIXOV+s2C9z/NBuUKP
         n7gQUkLxVQfHhVaqJ7WcACn+rG0ZCXy1MyjVMe5sUfZ01mIuPfOKRkOEsSkffBJUhqxO
         LZnA==
X-Gm-Message-State: AJcUukdCzt/UHbyb5EafP42TNAFMY+e6P/AquZIuJCbSKxFG1y/u/QXx
        Je1xNCDTXWBQXqT/1H7vuTUe7hOWVL0ejQ==
X-Google-Smtp-Source: ALg8bN7njLMNLviiVM0Yju0VfWuHAoVmoEEi5uK3Bs49G+HxB/MiNbGIQ26CMguGppN/vJGgzX1C5w==
X-Received: by 2002:adf:b3c3:: with SMTP id x3mr17607089wrd.294.1547833289769;
        Fri, 18 Jan 2019 09:41:29 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id p4sm68359895wrs.74.2019.01.18.09.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 09:41:29 -0800 (PST)
Date:   Fri, 18 Jan 2019 10:41:27 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: linux-next: Fixes tag needs some work in the clk tree
Message-ID: <20190118174127.GA822@flashbox>
References: <20190116083440.11b6839c@canb.auug.org.au>
 <154767815973.169631.1738587342757192096@swboyd.mtv.corp.google.com>
 <CAOMZO5DSbVpha=1_s5K+-vodD+N1fGnj41_UKmvqxDOPhxXwfg@mail.gmail.com>
 <154775054438.169631.5111867106558251203@swboyd.mtv.corp.google.com>
 <878szi3zp6.fsf@concordia.ellerman.id.au>
 <154783304655.169631.12906027462791855701@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154783304655.169631.12906027462791855701@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 09:37:26AM -0800, Stephen Boyd wrote:
> Quoting Michael Ellerman (2019-01-18 04:41:41)
> > Stephen Boyd <sboyd@kernel.org> writes:
> > 
> > > Quoting Fabio Estevam (2019-01-16 17:25:21)
> > >> On Wed, Jan 16, 2019 at 10:44 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >> 
> > >> > Ok sure. Does this matter to scripts? Is it documented in
> > >> > Documentation/process/submitting-patches.rst? I've seen both types, one
> > >> 
> > >> From Documentation/process/submitting-patches.rst"
> > >> 
> > >> "If your patch fixes a bug in a specific commit, e.g. you found an issue using
> > >> ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
> > >> the SHA-1 ID, and the one line summary.  For example::
> > >> 
> > >> Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")"
> > >
> > > Yes but 'one line summary' is not clear to me. Does it mean the summary
> > > line? Or the one line summary on one line regardless of commit message
> > > column wrapping? Sorry to be pedantic but I can see how this can be
> > > misunderstood.
> > 
> > Yeah "one line summary" is referring to the subject of the commit.
> > 
> > So it doesn't explicitly say not to split it across lines, it probably
> > should.
> > 
> > eg: ?
> 
> Yes, thanks!
> 
> > 
> > diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> > index 30dc00a364e8..12a283ba3929 100644
> > --- a/Documentation/process/submitting-patches.rst
> > +++ b/Documentation/process/submitting-patches.rst
> > @@ -186,6 +186,8 @@ If your patch fixes a bug in a specific commit, e.g. you found an issue using
> >  
> >         Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")
> >  
> > +To ease parsing of the 'Fixes:' tag please don't split it across multiple lines.
> > +
> >  The following ``git config`` settings can be used to add a pretty format for
> >  outputting the above style in the ``git log`` or ``git show`` commands::
> >  
> > 
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> 
> Do you have a patch for checkpatch too? Maybe Joe can solve my problem.
> 

Joe posted a checkpatch diff in another thread: https://lore.kernel.org/lkml/40bfc40958fca6e2cc9b86101153aa0715fac4f7.camel@perches.com/

Nathan
