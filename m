Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeCOQaC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:30:02 -0400
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:49859 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751600AbeCOQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:30:00 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4037:4321:5007:8660:10004:10400:10848:11232:11658:11914:12296:12663:12740:12895:13069:13148:13161:13229:13230:13311:13357:13439:13894:14096:14097:14659:14721:21080:21451:21627:30012:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: nerve02_399d26280f24f
X-Filterd-Recvd-Size: 2549
Message-ID: <1521131394.22221.25.camel@perches.com>
Subject: Re: [PATCH] drm: Reduce object size of DRM_ERROR and DRM_DEBUG uses
From: Joe Perches <joe@perches.com>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date: Thu, 15 Mar 2018 09:29:54 -0700
In-Reply-To: <20180315161434.GV5453@intel.com>
References: <016b5cb84cede20fd0f91ed6965421d99fd5f2ce.1520978414.git.joe@perches.com>
         <20180315133026.GR5453@intel.com>
         <1b50f5d8-97a6-2442-34bb-2782c35505fd@linux.intel.com>
         <20180315150524.GS5453@intel.com> <1521127073.22221.13.camel@perches.com>
         <20180315153734.GT5453@intel.com> <1521128645.22221.18.camel@perches.com>
         <20180315161434.GV5453@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-15 at 18:14 +0200, Ville Syrjälä wrote:
> > There's no trade-off in this patch for faster/larger.
> > This patch is simply smaller.  Smaller is better.
> 
> This feels a bit like saying pink is better than red because it's
> more pink.

Silly.  If you can't say smaller total object code that
performs the same task identically is better, I think
we can't discuss much of anything about code together.

Any printk related mechanism is not fast-path so any
icache dilution isn't an issue.

> That said, I'm not arguing against this patch as such. Making things
> smaller "just because" usually doesn't cause problems.

It seems more like you haven't read the patch.

>  But I was
> hoping that we might be after some more tangible gains here, and
> thus pointed out that there may be a better way to achieve even
> bigger gains.

Sure, it's just any such a discussion should not affect
this patch being applied.

This patch reduces the argument count of the drm_printk
(now drm_dbg) call and so is faster to execute even if
the emit test is internal to the drm_dbg function.
