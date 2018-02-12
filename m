Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbeBLPkD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:40:03 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:53944 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753626AbeBLPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:40:00 -0500
Date: Mon, 12 Feb 2018 10:39:56 -0500 (EST)
Message-Id: <20180212.103956.1262868827217051631.davem@davemloft.net>
To: fthain@telegraphics.com.au
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v4 02/13] net/8390: Fix msg_enable patch snafu
From: David Miller <davem@davemloft.net>
In-Reply-To: <f697da2b2513e025688f6c48088536060575a249.1518397634.git.fthain@telegraphics.com.au>
References: <cover.1518397634.git.fthain@telegraphics.com.au>
        <f697da2b2513e025688f6c48088536060575a249.1518397634.git.fthain@telegraphics.com.au>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Sun, 11 Feb 2018 22:08:43 -0500 (EST)

> The lib8390 module parameter 'msg_enable' doesn't do anything useful:
> it causes an ancient version string to be logged.

Not true.

You need to look at the various netif_*() et al. message logging
interfaces, they check "p->msg_enable" to determine which messages to
print.

I'm not applying this, sorry.

Just for the record, I consider these kinds of ancient driver cleanups
painful to review, and unless they allow some ugly global kernel API
to be improved or removed such changes have very little gain.

In fact, most of them have a good chance to break things.

It is especially a dubious sequence when you cluster so many of these
things together into a large patch series.

If you are really serious about fixing real bugs, post these one at a
time, very slowly, for us to review properly and apply.

Thank you.
