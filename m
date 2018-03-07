Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933453AbeCGN3f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:29:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:6033 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933324AbeCGN3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:29:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,435,1515484800";
   d="scan'208";a="23664063"
Message-ID: <1520429370.10722.467.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] vsprintf: distinguish between (null), (err) and
 (invalid) pointer derefs
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adam Borowski <kilobyte@angband.pl>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Date: Wed, 07 Mar 2018 15:29:30 +0200
In-Reply-To: <20180306181122.11449-1-kilobyte@angband.pl>
References: <20180306092513.ibodfsnv4xrxdlub@pathway.suse.cz>
         <20180306181122.11449-1-kilobyte@angband.pl>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 19:11 +0100, Adam Borowski wrote:
> Attempting to print an object pointed to by a bad (usually ERR_PTR)
> pointer
> is a not so surprising error.  Our code handles them inconsistently:
>  * two places print (null) if ptr<PAGE_SIZE
>  * one place prints (null) if abs(ptr)<PAGE_SIZE
>  * one place prints (null) only if !ptr
> 
> Obviously, saying (null) for a small but non-0 value is misleading.
> Thus, let's print:
>  * (null) for exactly 0
>  * (err) if last page && abs(ptr)<=MAX_ERRNO
>  * (invalid) otherwise

Ah, and last but not least thing.
Where are the test cases?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
