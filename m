Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B032C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E42F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E42F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeK0NFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:05:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:37270 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbeK0NFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:05:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 18:08:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,284,1539673200"; 
   d="scan'208";a="277336773"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga005.jf.intel.com with ESMTP; 26 Nov 2018 18:08:53 -0800
Date:   Tue, 27 Nov 2018 10:16:08 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, feng.tang@intel.com
Subject: Re: [RFC PATCH] panic: Add options to dump system info when panic
 happens
Message-ID: <20181127021608.pt3ghjjvu2xiy6gq@shbuild888>
References: <1542870631-77074-1-git-send-email-feng.tang@intel.com>
 <20181126152457.42f9917138e02b4ab9f17f7b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126152457.42f9917138e02b4ab9f17f7b@linux-foundation.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for the review.

On Mon, Nov 26, 2018 at 03:24:57PM -0800, Andrew Morton wrote:
> On Thu, 22 Nov 2018 15:10:31 +0800 Feng Tang <feng.tang@intel.com> wrote:
> 
> > Kernel panic issues are always painful to debug, partially
> > because of it's not easy to get enough information of the
> > context when panic happens.
> > 
> > And we have ramoops and kdump for that, while this commit
> > tries to a easier way to show the system info by adding a
> > cmdline parameter, referring some idea from sysrq handler.
> > 
> 
> This seems sensible to me.
> 
> > This patch is frequently used by us when debugging panic and system
> > stability bugs, and does help much. And the options could be expanded
> > more to cover other info like the ftrace, signal etc.
> 
> And that info is valuable.

Will add these info in v2.

> 
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3081,6 +3081,13 @@
> >  			timeout < 0: reboot immediately
> >  			Format: <timeout>
> >  
> > +	panic_dump=	Bitmask for dumping system info when panic happens.
> > +			User can chose combination of the following bits:
> > +			bit 0: dump all tasks info
> > +			bit 1: dump system memory info
> > +			bit 2: dump timer info
> > +			bit 3: dump locks info if CONFIG_LOCKDEP is on
> > +
> 
> Using "dump" makes this feature sounds a bit like kdump, which is also
> used in this code context.
> 
> I think I'd prefer that we use "print" - that's a more accurate
> description and avoids such confusion.  So s/dump/print/ and
> s/DUMP/PRINT/ throughout the changelog and patch?

Thanks for the suggestion, will change it in v2.

- Feng

