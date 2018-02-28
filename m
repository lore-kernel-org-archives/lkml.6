Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeB1EVk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 23:21:40 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:40994 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751628AbeB1EVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 23:21:39 -0500
Date: Wed, 28 Feb 2018 05:21:34 +0100
From: Willy Tarreau <w@1wt.eu>
To: Robert Abel <rabel@robertabel.eu>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
Message-ID: <20180228042134.GA27815@1wt.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
 <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu>
 <20180225235432.31209-4-rabel@robertabel.eu>
 <CANiq72mu2NkDx4XqXzcO39N8AZg50h+BxrONJ3eCc7LjJ0rJKg@mail.gmail.com>
 <50a2fd51-8bdb-d2b7-c2b3-7df638fdedde@robertabel.eu>
 <20180227051905.GA26781@1wt.eu>
 <911beeb5-529f-09bb-0e5a-c5b626adba60@robertabel.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911beeb5-529f-09bb-0e5a-c5b626adba60@robertabel.eu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Wed, Feb 28, 2018 at 12:29:38AM +0100, Robert Abel wrote:
> It is however an edge case that incurs a
> lot of code for little to no functionality.
> I'd much prefer if we broke backwards compatibility here and actually
> only parse the format that is indicated in the comment:
> 
> >         case 'x':       /* gotoxy : LxXXX[yYYY]; */
> >         case 'y':       /* gotoxy : LyYYY[xXXX]; */
> >  
> 
> Exactly one x command followed exactly by zero or one y command or
> vice-versa.
> 
> If somebody changes their mind during the escape sequence, they can just
> issue a new one instead of appending to the current one.
> 
> I'll post an example patch.

I'm sorry but I think that your patch has simply proven that your point
above doesn't stand. Adding 90 lines of code full of strchr, strpbrk and
memcpy to replace 12 trivial lines, while possibly breaking compatibility
isn't considered an improvement. Reducing code is an improvement,
multiplying it by 7 is not, it adds maintenance burden for no benefit.

Let's stick to Miguel's last version. At least now we know that the
alternatives are worse, which is great.

Thanks,
Willy
