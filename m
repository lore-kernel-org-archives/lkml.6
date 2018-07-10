Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8C1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1CE208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gRhhUz9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1CE208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbeGJXdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:33:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50821 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbeGJXdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:33:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so628080wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iNeutKfwp0+t6kDugqM795uYwUQhAa2TuyC882m2ysg=;
        b=gRhhUz9AMr8mLFZ+R3W+/QGxesqvtURvYpaGhv96fpcAWejhsBHDITP/Lg7AvGkwnZ
         zg5lVF5Tj4f6H19lMqMpFUybydoPZ9Eyy1JiN9hLCE568cjlQwuqdjnQcrhqEoeMRS4a
         zYHJdOnHAgaNtIPAAMgWUdHy1DFV/tNqwNq6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iNeutKfwp0+t6kDugqM795uYwUQhAa2TuyC882m2ysg=;
        b=mT4Dr5pJtnzkdcjJRaqJrDG53dRJZeT3SEovWd1EVnn5+yQkinsu7K0XiAlGHlyxBJ
         fXQbkh9LOoKD01kfNx6qLXiRDD8zSdLoWeakpdDpmtZszUVmwAhnA1wNGHMpvjmSHpDu
         4dM4Ld3f/JiVH/HUaqeZiK+9+IW7wMnUsbyMgPex/hcs/Cz3Jw9yZnXb7KprEZju3p1S
         pcx1bXjnFq5PCVKEkCNajeeHMCrryR8qwbjNayK6AekRGKGgzLDqcEK7tAXgZiVhsI7F
         UZCi1ooRqMWO6DCJvJHXaWL+3pH8i5zp2xL1+6P31zpzKK+lCkyonILN79WtIstw/LK8
         M/QA==
X-Gm-Message-State: APt69E3BesjyNa3xE9m+5ET6yp5VkGvusev/yVORB7UXM55Y7MJCSkW1
        OEedv0XrgqzmhnjH3FIJautJ2g==
X-Google-Smtp-Source: AAOMgpdFOst+rptJs6n0e1qcoh40wSQJhMLU/pfxFKM+nONvuvC+ZC5Zsmi5LtigtC2zlPMjHCuXrw==
X-Received: by 2002:a1c:b609:: with SMTP id g9-v6mr14786476wmf.73.1531265519519;
        Tue, 10 Jul 2018 16:31:59 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id t6-v6sm1226581wrn.97.2018.07.10.16.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 16:31:58 -0700 (PDT)
Date:   Wed, 11 Jul 2018 01:31:52 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Daniel Lustig <dlustig@nvidia.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180710233152.GA11825@andrea>
References: <e8e62634-0b5b-faa9-ac43-557a59b16100@nvidia.com>
 <Pine.LNX.4.44L0.1807101315140.1449-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807101315140.1449-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 01:17:50PM -0400, Alan Stern wrote:
> On Tue, 10 Jul 2018, Daniel Lustig wrote:
> 
> > > --- usb-4.x.orig/tools/memory-model/linux-kernel.cat
> > > +++ usb-4.x/tools/memory-model/linux-kernel.cat
> > > @@ -38,7 +38,7 @@ let strong-fence = mb | gp
> > >  (* Release Acquire *)
> > >  let acq-po = [Acquire] ; po ; [M]
> > >  let po-rel = [M] ; po ; [Release]
> > > -let rfi-rel-acq = [Release] ; rfi ; [Acquire]
> > > +let unlock-rf-lock-po = [UL] ; rf ; [LKR] ; po
> > 
> > It feels slightly weird that unlock-rf-lock-po is asymmetrical.  And in
> > fact, I think the current RISC-V solution we've been discussing (namely,
> > putting a fence.tso instead of a fence rw,w in front of the release)
> > may not even technically respect that particular sequence.  The
> > fence.tso solution really enforces "po; [UL]; rf; [LKR]", right?
> > 
> > Does something like "po; [UL]; rf; [LKR]; po" fit in with the rest
> > of the model?  If so, maybe that solves the asymmetry and also
> > legalizes the approach of putting fence.tso in front?
> 
> That would work just as well.  For this version of the patch it 
> doesn't make any difference, because nothing that comes po-after the 
> LKR is able to directly read the value stored by the UL.

Consider:

C v2-versus-v3

{}

P0(spinlock_t *s, int *x)
{
	spin_lock(s);   /* A */
	spin_unlock(s);
	spin_lock(s);
	WRITE_ONCE(*x, 1); /* B */
	spin_unlock(s);
}

P1(spinlock_t *s, int *x)
{
	int r0;
	int r1;

	r0 = READ_ONCE(*x); /* C */
	smp_rmb();
	r1 = spin_is_locked(s); /* D */
}

With v3, it's allowed that C reads from B and D reads from (the LKW of) A;
this is not allowed with v2 (unless I mis-applied/mis-read v2).

  Andrea
