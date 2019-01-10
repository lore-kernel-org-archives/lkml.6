Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A2BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C662173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jYq2j6qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfAJXUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:20:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45099 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfAJXUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:20:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so11581331edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 15:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/aCo7WsJ8RqeGyyBXg9MQtpaZUgJK1C27CinquA8p+E=;
        b=jYq2j6qxQrKNqXJ6j6xhKi2FfYj/K0fVxPpYfLB9UtLdlM2oIcnbUKJr9df7us4cIN
         K20HduduP2mGGi33Cg26MCjX58v5C/sl4eGzGRwWThGWQpH9+hU6LCOy0DKJLAwjT98h
         ZrI5e8RRmOfSxLLu+DFPpbZ3iZzHlFTpesMYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/aCo7WsJ8RqeGyyBXg9MQtpaZUgJK1C27CinquA8p+E=;
        b=YUfS2RUHMbpv+hYuqTPYLygCpcw9WUKjvypghrmUK6LHVDEKfmrEtvLaKxayJGRUd9
         AZXldqov4mgnpnIQ/+cKGZnre8fj8iC5pPs0kbmKajtLEUwMeocu7zmdB6/SS5gftZIP
         k9j9lXacS+57o+U6kDIAmD5ZLaNCugWQ67y+AuKzP5jufrn1s4mfDREyUqwso3ybFc5s
         ntublJB5+BcjSUkGXT6flaKBTzMeDyAusoDwlJR6Hcjw/d+qv88wbeJ+K/7nWSzoy6OE
         sp4hGBXfwUW20fxMIVka940ES6VY8RzFGa0JCBfaBNOlJz8DlhwLzrBW+uPUQchx23L0
         +amA==
X-Gm-Message-State: AJcUukeD2CBbIWwlWiVZnH0NPNcTyUZTeDpieGdZnZzjaQLLvyMo7QqW
        OB98TiA13koCZIrB+dLfm4C0vg==
X-Google-Smtp-Source: ALg8bN5Zb9uMZSCQrBTJbcFF2CfPydRe2sb12jtc9Eo3PLC2CdihTSQpHUz5ZYQvLj9ggzh3R+PZzg==
X-Received: by 2002:a05:6402:1286:: with SMTP id w6mr11547107edv.53.1547162453067;
        Thu, 10 Jan 2019 15:20:53 -0800 (PST)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id c12sm1888336edi.52.2019.01.10.15.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 15:20:52 -0800 (PST)
Date:   Fri, 11 Jan 2019 00:20:45 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org
Subject: Re: [PATCH RFC LKMM 7/7] tools/memory-model: Dynamically check SRCU
 lock-to-unlock matching
Message-ID: <20190110232045.GA3908@andrea>
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109210748.29074-7-paulmck@linux.ibm.com>
 <20190110094131.GA11647@andrea>
 <20190110144049.GK1215@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110144049.GK1215@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm not all that exited about spreading version requirements in the
> > source: we report this requirement in our README, and apparently we
> > already struggle to keep this information up-to-date.  So what about
> > squashing something like the below (assume that 7.52 will be released
> > by the time this patch hit mainline; if this won't be the case, we
> > may consider using the development version 7.51+6)? notice that this
> > also removes an (obsolete, at this point) comment from lock.cat.
> 
> Sounds like a very good point to me!
> 
> Should have pointers in the various files to the README file?  Or maybe
> get people used to using scripting that checks versions?  Or maybe
> after answering questions for some time, people will get used to
> checking versions?

As discussed off-list: I have no strong opinion on this regard, well,
except that I think we ought to fix the README, somehow (consider my
diff below as a first proposal).  Akira actually preceded me on this
and suggested another solution [1].

  Andrea

[1] http://lkml.kernel.org/r/04d15c18-d210-e3da-01e2-483eff135cb7@gmail.com


> 
> 							Thanx, Paul
> 
> >   Andrea
> > 
> > diff --git a/tools/memory-model/README b/tools/memory-model/README
> > index 9d7d4f23503fd..b362a41358fa1 100644
> > --- a/tools/memory-model/README
> > +++ b/tools/memory-model/README
> > @@ -20,8 +20,8 @@ that litmus test to be exercised within the Linux kernel.
> >  REQUIREMENTS
> >  ============
> >  
> > -Version 7.49 of the "herd7" and "klitmus7" tools must be downloaded
> > -separately:
> > +Version 7.52 or higher of the "herd7" and "klitmus7" tools must be
> > +downloaded separately:
> >  
> >    https://github.com/herd/herdtools7
> >  
> > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > index 95bf45f1215fc..8dcb37835b613 100644
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -1,7 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >  (*
> > - * Requires herd version 7.51+6 or higher.
> > - *
> >   * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
> >   * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
> >   * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
> > diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
> > index 305ded17e7411..a059d1a6d8a29 100644
> > --- a/tools/memory-model/lock.cat
> > +++ b/tools/memory-model/lock.cat
> > @@ -6,9 +6,6 @@
> >  
> >  (*
> >   * Generate coherence orders and handle lock operations
> > - *
> > - * Warning: spin_is_locked() crashes herd7 versions strictly before 7.48.
> > - * spin_is_locked() is functional from herd7 version 7.49.
> >   *)
> >  
> >  include "cross.cat"
> > 
> > 
> > 
> > > + *
> > >   * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
> > >   * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
> > >   * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
> > > diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> > > index 1d6a120cde14..0c3f0ef486f4 100644
> > > --- a/tools/memory-model/linux-kernel.def
> > > +++ b/tools/memory-model/linux-kernel.def
> > > @@ -49,7 +49,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
> > >  
> > >  // SRCU
> > >  srcu_read_lock(X)  __srcu{srcu-lock}(X)
> > > -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X); }
> > > +srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> > >  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> > >  
> > >  // Atomic
> > > -- 
> > > 2.17.1
> > > 
> > 
> 
