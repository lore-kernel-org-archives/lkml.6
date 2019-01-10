Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C755C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129B221738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DbO1l3Gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfAJAkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:40:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40874 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfAJAkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:40:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so8790121edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BHUQDTnETOEjv40kYCAQYWIRcl3AM67mdb7HXkKNtfk=;
        b=DbO1l3Gh/5ZvT5YEqkgb8hnHuZJJmbcRqGXqIuZlr35QVJFlK+L8OgKupIkZPo4yPz
         hJPOIiCth9jYPL2z7pg8XioJLREq3DaHXtOvTMXt/EoezzYf+wlRNVNr6yI4cKP7Qgv8
         GyVSICs3sItEAzZHZgPeliFlVyq9GNXxJoy7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BHUQDTnETOEjv40kYCAQYWIRcl3AM67mdb7HXkKNtfk=;
        b=nexvB6QnT3IrzWAfvb+pUJGkfM1n+zqtJH0zUngNtpa1Vv7kZZN2BMAEvftusWCI59
         g9cqJ03d68B8OiGZylTkAdxDPATD9J2wluPYdI2wtu9YdJtvWtggh1hMzs8MUe+0IKkG
         ZuDYDucU3hyCQWPU/3nGg19tMw5MECGPQ2YeHbil0P67sdL9npB+VoB3tW0ukX+N4G4g
         Osws7YEj4YvYyB+78pF9NzOqWLhg9wwebY8QwMQyPsrVR4yxwppmVYodesylVBA8Awkl
         FWI0cc00WnjZYG182bzxkVCIrvW+lCSym84rD66o7WZD7EX6fObpj28zRqWIWttKBJ5t
         EMlg==
X-Gm-Message-State: AJcUuke6RHNI/qTlTojueuDbU+yLt4vmycAMKyfPqKsIarizbBhpvA8R
        xmXjH5+gkwCeLlWnIxGmT702gw==
X-Google-Smtp-Source: ALg8bN75S+/h5JlpuiDpbHWh1prLYVIFc+vtYUJdBjNL1RxczXJtPoNuSmw8TXOlrrDtA7dgJiIx3g==
X-Received: by 2002:a17:906:681a:: with SMTP id k26-v6mr6907049ejr.62.1547080800290;
        Wed, 09 Jan 2019 16:40:00 -0800 (PST)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id s36sm1603194edb.43.2019.01.09.16.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:39:59 -0800 (PST)
Date:   Thu, 10 Jan 2019 01:39:52 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        willy@infradead.org
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Message-ID: <20190110003952.GA4354@andrea>
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109231852.GA4494@andrea>
 <20190109234043.GD1215@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109234043.GD1215@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 03:40:43PM -0800, Paul E. McKenney wrote:
> On Thu, Jan 10, 2019 at 12:18:53AM +0100, Andrea Parri wrote:
> > On Wed, Jan 09, 2019 at 01:07:06PM -0800, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > This series contains updates for the Linux-kernel memory model:
> > > 
> > > 1-3.	Add SRCU support, courtesy of Alan Stern.
> > > 
> > > 4.	Update README for adding of SRCU support.
> > > 
> > > 5.	Update memory-barriers.txt on enforcing heavy ordering for
> > > 	port-I/O accesses, courtesy of Will Deacon.  This one needs
> > > 	an ack, preferably by someone from Intel.  Matthew Wilcox
> > > 	posted some feedback from an Intel manual here, which might
> > > 	be considered to be a close substitute, but...  ;-)
> > > 
> > > 	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org
> > > 
> > > 6.	Update Documentation/explanation.txt to include SRCU support,
> > > 	courtesy of Alan Stern.
> > > 
> > > 7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
> > > 	Luc Maranget.  This needs an ack.
> > 
> > It seems that
> > 
> >   1b52d0186177 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
> >   
> > from linux-rcu/dev got lost; this also needs an ack (probably yours! ;D,
> > considered that, IIRC, you introduced the primitive and RCU is currently
> > its only user.)
> 
> That commit is in -tip:
> 
> 4607abbcf464 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
> 
> So it has already left my -rcu tree.  ;-)

Oh, you're right: now I see the commit (e.g., with "git show"), but I
don't see the corresponding changes applied to the tree.

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=locking/core&id=4607abbcf464ea2be14da444215d05c73025cf6e
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/memory-model/linux-kernel.bell?h=locking/core

Is this expected?

  Andrea


> 
> 							Thanx, Paul
> 
