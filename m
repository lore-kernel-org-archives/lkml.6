Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0259DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C9520989
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bH+Bktrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C9520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeK0Hjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:39:43 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:38142 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeK0Hjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:39:42 -0500
Received: by mail-ed1-f46.google.com with SMTP id h50so17087901ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 12:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l0G64M9uGC+sdYGFFFBET6aKINgx/kW68vHvhaCG9MQ=;
        b=bH+BktrqLaQ9khcspWq8dKtzHm+Q8rbNmfjrK4tL/zmjtU7TyIosaeaT6m+5Nh2KlU
         m931PnZptf1TG5WoFGOO+6533Pfm0IfFLkUBg1+ztD/ftnpgQPgZ6fOJjA4ZC8yF48j/
         iz1iMhmxeqt+Q+BhJREjJMwj4VZzQlVC7WkXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l0G64M9uGC+sdYGFFFBET6aKINgx/kW68vHvhaCG9MQ=;
        b=IinWClEPscNl/m1mkeGgerIT8MOrD4FZ6eARrSud8teVesEJ9FQ5uQV4jBnmAeL+Oe
         Upx6phSIPx1dJfB/X9ZzfMT3hutjZJr6Cq4FnxKP6jEM+vIAffLnVynyULfhUh+sLw26
         wpaLPqvYfpdZH9txDXJzvZAAU+k7BpOXJBQC4EUIxnMbcT9BqrqMIEud7UDApZQxUF1W
         xa7Ew2oG+Mi2cGW94loOt08vFg8PnFEu2cOw60QJKyw2rSNMP/4EMWh5GQJJJ2QQ1lHK
         PptEMadRGF3Qn5HiKCfTlMoggBHZUI4wBkYDM7XhJoEA1sVplO8SqiROCW1llL/1hiuO
         DYVw==
X-Gm-Message-State: AA+aEWahJd9gdGbm/T3iKoI6f4tufHD0QXWdiptFpUCuZ+J/VzlQdZx8
        EAjg77fyzRIycwRXgfzNxntzHg==
X-Google-Smtp-Source: AFSGD/X4uX1nOLasIIl28vTVmY9IlGQHdlniF44MTrSorpXnDAixi7yRLYn3Tv5KwQeHayD2CHzOcQ==
X-Received: by 2002:a50:880d:: with SMTP id b13mr23726017edb.68.1543265061510;
        Mon, 26 Nov 2018 12:44:21 -0800 (PST)
Received: from andrea (dynamic-2a00-1028-8386-da8a-eacb-c188-78b9-634c.ipv6.broadband.iol.cz. [2a00:1028:8386:da8a:eacb:c188:78b9:634c])
        by smtp.gmail.com with ESMTPSA id c30sm418711edc.70.2018.11.26.12.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 12:44:20 -0800 (PST)
Date:   Mon, 26 Nov 2018 21:44:14 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Question] atomic_fetch_andnot() in nohz_idle_balance()
Message-ID: <20181126204414.GA4643@andrea>
References: <20181121223453.GA4016@andrea>
 <20181126093051.GV2131@hirez.programming.kicks-ass.net>
 <CAKfTPtDm49JS7thuUn0--ocqpn2Du4qi8qsUeeHzGrAG_F2epw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDm49JS7thuUn0--ocqpn2Du4qi8qsUeeHzGrAG_F2epw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:37:00PM +0100, Vincent Guittot wrote:
> On Mon, 26 Nov 2018 at 10:30, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Nov 21, 2018 at 11:34:53PM +0100, Andrea Parri wrote:
> > > Hi,
> > >
> > > The comment for the atomic_fetch_andnot() in nohz_idle_balance() says:
> > >
> > >   "barrier, pairs with nohz_balance_enter_idle(), ensures ..."
> > >
> > > which, well, does sound a note of warning... ;-)
> > >
> > > I see that nohz_balance_enter_idle() has an smp_mb__after_atomic() but
> > > the comment for the latter suggests that this barrier is pairing with
> > > the smp_mb() in _nohz_idle_balance().
> > >
> > > So, what is the intended pairing barrier for the atomic_fetch_andnot()?
> > > what (which memory accesses) do you want "to order" here?
> >
> > I can't seem to make sense of that comment either; the best I can come
> > up with is that it would order the prior NOHZ_KICK_MASK load vs us then
> > changing it.
> >
> > But that would order against kick_ilb(), not enter_idle.
> >
> > Vincent?
> 
> I can't come with a good explanation.
> After looking into my email archive, the only explanation that i have
> is that the comments remains from a previous iteration of the feature
> that was based on a nohz.stats_state mechanism

I'm afraid I still can't help your comment...  put in other terms, would
you feel "unconfortable" with _relax()ing the andnot()?  (and if so ...)

  Andrea
