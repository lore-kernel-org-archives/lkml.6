Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeB0FUQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 00:20:16 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:40943 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751824AbeB0FUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 00:20:15 -0500
Date: Tue, 27 Feb 2018 06:20:11 +0100
From: Willy Tarreau <w@1wt.eu>
To: Robert Abel <rabel@robertabel.eu>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/4] auxdisplay: charlcd: fix x/y address commands
Message-ID: <20180227052011.GB26781@1wt.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu>
 <20180225235432.31209-2-rabel@robertabel.eu>
 <20180225235432.31209-3-rabel@robertabel.eu>
 <20180225235432.31209-4-rabel@robertabel.eu>
 <CANiq72mu2NkDx4XqXzcO39N8AZg50h+BxrONJ3eCc7LjJ0rJKg@mail.gmail.com>
 <1a02d35e-b87c-3751-eb1a-f3becee4aa6b@robertabel.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a02d35e-b87c-3751-eb1a-f3becee4aa6b@robertabel.eu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 12:05:10AM +0100, Robert Abel wrote:
> Hi Miguel,
> 
> On 26 Feb 2018 17:49, Miguel Ojeda wrote:
> > On Mon, Feb 26, 2018 at 12:54 AM, Robert Abel <rabel@robertabel.eu> wrote:
> >> +               /* clamp new x/y coordinates */
> >> +               if (tmp_addr.x >= lcd->width)
> >> +                       tmp_addr.x = lcd->width - 1;
> > 
> > tmp_addr.x = min(tmp_addr.x, lcd->width - 1);
> 
> Had throught of that, too. However, it introduces a warning about type
> mismatch, because lcd->width is int while tmp_addr.x is unsigned long
> int. I didn't fell like saving a line warranted much bigger changes to
> the lcd struct.

The you can use min_t() :

      tmp_addr.x = min_t(unsigned, tmp_addr.x, lcd->width - 1);

Willy
