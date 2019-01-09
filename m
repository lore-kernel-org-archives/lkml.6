Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E251CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAB72075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="abLOYt4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfAIXTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:19:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34340 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfAIXTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:19:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so8758301ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 15:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=08MFwLPmKfpU/cYgkbRH3qQMn7M2zBV4aixFJ7ms3Jo=;
        b=abLOYt4mb+JuDGevOHPDyqp9iQHFmNdkmZWNbov5wtVqg5VAX/ZUU6IRuCMhnG5PeO
         sZzPB8OtISQNX85K0clLhRt3Q9uWkQmfcdB8sbsRoIkV5mGbazPCK+jUiG/+mTBdqzGa
         XFMkwyc+e3rET+OOrBe1Ppg+SIOM3AdFueX+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=08MFwLPmKfpU/cYgkbRH3qQMn7M2zBV4aixFJ7ms3Jo=;
        b=XdTZ7YbXb9Jejj3SfGt2bz9g581vE1Qpp8sSd8cTNcy+ErByc3dhOSf7mkII64IQjS
         fkQ2o7a4b+1TOyCtPHzr/PBxNcJX6udWgGScTXkHR2qocf8kLEGdIo1LskSawKYoPT7V
         NHkPh3N7LTZgQAHvBgpw9juYn3BPQTUN3ta4sfBZaxNdzkDZFdWoob/ETPeM/G+Y2luR
         kQSScW13ltqYCssKvpWm4YiH0VGDfPkJad3Qvd+KNpAx1dEzovWer8/Fh2by48T2iDH/
         jXYLwx+NnokkXqpBFuRY6oj2uROJWQYP9ctyKwKlrLd0dnJSDTGHapKnUE0vo7NknnhH
         fYCg==
X-Gm-Message-State: AJcUukf6BlSLdpGlq6TYeXBMqCkFitZ+P4lt1jNouVklzYrXlXZxNOG6
        +USuYugR491LWSbl/FHUO1uz5Q==
X-Google-Smtp-Source: ALg8bN70WUD6tS0t6UbBvr+W4cAfPIwRRG3Yv6sQ29NafE/e7MJxnULFgJYGjIbK/BrlbqlWpGjMuw==
X-Received: by 2002:a50:9849:: with SMTP id h9mr7272434edb.36.1547075940246;
        Wed, 09 Jan 2019 15:19:00 -0800 (PST)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id cd6-v6sm996559ejb.14.2019.01.09.15.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 15:18:59 -0800 (PST)
Date:   Thu, 10 Jan 2019 00:18:53 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        willy@infradead.org
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Message-ID: <20190109231852.GA4494@andrea>
References: <20190109210706.GA27268@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:07:06PM -0800, Paul E. McKenney wrote:
> Hello!
> 
> This series contains updates for the Linux-kernel memory model:
> 
> 1-3.	Add SRCU support, courtesy of Alan Stern.
> 
> 4.	Update README for adding of SRCU support.
> 
> 5.	Update memory-barriers.txt on enforcing heavy ordering for
> 	port-I/O accesses, courtesy of Will Deacon.  This one needs
> 	an ack, preferably by someone from Intel.  Matthew Wilcox
> 	posted some feedback from an Intel manual here, which might
> 	be considered to be a close substitute, but...  ;-)
> 
> 	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org
> 
> 6.	Update Documentation/explanation.txt to include SRCU support,
> 	courtesy of Alan Stern.
> 
> 7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
> 	Luc Maranget.  This needs an ack.

It seems that

  1b52d0186177 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
  
from linux-rcu/dev got lost; this also needs an ack (probably yours! ;D,
considered that, IIRC, you introduced the primitive and RCU is currently
its only user.)

  Andrea


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  Documentation/memory-barriers.txt                |    6 
>  tools/memory-model/Documentation/explanation.txt |  289 ++++++++++++-----------
>  tools/memory-model/README                        |   25 +
>  tools/memory-model/linux-kernel.bell             |   37 ++
>  tools/memory-model/linux-kernel.cat              |   55 ++--
>  tools/memory-model/linux-kernel.def              |    7 
>  6 files changed, 250 insertions(+), 169 deletions(-)
> 
