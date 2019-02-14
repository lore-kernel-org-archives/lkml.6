Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04591C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE4B21B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="zXoQYJGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503263AbfBNUxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:53:49 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43447 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395284AbfBNUxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:53:46 -0500
Received: by mail-yw1-f66.google.com with SMTP id u200so2866261ywu.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nq3kS1AhtC4YfUavpJUvV3F1g90XhP6yXjx2z1YEeRw=;
        b=zXoQYJGmlEutrnMtRSMXJIfZ3GPdihFFgxNuYwhHNAeztOd7HHY1ufLdrS3yTVYvWL
         tg5R4IbkYwPPE5GazMCCpvM9omvznAqZvsPcIYNpgJgJYOdY5DWvko2caqwTd7JXq/Ra
         TJbdElkjp151GJ5ebowG0Y52BiWo85n9StNfui7yIW837fue8H6uiPSMMB2Zt26qlgsV
         yDPvoxG5vUcN1laSmAeHiyZ5c+P2E4n5x0rYxKzNFuA0CNErPTzu8o/gVyN166+PeXp4
         9oBfHGHeEurikJVHgHNPMjUVprZKIz5t8MGd2vo4IQ55DL8GkTvtP0aR0Tp+PXPxXvWG
         CYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nq3kS1AhtC4YfUavpJUvV3F1g90XhP6yXjx2z1YEeRw=;
        b=g0gLZPCuWTL0Da7eUfjxKL8jvOSwgoBycagn4D0FSpzhAQ++AiDyVtAI1cKZkkp/5q
         Q5R/oX8ApVGQMxxJqEcuviZFE22VIg0siVAIZZeRdJDpVpxIyON3Xeg3RM5EiKcQ6nKo
         UzqL8R2Uox5NjGE4rBb4+80mB543TWzs10Dd5iXCNChtLAlG85W5mRdy1E23RSlq0Pf9
         rgbI+GSixUsKzLpxb1jlmK3/0EySb9nqMIOxLBned879U+z+L/xDTecWiXoaAenkmBxy
         6108dXPAN0kzQVFBzKRInMolNAOQ/DZT77XdsTfxgWWzgLeiQJVDrl8NXEaguWyr4xBL
         BBMQ==
X-Gm-Message-State: AHQUAuaHCWcpo0J/DkvJh2edf1fPylCK25JZ7KkvgNY3EOFpUL5wS4ts
        WEb/v6vxAXiKO52X/l5ItRHeRg==
X-Google-Smtp-Source: AHgI3IZ8fmrK7eYAabzpiKPfkZUY4i19xx17UceTONnpXgEr0xDfMbeQuCRklSaGWBKCrSALT3FxLg==
X-Received: by 2002:a81:ee07:: with SMTP id l7mr4999106ywm.489.1550177625008;
        Thu, 14 Feb 2019 12:53:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:80d4])
        by smtp.gmail.com with ESMTPSA id 10sm961572ywv.96.2019.02.14.12.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 12:53:44 -0800 (PST)
Date:   Thu, 14 Feb 2019 15:53:43 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?Q?=C5=81ukasz?= Siudut <lsiudut@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] psi: avoid divide-by-zero crash inside virtual machines
Message-ID: <20190214205343.GA17084@cmpxchg.org>
References: <20190214193157.15788-1-hannes@cmpxchg.org>
 <20190214115855.76869aecd777fbd37d48f45c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214115855.76869aecd777fbd37d48f45c@linux-foundation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:58:55AM -0800, Andrew Morton wrote:
> On Thu, 14 Feb 2019 14:31:57 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -322,7 +322,7 @@ static bool update_stats(struct psi_group *group)
> >  	expires = group->next_update;
> >  	if (now < expires)
> >  		goto out;
> > -	if (now - expires > psi_period)
> > +	if (now - expires >= psi_period)
> >  		missed_periods = div_u64(now - expires, psi_period);
> >  
> >  	/*
> 
> It seems appropriate to use time_after64() and friends in this code.

These timestamps are all sourced from sched_clock(), which is defined
to be monotonic and never wrap in practice. From the "sched_clock()"
section in Documentation/timers/timekeeping.txt:

	"This function shall return the number of nanoseconds since
	 the system was started."

	"The sched_clock() function may wrap only on unsigned long
	 long boundaries, i.e. after 64 bits. Since this is a
	 nanosecond value this will mean it wraps after circa 585
	 years. (For most practical systems this means "never".)"

As far as readability goes, I have to say I find the naked comparisons
a bit easier to understand (and I'm glad we can use those here since
the code is already complicated):

	if (now < expires)

vs.

	if (time_before64(now, expires))

These macros always have me double check the argument order.
