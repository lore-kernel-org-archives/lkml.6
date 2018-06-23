Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817DAC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC2624A66
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="inT8LaUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC2624A66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934525AbeFWBK2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:10:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45459 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933808AbeFWBK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:10:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id o12-v6so8233278wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 18:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eqZm4D8xxlz6zJVJ2EH3i2teTl1OR8IBzIBxrYSCvyc=;
        b=inT8LaUBm6FchZ/aicCdkotp4hLogD22ly9THMoWwZRRCiZwPFZymZRaYN9jQnmbPy
         aL9b6KeFU78BIWHLgfOxbdcin7feQMpd0m3+hxGf6yAsq0W+syjOeQUXImEshb7grDWc
         HtzdJMpv8N9dogqnnssqC+36fAFpZEnif6Q7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eqZm4D8xxlz6zJVJ2EH3i2teTl1OR8IBzIBxrYSCvyc=;
        b=sqZe24lUXmxIo+0tc0javx5wliQVKjd+LOdEvzbecw/+yxkO1bR2D5ze5KyvPzvQLZ
         3xNUeH4a+6kwK5riCbXZqb9SQp67X6peRKfI0Mx4Pvxh1l5Uyl8S99ENmDmALej24X7M
         iLNbIsDsEWZDbQEy0faTnMis++exTHoRsE+soY3Cb/0yIdQBQr/gq8NxUMoYedVqKZEj
         rafsfBbJ00fMXhHAPfPhP54lGSZFMVoJ8stgIPqm5f3CFf5mXKv71xiSvlKcslsbkev6
         7ejvyGXs8c69sxlEk/FLR5+mCvjPYvMM85UiaBHe8oueN9Ks+JIQdcqcxpN4e5M4VPOp
         1qbg==
X-Gm-Message-State: APt69E0zDOJqEb24WPSrNF2VFuVmKjsXuqEeE/EUMYY7p3V2hy2lfiBU
        CaIwHFBM1+pDO6UjcJU169bWNg==
X-Google-Smtp-Source: AAOMgpdRWyAxrPdCi4aHxbxi+3eSiTq48jOPYhse960KKIDFQ7EAKnk6WKeRwGC3gg98dG9KwxNzWQ==
X-Received: by 2002:adf:8e93:: with SMTP id q19-v6mr3403627wrb.79.1529716225324;
        Fri, 22 Jun 2018 18:10:25 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id w24-v6sm2272991wmc.15.2018.06.22.18.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 18:10:24 -0700 (PDT)
Date:   Sat, 23 Jun 2018 03:10:17 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>, stern@rowland.harvard.edu,
        Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Daniel Lustig as a LKMM reviewer
Message-ID: <20180623011017.GA3506@andrea>
References: <6b17610f-e54b-9c05-2f28-f4873eff3a4c@nvidia.com>
 <mhng-5248f5fe-5b7b-4210-b5e4-7d726c28fa0d@palmer-si-x1c4>
 <20180623002329.GZ3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623002329.GZ3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thanks.  Unless anyone has any opposition I'll submit the fixed
> > patch as part of my next pull request.
> 
> Works for me, especially if this means that Daniel is RISC-V's official
> representative.  ;-)

I'd rather the "fixed patch" go through the LKMM's tree.  If not for
other, we tend to use get_maintainer.pl on your (TBD ;/) development
branch...


> 
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> > commit 9d01337e4724be4d34bfe848a7c64d14bfdb89ea
> > gpg: Signature made Fri 22 Jun 2018 03:35:24 PM PDT
> > gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
> > gpg:                issuer "palmer@dabbelt.com"
> > gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
> > gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
> > Author: Palmer Dabbelt <palmer@sifive.com>
> > Date:   Fri Jun 22 14:04:42 2018 -0700
> > 
> >    MAINTAINERS: Add Daniel Lustig as a LKMM reviewer

Nit: an LKMM


> > 
> >    Dan runs the RISC-V memory model working group.  I've been forwarding
> >    him LKMM emails that end up in my inbox, but I'm far from an expert in
> >    this stuff.  He requested to be added as a reviewer, which seem sane to

Nit: which seems


> >    me as it'll take a human out of the loop.
> > 
> >    CC: Daniel Lustig <dlustig@nvidia.com>
> >    Acked-by: Daniel Lustig <dlustig@nvidia.com>
> >    Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Glad to read this!  Please feel free to add:

Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

  Andrea


> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9d5eeff51b5f..ac8ed55dbe9b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8316,6 +8316,7 @@ M:	Jade Alglave <j.alglave@ucl.ac.uk>
> > M:	Luc Maranget <luc.maranget@inria.fr>
> > M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > R:	Akira Yokosawa <akiyks@gmail.com>
> > +R:	Daniel Lustig <dlustig@nvidia.com>
> > L:	linux-kernel@vger.kernel.org
> > S:	Supported
> > T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
