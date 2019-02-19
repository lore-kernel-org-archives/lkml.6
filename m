Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6A1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732882177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfBSNuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:50:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:31783 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfBSNuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:50:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 05:50:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="123578634"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 19 Feb 2019 05:49:58 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1gw5mW-00066w-Bp; Tue, 19 Feb 2019 15:49:56 +0200
Date:   Tue, 19 Feb 2019 15:49:56 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 8/9] vsprintf: Prevent crash when dereferencing
 invalid pointers
Message-ID: <20190219134956.GM9224@smile.fi.intel.com>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-9-pmladek@suse.com>
 <20190219033003.GA2284@jagdpanzerIV>
 <CAHp75VfeNvThbue+v1VHK_zxw9N82AkOQZUL=nH6xy21WXX7sg@mail.gmail.com>
 <20190219125115.GA19910@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219125115.GA19910@tigerII.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 09:51:15PM +0900, Sergey Senozhatsky wrote:
> On (02/19/19 13:02), Andy Shevchenko wrote:
> [..]
> > And if it's not? You will get in either case incomplete information,
> > but at least with "(e" (or even "(") you might get a clue that it
> > errornous conditions.
> 
> The thing I'm signaling here is that in some cases we still can
> crash the kernel; with the difference that invalid dereference
> can now be a memory corruption. Just saying.

Wouldn't that mean that the culprit in the caller, not in the callee?

(As far as I got your another example with badly called sprintf() which may
 overwrite stack, etc).

-- 
With Best Regards,
Andy Shevchenko


