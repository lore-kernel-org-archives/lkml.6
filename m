Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbeBCAnW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 19:43:22 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:45198 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeBCAnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 19:43:16 -0500
Date: Fri, 02 Feb 2018 19:43:14 -0500 (EST)
Message-Id: <20180202.194314.74937554805664914.davem@davemloft.net>
To: arnd@arndb.de
Cc: Ariel.Elior@cavium.com, everest-linux-l2@cavium.com,
        Tomer.Tayar@cavium.com, Yuval.Mintz@cavium.com, Chad.Dupuis@cavium.com,
        Manish.Rangankar@cavium.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qed: use correct strncpy() size
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180202154500.1616404-1-arnd@arndb.de>
References: <20180202154500.1616404-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri,  2 Feb 2018 16:44:47 +0100

> passing the strlen() of the source string as the destination
> length is pointless, and gcc-8 now warns about it:
> 
> drivers/net/ethernet/qlogic/qed/qed_debug.c: In function 'qed_grc_dump':
> include/linux/string.h:253: error: 'strncpy' specified bound depends on the length of the source argument [-Werror=stringop-overflow=]
> 
> This changes qed_grc_dump_big_ram() to instead uses the length of
> the destination buffer, and use strscpy() to guarantee nul-termination.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
