Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27509C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E157120824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIBBgdMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E157120824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeJYRAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:00:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43972 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeJYRAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 13:00:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id 30-v6so3503653plb.10;
        Thu, 25 Oct 2018 01:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=39nYOF2BQy0yd4uXdFMKKLMzHqQZprSRyGVyzypOxsE=;
        b=BIBBgdMwBHNEZWEqumOhFbMlhcJ1unyfUV77L6qqVdVjGw7HTNKy3UzQCDXps6midR
         REsd2wB/xYnC/Wqn5yFzPRnxsA2zPN8MvuaJE7w35Q451BWBk+QT3GKD6xN2jCuUb0EB
         nODBMnkqcRJATFLUQcuBERlxYuSbmnf3O6hAJzQBScsLEoHD1J8VzbYQfxhXjQpBefab
         3YNL6p/StrxY29DRdYLkicwJd8DqKECzKF6HY/SU+nVQ1+NXRl5rVB18zRmprIjqWN2b
         ntrMQzEnmdrgjkae+jDYh4L3jp2it7X7TSO0hfnffQsCRqkPnVyqhIWDp2sQzm1igWIw
         I0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=39nYOF2BQy0yd4uXdFMKKLMzHqQZprSRyGVyzypOxsE=;
        b=tnlKkl/wTCIO7P/RK6EfBszwt9vNGxU+LoT81mfLSZHSUtZA+uFO6wVMSZpFUO7B08
         A67FHa9M6k0PzFTAM0g9KY8a0785SzM8zrlA+Gef/vFcHED7PcWf+CFHuyBDCUOCmojn
         FwkNqOGQrCywLQtaiyMKsIPYp6IZwBFuF6kVBez2aqzrYiFYreksUG3DNRhkW1vpDzqF
         M+jqEHMLEzeWFLPzanFbVlb5xTnU754UXXft5rwDvapglvuzJA/ZvRRAc8R/tvMSlpL4
         +t+p5wWcjFDof43ysmBp6Z8jln8RFjXSr74WGkQXJ+/YgHFDWokUyjPulS7I3xyVJLYD
         Ro3Q==
X-Gm-Message-State: AGRZ1gLeVVHpHh0Tekq0qDgHtDPc5pP7KB5Je97yy5YYOnqJ0pDh8yzz
        3erkDzlX3MtWyUsxv1KkiE4=
X-Google-Smtp-Source: AJdET5dJUYByBy+KAEOJP+pNkcz/fYkPN5TuPZijT7F4YVNDRO4BfIsv2/gX0DAmsHvtApRTqEYQWg==
X-Received: by 2002:a17:902:148:: with SMTP id 66-v6mr614666plb.140.1540456112549;
        Thu, 25 Oct 2018 01:28:32 -0700 (PDT)
Received: from localhost ([175.223.22.26])
        by smtp.gmail.com with ESMTPSA id d143-v6sm1415856pfd.58.2018.10.25.01.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:28:31 -0700 (PDT)
Date:   Thu, 25 Oct 2018 17:28:27 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()
Message-ID: <20181025082827.GC20702@jagdpanzerIV>
References: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
 <20181024043425.GA8862@jagdpanzerIV>
 <20181025062800.GB4037@osiris>
 <20181025070543.GB20702@jagdpanzerIV>
 <20181025081108.GB26561@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025081108.GB26561@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/25/18 10:11), Heiko Carstens wrote:
> > s390 is the only architecture that is using own bust_spinlocks()
> > variant, while other arch-s seem to be OK with the common
> > implementation.
> > 
> > Heiko Carstens [1] said he would prefer s390 to use the common
> > bust_spinlocks() as well:
> >   I did some code archaeology and this function is unchanged since ~17
> >   years. When it was introduced it was close to identical to the x86
> >   variant. All other architectures use the common code variant in the
> >   meantime. So if we change this I'd prefer that we switch s390 to the
> >   common code variant as well. Right now I can't see a reason for not
> >   doing that
> > 
> > This patch removes s390 bust_spinlocks() and drops the weak attribute
> > from the common bust_spinlocks() version.
> > 
> > [1] lkml.kernel.org/r/20181025062800.GB4037@osiris
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > ---
> >  arch/s390/mm/fault.c | 24 ------------------------
> >  lib/bust_spinlocks.c |  6 +++---
> >  2 files changed, 3 insertions(+), 27 deletions(-)
> 
> I gave this some testing and forced panic/die in interrupt as well as
> process context with different consoles as well as single and multi
> cpu systems. Everything still seems to work.

That was quick ;) Thanks.

> So I'm applying this to our internal queue first. It will hit upstream
> latest in the next merge window if there aren't any issues found.

Sure; sounds like a plan.

	-ss
