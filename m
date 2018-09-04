Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C735DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8356720867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8356720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeIDPzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:55:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:19531 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbeIDPzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:55:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 04:30:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="230058647"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 04 Sep 2018 04:30:47 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1fx9Xi-0004QW-N5; Tue, 04 Sep 2018 14:30:46 +0300
Date:   Tue, 4 Sep 2018 14:30:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] linux/bitmap.h: relax comment on compile-time
 constant nbits
Message-ID: <20180904113046.GQ11447@smile.fi.intel.com>
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
 <20180818131623.8755-6-linux@rasmusvillemoes.dk>
 <20180904110859.GA4992@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904110859.GA4992@yury-thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 02:08:59PM +0300, Yury Norov wrote:
> On Sat, Aug 18, 2018 at 03:16:21PM +0200, Rasmus Villemoes wrote:
> > It's not clear what's so horrible about emitting a function call to
> > handle a run-time sized bitmap. Moreover, gcc also emits a function call
> > for a compile-time-constant-but-huge nbits, so the comment isn't even
> > accurate.
> > 
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Hi Rasmus,
> 
> Maybe too late, but 
> 
> Acked-by: Yury Norov <ynorov@caviumnetworks.com>

Actually not, I don't see this in linux-next.

Rasmus, do you know what happened to the series? Is it got stuck by unknown reasons?

> > ---
> >  include/linux/bitmap.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index e34c361f4a92..3f0cac3aedca 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -28,8 +28,8 @@
> >   * The available bitmap operations and their rough meaning in the
> >   * case that the bitmap is a single unsigned long are thus:
> >   *
> > - * Note that nbits should be always a compile time evaluable constant.
> > - * Otherwise many inlines will generate horrible code.
> > + * The generated code is more efficient when nbits is known at
> > + * compile-time and at most BITS_PER_LONG.
> >   *
> >   * ::
> >   *
> > --
> > 2.16.4

-- 
With Best Regards,
Andy Shevchenko


