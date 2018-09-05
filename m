Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B02EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7BE20867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B0kTOX4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7BE20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIETb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:31:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32882 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIETb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:31:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id d8-v6so6372106edv.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fl5YC/uL2Ga3BlbxdZDqOXCIXV2JwtzS25+9X5Csy6E=;
        b=B0kTOX4WC1fHj32kBIjYMXDm48kt2+Rjx79ZY/oPD5l94PZusj4wTzPpjWTyOvYok+
         DZpAht0MjqeSPbOIGcMytEeDOHs5cGlh8PrxY6FmdBKfzyku9PoKu0mfp3GmPbgjWVz5
         Wt/69um0oP9y0qP2vOihyr0XrovwMc/pwTzSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fl5YC/uL2Ga3BlbxdZDqOXCIXV2JwtzS25+9X5Csy6E=;
        b=GxgL9wGCXaYCfAbrL5BeHOOYrqZ3xbdyLtW6logWcy1wuJaRMv8hXq3is3FjsbDrnC
         CkjXYtc6jE0roVmSSZDBltQh8Q6AXP01YHMbLVfrILELtWg7j/YasIFUtkQ085opt9ny
         QuvDsdIhaasUvOV+xxN+lhDhZjbMtNXIvY9ci/BrOSJ7pcHHLFyrTmjPBlfjXkbiE20+
         bimmPpwtAq74Hz5Tg19jWJ2xLKylYLerdR5TbaESnpYgViJbKfpXMw90oW2GHb+4ncUC
         hRGPuv3D1F4dEfZ149G8WKWns1f6fKMzBWHfeyzInz9LHW4IDDZtsAHDpofGHWqTJJnl
         duUA==
X-Gm-Message-State: APzg51AKV9VviAVN0b2p1m6IpsUNY7HPnpwaLClJNd8hAdtuxXEscbi2
        mqCkzIQvYIE/CnmXADOFZUgLyQ==
X-Google-Smtp-Source: ANB0VdYyAOeYuizlICwalpaDGJmwR72XqKqBL8voncsMfdrtdfS7uxXE2zy4VUO/AR3r4HQeZkAYqQ==
X-Received: by 2002:a50:e185:: with SMTP id k5-v6mr36478111edl.195.1536159650329;
        Wed, 05 Sep 2018 08:00:50 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id n15-v6sm921528edn.44.2018.09.05.08.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 08:00:49 -0700 (PDT)
Date:   Wed, 5 Sep 2018 17:00:42 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180905150042.GA8820@andrea>
References: <20180904081144.GA4137@andrea>
 <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
 <20180905072151.GA3185@andrea>
 <50f0a7a7-0521-f833-34c3-132ce57dd777@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f0a7a7-0521-f833-34c3-132ce57dd777@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:33:08PM +0900, Akira Yokosawa wrote:
> On 2018/09/05 09:21:51 +0200, Andrea Parri wrote:
> > On Tue, Sep 04, 2018 at 03:09:49PM -0400, Alan Stern wrote:
> >> On Tue, 4 Sep 2018, Andrea Parri wrote:
> >>> Heh, your confusion might be the reflection of mine... ;-)  That was
> >>> indeed a long and not conclusive discussion (meaning there're pending
> >>> issues); and I cannot claim to find "arguments" such as:
> >>>
> >>>   "More than one kernel developer has expressed the opinion that
> >>>    the LKMM should enforce ordering of writes by locking."
> >>>
> >>> particularly helpful (I do tend to be convinced by arguments rather
> >>> than by opinions).  In fact, you can take the following as my only
> >>> current "constructive argument" against the patch [1,2]:
> >>>
> >>>   THE COMMIT MESSAGE IS RIDICULOUS; PLEASE EXPAND ON IT, AND DO
> >>>   SO BY LEVERAGING BOTH PROS AND CONS OF THE APPLIED CHANGES
> >>
> >> Do you have any concrete suggestions (i.e., some actual text) for 
> >> improvements to the patch description?  Earlier in your message you 
> >> mentioned that Will's comment:
> >>
> >> 	LKMM offers stronger guarantees that can portably be relied upon
> >> 	in the codebase.
> >>
> >> would make a good addition.  Suitably edited, it could be added to the
> >> description.  I can think of a few other things myself, but I'd like to 
> >> hear your thoughts.  Anything else?
> > 
> > Yes: I do sometimes have the impression that your "rules" for trimming
> > text in emails/replies are too aggressive...
> 
> Andrea, by saying "Yes:", do you mean you have something else to be added?

Indeed (examples in the trimmed text).


> I don't think you do, but want to make sure.
> 
> I'm a bit surprised to see all you wanted was the amendment of the
> commit log...

Well, I said that it was my only current constructive argument...

  Andrea


> 
>   Akira
> 
> > 
> >   Andrea
> > 
> > 
> >>
> >> Alan
> >>
> 
