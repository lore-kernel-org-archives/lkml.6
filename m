Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC919C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F9120880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aEhSAnK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfBTNot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:44:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52137 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfBTNot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:44:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id n19so6673729wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 05:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1FaPtUN6X+te83Y4+p98tzajqlQXdAj23kTLzAX63ks=;
        b=aEhSAnK2erJmewTp6jhY5vt3e1otxe+TDSaednmw+wKbWFU6CSCseVZiUZStaT05wQ
         INjei/6byZ4kktPiXIQAMYJjO2Pg3VA3v8jYiym3ONacJ/wQmldLb6D6G3qk/mx7UG5l
         Ji5qzk28Ii4g2ZNN3ZcL9sNmc8C6QEi7J4/3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1FaPtUN6X+te83Y4+p98tzajqlQXdAj23kTLzAX63ks=;
        b=aOgbJ4TXHAvHJ8cpFJ4+wI7bU384OILUCcbx3GynlYnT4nn4oSO7LndKKb6BXV4qKM
         l+ALdMaLtLOAQLVh203y8DyiNYrHsKSnVNSqsfm36xZXSFFTlxTQhrEJhyN4XF7c2N35
         5U/3uQ7mLh5cgwSL8RevAkoyQFvkAQH1YKIk4igpylDVjq061/JKuhnmU/JPdYXmSW9y
         jYSOAhV97TKg9L0+uI1J31amkTgIOI6rABIMjpG46GCDaobQRqWdwASGAuu3WGMfRI8Y
         KPmoir2aHcSlIiol8Cy6vQ3s6I9fsu8minFjJX18fIdyJVAR6geU/qTOAeV0gUIXmcbX
         dHTw==
X-Gm-Message-State: AHQUAuZyVFYlrkZWYFrimTT3TJE2cKXS7MNscTdp70AtN3rcBXm5aRfx
        cyi95+ShxDam3vBtrrcOl2ZL4Q==
X-Google-Smtp-Source: AHgI3Ib+VhzbpsxEz7b0+CW/QnoGf5OfKkLgeRQbLFBmNobRfDSRT3DYWKeg/wV6buNd7DslpMop0Q==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr6823987wmj.120.1550670286974;
        Wed, 20 Feb 2019 05:44:46 -0800 (PST)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id f4sm13179422wrx.68.2019.02.20.05.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 05:44:45 -0800 (PST)
Date:   Wed, 20 Feb 2019 14:44:33 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Petr Mladek <pmladek@suse.com>, linuxppc-dev@ozlabs.org,
        akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        dyoung@redhat.com, sergey.senozhatsky@gmail.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190220134433.GA4932@andrea>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
 <20190211125035.GA1562@andrea>
 <20190211143859.dd2lkccxod3f2fwn@pathway.suse.cz>
 <20190219233925.GA5648@andrea>
 <87va1e7pw2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va1e7pw2.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> > > +		 * Order the stores above in vsnprintf() vs the store of the
> >> > > +		 * space below which joins the two strings. Note this doesn't
> >> > > +		 * make the code truly race free because there is no barrier on
> >> > > +		 * the read side. ie. Another CPU might load the uninitialised
> >> > > +		 * tail of the buffer first and then the space below (rather
> >> > > +		 * than the NULL that was there previously), and so print the
> >> > > +		 * uninitialised tail. But the whole string lives in BSS so in
> >> > > +		 * practice it should just see NULLs.
> >> > 
> >> > The comment doesn't say _why_ we need to order these stores: IOW, what
> >> > will or can go wrong without this order?  This isn't clear to me.
> >> >
> >> > Another good practice when adding smp_*-constructs (as discussed, e.g.,
> >> > at KS'18) is to indicate the matching construct/synch. mechanism.
> >> 
> >> Yes, one barrier without a counter-part is suspicious.
> >
> > As is this silence...,
> >
> > Michael, what happened to this patch? did you submit a new version?
> 
> No, I'm just busy, it's the merge window next week :)

Got it.


> 
> I thought the comment was pretty clear, if the stores are observed out
> of order we might print the uninitialised tail.
> 
> And the barrier on the read side would need to be in printk somewhere,
> which is obviously unpleasant.

Indeed.


> 
> >> If the parallel access is really needed then we could define the
> >> current length as atomic_t and use:
> >> 
> >> 	+ atomic_cmpxchg() to reserve the space for the string
> >> 	+ %*s to limit the printed length
> >> 
> >> In the worst case, we would print an incomplete string.
> >> See below for a sample code.
> >
> > Seems worth exploring, IMO; but I'd like to first hear _clear about
> > the _intended semantics (before digging into alternatives)...
> 
> It is not my intention to support concurrent updates of the string. The
> idea is you setup the string early in boot.

Understood, thanks for the clarification.


> 
> The concern with a concurrent reader is simply that the string is dumped
> in the panic path, and you never really know when you're going to panic.
> Even if you only write to the string before doing SMP bringup you might
> still have another CPU go rogue and panic before then.
> 
> But I probably should have just not added the barrier, it's over
> paranoid and will almost certainly never matter in practice.

Oh, well, I can only echo you: if you don't care about the stores being
_observed_ out of order, you could simply remove the barrier; if you do
care, then you need "more paranoid" on the readers side.  ;-)

  Andrea


> 
> cheers
