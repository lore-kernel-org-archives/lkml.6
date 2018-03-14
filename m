Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932928AbeCNAZ5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 20:25:57 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:53580 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932349AbeCNAZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 20:25:56 -0400
Date: Tue, 13 Mar 2018 20:25:52 -0400 (EDT)
Message-Id: <20180313.202552.1990425972566331246.davem@davemloft.net>
To: arnd@arndb.de
Cc: gustavo@embeddedor.com, dima@arista.com, johannes.berg@intel.com,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pktgen: use dynamic allocation for debug print buffer
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180313205856.3309750-1-arnd@arndb.de>
References: <20180313205856.3309750-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Mar 2018 21:58:39 +0100

> After the removal of the VLA, we get a harmless warning about a large
> stack frame:
> 
> net/core/pktgen.c: In function 'pktgen_if_write':
> net/core/pktgen.c:1710:1: error: the frame size of 1076 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> The function was previously shown to be safe despite hitting
> the 1024 bye warning level. To get rid of the annoyging warning,
> while keeping it readable, this changes it to use strndup_user().
> 
> Obviously this is not a fast path, so the kmalloc() overhead
> can be disregarded.
> 
> Fixes: 35951393bbff ("pktgen: Remove VLA usage")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
