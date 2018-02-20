Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeBTUPe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:15:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:3022 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750985AbeBTUPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:15:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="176757438"
Date: Tue, 20 Feb 2018 12:15:32 -0800
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20180220201532.GI27433@intel.com>
References: <20180219101050.0a1514e5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219101050.0a1514e5@canb.auug.org.au>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 10:10:50AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the drm tree got a conflict in:
> 
>   drivers/gpu/drm/i915/intel_breadcrumbs.c
> 
> between commit:
> 
>   117172c8f9d4 ("drm/i915/breadcrumbs: Ignore unsubmitted signalers")
> 
> from Linus' tree and commit:
> 
>   b7a3f33bd5ab ("drm/i915/breadcrumbs: Drop request reference for the signaler thread")
> 
> from the drm tree.
> 
> These are basically identical for the conflicting section except that
> the former added a line:
> 
> 	GEM_BUG_ON(!i915_gem_request_completed(request));
> 
> which I left in.
> 
> I fixed it up (see above) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

For this and for the PMU one, I'm really sorry. I believe I should had
mentioned this to Dave when sending pull request for drm-intel-fixes.

I didn't mentioned because for what fixes is concerned this shouldn't
be a problem, but I totally forgot about linux-next. Please accept my
apologies.

Do you use any rerere on linux-next? I wonder if drm-rerere could be used
somehow here to simplify this process of propagating conflicts resolutions
like this.

Thanks,
Rodrigo.

> 
> -- 
> Cheers,
> Stephen Rothwell



> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
