Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3542CC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD502082B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OHMWrgdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD502082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeJaKHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:07:11 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:41665 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbeJaKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:07:10 -0400
Received: by mail-pg1-f180.google.com with SMTP id 23-v6so6520683pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 18:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L8oEbrXwT+LwEgQ0ra0KoaCtH9s/HD5fOw7mDgCTGIA=;
        b=OHMWrgdlgH5hH+fCJz216fLiZuS8lmTb21pfxQmwxqMKfo60UJ88JUJ0ZUY0QDsHfu
         02pkIrLYWKE2jQ30dtYlutfgC1TfcGcXoXJhWgrgQLO+Zdl8m/5Svpy30xJf9doKbll6
         aN2ANXlfgo004Ag9QaF0OXO65CdXNFNVeODgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L8oEbrXwT+LwEgQ0ra0KoaCtH9s/HD5fOw7mDgCTGIA=;
        b=mm/twUgA7Se6oIcyeY4ko0qA5VecwKPw2HxUhVWrwcIXcvm7nR7/ySqPc66oD4i0I0
         UyAOL8zjij7AS4p6w67zx1Rv11x0MPGfnSERBGcPMbkmkl7uetxL0c0MGcjLDiqjMKod
         8TgfmB9stg0PBO3WM+D9uLHyay2GaDICQ7SijXhNID8E+qEWhSeyiPqIbWqR2UPJMjpw
         HL7sfQc6iT+ra0b6Gyr17Ru/UAGZXqjVDh/H5CzEu9gFS+iOCZWCEaTcpXOZB1klFhOi
         PI1DxEmElh+fghmDrMYf3ZCGMk3e7KbvKI0w0ewX9Rm5Kw3zCmdekdFRCYJBSiVVcdv5
         QmBA==
X-Gm-Message-State: AGRZ1gLcTHvqb+5xFzbi9aYD/OZHQuaslKyU9NTeeZN8sbklVIxsFH0e
        nxMvNcSvwIeBeLy7N4hjjIg/v3iiGeo=
X-Google-Smtp-Source: AJdET5dVZ19WnVoZFboaob+YTi90A6/c4137nEgz0MJ+0QrQFmhEBAp/mBWf9qFBKfKi0J45b0yBLQ==
X-Received: by 2002:a65:638a:: with SMTP id h10-v6mr1048490pgv.136.1540948281715;
        Tue, 30 Oct 2018 18:11:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id d2-v6sm44879994pfj.122.2018.10.30.18.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 18:11:20 -0700 (PDT)
Date:   Tue, 30 Oct 2018 18:11:19 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] doc: rcu: remove note on smp_mb during synchronize_rcu
Message-ID: <20181031011119.GF224709@google.com>
References: <20181028043046.198403-1-joel@joelfernandes.org>
 <20181030222649.GA105735@joelaf.mtv.corp.google.com>
 <20181030234336.GW4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030234336.GW4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Oct 30, 2018 at 04:43:36PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 30, 2018 at 03:26:49PM -0700, Joel Fernandes wrote:
> > Hi Paul,
> > 
> > On Sat, Oct 27, 2018 at 09:30:46PM -0700, Joel Fernandes (Google) wrote:
> > > As per this thread [1], it seems this smp_mb isn't needed anymore:
> > > "So the smp_mb() that I was trying to add doesn't need to be there."
> > > 
> > > So let us remove this part from the memory ordering documentation.
> > > 
> > > [1] https://lkml.org/lkml/2017/10/6/707
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > I was just checking about this patch. Do you feel it is correct to remove
> > this part from the docs? Are you satisified that a barrier isn't needed there
> > now? Or did I miss something?
> 
> Apologies, it got lost in the shuffle.  I have now applied it with a
> bit of rework to the commit log, thank you!

No worries, thanks for taking it!

Just wanted to update you on my progress reading/correcting the docs. The
'Memory Ordering' is taking a bit of time so I paused that and I'm focusing
on finishing all the other low hanging fruit. This activity is mostly during
night hours after the baby is asleep but some times I also manage to sneak it
into the day job ;-)

BTW I do want to discuss about this smp_mb patch above with you at LPC if you
had time, even though we are removing it from the documentation. I thought
about it a few times, and I was not able to fully appreciate the need for the
barrier (that is even assuming that complete() etc did not do the right
thing).  Specifically I was wondering same thing Peter said in the above
thread I think that - if that rcu_read_unlock() triggered all the spin
locking up the tree of nodes, then why is that locking not sufficient to
prevent reads from the read-side section from bleeding out? That would
prevent the reader that just unlocked from seeing anything that happens
_after_ the synchronize_rcu.

Also about GP memory ordering and RCU-tree-locking, I think you mentioned to
me that the RCU reader-sections are virtually extended both forward and
backward and whereever it ends, those paths do heavy-weight synchronization
that should be sufficient to prevent memory ordering issues (such as those
you mentioned in the Requierments document). That is exactly why we don't
need explicit barriers during rcu_read_unlock. If I recall I asked you why
those are not needed. So that answer made sense, but then now on going
through the 'Memory Ordering' document, I see that you mentioned there is
reliance on the locking. Is that reliance on locking necessary to maintain
ordering then?

Or did I miss the points completely? :(

----------------------
TODO list of the index file marking which ones I have finished perusing:

arrayRCU.txt			DONE
checklist.txt			DONE
listRCU.txt			DONE
lockdep.txt			DONE
lockdep-splat.txt		DONE
NMI-RCU.txt
rcu_dereference.txt
rcubarrier.txt
rculist_nulls.txt
rcuref.txt
rcu.txt
RTFP.txt			DONE
stallwarn.txt			DONE
torture.txt
UP.txt
whatisRCU.txt			DONE

Design
 - Data-Structures		DONE
 - Requirements			DONE
 - Expedited-Grace-Periods
 - Memory Ordering		next

