Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE2BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5B321502
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="vnz0POuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5B321502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeIQPqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:46:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41995 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeIQPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:46:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id e11-v6so1488312lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m7MAok2CBuFVicuzTHSXJHysUHJmU8cEVDBtH07ivqc=;
        b=vnz0POuqQKoyWTwHWOhUVPOSPqBVtV3j1B0pG3B88AkAVnUG9oaxB0u37C3rBnug9Z
         EEq5PDbBuzGS/CA9ypHdl0KVMQ1oHLjnKZ95BI0f5GH25AvXyXcbYcj538W2M7iVBn2r
         fbggTGKJTROgum8Yf6aKM15WN5eDXwE+5NS20eMTA0o4qMj5+dyP4h9UoV93YyrR0xs4
         X4xIRJuFbWno09grw7Yu8RYq+nkyphaulBy7fzZGYbr90wrg4Xm4f2TRY+XVRc53kz0C
         jhVu8T7xK1bkEKTuyZ8aPV1WigtqFAObrEbv1mCwpeZ9hMX3mVWNXkBzVgbKsw2/HWkS
         L0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m7MAok2CBuFVicuzTHSXJHysUHJmU8cEVDBtH07ivqc=;
        b=LINMAIIJqoP/KLqDmLWhGKQHCtqpRIUq5KrFiM0M+qhC/0SNCR1UirQD7YvHHCnJ/0
         b1hPvXWWnIJemfn8OFzB49Iq/ssJMeSWHkvS4SSps+b0nxVnhvtV4FF+0NJuSQOEj1Ql
         pOZ9eDEqTz2bjupv8K0zAZPpT+WbiXLiFCW1ZC+JnYa4S8aNgIGr/lt/wMfh3okXvWUb
         Zow1+QyRYzG8kzTgU7STTHQaXNuzcFR2KeeFHJb/WhZTyrJlumfPQeukyNQXILKN0RTc
         QpT2bZqTvZ66I/z1cJPCJqka3bDOBIUB4WEjmxdT3ZFyUPqlDw2pLwOTZQ3ES+WMgC/0
         nf0Q==
X-Gm-Message-State: APzg51CIeAjMr4NvRvOSwIdX61eqz6/bVxRtQaZ+6cK/mO06KdRZUGwG
        VFgRatF7SLEl+KhpLXlHF5V/Yg7ncLYONiUB
X-Google-Smtp-Source: ANB0Vdbp84/coEl7v3LaeTNyLmOqeyjR+NRzK5qPOYSqQ2fkc/pnLl8Llh9hUIGwT1xMovC3COGK9w==
X-Received: by 2002:a19:8d45:: with SMTP id p66-v6mr15220411lfd.44.1537179593681;
        Mon, 17 Sep 2018 03:19:53 -0700 (PDT)
Received: from cisco (penitent.factor.volia.net. [93.74.255.199])
        by smtp.gmail.com with ESMTPSA id u191-v6sm2799404lja.13.2018.09.17.03.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 03:19:52 -0700 (PDT)
Date:   Mon, 17 Sep 2018 04:19:50 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Julian Stecklina <jsteckli@amazon.de>
Cc:     Juerg Haefliger <juergh@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        deepa.srinivasan@oracle.com, Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        joao.m.martins@oracle.com, pradeep.vincent@oracle.com,
        Andi Kleen <ak@linux.intel.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        kanth.ghatraju@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Kees Cook <keescook@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
Message-ID: <20180917101950.GG4672@cisco>
References: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
 <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
 <ciirm8zhwyiqh4.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <ciirm8efdy916l.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <CADLDEKsxx=MSFu=4_4JLX1afUMr3GVjNxSQ-726NrbLn8KQaQg@mail.gmail.com>
 <ciirm8r2hs30kh.fsf@u54ee758033e858cfa736.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ciirm8r2hs30kh.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 12:01:02PM +0200, Julian Stecklina wrote:
> Juerg Haefliger <juergh@gmail.com> writes:
> 
> >> I've updated my XPFO branch[1] to make some of the debugging optional
> >> and also integrated the XPFO bookkeeping with struct page, instead of
> >> requiring CONFIG_PAGE_EXTENSION, which removes some checks in the hot
> >> path.
> >
> > FWIW, that was my original design but there was some resistance to
> > adding more to the page struct and page extension was suggested
> > instead.
> 
> From looking at both versions, I have to say that having the metadata in
> struct page makes the code easier to understand and removes some special
> cases and bookkeeping.
> 
> > I'm wondering how much performance we're loosing by having to split
> > hugepages. Any chance this can be quantified somehow? Maybe we can
> > have a pool of some sorts reserved for userpages and group allocations
> > so that we can track the XPFO state at the hugepage level instead of
> > at the 4k level to prevent/reduce page splitting. Not sure if that
> > causes issues or has any unwanted side effects though...
> 
> Optimizing the allocation/deallocation path might be worthwhile, because
> that's where most of the overhead goes. I haven't looked into how to do
> this yet. I'd appreciate if someone has pointers to code that tries to
> achieve similar functionality to get me started.
> 
> That being said, I'm wondering whether we have unrealistic expectations
> about the overhead here and whether it's worth turning this patch into
> something far more complicated. Opinions?

I think that implementing Dave Hansen's suggestions of not doing
flushes/other work on every map/unmap, but only when pages are added
to the various free lists will probably help out a lot. That's where I
got stuck last time when I was trying to do it, though :)

Cheers,

Tycho
