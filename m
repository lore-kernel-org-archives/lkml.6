Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeCDFJF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 00:09:05 -0500
Received: from server.atrad.com.au ([150.101.241.2]:48924 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeCDFJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 00:09:03 -0500
Date: Sun, 4 Mar 2018 15:38:13 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Micha?? K??pie?? <kernel@kempniu.pl>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: Define constants for
 FUNC operations
Message-ID: <20180304050813.GA3129@marvin.atrad.com.au>
References: <20180227211539.5708-1-kernel@kempniu.pl>
 <20180227211539.5708-2-kernel@kempniu.pl>
 <CAHp75VdDQ1xAYcXEN04kSug2sgi-G8+7PBEOC8MJSBw7gSCyRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdDQ1xAYcXEN04kSug2sgi-G8+7PBEOC8MJSBw7gSCyRQ@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-MIMEDefang-action: accept
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 06:08:52PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 27, 2018 at 11:15 PM, Micha?? K??pie?? <kernel@kempniu.pl> wrote:
> > Various functions exposed by the firmware through the FUNC interface
> > tend to use a consistent set of integers for denoting the type of
> > operation to be performed for a specified feature.  Use named constants
> > instead of integers in each call_fext_func() invocation in order to more
> > clearly convey the intent of each call.
> >
> > Note that FUNC_FLAGS is a bit peculiar:
> 
> > +/* FUNC interface - operations */
> > +#define OP_GET                         BIT(1)
> > +#define OP_GET_CAPS                    0
> > +#define OP_GET_EVENTS                  BIT(0)
> > +#define OP_GET_EXT                     BIT(2)
> > +#define OP_SET                         BIT(0)
> > +#define OP_SET_EXT                     (BIT(2) | BIT(0))
> 
> Hmm... this looks unordered a bit.

It seems to be ordered alphabetically on the identifier.  Andy, is it
preferred to order defines like this based on resolved numeric order?

There is a lack of apparent consistency in the numeric mapping; for example,
OP_SET_EXT includes the OP_SET bit, but OP_GET_EXT does not include the
OP_GET bit.  However, after inspecting the code I think this is simply
reflecting what the hardware expects.

> And plain 0 doesn't look right in this concept (something like (0 <<
> 0) would probably do it).

Given that all other definitions are in terms of BIT(), to my eye "(0 << 0)"
looks as much out of place as plain "0".  However, if the convention in this
case would be to use the former then I have no objections.  I presume the
"(0 << 0)" idea comes from the fact that BIT() ultimately expands to some
form of shift.

Regards
  jonathan
