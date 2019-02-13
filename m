Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DDFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1122E207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbfBMNzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:55:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:45968 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfBMNzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:55:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 05:54:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="146507453"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2019 05:54:56 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gtv03-00018g-5i; Wed, 13 Feb 2019 15:54:55 +0200
Date:   Wed, 13 Feb 2019 15:54:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vsprintf: Avoid confusion between invalid address
 and value
Message-ID: <20190213135455.GL9224@smile.fi.intel.com>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-10-pmladek@suse.com>
 <20190208172717.GW9224@smile.fi.intel.com>
 <20190212154530.wjikbevy5beg2uzc@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212154530.wjikbevy5beg2uzc@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:45:30PM +0100, Petr Mladek wrote:
> On Fri 2019-02-08 19:27:17, Andy Shevchenko wrote:
> > On Fri, Feb 08, 2019 at 04:23:10PM +0100, Petr Mladek wrote:
> > > We are able to detect invalid values handled by %p[iI] printk specifier.
> > > The current error message is "invalid address". It might cause confusion
> > > against "(efault)" reported by the generic valid_pointer_address() check.
> > > 
> > > Let's unify the style and use the more appropriate error code description
> > > "(einval)".
> > 
> > The proper one should be "invalid address family". The proposed change
> > increases confusion.
> 
> I am confused. Is there any error code for "invalid address family"?

I'm not sure.
There is EAFNOSUPPORT. I don't know if it suits better.

> EINVAL is standard error code used when a wrong value is passed
> as a parameter. In this case, the code is not able to handle
> the given address family.

This is possible, but it will produce more generic message.


> IMHO, the original message "invalid address" has been even more
> confusing. Oops would happen if it was invalid. In fact, the value
> was invalid.

I agree with this. "Address" may be treated as "memory address", while in
practice it's a "network address".

-- 
With Best Regards,
Andy Shevchenko


