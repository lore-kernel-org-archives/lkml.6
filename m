Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932100AbeB1Koc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:44:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:17397 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752299AbeB1Kob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:44:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,405,1515484800";
   d="scan'208";a="20791509"
Message-ID: <1519814668.10722.268.camel@linux.intel.com>
Subject: Re: [PATCH v2 8/9] lib/vsprintf: Remove useless NULL checks
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Date: Wed, 28 Feb 2018 12:44:28 +0200
In-Reply-To: <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
         <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
         <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
         <1519752950.10722.231.camel@linux.intel.com>
         <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-28 at 11:04 +0100, Petr Mladek wrote:
> On Tue 2018-02-27 19:35:50, Andy Shevchenko wrote:
> > On Tue, 2018-02-27 at 16:50 +0100, Petr Mladek wrote:
> > > On Fri 2018-02-16 23:07:10, Andy Shevchenko wrote:
> > > > 
> > > 

> > > This macro matches also values <= 16.
> > 
> > Yes, I know.
> > 
> > This had been discussed with Rasmus and we agreed that printing a
> > result
> > of kmalloc(0) is rather weird.
> 
> I see
> https://lkml.kernel.org/r/1500546142.29303.133.camel@linux.intel.com
> There you suggested to move this check into pointer(). But I do not
> see any agreement on this.
> 

Btw, I'm pretty sure that the checks like this or another one with
PAGE_SIZE is cargo cult programming rather than imaging possible so
weird use cases.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
