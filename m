Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeBSPYm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:24:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:45600 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753031AbeBSPY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:24:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,535,1511856000";
   d="scan'208";a="18927936"
Message-ID: <1519053862.22495.396.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/9] lib/test_printf: Mark big constant with ULL
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 19 Feb 2018 17:24:22 +0200
In-Reply-To: <20180218125802.lu5abzydm2hwxj5p@ltop.local>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
         <20180218125802.lu5abzydm2hwxj5p@ltop.local>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-18 at 13:58 +0100, Luc Van Oostenryck wrote:
> On Fri, Feb 16, 2018 at 11:07:03PM +0200, Andy Shevchenko wrote:
> > Sparse complains that constant is so bit for unsigned long on 64-bit
> > architecture.
> > 
> > lib/test_printf.c:217:54: warning: constant 0xffff0123456789ab is so
> > big it is unsigned long
> > lib/test_printf.c:246:54: warning: constant 0xffff0123456789ab is so
> > big it is unsigned long
> > 
> > To satisfy everyone, mark the constant with ULL.
> 
> It should be 'UL' not 'ULL' since for architectures a pointer and
> a unsigned long have the ame size while on 32bit archs, long long
> are (or may?) 64bit.

Yes, UL works as well.

Andrew, tell me if I need to send an update (followup) or a new version.

Btw, I ran test_printf suite on both 32- and 64-bit code, everything
passed. So, if anyone notices a regression, please, create a test case
that we may run.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
