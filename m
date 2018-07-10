Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E6AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35222089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="W8T5mnah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35222089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934261AbeGJPYZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:24:25 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35732 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933374AbeGJPYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:24:23 -0400
Received: by mail-wm0-f46.google.com with SMTP id v3-v6so21204033wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vTnG0SpBBAN+YEzPCAI8RQMGwfAvXUkJ2ZcGPhQJcjg=;
        b=W8T5mnaha8jUTM7zPH6AMF+dP3U92TsfW+/FnTPW3EUfDjgk+6OcTgJdNfPASYtwte
         9OoEnfM+2xWOdUe6n541bVFeuUhUPVFk8/W+Dq3UFPvG+6EHsbciDkOCcKA0BojNwqR6
         XXBh7YemuGxculFjit9lVv8ehRaagoHVDUF3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vTnG0SpBBAN+YEzPCAI8RQMGwfAvXUkJ2ZcGPhQJcjg=;
        b=W1G1QzYJuJR7uZV2DwnIvEycg0v9ooc1xTbB/5Mn2tdCvLqORWEMyvO/ne/IxBwE9t
         425Y/Qt733V4ahhwtalhoKLKAMLjc4UeU0S0kT1iBZuceF/XrgCNUiOt3f9tMgcg914A
         akzn7QGubSU5aAT+Yo8AQSEJAfNLwu8g2Y09ytUT+R4Hzku+AUcxJqe+xsm5zMeSwryL
         Z6psLfvkQx5lm9Fnr8kiEK1PBduFp1tswCXbAmiGomUhLeXhQ3zbbEIKteq1Gx5C4Ktr
         ddTvDRgqGsIlpk6A7EcdOjpukNvKzzaJsfADCotRKofz21S7fhGJr1TeAVXy48NE62vi
         Irfg==
X-Gm-Message-State: APt69E1z3sVonQlBtAR/TXlR0Tc/PBuqGHhuQyL0ZuxZwBpxCf76vJcz
        4eqT14d/esAXtHp7jFAZrNGWaw==
X-Google-Smtp-Source: AAOMgpdeoZaomDqglYB8THVjSmLvj+QS6c9ALf7kYDlI8bw9o/EOuY+Fx7p+1pUftxwcLdXvMUnlDA==
X-Received: by 2002:a1c:30d7:: with SMTP id w206-v6mr14263284wmw.153.1531236262715;
        Tue, 10 Jul 2018 08:24:22 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id w135-v6sm50404862wme.7.2018.07.10.08.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:24:22 -0700 (PDT)
Date:   Tue, 10 Jul 2018 17:24:04 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180710152404.GA11437@andrea>
References: <20180710093821.GA5414@andrea>
 <Pine.LNX.4.44L0.1807101039310.1449-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807101039310.1449-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >   ACQUIRE operations include LOCK operations and both smp_load_acquire()
> >   and smp_cond_acquire() operations.  [BTW, the latter was replaced by
> >   smp_cond_load_acquire() in 1f03e8d2919270 ...]
> > 
> >   RELEASE operations include UNLOCK operations and smp_store_release()
> >   operations. [...]
> > 
> >   [...] after an ACQUIRE on a given variable, all memory accesses
> >   preceding any prior RELEASE on that same variable are guaranteed
> >   to be visible.
> 
> As far as I can see, these statements remain valid.

Interesting; ;-)  What does these statement tells you ;-)  when applied
to a: and b: below?

  a: WRITE_ONCE(x, 1); // "preceding any prior RELEASE..."
  smp_store_release(&s, 1);
  smp_load_acquire(&s);
  b: WRITE_ONCE(y, 1); // "after an ACQUIRE..."

  Andrea
