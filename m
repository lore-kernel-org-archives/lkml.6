Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750851AbeBPVgm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:36:42 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:59396 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeBPVgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:36:41 -0500
Date: Fri, 16 Feb 2018 16:36:39 -0500 (EST)
Message-Id: <20180216.163639.281029287998550643.davem@davemloft.net>
To: colin.king@canonical.com
Cc: andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] net: dsa: mv88e6xxx: avoid unintended sign
 extension on a 16 bit shift
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180216165505.20058-1-colin.king@canonical.com>
References: <20180216165505.20058-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri, 16 Feb 2018 16:55:05 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> The shifting of timehi by 16 bits to the left will be promoted to
> a 32 bit signed int and then sign-extended to an u64. If the top bit
> of timehi is set then all then all the upper bits of ns end up as also
> being set because of the sign-extension. Fix this by making timehi and
> timelo u64.  Also move the declaration of ns.
> 
> Detected by CoverityScan, CID#1465288 ("Unintended sign extension")
> 
> Fixes: c6fe0ad2c349 ("net: dsa: mv88e6xxx: add rx/tx timestamping support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Please indicate the appropriate target tree in your Subject lines
in the future, for this it should be "[PATCH net-next]".

Applied, thanks.
