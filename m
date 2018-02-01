Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932202AbeBABv6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 20:51:58 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:43354 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932118AbeBABvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 20:51:55 -0500
Date: Thu, 1 Feb 2018 02:51:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Wong Hoi Sing, Edison" <hswong3i@gmail.com>,
        "Hung Hing Lun, Mike" <hlhung3i@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp_lp: use 64-bit arithmetic instead of 32-bit
Message-ID: <20180201015126.GH16547@lunn.ch>
References: <20180201002407.GA1608@embeddedgus>
 <20180201003236.06143fd0@alans-desktop>
 <20180131190749.Horde.bsc7GhewsZwdnkmDtMlSwWO@gator4166.hostgator.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131190749.Horde.bsc7GhewsZwdnkmDtMlSwWO@gator4166.hostgator.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 07:07:49PM -0600, Gustavo A. R. Silva wrote:
> 
> Hi Alan,
> 
> Quoting Alan Cox <gnomes@lxorguk.ukuu.org.uk>:
> 
> >On Wed, 31 Jan 2018 18:24:07 -0600
> >"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> >
> >>Cast to s64 some variables and a macro in order to give the
> >>compiler complete information about the proper arithmetic to
> >>use. Notice that these elements are used in contexts that
> >>expect expressions of type s64 (64 bits, signed).
> >>
> >>Currently such expression are being evaluated using 32-bit
> >>arithmetic.
> >
> >The question you need to ask is 'can it overflow 32bit maths', otherwise
> >you are potentially making the system do extra work for no reason.
> >
> 
> Yeah, I get your point and it seems that in this particular case there is no
> risk of a 32bit overflow, but in general and IMHO as the code evolves, the
> use of incorrect arithmetic may have security implications in the future, so
> I advocate for code correctness in this case.

Hi Gustavo

Is this on the hotpath? How much overhead does it add to 32 bit
architectures which don't have 64 bit arithmetic in hardware? There
are a lot of embedded systems which are 32 bit.

    Andrew
