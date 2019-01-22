Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34721C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720B320855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dxqLeUxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfAVPrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:47:55 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33244 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfAVPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:47:55 -0500
Received: by mail-ed1-f50.google.com with SMTP id p6so19740062eds.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 07:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lhZYksM32IlFxixTYjrl2i9XhZaAp6algMTzXFMI9Eo=;
        b=dxqLeUxASZfmHGOCc8ln7NwA3yWfuqW9Rb4AwNgkoUb+vnxnJhxxJzJtbPniOxEdiX
         xJJ755bkojqXl/bAcbGY6ydui++qfLVrmy3S3k30hyybTqyEuryBp6PnBfEzv1IN0jVE
         y0X03D0reMwsLy6ZbLPmsuMFTBXgMnCM+ulu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lhZYksM32IlFxixTYjrl2i9XhZaAp6algMTzXFMI9Eo=;
        b=ftbCjUZS9ISg0raFdWDXAw56DXdvoZlSQ5ykx/dA5T8tO6RVrSblwj1m83iGeMZYBM
         uLTAcG+NLLOEg6tNXs1UeDsC0XBE6LslHVJ9yMa1eSUQC2iZCuLI21VW4mWhlZ+43wvn
         TIcag4TXeyfhkTLwjd9CMiBh6rUSVTePGZIAQhIOcZQFoLNGEQhXPLCdb9N+d8P8AUEe
         JkFfKKEV27+hlkFNJSbh4hHQBYwQfliew2u/ujzCrOnTxrTb9yGAX19i5wnnREjftQ8Q
         hR3/sIPU0JyNqs9zlTK2fIWVKgKkZR510VJAfYeouiwFuS9sKVoZEV8pVEolj4hG0ZMA
         dQqw==
X-Gm-Message-State: AJcUukdX7WzGkhzNqvyNpDAS7hb56FZVeuJ8fXcTozdwdDY9pAqT9pMY
        4/YaEu9uhWWqsvd1TiOyYWa5pA==
X-Google-Smtp-Source: ALg8bN6bx/LILCOmKI5N6qL8GUebkBZtzYJhDdWnqWQJlDqJ18RlWVPu1Vw1yuRm+5nX0tokSYmuKw==
X-Received: by 2002:a50:8bc9:: with SMTP id n9mr31645388edn.41.1548172073180;
        Tue, 22 Jan 2019 07:47:53 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id d27-v6sm5291043eja.20.2019.01.22.07.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 07:47:52 -0800 (PST)
Date:   Tue, 22 Jan 2019 16:47:45 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Plain accesses and data races in the Linux Kernel Memory Model
Message-ID: <20190122154745.GA13659@andrea>
References: <Pine.LNX.4.44L0.1901141439480.1366-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901141439480.1366-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -131,7 +159,7 @@ let rec rcu-fence = rcu-gp | srcu-gp |
>  	(rcu-fence ; rcu-link ; rcu-fence)
>  
>  (* rb orders instructions just as pb does *)
> -let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb*
> +let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb* ; [marked]

Testing has revealed some subtle semantics changes for some RCU tests
_without_ unmarked memory accesses; an example is reported at the end
of this email.  I suspect that the improvements you mentioned in this
thread can restore the original semantics but I'm reporting this here
for further reference.

With the above definition of 'rb', we're losing links which originate
or target RCU fences, so that this definition is in fact a relaxation
w.r.t. the current semantics (even when limiting to marked accesses).
The test below, for example, is currently forbidden by the LKMM, but
it becomes allowed with this patch.

FWIW, I checked that including the RCU fences in 'marked' can restore
the original semantics of these tests; I'm still not sure whether this
change can make sense though....

Thoughts?

Oh, one last (and unrelated) nit before I forget: IIUC, we used to
upper-case set names, so I'd also suggest s/marked/Marked, s/plain/Plain
and similarly for the other sets to be introduced.

  Andrea


C sync-rcu-is-not-idempotent

{ }

P0(int *x, int *y)
{
	int r0;

	WRITE_ONCE(*x, 1);
	synchronize_rcu();
	synchronize_rcu();
	r0 = READ_ONCE(*y);
}


P1(int *y, int *z)
{
	int r0;

	rcu_read_lock();
	WRITE_ONCE(*y, 1);
	r0 = READ_ONCE(*z);
	rcu_read_unlock();
}


P2(int *z, int *x)
{
	int r0;

	rcu_read_lock();
	WRITE_ONCE(*z, 1);
	r0 = READ_ONCE(*x);
	rcu_read_unlock();
}

exists (0:r0=0 /\ 1:r0=0 /\ 2:r0=0)


>  
>  irreflexive rb as rcu
>  
