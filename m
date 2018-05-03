Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeECTZK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:25:10 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51714 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeECTZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:25:05 -0400
Date: Thu, 03 May 2018 15:25:03 -0400 (EDT)
Message-Id: <20180503.152503.728427996327227001.davem@davemloft.net>
To: rdunlap@infradead.org
Cc: gustavo@embeddedor.com, 3chas3@gmail.com,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: zatm: Fix potential Spectre v1
From: David Miller <davem@davemloft.net>
In-Reply-To: <98d11d2c-c7c9-e0ae-8a96-320ab9bca765@infradead.org>
References: <20180503181712.GA7443@embeddedor.com>
        <98d11d2c-c7c9-e0ae-8a96-320ab9bca765@infradead.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 3 May 2018 12:09:40 -0700

> Just for (my) info:  all of these types of patches are to prevent
> what is loaded in cache when the index is out of range, right?
> Not some random pool_info[random], but pool_info[valid, i.e., 0].
> 
> Since the value of pool is already sanity checked and -EINVAL is
> returned when it's out of range.

Well, the whole point is that the cpu can speculate execution past the
range check and execute the indexed read anyways.  So even if the
value is "sanity checked" the cpu can execute ahead and load things
into the cache, just cancelling the register state updates later when
the range check is fully resolved.
