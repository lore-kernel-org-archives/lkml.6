Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934014AbeE2MO3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:14:29 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:54022 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933605AbeE2MOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:14:24 -0400
Date: Tue, 29 May 2018 08:14:19 -0400 (EDT)
Message-Id: <20180529.081419.463698377540876485.davem@davemloft.net>
To: arnd@arndb.de
Cc: ast@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpfilter: fix building without CONFIG_INET
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180529095535.81934-1-arnd@arndb.de>
References: <20180529095535.81934-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 29 May 2018 11:55:06 +0200

> bpfilter_process_sockopt is a callback that gets called from
> ip_setsockopt() and ip_getsockopt(). However, when CONFIG_INET is
> disabled, it never gets called at all, and assigning a function to the
> callback pointer results in a link failure:
> 
> net/bpfilter/bpfilter_kern.o: In function `__stop_umh':
> bpfilter_kern.c:(.text.unlikely+0x3): undefined reference to `bpfilter_process_sockopt'
> net/bpfilter/bpfilter_kern.o: In function `load_umh':
> bpfilter_kern.c:(.init.text+0x73): undefined reference to `bpfilter_process_sockopt'
> 
> Since there is no caller in this configuration, I assume we can
> simply make the assignment conditional.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
