Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2656378-1527200244-2-14562991678341289575
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527200244; b=NyFx6SR8pQBQgfKql6XKIYZvhuF9zFYE85Dv3JCDilFtsGxE0x
    xAFyJgEo58GIXezDldTyWAv1LNfBVy8n0yrgK4dzX2KU2jKQRnkAyMQWiuq7Mgsq
    FfOQIK5l0izMNaY+9mn8Mrd/3PGIVIZk6HCG6xRouZxVcOWJY04kqTy/o++1lxu4
    IayZzjn5qKLFKlWk4CFiLYwAK/cMV3AdRgceG9jhgfix+hwmxkVxKnNGexVAabvM
    74GPtMdkJDiYAwmBGbamBuL8fgIKeNSmWAsss6Lb6pqBdYSz3bOd+gLOI9MOxdst
    yc2RXjOOpkiy0MCzGFkC+mxf0+zasuA1CQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527200244; bh=AzSo/AOvcB5qZao3YCr3N0XT0nGgIt
    f0sLdyX2gvYvU=; b=JAb1VLgZ6KMXbPFkH/TT77Yv3JdpF6h72l+NtJemGjbcKi
    pzv8thZcoQ/2Y18PDolCf1iqcYn4/lw/uxMglbTw4FMdtaFRMrpvJzw/kkkCpSPq
    z+9tCJEt6p10DKEtVpubSQueQnOO7NkVij27i1kCg+KQGhvpcdGwiazrBZ5lY81E
    neuo4mtocqLE4SAsSF5kEchPWEzFw/VrLwBnvLverkxnAh594SnVprDCXVNY+821
    6UvVBcHJyfISEO09A4XvMuUklwIzFlQs4tr89M+4Wdw+okolHorhLte/+37b77vA
    n7zhO2fUafjQ4eD1EKF9gLXowjtx4e7ZeZH3DUzw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=fromorbit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=fromorbit.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=fromorbit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=fromorbit.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD3WOztEmruw5bAVxOiuejeQjmgNzstFnRxXQnjHuE2gCsWoUHGrcdrbuGRLUZ5Y2Q8eMy/r0HLY01GEhUjbOnDp8vYzPLLFdTC1WjHre+DUtO7N5h8A
    +MnDppQiyX3LK+B1FiSv1Io6duyTC5eneifurwhPh+az7WPU5Br4iSPwl5Me+F3weRW4l4A2xPb3ay1MehF3/KnQaT91BX/NInF0V52BZjWFpojo4fwHIItb
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=sJbc32M6AAAA:8
    a=7-415B0cAAAA:8 a=er9z4SigiBqKLl_lmn4A:9 a=CjuIK1q_8ugA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22 a=dKgTKMx5mwBRCdX1GUW1:22
    a=biEYGPWJfzWAr4FL6Ov7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969555AbeEXWRT (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 18:17:19 -0400
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:41767 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966031AbeEXWRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 18:17:18 -0400
Date: Fri, 25 May 2018 08:17:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] doc: document scope NOFS, NOIO APIs
Message-ID: <20180524221715.GY10363@dastard>
References: <20180424183536.GF30619@thunk.org>
 <20180524114341.1101-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524114341.1101-1-mhocko@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 01:43:41PM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Although the api is documented in the source code Ted has pointed out
> that there is no mention in the core-api Documentation and there are
> people looking there to find answers how to use a specific API.
> 
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: David Sterba <dsterba@suse.cz>
> Requested-by: "Theodore Y. Ts'o" <tytso@mit.edu>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Yay, Documentation! :)

> ---
> 
> Hi Johnatan,
> Ted has proposed this at LSFMM and then we discussed that briefly on the
> mailing list [1]. I received some useful feedback from Darrick and Dave
> which has been (hopefully) integrated. Then the thing fall off my radar
> rediscovering it now when doing some cleanup. Could you take the patch
> please?
> 
> [1] http://lkml.kernel.org/r/20180424183536.GF30619@thunk.org
>  .../core-api/gfp_mask-from-fs-io.rst          | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/core-api/gfp_mask-from-fs-io.rst
> 
> diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
> new file mode 100644
> index 000000000000..e8b2678e959b
> --- /dev/null
> +++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
> @@ -0,0 +1,55 @@
> +=================================
> +GFP masks used from FS/IO context
> +=================================
> +
> +:Date: Mapy, 2018
> +:Author: Michal Hocko <mhocko@kernel.org>
> +
> +Introduction
> +============
> +
> +Code paths in the filesystem and IO stacks must be careful when
> +allocating memory to prevent recursion deadlocks caused by direct
> +memory reclaim calling back into the FS or IO paths and blocking on
> +already held resources (e.g. locks - most commonly those used for the
> +transaction context).
> +
> +The traditional way to avoid this deadlock problem is to clear __GFP_FS
> +resp. __GFP_IO (note the later implies clearing the first as well) in
> +the gfp mask when calling an allocator. GFP_NOFS resp. GFP_NOIO can be
> +used as shortcut. It turned out though that above approach has led to
> +abuses when the restricted gfp mask is used "just in case" without a
> +deeper consideration which leads to problems because an excessive use
> +of GFP_NOFS/GFP_NOIO can lead to memory over-reclaim or other memory
> +reclaim issues.
> +
> +New API
> +========
> +
> +Since 4.12 we do have a generic scope API for both NOFS and NOIO context
> +``memalloc_nofs_save``, ``memalloc_nofs_restore`` resp. ``memalloc_noio_save``,
> +``memalloc_noio_restore`` which allow to mark a scope to be a critical
> +section from the memory reclaim recursion into FS/IO POV. Any allocation
> +from that scope will inherently drop __GFP_FS resp. __GFP_IO from the given
> +mask so no memory allocation can recurse back in the FS/IO.
> +
> +FS/IO code then simply calls the appropriate save function right at the
> +layer where a lock taken from the reclaim context (e.g. shrinker) and
> +the corresponding restore function when the lock is released. All that
> +ideally along with an explanation what is the reclaim context for easier
> +maintenance.

This paragraph doesn't make much sense to me. I think you're trying
to say that we should call the appropriate save function "before
locks are taken that a reclaim context (e.g a shrinker) might
require access to."

I think it's also worth making a note about recursive/nested
save/restore stacking, because it's not clear from this description
that this is allowed and will work as long as inner save/restore
calls are fully nested inside outer save/restore contexts.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
