Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1214C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3473206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="f9OvUK8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfAIML7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:11:59 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:43023 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfAIML6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:11:58 -0500
Received: by mail-ed1-f44.google.com with SMTP id f9so7085399eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 04:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zh065povyQAeoMy86V27ZeQHdVdeO/EHKsM07wvSpjo=;
        b=f9OvUK8WA2u4QE1Gp4Vj/e90TiXuxfsszjocsu7HC+s+KYCC+X7hYZFATMwapePDAH
         NH6rQzg6Cs77hJ/y6kmkakMKSqzIBuo/czNNJG80B8LC4rX3WNNT511LYDrNv0yMiDqw
         46C1LlSVvM01T6dMCrPREu46yphRi6eL/cQUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zh065povyQAeoMy86V27ZeQHdVdeO/EHKsM07wvSpjo=;
        b=S9zjTd49NkfoEybZ1cl/HfE70vA6LrikQC/xLMAntu3iQKNqeljMMaICR+ofTB748W
         NdWJAq22BGyNXuq470WZoyN5P3Q/SX1uNhWc5cO75avRLfwih9SU6yOgOg5q1qCuuNoj
         ZpAvDvTPz6KHtoMARJahNv7fAOWsjJl4wxoS7Pdwme+t6QiTirWXy2SOiO4Aycf/ZvSz
         rW0/77hJ01bkL4glFaRhDkd85eOuaOjuzQRKx8KVejSaVDnS8MP4ytSAL5gksqlu0nxR
         JkybC1+AXxo0uRwVrWYIcj0ylAw8hZMVQt3ZTu998kH+LcTaXHLjyqyXjCWXfD5rYQSl
         KlmA==
X-Gm-Message-State: AJcUukdg1ncj1VjF040W62IJFW6iNnPpbQiAS6N6FQz3udHGsk2/UZP8
        5iC5HKh90vnELCMTQTwpFbnizA==
X-Google-Smtp-Source: ALg8bN40h1O/G0SI65X69hBqGhrykJQgjtaPQfZLTcKltWMvnCU2b5NNnbaOAqnOHXoWW38PIdFd4Q==
X-Received: by 2002:a50:f19b:: with SMTP id x27mr5855016edl.140.1547035916711;
        Wed, 09 Jan 2019 04:11:56 -0800 (PST)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id l51sm1034651edb.36.2019.01.09.04.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 04:11:55 -0800 (PST)
Date:   Wed, 9 Jan 2019 13:11:26 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Anatol Pomozov <anatol.pomozov@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Paul McKenney <paulmck@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Luc Maranget <luc.maranget@inria.fr>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190109121126.GA7141@andrea>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190109000214.GA5907@andrea>
 <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
 <20190109112432.GA6351@andrea>
 <CACT4Y+YAr1XuwAy1qRL678VHZjzsbAQ05o1zoN9ZfC0muYzK8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YAr1XuwAy1qRL678VHZjzsbAQ05o1zoN9ZfC0muYzK8g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:55:27PM +0100, Dmitry Vyukov wrote:
> On Wed, Jan 9, 2019 at 12:24 PM Andrea Parri
> <andrea.parri@amarulasolutions.com> wrote:
> >
> > On Tue, Jan 08, 2019 at 04:36:46PM -0800, Anatol Pomozov wrote:
> > > Hello
> > >
> > > On Tue, Jan 8, 2019 at 4:02 PM Andrea Parri
> > > <andrea.parri@amarulasolutions.com> wrote:
> > > >
> > > > Hi Anatol,
> > > >
> > > > On Tue, Jan 08, 2019 at 11:33:39AM -0800, Anatol Pomozov wrote:
> > > > > Hello folks,
> > > > >
> > > > > A bit of context what I am doing. I am trying to port KTSAN (Kernel
> > > > > Thread Sanitizer) tool to v4.20. That tool tracks shared data usage
> > > > > and makes sure it is accessed in a thread-safe manner.
> > > >
> > > > Interesting!  FYI, some LKMM's maintainers (Paul included) had and
> > > > continued to have some "fun" discussing topics related to "thread-
> > > > safe memory accesses": I'm sure that they'll be very interested in
> > > > such work of yours and eager to discuss your results.
> > >
> > > Thread Sanitizer is a great tool to find thread-safety issues with
> > > user-space code. The tool been developed by a team of smart people
> > > from Google [1].
> > >
> > > KTSAN is an attempt to bring the same ideas to Linux kernel [2]. A
> > > bunch of work been done there but the project is still at
> > > proof-of-concept point.
> >
> > Yes, I have been aware of these tools since at least  ;-)
> >
> >   https://groups.google.com/forum/#!msg/ktsan/bVZ1c6H2NE0/Dxrw55bfBAAJ
> >
> >
> > >
> > > I am not a part of Google's dynamic tools team. But I've decided to
> > > pick something to do during the New Year holidays so started porting
> > > KTSAN from v4.2 to v4.20. The work is "almost completed" but I need to
> > > fix a few crashes [3].
> >
> > I guess my first reaction would remain
> >
> >   "it's kind of hard (to use an euphemism) to review 7,582 additions
> >   or so for a data race detector without a clear/an accepted (by the
> >   community) notion of data race..."
> 
> Tsan's notion of a data race is basically the C/C++'s notion:
> concurrent/unsynchronized non-atomic access in different threads at
> least one of which is a write.

Yeah, I think that this notion needs to be detailed, discussed,
documented, and discussed again. ;-)


> Tremendous (for such a project) benefits of automatic data race
> detection is a good motivation to finally agree on and accept a
> practically useful notion of a data race.

Agreed.

  Andrea
