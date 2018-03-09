Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932092AbeCIP5a (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:57:30 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:52972 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbeCIP53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:57:29 -0500
Date: Fri, 09 Mar 2018 10:57:24 -0500 (EST)
Message-Id: <20180309.105724.519703919967625754.davem@davemloft.net>
To: dwmw2@infradead.org
Cc: fw@strlen.de, pablo@netfilter.org, rga@amazon.de,
        bridge@lists.linux-foundation.org, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        aliguori@amazon.com, nbd@openwrt.org
Subject: Re: [RFC PATCH v2] bridge: make it possible for packets to
 traverse the bridge without hitting netfilter
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520609475.17937.42.camel@infradead.org>
References: <20150306142932.GA15926@salvia>
        <20150306163700.GC20382@breakpoint.cc>
        <1520609475.17937.42.camel@infradead.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw2@infradead.org>
Date: Fri, 09 Mar 2018 15:31:15 +0000

> Eschewing a 15% speedup on the basis that "well, even though we've had
> three of these already for a decade, we're worried that adding a fourth
> might open the floodgates to further patches" does seem a little odd to
> me, FWIW.

The cost we are dealing with is a fundamental one which is a result of
the hook design.

Indirect calls are killer.

Indirect calls are even more killer now in the age of Spectre and
retpolines.

I definitely would rather see the fundamental issue addressed rather
than poking at it randomly with knobs for this case and that.

Thank you.
