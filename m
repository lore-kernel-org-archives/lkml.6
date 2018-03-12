Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932478AbeCLPNE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:13:04 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60192 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbeCLPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:12:59 -0400
Date: Mon, 12 Mar 2018 11:12:57 -0400 (EDT)
Message-Id: <20180312.111257.2221362853661035214.davem@davemloft.net>
To: colin.king@canonical.com
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] lan743x: remove some redundant variables and
 assignments
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180311164233.27139-1-colin.king@canonical.com>
References: <20180311164233.27139-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sun, 11 Mar 2018 17:42:33 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Function lan743x_phy_init assigns pointer 'netdev' but this is never read
> and hence it can be removed. The return error code handling can also be
> cleaned up to remove the variable 'ret'.
> 
> Function lan743x_phy_link_status_change assigns pointer 'phy' twice and
> this is never read, so it also can be removed.
> 
> Finally, function lan743x_tx_napi_poll initializes pointer 'adapter'
> and then re-assigns the same value into this pointer a little later on
> so this second assignment is redundant and can be also removed.
> 
> Cleans up clang warnings:
> drivers/net/ethernet/microchip/lan743x_main.c:951:2: warning: Value
> stored to 'netdev' is never read
> drivers/net/ethernet/microchip/lan743x_main.c:971:3: warning: Value
> stored to 'phy' is never read
> drivers/net/ethernet/microchip/lan743x_main.c:1583:26: warning: Value
> stored to 'adapter' during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
