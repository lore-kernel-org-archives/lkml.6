Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5sVbD+9WGVtWcwAAmS7hNA
	; Thu, 07 Jun 2018 16:09:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9DEA16074D; Thu,  7 Jun 2018 16:09:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OzHsAj8T"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 25D7F605A2;
	Thu,  7 Jun 2018 16:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25D7F605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964796AbeFGQJ2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:09:28 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43795 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935654AbeFGQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:09:12 -0400
Received: by mail-wr0-f195.google.com with SMTP id d2-v6so10417196wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRd+XZNBiL4kJav+xhAl2qbYnyToIwNx+iHLrSKX+00=;
        b=OzHsAj8ThqF2R90BCSy7tF5CLjZhr1B8sZ+lcWHw4VIyR7u23l2+cMlmvPS0iIG1RW
         cuy1ZrDEYBvp4iOJPuDn9Y5eyYKIpJy1Uy4ALo8n1GqVXoE01eFmFugPPx8T/BCi23sD
         PW7IwkPW2LOODERSR34v+9ai0ASZ/J0I5O3LDCzjOYN5Ce0yn4c41XmgbeFW/vXaJuoV
         KsLRm9f/hbuwHrrxW2O4beW7YW43+mhd7gJE1zPFagJ2CZFSaWfiJkoXBHbed21Az9CY
         Bku90dgjMSwmiHjtpMxZHUVUYPLc9FD4ZfTc6FLYF+7doz+X4dPXw5vX/jPn/wg4Lidm
         JNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRd+XZNBiL4kJav+xhAl2qbYnyToIwNx+iHLrSKX+00=;
        b=BiK27hvFc8wGV3AZD+1osIii4VCunY5hfWmvAFH6rSvYrwovDVKwGS6HExjM122oTI
         LI0BZX/pb05wDjcqHtap0peRVgNuqc35nLmaOHF/+IjNxMLmOKoaJWmH0xVWNzQsji7Y
         WN3LgaX9f+GUIRLNZ5XHd0F7/8bhers/YVYsZIFTidaC8DMgCfEOU/kzwRj74RKWD8Oa
         8CorByJvAIyue38x7TdhTR13LATUHSGxB017V2tLnUp6c5CdEYETZvMs+jCLiWn2HX0t
         3fBkz7FeVzc9udskk5Bxpt96sUpiQb1lgydLxbfHj3hRdU74817Crvx0okgd6zXBPWHm
         0K6w==
X-Gm-Message-State: APt69E0cKzvTe8mW06lbwxbR036LGu7PcWv8T6NJeXyGlzWIFSY5PLAI
        wc9X+ApSEr+UkYuQdr3U2K+W/mn2CGI5y+dppbXYgA==
X-Google-Smtp-Source: ADUXVKKqJO7HlxiS8rtTqR5Y9z9kSuvYARoIrLJUxR33mLR/tbOu5srVAcd0vHt5fzAYtNOEqHr9Q8emgCZtiOXVWtQ=
X-Received: by 2002:adf:a0ee:: with SMTP id n43-v6mr2329183wrn.23.1528387751069;
 Thu, 07 Jun 2018 09:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180606221513.11302-1-jolsa@kernel.org> <20180606221513.11302-2-jolsa@kernel.org>
 <20180606231902.GE7220@tassilo.jf.intel.com> <20180607062239.GA18436@krava>
In-Reply-To: <20180607062239.GA18436@krava>
From: Stephane Eranian <eranian@google.com>
Date: Thu, 7 Jun 2018 09:09:10 -0700
Message-ID: <CABPqkBRCZgPEpcc0SUvefoqAHh=-jTtBr=EgoomDCFTT54aJBg@mail.gmail.com>
Subject: Re: [PATCH 01/10] perf tools: Uniquify the event name if there's no
 other matched event
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Liang, Kan" <kan.liang@linux.intel.com>, agustinv@codeaurora.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>, frederic@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 11:22 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Jun 06, 2018 at 04:19:02PM -0700, Andi Kleen wrote:
> > On Thu, Jun 07, 2018 at 12:15:04AM +0200, Jiri Olsa wrote:
> > > Currently by default we try to match the user specified PMU
> > > name to all PMU units available and use them to aggregate
> > > all matched PMUs event counts into one 'pattern' event.
> > >
> > > While this is useful for uncore events, it screws up names
> > > for other events, where this is not desirable, like:
> > >
> > > Before:
> > >   # perf stat -e cp/cpu-cycles/ kill
> >
> > I assume you mean cpU/cpu-cycles/
> > >
> > >    Performance counter stats for 'kill':
> > >
> > >            1,573,757      cp/cpu-cycles/
> > >
> > > Keeping the pattern matching logic, but making the name unique
> > > in case there's no other match found. That fixes the example
> > > above and hopefully does not screw up anything else.
> > >
And the problem I have with this approach, is that you do not really
know what you are measuring.
You have not way of knowing that the count comes from multiple PMU instances:

perf stat -a -e uncore_cb/clockticks/ kill
0 uncore_cb/clockticks/

I think you need to report that this is aggregated from uncore_cbox_0
and uncore_cbox_1.
Otherwise it is not clear what I am monitoring. And you hope that what
you match in the regex
is related.
In my example should say:
0 uncore_cbox[0-1]/clockticks/

then it is clear what happened.

> > > After:
> > >   # perf stat -e cp/cpu-cycles/ kill
> > >
> > >    Performance counter stats for 'kill':
> > >
> > >            1,573,757      cpu/cpu-cycles/
> >
> >
> > The output is 100% identical?
>
> nope, the U is actualy missing.. that's the thing, the patern
> matching allows you to put 'cp' instead of 'cpu' and the final
> output is screwed.. also the metrics won't match the proper event
>
> jirka
