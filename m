Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeDJQcY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:32:24 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33026 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDJQcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:32:22 -0400
X-Google-Smtp-Source: AIpwx4+lOfKDNgOo71K33XiUdXEbBTCp7tHXOXG2HhDX5dDQHnoMoi3FGNJPE/pJ1qieB1s14bQASQ==
Date: Tue, 10 Apr 2018 13:32:16 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Wenhua Shi <march511@gmail.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make net_gso_ok return false when gso_type is
 zero(invalid)
Message-ID: <20180410163216.GB3661@localhost.localdomain>
References: <20180406014340.1562-1-march511@gmail.com>
 <20180408.125114.2111042327285982582.davem@davemloft.net>
 <CAN6D2npQd9AowLCz5CXGNPPib+10nABh1dOvLWV15r1z6FvF8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN6D2npQd9AowLCz5CXGNPPib+10nABh1dOvLWV15r1z6FvF8w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 08:41:21PM +0200, Wenhua Shi wrote:
> 2018-04-08 18:51 GMT+02:00 David Miller <davem@davemloft.net>:
> >
> > From: Wenhua Shi <march511@gmail.com>
> > Date: Fri,  6 Apr 2018 03:43:39 +0200
> >
> > > Signed-off-by: Wenhua Shi <march511@gmail.com>
> >
> > This precondition should be made impossible instead of having to do
> > an extra check everywhere that this helper is invoked, many of which
> > are in fast paths.
>
> I believe the precondition you said is quite true. In my situation, I
> have to disable GSO for some packet and I notice that it leads to a
> worse performance (slower than 1Mbps, was almost 800Mbps).
>
> Here's the hook I use on debian 9.4, kernel version 4.9:

There is quite a distance between 4.9 and net/net-next. Did you test
on a more recent kernel too?

Note that TCP stack now works with GSO being always on.
0a6b2a1dc2a2 ("tcp: switch to GSO being always on")
