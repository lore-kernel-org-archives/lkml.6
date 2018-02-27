Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeB0Lk4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 06:40:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:34250 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752056AbeB0Lky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 06:40:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,400,1515484800";
   d="scan'208";a="30072843"
Message-ID: <1519731651.10722.224.camel@linux.intel.com>
Subject: Re: [PATCH v1] kernel.h: Update comment about simple_strto<foo>()
 functions
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, Willy Tarreau <w@1wt.eu>
Date: Tue, 27 Feb 2018 13:40:51 +0200
In-Reply-To: <CANiq72nsPasAxZBkHW0fNcTMj3Vp_QdT3VABs9-mHKe4RHS9KA@mail.gmail.com>
References: <20180226175532.70556-1-andriy.shevchenko@linux.intel.com>
         <CANiq72nsPasAxZBkHW0fNcTMj3Vp_QdT3VABs9-mHKe4RHS9KA@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-26 at 23:31 +0100, Miguel Ojeda wrote:
> On Mon, Feb 26, 2018 at 6:55 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > There were discussions in the past about use cases for
> > simple_strto<foo>() functions and in some rare cases they have a
> > benefit
> > on kstrto<foo>() ones.
> > 
> > Update a comment to reduce confusing about special use cases.
> > 
> > Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 
> I am not sure we should just go back to the old ones, though.

I didn't tell that we should.
The niche of kstrto*() and simple_strto*() is different.

>  Maybe it
> is better to create a new set of kstrto*_inplace() or some other name,
> safer than the old ones and following kstrto*()'s interface regarding
> returned errors, overflow checking, etc. There are two variations that
> can be useful:
> 
>   * A strict version taking a (start, end) range or (start, size) pair
> which contains the number to be converted. If there is any problem
> parsing it (e.g. invalid characters, extra characters, ...), fail.
> 
>   * A less strict version taking an extra end pointer (or size
> parameter) which is not allowed to be surpassed, and any non-digit
> character means successful stop.

Send a patch, we will discuss that for sure.

> The old behavior (simple_*()) can still be achieved (almost) with the
> second version with an "infinite" end pointer if one really needs it.

> In any case, if you want to go forward with the old ones, we would
> also have to change the comments inside lib/vsprintf.c and possibly
> checkpatch :-)

Feel free to amend.

I actually didn't get your position here. You rather going to keep ugly
code in your subsystem because of "official" comment than do it in more
cleaner, but old fashion way.

Btw, you can still weakly (based on power of base) detect an overflow by
checking a returned pointer from simple_strto*().

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
