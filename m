Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCD8C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E095F213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E095F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeGLOUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:20:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:15922 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbeGLOUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:20:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 07:10:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,343,1526367600"; 
   d="scan'208";a="66390145"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 12 Jul 2018 07:10:16 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 12 Jul 2018 17:10:15 +0300
Date:   Thu, 12 Jul 2018 17:10:15 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH] i915/intel_tv_get_modes: fix strncpy
 truncation warning
Message-ID: <20180712141015.GD5565@intel.com>
References: <1531295175-24052-1-git-send-email-asmadeus@codewreck.org>
 <20180712124401.GZ5565@intel.com>
 <20180712135526.GA5463@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180712135526.GA5463@nautica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 03:55:26PM +0200, Dominique Martinet wrote:
> Ville Syrjälä wrote on Thu, Jul 12, 2018:
> > On Wed, Jul 11, 2018 at 09:46:15AM +0200, Dominique Martinet wrote:
> > > This is effectively no-op as the next line writes a nul at the final
> > 
> > What is "This". Please write self contained commit messages.
> 
> This could either be 'this commit' as a whole or if you look only at the
> commit message 'this strncpy fix' from the title (which is arguably the
> same), and both interpretations sound fairly understandable in the
> context of the title line without seeing the patch to me... Although
> I'll admit this is difficult to judge of that as the author.

The patch subject is not part of the commit message body though. This is
made all the more clear when I'm editing the response in vim that doesn't
even show the mail subject to me. Hence I'm always left in the dark by
commit messages that aren't fully self contained.

> 
> Thanksfully, the v2 of the patch didn't use this wording but while I
> agree the message could be better I do not think it was horrible.
> 
> 
> > > drivers/gpu/drm/i915/intel_tv.c: In function ‘intel_tv_get_modes’:
> > > drivers/gpu/drm/i915/intel_tv.c:1358:3: error: ‘strncpy’ specified bound 32 equals destination size [-Werror=stringop-truncation]
> > >    strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
> > >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> > 
> > That warning should be in the actual commit message.
> 
> Yes and no, I gave it for referrence but when you update to gcc 8 you
> will literally see it all over the place.
> The words "strncpy truncation warning" is really precise once you've
> seen them a few times and there are litteraly hundred of these warnings
> in the kernel, some have already been fixed taking a glance at the git
> log, some with and without the warning message.
> I don't think it's worth polluting the git log with this many
> warnings... Which leads to...

I disagree. Without knowing what exactly is fixed how can you judge 
whether the patch even makes sense? And later you may get another
report of the same warning and then you would want to look through
the git log to see if there's a patch that already fixed it. Quite
hard to do without the exact warning in the log.

-- 
Ville Syrjälä
Intel
