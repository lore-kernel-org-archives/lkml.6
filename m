Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeBCAqT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 19:46:19 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:45236 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeBCAqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 19:46:09 -0500
Date: Fri, 02 Feb 2018 19:46:07 -0500 (EST)
Message-Id: <20180202.194607.1678689429966846181.davem@davemloft.net>
To: arnd@arndb.de
Cc: harish.patil@cavium.com, manish.chopra@cavium.com,
        Dept-GELinuxNICDev@cavium.com, keescook@chromium.org,
        johannes.berg@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qlge: use memmove instead of
 skb_copy_to_linear_data
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180202154603.1617656-1-arnd@arndb.de>
References: <20180202154603.1617656-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri,  2 Feb 2018 16:45:44 +0100

> gcc-8 points out that the skb_copy_to_linear_data() argument points to
> the skb itself, which makes it run into a problem with overlapping
> memcpy arguments:
> 
> In file included from include/linux/ip.h:20,
>                  from drivers/net/ethernet/qlogic/qlge/qlge_main.c:26:
> drivers/net/ethernet/qlogic/qlge/qlge_main.c: In function 'ql_realign_skb':
> include/linux/skbuff.h:3378:2: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
>   memcpy(skb->data, from, len);
> 
> It's unclear to me what the best solution is, maybe it ought to use a
> different helper that adjusts the skb data in a safe way. Simply using
> memmove() here seems like the easiest workaround.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This looks fine, applied, thanks.
