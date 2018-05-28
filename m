Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-696591-1527522873-2-12443927540497214178
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527522872; b=XL+GoaQMssjYkPqJF66BCnpVuZqitoXxDusrMdFY+3D3LidqJZ
    VxzXkVbBYcHaAOOQa7+j3vbn4CRDcLTeLTg1ZTawxtiCNxW9Ye5gr/jKzxYgKLTj
    iSVu+yvwxat9r+7+8d5sOdAvicVDuXiA5WqrwGt3dxCOkiE2/gbit3iDhDFdGTWi
    WgJwrJklyVGhcPxlnbHXy/QKzvPkfSQx7UahvceW/q5zVUvhp0nNkHjflxEvEP6/
    TmhktgKJ4nSfrv7bhggmiNd7ozZhsJqBnz02XZOeH5om4YIYT82WAWiOFOXHsu+B
    Fdv6e0p8BiemVB3RTXBAgyEBj56tH5Sy2UdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527522872; bh=p1aH8ZatdS6seNCEx8jw7kCykSqILg
    IkCjV64lQl7uQ=; b=g95+BnmCw4LQdIcqf8HgtBafu4Cmxovlc2dzdWMwnrwBux
    IppmsRl9xCuoGhovEELaLYQOgtbaagRv0L2n70Dwo7Kh4X8+Ch5s2UdSSWRWy1NN
    VLxr09xb84pCAEjnZLmaB+jbymKRta2soXjkfoUKsGFEChZfuz3qkQr5CgjUxuT8
    pTBayAOkWrTXQlyYRuh4ZS0dZ8pFBzpYfaPr89FXaa86ZFpYsxDDIPliq3tF4FZ8
    GaSrAG22XbiHG2wgx4oMkLCVoXDvuNddqbLdbDG7UGyJdQj9ao4ED0gz2SxwWHSE
    fVl0j9jBvPnhc5xw4w7No4ELk9Y1NsuNDJI9kRsg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfCJo1lUTb9+dHnlyqlkTzpwb19Z2AWA3bMyxVzXUimjEBd+r893N4JnNi5OUHbAMp02C4ufOF0YFrMOShuyG2hI+/qWWLPWCP1zMLTD5Ci8JfOmue5aS
    7xU+FZa9Zgopz4jS8ywy2rcsLZp5cowP3Fr/dUNeKzeok8D3oqCauNz6hOy2LqLZ8Bii9K9Ll0b0/u4bDhIXvlrSkUVAcwxoful+Yyy8mXxm9nrVwiVMi0b8
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=zVL1a8GAs0BtBRptJQUA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969263AbeE1Py2 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 11:54:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:43737 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425265AbeE1PyQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 May 2018 11:54:16 -0400
Date: Mon, 28 May 2018 11:21:38 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Dave Chinner <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] doc: document scope NOFS, NOIO APIs
Message-ID: <20180528092138.GI1517@dhcp22.suse.cz>
References: <20180424183536.GF30619@thunk.org>
 <20180524114341.1101-1-mhocko@kernel.org>
 <20180524221715.GY10363@dastard>
 <20180525081624.GH11881@dhcp22.suse.cz>
 <20180527124721.GA4522@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527124721.GA4522@rapoport-lnx>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun 27-05-18 15:47:22, Mike Rapoport wrote:
> On Fri, May 25, 2018 at 10:16:24AM +0200, Michal Hocko wrote:
> > On Fri 25-05-18 08:17:15, Dave Chinner wrote:
> > > On Thu, May 24, 2018 at 01:43:41PM +0200, Michal Hocko wrote:
> > [...]
> > > > +FS/IO code then simply calls the appropriate save function right at the
> > > > +layer where a lock taken from the reclaim context (e.g. shrinker) and
> > > > +the corresponding restore function when the lock is released. All that
> > > > +ideally along with an explanation what is the reclaim context for easier
> > > > +maintenance.
> > > 
> > > This paragraph doesn't make much sense to me. I think you're trying
> > > to say that we should call the appropriate save function "before
> > > locks are taken that a reclaim context (e.g a shrinker) might
> > > require access to."
> > > 
> > > I think it's also worth making a note about recursive/nested
> > > save/restore stacking, because it's not clear from this description
> > > that this is allowed and will work as long as inner save/restore
> > > calls are fully nested inside outer save/restore contexts.
> > 
> > Any better?
> > 
> > -FS/IO code then simply calls the appropriate save function right at the
> > -layer where a lock taken from the reclaim context (e.g. shrinker) and
> > -the corresponding restore function when the lock is released. All that
> > -ideally along with an explanation what is the reclaim context for easier
> > -maintenance.
> > +FS/IO code then simply calls the appropriate save function before any
> > +lock shared with the reclaim context is taken.  The corresponding
> > +restore function when the lock is released. All that ideally along with
> 
> Maybe: "The corresponding restore function is called when the lock is
> released"

This will get rewritten some more based on comments from Dave
 
> > +an explanation what is the reclaim context for easier maintenance.
> > +
> > +Please note that the proper pairing of save/restore function allows nesting
> > +so memalloc_noio_save is safe to be called from an existing NOIO or NOFS scope.
>  
> so it is safe to call memalloc_noio_save from an existing NOIO or NOFS
> scope

Here is what I have right now on top

diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
index c0ec212d6773..0cff411693ab 100644
--- a/Documentation/core-api/gfp_mask-from-fs-io.rst
+++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
@@ -34,12 +34,15 @@ scope will inherently drop __GFP_FS respectively __GFP_IO from the given
 mask so no memory allocation can recurse back in the FS/IO.
 
 FS/IO code then simply calls the appropriate save function before any
-lock shared with the reclaim context is taken.  The corresponding
-restore function when the lock is released. All that ideally along with
-an explanation what is the reclaim context for easier maintenance.
-
-Please note that the proper pairing of save/restore function allows nesting
-so memalloc_noio_save is safe to be called from an existing NOIO or NOFS scope.
+critical section wrt. the reclaim is started - e.g. lock shared with the
+reclaim context or when a transaction context nesting would be possible
+via reclaim. The corresponding restore function when the critical
+section ends. All that ideally along with an explanation what is
+the reclaim context for easier maintenance.
+
+Please note that the proper pairing of save/restore function allows
+nesting so it is safe to call ``memalloc_noio_save`` respectively
+``memalloc_noio_restore`` from an existing NOIO or NOFS scope.
 
 What about __vmalloc(GFP_NOFS)
 ==============================

-- 
Michal Hocko
SUSE Labs
