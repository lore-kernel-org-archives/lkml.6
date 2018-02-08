Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeBHUe5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:34:57 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:49234 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHUez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:34:55 -0500
Date: Thu, 08 Feb 2018 15:34:53 -0500 (EST)
Message-Id: <20180208.153453.774785043965984772.davem@davemloft.net>
To: dnelson@redhat.com
Cc: rric@kernel.org, sgoutham@cavium.com, netdev@vger.kernel.org,
        Vadim.Lomovtsev@cavium.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: net: thunder: change q_len's type to handle max ring size
From: David Miller <davem@davemloft.net>
In-Reply-To: <151811766130.10712.18293368656209944798.email-sent-by-dnelson@aqua>
References: <151811766130.10712.18293368656209944798.email-sent-by-dnelson@aqua>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dean Nelson <dnelson@redhat.com>
Date: 

> The Cavium thunder nicvf driver supports rx/tx rings of up to 65536 entries per.
> The number of entires are stored in the q_len member of struct q_desc_mem. The
> problem is that q_len being a u16, results in 65536 becoming 0.
> 
> In getting pointers to descriptors in the rings, the driver uses q_len minus 1
> as a mask after incrementing the pointer, in order to go back to the beginning
> and not go past the end of the ring.
> 
> With the q_len set to 0 the mask is no longer correct and the driver does go
> beyond the end of the ring, causing various ills. Usually the first thing that
> shows up is a "NETDEV WATCHDOG: enP2p1s0f1 (nicvf): transmit queue 7 timed out"
> warning.
> 
> This patch remedies the problem by changing q_len to a u32.
> 
> Signed-off-by: Dean Nelson <dnelson@redhat.com>

Applied, thanks.

Another way to solve this could have been to encode that length
as "length - 1"
