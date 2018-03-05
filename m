Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932784AbeCEXQ4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 18:16:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932106AbeCEXQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 18:16:54 -0500
Date: Mon, 5 Mar 2018 15:16:50 -0800
From: Darren Hart <dvhart@infradead.org>
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Jonathan Woithe <jwoithe@just42.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: Define constants for
 FUNC operations
Message-ID: <20180305231650.GA25693@fury>
References: <20180227211539.5708-1-kernel@kempniu.pl>
 <20180227211539.5708-2-kernel@kempniu.pl>
 <CAHp75VdDQ1xAYcXEN04kSug2sgi-G8+7PBEOC8MJSBw7gSCyRQ@mail.gmail.com>
 <20180304050813.GA3129@marvin.atrad.com.au>
 <20180304194426.GA1428@kmp-mobile.hq.kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180304194426.GA1428@kmp-mobile.hq.kempniu.pl>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 08:44:26PM +0100, Michał Kępień wrote:
> > On Wed, Feb 28, 2018 at 06:08:52PM +0200, Andy Shevchenko wrote:
> > > On Tue, Feb 27, 2018 at 11:15 PM, Micha?? K??pie?? <kernel@kempniu.pl> wrote:
> > > > Various functions exposed by the firmware through the FUNC interface
> > > > tend to use a consistent set of integers for denoting the type of
> > > > operation to be performed for a specified feature.  Use named constants
> > > > instead of integers in each call_fext_func() invocation in order to more
> > > > clearly convey the intent of each call.
> > > >
> > > > Note that FUNC_FLAGS is a bit peculiar:
> > > 
> > > > +/* FUNC interface - operations */
> > > > +#define OP_GET                         BIT(1)
> > > > +#define OP_GET_CAPS                    0
> > > > +#define OP_GET_EVENTS                  BIT(0)
> > > > +#define OP_GET_EXT                     BIT(2)
> > > > +#define OP_SET                         BIT(0)
> > > > +#define OP_SET_EXT                     (BIT(2) | BIT(0))
> > > 
> > > Hmm... this looks unordered a bit.
> > 
> > It seems to be ordered alphabetically on the identifier.  Andy, is it
> > preferred to order defines like this based on resolved numeric order?
>  
> Just to expand on what Jonathan wrote above: if you take a peek at the
> end result of the patch series, you will notice a pattern: constants in
> each section are ordered alphabetically by their name.  I wanted all
> sections to be consistently ordered.  If you would rather have me order
> things by the bit index, sure, no problem, just please note that the
> order above is not accidental.

Hrm. In my experience it is more typical to order by value (bit), that's a
little less obvious when using the BIT()|BIT() macros though. So long as it's
consistent, I think that's what matters most.

-- 
Darren Hart
VMware Open Source Technology Center
