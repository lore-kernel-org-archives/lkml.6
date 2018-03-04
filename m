Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeCDFhh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 00:37:37 -0500
Received: from server.atrad.com.au ([150.101.241.2]:48934 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeCDFhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 00:37:36 -0500
Date: Sun, 4 Mar 2018 16:07:11 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Micha?? K??pie?? <kernel@kempniu.pl>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] fujitsu-laptop: Consistent naming of constants
Message-ID: <20180304053711.GB3129@marvin.atrad.com.au>
References: <20180227211539.5708-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227211539.5708-1-kernel@kempniu.pl>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-MIMEDefang-action: accept
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal

On Tue, Feb 27, 2018 at 10:15:32PM +0100, Micha?? K??pie?? wrote:
> This patch series is an attempt to organize all the named constants used
> throughout fujitsu-laptop so that their names more clearly convey their
> purpose: a set of prefixes is introduced to "map" constant names to
> call_fext_func() parameters.

While fairly superficial in nature I think this patch set is worthwhile. 
Features have been progressively added to fujitsu-laptop over the last 10 or
so years from a number of sources but a consistent naming methodology for
constants has not emerged.  Having at least some consistency across the
constant names will help clarify the intent of the code.

> Some changes (like those in patches 4/7 and 5/7) may be perceived as
> bikeshedding, so please just think of them as proposals, not fixes.

Patches 4 and 5 don't bother me within the context of the patch series as a
whole.

> Finally, patch 7/7 again [1] proposes a set of helper functions which
> seem to be making quite a difference in terms of code readability in
> certain places (especially in long conditional expressions).  YMMV,
> though, feel free to disagree.

As before, I can't see any strong arguments one way or the other.  The
helper functions certainly save a line in many of the call sites, but
whether they provide significant advantages I cannot say (I personally have
no fundamental problems with either version).  I guess if pushed I'd
probably come down on the side of leaving things as they are: in principle
defining a bunch of thin wrapper functions to save one parameter isn't
something I tend to do since it doesn't seem worth it.  However, what has
changed since the last iteration of this idea is the use of identifiers
rather than numbers for many of call_fext_func()'s parameters, which adds
length to each call site.

If there is general agreement that using these functions is beneficial in
this context I certainly won't block it.

Regards
  jonathan
