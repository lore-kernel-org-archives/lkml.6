Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755429AbeDPOCN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:02:13 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41508 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754990AbeDPOCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:02:11 -0400
Date: Mon, 16 Apr 2018 10:02:10 -0400 (EDT)
Message-Id: <20180416.100210.796567683447229503.davem@davemloft.net>
To: dan.carpenter@oracle.com
Cc: labbott@redhat.com, sd@queasysnail.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net] Revert "macsec: missing dev_put() on error in
 macsec_newlink()"
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180416101750.GA19613@mwanda>
References: <20180414223121.GA7475@bistromath.localdomain>
        <20180416101750.GA19613@mwanda>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 16 Apr 2018 13:17:50 +0300

> This patch is just wrong, sorry.  I was trying to fix a static checker
> warning and misread the code.  The reference taken in macsec_newlink()
> is released in macsec_free_netdev() when the netdevice is destroyed.
> 
> This reverts commit 5dcd8400884cc4a043a6d4617e042489e5d566a9.
> 
> Reported-by: Laura Abbott <labbott@redhat.com>
> Fixes: 5dcd8400884c ("macsec: missing dev_put() on error in macsec_newlink()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
> I sent this earlier but I messed up the CC list.  I've updated the
> commit message as well.

Applied, thanks Dan.
