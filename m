Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeCPM3I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:29:08 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:47772 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750826AbeCPM3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:29:06 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4362:4559:5007:6691:7903:8603:8985:9025:10004:10400:10848:11026:11232:11658:11914:12043:12296:12555:12663:12740:12760:12895:12986:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21611:21627:30012:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: moon44_32124703a7a4a
X-Filterd-Recvd-Size: 2291
Message-ID: <1521203342.6119.5.camel@perches.com>
Subject: Re: [PATCH] drm: Reduce object size of DRM_ERROR and DRM_DEBUG uses
From: Joe Perches <joe@perches.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date: Fri, 16 Mar 2018 05:29:02 -0700
In-Reply-To: <20180316074150.GE25297@phenom.ffwll.local>
References: <016b5cb84cede20fd0f91ed6965421d99fd5f2ce.1520978414.git.joe@perches.com>
         <20180316074150.GE25297@phenom.ffwll.local>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-16 at 08:41 +0100, Daniel Vetter wrote:
> On Tue, Mar 13, 2018 at 03:02:15PM -0700, Joe Perches wrote:
> > drm_printk is used for both DRM_ERROR and DRM_DEBUG with unnecessary
> > arguments that can be removed by creating separate functins.
> > 
> > Create specific functions for these calls to reduce x86/64 defconfig
> > size by ~20k.
> > 
> > Modify the existing macros to use the specific calls.
> > 
> > new:
> > $ size -t drivers/gpu/drm/built-in.a | tail -1
> > 1876562	  44542	    995	1922099	 1d5433	(TOTALS)
> > 
> > old:
> > $ size -t drivers/gpu/drm/built-in.a | tail -1
> > 1897565	  44542	    995	1943102	 1da63e	(TOTALS)
> > 
> > Miscellanea:
> > 
> > o intel_display requires a change to use the specific calls.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Impressed with the size of the bikeshed piled on top of this I decided to
> cut this all short by merging it.

Thanks.

There was a similar patch for the DRM_DEV_ macros
awhile ago that also reduced object code.

https://lkml.org/lkml/2017/9/25/247

Never applied.

Want a remerge resend?
