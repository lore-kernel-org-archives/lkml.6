Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1760902-1527581912-2-11970939509619048156
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527581912; b=WiWSndJMULy1N6cwhMNIvEo/CpWMFng3MCd4vY9XIcumkpR0b/
    S1Goc9M5SJgQL66eKQ2X6Wv1UDX+LcorZZVCfIVixuMxI2RPhpDDsGU92nHkiHSm
    KeEyF9JTmBPjBSndmhwmxwbYzzlRi6IQKmF0fwZwczHikP39A/nIsjpSO95lJhEb
    5qV8duMHBM5mcoT6rcjYzv1TJhugWbVf1kqc+60cVzMyTIsd6GRbLpTaHY7hNGmZ
    B/5PVeh5apf5ZvAHBM4mUyuvHv/GZrvrxsInl4/CKxsJMTurSWrN14lcTz4a/9m3
    HphG8nwctr8Jhn+1t8FweweuFNA56F5ETQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527581912; bh=Jxj+w0f01oe75cja+2FcY3XLWNSbqm
    7Vlwo0sfRA9yA=; b=BEm1dNj0G+UpZk1JFChQiS4/RVzB+n8RePvF4A/HcS2EsH
    yVbJ8QPpHn5pR7r/MYs98y15PJtt3ssy46/WM3K0Og5EW9k07ys/690vAerXXOgq
    9m1geEpCXG8JzskEWwvMTSvFDqmOnwfdKoAy7gSSOj4Zjrv7zD07NMQ9PYaY1Nng
    H1uKijKcWuluPjy5VGPqzhAkHAS3jmSgs2fVhDhy3U7SfXQnXa+xCt+CnFK+Ha6n
    af5NT9kLCx7/ltv77oDB21onh5VbJkozysVcONVZszjlwgUWtux5qp2GX9au1j6+
    cB/zxnf8ti/bAdIrGfCYmzaGGseRdekcgT76JlRA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH1jjJvEkB+JsQ3plWqzNRpTLrsFFIcYz0bj1EKBKS1dyhcrq5IvSKypOHDVDQSggKxD+RGFEzns9ErAnQRuzVTsOBZByOxPU7xmA/CaItNscq9vynjJ
    f2JglzHJnbq+m58j5kJYjM1XhIAd2XaxQY7i2NUC5oYwMIeAuBDmoH5FW+Wr83StCHIfaWgoxHmTz3i5JVCLimgsiNS8iN+WmmA8r5nH9bPNGk8NhPkyH5zh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=tHq3PoECSlNlaMTNcfIA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeE2IS3 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 04:18:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:45452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932072AbeE2IS0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 04:18:26 -0400
Date: Tue, 29 May 2018 10:18:23 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] doc: document scope NOFS, NOIO APIs
Message-ID: <20180529081823.GN27180@dhcp22.suse.cz>
References: <20180424183536.GF30619@thunk.org>
 <20180524114341.1101-1-mhocko@kernel.org>
 <20180524221715.GY10363@dastard>
 <20180525081624.GH11881@dhcp22.suse.cz>
 <20180527234854.GF23861@dastard>
 <20180528091923.GH1517@dhcp22.suse.cz>
 <20180528223205.GG23861@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528223205.GG23861@dastard>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 29-05-18 08:32:05, Dave Chinner wrote:
> On Mon, May 28, 2018 at 11:19:23AM +0200, Michal Hocko wrote:
> > On Mon 28-05-18 09:48:54, Dave Chinner wrote:
> > > On Fri, May 25, 2018 at 10:16:24AM +0200, Michal Hocko wrote:
> > > > On Fri 25-05-18 08:17:15, Dave Chinner wrote:
> > > > > On Thu, May 24, 2018 at 01:43:41PM +0200, Michal Hocko wrote:
> > > > [...]
> > > > > > +FS/IO code then simply calls the appropriate save function right at the
> > > > > > +layer where a lock taken from the reclaim context (e.g. shrinker) and
> > > > > > +the corresponding restore function when the lock is released. All that
> > > > > > +ideally along with an explanation what is the reclaim context for easier
> > > > > > +maintenance.
> > > > > 
> > > > > This paragraph doesn't make much sense to me. I think you're trying
> > > > > to say that we should call the appropriate save function "before
> > > > > locks are taken that a reclaim context (e.g a shrinker) might
> > > > > require access to."
> > > > > 
> > > > > I think it's also worth making a note about recursive/nested
> > > > > save/restore stacking, because it's not clear from this description
> > > > > that this is allowed and will work as long as inner save/restore
> > > > > calls are fully nested inside outer save/restore contexts.
> > > > 
> > > > Any better?
> > > > 
> > > > -FS/IO code then simply calls the appropriate save function right at the
> > > > -layer where a lock taken from the reclaim context (e.g. shrinker) and
> > > > -the corresponding restore function when the lock is released. All that
> > > > -ideally along with an explanation what is the reclaim context for easier
> > > > -maintenance.
> > > > +FS/IO code then simply calls the appropriate save function before any
> > > > +lock shared with the reclaim context is taken.  The corresponding
> > > > +restore function when the lock is released. All that ideally along with
> > > > +an explanation what is the reclaim context for easier maintenance.
> > > > +
> > > > +Please note that the proper pairing of save/restore function allows nesting
> > > > +so memalloc_noio_save is safe to be called from an existing NOIO or NOFS scope.
> > > 
> > > It's better, but the talk of this being necessary for locking makes
> > > me cringe. XFS doesn't do it for locking reasons - it does it
> > > largely for preventing transaction context nesting, which has all
> > > sorts of problems that cause hangs (e.g. log space reservations
> > > can't be filled) that aren't directly locking related.
> > 
> > Yeah, I wanted to not mention locks as much as possible.
> >  
> > > i.e we should be talking about using these functions around contexts
> > > where recursion back into the filesystem through reclaim is
> > > problematic, not that "holding locks" is problematic. Locks can be
> > > used as an example of a problematic context, but locks are not the
> > > only recursion issue that require GFP_NOFS allocation contexts to
> > > avoid.
> > 
> > agreed. Do you have any suggestion how to add a more abstract wording
> > that would not make head spinning?
> > 
> > I've tried the following. Any better?
> > 
> > diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
> > index c0ec212d6773..adac362b2875 100644
> > --- a/Documentation/core-api/gfp_mask-from-fs-io.rst
> > +++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
> > @@ -34,9 +34,11 @@ scope will inherently drop __GFP_FS respectively __GFP_IO from the given
> >  mask so no memory allocation can recurse back in the FS/IO.
> >  
> >  FS/IO code then simply calls the appropriate save function before any
> > -lock shared with the reclaim context is taken.  The corresponding
> > -restore function when the lock is released. All that ideally along with
> > -an explanation what is the reclaim context for easier maintenance.
> > +critical section wrt. the reclaim is started - e.g. lock shared with the
> > +reclaim context or when a transaction context nesting would be possible
> > +via reclaim. The corresponding restore function when the critical
> 
> .... restore function should be called when ...

fixed

> But otherwise I think this is much better.

Thanks!

-- 
Michal Hocko
SUSE Labs
